Return-Path: <SRS0=eot0=4F=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C220C7619B
	for <linux-mmc@archiver.kernel.org>; Mon, 17 Feb 2020 06:56:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54A6120679
	for <linux-mmc@archiver.kernel.org>; Mon, 17 Feb 2020 06:56:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="p4SeIOL2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbgBQG4s (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 17 Feb 2020 01:56:48 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:6658 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725855AbgBQG4s (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 17 Feb 2020 01:56:48 -0500
X-UUID: 1802d54c9eda4d11bb9fbeb245679826-20200217
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=hxYCCL3/k4cibEcsvPHtckq0NXx5A2Fj9khz3ehuN+o=;
        b=p4SeIOL24J0WiZxgC4Ufbtv9qKDlfLq9rAF6TMXhyC/K5RNG7uyDjSd/Dmz4aKVKHtn36+Kq8e4RUNFYJrq11HLkxT7PWXfrIbEC8jh70vvwuXdJ6+0yS5yFFqNVIOsPJco0mEGZWK6zZdJQngGjyFnPr666ihOwAMeCuRAOzes=;
X-UUID: 1802d54c9eda4d11bb9fbeb245679826-20200217
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <chun-hung.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 3879307; Mon, 17 Feb 2020 14:56:42 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 17 Feb 2020 14:55:46 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 17 Feb 2020 14:54:43 +0800
From:   Chun-Hung Wu <chun-hung.wu@mediatek.com>
To:     Chaotian Jing <chaotian.jing@mediatek.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Pavel Machek <pavel@ucw.cz>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Pan Bian <bianpan2016@163.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Allison Randal <allison@lohutok.net>,
        Mathieu Malaterre <malat@debian.org>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Kuohong Wang <kuohong.wang@mediatek.com>
CC:     <kernel-team@android.com>, <linux-kernel@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <wsd_upstream@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Chun-Hung Wu <chun-hung.wu@mediatek.com>
Subject: [PATCH v3 2/4] mmc: mediatek: refine msdc timeout api
Date:   Mon, 17 Feb 2020 14:56:02 +0800
Message-ID: <1581922564-24914-3-git-send-email-chun-hung.wu@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1581922564-24914-1-git-send-email-chun-hung.wu@mediatek.com>
References: <1581922564-24914-1-git-send-email-chun-hung.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

RXh0cmFjdCBtc2RjIHRpbWVvdXQgYXBpIGNvbW1vbiBwYXJ0IHRvIGhhdmUNCmJldHRlciBjb2Rl
IGFyY2hpdGVjdHVyZSBhbmQgYXZvaWQgcmVkdW5kZW50DQpjb2RlLg0KDQpTaWduZWQtb2ZmLWJ5
OiBDaHVuLUh1bmcgV3UgPGNodW4taHVuZy53dUBtZWRpYXRlay5jb20+DQotLS0NCiBkcml2ZXJz
L21tYy9ob3N0L210ay1zZC5jIHwgMzIgKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0N
CiAxIGZpbGUgY2hhbmdlZCwgMjIgaW5zZXJ0aW9ucygrKSwgMTAgZGVsZXRpb25zKC0pDQoNCmRp
ZmYgLS1naXQgYS9kcml2ZXJzL21tYy9ob3N0L210ay1zZC5jIGIvZHJpdmVycy9tbWMvaG9zdC9t
dGstc2QuYw0KaW5kZXggMTg5ZTQyNi4uMTI3YjBjZiAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvbW1j
L2hvc3QvbXRrLXNkLmMNCisrKyBiL2RyaXZlcnMvbW1jL2hvc3QvbXRrLXNkLmMNCkBAIC02OTgs
MjEgKzY5OCwyMSBAQCBzdGF0aWMgdm9pZCBtc2RjX3VucHJlcGFyZV9kYXRhKHN0cnVjdCBtc2Rj
X2hvc3QgKmhvc3QsIHN0cnVjdCBtbWNfcmVxdWVzdCAqbXJxKQ0KIAl9DQogfQ0KIA0KLS8qIGNs
b2NrIGNvbnRyb2wgcHJpbWl0aXZlcyAqLw0KLXN0YXRpYyB2b2lkIG1zZGNfc2V0X3RpbWVvdXQo
c3RydWN0IG1zZGNfaG9zdCAqaG9zdCwgdTMyIG5zLCB1MzIgY2xrcykNCitzdGF0aWMgdTY0IG1z
ZGNfdGltZW91dF9jYWwoc3RydWN0IG1zZGNfaG9zdCAqaG9zdCwgdTY0IG5zLCB1NjQgY2xrcykN
CiB7DQotCXUzMiB0aW1lb3V0LCBjbGtfbnM7DQorCXU2NCB0aW1lb3V0LCBjbGtfbnM7DQogCXUz
MiBtb2RlID0gMDsNCiANCi0JaG9zdC0+dGltZW91dF9ucyA9IG5zOw0KLQlob3N0LT50aW1lb3V0
X2Nsa3MgPSBjbGtzOw0KIAlpZiAoaG9zdC0+bW1jLT5hY3R1YWxfY2xvY2sgPT0gMCkgew0KIAkJ
dGltZW91dCA9IDA7DQogCX0gZWxzZSB7DQotCQljbGtfbnMgID0gMTAwMDAwMDAwMFVMIC8gaG9z
dC0+bW1jLT5hY3R1YWxfY2xvY2s7DQotCQl0aW1lb3V0ID0gKG5zICsgY2xrX25zIC0gMSkgLyBj
bGtfbnMgKyBjbGtzOw0KKwkJY2xrX25zICA9IDEwMDAwMDAwMDBVTEw7DQorCQlkb19kaXYoY2xr
X25zLCBob3N0LT5tbWMtPmFjdHVhbF9jbG9jayk7DQorCQl0aW1lb3V0ID0gbnMgKyBjbGtfbnMg
LSAxOw0KKwkJZG9fZGl2KHRpbWVvdXQsIGNsa19ucyk7DQorCQl0aW1lb3V0ICs9IGNsa3M7DQog
CQkvKiBpbiAxMDQ4NTc2IHNjbGsgY3ljbGUgdW5pdCAqLw0KLQkJdGltZW91dCA9ICh0aW1lb3V0
ICsgKDB4MSA8PCAyMCkgLSAxKSA+PiAyMDsNCisJCXRpbWVvdXQgPSBESVZfUk9VTkRfVVAodGlt
ZW91dCwgKDB4MSA8PCAyMCkpOw0KIAkJaWYgKGhvc3QtPmRldl9jb21wLT5jbGtfZGl2X2JpdHMg
PT0gOCkNCiAJCQlzZHJfZ2V0X2ZpZWxkKGhvc3QtPmJhc2UgKyBNU0RDX0NGRywNCiAJCQkJICAg
ICAgTVNEQ19DRkdfQ0tNT0QsICZtb2RlKTsNCkBAIC03MjIsOSArNzIyLDIxIEBAIHN0YXRpYyB2
b2lkIG1zZGNfc2V0X3RpbWVvdXQoc3RydWN0IG1zZGNfaG9zdCAqaG9zdCwgdTMyIG5zLCB1MzIg
Y2xrcykNCiAJCS8qRERSIG1vZGUgd2lsbCBkb3VibGUgdGhlIGNsayBjeWNsZXMgZm9yIGRhdGEg
dGltZW91dCAqLw0KIAkJdGltZW91dCA9IG1vZGUgPj0gMiA/IHRpbWVvdXQgKiAyIDogdGltZW91
dDsNCiAJCXRpbWVvdXQgPSB0aW1lb3V0ID4gMSA/IHRpbWVvdXQgLSAxIDogMDsNCi0JCXRpbWVv
dXQgPSB0aW1lb3V0ID4gMjU1ID8gMjU1IDogdGltZW91dDsNCiAJfQ0KLQlzZHJfc2V0X2ZpZWxk
KGhvc3QtPmJhc2UgKyBTRENfQ0ZHLCBTRENfQ0ZHX0RUT0MsIHRpbWVvdXQpOw0KKwlyZXR1cm4g
dGltZW91dDsNCit9DQorDQorLyogY2xvY2sgY29udHJvbCBwcmltaXRpdmVzICovDQorc3RhdGlj
IHZvaWQgbXNkY19zZXRfdGltZW91dChzdHJ1Y3QgbXNkY19ob3N0ICpob3N0LCB1NjQgbnMsIHU2
NCBjbGtzKQ0KK3sNCisJdTY0IHRpbWVvdXQ7DQorDQorCWhvc3QtPnRpbWVvdXRfbnMgPSBuczsN
CisJaG9zdC0+dGltZW91dF9jbGtzID0gY2xrczsNCisNCisJdGltZW91dCA9IG1zZGNfdGltZW91
dF9jYWwoaG9zdCwgbnMsIGNsa3MpOw0KKwlzZHJfc2V0X2ZpZWxkKGhvc3QtPmJhc2UgKyBTRENf
Q0ZHLCBTRENfQ0ZHX0RUT0MsDQorCQkgICAgICAodTMyKSh0aW1lb3V0ID4gMjU1ID8gMjU1IDog
dGltZW91dCkpOw0KIH0NCiANCiBzdGF0aWMgdm9pZCBtc2RjX2dhdGVfY2xvY2soc3RydWN0IG1z
ZGNfaG9zdCAqaG9zdCkNCi0tIA0KMS45LjENCg==

