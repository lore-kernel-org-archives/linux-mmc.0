Return-Path: <SRS0=ufR4=BK=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B446C433DF
	for <linux-mmc@archiver.kernel.org>; Fri, 31 Jul 2020 06:54:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3B562084D
	for <linux-mmc@archiver.kernel.org>; Fri, 31 Jul 2020 06:54:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="LL4wduW5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731473AbgGaGyh (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 31 Jul 2020 02:54:37 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:31188 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731471AbgGaGyh (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 31 Jul 2020 02:54:37 -0400
X-UUID: c6f14febf0ac4b14a28074cc74eff403-20200731
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=YjhhNpNRDNHhO6Ju5IjvM6o2mcIZbqEWX5yq3bSDKr8=;
        b=LL4wduW5jxAqJ8cPKW8BJQm4p7ceJ5q+2/GIlxEBThHKUMpDxMTZjlA4A9RdTQC4YUWVXCnpN8KRK51NNDyXHAB9HQEUD94bWy7gx+CaYCmTqEnRhpgtFKS4kCCyPLAHr9Bp4fnZl3ySvqqfvke5RdxcLdCDmm7FvY/SGxKVe1g=;
X-UUID: c6f14febf0ac4b14a28074cc74eff403-20200731
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chun-hung.wu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 705240515; Fri, 31 Jul 2020 14:54:24 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 MTKMBS31N1.mediatek.inc (172.27.4.69) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 31 Jul 2020 14:54:23 +0800
Received: from [172.21.77.33] (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 31 Jul 2020 14:54:22 +0800
Message-ID: <1596178463.18010.1.camel@mtkswgap22>
Subject: Re: [PATCH -next] mmc: mediatek: make function msdc_cqe_disable()
 static
From:   Chun-Hung Wu <chun-hung.wu@mediatek.com>
To:     Wei Yongjun <weiyongjun1@huawei.com>
CC:     Hulk Robot <hulkci@huawei.com>,
        Chaotian Jing =?UTF-8?Q?=28=E4=BA=95=E6=9C=9D=E5=A4=A9=29?= 
        <Chaotian.Jing@mediatek.com>, Ulf Hansson <ulf.hansson@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>
Date:   Fri, 31 Jul 2020 14:54:23 +0800
In-Reply-To: <20200727171129.2945-1-weiyongjun1@huawei.com>
References: <20200727171129.2945-1-weiyongjun1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 870AB6426B9AC3E7EF684823B905EE66E93DC7E0E13748ABF5ADA191279DA3742000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

T24gVHVlLCAyMDIwLTA3LTI4IGF0IDAxOjExICswODAwLCBXZWkgWW9uZ2p1biB3cm90ZToNCj4g
VGhlIHNwYXJzZSB0b29sIGNvbXBsYWlucyBhcyBmb2xsb3dzOg0KPiANCj4gZHJpdmVycy9tbWMv
aG9zdC9tdGstc2QuYzoyMjY5OjY6IHdhcm5pbmc6DQo+ICBzeW1ib2wgJ21zZGNfY3FlX2Rpc2Fi
bGUnIHdhcyBub3QgZGVjbGFyZWQuIFNob3VsZCBpdCBiZSBzdGF0aWM/DQo+IA0KPiBUaGlzIGZ1
bmN0aW9uIGlzIG5vdCB1c2VkIG91dHNpZGUgb2YgbXRrLXNkLmMsIHNvIHRoaXMgY29tbWl0DQo+
IG1hcmtzIGl0IHN0YXRpYy4NCj4gDQo+IEZpeGVzOiA4OGJkNjUyYjNjNzQgKCJtbWM6IG1lZGlh
dGVrOiBjb21tYW5kIHF1ZXVlIHN1cHBvcnQiKQ0KPiBSZXBvcnRlZC1ieTogSHVsayBSb2JvdCA8
aHVsa2NpQGh1YXdlaS5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IFdlaSBZb25nanVuIDx3ZWl5b25n
anVuMUBodWF3ZWkuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvbW1jL2hvc3QvbXRrLXNkLmMgfCAy
ICstDQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4g
DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL21tYy9ob3N0L210ay1zZC5jIGIvZHJpdmVycy9tbWMv
aG9zdC9tdGstc2QuYw0KPiBpbmRleCA3MzRlNDAzYTE0MmUuLjRlMjU4M2Y2OWE2MyAxMDA2NDQN
Cj4gLS0tIGEvZHJpdmVycy9tbWMvaG9zdC9tdGstc2QuYw0KPiArKysgYi9kcml2ZXJzL21tYy9o
b3N0L210ay1zZC5jDQo+IEBAIC0yMjY2LDcgKzIyNjYsNyBAQCBzdGF0aWMgdm9pZCBtc2RjX2Nx
ZV9lbmFibGUoc3RydWN0IG1tY19ob3N0ICptbWMpDQo+ICAJbXNkY19zZXRfdGltZW91dChob3N0
LCAxMDAwMDAwMDAwVUxMLCAwKTsNCj4gIH0NCj4gIA0KPiAtdm9pZCBtc2RjX2NxZV9kaXNhYmxl
KHN0cnVjdCBtbWNfaG9zdCAqbW1jLCBib29sIHJlY292ZXJ5KQ0KPiArc3RhdGljIHZvaWQgbXNk
Y19jcWVfZGlzYWJsZShzdHJ1Y3QgbW1jX2hvc3QgKm1tYywgYm9vbCByZWNvdmVyeSkNCj4gIHsN
Cj4gIAlzdHJ1Y3QgbXNkY19ob3N0ICpob3N0ID0gbW1jX3ByaXYobW1jKTsNCj4gIA0KPiANCg0K
QWNrZWQtYnk6IENodW4tSHVuZyBXdSA8Y2h1bi1odW5nLnd1QG1lZGlhdGVrLmNvbT4NCg==

