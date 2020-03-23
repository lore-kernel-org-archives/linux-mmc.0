Return-Path: <SRS0=kaON=5I=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B919C54FD3
	for <linux-mmc@archiver.kernel.org>; Mon, 23 Mar 2020 20:24:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1056420753
	for <linux-mmc@archiver.kernel.org>; Mon, 23 Mar 2020 20:24:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="Z6QViM6p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727589AbgCWUX4 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 23 Mar 2020 16:23:56 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:43361 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727585AbgCWUX4 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 23 Mar 2020 16:23:56 -0400
IronPort-SDR: Mo/+0g6otTA08coDniAXKRG+93NmujylJh+THmCnYb4GRIB7d+ISaYeKJYMqVEZ8f8+UCgSh3K
 nJhkCcKuyuKDO5S5UH71nGpI8jHzb+nk8NFeoLkliLFHXBSwliL84VszjyWyBifMiGAp2yUB5x
 Jsi25IT719KqA0RSvJTPHX+pYYIN/htALH0yCPxgWfPh5/iFiSX2cJryUMwDpAF6sxkC5ud4Ll
 +EnOKcvoeYxNECs8osYUjfCR/Wxfjb6m7smKIDpQg5pQLsYLGhF7Yf3E+XP8IQ6EYHizWUOrqj
 MhI=
X-IronPort-AV: E=Sophos;i="5.72,297,1580799600"; 
   d="scan'208";a="73163869"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 Mar 2020 13:23:55 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 23 Mar 2020 13:23:55 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Mon, 23 Mar 2020 13:23:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lAY6VEsCeEnoYfdk+IM7INjKcSo9NMikbhl8PyAE0Kqdx9z91VT57mjQ35tBhrbtgQEMIs/f+Ouskm1zMYG8Ym8RYmWl0nQ0hc4nKht+Ncr7/lopfY/0NCYttAzlOkS7iYw19NijGjIxdHeAAa7rOY83Kl6iAGwoyjtrn+9cAydyOMT893IC5M5T2oazN1otryJmMr/yLTXRnLuC8MNDlNoEvkocYcmr9obvBVCy9cM9xyQSSJLcIjJFs2aEE0qOW3aFgpZk7qDKvyzhE5uuEjqX92/gB0theHDjRHewvPfpykngc37iAKxb74xlX/QOAxjtLH44LLwyR31V+BbluA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dZ2gNxs+86vOVeafta+VPnsE1sYt1XeZMeX4rDDk3ZE=;
 b=axiMK3BtiOmB7MQVlqFQluT59H/LDxacexttAZyeHEF9enPbkdZ/2oY3mgeLwc2pxf0qoIXXD/aDrgA5MwNUdn18wlsODVBq1AXkBTYKW+LLvRqZIjMRlI5FYxDdrqsizFVOKPe1YK7WG3RUyC8RszvQwl7qnb3GLH5V4WI1fjdFWjD8mVDw/q8ualvUe/d4BELeHlbas3KbRqKwB0WOxknp4lxS9PTeSSk5iZCUsw7zGVUw/TeOgDZGwNLkkDsDzfzswbhQdcCKnV2RraqZW9apv+jJFlVMneQQxXnP7pMEdpeRrWcLv9v7j0H5wrxPAtrdWN3QGocQLpctbYC9mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dZ2gNxs+86vOVeafta+VPnsE1sYt1XeZMeX4rDDk3ZE=;
 b=Z6QViM6pOISwCDSLB8gWoGl1PFb2R1xcBeq05/59vV7+qrZdZwyIWKQCgWY2NBOVFZMe/n2ny4n1fFFo6CDSG0ZOWaMwvZ0PWYrbnlMCw15WEwGPqpHaNjwzSu94YlgZb4VGGpiqbZfVIYdFaz4XJ1pr2UGwAeBNAIBLX8/9ybc=
Received: from BY5PR11MB3895.namprd11.prod.outlook.com (2603:10b6:a03:18e::21)
 by BY5PR11MB4133.namprd11.prod.outlook.com (2603:10b6:a03:18f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.15; Mon, 23 Mar
 2020 20:23:51 +0000
Received: from BY5PR11MB3895.namprd11.prod.outlook.com
 ([fe80::c09b:2e03:b941:13c5]) by BY5PR11MB3895.namprd11.prod.outlook.com
 ([fe80::c09b:2e03:b941:13c5%5]) with mapi id 15.20.2835.021; Mon, 23 Mar 2020
 20:23:51 +0000
From:   <Ludovic.Desroches@microchip.com>
To:     <mirq-linux@rere.qmqm.pl>, <ulf.hansson@linaro.org>,
        <adrian.hunter@intel.com>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>
CC:     <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mmc: sdhci-of-at91: fix cd-gpios for SAMA5D2
Thread-Topic: [PATCH] mmc: sdhci-of-at91: fix cd-gpios for SAMA5D2
Thread-Index: AQHV+ukG6vq+Dh/nIkKVG4ZfW2cXeqhWrCcA
Date:   Mon, 23 Mar 2020 20:23:51 +0000
Message-ID: <635a5f5f-fb52-d9ef-a905-3e09ee1f4f18@microchip.com>
References: <8d10950d9940468577daef4772b82a071b204716.1584290561.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <8d10950d9940468577daef4772b82a071b204716.1584290561.git.mirq-linux@rere.qmqm.pl>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ludovic.Desroches@microchip.com; 
x-originating-ip: [92.150.97.227]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7aef27e0-8aa2-432a-3af5-08d7cf681a0a
x-ms-traffictypediagnostic: BY5PR11MB4133:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR11MB4133162FBCD22FE5EC76C379EFF00@BY5PR11MB4133.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:1468;
x-forefront-prvs: 0351D213B3
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(376002)(396003)(136003)(39860400002)(199004)(76116006)(36756003)(81156014)(81166006)(54906003)(8676002)(110136005)(6486002)(6506007)(316002)(31696002)(6512007)(4326008)(86362001)(31686004)(186003)(64756008)(26005)(5660300002)(8936002)(66946007)(66476007)(71200400001)(66574012)(2616005)(66556008)(478600001)(66446008)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:BY5PR11MB4133;H:BY5PR11MB3895.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5Gx54myA7kilgOFdZdkhU/4tkPugiKeBmST47XMpj3/bZWKlk0CzKoDJbhjXoH67n4IfJV1iiRXdRPbYQFjGCayjd1zLPoURJsMeL9Wy687aNFKJEnlDA2wlc62EiBKIozdrSgy+sAQqWe7Trfp+WLwhKB+dddQ1ZeVPSpWCBOwA/52c88qG2n+ujzTppQaFcH8i1UVB054eJI556LTupwhW7t6vopZlVdQCK2oca0M39TVAFrryeothqnkS+loTC8EPPnuXj+PmY67DuVs2J9CS1gDcoPYv62bCuNeaYhs6tNI/Q7lrLW/s6Q6p9Ndfy3Dc48XwMU4sA2IvZQ30RKGO5XBBq9U4tzjDE90l68+0S3b6Rir3hcyojhui3TG24Gs/SmCVpYjG+pey1iHSCDyoay2z2h3bPFNiAzpd0fqWc8OeJwMpDtudmKjmcDW5
x-ms-exchange-antispam-messagedata: +aJ478Xhn73toxHLML3dlAxUhqpZv963XNfb/nqBzSi4WFZsN5BRqVVm7nVAtW+rf+9WxJrbalwrg3tsKcN8sn3MJzSOR21nQxIs0KglMt+FTu7MAGfl+PRlJuvJqTOQzcAha7iPIBjOeR8rfWzfDw==
Content-Type: text/plain; charset="utf-8"
Content-ID: <00725C1259ABA94F9CED032BB20314D8@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 7aef27e0-8aa2-432a-3af5-08d7cf681a0a
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2020 20:23:51.4462
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UBBHZHkjB25LpswcOgAYMv+ktTy57dUY4XA06i3Qmc0DTIw6tPDca9NPs99Tbk56GK6cAKfJg1RcEgi4/ZwxXkVr2RhQwN7P4E+d98rMRFM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4133
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

SGksDQoNCg0KT24gMy8xNS8yMDIwIDU6NDQgUE0sIE1pY2hhxYIgTWlyb3PFgmF3IHdyb3RlDQo+
IFNBTUE1RDJ4IGRvZXNuJ3QgZHJpdmUgQ01EIGxpbmUgaWYgR1BJTyBpcyB1c2VkIGFzIENEIGxp
bmUgKGF0IGxlYXN0DQo+IFNBTUE1RDI3IGRvZXNuJ3QpLiBGaXggdGhpcyBieSBmb3JjaW5nIGNh
cmQtZGV0ZWN0IGluIHRoZSBtb2R1bGUNCj4gaWYgbW9kdWxlLWNvbnRyb2xsZWQgQ0QgaXMgbm90
IHVzZWQuDQo+DQo+IEZpeGVkIGNvbW1pdCBhZGRyZXNzZXMgdGhlIHByb2JsZW0gb25seSBmb3Ig
bm9uLXJlbW92YWJsZSBjYXJkcy4gVGhpcw0KPiBhbWVuZHMgaXQgdG8gYWxzbyBjb3ZlciBncGlv
LWNkIGNhc2UuDQo+DQo+IENjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnDQo+IEZpeGVzOiA3YTFl
M2YxNDMxNzYgKCJtbWM6IHNkaGNpLW9mLWF0OTE6IGZvcmNlIGNhcmQgZGV0ZWN0IHZhbHVlIGZv
ciBub24gcmVtb3ZhYmxlIGRldmljZXMiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBNaWNoYcWCIE1pcm9z
xYJhdyA8bWlycS1saW51eEByZXJlLnFtcW0ucGw+DQoNCkV2ZW4gaWYgaXQncyB0b28gbGF0ZSwg
SSBhZ3JlZSB3aXRoIHRoaXMgcGF0Y2guIFRoYW5rcywgSSBkaWRuJ3QgZXhwZWN0IA0Kc29tZW9u
ZSB3aWxsIHVzZSBhIEdQSU8gQ0QgaW5zdGVhZCBvZiB0aGUNCg0Kb25lIG9mIHRoZSBjb250cm9s
bGVyIHNvIHRoaXMgY2FzZSB3YXMgbWlzc2luZy4NCg0KSW4gZmFjdCwgdGhlIHdob2xlIFNBTUE1
RDIgZmFtaWx5IGlzIGNvbmNlcm5lZCBkZXBlbmRpbmcgb24gdGhlIHJldmlzaW9uIA0Kb2YgdGhl
IFNvQy4gRnJvbSB0aGUgdG9wIG9mIG15IGhlYWQsDQoNCmZvciByZXYgQSwgaWYgdGhlIHBpbiBp
cyBtdXhlZCB0byBhbm90aGVyIGZ1bmN0aW9uIHRoYW4gdGhlIFNETU1DIA0KY29udHJvbGxlciwg
dGhlIGRlZmF1bHQgdmFsdWUgaXMgY2FyZCBwcmVzZW50Lg0KDQpGb3IgcmV2IEIgYW5kIGxhdGVy
LCB0aGUgZGVmYXVsdCB2YWx1ZSBpcyBubyBjYXJkIHByZXNlbnQsIHRoYXQncyB3aHkgDQp0aGUg
Q01EIGxpbmUgaXMgbm90IGRyaXZlbi4NCg0KUmVnYXJkcw0KDQpMdWRvdmljDQoNCg0KPiAtLS0N
Cj4gICBkcml2ZXJzL21tYy9ob3N0L3NkaGNpLW9mLWF0OTEuYyB8IDggKysrKysrLS0NCj4gICAx
IGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPg0KPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1vZi1hdDkxLmMgYi9kcml2ZXJzL21tYy9o
b3N0L3NkaGNpLW9mLWF0OTEuYw0KPiBpbmRleCBkOTBmNGVkMTgyODMuLjhmOGRhMmZlNDhhOSAx
MDA2NDQNCj4gLS0tIGEvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1vZi1hdDkxLmMNCj4gKysrIGIv
ZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1vZi1hdDkxLmMNCj4gQEAgLTE4NSw3ICsxODUsOCBAQCBz
dGF0aWMgdm9pZCBzZGhjaV9hdDkxX3Jlc2V0KHN0cnVjdCBzZGhjaV9ob3N0ICpob3N0LCB1OCBt
YXNrKQ0KPg0KPiAgICAgICAgICBzZGhjaV9yZXNldChob3N0LCBtYXNrKTsNCj4NCj4gLSAgICAg
ICBpZiAoaG9zdC0+bW1jLT5jYXBzICYgTU1DX0NBUF9OT05SRU1PVkFCTEUpDQo+ICsgICAgICAg
aWYgKChob3N0LT5tbWMtPmNhcHMgJiBNTUNfQ0FQX05PTlJFTU9WQUJMRSkNCj4gKyAgICAgICAg
ICAgfHwgbW1jX2dwaW9fZ2V0X2NkKGhvc3QtPm1tYykgPj0gMCkNCj4gICAgICAgICAgICAgICAg
ICBzZGhjaV9hdDkxX3NldF9mb3JjZV9jYXJkX2RldGVjdChob3N0KTsNCj4NCj4gICAgICAgICAg
aWYgKHByaXYtPmNhbF9hbHdheXNfb24gJiYgKG1hc2sgJiBTREhDSV9SRVNFVF9BTEwpKQ0KPiBA
QCAtNDg3LDggKzQ4OCwxMSBAQCBzdGF0aWMgaW50IHNkaGNpX2F0OTFfcHJvYmUoc3RydWN0IHBs
YXRmb3JtX2RldmljZSAqcGRldikNCj4gICAgICAgICAgICogZGV0ZWN0aW9uIHByb2NlZHVyZSB1
c2luZyB0aGUgU0RNQ0NfQ0Qgc2lnbmFsIGlzIGJ5cGFzc2VkLg0KPiAgICAgICAgICAgKiBUaGlz
IGJpdCBpcyByZXNldCB3aGVuIGEgc29mdHdhcmUgcmVzZXQgZm9yIGFsbCBjb21tYW5kIGlzIHBl
cmZvcm1lZA0KPiAgICAgICAgICAgKiBzbyB3ZSBuZWVkIHRvIGltcGxlbWVudCBvdXIgb3duIHJl
c2V0IGZ1bmN0aW9uIHRvIHNldCBiYWNrIHRoaXMgYml0Lg0KPiArICAgICAgICAqDQo+ICsgICAg
ICAgICogV0E6IFNBTUE1RDIgZG9lc24ndCBkcml2ZSBDTUQgaWYgdXNpbmcgQ0QgR1BJTyBsaW5l
Lg0KPiAgICAgICAgICAgKi8NCj4gLSAgICAgICBpZiAoaG9zdC0+bW1jLT5jYXBzICYgTU1DX0NB
UF9OT05SRU1PVkFCTEUpDQo+ICsgICAgICAgaWYgKChob3N0LT5tbWMtPmNhcHMgJiBNTUNfQ0FQ
X05PTlJFTU9WQUJMRSkNCj4gKyAgICAgICAgICAgfHwgbW1jX2dwaW9fZ2V0X2NkKGhvc3QtPm1t
YykgPj0gMCkNCj4gICAgICAgICAgICAgICAgICBzZGhjaV9hdDkxX3NldF9mb3JjZV9jYXJkX2Rl
dGVjdChob3N0KTsNCj4NCj4gICAgICAgICAgcG1fcnVudGltZV9wdXRfYXV0b3N1c3BlbmQoJnBk
ZXYtPmRldik7DQo+IC0tDQo+IDIuMjAuMQ0KPg0KDQo=
