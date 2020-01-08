Return-Path: <SRS0=QNIT=25=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D72DC00523
	for <linux-mmc@archiver.kernel.org>; Wed,  8 Jan 2020 04:10:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C086F2070A
	for <linux-mmc@archiver.kernel.org>; Wed,  8 Jan 2020 04:10:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="kl+p+amn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726252AbgAHEKf (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 7 Jan 2020 23:10:35 -0500
Received: from mail-eopbgr80088.outbound.protection.outlook.com ([40.107.8.88]:28736
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726145AbgAHEKf (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 7 Jan 2020 23:10:35 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z4NHG8BaXQ5ooVVPFlXmlBGeh3o6uvzkGxiLU5n6jcEB6FUOJgMMfqT5QRrCeo/FquBsPTCJwF3PjNcRu8FfkinUZ3B9e7B17r9Cz3OAz2dlPom+7/Nx/WPVy4vmoCnImiRmNxfIRnnukH6cUSmGV0kNLyg36Ye5ZjESFG/1Z8WelgPF5VcK8s35g/bO0DbydJJ3jOcp58i338IsXrH40GIkEAAPd4qEqcsV0hBph1HIJfvKSkNr8ftlJW6qFDwkoZDmdUy75+fMSC5votku7dEqjdvwcsIH5mKYCoYWlmrfWMGTPEiXpe02iK953vTTQlJqynC5JCPM/BUD8048Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JKz3TttTAHad4RALOfYcRYvUvSlrs3DLkq57JegtreY=;
 b=N5udFvFT9jJNEzzXHrj98Cl8ZZ1eAudzBFbwmSAaexzFcO6Ca6L5zgoK4nkwB2eP8lxoXHtFszymksuQACeQRNUwnjVOjIwQd3NLeFXueOSRtIPvT1u8sXgR0QRMtEV1M4z0bOjpmXUeO9doHKsw2lZw+NIDPd94d4ug42ApHtU9GxvPR/y7oqq3erQXiKJjAPexYG8ThdeSRdOTSfMkJAoOS1ypKv/v/mkKFtU70meSH4ifcwhi4frkt3V7J7B/Z95idpPLAfHa3pZSecsnowHtsz3f2HTr3n5W7+ABxYzVR5ANgPXM0Q9DwONimZEwUrQ7Qy2xIwTrRw1sByHi3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JKz3TttTAHad4RALOfYcRYvUvSlrs3DLkq57JegtreY=;
 b=kl+p+amnTtm5lYkNiQGpAomfjJgnFhvMagZVA7Sy7NLvL2wrARazepe+JpqPl3JWCcPLzirRBsVWg3dIMfNHcxq0PzFV3z16eXH/8CiwoQprhCO/p2ZF24R0hWuAZ/rJoLhkHnMNZdfyvcJiqMMxdGcl1wHC8ayCpidXo6jO1Ko=
Received: from VI1PR04MB6896.eurprd04.prod.outlook.com (52.133.244.76) by
 VI1PR04MB7182.eurprd04.prod.outlook.com (10.186.156.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.10; Wed, 8 Jan 2020 04:10:29 +0000
Received: from VI1PR04MB6896.eurprd04.prod.outlook.com
 ([fe80::e0d7:8810:f110:3a60]) by VI1PR04MB6896.eurprd04.prod.outlook.com
 ([fe80::e0d7:8810:f110:3a60%3]) with mapi id 15.20.2602.016; Wed, 8 Jan 2020
 04:10:29 +0000
From:   "Y.b. Lu" <yangbo.lu@nxp.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: RE: [PATCH 1/2] mmc: sdhci-of-esdhc: fix esdhc_reset() for different
 controller versions
Thread-Topic: [PATCH 1/2] mmc: sdhci-of-esdhc: fix esdhc_reset() for different
 controller versions
Thread-Index: AQHVujYU/bUNhyj1yECFay4yskqIW6ffNhkAgAEIMrA=
Date:   Wed, 8 Jan 2020 04:10:29 +0000
Message-ID: <VI1PR04MB6896F82E70381FFA8DBA5E26F83E0@VI1PR04MB6896.eurprd04.prod.outlook.com>
References: <20191224084122.25381-1-yangbo.lu@nxp.com>
 <12d82268-4f94-41d3-e0e7-2a3ab8a6964f@intel.com>
In-Reply-To: <12d82268-4f94-41d3-e0e7-2a3ab8a6964f@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yangbo.lu@nxp.com; 
x-originating-ip: [92.121.36.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 868b6da7-2abd-41de-0f43-08d793f0b27d
x-ms-traffictypediagnostic: VI1PR04MB7182:
x-microsoft-antispam-prvs: <VI1PR04MB7182E7ECD1A067B5C62468D2F83E0@VI1PR04MB7182.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 02760F0D1C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(396003)(136003)(346002)(366004)(376002)(13464003)(199004)(189003)(53546011)(52536014)(6506007)(26005)(8936002)(7696005)(81166006)(81156014)(8676002)(5660300002)(478600001)(66446008)(2906002)(316002)(64756008)(66556008)(66476007)(66946007)(110136005)(186003)(9686003)(71200400001)(55016002)(76116006)(33656002)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB7182;H:VI1PR04MB6896.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8rf8dFteC05Y541Bld1Kivk+GGKGZ6E3PgU/ZDRvZSEXXUda1M+YxlU7/8cHDrubPQ5nvQf8P+mdncVbLSmtcqiqqXPmegmRRHognykzmeAnFBpa79wOLqGluOwOi1U/DeUtqxPXzpvrHGp+Suphekv3j+8+ND1NIycgo/v2nDW2qxugt0EMSYzUXCf0KhLdh3ju7W21hH1CEdt3bwViI8/2iK03aJ6+/uxyvw/LCx6mv+82EXRHdORCPHs2RAFqWVPEDvNkWyHxql/XQBn+Xxu+6kRCK3zq/8voGsT5AchO2EkzUoKDMyzLpRTkVPvFYGR91k+8RzlxcXAMbfqo0Sdr5QMIzt+6NIo0xkEJvGq8pyM+3cGWpC20z5/kPOgb/F7k1WgPdtPVEZDVRW1zpfICPtCLNM7U7kcIv5cP7m1YQ8wE8rZPmO436bd3vam91SO4udXJXzAy/YlVeLos5b9HMg7JTT0+oLlLFoRZ5XIpaNI0+ufHIzKnfY0KuHOH
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 868b6da7-2abd-41de-0f43-08d793f0b27d
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2020 04:10:29.1063
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gx3vRgcbYhQDmpyaaH0TtmRYZLKg6jbe0v0lZJsfR8tArzDZef2qVNMUuhcmagXY68jdSPB9AJJvtxFRP/sTVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7182
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBsaW51eC1tbWMtb3duZXJAdmdl
ci5rZXJuZWwub3JnIDxsaW51eC1tbWMtb3duZXJAdmdlci5rZXJuZWwub3JnPg0KPiBPbiBCZWhh
bGYgT2YgQWRyaWFuIEh1bnRlcg0KPiBTZW50OiBUdWVzZGF5LCBKYW51YXJ5IDcsIDIwMjAgODoy
MyBQTQ0KPiBUbzogWS5iLiBMdSA8eWFuZ2JvLmx1QG54cC5jb20+OyBsaW51eC1tbWNAdmdlci5r
ZXJuZWwub3JnOyBVbGYgSGFuc3Nvbg0KPiA8dWxmLmhhbnNzb25AbGluYXJvLm9yZz4NCj4gU3Vi
amVjdDogUmU6IFtQQVRDSCAxLzJdIG1tYzogc2RoY2ktb2YtZXNkaGM6IGZpeCBlc2RoY19yZXNl
dCgpIGZvciBkaWZmZXJlbnQNCj4gY29udHJvbGxlciB2ZXJzaW9ucw0KPiANCj4gT24gMjQvMTIv
MTkgMTA6NDEgYW0sIFlhbmdibyBMdSB3cm90ZToNCj4gPiBUaGlzIHBhdGNoIGlzIHRvIGZpeCBv
cGVyYXRpbmcgaW4gZXNkaGNfcmVzZXQoKSBmb3IgZGlmZmVyZW50DQo+ID4gY29udHJvbGxlciB2
ZXJzaW9ucywgYW5kIHRvIGFkZCBidXMtd2lkdGggcmVzdG9yaW5nIGFmdGVyIGRhdGENCj4gPiBy
ZXNldCBmb3IgZVNESEMgKHZlcmRvciB2ZXJzaW9uIDw9IDIuMikuDQo+ID4NCj4gPiBBbHNvIGFk
ZCBhbm5vdGF0aW9uIGZvciB1bmRlcnN0YW5kaW5nLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTog
WWFuZ2JvIEx1IDx5YW5nYm8ubHVAbnhwLmNvbT4NCj4gDQo+IE9uZSBtaW5vciBjb3NtZXRpYyBj
b21tZW50IGJlbG93LCBvdGhlcndpc2U6DQo+IA0KPiBBY2tlZC1ieTogQWRyaWFuIEh1bnRlciA8
YWRyaWFuLmh1bnRlckBpbnRlbC5jb20+DQo+IA0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL21tYy9o
b3N0L3NkaGNpLW9mLWVzZGhjLmMgfCAzOA0KPiArKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrLS0tLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMzQgaW5zZXJ0aW9ucygrKSwgNCBkZWxl
dGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL21tYy9ob3N0L3NkaGNpLW9m
LWVzZGhjLmMNCj4gYi9kcml2ZXJzL21tYy9ob3N0L3NkaGNpLW9mLWVzZGhjLmMNCj4gPiBpbmRl
eCBjZDNiNjc2Li41MDJlMzE3IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvbW1jL2hvc3Qvc2Ro
Y2ktb2YtZXNkaGMuYw0KPiA+ICsrKyBiL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2ktb2YtZXNkaGMu
Yw0KPiA+IEBAIC03NTgsMjMgKzc1OCw1MyBAQCBzdGF0aWMgdm9pZCBlc2RoY19yZXNldChzdHJ1
Y3Qgc2RoY2lfaG9zdCAqaG9zdCwNCj4gdTggbWFzaykNCj4gPiAgew0KPiA+ICAJc3RydWN0IHNk
aGNpX3BsdGZtX2hvc3QgKnBsdGZtX2hvc3QgPSBzZGhjaV9wcml2KGhvc3QpOw0KPiA+ICAJc3Ry
dWN0IHNkaGNpX2VzZGhjICplc2RoYyA9IHNkaGNpX3BsdGZtX3ByaXYocGx0Zm1faG9zdCk7DQo+
ID4gLQl1MzIgdmFsOw0KPiA+ICsJdTMyIHZhbCwgYnVzX3dpZHRoID0gMDsNCj4gPg0KPiA+ICsJ
LyogQWRkIGRlbGF5IHRvIG1ha2Ugc3VyZSBhbGwgdGhlIERNQSB0cmFuc2ZlcnMgYXJlIGZpbmlz
aGVkDQo+ID4gKwkgKiBmb3IgcXVpcmsuDQo+ID4gKwkgKi8NCj4gDQo+IHNkaGNpLW9mLWVzZGhj
LmMgc2VlbXMgdG8gaGF2ZSBhIG1peCBvZiBtdWx0aS1saW5lIGNvbW1lbnQgc3R5bGVzLg0KPiBU
aGUgcHJlZmVycmVkIHN0eWxlIGlzIGRvY3VtZW50ZWQgaW4gRG9jdW1lbnRhdGlvbi9wcm9jZXNz
L2NvZGluZy1zdHlsZS5yc3QNCg0KVGhhbmtzIEFkcmlhbi4NCllvdSBhcmUgcmlnaHQuIEkgd2Fz
IHVzaW5nIHByZWZlcnJlZCBjb21tZW50IHN0eWxlIGZvciBuZXQvLg0KSSBzZW50IG91dCB2MiB0
byBmaXggdGhlIGNvbW1lbnRzLg0KDQotIFlhbmdibyBMdQ0KDQo+IA0KPiA+ICAJaWYgKGVzZGhj
LT5xdWlya19kZWxheV9iZWZvcmVfZGF0YV9yZXNldCAmJg0KPiA+ICAJICAgIChtYXNrICYgU0RI
Q0lfUkVTRVRfREFUQSkgJiYNCj4gPiAgCSAgICAoaG9zdC0+ZmxhZ3MgJiBTREhDSV9SRVFfVVNF
X0RNQSkpDQo+ID4gIAkJbWRlbGF5KDUpOw0KPiA+DQo+ID4gKwkvKiBTYXZlIGJ1cy13aWR0aCBm
b3IgZVNESEMgd2hvc2UgdmVuZG9yIHZlcnNpb24gaXMgMi4yDQo+ID4gKwkgKiBvciBsb3dlciBm
b3IgZGF0YSByZXNldC4NCj4gPiArCSAqLw0KPiA+ICsJaWYgKChtYXNrICYgU0RIQ0lfUkVTRVRf
REFUQSkgJiYNCj4gPiArCSAgICAoZXNkaGMtPnZlbmRvcl92ZXIgPD0gVkVORE9SX1ZfMjIpKSB7
DQo+ID4gKwkJdmFsID0gc2RoY2lfcmVhZGwoaG9zdCwgRVNESENfUFJPQ1RMKTsNCj4gPiArCQli
dXNfd2lkdGggPSB2YWwgJiBFU0RIQ19DVFJMX0JVU1dJRFRIX01BU0s7DQo+ID4gKwl9DQo+ID4g
Kw0KPiA+ICAJc2RoY2lfcmVzZXQoaG9zdCwgbWFzayk7DQo+ID4NCj4gPiAtCXNkaGNpX3dyaXRl
bChob3N0LCBob3N0LT5pZXIsIFNESENJX0lOVF9FTkFCTEUpOw0KPiA+IC0Jc2RoY2lfd3JpdGVs
KGhvc3QsIGhvc3QtPmllciwgU0RIQ0lfU0lHTkFMX0VOQUJMRSk7DQo+ID4gKwkvKiBSZXN0b3Jl
IGJ1cy13aWR0aCBzZXR0aW5nIGFuZCBpbnRlcnJ1cHQgcmVnaXN0ZXJzIGZvciBlU0RIQw0KPiA+
ICsJICogd2hvc2UgdmVuZG9yIHZlcnNpb24gaXMgMi4yIG9yIGxvd2VyIGZvciBkYXRhIHJlc2V0
Lg0KPiA+ICsJICovDQo+ID4gKwlpZiAoKG1hc2sgJiBTREhDSV9SRVNFVF9EQVRBKSAmJg0KPiA+
ICsJICAgIChlc2RoYy0+dmVuZG9yX3ZlciA8PSBWRU5ET1JfVl8yMikpIHsNCj4gPiArCQl2YWwg
PSBzZGhjaV9yZWFkbChob3N0LCBFU0RIQ19QUk9DVEwpOw0KPiA+ICsJCXZhbCAmPSB+RVNESENf
Q1RSTF9CVVNXSURUSF9NQVNLOw0KPiA+ICsJCXZhbCB8PSBidXNfd2lkdGg7DQo+ID4gKwkJc2Ro
Y2lfd3JpdGVsKGhvc3QsIHZhbCwgRVNESENfUFJPQ1RMKTsNCj4gPiArDQo+ID4gKwkJc2RoY2lf
d3JpdGVsKGhvc3QsIGhvc3QtPmllciwgU0RIQ0lfSU5UX0VOQUJMRSk7DQo+ID4gKwkJc2RoY2lf
d3JpdGVsKGhvc3QsIGhvc3QtPmllciwgU0RIQ0lfU0lHTkFMX0VOQUJMRSk7DQo+ID4gKwl9DQo+
ID4NCj4gPiAtCWlmIChtYXNrICYgU0RIQ0lfUkVTRVRfQUxMKSB7DQo+ID4gKwkvKiBTb21lIGJp
dHMgaGF2ZSB0byBiZSBjbGVhbmVkIG1hbnVhbGx5IGZvciBlU0RIQyB3aG9zZSBzcGVjDQo+ID4g
KwkgKiB2ZXJzaW9uIGlzIGhpZ2hlciB0aGFuIDMuMCBmb3IgYWxsIHJlc2V0Lg0KPiA+ICsJICov
DQo+ID4gKwlpZiAoKG1hc2sgJiBTREhDSV9SRVNFVF9BTEwpICYmDQo+ID4gKwkgICAgKGVzZGhj
LT5zcGVjX3ZlciA+PSBTREhDSV9TUEVDXzMwMCkpIHsNCj4gPiAgCQl2YWwgPSBzZGhjaV9yZWFk
bChob3N0LCBFU0RIQ19UQkNUTCk7DQo+ID4gIAkJdmFsICY9IH5FU0RIQ19UQl9FTjsNCj4gPiAg
CQlzZGhjaV93cml0ZWwoaG9zdCwgdmFsLCBFU0RIQ19UQkNUTCk7DQo+ID4NCj4gPiArCQkvKiBJ
bml0aWFsaXplIGVTREhDX0RMTENGRzFbRExMX1BEX1BVTFNFX1NUUkVUQ0hfU0VMXSB0bw0KPiA+
ICsJCSAqIDAgZm9yIHF1aXJrLg0KPiA+ICsJCSAqLw0KPiA+ICAJCWlmIChlc2RoYy0+cXVpcmtf
dW5yZWxpYWJsZV9wdWxzZV9kZXRlY3Rpb24pIHsNCj4gPiAgCQkJdmFsID0gc2RoY2lfcmVhZGwo
aG9zdCwgRVNESENfRExMQ0ZHMSk7DQo+ID4gIAkJCXZhbCAmPSB+RVNESENfRExMX1BEX1BVTFNF
X1NUUkVUQ0hfU0VMOw0KPiA+DQoNCg==
