Return-Path: <SRS0=5cIg=4H=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3285CC34022
	for <linux-mmc@archiver.kernel.org>; Wed, 19 Feb 2020 07:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F28A921D56
	for <linux-mmc@archiver.kernel.org>; Wed, 19 Feb 2020 07:20:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="jAU0Vw4+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbgBSHUO (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 19 Feb 2020 02:20:14 -0500
Received: from mail-eopbgr50088.outbound.protection.outlook.com ([40.107.5.88]:62277
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726515AbgBSHUO (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 19 Feb 2020 02:20:14 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lKH4JCmenTnESmaOrd9WszYIQ8LeBC4njFFzmoimx7j+jRzhYrimiSIT4ULUqS98RSddiacpx2tMincDpjvGuDN/Z2lmf421bOQ0dTRwTSYRDeYh7hGLeVLgOEg/L2BB1mUu/of59cF7WJRnAehWgHM0YKnzUup13vjmyY0woOL/h03O63+0SPXucIM5N40wZawrNgitWNcdB/9JshozRvNh5QP5ODHtOP/SxScClJ6iJW4CSIDjYJH2uPIxQm8n8TQvEavMBesicbDQ2YB224p5yrbnNtNP2iGTUAU2+JK6s6ogfR9652BAmJtyS2WEyC3nNu9jDd/XZk/H5t60fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n605vmpYthJUpUvv1xJMp9xrUhxXBkMfhwsJw3s++DU=;
 b=LEk8lPtsNxOoE6vC32gNTTxZ2dP9CBZPtdZJBlEqeTjXyoxbjEj6ImcwbhVhJV5MWJDFLQthyMo03dssDRVKq56MbzD7WVNefJHZ99bC/8d93cdwxZEaL/+IWwksHUxbAcY16OX4olrR1/iVEMYxNRzuZwvB0fuAFgWG5kBwj7APc+rZz5cEWhbOin5BNr1Sm3wjnO0igW2oH5L/ddZCoMns3VWb6ZWxEIV4irKkjRzXeoEaTmhMK8ug+1HoB9qmt2wJAYFyOmSoJXSIhSK1EJR73TYnPu/dEdbOYNgi3X/qV4XPey8sI66ZVd1GtJzgqbOMk3y9+RbYR3l6SO342g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n605vmpYthJUpUvv1xJMp9xrUhxXBkMfhwsJw3s++DU=;
 b=jAU0Vw4+RjuRWBRffxLknAwa+7DvAz+2EGXAtKc4SDVFeDuT9IYR3A4CS1g+iyauNUrHygoh5x6CB0LoCXrNtBHTM/ebGVorxXCrLuZdpOvpYx03ea4pYktcLIEw/+JlKKlnyqTbb949bzqZDlqgEFSrHyUcuGqBMeTBb5syKjM=
Received: from VI1PR04MB5040.eurprd04.prod.outlook.com (20.177.52.24) by
 VI1PR04MB3070.eurprd04.prod.outlook.com (10.170.226.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.22; Wed, 19 Feb 2020 07:20:09 +0000
Received: from VI1PR04MB5040.eurprd04.prod.outlook.com
 ([fe80::d0c7:37d1:d835:a682]) by VI1PR04MB5040.eurprd04.prod.outlook.com
 ([fe80::d0c7:37d1:d835:a682%7]) with mapi id 15.20.2729.025; Wed, 19 Feb 2020
 07:20:09 +0000
From:   BOUGH CHEN <haibo.chen@nxp.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>
Subject: RE: [PATCH v3 14/14] mmc: queue: create dev->dma_parms before call
 dma_set_max_seg_size()
Thread-Topic: [PATCH v3 14/14] mmc: queue: create dev->dma_parms before call
 dma_set_max_seg_size()
Thread-Index: AQHV3+/biCzLE8ZdjU6Rp7Yj1LhFzKggp1yAgAGCJ2A=
Date:   Wed, 19 Feb 2020 07:20:09 +0000
Message-ID: <VI1PR04MB50402A1502EAA59500C6FDB190100@VI1PR04MB5040.eurprd04.prod.outlook.com>
References: <1581324597-31031-1-git-send-email-haibo.chen@nxp.com>
 <1581324597-31031-9-git-send-email-haibo.chen@nxp.com>
 <c02cf466-a6fe-2996-d928-a7ef3640c3af@intel.com>
In-Reply-To: <c02cf466-a6fe-2996-d928-a7ef3640c3af@intel.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=haibo.chen@nxp.com; 
x-originating-ip: [223.106.0.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 004ecf25-f95a-4a6c-88b6-08d7b50c26ff
x-ms-traffictypediagnostic: VI1PR04MB3070:|VI1PR04MB3070:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB3070CF47473ED26A7F794C1290100@VI1PR04MB3070.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-forefront-prvs: 0318501FAE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(366004)(346002)(376002)(396003)(136003)(189003)(199004)(66946007)(4326008)(66446008)(478600001)(186003)(66476007)(64756008)(7696005)(81156014)(86362001)(76116006)(53546011)(33656002)(52536014)(6506007)(81166006)(66556008)(316002)(5660300002)(8676002)(8936002)(26005)(110136005)(55016002)(71200400001)(2906002)(9686003)(54906003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB3070;H:VI1PR04MB5040.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LV7EkH9NCK3MDqrIk9yJIR11sBvBFYWDQreS4b3dV4vNeUOL9nTCciZ86pYun4FTPX0773N46DDt5Iocbyl0dQkh/wPzOZqzdLBR0Pt6PaACnVjYxUlwDEsbhs9+Opdl+Qqm2V5O97F+++fmHfauAfBqgIZFSELTwxL1d2CYzLN76SwfZOMyPWqB6OGef5mdSewhN5zk18xWdqe4q4aBFkMgURFVu1W5LBW7WZFcMF4stCArbfXHMkMnmcjG9Axth+aVuOsJWa5DBL+Rw/2PHa6wYtTktAR93O8AvvD7CrW1aTDb2ezO45H8MRsrwadKib7UTmkbILfvCaKy0FDqfW9Bu/nKZQgAUXkn8wmPuwB1BK/9QX7clM+en4/TPqlZt3uoDNfsZ/WxT3QQugRKmm2rkb35OCUUtM09kCE3YdMiBNFMDzJf0wJeG+iWwl1d
x-ms-exchange-antispam-messagedata: jWZd4kZ3SLrmesZn6rGXaHKSgQkAx6D83++Ep+wj3p5+U00SGjRg+UOc/MgCkmYgpspi/wgb5AP5XKx5MTXJ1RWI12R8EdlmTI2Ytiiz2T1Ouq/SeGjLY/GX7omKdBzqQSpPxFD7MaMckyxbKEedBg==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 004ecf25-f95a-4a6c-88b6-08d7b50c26ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2020 07:20:09.3571
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mx7JTsoPnsErMSzfleN54/0e10Hx5fwWy9xr4LuJ0AQeB9xSrTvGS0l1jNNJee1F30SrkzCDxDXekF5OvCtfqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3070
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBsaW51eC1tbWMtb3duZXJAdmdl
ci5rZXJuZWwub3JnDQo+IDxsaW51eC1tbWMtb3duZXJAdmdlci5rZXJuZWwub3JnPiBPbiBCZWhh
bGYgT2YgQWRyaWFuIEh1bnRlcg0KPiBTZW50OiAyMDIw5bm0MuaciDE45pelIDE2OjE2DQo+IFRv
OiBCT1VHSCBDSEVOIDxoYWliby5jaGVuQG54cC5jb20+OyB1bGYuaGFuc3NvbkBsaW5hcm8ub3Jn
Ow0KPiBsaW51eC1tbWNAdmdlci5rZXJuZWwub3JnDQo+IENjOiBkbC1saW51eC1pbXggPGxpbnV4
LWlteEBueHAuY29tPjsgbGludXMud2FsbGVpakBsaW5hcm8ub3JnDQo+IFN1YmplY3Q6IFJlOiBb
UEFUQ0ggdjMgMTQvMTRdIG1tYzogcXVldWU6IGNyZWF0ZSBkZXYtPmRtYV9wYXJtcyBiZWZvcmUN
Cj4gY2FsbCBkbWFfc2V0X21heF9zZWdfc2l6ZSgpDQo+IA0KPiBPbiAxMC8wMi8yMCAxMDo0OSBh
bSwgaGFpYm8uY2hlbkBueHAuY29tIHdyb3RlOg0KPiA+IEZyb206IEhhaWJvIENoZW4gPGhhaWJv
LmNoZW5AbnhwLmNvbT4NCj4gPg0KPiA+IFRvIG1ha2UgZG1hX3NldF9tYXhfc2VnX3NpemUoKSB3
b3JrLCBuZWVkIHRvIGNyZWF0ZSBkZXYtPmRtYV9wYXJtcy4NCj4gPg0KPiA+IEZpbmQgdGhpcyBp
c3N1ZSBvbiBpLk1YOFFNIG1layBib2FyZCwgdGhpcyBwbGF0Zm9ybSBjb25maWcgdGhlDQo+ID4g
bWF4X3NlZ21lbnRfc2l6ZSB0byA2NTUzNSwgYnV0IHRoaXMgZG1hX3NldF9tYXhfc2VnX3NpemUg
ZG8gbm90DQo+ID4gYWN0dWFsbCB3b3JrLCBmaW5kIHNvbWV0aW1lcyB0aGUgc2VnbWVudCBzaXpl
IGlzIDY1NTM2LCBleGNlZWQgdGhlDQo+ID4gaGFyZHdhcmUgbWF4IHNlZ21lbnQgbGltaXRhdGlv
biwgdHJpZ2dlciBBRE1BIGVycm9yLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogSGFpYm8gQ2hl
biA8aGFpYm8uY2hlbkBueHAuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL21tYy9jb3JlL3F1
ZXVlLmMgfCA5ICsrKysrLS0tLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCsp
LCA0IGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbW1jL2NvcmUv
cXVldWUuYyBiL2RyaXZlcnMvbW1jL2NvcmUvcXVldWUuYyBpbmRleA0KPiA+IDllZGMwODY4NWU4
Ni4uZjc0YzI4YzU4NDgyIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvbW1jL2NvcmUvcXVldWUu
Yw0KPiA+ICsrKyBiL2RyaXZlcnMvbW1jL2NvcmUvcXVldWUuYw0KPiA+IEBAIC0zNTksNiArMzU5
LDcgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBibGtfbXFfb3BzIG1tY19tcV9vcHMgPSB7DQo+ID4g
c3RhdGljIHZvaWQgbW1jX3NldHVwX3F1ZXVlKHN0cnVjdCBtbWNfcXVldWUgKm1xLCBzdHJ1Y3Qg
bW1jX2NhcmQNCj4gPiAqY2FyZCkgIHsNCj4gPiAgCXN0cnVjdCBtbWNfaG9zdCAqaG9zdCA9IGNh
cmQtPmhvc3Q7DQo+ID4gKwlzdHJ1Y3QgZGV2aWNlICpkZXYgPSBtbWNfZGV2KGhvc3QpOw0KPiA+
ICAJdW5zaWduZWQgYmxvY2tfc2l6ZSA9IDUxMjsNCj4gPg0KPiA+ICAJYmxrX3F1ZXVlX2ZsYWdf
c2V0KFFVRVVFX0ZMQUdfTk9OUk9ULCBtcS0+cXVldWUpOyBAQCAtMzY2LDEzDQo+ICszNjcsMTIN
Cj4gPiBAQCBzdGF0aWMgdm9pZCBtbWNfc2V0dXBfcXVldWUoc3RydWN0IG1tY19xdWV1ZSAqbXEs
IHN0cnVjdA0KPiBtbWNfY2FyZCAqY2FyZCkNCj4gPiAgCWlmIChtbWNfY2FuX2VyYXNlKGNhcmQp
KQ0KPiA+ICAJCW1tY19xdWV1ZV9zZXR1cF9kaXNjYXJkKG1xLT5xdWV1ZSwgY2FyZCk7DQo+ID4N
Cj4gPiAtCWlmICghbW1jX2Rldihob3N0KS0+ZG1hX21hc2sgfHwgISptbWNfZGV2KGhvc3QpLT5k
bWFfbWFzaykNCj4gPiArCWlmICghZGV2LT5kbWFfbWFzayB8fCAhKmRldi0+ZG1hX21hc2spDQo+
ID4gIAkJYmxrX3F1ZXVlX2JvdW5jZV9saW1pdChtcS0+cXVldWUsIEJMS19CT1VOQ0VfSElHSCk7
DQo+ID4gIAlibGtfcXVldWVfbWF4X2h3X3NlY3RvcnMobXEtPnF1ZXVlLA0KPiA+ICAJCW1pbiho
b3N0LT5tYXhfYmxrX2NvdW50LCBob3N0LT5tYXhfcmVxX3NpemUgLyA1MTIpKTsNCj4gPiAgCWlm
IChob3N0LT5jYW5fZG1hX21hcF9tZXJnZSkNCj4gPiAtCQlXQVJOKCFibGtfcXVldWVfY2FuX3Vz
ZV9kbWFfbWFwX21lcmdpbmcobXEtPnF1ZXVlLA0KPiA+IC0JCQkJCQkJbW1jX2Rldihob3N0KSks
DQo+ID4gKwkJV0FSTighYmxrX3F1ZXVlX2Nhbl91c2VfZG1hX21hcF9tZXJnaW5nKG1xLT5xdWV1
ZSwgZGV2KSwNCj4gPiAgCQkgICAgICJtZXJnaW5nIHdhcyBhZHZlcnRpc2VkIGJ1dCBub3QgcG9z
c2libGUiKTsNCj4gPiAgCWJsa19xdWV1ZV9tYXhfc2VnbWVudHMobXEtPnF1ZXVlLA0KPiBtbWNf
Z2V0X21heF9zZWdtZW50cyhob3N0KSk7DQo+ID4NCj4gPiBAQCAtMzg5LDcgKzM4OSw4IEBAIHN0
YXRpYyB2b2lkIG1tY19zZXR1cF9xdWV1ZShzdHJ1Y3QgbW1jX3F1ZXVlDQo+ICptcSwgc3RydWN0
IG1tY19jYXJkICpjYXJkKQ0KPiA+ICAJCWJsa19xdWV1ZV9tYXhfc2VnbWVudF9zaXplKG1xLT5x
dWV1ZSwNCj4gPiAgCQkJcm91bmRfZG93bihob3N0LT5tYXhfc2VnX3NpemUsIGJsb2NrX3NpemUp
KTsNCj4gPg0KPiA+IC0JZG1hX3NldF9tYXhfc2VnX3NpemUobW1jX2Rldihob3N0KSwNCj4gcXVl
dWVfbWF4X3NlZ21lbnRfc2l6ZShtcS0+cXVldWUpKTsNCj4gPiArCWRldi0+ZG1hX3Bhcm1zID0g
ZGV2bV9remFsbG9jKGRldiwgc2l6ZW9mKCpkZXYtPmRtYV9wYXJtcyksDQo+ID4gK0dGUF9LRVJO
RUwpOw0KPiANCj4gV291bGRuJ3QgaXQgYmUgbW9yZSBsb2dpY2FsIHRvIGtlZXAgZXhpc3Rpbmcg
ZG1hX3Bhcm1zPyBpLmUuDQo+IA0KPiAJaWYgKCFkZXYtPmRtYV9wYXJtcykNCj4gCQlkZXYtPmRt
YV9wYXJtcyA9IGRldm1fa3phbGxvYyhkZXYsIHNpemVvZigqZGV2LT5kbWFfcGFybXMpLA0KPiBH
RlBfS0VSTkVMKTsNCg0KWWVzISBJIHdpbGwgZG8gdGhhdC4NCg0KQmVzdCBSZWdhcmRzDQpCb3Vn
aCBDaGVuDQo+IA0KPiA+ICsJZG1hX3NldF9tYXhfc2VnX3NpemUoZGV2LCBxdWV1ZV9tYXhfc2Vn
bWVudF9zaXplKG1xLT5xdWV1ZSkpOw0KPiA+DQo+ID4gIAlJTklUX1dPUksoJm1xLT5yZWNvdmVy
eV93b3JrLCBtbWNfbXFfcmVjb3ZlcnlfaGFuZGxlcik7DQo+ID4gIAlJTklUX1dPUksoJm1xLT5j
b21wbGV0ZV93b3JrLCBtbWNfYmxrX21xX2NvbXBsZXRlX3dvcmspOw0KPiA+DQoNCg==
