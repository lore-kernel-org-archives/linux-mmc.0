Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10381C64E69
	for <linux-mmc@archiver.kernel.org>; Tue, 17 Nov 2020 12:30:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 942F42222B
	for <linux-mmc@archiver.kernel.org>; Tue, 17 Nov 2020 12:30:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ikPfYQFA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727214AbgKQMaR (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 17 Nov 2020 07:30:17 -0500
Received: from mail-eopbgr50073.outbound.protection.outlook.com ([40.107.5.73]:4208
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726791AbgKQMaQ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 17 Nov 2020 07:30:16 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SJRLaPHPYKi9BM9EPVDGfWI1Ar/1JtlZ9BjKYAyvT0/QVsQvM/hza3q3ltQfDa/km0iEv+wEolizzUTHIPCj/LUOLINtVJR0Lr8QtCrsSQjevsZszcgwZI34fFEfs/tmwcw3CPdlwH1LHtoIDQfJzm3cwK586Tj57HgFNbHRuX6MqDVEg/+UrxBOCGMgAN1TOh+9xesrM01SRgPXk3aW20Drtd1SSVtaPSY/aORBJ33O9zw96jt1A8yY7yfLnqkcrXLICRG0tgH2c4AO3zvjsyBoxEWgbUsdalM8qw/J/y2I1BlsMw4OKPzxry9CSrZ994QjGoheSZA+tvEJR0YebA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=49lMQATHv429OEiRb67Y8ExmPEYjOjuVl6vDpIEtLLY=;
 b=WR0c6CD6t2WM2Dobcn2rzZFuEjtBrW0gP6JZDhd08fQYJWibmj8C8h8hkuhudosNTKMQ96Y0rJIdvb7gCona6BQt+V2EH8/5IHWleZicsE4JVqB32tohVYpC1myFn+hedh7ysGxSVqwfhrvTDJq8U93Yy6EqEajAxIxYnIqPGxVXy/soYa9s5Wd+OeBKObaYb8dBM6JFtYF4KjaSU96kNfKQPp/+8+2KEhDx2bX9tEU9Ktk1Jq0Jj6YVRHeILAiQJx2gNyinBQERGaC4dApJ8nwgE5wx5iGW4f2q1B638GOFx8KIRIPkNxNqdlWF4FpR7Re6aQvZ5H313SOBDY1RBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=49lMQATHv429OEiRb67Y8ExmPEYjOjuVl6vDpIEtLLY=;
 b=ikPfYQFA9sl2tXjfO3P8gBAcp1siSUz+mkaDaX4CwHEsavMJK2WQAS9HznMlPLKG8FLS+O3RUEfetXnJc4SYyora2MHo1bVMFlnUN7SYsZ7VOEvb+rFaKM+4W2j5YSnzVA363tadkt1ppC8WY9hpafZ5Fi7GeYiAy2ekAKCtLNQ=
Received: from VI1PR04MB5294.eurprd04.prod.outlook.com (2603:10a6:803:5a::22)
 by VI1PR04MB5501.eurprd04.prod.outlook.com (2603:10a6:803:d3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.28; Tue, 17 Nov
 2020 12:30:13 +0000
Received: from VI1PR04MB5294.eurprd04.prod.outlook.com
 ([fe80::55e4:aa36:fd88:3b93]) by VI1PR04MB5294.eurprd04.prod.outlook.com
 ([fe80::55e4:aa36:fd88:3b93%7]) with mapi id 15.20.3564.025; Tue, 17 Nov 2020
 12:30:12 +0000
From:   Bough Chen <haibo.chen@nxp.com>
To:     Fabio Estevam <festevam@gmail.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>
CC:     "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Subject: RE: [PATCH] mmc: sdhci-esdhc-imx: Convert the driver to DT-only
Thread-Topic: [PATCH] mmc: sdhci-esdhc-imx: Convert the driver to DT-only
Thread-Index: AQHWvNYbx/aCep+pHUml1suHo4aXZqnMQKaw
Date:   Tue, 17 Nov 2020 12:30:12 +0000
Message-ID: <VI1PR04MB5294420F9A72A57EBBC8F58890E20@VI1PR04MB5294.eurprd04.prod.outlook.com>
References: <20201117113750.25053-1-festevam@gmail.com>
In-Reply-To: <20201117113750.25053-1-festevam@gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0a3ebe45-ad9f-4e17-59d5-08d88af487d6
x-ms-traffictypediagnostic: VI1PR04MB5501:
x-microsoft-antispam-prvs: <VI1PR04MB55015290769F4577E87740CD90E20@VI1PR04MB5501.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1468;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ArY1C8tPaIuHszc7eIppEad+hRORVoNFYagAvejMn45+CxJAcYcdTuvzpcQwrU0j5XoquJnkCXhYmJyE9wRWUXWh7pQFaa/oF7coPVzx2m64WSiC44BMWCVPX1ewQq5IwVAllbNlhj4fViq7LDj6l/SfFeYvCICeGkto+he2kxGcGItfbqCAkRETVNTGXx1QNiG1Tzn70JZBSntn9G5c+GbFj3xmM8D7hBdIN9qJBy/1XO4CW9CdXRQTY9nzURYfXLVn7MTWIFUv890uBDGDzM1FNdcYhZ0EyBH7UZlKq5VTV2ax8ovGtQ3whHi4KIht
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5294.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39850400004)(396003)(346002)(136003)(366004)(26005)(478600001)(54906003)(55016002)(110136005)(9686003)(83380400001)(2906002)(186003)(66556008)(8936002)(64756008)(66476007)(52536014)(76116006)(316002)(8676002)(6506007)(71200400001)(7696005)(53546011)(66946007)(86362001)(33656002)(66446008)(5660300002)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: DxJjNWqAO8fH4fDiQhWPf+lRmwjl5Wjoo6um8hBfmqcRvbZQimP/V1i1AqbXCxXFVT2Pf1JMuFuqBsUglfKz/Nf5wYJ1UTOtzegZaadefWYoQ+u9867J5Kko2kWMLArsFnOWoCZcsw0VbtYTdRTzIwFYMVSisByewaLL0H8bHOaVUCiwt6GGlwVMEOBPpZYEJ+FienEKjBAFSPlH+Mjg4dSV9RfsCy4KGkkXsCkvtAsS14H+oP3iabhzOWJBbVy9RC7cdDmYS5sg8PVj+g2GN9YJlOjafUiC51dPlXwPCOJSj554DStd8f7h2qLpp8RRUn8ypIMEU27/JeFVPz12Y2cSdmciUnV0mFbvTARSfalp1H46CczgTR8B/nMcNxfMW+QLMELPfO1V9v5dZfJQLtMMCf6Kq86ojKErkMNXFlvOcUqf1IPbQCpj7e1wwKxD63DzHyxk7X5njUAzJRscfNpeftYHbC75OcwD5mWaKVEmCoZ5Bvn25dOrQhCdThH48ucPsp0EXhy9sKxRLUdplNPbFgtDsQmucBf+0m4CS6ORBmebNFd90jJx8iI6G2eDsOTlnlPGRziKtLajU0JO94rFP38Uqw2GU0nsm7t58IltLmt+4gDZDIMh/t5UcM6NTgm0DuohOaDE8g6GeGydJgH8sHHGYRv76cIaQ+gGjtQ6XNwlFZLvn0jDGmEpdpC3X96YPvC/bg0HVUDzMYT7rLPFCiW+bxhK5iFbo4J/iWX9NDtnlG6yDibAnmqhJPP5KPQWlSpJDyAt0Bnl/sORE4MikhdBbMXGpIgQxBJH1AwhA+ExUH1ovRY+pXWG9B4XxwBiatxs2+65+NM3Hug3Ej6Um+LIKYqBhEWiWxckLbvLArKjRsdNaBDcqH0f0l6u6iFK2MKB7pSFUt6CM1Zz1Q==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5294.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a3ebe45-ad9f-4e17-59d5-08d88af487d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2020 12:30:12.7151
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tPybuutYY5r7VBhGvGEDlyj9eXGR0B+Wo41cAP9pPPskETXRVa0W/MFLynEvmlcFpXPZZe7UN1Dgab4Gnzo2Rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5501
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBGYWJpbyBFc3RldmFtIFttYWls
dG86ZmVzdGV2YW1AZ21haWwuY29tXQ0KPiBTZW50OiAyMDIwxOoxMdTCMTfI1SAxOTozOA0KPiBU
bzogdWxmLmhhbnNzb25AbGluYXJvLm9yZw0KPiBDYzogYWRyaWFuLmh1bnRlckBpbnRlbC5jb207
IHNoYXduZ3VvQGtlcm5lbC5vcmc7IGtlcm5lbEBwZW5ndXRyb25peC5kZTsNCj4gQm91Z2ggQ2hl
biA8aGFpYm8uY2hlbkBueHAuY29tPjsgbGludXgtbW1jQHZnZXIua2VybmVsLm9yZzsgRmFiaW8N
Cj4gRXN0ZXZhbSA8ZmVzdGV2YW1AZ21haWwuY29tPg0KPiBTdWJqZWN0OiBbUEFUQ0hdIG1tYzog
c2RoY2ktZXNkaGMtaW14OiBDb252ZXJ0IHRoZSBkcml2ZXIgdG8gRFQtb25seQ0KPiANCj4gU2lu
Y2UgNS4xMC1yYzEgaS5NWCBpcyBhIGRldmljZXRyZWUtb25seSBwbGF0Zm9ybSwgc28gc2ltcGxp
ZnkgdGhlIGNvZGUgYnkNCj4gcmVtb3ZpbmcgdGhlIHVudXNlZCBub24tRFQgc3VwcG9ydC4NCj4g
DQo+IFNpZ25lZC1vZmYtYnk6IEZhYmlvIEVzdGV2YW0gPGZlc3RldmFtQGdtYWlsLmNvbT4NCg0K
UmV2aWV3ZWQtYnk6IEhhaWJvIENoZW4gPGhhaWJvLmNoZW5AbnhwLmNvbT4NCg0KPiAtLS0NCj4g
IGRyaXZlcnMvbW1jL2hvc3Qvc2RoY2ktZXNkaGMtaW14LmMgfCA5MSArLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDg5IGRl
bGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2ktZXNk
aGMtaW14LmMNCj4gYi9kcml2ZXJzL21tYy9ob3N0L3NkaGNpLWVzZGhjLWlteC5jDQo+IGluZGV4
IGZjZThmYTdlNmIzMC4uMTZlZDE5ZjQ3OTM5IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL21tYy9o
b3N0L3NkaGNpLWVzZGhjLWlteC5jDQo+ICsrKyBiL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2ktZXNk
aGMtaW14LmMNCj4gQEAgLTI5NiwyMiArMjk2LDYgQEAgc3RydWN0IHBsdGZtX2lteF9kYXRhIHsN
Cj4gIAlzdHJ1Y3QgcG1fcW9zX3JlcXVlc3QgcG1fcW9zX3JlcTsNCj4gIH07DQo+IA0KPiAtc3Rh
dGljIGNvbnN0IHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2VfaWQgaW14X2VzZGhjX2RldnR5cGVbXSA9
IHsNCj4gLQl7DQo+IC0JCS5uYW1lID0gInNkaGNpLWVzZGhjLWlteDI1IiwNCj4gLQkJLmRyaXZl
cl9kYXRhID0gKGtlcm5lbF91bG9uZ190KSAmZXNkaGNfaW14MjVfZGF0YSwNCj4gLQl9LCB7DQo+
IC0JCS5uYW1lID0gInNkaGNpLWVzZGhjLWlteDM1IiwNCj4gLQkJLmRyaXZlcl9kYXRhID0gKGtl
cm5lbF91bG9uZ190KSAmZXNkaGNfaW14MzVfZGF0YSwNCj4gLQl9LCB7DQo+IC0JCS5uYW1lID0g
InNkaGNpLWVzZGhjLWlteDUxIiwNCj4gLQkJLmRyaXZlcl9kYXRhID0gKGtlcm5lbF91bG9uZ190
KSAmZXNkaGNfaW14NTFfZGF0YSwNCj4gLQl9LCB7DQo+IC0JCS8qIHNlbnRpbmVsICovDQo+IC0J
fQ0KPiAtfTsNCj4gLU1PRFVMRV9ERVZJQ0VfVEFCTEUocGxhdGZvcm0sIGlteF9lc2RoY19kZXZ0
eXBlKTsNCj4gLQ0KPiAgc3RhdGljIGNvbnN0IHN0cnVjdCBvZl9kZXZpY2VfaWQgaW14X2VzZGhj
X2R0X2lkc1tdID0gew0KPiAgCXsgLmNvbXBhdGlibGUgPSAiZnNsLGlteDI1LWVzZGhjIiwgLmRh
dGEgPSAmZXNkaGNfaW14MjVfZGF0YSwgfSwNCj4gIAl7IC5jb21wYXRpYmxlID0gImZzbCxpbXgz
NS1lc2RoYyIsIC5kYXRhID0gJmVzZGhjX2lteDM1X2RhdGEsIH0sIEBADQo+IC0xNTMxLDcyICsx
NTE1LDYgQEAgc2RoY2lfZXNkaGNfaW14X3Byb2JlX2R0KHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UN
Cj4gKnBkZXYsICB9ICAjZW5kaWYNCj4gDQo+IC1zdGF0aWMgaW50IHNkaGNpX2VzZGhjX2lteF9w
cm9iZV9ub25kdChzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2LA0KPiAtCQkJIHN0cnVjdCBz
ZGhjaV9ob3N0ICpob3N0LA0KPiAtCQkJIHN0cnVjdCBwbHRmbV9pbXhfZGF0YSAqaW14X2RhdGEp
DQo+IC17DQo+IC0Jc3RydWN0IGVzZGhjX3BsYXRmb3JtX2RhdGEgKmJvYXJkZGF0YSA9ICZpbXhf
ZGF0YS0+Ym9hcmRkYXRhOw0KPiAtCWludCBlcnI7DQo+IC0NCj4gLQlpZiAoIWhvc3QtPm1tYy0+
cGFyZW50LT5wbGF0Zm9ybV9kYXRhKSB7DQo+IC0JCWRldl9lcnIobW1jX2Rldihob3N0LT5tbWMp
LCAibm8gYm9hcmQgZGF0YSFcbiIpOw0KPiAtCQlyZXR1cm4gLUVJTlZBTDsNCj4gLQl9DQo+IC0N
Cj4gLQlpbXhfZGF0YS0+Ym9hcmRkYXRhID0gKigoc3RydWN0IGVzZGhjX3BsYXRmb3JtX2RhdGEg
KikNCj4gLQkJCQlob3N0LT5tbWMtPnBhcmVudC0+cGxhdGZvcm1fZGF0YSk7DQo+IC0JLyogd3Jp
dGVfcHJvdGVjdCAqLw0KPiAtCWlmIChib2FyZGRhdGEtPndwX3R5cGUgPT0gRVNESENfV1BfR1BJ
Tykgew0KPiAtCQlob3N0LT5tbWMtPmNhcHMyIHw9IE1NQ19DQVAyX1JPX0FDVElWRV9ISUdIOw0K
PiAtDQo+IC0JCWVyciA9IG1tY19ncGlvZF9yZXF1ZXN0X3JvKGhvc3QtPm1tYywgIndwIiwgMCwg
MCk7DQo+IC0JCWlmIChlcnIpIHsNCj4gLQkJCWRldl9lcnIobW1jX2Rldihob3N0LT5tbWMpLA0K
PiAtCQkJCSJmYWlsZWQgdG8gcmVxdWVzdCB3cml0ZS1wcm90ZWN0IGdwaW8hXG4iKTsNCj4gLQkJ
CXJldHVybiBlcnI7DQo+IC0JCX0NCj4gLQl9DQo+IC0NCj4gLQkvKiBjYXJkX2RldGVjdCAqLw0K
PiAtCXN3aXRjaCAoYm9hcmRkYXRhLT5jZF90eXBlKSB7DQo+IC0JY2FzZSBFU0RIQ19DRF9HUElP
Og0KPiAtCQllcnIgPSBtbWNfZ3Bpb2RfcmVxdWVzdF9jZChob3N0LT5tbWMsICJjZCIsIDAsIGZh
bHNlLCAwKTsNCj4gLQkJaWYgKGVycikgew0KPiAtCQkJZGV2X2VycihtbWNfZGV2KGhvc3QtPm1t
YyksDQo+IC0JCQkJImZhaWxlZCB0byByZXF1ZXN0IGNhcmQtZGV0ZWN0IGdwaW8hXG4iKTsNCj4g
LQkJCXJldHVybiBlcnI7DQo+IC0JCX0NCj4gLQkJZmFsbHRocm91Z2g7DQo+IC0NCj4gLQljYXNl
IEVTREhDX0NEX0NPTlRST0xMRVI6DQo+IC0JCS8qIHdlIGhhdmUgYSB3b3JraW5nIGNhcmRfZGV0
ZWN0IGJhY2sgKi8NCj4gLQkJaG9zdC0+cXVpcmtzICY9IH5TREhDSV9RVUlSS19CUk9LRU5fQ0FS
RF9ERVRFQ1RJT047DQo+IC0JCWJyZWFrOw0KPiAtDQo+IC0JY2FzZSBFU0RIQ19DRF9QRVJNQU5F
TlQ6DQo+IC0JCWhvc3QtPm1tYy0+Y2FwcyB8PSBNTUNfQ0FQX05PTlJFTU9WQUJMRTsNCj4gLQkJ
YnJlYWs7DQo+IC0NCj4gLQljYXNlIEVTREhDX0NEX05PTkU6DQo+IC0JCWJyZWFrOw0KPiAtCX0N
Cj4gLQ0KPiAtCXN3aXRjaCAoYm9hcmRkYXRhLT5tYXhfYnVzX3dpZHRoKSB7DQo+IC0JY2FzZSA4
Og0KPiAtCQlob3N0LT5tbWMtPmNhcHMgfD0gTU1DX0NBUF84X0JJVF9EQVRBIHwNCj4gTU1DX0NB
UF80X0JJVF9EQVRBOw0KPiAtCQlicmVhazsNCj4gLQljYXNlIDQ6DQo+IC0JCWhvc3QtPm1tYy0+
Y2FwcyB8PSBNTUNfQ0FQXzRfQklUX0RBVEE7DQo+IC0JCWJyZWFrOw0KPiAtCWNhc2UgMToNCj4g
LQlkZWZhdWx0Og0KPiAtCQlob3N0LT5xdWlya3MgfD0gU0RIQ0lfUVVJUktfRk9SQ0VfMV9CSVRf
REFUQTsNCj4gLQkJYnJlYWs7DQo+IC0JfQ0KPiAtDQo+IC0JcmV0dXJuIDA7DQo+IC19DQo+IC0N
Cj4gIHN0YXRpYyBpbnQgc2RoY2lfZXNkaGNfaW14X3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZp
Y2UgKnBkZXYpICB7DQo+ICAJY29uc3Qgc3RydWN0IG9mX2RldmljZV9pZCAqb2ZfaWQgPQ0KPiBA
QCAtMTYxNiw4ICsxNTM0LDcgQEAgc3RhdGljIGludCBzZGhjaV9lc2RoY19pbXhfcHJvYmUoc3Ry
dWN0DQo+IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gDQo+ICAJaW14X2RhdGEgPSBzZGhjaV9w
bHRmbV9wcml2KHBsdGZtX2hvc3QpOw0KPiANCj4gLQlpbXhfZGF0YS0+c29jZGF0YSA9IG9mX2lk
ID8gb2ZfaWQtPmRhdGEgOiAoc3RydWN0IGVzZGhjX3NvY19kYXRhICopDQo+IC0JCQkJCQkgIHBk
ZXYtPmlkX2VudHJ5LT5kcml2ZXJfZGF0YTsNCj4gKwlpbXhfZGF0YS0+c29jZGF0YSA9IG9mX2lk
LT5kYXRhOw0KPiANCj4gIAlpZiAoaW14X2RhdGEtPnNvY2RhdGEtPmZsYWdzICYgRVNESENfRkxB
R19QTVFPUykNCj4gIAkJY3B1X2xhdGVuY3lfcW9zX2FkZF9yZXF1ZXN0KCZpbXhfZGF0YS0+cG1f
cW9zX3JlcSwgMCk7IEBADQo+IC0xNzEzLDEwICsxNjMwLDcgQEAgc3RhdGljIGludCBzZGhjaV9l
c2RoY19pbXhfcHJvYmUoc3RydWN0DQo+IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gIAkJCWdv
dG8gZGlzYWJsZV9haGJfY2xrOw0KPiAgCX0NCj4gDQo+IC0JaWYgKG9mX2lkKQ0KPiAtCQllcnIg
PSBzZGhjaV9lc2RoY19pbXhfcHJvYmVfZHQocGRldiwgaG9zdCwgaW14X2RhdGEpOw0KPiAtCWVs
c2UNCj4gLQkJZXJyID0gc2RoY2lfZXNkaGNfaW14X3Byb2JlX25vbmR0KHBkZXYsIGhvc3QsIGlt
eF9kYXRhKTsNCj4gKwllcnIgPSBzZGhjaV9lc2RoY19pbXhfcHJvYmVfZHQocGRldiwgaG9zdCwg
aW14X2RhdGEpOw0KPiAgCWlmIChlcnIpDQo+ICAJCWdvdG8gZGlzYWJsZV9haGJfY2xrOw0KPiAN
Cj4gQEAgLTE5MjksNyArMTg0Myw2IEBAIHN0YXRpYyBzdHJ1Y3QgcGxhdGZvcm1fZHJpdmVyDQo+
IHNkaGNpX2VzZGhjX2lteF9kcml2ZXIgPSB7DQo+ICAJCS5vZl9tYXRjaF90YWJsZSA9IGlteF9l
c2RoY19kdF9pZHMsDQo+ICAJCS5wbQk9ICZzZGhjaV9lc2RoY19wbW9wcywNCj4gIAl9LA0KPiAt
CS5pZF90YWJsZQk9IGlteF9lc2RoY19kZXZ0eXBlLA0KPiAgCS5wcm9iZQkJPSBzZGhjaV9lc2Ro
Y19pbXhfcHJvYmUsDQo+ICAJLnJlbW92ZQkJPSBzZGhjaV9lc2RoY19pbXhfcmVtb3ZlLA0KPiAg
fTsNCj4gLS0NCj4gMi4xNy4xDQoNCg==
