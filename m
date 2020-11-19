Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A6A0C56201
	for <linux-mmc@archiver.kernel.org>; Thu, 19 Nov 2020 17:20:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D107D24695
	for <linux-mmc@archiver.kernel.org>; Thu, 19 Nov 2020 17:20:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="jb9X5PDY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728202AbgKSRUb (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 19 Nov 2020 12:20:31 -0500
Received: from mail-dm6nam08on2081.outbound.protection.outlook.com ([40.107.102.81]:36960
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728169AbgKSRUa (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 19 Nov 2020 12:20:30 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ghWtPdc+XJDGVoYYUn7P+rNlzpEEO1w9ajb00cSRGFWbe7Dw581NdK7i6P/wONG6XhPOUpwCAWUhftcoxvgqIwVsjPpqWdGLZ/tzsBuZ88OPjzsj3X5eYrDQ8PqkZWz7d8p4hZyoIhxCAbZ4Ns1PJ9xjsS2cfIpTcAQVIQjsVaQU1kNL0YB1rcOaVvIJCjagqrX+xhFHGmq4yNzPP2d7W2zVmvSozC1frJyf4FWqioweyU1uF9fodHlWubeusJIIBs7lU+hXhXGmrCd5ORgJyQb36kYcD6h6y3HaGqjRTzs8/BlvjeCWSGnQb0Z3SPMuyGzGTtQAjFQKmKKEOPuF0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RCE1gFOl7vRk95dkxFZcD+30PCLMOlulSPYa1825uBs=;
 b=L4bD62cYi8rlrM01BY1nJR/GdHMvSmWB5qDBU04w4dFq1Uqfle9xmfL1ccHgue6dpLc8k9APUDLTUScqj+5TGSSfWMTyODukBUn7J8LbbyncKi68N772fnNeo9SeortQ3Usl9MY8U6399bxA5QDL8WTMlo0BbR24vil7lYMmO6JPBQeFbFbXYk6Kp2W1wVAmB7/U8dTAPAubzJBlcI4XPHBZwUao0rA8QY3LFanv+g3VtAh5erj4/MbEYAx3p9zVp6IWY7vFoPDzOff9bVdyJ8B0rrchrFdaMoJdYh+SfHC3jY/PiCciK0ygBIraWfH2nlIrq/yqnJy/GnnWZN1g0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RCE1gFOl7vRk95dkxFZcD+30PCLMOlulSPYa1825uBs=;
 b=jb9X5PDYBxLzbhawq48xPWDrtbzBqlzLQwPiadgtnCYntsmAvXUg/p09TdUWuRMdVd0KRB8mLTXC0gC9wssbaRGPuJf5nP50+aVAzt/v5NrR4Crzt+7oJkQo5C33nYBi8qd4xFPKcD352feGGRZu2rh1k8uazMHsYiQPWoitNtg=
Received: from BYAPR02MB5896.namprd02.prod.outlook.com (2603:10b6:a03:122::10)
 by BYAPR02MB4278.namprd02.prod.outlook.com (2603:10b6:a03:55::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.22; Thu, 19 Nov
 2020 17:20:26 +0000
Received: from BYAPR02MB5896.namprd02.prod.outlook.com
 ([fe80::1876:e714:1c03:e89b]) by BYAPR02MB5896.namprd02.prod.outlook.com
 ([fe80::1876:e714:1c03:e89b%6]) with mapi id 15.20.3564.028; Thu, 19 Nov 2020
 17:20:25 +0000
From:   Manish Narani <MNARANI@xilinx.com>
To:     Michal Simek <michals@xilinx.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
CC:     Michal Simek <michals@xilinx.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        git <git@xilinx.com>
Subject: RE: [PATCH] mmc: sdhci-of-arasan: Add pinctrl support to the driver
Thread-Topic: [PATCH] mmc: sdhci-of-arasan: Add pinctrl support to the driver
Thread-Index: AQHWvXMdrdVXyTSuUkyy+N8PLFC/P6nOCECAgAAs8wCAAX8rEA==
Date:   Thu, 19 Nov 2020 17:20:25 +0000
Message-ID: <BYAPR02MB589626845315581375811594C1E00@BYAPR02MB5896.namprd02.prod.outlook.com>
References: <1605680495-37483-1-git-send-email-manish.narani@xilinx.com>
 <CAPDyKFr7KTf7jUAuPj=0NZ1sty+y7ySV8PkdrKFXPVthJ=VJVQ@mail.gmail.com>
 <aeb44b64-5ff6-5662-2761-0e804708ce8a@xilinx.com>
In-Reply-To: <aeb44b64-5ff6-5662-2761-0e804708ce8a@xilinx.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: xilinx.com; dkim=none (message not signed)
 header.d=none;xilinx.com; dmarc=none action=none header.from=xilinx.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [149.199.50.129]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 68c0d4e5-556b-4916-d6d5-08d88caf67a6
x-ms-traffictypediagnostic: BYAPR02MB4278:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR02MB42784896E1F5C72F9101086AC1E00@BYAPR02MB4278.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nFyk9md6A6ZYVHkYFVjbOb8aqE1cygBSTOgPCNoYrw1aKkjPCaLpHybBQj2xx1Warz3oascMekutKHgpMXAZI36FoqfHWIhYvNtMFN4lr8SeEr0rMXtJLWenm3t5opJhxdJmmaXp6iOY+C7S941d9wVy5XemUVyELA+uqsbVtGoBeHQWIn3XdxMzUuC4IWHY/wWNAwvRKQ5pZQ9ZcOvDCJnaFscxkAspYJsrrWXbnLtWMMxFKlpZ0YlKYthJfEulNjXQAG55jdsxypJVHGyx7kmpFRTxhRcJov2pfitcpoRhQs0X5XMB58BNVvTFNZWBmw0WDeNWTunCJf7h61GSkA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR02MB5896.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(39860400002)(346002)(136003)(376002)(8936002)(66556008)(2906002)(54906003)(66476007)(64756008)(66446008)(52536014)(110136005)(83380400001)(316002)(6506007)(53546011)(5660300002)(44832011)(8676002)(186003)(7696005)(71200400001)(4326008)(26005)(478600001)(55016002)(107886003)(76116006)(66946007)(33656002)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: WUEactH1juppPiSYNNBTwah0IzUSq80gcaOi3z7QjV+o4ilv4yIdy2rHJnPDmVsrPzRrH+hwk+M7lSOkts2iGWxYKncS7WqEEUmy/KY9HZXUskh+QoPRQs1GVhocBAtzVQnEVc+0Fe99hlMNwuiCeNVZphF/PxGdE0DbZkhNYYg7wrrHD1aUUOMYaqdQcmYqd/YASWnlYxZTqQqMP61v7kL39y/9c84s+Xcv5fBHL111+uzTJ1L6W6iEuLfZnfOXEy3VZp3gbA1Ufqq6QQA+oCNC8GyPe2GF38SMHSM12OIEviVxfXyeNR3HfQOAp5p8SE+5/2OhFGG+HvYxn6kPxbVlhq7DsFafgSae2u1m7VY/QyZkB5ufrgmHKZti8UJ0hLQl1TEx2XaRTjm9EQIw+XusOf8N3IQQMHQC5Cu0UQAO6OcVgqD0cgELTP4BxbVclxai47TmJz6Yk7SuyFJnAhRf7CkmvpwgxD24BkNJjR4jLdHweCNtBr0G4+EKmZviy0o0BlEViAQN2I9lRnvPaE6BHNz68adwC7qGO9l9UCdJGShCih+pDo7Ik9IqkCkt/T+sUtPfOqqJZdzEGNFjdJgh5hY5d/bVcL50cgIxezK7clzx6475SyntEmGaez3z6w8aG6+kwIEzGT4MqgrGKw==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB5896.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68c0d4e5-556b-4916-d6d5-08d88caf67a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2020 17:20:25.7858
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s+sEr+TGhEXTg4BwFCw39Q9I/6wsXRDmkC16tGb46eLXmOK29WZTcipwI/uUMtNXkGUa5xtSC9JGOtovIaz1zA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4278
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

SGkgVWZmZS9NaWNoYWwsDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTog
TWljaGFsIFNpbWVrIDxtaWNoYWwuc2ltZWtAeGlsaW54LmNvbT4NCj4gU2VudDogV2VkbmVzZGF5
LCBOb3ZlbWJlciAxOCwgMjAyMCAxMTo1NCBQTQ0KPiBUbzogVWxmIEhhbnNzb24gPHVsZi5oYW5z
c29uQGxpbmFyby5vcmc+OyBNYW5pc2ggTmFyYW5pDQo+IDxNTkFSQU5JQHhpbGlueC5jb20+DQo+
IENjOiBNaWNoYWwgU2ltZWsgPG1pY2hhbHNAeGlsaW54LmNvbT47IEFkcmlhbiBIdW50ZXINCj4g
PGFkcmlhbi5odW50ZXJAaW50ZWwuY29tPjsgTGludXggQVJNIDxsaW51eC1hcm0tDQo+IGtlcm5l
bEBsaXN0cy5pbmZyYWRlYWQub3JnPjsgbGludXgtbW1jQHZnZXIua2VybmVsLm9yZzsgTGludXgg
S2VybmVsDQo+IE1haWxpbmcgTGlzdCA8bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZz47IGdp
dCA8Z2l0QHhpbGlueC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIG1tYzogc2RoY2ktb2Yt
YXJhc2FuOiBBZGQgcGluY3RybCBzdXBwb3J0IHRvIHRoZSBkcml2ZXINCj4gDQo+IA0KPiANCj4g
T24gMTguIDExLiAyMCAxNjo0MywgVWxmIEhhbnNzb24gd3JvdGU6DQo+ID4gT24gV2VkLCAxOCBO
b3YgMjAyMCBhdCAwNzoyMiwgTWFuaXNoIE5hcmFuaQ0KPiA8bWFuaXNoLm5hcmFuaUB4aWxpbngu
Y29tPiB3cm90ZToNCj4gPj4NCj4gPj4gRHJpdmVyIHNob3VsZCBiZSBhYmxlIHRvIGhhbmRsZSBv
cHRpb25hbCBwaW5jdHJsIHNldHRpbmcuDQo+ID4+DQo+ID4+IFNpZ25lZC1vZmYtYnk6IE1pY2hh
bCBTaW1layA8bWljaGFsLnNpbWVrQHhpbGlueC5jb20+DQo+ID4+IFNpZ25lZC1vZmYtYnk6IE1h
bmlzaCBOYXJhbmkgPG1hbmlzaC5uYXJhbmlAeGlsaW54LmNvbT4NCj4gPj4gLS0tDQo+ID4+ICBk
cml2ZXJzL21tYy9ob3N0L3NkaGNpLW9mLWFyYXNhbi5jIHwgMjQgKysrKysrKysrKysrKysrKysr
KysrKysrDQo+ID4+ICAxIGZpbGUgY2hhbmdlZCwgMjQgaW5zZXJ0aW9ucygrKQ0KPiA+Pg0KPiA+
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1vZi1hcmFzYW4uYw0KPiBiL2Ry
aXZlcnMvbW1jL2hvc3Qvc2RoY2ktb2YtYXJhc2FuLmMNCj4gPj4gaW5kZXggODI5Y2NlZjg3NDI2
Li5mNzg4Y2M5ZDU5MTQgMTAwNjQ0DQo+ID4+IC0tLSBhL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2kt
b2YtYXJhc2FuLmMNCj4gPj4gKysrIGIvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1vZi1hcmFzYW4u
Yw0KPiA+PiBAQCAtMjMsNiArMjMsNyBAQA0KPiA+PiAgI2luY2x1ZGUgPGxpbnV4L3JlZ21hcC5o
Pg0KPiA+PiAgI2luY2x1ZGUgPGxpbnV4L29mLmg+DQo+ID4+ICAjaW5jbHVkZSA8bGludXgvZmly
bXdhcmUveGxueC16eW5xbXAuaD4NCj4gPj4gKyNpbmNsdWRlIDxsaW51eC9waW5jdHJsL2NvbnN1
bWVyLmg+DQo+ID4+DQo+ID4+ICAjaW5jbHVkZSAiY3FoY2kuaCINCj4gPj4gICNpbmNsdWRlICJz
ZGhjaS1wbHRmbS5oIg0KPiA+PiBAQCAtMTM1LDYgKzEzNiw4IEBAIHN0cnVjdCBzZGhjaV9hcmFz
YW5fY2xrX2RhdGEgew0KPiA+PiAgICogQGNsa19vcHM6ICAgICAgICAgICBTdHJ1Y3QgZm9yIHRo
ZSBBcmFzYW4gQ29udHJvbGxlciBDbG9jayBPcGVyYXRpb25zLg0KPiA+PiAgICogQHNvY19jdGxf
YmFzZTogICAgICBQb2ludGVyIHRvIHJlZ21hcCBmb3Igc3lzY29uIGZvciBzb2NfY3RsIHJlZ2lz
dGVycy4NCj4gPj4gICAqIEBzb2NfY3RsX21hcDogICAgICAgTWFwIHRvIGdldCBvZmZzZXRzIGlu
dG8gc29jX2N0bCByZWdpc3RlcnMuDQo+ID4+ICsgKiBAcGluY3RybDogICAgICAgICAgIFBlci1k
ZXZpY2UgcGluIGNvbnRyb2wgc3RhdGUgaG9sZGVyLg0KPiA+PiArICogQHBpbnNfZGVmYXVsdDog
ICAgICBQaW5jdHJsIHN0YXRlIGZvciBhIGRldmljZS4NCj4gPj4gICAqIEBxdWlya3M6ICAgICAg
ICAgICAgQXJhc2FuIGRldmlhdGlvbnMgZnJvbSBzcGVjLg0KPiA+PiAgICovDQo+ID4+ICBzdHJ1
Y3Qgc2RoY2lfYXJhc2FuX2RhdGEgew0KPiA+PiBAQCAtMTQ5LDYgKzE1Miw4IEBAIHN0cnVjdCBz
ZGhjaV9hcmFzYW5fZGF0YSB7DQo+ID4+DQo+ID4+ICAgICAgICAgc3RydWN0IHJlZ21hcCAgICpz
b2NfY3RsX2Jhc2U7DQo+ID4+ICAgICAgICAgY29uc3Qgc3RydWN0IHNkaGNpX2FyYXNhbl9zb2Nf
Y3RsX21hcCAqc29jX2N0bF9tYXA7DQo+ID4+ICsgICAgICAgc3RydWN0IHBpbmN0cmwgICpwaW5j
dHJsOw0KPiA+PiArICAgICAgIHN0cnVjdCBwaW5jdHJsX3N0YXRlICpwaW5zX2RlZmF1bHQ7DQo+
ID4+ICAgICAgICAgdW5zaWduZWQgaW50ICAgIHF1aXJrczsNCj4gPj4NCj4gPj4gIC8qIENvbnRy
b2xsZXIgZG9lcyBub3QgaGF2ZSBDRCB3aXJlZCBhbmQgd2lsbCBub3QgZnVuY3Rpb24gbm9ybWFs
bHkNCj4gd2l0aG91dCAqLw0KPiA+PiBAQCAtMTYxOSw2ICsxNjI0LDI1IEBAIHN0YXRpYyBpbnQg
c2RoY2lfYXJhc2FuX3Byb2JlKHN0cnVjdA0KPiBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ID4+
ICAgICAgICAgICAgICAgICBnb3RvIHVucmVnX2NsazsNCj4gPj4gICAgICAgICB9DQo+ID4+DQo+
ID4+ICsgICAgICAgc2RoY2lfYXJhc2FuLT5waW5jdHJsID0gZGV2bV9waW5jdHJsX2dldCgmcGRl
di0+ZGV2KTsNCj4gPj4gKyAgICAgICBpZiAoIUlTX0VSUihzZGhjaV9hcmFzYW4tPnBpbmN0cmwp
KSB7DQo+ID4+ICsgICAgICAgICAgICAgICBzZGhjaV9hcmFzYW4tPnBpbnNfZGVmYXVsdCA9DQo+
ID4+ICsgICAgICAgICAgICAgICAgICAgICAgIHBpbmN0cmxfbG9va3VwX3N0YXRlKHNkaGNpX2Fy
YXNhbi0+cGluY3RybCwNCj4gPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgUElOQ1RSTF9TVEFURV9ERUZBVUxUKTsNCj4gPj4gKyAgICAgICAgICAgICAgIGlm
IChJU19FUlIoc2RoY2lfYXJhc2FuLT5waW5zX2RlZmF1bHQpKSB7DQo+ID4+ICsgICAgICAgICAg
ICAgICAgICAgICAgIGRldl9lcnIoJnBkZXYtPmRldiwgIk1pc3NpbmcgZGVmYXVsdCBwaW5jdHJs
IGNvbmZpZ1xuIik7DQo+ID4+ICsgICAgICAgICAgICAgICAgICAgICAgIHJldCA9IFBUUl9FUlIo
c2RoY2lfYXJhc2FuLT5waW5zX2RlZmF1bHQpOw0KPiA+PiArICAgICAgICAgICAgICAgICAgICAg
ICBnb3RvIHVucmVnX2NsazsNCj4gPj4gKyAgICAgICAgICAgICAgIH0NCj4gPj4gKw0KPiA+PiAr
ICAgICAgICAgICAgICAgcmV0ID0gcGluY3RybF9zZWxlY3Rfc3RhdGUoc2RoY2lfYXJhc2FuLT5w
aW5jdHJsLA0KPiA+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
c2RoY2lfYXJhc2FuLT5waW5zX2RlZmF1bHQpOw0KPiA+PiArICAgICAgICAgICAgICAgaWYgKHJl
dCkgew0KPiA+PiArICAgICAgICAgICAgICAgICAgICAgICBkZXZfZXJyKCZwZGV2LT5kZXYsICJj
b3VsZCBub3Qgc2VsZWN0IGRlZmF1bHQgc3RhdGVcbiIpOw0KPiA+PiArICAgICAgICAgICAgICAg
ICAgICAgICBnb3RvIHVucmVnX2NsazsNCj4gPj4gKyAgICAgICAgICAgICAgIH0NCj4gPj4gKyAg
ICAgICB9DQo+ID4NCj4gPiBJc24ndCBhbGwgdGhpcyBhbHJlYWR5IHRha2VuIGNhcmUgb2Ygdmlh
IHBpbmN0cmxfYmluZF9waW5zKCkgY2FsbGVkIGJ5DQo+ID4gZHJpdmVyIGNvcmUgZHVyaW5nIHBy
b2JlPw0KPiA+DQo+IA0KPiBUaGFua3MgZm9yIHRoZSBoaW50Lg0KPiBNYW5pc2g6IENhbiB5b3Ug
cGxlYXNlIGNoZWNrIGl0Pw0KDQpUaGFua3MgVWZmZS4NClllcywgdGhpcyBpcyBhbHJlYWR5IHRh
a2VuIGNhcmUgb2YgdmlhIHBpbmN0cmxfYmluZF9waW5zKCkgY2FsbGVkIGR1cmluZyBwcm9iZS4N
ClRoaXMgcGF0Y2ggaXMgbm90IHJlcXVpcmVkIHRvIGJlIG1lcmdlZC4NCg0KVGhhbmtzLA0KTWFu
aXNoDQo=
