Return-Path: <SRS0=1974=Z2=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2434C43603
	for <linux-mmc@archiver.kernel.org>; Wed,  4 Dec 2019 07:15:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EFB420865
	for <linux-mmc@archiver.kernel.org>; Wed,  4 Dec 2019 07:14:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="C5SPNZ8T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbfLDHO3 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 4 Dec 2019 02:14:29 -0500
Received: from mail-eopbgr800079.outbound.protection.outlook.com ([40.107.80.79]:42447
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726048AbfLDHO3 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 4 Dec 2019 02:14:29 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c9t6Oj1+5cI7sb3q46a8ESxO49P9xsjXHw9H1rkC2dbH//H0dwWMWsmTMFOpxVQ19WBSP1vQJaTPjjf99wd+uwFurKc+NGfOWv/gIspZg8yoGppt0NqdsjPzSOW+/cuWfpO1ssku3mPjGiStQctj5HhFhf7f9YVYT8CVqjNqIMt/M56QSy4U5G3dwmSi4yoD5FGVEa8xs6ZkzcP8rs9r8+lyztmg+oYjkayexEkQ3OUiJyl5L7vTkP7Fd/wYnVTlIs4GuxxZB++PDfMN9d5d3+3GJm2OzD5JuvPgtTP9/YcGh1u4Yj6ZFPcfFojsoSZARi+FBPNXcfH6K64XK3cm1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NZZLwMhrq9e1E2n+3ugFj18kpVD0nbPNFZ/wqKGcW98=;
 b=eQbv5T1BvZSTNP++vYcWkc98bD7YtSvwwyspYFhnq9bcfBGrA7XV6Vl2FNVbRNrrPF7nruhC2W81bzsZsIJmYjCuCeh2UMa4Jmp5gHftsDmkqH4oyowtfvajMca+JrYNvfwKsc0FOGUWJsa/+JDcyyFL06CQuIygVHd5+JMczO4gATulIgAJksEMopocbQXyKxltjbgI3a48o7Mugm3u1qIct733TA0/cUCbP1c1IM479hLyXAFWZXqQxFP1oAcBeWMoRSHF/rLtQDuY00JHnd/45k60kgsXCbIYvN50nadUIPeckWrenHU+2q+OLBPghBvlSou089hiHLSqAS2NMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NZZLwMhrq9e1E2n+3ugFj18kpVD0nbPNFZ/wqKGcW98=;
 b=C5SPNZ8TNdwERNbC/lt4hCjWAvWI77Uv3gHdmXRK0K8/SVZuPV3Ns6rfvREgffa9A9rXQ/BWRz98dCpER1i1e+GNO55zmk5cdF92tnkhuNV+Ut9wplFxYNZKLk7hMlzkV6RuyA5YHHCTf7Ns/ZimyzHHu+5FvZJHvl3XNcmRYAg=
Received: from BYAPR03MB4773.namprd03.prod.outlook.com (20.179.93.213) by
 BYAPR03MB3719.namprd03.prod.outlook.com (52.135.215.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.18; Wed, 4 Dec 2019 07:14:27 +0000
Received: from BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::708d:91cc:79a7:9b9a]) by BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::708d:91cc:79a7:9b9a%6]) with mapi id 15.20.2495.014; Wed, 4 Dec 2019
 07:14:27 +0000
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Jun Nie <jun.nie@linaro.org>
CC:     Christoph Hellwig <hch@infradead.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH 4/4] mmc: sdhci: Add DMA memory boundary workaround
Thread-Topic: [PATCH 4/4] mmc: sdhci: Add DMA memory boundary workaround
Thread-Index: AQHVqaxaSNy8xcyAyESfm+a1vx+I5KepfNAAgAAQ7oA=
Date:   Wed, 4 Dec 2019 07:14:26 +0000
Message-ID: <20191204150043.3a82cec0@xhacker.debian>
References: <20191202144104.5069-1-jun.nie@linaro.org>
        <20191202144104.5069-5-jun.nie@linaro.org>
        <20191202175202.GA6488@infradead.org>
        <CABymUCM09L3TfLsPhLWPkoYXJ6OVGhHvd9_o4FCO07_Z3Y6A8w@mail.gmail.com>
        <20191203073620.GA360@infradead.org>
        <CABymUCNHMKvVCkKdwnOcDZC9rNhLTEHLfLoH_O+CEf9XuZY+_A@mail.gmail.com>
In-Reply-To: <CABymUCNHMKvVCkKdwnOcDZC9rNhLTEHLfLoH_O+CEf9XuZY+_A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [124.74.246.114]
x-clientproxiedby: TY1PR01CA0137.jpnprd01.prod.outlook.com
 (2603:1096:402:1::13) To BYAPR03MB4773.namprd03.prod.outlook.com
 (2603:10b6:a03:139::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: beb70449-8e46-4cc2-e940-08d7788998bd
x-ms-traffictypediagnostic: BYAPR03MB3719:
x-microsoft-antispam-prvs: <BYAPR03MB37191D868B75E125FEB7B226ED5D0@BYAPR03MB3719.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0241D5F98C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(366004)(136003)(346002)(376002)(51914003)(189003)(199004)(6436002)(9686003)(2906002)(6246003)(54906003)(6486002)(6116002)(4326008)(102836004)(256004)(66946007)(76176011)(3846002)(6512007)(71190400001)(5660300002)(71200400001)(66446008)(64756008)(66556008)(66476007)(14444005)(52116002)(478600001)(50226002)(14454004)(316002)(6916009)(25786009)(186003)(99286004)(305945005)(386003)(7736002)(6506007)(8676002)(8936002)(81166006)(446003)(86362001)(11346002)(229853002)(81156014)(26005)(1076003)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR03MB3719;H:BYAPR03MB4773.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:0;
received-spf: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RdSOSuxO26N5bQ+I2vIBC2fTQ30uDimAnJAxoUevpu0WUnXn/fkMPVEr5Flx7PN42RryyPadgULBJhNfBBt410lSiMOe33X/ICurLuR5o3YNC0aw+TALER9udIsqURq++S9Y+Eusr/TsFf54dhsghDouBTa5MZ1sA0P6IcL0LlHqwvPG0F7Ur4JR9jkRV0UhY23IUn0xIgQcgKuR9VW7vJWFEFaxLLF7WUvPFCzTLvrx4IizfgWPSqQSUopSLs+uelRKO4xYJyBiuVCb2mevEv/bJp7rVJJmzx3Yn1YOaxXHeE2+RufS6OW6icNfFj9cglmKwWfAZu5q98h15Oa6gvrUNPfATAXmEeWDEB2vlZo+D1rh2j8vElQ3Tg6ebLvWxGEJu5w0cGNKERWW1vD6HGnlXh3NGCwmoP5QnXWE0sjisa5uPl6uLYy4PjGKkFEXbhCgKz4u3y3QgrOUCXYgV5YgrafvfNfBwmadoucXr9rUFXWeNT0K4JY3rW+NPsJQs/WdoAHveYAbC5TmgUCtFQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <7E3B034165B9FF49AB1FF3E93FFBF926@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: beb70449-8e46-4cc2-e940-08d7788998bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2019 07:14:26.8337
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2KBn26qtAfa/zMOpB/VhOCLT512uRptsSYQOUtI5mH6+R4js3qH5TTTJiysMpfighgfosNe+ln3XACjAOdTGJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB3719
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

T24gV2VkLCA0IERlYyAyMDE5IDE0OjAwOjA4ICswODAwIEp1biBOaWUgd3JvdGU6DQoNCj4gDQo+
IA0KPiBDaHJpc3RvcGggSGVsbHdpZyA8aGNoQGluZnJhZGVhZC5vcmc+IOS6jjIwMTnlubQxMuac
iDPml6Xlkajkuowg5LiL5Y2IMzozNuWGmemBk++8mg0KPiA+DQo+ID4gT24gVHVlLCBEZWMgMDMs
IDIwMTkgYXQgMTE6Mjk6MTVBTSArMDgwMCwgSnVuIE5pZSB3cm90ZTogIA0KPiA+ID4gVGhhbmtz
IGZvciB0aGUgcmVtaW5kZXIhIFNvIEkgbmVlZCB0byBwYXJzZSB0aGUgc2VnbWVudF9ib3VuZGFy
eSBmcm9tDQo+ID4gPiBkZXZpY2UgdHJlZSBhbmQgdXNlIGJlbG93IGNvZGUgdG8gc2V0IGl0LCBy
aWdodD8NCj4gPiA+IEZvciB0aGUgbWF4X3NlZ21lbnRzIGFjY291bnRpbmcgZXJyb3IsIEkgZGlk
IG5vdCBzZWUgaXQgc28gZmFyIHRob3VnaCBJDQo+ID4gPiBiZWxpZXZlIGl0IGlzIHRydWUgaW4g
dGhlb3J5LiBNYXliZSBpdCBpcyBkdWUgdG8gc2VnbWVudCBib3VuZGFyeSB2YWx1ZSBpcw0KPiA+
ID4gdmVyeSBsYXJnZS4NCj4gPiA+DQo+ID4gPiArKysgYi9kcml2ZXJzL21tYy9jb3JlL3F1ZXVl
LmMNCj4gPiA+IEBAIC0zNzQsNiArMzc0LDcgQEAgc3RhdGljIHZvaWQgbW1jX3NldHVwX3F1ZXVl
KHN0cnVjdCBtbWNfcXVldWUgKm1xLA0KPiA+ID4gc3RydWN0IG1tY19jYXJkICpjYXJkKQ0KPiA+
ID4gICAgICAgICAgICAgICAgIFdBUk4oIWJsa19xdWV1ZV9jYW5fdXNlX2RtYV9tYXBfbWVyZ2lu
ZyhtcS0+cXVldWUsDQo+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIG1tY19kZXYoaG9zdCkpLA0KPiA+ID4gICAgICAgICAgICAgICAg
ICAgICAgIm1lcmdpbmcgd2FzIGFkdmVydGlzZWQgYnV0IG5vdCBwb3NzaWJsZSIpOw0KPiA+ID4g
KyAgICAgICBibGtfcXVldWVfc2VnbWVudF9ib3VuZGFyeShtcS0+cXVldWUsIG1tYy0+c2VnbWVu
dF9ib3VuZGFyeSk7DQo+ID4gPiAgICAgICAgIGJsa19xdWV1ZV9tYXhfc2VnbWVudHMobXEtPnF1
ZXVlLCBtbWNfZ2V0X21heF9zZWdtZW50cyhob3N0KSk7ICANCj4gPg0KPiA+IFllcywgSSB0aGlu
ayBzaG91bGQgZG8gaXQuICBNYXliZSBtb2R1bG8gYSBjaGVjayBpZiB0aGUgbG93LWxldmVsDQo+
ID4gZHJpdmVyIGFjdHVhbGx5IHNldHMgYSBzZWdtZW50IGJvdW5kYXJ5LiAgDQo+IA0KPiBGb3Ig
dGhlIGJsb2NrIGRldmljZSwgc3VjaCBhcyBTRCBjYXJkLCBpdCBpcyByaWdodCBzb2x1dGlvbi4g
QnV0IEkNCj4gaGF2ZSBjb25jZXJuIG9uIFNESU8gY2FzZS4gTWF5YmUgd2Ugc2hvdWxkIGFkZCB3
b3JrYXJvdW5kIHRvZ2V0aGVyDQo+IHdpdGggYmxvY2sgbGF5ZXIgc2VnbWVudCBib3VuZGFyeSBy
ZXN0cmljdGlvbi4gSG93IGRvIHlvdSB0aGluayBhYm91dA0KPiBpdD8NCj4gDQoNCkFub3RoZXIg
dHJvdWJsZSBpcyBob3cgdG8gd29ya2Fyb3VuZCBpZiB0aGUgc2cgaXMgY29uc3RydWN0ZWQgYnkg
bW1jIGFuZA0Kbm8gYmxvY2sgbGF5ZXIgaW50ZXJhY3Rpb25zIGF0IGFsbC4gZS5nIF9fbW1jX2Js
a19pb2N0bF9jbWQoKSwgYW5kIGFsbA0KdGhvc2Ugc2dzIGluIG1tY190ZXN0LmMNCg0KVGhhbmtz
DQo=
