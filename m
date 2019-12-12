Return-Path: <SRS0=OcmH=2C=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D666C43603
	for <linux-mmc@archiver.kernel.org>; Thu, 12 Dec 2019 13:43:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D28C82173E
	for <linux-mmc@archiver.kernel.org>; Thu, 12 Dec 2019 13:43:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="lOH/txUv";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="QGuGFsny"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729504AbfLLNnI (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 12 Dec 2019 08:43:08 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:9392 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729465AbfLLNnI (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 12 Dec 2019 08:43:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1576158187; x=1607694187;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9FTeHfklWZ248ZT4r7bpBZVS9PX+3xronEiOThs0FKc=;
  b=lOH/txUvOtbiKXFEcwUHeihPn5sJJEgZcac7YBxvAu2vYSTzTg4eostS
   u9b+xoXNtzQXl5YkhEG9SXOwRdapGuZCVH7VJs21TGZrdEJn864GIzoaW
   MsUD2YWFHS1U1EG8lhRc0BCCJWBR0hhY3/5Ahe0Sa9k0U29N4GkAwJYTg
   YYe4wvmcf1C2WXh37AC04+of+Tf0KAoaTjBkdZrqSy8Qimd5sFUIeUOZy
   LoBeu0fp8TuniBYSZ4vYMtGleeBKV8NItr3J31fqdfsgpjlXyCW/FVSuG
   PWO9XFsdVProAudTJrxNC+AfgJhAAz3UClb69hCOe7xywht37RXAAe4NH
   w==;
IronPort-SDR: HtO/6l5ZVZkuzVosViHZNAP9qiUOScIOEwaG5S5r9wpFCs7JOKkVMqd23ju7iFP8erm/tKmHVn
 DIJCsfzf7paOAWD43dbuW78RyEeBs2juOleqJwVTFJSconHU+kdilB3mEeDn7ASSCJAKWrcfco
 p7nwDfjSwCoSSwx3oMwdzAzjlpis9M2y/jFpnOXFajMHoGvbz6bLMwC+3VPWJZ6b/5cyiKPWBn
 90mcO/NXxjBL02VOcqh+D4gJ7h/DNg8ij/C0JwS+1Vj8f3LAw0tGrfJbIk75+SMK2iAU4hRyeU
 78A=
X-IronPort-AV: E=Sophos;i="5.69,306,1571673600"; 
   d="scan'208";a="126804894"
Received: from mail-bn7nam10lp2109.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.109])
  by ob1.hgst.iphmx.com with ESMTP; 12 Dec 2019 21:43:06 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h2JIoBtdzW1hoa7BxP/Oyu50mwcny9DfunST5fbWWiAljVaFGAhQDxzkAGYZf94Tpd+GkKRB/ZSc6iuYCKcoo/1rzemy7THpJYWR5JFHXZ72Mmqnns5SP4IIw28hMWYThE0SL81p8P2juDOLukUcwvasNWCnu7iTm93sVrMOmRCkohS+qWJ3bK08N2BdHz9BVTE/U2xWffxflsIa+JiVhaz3CFq/ws4zUl2+nJ30SgseDTlm3sm3zcEDHS2egEUQ/mtGE1DMfHV2qu2mDBYWSHHKrmiu+Hi/bjebt0Z84YMW26XZTYTlDM3Y99cGLfC9hK2K1FpRvRNLuzEB4m51Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9FTeHfklWZ248ZT4r7bpBZVS9PX+3xronEiOThs0FKc=;
 b=Kvk4GSkYail+hFlQmMoshokg2Tub7/r+pk/jFY5Locxy6ze28yXIU0c01KHLD3qy7vQtHecxgBpeZ9z6If0leaTetB+JZJF9virX8BxEI5WN5fTLNc6rh45scAW0mOWGzC8jFbfn3JRbYl4ZHzMPRO1oyKzOVPa1vmgAgdHD+cAMnHl8zmHzWJflah09ReXsEeUjzsiXPylkfSWYJqrQ4aB/tIm8t4DLqCk89+Tljf/smRemVI//4yCjoCm2tU8rEbPle1TWbqVngwZ9hZ/cIPvnr9ZacG0soUig9rTb7xl9qUFH5UuzxdGq2fU1wxcDMjgIA7+qYnfjJ/M7NRYrNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9FTeHfklWZ248ZT4r7bpBZVS9PX+3xronEiOThs0FKc=;
 b=QGuGFsnynEQqyiDxAmVw0524Pk13LHZUE53EprKBO7PS4HCKBLPYvm8ycHiyYSJsljr5qpFiBSBLvmQYmqpqNG2cDo0L5QlYfSQ4NKXmgRWTT4CLXga7XCGTSmCuYDsOahinT5SmsI+hf+2Ovgv3ibfUoPwvnbQgKsPZ5S0h2Bc=
Received: from MN2PR04MB6991.namprd04.prod.outlook.com (10.186.144.209) by
 MN2PR04MB5965.namprd04.prod.outlook.com (20.178.246.82) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.15; Thu, 12 Dec 2019 13:43:04 +0000
Received: from MN2PR04MB6991.namprd04.prod.outlook.com
 ([fe80::9447:fa71:53df:f866]) by MN2PR04MB6991.namprd04.prod.outlook.com
 ([fe80::9447:fa71:53df:f866%3]) with mapi id 15.20.2538.012; Thu, 12 Dec 2019
 13:43:04 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Kimito Sakata <kimito.sakata@oracle.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
CC:     "chrisball@gmail.com" <chrisball@gmail.com>,
        Nachi Nachiappan <nachi.nachiappan@oracle.com>
Subject: RE: mmc-utils changes for Erase commands.
Thread-Topic: mmc-utils changes for Erase commands.
Thread-Index: AQHVr6ygu2u8dDhm1Uq+yiQGAMZbi6e2hCcA
Date:   Thu, 12 Dec 2019 13:43:04 +0000
Message-ID: <MN2PR04MB69914177DD63B9DB59EDDFE7FC550@MN2PR04MB6991.namprd04.prod.outlook.com>
References: <702f7830-5477-8024-4716-240e263375be@oracle.com>
In-Reply-To: <702f7830-5477-8024-4716-240e263375be@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Avri.Altman@wdc.com; 
x-originating-ip: [212.25.79.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7e41606c-5caf-485f-51cc-08d77f0936c6
x-ms-traffictypediagnostic: MN2PR04MB5965:
x-microsoft-antispam-prvs: <MN2PR04MB5965442501D8B8ACAA4CA3EAFC550@MN2PR04MB5965.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0249EFCB0B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(39860400002)(366004)(376002)(136003)(396003)(189003)(199004)(9686003)(76116006)(66946007)(66476007)(6506007)(52536014)(66446008)(26005)(186003)(66556008)(64756008)(86362001)(7696005)(110136005)(54906003)(71200400001)(5660300002)(316002)(478600001)(55016002)(81166006)(2906002)(8676002)(81156014)(8936002)(4326008)(33656002);DIR:OUT;SFP:1102;SCL:1;SRVR:MN2PR04MB5965;H:MN2PR04MB6991.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CfELd02TR1dZY3sH7RD7yKFfmvvEtnnWQPvpAjxuzcjDgJP8pthqBs21jRaRWRKvl0NApvq6oCVc8XIT0srbtua7J1kCXZc/hg3C+KFSQDdI0MbsLjREcliluUI0dJz8JU3qg9Qye7syMqVIlO0+Qo+GbEevaUtaKrjyrrGTdrPUurturwO34fcxfUet3AZf5keDHLK6HaEJ7N0ITGvcnALKT++OkTD/LL01bHNUJr13asYqMBsBrbQ7aiiYi8icyQgedjfF3xsg4+NHGYjdTTM7zx+7oyhfrMTvNJK9/od+iJ86gb+5qaEWPyVeg1yDzsxiIBoUjIm//Lk1Ugxq80vXu5U7UilbLk2fkQZMHORO0hn5GSYSqfK64NL0lFPFQaZoMIuJcTur3oWt1rqXNJ5Sk0SwtqWnmxlU4KVzwL7A2UJkda5SV0lkfpZYVIm5
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e41606c-5caf-485f-51cc-08d77f0936c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2019 13:43:04.5140
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F1JSzeYCetesJGmOI3A+0sarj0YiXyUaEzY4ZdWhWMNkx+QRVBAYYukTKZbcqS/C19DnhpceeGzuQyIUdAu+GQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB5965
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

UGxlYXNlIHNlbmQgeW91ciBwYXRjaCBpbiB0aGUgYXBwcm9wcmlhdGUgZm9ybWF0LA0KU28gaXQg
Y2FuIGJlIHJldmlld2VkLg0KDQpUaGFua3MsDQpBdnJpDQoNCj4gDQo+IA0KPiBtbWMuaA0KPiAz
NmEzNyw0NQ0KPiAgPiAjZGVmaW5lIE1NQ19FUkFTRV9HUk9VUF9TVEFSVCAgIDM1ICAgIC8qIGFj
ICAgWzMxOjBdIGRhdGEgYWRkciAgIFIxICAqLw0KPiAgPiAjZGVmaW5lIE1NQ19FUkFTRV9HUk9V
UF9FTkQgICAgIDM2ICAgIC8qIGFjICAgWzMxOjBdIGRhdGEgYWRkciAgIFIxICAqLw0KPiAgPiAj
ZGVmaW5lIE1NQ19FUkFTRSAgICAgICAgICAgICAgIDM4ICAgIC8qIGFjICAgWzMxXSBTZWN1cmUg
cmVxdWVzdA0KPiAgPsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFszMDoxNl0g
c2V0IHRvIDAgID7CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBbMTVdIEZvcmNl
DQo+IEdhcmJhZ2UgQ29sbGVjdCByZXF1ZXN0NCAgPsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIFsxNDoyXSBzZXQgdG8gMA0KPiA+wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgWzFdIERpc2NhcmQgRW5hYmxlICA+wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgWzBdDQo+IElkZW50aWZ5IFdyaXRlIEJsb2NrcyBmb3IgRXJhc2UgKG9yIFRSSU0g
RW5hYmxlKSAgPiBSMWIgKi8NCj4gDQo+IG1tY19jbWRzLmgNCj4gMzNhMzQNCj4gID4gaW50IGRv
X2VyYXNlKGludCBuYXJncywgY2hhciAqKmFyZ3YpOw0KPiANCj4gbW1jX2NtZHMuYw0KPiAyMjZh
MjI3LDI5MQ0KPiAgPiBpbnQgZXJhc2UoaW50IGZkLCBfX3UzMiBhcmdpbiwgX191MzIgc3RhcnQs
IF9fdTMyIGVuZCkgID4geyAgPsKgwqDCoMKgwqDCoMKgwqAgaW50IHJldCA9IDA7DQo+ICA+ICAg
ICBzdHJ1Y3QgbW1jX2lvY19jbWQgaWRhdGE7DQo+ICA+ICAgICBfX3UzMiAgcmVzcG9uc2U7DQo+
ICA+DQo+ICA+ICAgICAvLyBTZXQgU3RhcnQgYWRkcmVzcw0KPiAgPiAgICAgbWVtc2V0KCZpZGF0
YSwgMCwgc2l6ZW9mKGlkYXRhKSk7DQo+ICA+ICAgICBpZGF0YS5vcGNvZGUgPSBNTUNfRVJBU0Vf
R1JPVVBfU1RBUlQ7DQo+ICA+ICAgICBpZGF0YS5hcmcgPSBzdGFydDsNCj4gID4gICAgIGlkYXRh
LmZsYWdzID0gTU1DX1JTUF9SMSB8IE1NQ19DTURfQUM7DQo+ICA+ICAgICByZXQgPSBpb2N0bChm
ZCwgTU1DX0lPQ19DTUQsICZpZGF0YSk7DQo+ICA+ICAgICBpZiAocmV0KSAgew0KPiAgPiAgICAg
ICBwZXJyb3IoImlvY3RsIik7DQo+ICA+ICAgICAgIHByaW50ZigiRXJhc2UgR3JvdXAgU3RhcnQg
QWRkcmVzcyBjb21tYW5kIGZhaWxlZFxuIik7DQo+ICA+ICAgICAgIHJldHVybiByZXQ7DQo+ICA+
ICAgICB9DQo+ICA+ICAgICByZXQgPSBzZW5kX3N0YXR1cyhmZCwgJnJlc3BvbnNlKTsNCj4gID4g
ICAgIGlmIChyZXNwb25zZSAmIDB4RkZGOTAwQzApIHsNCj4gID4gICAgICAgcHJpbnRmKCJDTUQx
MyByZXR1cm5zOiAweCUwOHggZHVyaW5nIENNRDM1XG4iLCByZXNwb25zZSk7DQo+ICA+ICAgICB9
DQo+ICA+DQo+ICA+ICAgICAvLyBTZXQgZW5kIGFkZHJlc3MNCj4gID4gICAgIG1lbXNldCgmaWRh
dGEsIDAsIHNpemVvZihpZGF0YSkpOw0KPiAgPiAgICAgaWRhdGEub3Bjb2RlID0gTU1DX0VSQVNF
X0dST1VQX0VORDsNCj4gID4gICAgIGlkYXRhLmFyZyA9IGVuZDsNCj4gID4gICAgIGlkYXRhLmZs
YWdzID0gTU1DX1JTUF9SMSB8IE1NQ19DTURfQUM7DQo+ICA+ICAgICByZXQgPSBpb2N0bChmZCwg
TU1DX0lPQ19DTUQsICZpZGF0YSk7DQo+ICA+ICAgICBpZiAocmV0KSB7DQo+ICA+ICAgICAgIHBl
cnJvcigiaW9jdGwiKTsNCj4gID4gICAgICAgcHJpbnRmKCJFcmFzZSBHcm91cCBFbmQgQWRkcmVz
cyBjb21tYW5kIGZhaWxlZFxuIik7DQo+ICA+ICAgICAgIHJldHVybiByZXQ7DQo+ICA+ICAgICB9
DQo+ICA+ICAgICByZXQgPSBzZW5kX3N0YXR1cyhmZCwgJnJlc3BvbnNlKTsNCj4gID4gICAgIGlm
IChyZXNwb25zZSAmIDB4RkZGOTAwQzApDQo+ICA+ICAgICAgIHByaW50ZigiQ01EMTMgcmV0dXJu
czogMHglMDh4IGR1cmluZyBDTUQzNlxuIiwgcmVzcG9uc2UpOw0KPiAgPg0KPiAgPiAgICAgLy8g
U2VuZCBFcmFzZSBDb21tYW5kDQo+ICA+ICAgICBtZW1zZXQoJmlkYXRhLCAwLCBzaXplb2YoaWRh
dGEpKTsNCj4gID4gICAgIGlkYXRhLm9wY29kZSA9IE1NQ19FUkFTRTsNCj4gID4gICAgIGlkYXRh
LmFyZyA9IGFyZ2luOw0KPiAgPiAgICAgaWRhdGEuY21kX3RpbWVvdXRfbXMgPSA2MDAwMDsNCj4g
ID4gICAgIGlkYXRhLmRhdGFfdGltZW91dF9ucyA9IDYwMDAwMDAwOw0KPiAgPiAgICAgaWRhdGEu
ZmxhZ3MgPSBNTUNfUlNQX1IxQiB8IE1NQ19DTURfQUM7DQo+ICA+ICAgICByZXQgPSBpb2N0bChm
ZCwgTU1DX0lPQ19DTUQsICZpZGF0YSk7DQo+ICA+ICAgICBpZiAocmV0KSAgew0KPiAgPiAgICAg
ICBwZXJyb3IoImlvY3RsIik7DQo+ICA+ICAgICAgIHByaW50ZigiRXJhc2UgY29tbWFuZCBmYWls
ZWRcbiIpOw0KPiAgPiAgICAgICByZXR1cm4gcmV0Ow0KPiAgPiAgICAgfQ0KPiAgPg0KPiAgPiAg
ICAgLy8gU2VuZCBTdGF0dXMgQ29tbWFuZA0KPiAgPiAgICAgLy8gMTA5OCA3NjU0IDMyMTAgOTg3
NiA1NDMyIDEwOTggNzY1NCAzMjEwDQo+ICA+ICAgICAvLyAzMzIyIDIyMjIgMjIyMiAxMTExIDEx
MTEgMTEwMCAwMDAwIDAwMDANCj4gID4gICAgIC8vIDExMTEgMTExMSAxMTExIDF4eDEgeHh4eCB4
eHh4IDExeHggeHh4eCAgRGV2aWNlIFN0YXR1cyBFcnJvciBiaXRzDQo+ICA+ICAgICAvLyBGICAg
IEYgICAgRiAgICA5ICAgIDAgICAgMCAgICBDICAgIDAgICAgIDB4RkZGOTAwQzANCj4gID4gICAg
IHJldCA9IHNlbmRfc3RhdHVzKGZkLCAmcmVzcG9uc2UpOw0KPiAgPiAgICAgaWYgKHJlc3BvbnNl
ICYgMHhGRkY5MDBDMCkNCj4gID4gICAgICAgcHJpbnRmKCJDTUQxMyByZXR1cm5zOiAweCUwOHgg
ZHVyaW5nIENNRDM4XG4iLCByZXNwb25zZSk7DQo+ICA+ICAgICBpZiAocmV0KQ0KPiAgPiAgICAg
ICBwcmludGYoIlNlbmQgU3RhdHVzIENvbW1hbmQgcmV0dXJuZWQgMHglMDhYXG4iLCByZXNwb25z
ZSk7DQo+ICA+DQo+ICA+ICAgICByZXR1cm4gcmV0Ow0KPiAgPiB9DQo+ICA+DQo+IDExNTBhMTIx
Ng0KPiAgPg0KPiAxODQyYTE5MDksMTk4NQ0KPiAgPg0KPiAgPg0KPiAgPg0KPiAgPiBpbnQgZG9f
ZXJhc2UoaW50IG5hcmdzLCBjaGFyICoqYXJndikNCj4gID4gew0KPiAgPiAgICAgaW50IGZkLCBy
ZXQ7DQo+ICA+ICAgICBjaGFyICpkZXZpY2U7DQo+ICA+ICAgICBjaGFyICoqZXB0cj1OVUxMOw0K
PiAgPiAgICAgX191MzIgIGFyZ2luLCBzdGFydCwgZW5kOw0KPiAgPg0KPiAgPg0KPiAgPiAgICAg
aWYgKG5hcmdzICE9IDUpIHsNCj4gID4gICAgICAgICBmcHJpbnRmKHN0ZGVyciwgIlVzYWdlOiBt
bWMgZXJhc2UgPGFyZz4gPHN0YXJ0IGFkZHJlc3M+IDxlbmQNCj4gYWRkcmVzcz4gPC9wYXRoL3Rv
L21tY2Jsa1g+XG4iKTsNCj4gID4gICAgICAgICBleGl0KDEpOw0KPiAgPiAgICAgfQ0KPiAgPg0K
PiAgPiAgICAgaWYgKChhcmd2WzFdWzBdID09ICcwJykgJiYgKGFyZ3ZbMV1bMV0gPT0gJ3gnKSkN
Cj4gID4gICAgICAgYXJnaW4gPSBzdHJ0b2woYXJndlsxXSwgZXB0ciwgMTYpOw0KPiAgPiAgICAg
ZWxzZQ0KPiAgPiAgICAgICBhcmdpbiA9IHN0cnRvbChhcmd2WzFdLCBlcHRyLCAxMCk7DQo+ICA+
ICAgICBpZiAoKGFyZ3ZbMl1bMF0gPT0gJzAnKSAmJiAoYXJndlsyXVsxXSA9PSAneCcpKQ0KPiAg
PiAgICAgICBzdGFydCA9IHN0cnRvbChhcmd2WzJdLCBlcHRyLCAxNik7DQo+ICA+ICAgICBlbHNl
DQo+ICA+ICAgICAgIHN0YXJ0ID0gc3RydG9sKGFyZ3ZbMl0sIGVwdHIsIDEwKTsNCj4gID4gICAg
IGlmICgoYXJndlszXVswXSA9PSAnMCcpICYmIChhcmd2WzNdWzFdID09ICd4JykpDQo+ICA+ICAg
ICAgIGVuZCAgID0gc3RydG9sKGFyZ3ZbM10sIGVwdHIsIDE2KTsNCj4gID4gICAgIGVsc2UNCj4g
ID4gICAgICAgZW5kICAgPSBzdHJ0b2woYXJndlszXSwgZXB0ciwgMTApOw0KPiAgPiAgICAgZGV2
aWNlID0gYXJndls0XTsNCj4gID4NCj4gID4gICAgIGZkID0gb3BlbihkZXZpY2UsIE9fUkRXUik7
DQo+ICA+ICAgICBpZiAoZmQgPCAwKSB7DQo+ICA+ICAgICAgICAgcGVycm9yKCJvcGVuIik7DQo+
ICA+ICAgICAgICAgZXhpdCgxKTsNCj4gID4gICAgIH0NCj4gID4NCj4gID4gICAgIHByaW50Zigi
RXhlY3V0aW5nICgweCUwOFgpOiAiLCBhcmdpbik7DQo+ICA+ICAgICBzd2l0Y2goYXJnaW4pICB7
DQo+ICA+ICAgICBjYXNlIDB4MDAwMDAwMDA6DQo+ICA+ICAgICAgIHByaW50ZigiRXJhc2UgIik7
DQo+ICA+ICAgICAgIGJyZWFrOw0KPiAgPiAgICAgY2FzZSAweDAwMDAwMDAzOg0KPiAgPiAgICAg
ICBwcmludGYoIkRpc2NhcmQgIik7DQo+ICA+ICAgICAgIGJyZWFrOw0KPiAgPiAgICAgY2FzZSAw
eDgwMDAwMDAwOg0KPiAgPiAgICAgICBwcmludGYoIlNlY3VyZSBFcmFzZSAiKTsNCj4gID4gICAg
ICAgYnJlYWs7DQo+ICA+ICAgICBjYXNlIDB4ODAwMDgwMDA6DQo+ICA+ICAgICAgIHByaW50Zigi
U2VjdXJlIFRyaW0gU3RlcCAyICIpOw0KPiAgPiAgICAgICBicmVhazsNCj4gID4gICAgIGNhc2Ug
MHg4MDAwMDAwMToNCj4gID4gICAgICAgcHJpbnRmKCJTZWN1cmUgVHJpbSBTdGVwIDEgIik7DQo+
ICA+ICAgICAgIGJyZWFrOw0KPiAgPiAgICAgY2FzZSAweDAwMDAwMDAxOg0KPiAgPiAgICAgICBw
cmludGYoIlRyaW0gIik7DQo+ICA+ICAgICAgIGJyZWFrOw0KPiAgPiAgICAgZGVmYXVsdDoNCj4g
ID4gICAgICAgcHJpbnRmKCJVbmtub3duIEFyZ3VtZW50ICIpOw0KPiAgPiAgICAgfQ0KPiAgPiAg
ICAgcHJpbnRmKCJGcm9tOjB4JTA4WCBUbzoweCUwOFhcbiIsIHN0YXJ0LCBlbmQpOw0KPiAgPg0K
PiAgPiAgICAgcmV0ID0gZXJhc2UoZmQsIGFyZ2luLCBzdGFydCwgZW5kKTsNCj4gID4gICAgIGlm
IChyZXQpIHsNCj4gID4gICAgICAgICBmcHJpbnRmKHN0ZGVyciwgIkVycm9yIGluIEVyYXNlIENv
bW1hbmQgdG8gJXMgd2l0aCBBcmc9MHglMDhYDQo+IFN0YXJ0PTB4JTA4WCBFbmQ9MHglMDhYXG4i
LA0KPiAgPiAgICAgICAgICAgICBkZXZpY2UsDQo+ICA+ICAgICAgICAgICAgIGFyZ2luLA0KPiAg
PiAgICAgICAgICAgICBzdGFydCwNCj4gID4gICAgICAgICAgICAgZW5kKTsNCj4gID4gICAgICAg
ICBleGl0KDEpOw0KPiAgPiAgICAgfQ0KPiAgPg0KPiAgPiAgICAgcmV0dXJuIHJldDsNCj4gID4N
Cj4gID4gfQ0KPiAgPg0KPiAgPg0KPiAgPg0KPiANCj4gbW1jLmMNCj4gMjljMjkNCj4gPCAjZGVm
aW5lIE1NQ19WRVJTSU9OICAgICIwLjEiDQo+IC0tLQ0KPiAgPiAjZGVmaW5lIE1NQ19WRVJTSU9O
ICAgICIwLjFfS1MiDQo+IDEzNWExMzYsMTQwDQo+ICA+ICAgICAgIE5VTEwNCj4gID4gICAgIH0s
DQo+ICA+ICAgICB7IGRvX2VyYXNlLCAtNCwNCj4gID4gICAgICAgImVyYXNlIiwgIjxhcmc+ICIg
IjxzdGFydCBhZGRyZXNzPiAiICI8ZW5kIGFkZHJlc3M+ICIgIjxkZXZpY2U+XG4iDQo+ICA+ICAg
ICAgICAgIlNlbmQgRXJhc2UgY29tbWFuZCB0byB0aGUgPGRldmljZT4uXG5UaGlzIHdpbGwgZGVs
ZXRlIGFsbA0KPiB1c2VyIGRhdGEgaW4gdGhlIHNwZWNpZmllZCByZWdpb24gb2YgdGhlIGRldmlj
ZS4iLA0KPiANCj4gDQoNCg==
