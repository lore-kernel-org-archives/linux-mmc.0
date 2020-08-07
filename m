Return-Path: <SRS0=OnGT=BR=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AF40C433E0
	for <linux-mmc@archiver.kernel.org>; Fri,  7 Aug 2020 01:50:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A820221E2
	for <linux-mmc@archiver.kernel.org>; Fri,  7 Aug 2020 01:50:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="dZNcVb/q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726013AbgHGBuK (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 6 Aug 2020 21:50:10 -0400
Received: from mail-eopbgr70075.outbound.protection.outlook.com ([40.107.7.75]:32210
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725998AbgHGBuK (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 6 Aug 2020 21:50:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ku/Q+UV4kvbjtLnqUTDlB8a85uV3q5gNHRWvjHccvwvBNck2WHpZUI0WZv9tCdKxEnWXtpCT1+gU8XpyX/BBMbsa2sbqiZNmMGshofqp3x6PI6UL0TfC9xNBeZbGGeEag+qnRRT/F21BNgppryKz86oFjUb7ppEymlKfX0nRvlTaBTOy/rRGod1iHMUODQX/J0hu07cOLEHOb9wNz+auW9rYN5fEPk3BWwHAUXw90vG8LSgTifHUYFPZwJ+O4NBFYbwAkE92SYVEw8OoPVYyDOAW/uOYk8s9Df/ntGf7qg4WAtwhUd1duNk8hRHbYbH+8gIEe6mqf/VqOpGpLItvpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KmvtF8WrIEykvRYy+TdtXffYsxB6OdhD0t9Mtban92M=;
 b=cxPShfZxebzRAy0dao+7kD1mbcg8ftKmx1lY+OlLoSKdpbPYodcueo2aIuFMu3NeLWDxMDZmRT+o6zrpmZEP3m9eD8JjdQt9PLjvxWih07P0XD1UY7++DWiHfLGMx6Jx090DbORiLppLValmCbfPI7JgioW95rOIsCD1rlkFn5GgLdRRLpE/2Ve7i+xCesfmvmMigb3qI+YMsubR9H1NAhA0/opFX4QL9aUh8EYzD/SHUYlT0Xme/BRu6ibDpuWuJQH1bo1u3retfT74/ntO8JllO0t2z2QGyq8iMqVStbhjDCMVTGPVe36bT5w5NJVq9MFC2+9DRLNCaMxzKdtO1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KmvtF8WrIEykvRYy+TdtXffYsxB6OdhD0t9Mtban92M=;
 b=dZNcVb/qWKHk3WiHrlL6u8wZP0QqMDmREM/WK29uYuldVNszTMDkl1V1tG+YSdQMmnvwf2ZPTXTscsp2ei6QWgGDluscIYYevGuGt7qAw8Alpfrdn5DXRflDLvchGOJbRM79Y/h/4ZR99QsTUH0oxlMLinSJuTHpl2k49ra4Exo=
Received: from VI1PR04MB5294.eurprd04.prod.outlook.com (2603:10a6:803:5a::22)
 by VI1PR04MB5503.eurprd04.prod.outlook.com (2603:10a6:803:d1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.15; Fri, 7 Aug
 2020 01:50:04 +0000
Received: from VI1PR04MB5294.eurprd04.prod.outlook.com
 ([fe80::6832:acd8:baa0:f094]) by VI1PR04MB5294.eurprd04.prod.outlook.com
 ([fe80::6832:acd8:baa0:f094%7]) with mapi id 15.20.3261.019; Fri, 7 Aug 2020
 01:50:04 +0000
From:   Bough Chen <haibo.chen@nxp.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>
Subject: RE: [PATCH] mmc: host: sdhci-esdhc-imx: reset usdhc before sending
 tuning command for manual tuning method
Thread-Topic: [PATCH] mmc: host: sdhci-esdhc-imx: reset usdhc before sending
 tuning command for manual tuning method
Thread-Index: AQHWa+grmES3Xq7XDU6TvTpO+ylxM6kq/YQAgADh0KA=
Date:   Fri, 7 Aug 2020 01:50:03 +0000
Message-ID: <VI1PR04MB52945822087D81437FA6CCC590490@VI1PR04MB5294.eurprd04.prod.outlook.com>
References: <1596714504-16313-1-git-send-email-haibo.chen@nxp.com>
 <d3e56b01-144b-17cf-d414-9e0d558b9bcc@intel.com>
In-Reply-To: <d3e56b01-144b-17cf-d414-9e0d558b9bcc@intel.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3712b4a2-a9d2-4147-0598-08d83a743460
x-ms-traffictypediagnostic: VI1PR04MB5503:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB550309E8CD377EE796CCFFE190490@VI1PR04MB5503.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UCQyOS01JjNMYlLQQ4F61b43i0UEP/c+Wk1XY7HfhkJX8AF0/FRKBq4jB5X82Q/hM/TIGEGZAG85v07slufUoIKLcG5MtvEGoQd2KfglMQOnwGQcJ7NxxlMu6b6u4ED75pl4yjl2qtCL92NJMtvwup/2rMrlvfW75QayZdLNNdL857chMB019akwsOWQYnOqCXZZKnPk3qUpIol0YWYwLzVCvBy56QF6ODa3tne0hl7uGITAe6nlwGp47QJib8vRPzPwnyvbMC+g4KCQrc1Pii5jtiYswsL8MzCk/X0OwRgXXWpW39B/Kke2Kprm7QBQTPuIfs6bQFawpWTpTzSLaw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5294.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(396003)(39860400002)(376002)(346002)(136003)(66556008)(33656002)(55016002)(9686003)(76116006)(66446008)(66946007)(4326008)(52536014)(5660300002)(64756008)(66476007)(7696005)(6506007)(83380400001)(8676002)(71200400001)(86362001)(8936002)(54906003)(53546011)(2906002)(478600001)(110136005)(316002)(26005)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: u1809CXOaQhVmHdILL1/WX2B4XRbJaQoCoe9dTqFSzoeRIFjaL5sRJvt+/THP6ki+yIg6CU1JDNRAYyfI/8S5huzAjBCJjU9bK2MVakRSqTybm+6I91QLhH9Zhjc6A5LgZ/TzccH/FOtH0K01Q8lncRZgZzgS0HDDZnbstBJKde58REf8/ZOI3Cephfz/gnFCpqoLGSLp85x9py7Wj/avsUUj3P3/olimp6BBvh9Zo4LPRFQeJSUe/6nhiZdUFZt0D5sXYKpol5TCOb+kDHzlANVEy7UoYzNZdmNG3LIm1PefZomVrZ6BQgRzvMnEpU0f+d+myvnQXAhlTd9dSenFNQnfRv2AJIxZ83Hrm/QLahqpo59Od4nH7vddm2nx1OThoCetqpmcuI+kGOQSF7+zzexD+scPmukQWZqWk2JwliHhAGerXU45Hvk2sKW8HZM9or+e8UViAs3GI79/5yfCbY8tpRFS7O60dzcN6GrPJpLKPWfypouFBpJsVpou6B6Kz6d5hFOCZ6m0KivCdtS4/Ja0aPDtnLRlOawiuQ+nbh2QtA5Jtk2dcpPnODN1Rgj9JUZXUuklbH+4CqACYnfZyBLlAkJmNOk6hfvC1B81LbpvCTMpJG0U2Me1/QbqT6rM7DplV1zrxdIBym+Frwzgw==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5294.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3712b4a2-a9d2-4147-0598-08d83a743460
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2020 01:50:04.0491
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NWtZDgGVLF+tHnwMCZawvBPTz8ZcCw+uPkSXPYt1dYnbPiy0Y24NCudXAF4HORkhpSU34u2/5HHOXLHwI5ATDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5503
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEFkcmlhbiBIdW50ZXIgW21h
aWx0bzphZHJpYW4uaHVudGVyQGludGVsLmNvbV0NCj4gU2VudDogMjAyMOW5tDjmnIg25pelIDIw
OjExDQo+IFRvOiBCb3VnaCBDaGVuIDxoYWliby5jaGVuQG54cC5jb20+OyB1bGYuaGFuc3NvbkBs
aW5hcm8ub3JnOw0KPiBsaW51eC1tbWNAdmdlci5rZXJuZWwub3JnDQo+IENjOiBkbC1saW51eC1p
bXggPGxpbnV4LWlteEBueHAuY29tPjsgc2hhd25ndW9Aa2VybmVsLm9yZzsNCj4gcy5oYXVlckBw
ZW5ndXRyb25peC5kZTsga2VybmVsQHBlbmd1dHJvbml4LmRlOyBmZXN0ZXZhbUBnbWFpbC5jb20N
Cj4gU3ViamVjdDogUmU6IFtQQVRDSF0gbW1jOiBob3N0OiBzZGhjaS1lc2RoYy1pbXg6IHJlc2V0
IHVzZGhjIGJlZm9yZSBzZW5kaW5nDQo+IHR1bmluZyBjb21tYW5kIGZvciBtYW51YWwgdHVuaW5n
IG1ldGhvZA0KPiANCj4gT24gNi8wOC8yMCAyOjQ4IHBtLCBoYWliby5jaGVuQG54cC5jb20gd3Jv
dGU6DQo+ID4gRnJvbTogSGFpYm8gQ2hlbiA8aGFpYm8uY2hlbkBueHAuY29tPg0KPiA+DQo+ID4g
QWNjb3JkaW5nIHRvIElDIHN1Z2dlc3Rpb24sIGV2ZXJ5dGltZSBiZWZvcmUgc2VuZGluZyB0aGUg
dHVuaW5nDQo+ID4gY29tbWFuZCwgbmVlZCB0byByZXNldCB0aGUgdXNkaGMsIHNvIHRvIHJlc2V0
IHRoZSB0dW5pbmcgY2lyY3VpdCwgdG8NCj4gPiBsZXQgZXZlcnkgdHVuaW5nIGNvbW1hbmQgd29y
ayB3ZWxsIGZvciB0aGUgbWFudWFsIHR1bmluZyBtZXRob2QuIEZvcg0KPiA+IHN0YW5kYXJkIHR1
bmluZyBtZXRob2QsIElDIGFscmVhZHkgYWRkIHRoZSByZXNldCBvcGVyYXRpb24gaW4gdGhlIGxv
Z2ljLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogSGFpYm8gQ2hlbiA8aGFpYm8uY2hlbkBueHAu
Y29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL21tYy9ob3N0L3NkaGNpLWVzZGhjLWlteC5jIHwg
MSArDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQ0KPiA+DQo+ID4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2ktZXNkaGMtaW14LmMNCj4gPiBiL2RyaXZlcnMv
bW1jL2hvc3Qvc2RoY2ktZXNkaGMtaW14LmMNCj4gPiBpbmRleCBhNzZiNDUxM2ZiZWMuLmU0Njk0
ZWIxYjkxNCAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL21tYy9ob3N0L3NkaGNpLWVzZGhjLWlt
eC5jDQo+ID4gKysrIGIvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1lc2RoYy1pbXguYw0KPiA+IEBA
IC05OTAsNiArOTkwLDcgQEAgc3RhdGljIHZvaWQgZXNkaGNfcHJlcGFyZV90dW5pbmcoc3RydWN0
IHNkaGNpX2hvc3QNCj4gPiAqaG9zdCwgdTMyIHZhbCkNCj4gPg0KPiA+ICAJLyogRklYTUU6IGRl
bGF5IGEgYml0IGZvciBjYXJkIHRvIGJlIHJlYWR5IGZvciBuZXh0IHR1bmluZyBkdWUgdG8gZXJy
b3JzICovDQo+ID4gIAltZGVsYXkoMSk7DQo+ID4gKwlzZGhjaV9yZXNldChob3N0LCBTREhDSV9S
RVNFVF9BTEwpOw0KPiANCj4gRG9lc24ndCB0aGF0IHJlc2V0IGFsbCByZWdpc3RlcnMgaS5lLiB0
aGUgZW50aXJlIGlvcyBzdGF0ZT8NCj4gDQoNCkhpIEFkcmlhbiwNCkZvciBpLk1YIHVzZGhjLCBS
RVNFVF9BTEwgb3BlcmF0aW9uIGRvIG5vdCBpbXBhY3QgYW55IHJlZ2lzdGVyIHZhbHVlLCBpdCBq
dXN0IHJlc2V0IHRoZSBpbnRlcm5hbCBsb2dpYyBzZXR0aW5nLiBJIGFscmVhZHkgdmVyaWZpZWQg
dGhhdC4NCkhlcmUgSSBqdXN0IHdhbnQgdG8gc2V0IHRoZSBTREhDSV9SRVNFVF9BTEwgYml0LCBi
dXQgSSBub3RpY2UgdGhhdCB0aGUgQVBJIHNkaGNpX3Jlc2V0KCkgd2lsbCBhbHNvIHRvdWNoIHRo
ZSBob3N0LT5jbG9jaywgc28gSSdtIG5vdCBzdXJlIHdoZXRoZXIgaXQgaXMgZ29vZCBlbm91Z2gg
dG8gdXNlIHRoaXMgQVBJIGRpcmVjdGx5LiBBbnkgc3VnZ2VzdGlvbj8gQXQgbGVhc3QsIGN1cnJl
bnQgcGF0Y2ggY2FuIGZpeCB0aGUgbWFudWFsIHR1bmluZyBpc3N1ZSBvbiBpbXg3ZC9pbXg4cXhw
Lg0KDQo+ID4NCj4gPiAgCXJlZyA9IHJlYWRsKGhvc3QtPmlvYWRkciArIEVTREhDX01JWF9DVFJM
KTsNCj4gPiAgCXJlZyB8PSBFU0RIQ19NSVhfQ1RSTF9FWEVfVFVORSB8IEVTREhDX01JWF9DVFJM
X1NNUENMS19TRUwgfA0KPiA+DQoNCg==
