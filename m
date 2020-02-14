Return-Path: <SRS0=Uv9M=4C=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0888C35242
	for <linux-mmc@archiver.kernel.org>; Fri, 14 Feb 2020 06:39:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA798222C2
	for <linux-mmc@archiver.kernel.org>; Fri, 14 Feb 2020 06:39:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="dzqR7OKj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725828AbgBNGjW (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 14 Feb 2020 01:39:22 -0500
Received: from mail-mw2nam12on2083.outbound.protection.outlook.com ([40.107.244.83]:32353
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725818AbgBNGjW (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 14 Feb 2020 01:39:22 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SLXE+SiU5HnDTNFgLQKzdeFvLqXwR1jphCzFODWwczlVCjJ6zV+8PTr90e1ntn/6esipmsvnWZ7NNN+zApI42RyGhCYgDB72olUxJm2JMmWOIEGXV9vcMGGptfn7PISbVuBoKw2OyBC0ZeaXxdwspQojteSWuFufrxSVU+Kjc3P/VQMgoiq6j2TAPF32x7cHTYUdU2RBE2c6k7UdenVq2JVpzxSzZEX41iIfvnCbEe9ZZ5dzRvnc8937c+WBbpw4kDiIAM5Gq7xrm6/eKRT5yUA70OWLk/L9s83F9Iy9Xqd3581XKNr9p3bg87xgLwJxhhkVlf2zGjsVPBJU648UDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SCOWw4kJR57tBvwIESJdXqxfccJf4YrL41v/u6y0dpc=;
 b=TuoEaCbZmmw3BEcJeeE0Wvej/ALOo9rY8VaX+emZhJaKKW3KUKg/I7+kjb8moF+oSQXH1AVMtYbMfHKwUL968UI/9gnQnAqDxFZGcgyHxBvyNnOSCbBKQ8sNaHTdYDrq7+S315bbZ8cmCF7j1xjqizzO4KX83Gkhr8eA9pO0EZRvbBVe000BwCfeaFnbO22smjUTjNpUwMQ7I4ed23Ebxhr3Ge+ah6t6EWIek20aHVzA2jvWW1nTi+zQIpHkok1Oog7sJz7pZwqBjDfY+65jkqfqVD10k8d6v2O87unfVszaI/nYWk+y3IlORNy23CbcFqWbqksx41oBtZETcZ9EdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SCOWw4kJR57tBvwIESJdXqxfccJf4YrL41v/u6y0dpc=;
 b=dzqR7OKj/03j84QNvjydr8QXO7s0IF9vFs/gDImLP3BK+UePx/opHUY+DmBmGcgrJOeDKKdgconspGrBEwJoMTOjP2kHzc/S5YPg6OeulFi6/Ky9OQt9383KgNWFCH/NXdcTbAhr78FBhdW+WtsQNvFUOYtiaV3z8H7lL0rVCiw=
Received: from DM6PR02MB4426.namprd02.prod.outlook.com (20.176.106.156) by
 DM6PR02MB4426.namprd02.prod.outlook.com (20.176.106.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.25; Fri, 14 Feb 2020 06:39:17 +0000
Received: from DM6PR02MB4426.namprd02.prod.outlook.com
 ([fe80::c084:a7d0:ee5d:4673]) by DM6PR02MB4426.namprd02.prod.outlook.com
 ([fe80::c084:a7d0:ee5d:4673%6]) with mapi id 15.20.2729.025; Fri, 14 Feb 2020
 06:39:17 +0000
From:   Manish Narani <MNARANI@xilinx.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     Michal Simek <michals@xilinx.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jolly Shah <JOLLYS@xilinx.com>, Rajan Vaja <RAJANV@xilinx.com>,
        Nava kishore Manne <navam@xilinx.com>,
        Tejas Patel <TEJASP@xilinx.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        git <git@xilinx.com>
Subject: RE: [PATCH 0/4] Enhancements and Bug Fixes in ZynqMP SDHCI
Thread-Topic: [PATCH 0/4] Enhancements and Bug Fixes in ZynqMP SDHCI
Thread-Index: AQHV0ES+oJkeVmCLSEim2Z6Yhdi7uagZSiIAgAEX+cA=
Date:   Fri, 14 Feb 2020 06:39:17 +0000
Message-ID: <DM6PR02MB4426401AE6322FBC2D12B849C1150@DM6PR02MB4426.namprd02.prod.outlook.com>
References: <1579602095-30060-1-git-send-email-manish.narani@xilinx.com>
 <CAPDyKFqS+9j++9RugFxNS4gKWuH_TpgbL-RXuudg92b-j_kvtQ@mail.gmail.com>
In-Reply-To: <CAPDyKFqS+9j++9RugFxNS4gKWuH_TpgbL-RXuudg92b-j_kvtQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=MNARANI@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d6b12b72-98a1-48b3-29d1-08d7b1189d64
x-ms-traffictypediagnostic: DM6PR02MB4426:|DM6PR02MB4426:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR02MB44264EDCF7B0DF444F1E6712C1150@DM6PR02MB4426.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 03137AC81E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(136003)(396003)(39860400002)(366004)(189003)(199004)(2906002)(316002)(54906003)(5660300002)(7696005)(52536014)(8676002)(8936002)(107886003)(81156014)(81166006)(55016002)(86362001)(33656002)(66446008)(71200400001)(66556008)(478600001)(64756008)(4326008)(9686003)(53546011)(66946007)(66476007)(76116006)(6916009)(26005)(6506007)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR02MB4426;H:DM6PR02MB4426.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rc0yEmt9YpVn9kcH7y6XbbH+nKcY8hyHkZHe7n4DfxJzzCNueo3Tusaj7KO4FeK1ls83xDXwmkdp2o+T945I/PKOnYwezZFJZUGVe7+Mt3gN2mhK4hbuks2iDt8toUsNwHinwYs8/2PPeMIGYXLV7U8cKX49lzrloeiXkKq3r4QBCfTKbVFTp3peOwKV94IvR89pbr29qWTFBCMtYCUIXqzL8yQKWnjgZtPb2Q41zdoxuET+jNApfsxt0520/wAQAXfa9GJmmOK7g3XML8p+YqwotnH8/sRH+CVmF4FvacBFRYbAvP5ewLP7ZBXrYwhRDSlFzTV6vKY7CG6HEhsokIWBI+Q0YnuCSkfoeJ3nL/JuuFSN1iOov92D8qe7d4Sj4MFQkw8WUvlanBDIegKWZ0kIbrTcfXKdsaG29xFJOdcMMzLWaw+ghdhY7DRQGeyz
x-ms-exchange-antispam-messagedata: h7eoWiHWnYA15A9E+E14ISfLwM2jyULsyQpfhAlwSTcW0QV6kRQF4pTuNqHIC2FaLIshZQjfLsr9/dd2O3bLqIOq0bMr/QjojoAaB1z3p9cqsOXqAn/4Hei3eCCHQqtmNeDQRteKaGhwPIu+t1i07Q==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6b12b72-98a1-48b3-29d1-08d7b1189d64
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2020 06:39:17.3469
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b1RsC6PaThaoR+J38O+oomXextg3zbqSVis8zqbqtP6vU+n5fM4QfaiVrx3gl63sT2lz6cpPkMMC6IUU6ZPjTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4426
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

SGkgVWZmZSwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBVbGYgSGFu
c3NvbiA8dWxmLmhhbnNzb25AbGluYXJvLm9yZz4NCj4gU2VudDogVGh1cnNkYXksIEZlYnJ1YXJ5
IDEzLCAyMDIwIDc6MjYgUE0NCj4gVG86IE1hbmlzaCBOYXJhbmkgPE1OQVJBTklAeGlsaW54LmNv
bT4NCj4gQ2M6IE1pY2hhbCBTaW1layA8bWljaGFsc0B4aWxpbnguY29tPjsgQWRyaWFuIEh1bnRl
cg0KPiA8YWRyaWFuLmh1bnRlckBpbnRlbC5jb20+OyBKb2xseSBTaGFoIDxKT0xMWVNAeGlsaW54
LmNvbT47IFJhamFuIFZhamENCj4gPFJBSkFOVkB4aWxpbnguY29tPjsgTmF2YSBraXNob3JlIE1h
bm5lIDxuYXZhbUB4aWxpbnguY29tPjsgVGVqYXMNCj4gUGF0ZWwgPFRFSkFTUEB4aWxpbnguY29t
PjsgTGludXggQVJNIDxsaW51eC1hcm0tDQo+IGtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnPjsg
TGludXggS2VybmVsIE1haWxpbmcgTGlzdCA8bGludXgtDQo+IGtlcm5lbEB2Z2VyLmtlcm5lbC5v
cmc+OyBsaW51eC1tbWNAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMC80
XSBFbmhhbmNlbWVudHMgYW5kIEJ1ZyBGaXhlcyBpbiBaeW5xTVAgU0RIQ0kNCj4gDQo+IE9uIFR1
ZSwgMjEgSmFuIDIwMjAgYXQgMTE6MjEsIE1hbmlzaCBOYXJhbmkgPG1hbmlzaC5uYXJhbmlAeGls
aW54LmNvbT4NCj4gd3JvdGU6DQo+ID4NCj4gPiBUaGlzIHBhdGNoIHNlcmllcyBpbmNsdWRlczoN
Cj4gPiAtPiBNYXJrIHRoZSBUYXAgRGVsYXkgTm9kZSBhcyB2YWxpZCBmb3IgaW9jdGwgY2FsbHMN
Cj4gPiAtPiBBZGQgc3VwcG9ydCBmb3IgRExMIHJlc2V0IGluIGZpcm13YXJlIGRyaXZlcg0KPiA+
IC0+IEFkZCBzdXBwb3J0IHRvIHJlc2V0IERMTCBmcm9tIEFyYXNhbiBTREhDSSBkcml2ZXIgZm9y
IFp5bnFNUCBwbGF0Zm9ybQ0KPiA+IC0+IEZpeCBpbmNvcnJlY3QgYmFzZSBjbG9jayByZXBvcnRp
bmcgaXNzdWUNCj4gPg0KPiA+IE1hbmlzaCBOYXJhbmkgKDQpOg0KPiA+ICAgZmlybXdhcmU6IHhp
bGlueDogQWRkIFp5bnFNUCBUYXAgRGVsYXkgc2V0dXAgaW9jdGwgdG8gdGhlIHZhbGlkIGxpc3QN
Cj4gPiAgIGZpcm13YXJlOiB4aWxpbng6IEFkZCBETEwgcmVzZXQgc3VwcG9ydA0KPiA+ICAgbW1j
OiBzZGhjaS1vZi1hcmFzYW46IEFkZCBzdXBwb3J0IGZvciBETEwgcmVzZXQgZm9yIFp5bnFNUCBw
bGF0Zm9ybXMNCj4gPiAgIHNkaGNpOiBhcmFzYW46IFJlbW92ZSBxdWlyayBmb3IgYnJva2VuIGJh
c2UgY2xvY2sNCj4gPg0KPiA+ICBkcml2ZXJzL2Zpcm13YXJlL3hpbGlueC96eW5xbXAuYyAgICAg
fCAgMiArDQo+ID4gIGRyaXZlcnMvbW1jL2hvc3Qvc2RoY2ktb2YtYXJhc2FuLmMgICB8IDU5DQo+
ICsrKysrKysrKysrKysrKysrKysrKysrKysrKy0NCj4gPiAgaW5jbHVkZS9saW51eC9maXJtd2Fy
ZS94bG54LXp5bnFtcC5oIHwgIDkgKysrKy0NCj4gPiAgMyBmaWxlcyBjaGFuZ2VkLCA2OCBpbnNl
cnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gLS0NCj4gPiAyLjE3LjENCj4gPg0K
PiANCj4gQXBwbGllZCBmb3IgbmV4dCwgdGhhbmtzIQ0KVGhhbmtzIGEgbG90IQ0KDQotIE1hbmlz
aA0K
