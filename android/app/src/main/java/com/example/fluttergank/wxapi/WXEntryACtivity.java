package com.example.fluttergank.wxapi;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;

import com.tencent.mm.opensdk.modelbase.BaseReq;
import com.tencent.mm.opensdk.modelbase.BaseResp;
import com.tencent.mm.opensdk.modelmsg.SendAuth;
import com.tencent.mm.opensdk.openapi.IWXAPI;
import com.tencent.mm.opensdk.openapi.IWXAPIEventHandler;
import com.tencent.mm.opensdk.openapi.WXAPIFactory;

/**
 * Created by Rylynn on 2018-08-08.
 */
public class WXEntryACtivity extends Activity implements IWXAPIEventHandler {
    private IWXAPI api;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        api = WXAPIFactory.createWXAPI(this, "wxb25d3dec3db1affc", false);
        onNewIntent(getIntent());
        finish();
    }

    @Override
    public void onReq(BaseReq baseReq) {
    }

    @Override
    public void onResp(BaseResp baseResp) {
        sendBroadcastToWechat(baseResp);
    }

    private void sendBroadcastToWechat(BaseResp baseResp) {
        Intent intent = new Intent();
        intent.setAction("sendResp");
        if (baseResp instanceof SendAuth.Resp) {
            SendAuth.Resp resp = (SendAuth.Resp) (baseResp);
            intent.putExtra("code", resp.errCode == 0 ? resp.code : "-1");
            intent.putExtra("type", "SendAuthResp");
            sendBroadcast(intent);
        } else {
            intent.setAction("sendResp");
            intent.putExtra("code", baseResp.errCode + "");
            intent.putExtra("type", "ShareResp");
            sendBroadcast(intent);
        }
    }

    protected void onNewIntent(Intent intent) {
        api.handleIntent(intent, this);
    }
}