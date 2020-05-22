Return-Path: <SRS0=PvXF=7E=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=CHARSET_FARAWAY_HEADER,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 036B4C433DF
	for <linux-mmc@archiver.kernel.org>; Fri, 22 May 2020 09:29:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C69DF206C3
	for <linux-mmc@archiver.kernel.org>; Fri, 22 May 2020 09:29:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=oppoglobal.onmicrosoft.com header.i=@oppoglobal.onmicrosoft.com header.b="ZWCbH8qm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728183AbgEVJ3c (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 22 May 2020 05:29:32 -0400
Received: from mail-eopbgr1300053.outbound.protection.outlook.com ([40.107.130.53]:14789
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728068AbgEVJ33 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 22 May 2020 05:29:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BrP0VoZ1HCbY5j+4UDmQnsMroBQ5LQzvkMQAnFc73C6rl7yN1XYXqrJbzfJJpez+ktBtHQUvNkPQxzk6dW3emTZIwAtDG7vyVMBo8jn/3S74OX0VjSyEVWcw58Zax3kjVxmCD3ipiWqh9M2VsgWHjucHyZ1Hyq0KCAWhRL+tBpHXpXseOmIHhUonP6Ps6TZxx/u+6ndWDt/R9Q0T57bwlSXccd8MSJGM1MO+hKf0sZ7MAGFOkK8r87+f5JXHPcEQNfF3RixGOx5EU+a8aBDTaZGgUmpbrgN0QkZLXKKmUTK3DKg6/bvBsxV9GEdwQO0SajbBH7VD8vhR2B+g7Vg7Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uhq+khHEA+fj62144fFShpEsHFBA1gaRwwrk3lr0k1w=;
 b=EyNPKV23g4SPXQdZ3cERWZ5tpojInj1ptWVPLlDD1ovAEP8Rw+expFb3wf/RUSzOfilWv6DEGm2sfD69enTW8Cg/AbNJuiqTGNomx0FtvbuT8kHv4pknfrLaOBU+w3RQwQzGJvHY3c98XTL65LlFxnIBcWgCLCded38tfZ3pwo1dIzI0dyEed0jE+NBzfO8woBk6oOw5ry2fC7A51FJUw+VwvKRyuhHkYEjMihtW9mIBbim9KYuXVarNBPjzRHYp0f7yEUcdHmm6wF8i91WHRwbnlzToZCy9EnKTf3n4os/BJXK2h/cPSqKq/euemZ3y3IV5obhLku8faF4sxYd2iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oppoglobal.onmicrosoft.com; s=selector1-oppoglobal-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uhq+khHEA+fj62144fFShpEsHFBA1gaRwwrk3lr0k1w=;
 b=ZWCbH8qmR28av3dNymCQuKV35CSF441u/A2LVDb3kIFKdOXJU9RANYlZaa8YTn5tINq8itPGJYb38czu99lIPsznD/ghVLWOfFI2BIh9PDnv7gq7EBuZnN+43UyZtaq/VBFgCaZTB/9+iw9AZYXORE7kfPqYl9o2cV4sJo9g5mw=
Received: from HKAPR02MB4291.apcprd02.prod.outlook.com (2603:1096:203:d3::12)
 by HKAPR02MB4340.apcprd02.prod.outlook.com (2603:1096:203:d4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.26; Fri, 22 May
 2020 09:29:25 +0000
Received: from HKAPR02MB4291.apcprd02.prod.outlook.com
 ([fe80::80ca:c698:988e:a999]) by HKAPR02MB4291.apcprd02.prod.outlook.com
 ([fe80::80ca:c698:988e:a999%5]) with mapi id 15.20.3021.020; Fri, 22 May 2020
 09:29:25 +0000
From:   =?gb2312?B?xe26xihSaWNoYXJkKQ==?= <richard.peng@oppo.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        "Markus.Elfring@web.de" <Markus.Elfring@web.de>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Subject: [PATCH v2] mmc: fix use-after-free issue
Thread-Topic: [PATCH v2] mmc: fix use-after-free issue
Thread-Index: AdYwG1QOySHOrR48TpmU8O/k4aVGOA==
Date:   Fri, 22 May 2020 09:29:25 +0000
Message-ID: <HKAPR02MB429107D62F3E9F86E76AD550E0B40@HKAPR02MB4291.apcprd02.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=oppo.com;
x-originating-ip: [58.252.5.70]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d83f458e-ebc4-493d-8583-08d7fe329e80
x-ms-traffictypediagnostic: HKAPR02MB4340:
x-microsoft-antispam-prvs: <HKAPR02MB4340D280F448DC3CCA41F406E0B40@HKAPR02MB4340.apcprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:628;
x-forefront-prvs: 04111BAC64
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kcu6bDNZk+RTPb5SmNRsCdb+C5itBAPBOybgy7GpkK1Z+XJK07OGMkpYh3TBRZPI3iPMb1m50eY16pfdGeddzwZ+XCt1r+l31B0s5PlJvn5qKx9LxLgj/XxRlNgBwKcfvaTfiKBw6nBMQZd1gZDBPkebvl8E8ZjnUgjgKTScEBa6IMOs/7EbMkiKUtET09u9/tIxd/tql5HTMnuiKFRFFeGRrobVwnaiGDHP1AlFouUtyUB658IoZr2UE5b6Zu11UHT52gdBMwtGEXLcVf4jgWevVbFecMbP0/mxJuqBFlusKkkJMytgV300NTEoMuvoGoehingBDUZMttobBD9qq+DmJnIgw8ReWu5lhOlozEbs1bZzHkVuyF/ieoMF07HC
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HKAPR02MB4291.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(136003)(396003)(376002)(346002)(39860400002)(4326008)(86362001)(110136005)(2906002)(54906003)(316002)(5660300002)(64756008)(186003)(26005)(52536014)(7696005)(478600001)(8936002)(71200400001)(9686003)(66556008)(66476007)(76116006)(66446008)(8676002)(6506007)(66946007)(33656002)(55016002)(85182001)(11606004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: s3wvG4nA/eYNd79i6HRDMmQFi/G8uFeomFJ2Qef15sns9ggti3oH0k8fFH7Lh15NlxGyc7skGhfKTc+AbU0HydzTWR3j4/cHq5OXGc6/bYS2fA3lVoJVyxmPLK1F/VhjlGUxsyhuhlYEYfH3Ue1hohIiqv/B8QCfQlZYzTZ5udJs7rIj356DA+yhbHrJ7/ZbatiJvTCOArm6uboy8UwlaVe3H3p/IsA7YeAI+rYi0qe9L6X0F2wwOUKchenmlEu2sOU1aV16l2QJYq1Lu5ntqsWWo+wQt7OFakV9/V7zL2ATSxg1ZW80JTJvODW0Q2zKPrGc1vZ0G5x8IkCDyKw2Sl3zRtq4K40DCKJnjxUqe54c1fttfx1CGrHGbEC+e1r8f+MDXgHg9Df21F+wH92+of376hpWwtaWKiEPEb49wtoibxhxkhMkcgLS56DH6ADIK41ajLuUiS9qUFqiZlzLHU/Nud7iv50MhWfPUAfVF+Q=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d83f458e-ebc4-493d-8583-08d7fe329e80
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2020 09:29:25.6699
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0Rzf6c/8JlUB4HWOCyX6sb5gmDbgJQmQ0jWosjo6FLgqNeg+HQhXCjmc5ne39EBVrpKUy2+PZzzlM98LiATmfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HKAPR02MB4340
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

IFRoZSBkYXRhIHN0cnVjdHVyZSBtZW1iZXIgobBycG1iLT5tZKGxIHdhcyBwYXNzZWQgdG8gYSBj
YWxsIG9mDQogdGhlIGZ1bmN0aW9uIKGwbW1jX2Jsa19wdXShsSBhZnRlciBhIGNhbGwgb2YgdGhl
IGZ1bmN0aW9uIKGwcHV0X2RldmljZaGxLg0KIFJlb3JkZXIgdGhlc2UgZnVuY3Rpb24gY2FsbHMg
dG8ga2VlcCB0aGUgZGF0YSBhY2Nlc3NlcyBjb25zaXN0ZW50Lg0KDQpGaXhlczogMWM4N2Y3MzU3
ODQ5ICgibW1jOiBibG9jazogRml4IGJ1ZyB3aGVuIHJlbW92aW5nIFJQTUIgY2hhcmRldiAiKQ0K
U2lnbmVkLW9mZi1ieTogUGVuZyBIYW8gPHJpY2hhcmQucGVuZ0BvcHBvLmNvbT4NCi0tLQ0KIGRy
aXZlcnMvbW1jL2NvcmUvYmxvY2suYyB8IDIgKy0NCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRp
b24oKyksIDEgZGVsZXRpb24oLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvbW1jL2NvcmUvYmxv
Y2suYyBiL2RyaXZlcnMvbW1jL2NvcmUvYmxvY2suYw0KaW5kZXggODQ5OWI1Ni4uZTZlMDI1YyAx
MDA2NDQNCi0tLSBhL2RyaXZlcnMvbW1jL2NvcmUvYmxvY2suYw0KKysrIGIvZHJpdmVycy9tbWMv
Y29yZS9ibG9jay5jDQpAQCAtMjQ4Myw4ICsyNDgzLDggQEAgc3RhdGljIGludCBtbWNfcnBtYl9j
aHJkZXZfcmVsZWFzZShzdHJ1Y3QgaW5vZGUgKmlub2RlLCBzdHJ1Y3QgZmlsZSAqZmlscCkNCiBz
dHJ1Y3QgbW1jX3JwbWJfZGF0YSAqcnBtYiA9IGNvbnRhaW5lcl9vZihpbm9kZS0+aV9jZGV2LA0K
ICAgc3RydWN0IG1tY19ycG1iX2RhdGEsIGNocmRldik7DQoNCi1wdXRfZGV2aWNlKCZycG1iLT5k
ZXYpOw0KIG1tY19ibGtfcHV0KHJwbWItPm1kKTsNCitwdXRfZGV2aWNlKCZycG1iLT5kZXYpOw0K
DQogcmV0dXJuIDA7DQogfQ0KLS0NCjIuNy40DQpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXw0KT1BQTw0KDQqxvrXn19PTyrz+vLDG5Li9vP66rNPQT1BQT7mry761xLGjw9zQxc+io6y9
9s/e09rTyrz+1rjD97XEytW8/sjLyrnTw6OosPy6rLj2yMu8sMi61+mjqaGjvfvWucjOus7Iy9Ta
zrS+rcrayKi1xMfpv/bPwtLUyM66ztDOyr3KudPDoaPI57n7xPq07crVwcuxvtPKvP6jrMfrwaK8
tNLUtefX09PKvP7NqNaqt6K8/sjLsqLJvrP9sb7Tyrz+vLDG5Li9vP6how0KDQpUaGlzIGUtbWFp
bCBhbmQgaXRzIGF0dGFjaG1lbnRzIGNvbnRhaW4gY29uZmlkZW50aWFsIGluZm9ybWF0aW9uIGZy
b20gT1BQTywgd2hpY2ggaXMgaW50ZW5kZWQgb25seSBmb3IgdGhlIHBlcnNvbiBvciBlbnRpdHkg
d2hvc2UgYWRkcmVzcyBpcyBsaXN0ZWQgYWJvdmUuIEFueSB1c2Ugb2YgdGhlIGluZm9ybWF0aW9u
IGNvbnRhaW5lZCBoZXJlaW4gaW4gYW55IHdheSAoaW5jbHVkaW5nLCBidXQgbm90IGxpbWl0ZWQg
dG8sIHRvdGFsIG9yIHBhcnRpYWwgZGlzY2xvc3VyZSwgcmVwcm9kdWN0aW9uLCBvciBkaXNzZW1p
bmF0aW9uKSBieSBwZXJzb25zIG90aGVyIHRoYW4gdGhlIGludGVuZGVkIHJlY2lwaWVudChzKSBp
cyBwcm9oaWJpdGVkLiBJZiB5b3UgcmVjZWl2ZSB0aGlzIGUtbWFpbCBpbiBlcnJvciwgcGxlYXNl
IG5vdGlmeSB0aGUgc2VuZGVyIGJ5IHBob25lIG9yIGVtYWlsIGltbWVkaWF0ZWx5IGFuZCBkZWxl
dGUgaXQhDQo=
