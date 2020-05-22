Return-Path: <SRS0=PvXF=7E=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=CHARSET_FARAWAY_HEADER,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CB5EC433E0
	for <linux-mmc@archiver.kernel.org>; Fri, 22 May 2020 07:23:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15E2420679
	for <linux-mmc@archiver.kernel.org>; Fri, 22 May 2020 07:23:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=oppoglobal.onmicrosoft.com header.i=@oppoglobal.onmicrosoft.com header.b="GXv7qr5V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727839AbgEVHXj (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 22 May 2020 03:23:39 -0400
Received: from mail-eopbgr1300059.outbound.protection.outlook.com ([40.107.130.59]:50548
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726578AbgEVHXj (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 22 May 2020 03:23:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ILQHF8MUXPeyUk1l9OcHc7B0ujvhLNT2hrAc6xLIeIkQT5vVBb2a6F/9Y9/u425hHJJ+zkDeWbhssRsqCdTROp9FemfusMVniMM1cuS4glz6a9LkRrlXi1OPfclZzRDub982GvW1cqftuBdhciHh5JyCLQ1nnt1JuJlKActUiD3P/EX8q1xd8mO0Lp/YrkIMtU4Br7YvPcU6ppEL1aHm3chYv1IQODY3eUCy5SC9HdbJNTQSs07ZgthXydqA8SWufbSUaEGrf+WwGAvEaQkJn3Vgj4ou2uMKGIYRWM7MeQuuDLoq5XKeVyj0RiZ+qa2+7t7BYFK8sPrBJw/AWk44kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1oaVGyXXV5fgNl37qn24YvCeQuNsCHRZrlow3Xsa4eY=;
 b=BxXLrlt91If3SMrjJt7yCKsd5YAd21nvMUh422qKg6I2rgnjocNcB40p/0diLfrDEG9wOMXsM9gYazyUppunVEApJkIPg6AFZjW8JvGC5sZgQR0t2b1WYF2JSpZ50OW4wdTZ7G7jV6XYxZrVA2XV9FspbWzeibKhs7HlmMf/b6lUr1mokbfy1Ti0BrjKQz9qnreNOxpYYeIp8rf5AzQbe46XM8pz6+ioaTeEclWw/tCPC7uv1KJqyWHwzM8PvpNUVuak8huMcVQqrmzZHYwMRM07uVxic86tvP7RIa83xzvd4vMYReKDLtjBXfLR3DxTPGPKbmMSp1akoR2bVk26xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oppoglobal.onmicrosoft.com; s=selector1-oppoglobal-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1oaVGyXXV5fgNl37qn24YvCeQuNsCHRZrlow3Xsa4eY=;
 b=GXv7qr5VG+1w7t5IeK2ZRXGpd80dOob2S/QGXipjGN3MO0doJyM1Uq4KyYAckdWcYxrrs9m7vjiqaNVM0knk/vUMyGKGrDdXQpZiBF7cBj93SdtqTQzTfweKe+UwrqSzlTNH5uzfV64uMZapZ5dqghVyMHaaQQpjQmf6lyCVXX0=
Received: from HKAPR02MB4291.apcprd02.prod.outlook.com (2603:1096:203:d3::12)
 by HKAPR02MB4387.apcprd02.prod.outlook.com (2603:1096:203:c6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.27; Fri, 22 May
 2020 07:23:34 +0000
Received: from HKAPR02MB4291.apcprd02.prod.outlook.com
 ([fe80::80ca:c698:988e:a999]) by HKAPR02MB4291.apcprd02.prod.outlook.com
 ([fe80::80ca:c698:988e:a999%5]) with mapi id 15.20.3021.020; Fri, 22 May 2020
 07:23:34 +0000
From:   =?gb2312?B?xe26xihSaWNoYXJkKQ==?= <richard.peng@oppo.com>
To:     "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "chaotian.jing@mediatek.com" <chaotian.jing@mediatek.com>
CC:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] mmc: fix use after free issue
Thread-Topic: [PATCH] mmc: fix use after free issue
Thread-Index: AdYwCdPnAxrcnE/hRe2xUa+RJjTwRA==
Date:   Fri, 22 May 2020 07:23:34 +0000
Message-ID: <HKAPR02MB429186300C2D9252A1D145BFE0B40@HKAPR02MB4291.apcprd02.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=oppo.com;
x-originating-ip: [58.255.79.102]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 23c416d4-5bce-4d8f-d0c0-08d7fe210997
x-ms-traffictypediagnostic: HKAPR02MB4387:
x-microsoft-antispam-prvs: <HKAPR02MB4387AE038CD79A7C63965F97E0B40@HKAPR02MB4387.apcprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:207;
x-forefront-prvs: 04111BAC64
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lZPmZhQo2M6aGzAx+8LTjbsk6u0Uc1ZAz4j+YZlqXxDPwtQwkZTj2pGIwT4vgxVjFTmOaeSgEbglpczdQnGe77l3aWdr0r4jdQXSjkj80+Hz3PQ3YnrEGs9FdYwzfLDbNVbS/2fdBAteCkXIk9C8q8EfGtKnlNgdb6I7CXoyDPFTh2JXZNHnIE02B+0En8iX+mJK+JG4fTrljgTv5vuLHhgj2K3OGMS3R3b41X2FTg61+Axp1bF3gXYTHhXRl+dqhYBfWDLv2qsi6aDdopYXGfCN1t0Ym5obEv4iiJ8jw8k451Gg5ijuLUwyWQ2tgpyAYmTX3jbcsLDcNTJzQEORJCvoumH91GxiGnlpEoJzUd0CLATIZqweq5liXEPaFRtE
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HKAPR02MB4291.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(136003)(376002)(366004)(346002)(39860400002)(396003)(76116006)(64756008)(71200400001)(66446008)(66476007)(2906002)(66946007)(66556008)(186003)(26005)(4326008)(52536014)(6506007)(85182001)(54906003)(55016002)(316002)(9686003)(7696005)(110136005)(5660300002)(33656002)(86362001)(478600001)(8936002)(8676002)(11606004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: MRvw+qLe2UtGiQHleD/yIonWMDPS4VHM+VAtmyyM3xWj8SNDk8UonI6250n3Y1wDkMwbXAA2VS7Y8W70XYpP2vvYDw4zPlda0WkypPKyw5DscTOcKP9yM+esdSbpnlGd5JUvSdumkuEWEL/HEeVH7YwQ+Y6w7lpv7n/a2FM1PdtasgbzVaVxX3LHvkPJNDEzGIbaM2PIvv4N5JbmbysxttMnWo027gJ0MxpPzUe8Ja4o/dJEnDw+OK9xAaLVkPiSmFil/XHPwig/QRhB3CZZyTQ0hrdIPGI2sn3m1jpVrg+M9nrRZSoC3UWC3y57iyQ5YMFPOYbjTXDCQgG9jIpyTwX9wtekiyQoKe/OZs9MzGKp6Le9tQlXZ5RD4NmTlycsAFTBkmYK6OgkxMT3/WhsZVikFOwa9mJMeWgsvcGbv0GX8lom0+3rTBHWQ64gUH7OEfU12LfDWBencUN+oP/gOLJnFRirgx0uCtBNdU7Djrg=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23c416d4-5bce-4d8f-d0c0-08d7fe210997
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2020 07:23:34.2692
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ha/1Z6lJpQz7wUIZ6N4OfO9JxFcRl0A8ttdc91laWVcCN9BHVmnI6hsXfKmLouG/ho6K6+i3Y9P71dPSg1ELBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HKAPR02MB4387
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

VGhpcyBpcyBjYXVzZWQgYnkgZGVyZWZlcmVuY2luZyAncnBtYicgYWZ0ZXIgcHV0X2RldmljZSgp
Lg0KDQpTaWduZWQtb2ZmLWJ5OiBQZW5nIEhhbyA8cmljaGFyZC5wZW5nQG9wcG8uY29tPg0KLS0t
DQogZHJpdmVycy9tbWMvY29yZS9ibG9jay5jIHwgMiArLQ0KIDEgZmlsZSBjaGFuZ2VkLCAxIGlu
c2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9tbWMvY29y
ZS9ibG9jay5jIGIvZHJpdmVycy9tbWMvY29yZS9ibG9jay5jDQppbmRleCA4NDk5YjU2Li5lNmUw
MjVjIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9tbWMvY29yZS9ibG9jay5jDQorKysgYi9kcml2ZXJz
L21tYy9jb3JlL2Jsb2NrLmMNCkBAIC0yNDgzLDggKzI0ODMsOCBAQCBzdGF0aWMgaW50IG1tY19y
cG1iX2NocmRldl9yZWxlYXNlKHN0cnVjdCBpbm9kZSAqaW5vZGUsIHN0cnVjdCBmaWxlICpmaWxw
KQ0KIHN0cnVjdCBtbWNfcnBtYl9kYXRhICpycG1iID0gY29udGFpbmVyX29mKGlub2RlLT5pX2Nk
ZXYsDQogICBzdHJ1Y3QgbW1jX3JwbWJfZGF0YSwgY2hyZGV2KTsNCg0KLXB1dF9kZXZpY2UoJnJw
bWItPmRldik7DQogbW1jX2Jsa19wdXQocnBtYi0+bWQpOw0KK3B1dF9kZXZpY2UoJnJwbWItPmRl
dik7DQoNCiByZXR1cm4gMDsNCiB9DQotLQ0KMi43LjQNCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fDQpPUFBPDQoNCrG+tefX09PKvP68sMbkuL28/rqs09BPUFBPuavLvrXEsaPD3NDF
z6KjrL32z97T2tPKvP7WuMP3tcTK1bz+yMvKudPDo6iw/LqsuPbIy7ywyLrX6aOpoaO9+9a5yM66
zsjL1NrOtL6tytrIqLXEx+m/9s/C0tTIzrrO0M7Kvcq508Oho8jnufvE+rTtytXBy7G+08q8/qOs
x+vBory00tS159fT08q8/s2o1qq3orz+yMuyosm+s/2xvtPKvP68sMbkuL28/qGjDQoNClRoaXMg
ZS1tYWlsIGFuZCBpdHMgYXR0YWNobWVudHMgY29udGFpbiBjb25maWRlbnRpYWwgaW5mb3JtYXRp
b24gZnJvbSBPUFBPLCB3aGljaCBpcyBpbnRlbmRlZCBvbmx5IGZvciB0aGUgcGVyc29uIG9yIGVu
dGl0eSB3aG9zZSBhZGRyZXNzIGlzIGxpc3RlZCBhYm92ZS4gQW55IHVzZSBvZiB0aGUgaW5mb3Jt
YXRpb24gY29udGFpbmVkIGhlcmVpbiBpbiBhbnkgd2F5IChpbmNsdWRpbmcsIGJ1dCBub3QgbGlt
aXRlZCB0bywgdG90YWwgb3IgcGFydGlhbCBkaXNjbG9zdXJlLCByZXByb2R1Y3Rpb24sIG9yIGRp
c3NlbWluYXRpb24pIGJ5IHBlcnNvbnMgb3RoZXIgdGhhbiB0aGUgaW50ZW5kZWQgcmVjaXBpZW50
KHMpIGlzIHByb2hpYml0ZWQuIElmIHlvdSByZWNlaXZlIHRoaXMgZS1tYWlsIGluIGVycm9yLCBw
bGVhc2Ugbm90aWZ5IHRoZSBzZW5kZXIgYnkgcGhvbmUgb3IgZW1haWwgaW1tZWRpYXRlbHkgYW5k
IGRlbGV0ZSBpdCENCg==
