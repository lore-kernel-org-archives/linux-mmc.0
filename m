Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87DACC2D0A3
	for <linux-mmc@archiver.kernel.org>; Thu, 12 Nov 2020 08:52:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15C242100A
	for <linux-mmc@archiver.kernel.org>; Thu, 12 Nov 2020 08:52:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="PHPA9cF1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725941AbgKLIwI (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 12 Nov 2020 03:52:08 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:20195 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725902AbgKLIwI (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 12 Nov 2020 03:52:08 -0500
X-UUID: 180a56fed0c045148064dceba5a8562e-20201112
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=EL2xgh+f2w+QkXQYUlt8Af4ocrMSb0AMQTg9c+lCuOI=;
        b=PHPA9cF1R/mwkmJYM09S4BrdyJlyEGQxujpqCRCIRkPxOOlKTheg0re+G4Z4fo/sLgIazlthjry120SOHUCSRzIQqMH8ThrLhCd77i0n3xjTZcIU+D4wrlJNu26b3r7IEF+iPhT/TfwKQcpXkGRV3a+CtlswHMFkLILA7T838xc=;
X-UUID: 180a56fed0c045148064dceba5a8562e-20201112
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chaotian.jing@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 882986302; Thu, 12 Nov 2020 16:52:01 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31DR.mediatek.inc
 (172.27.6.102) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 12 Nov
 2020 16:52:00 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 12 Nov 2020 16:51:59 +0800
Message-ID: <1605171119.29266.1.camel@mhfsdcap03>
Subject: Re: [PATCH] mmc: mediatek: fix mem leak in msdc_drv_probe
From:   Chaotian Jing <chaotian.jing@mediatek.com>
To:     Zheng Liang <zhengliang6@huawei.com>
CC:     <ulf.hansson@linaro.org>, <matthias.bgg@gmail.com>,
        <linux-mmc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <wangli74@huawei.com>,
        <fangwei1@huawei.com>, <wenbin.mei@mediatek.com>
Date:   Thu, 12 Nov 2020 16:51:59 +0800
In-Reply-To: <20201112092530.32446-1-zhengliang6@huawei.com>
References: <20201112092530.32446-1-zhengliang6@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: E42657F8F3062DD55A3CBA017D1041D894DA704C08F11EE61CD92F0F513239312000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

T24gVGh1LCAyMDIwLTExLTEyIGF0IDE3OjI1ICswODAwLCBaaGVuZyBMaWFuZyB3cm90ZToNCj4g
SXQgc2hvdWxkIHVzZSBtbWNfZnJlZV9ob3N0IHRvIGZyZWUgbWVtIGluIGVycm9yIHBhdGNoIG9m
DQo+IG1zZGNfZHJ2X3Byb2JlLg0KPiANCj4gUmVwb3J0ZWQtYnk6IEh1bGsgUm9ib3QgPGh1bGtj
aUBodWF3ZWkuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBaaGVuZyBMaWFuZyA8emhlbmdsaWFuZzZA
aHVhd2VpLmNvbT4NClJldmlld2VkLWJ5OiBDaGFvdGlhbiBKaW5nIDxjaGFvdGlhbi5qaW5nQG1l
ZGlhdGVrLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL21tYy9ob3N0L210ay1zZC5jIHwgNiArKysr
LS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+
IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tbWMvaG9zdC9tdGstc2QuYyBiL2RyaXZlcnMvbW1j
L2hvc3QvbXRrLXNkLmMNCj4gaW5kZXggZmM1ZWU1ZGY5MWFkLi5lYWM3ODM4ZTJkYWMgMTAwNjQ0
DQo+IC0tLSBhL2RyaXZlcnMvbW1jL2hvc3QvbXRrLXNkLmMNCj4gKysrIGIvZHJpdmVycy9tbWMv
aG9zdC9tdGstc2QuYw0KPiBAQCAtMjUwNCw4ICsyNTA0LDEwIEBAIHN0YXRpYyBpbnQgbXNkY19k
cnZfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gIA0KPiAgCWhvc3QtPnJl
c2V0ID0gZGV2bV9yZXNldF9jb250cm9sX2dldF9vcHRpb25hbF9leGNsdXNpdmUoJnBkZXYtPmRl
diwNCj4gIAkJCQkJCQkJImhyc3QiKTsNCj4gLQlpZiAoSVNfRVJSKGhvc3QtPnJlc2V0KSkNCj4g
LQkJcmV0dXJuIFBUUl9FUlIoaG9zdC0+cmVzZXQpOw0KPiArCWlmIChJU19FUlIoaG9zdC0+cmVz
ZXQpKSB7DQo+ICsJCXJldCA9IFBUUl9FUlIoaG9zdC0+cmVzZXQpOw0KPiArCQlnb3RvIGhvc3Rf
ZnJlZTsNCj4gKwl9DQo+ICANCj4gIAlob3N0LT5pcnEgPSBwbGF0Zm9ybV9nZXRfaXJxKHBkZXYs
IDApOw0KPiAgCWlmIChob3N0LT5pcnEgPCAwKSB7DQoNCg==

