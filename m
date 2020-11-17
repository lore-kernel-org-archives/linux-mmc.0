Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F4EAC388F9
	for <linux-mmc@archiver.kernel.org>; Tue, 17 Nov 2020 02:45:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C899B246A4
	for <linux-mmc@archiver.kernel.org>; Tue, 17 Nov 2020 02:45:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Uf6XiEJj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbgKQCos (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 16 Nov 2020 21:44:48 -0500
Received: from mail-eopbgr70085.outbound.protection.outlook.com ([40.107.7.85]:24462
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726202AbgKQCor (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 16 Nov 2020 21:44:47 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ukv8PX5VITR1bPTrSavLjVhGRNF0bOITkyyIUoimkcBgvn2FaM+6cEC6kSRCv8HLNMh8EIWHK5lwnWcYlscXjKvg1rMVlf605jJEYOdV/5z3Hu8pDmHRT98sRVmWWVSQHXkXwab0kmSso9+/rJEnoyf/FaUCcpykYiRWzz8HDNlJ5NTxLJTqkLBADwv0N8nMivaBzBw1ZCINOnQ9mCfowW2Uv0PnEtLHYavPSPdtV9qFsZQ7Tr/TpEvWLki1bVxm2RSbY8laaQEx2nE3LkcqH2F5mIstPUvxxGdHJQExUQ4B1RoXcELIGxz5kQ4uoRk31Uvp5dfb8ce4kPkWmqlyPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CE1wEUmLcaQV7bw9CaLkpELzhDcsijAFW/EaJLpoxLE=;
 b=QrfU/hqJoXFVTwD7lpnuZvie/UIz3vt+iwsyD32dCxIKRaoKzGdV8lURVOyJemLvfX5KoNW5xLwRcglZXlp/cg4/FXv0MnUzsbZBGBqH2F/x3c7cYWt6nOosZKjchaCB4c4WRDpCg/hEIyNA0eH0QO5HtuaaOY7uIJE3Q97MYdxUZYNg3YpNetw1tDQW+rwPO3T+OTKsL9WTJma52PxI3rhywrvHdLMrJahDxQGUCLoWAzz3PoA/q4jP5VWT/1WZpfTcyDV3qhd6AMvnYO5MM26hnWbaUKPkVJlzaKqKmK3sPfMMOBh9461NaU+jYLiLMrNv1OS4My2Q916PtQULLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CE1wEUmLcaQV7bw9CaLkpELzhDcsijAFW/EaJLpoxLE=;
 b=Uf6XiEJjmE0Dw+z6/KIVac4PsYNKUv9abRklZ9hnPRQ2UJkECLiuv4yRP6zGxz/JKcC1dyuniUGz+W9PX94tOqwt5eRBOK/dL4XExRAaXANbCfqs2uaYNCJgF4tMSpKUWKBT8lrn75tHS9A6MbTcvDWsYujkrl9V9Pi7NaapPTc=
Received: from AM7PR04MB6885.eurprd04.prod.outlook.com (2603:10a6:20b:10d::24)
 by AM6PR0402MB3608.eurprd04.prod.outlook.com (2603:10a6:209:6::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.28; Tue, 17 Nov
 2020 02:44:43 +0000
Received: from AM7PR04MB6885.eurprd04.prod.outlook.com
 ([fe80::a90d:1d14:7235:b56f]) by AM7PR04MB6885.eurprd04.prod.outlook.com
 ([fe80::a90d:1d14:7235:b56f%4]) with mapi id 15.20.3564.028; Tue, 17 Nov 2020
 02:44:37 +0000
From:   "Y.b. Lu" <yangbo.lu@nxp.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: RE: [PATCH] mmc: export sd3_bus_mode to user space
Thread-Topic: [PATCH] mmc: export sd3_bus_mode to user space
Thread-Index: AQHWsOmADDDmjaJ9Gk2tOSY58y3Z+6nKtPOAgAD9UuA=
Date:   Tue, 17 Nov 2020 02:44:36 +0000
Message-ID: <AM7PR04MB688529C142BD33F6F78DDCF9F8E20@AM7PR04MB6885.eurprd04.prod.outlook.com>
References: <20201102071715.18057-1-yangbo.lu@nxp.com>
 <CAPDyKFp9se67D-R0ay+77n9yg93APjDMvNvJATLJ7sFXn7RvfQ@mail.gmail.com>
In-Reply-To: <CAPDyKFp9se67D-R0ay+77n9yg93APjDMvNvJATLJ7sFXn7RvfQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0cb64681-1e0c-4644-0308-08d88aa2b941
x-ms-traffictypediagnostic: AM6PR0402MB3608:
x-microsoft-antispam-prvs: <AM6PR0402MB36084EBA3989467542F9D7E0F8E20@AM6PR0402MB3608.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: K0QK+hKFLv5tDxgOSlMoleLp5SqLegWdnMPrqJCJUg8g5qLInVBDooQkfmkyjpxW+dJZ9353+sVoJABV4twjuEfR1gpXxS5a4SJ7WhPChf5xI8rLPmb4XT1HIGoVcaI5XwU8uwj6W9W37SysUTwEobUZBmVzl6eCIf0LrIzUX8pIhOsQBBjXoRMVau3uOc45szOdFBsXvP8DGiOH6/lauxoHxzZwdaSszPqegODwHghnjZPE/eATxPY3fbsA8MP9w4tEGrcIexYmtYzRI7yPhebZwxLnP5YLzpkzy9uS6q9jdsLQ6eo9F7uZ+QKBdQBH4V1H0Wfl/NKRbluq8LZydQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB6885.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(136003)(346002)(39860400002)(366004)(316002)(55016002)(53546011)(54906003)(6506007)(8936002)(7696005)(2906002)(9686003)(86362001)(83380400001)(33656002)(186003)(66946007)(64756008)(76116006)(66476007)(66446008)(66556008)(71200400001)(6916009)(4326008)(5660300002)(8676002)(52536014)(478600001)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: IJ3YSzY9ytiekOKp5egtSdFR5mGOqT6VkOnjHye9BuK/QutNMQokhAv0u8UdjYXCLq4+8hJhgjQMemGAiuAGZRfEhJevvr5jT0PpECjmeBQYCoQKfUMqyccAHq6B15s1RXouYXlMEHH30CN/pmgXuAtZtyV+l78yH3t4yEyR+9AGtfC8n8ekCUakcU2eMC/5+SjVSNWOKM2Wm28brc9qJwlyaIF8JBwVbr5xnAQh2N3LLJT2PBSQ+vzRAqrfBjtSpJXXAuoDuEdfp6HhYJaqoCslTZ/J6yMtvkNucJ22vlvdsenDYWp+a5DFB3ABSj7mE3hYJeHLe4y7c0ERff9a7yakUS14UBj1xKSADRc9v+xX60cxGRhV0fxMpzWDFojj/Jx87htRviLyN3Ba5nsmEruBDB3w21eGQWxOVnu7gw7ov/Xz3sPLVGPkqRj8ACPRXhJASp1LGJqILOMwdvPFvvqOqZPhmPaMgZLUtFVJNcPPn/cxCWQxzJMdB/BiQLIs0qLQFUXw5PJ64YGIecjEmGWj5HJumv4qOIbJGTEDgLFXn4gnLNGlhF9exG4NecEa2AFmqGKEDypZ/F7YNCi9Y2GxFmvwx+xUqKX8b2kQ6gYfcSyRW97rc/tkDfwNlfY/Mw2JfPJS9s/ushYc48joYQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB6885.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cb64681-1e0c-4644-0308-08d88aa2b941
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2020 02:44:36.9429
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7jJeZkqKe46nu5H3MpYtFj1I+/oesnaBIZdy6p9QMenvKPC6Pli8h6ArTv2iJcP+hAy93vlArUyb/gfFKjEkyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3608
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

SGkgVWZmZSwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBVbGYgSGFu
c3NvbiA8dWxmLmhhbnNzb25AbGluYXJvLm9yZz4NCj4gU2VudDogTW9uZGF5LCBOb3ZlbWJlciAx
NiwgMjAyMCA3OjI3IFBNDQo+IFRvOiBZLmIuIEx1IDx5YW5nYm8ubHVAbnhwLmNvbT4NCj4gQ2M6
IGxpbnV4LW1tY0B2Z2VyLmtlcm5lbC5vcmc7IEFkcmlhbiBIdW50ZXIgPGFkcmlhbi5odW50ZXJA
aW50ZWwuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBtbWM6IGV4cG9ydCBzZDNfYnVzX21v
ZGUgdG8gdXNlciBzcGFjZQ0KPiANCj4gT24gTW9uLCAyIE5vdiAyMDIwIGF0IDA4OjI2LCBZYW5n
Ym8gTHUgPHlhbmdiby5sdUBueHAuY29tPiB3cm90ZToNCj4gPg0KPiA+IFRoZXJlIHdhcyBubyB3
YXkgZm9yIHVzZXIgdG8ga25vdyB3aGF0IFVIUy1JIG1vZGVzIHRoZSBTRCBjYXJkDQo+ID4gc3Vw
cG9ydGluZy4gV2UgbWlnaHQgbm90IGtub3csIGV2ZW4gdGhlIGhpZ2hlc3Qgc3BlZWQgbW9kZQ0K
PiA+IGZhaWxlZCB0byB1c2UgYW5kIGZlbGwgYmFjayB0byBhIGxvd2VyIHNwZWVkIG1vZGUuDQo+
ID4NCj4gPiBUaGlzIHBhdGNoIGlzIHRvIGV4cG9ydCBzZDNfYnVzX21vZGUgdG8gdXNlciBzcGFj
ZSB0byBjaGVjay4NCj4gDQo+IFdlbGwsIGV2ZW4gaWYgdGhlIHVzZXIgd291bGQga25vdywgd2hh
dCBjYW4gaXQgZG8gYWJvdXQgaXQ/DQoNCkZvciB1c2VyLCB0aGV5IGNhbiBjaGVjayB0aGUgY2Fy
ZCBzcGVlZCBtb2RlcyBjYXBhYmlsaXR5LCBpZiB0aGV5IHdhbnQgdG8ga25vdy4NCkZvciBkZXZl
bG9wZXIsIHRoZXkgY2FuIGtub3cgd2hldGhlciBjYXJkIGlzIHdvcmtpbmcgb24gaGlnaGVzdCBz
cGVlZCBtb2RlIGFzIGV4cGVjdC4gSWYgbm90LCB0aGV5IGtub3cgdGhlcmUgaXMgaXNzdWUgbmVl
ZGVkIGNoZWNraW5nLg0KDQo+IA0KPiBTb3VuZCBsaWtlIHlvdSBhcmUgbG9va2luZyBmb3Igc29t
ZSBkZWJ1Z2dpbmcgZmVhdHVyZSBpbnN0ZWFkPw0KDQpZZXMuIEkgdGhpbmsgd2UgbWF5IG5lZWQg
YSB3YXkgdG8ga25vdyB3aGV0aGVyIFNEIGNhcmQgaXMgd29ya2luZyBvbiB0aGUgaGlnaGVzdCBz
cGVlZCBtb2RlIGFzIGV4cGVjdC4NCk90aGVyd2lzZSwgd2UgYXJlIG5vdCBhYmxlIHRvIHJlYWxp
emUgaXNzdWUgaWYgY2FyZCBqdXN0IGZhbGwgYmFjayB0byBhIGxvd2VyIHNwZWVkIG1vZGUgdG8g
d29yay4NCkFueSBzdWdnZXN0aW9uIG9uIHRoaXM/DQoNClRoYW5rcyBhIGxvdC4NCg0KPiANCj4g
S2luZCByZWdhcmRzDQo+IFVmZmUNCj4gDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBZYW5nYm8g
THUgPHlhbmdiby5sdUBueHAuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL21tYy9jb3JlL3Nk
LmMgfCAyICsrDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykNCj4gPg0KPiA+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL21tYy9jb3JlL3NkLmMgYi9kcml2ZXJzL21tYy9jb3JlL3Nk
LmMNCj4gPiBpbmRleCA2ZjA1NGM0Li4xMzQwOWMyIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMv
bW1jL2NvcmUvc2QuYw0KPiA+ICsrKyBiL2RyaXZlcnMvbW1jL2NvcmUvc2QuYw0KPiA+IEBAIC02
ODksNiArNjg5LDcgQEAgTU1DX0RFVl9BVFRSKG9lbWlkLCAiMHglMDR4XG4iLA0KPiBjYXJkLT5j
aWQub2VtaWQpOw0KPiA+ICBNTUNfREVWX0FUVFIoc2VyaWFsLCAiMHglMDh4XG4iLCBjYXJkLT5j
aWQuc2VyaWFsKTsNCj4gPiAgTU1DX0RFVl9BVFRSKG9jciwgIjB4JTA4eFxuIiwgY2FyZC0+b2Ny
KTsNCj4gPiAgTU1DX0RFVl9BVFRSKHJjYSwgIjB4JTA0eFxuIiwgY2FyZC0+cmNhKTsNCj4gPiAr
TU1DX0RFVl9BVFRSKHNkM19idXNfbW9kZSwgIjB4JTA4eFxuIiwNCj4gY2FyZC0+c3dfY2Fwcy5z
ZDNfYnVzX21vZGUpOw0KPiA+DQo+ID4NCj4gPiAgc3RhdGljIHNzaXplX3QgbW1jX2Rzcl9zaG93
KHN0cnVjdCBkZXZpY2UgKmRldiwNCj4gPiBAQCAtNzUzLDYgKzc1NCw3IEBAIHN0YXRpYyBzdHJ1
Y3QgYXR0cmlidXRlICpzZF9zdGRfYXR0cnNbXSA9IHsNCj4gPiAgICAgICAgICZkZXZfYXR0cl9v
Y3IuYXR0ciwNCj4gPiAgICAgICAgICZkZXZfYXR0cl9yY2EuYXR0ciwNCj4gPiAgICAgICAgICZk
ZXZfYXR0cl9kc3IuYXR0ciwNCj4gPiArICAgICAgICZkZXZfYXR0cl9zZDNfYnVzX21vZGUuYXR0
ciwNCj4gPiAgICAgICAgIE5VTEwsDQo+ID4gIH07DQo+ID4NCj4gPiAtLQ0KPiA+IDIuNy40DQo+
ID4NCg==
