Return-Path: <SRS0=eot0=4F=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54305C7619B
	for <linux-mmc@archiver.kernel.org>; Mon, 17 Feb 2020 06:32:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27E7320726
	for <linux-mmc@archiver.kernel.org>; Mon, 17 Feb 2020 06:32:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Piwz1Yye"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726107AbgBQGcz (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 17 Feb 2020 01:32:55 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:55441 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725873AbgBQGcz (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 17 Feb 2020 01:32:55 -0500
X-UUID: dfd754f1d65e4d469348092e4f803dea-20200217
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=L6ns1uLHFIoR7JrbKm5yCeM+PGvfPIcb1rFj/+bzaJ4=;
        b=Piwz1YyeHyrssJII6Z3jaRCSbAohCQvK/z74BTmNNIQP//hA1H5pbG3C/1LLYvVLw3p5ZF8+TR6XjVADwzH9S65LMQEFX9d9sdsI5mhiaNYjFdQtl2bcQzfJWZ9iHJWw+jSMZWoV492WyCmDSH8BCV/o0ALsQQtcrq/94spDGIM=;
X-UUID: dfd754f1d65e4d469348092e4f803dea-20200217
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw02.mediatek.com
        (envelope-from <chun-hung.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1242957750; Mon, 17 Feb 2020 14:32:51 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 17 Feb 2020 14:31:54 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 17 Feb 2020 14:32:24 +0800
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
Subject: [PATCH 1/4] [1/4] mmc: core: expose MMC_CAP2_CQE* to dt
Date:   Mon, 17 Feb 2020 14:31:48 +0800
Message-ID: <1581921111-24172-2-git-send-email-chun-hung.wu@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1581921111-24172-1-git-send-email-chun-hung.wu@mediatek.com>
References: <1581921111-24172-1-git-send-email-chun-hung.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

RXhwb3NlIE1NQ19DQVAyX0NRRSBhbmQgTU1DX0NBUDJfQ1FFX0RDTUQNCnRvIGhvc3QtPmNhcHMy
IGlmDQoxLiAic3VwcG9ydHMtY3FlIiBpcyBkZWZpbmVkIGluIGR0IGFuZA0KMi4gImRpc2FibGUt
Y3FlLWRjbWQiIGlzIG5vdCBkZWZpbmVkIGluIGR0Lg0KDQotLS0NCiBkcml2ZXJzL21tYy9jb3Jl
L2hvc3QuYyB8IDggKysrKysrKysNCiAxIGZpbGUgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspDQoN
CmRpZmYgLS1naXQgYS9kcml2ZXJzL21tYy9jb3JlL2hvc3QuYyBiL2RyaXZlcnMvbW1jL2NvcmUv
aG9zdC5jDQppbmRleCAxMDViN2E3Li5lZmIwZGJlIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9tbWMv
Y29yZS9ob3N0LmMNCisrKyBiL2RyaXZlcnMvbW1jL2NvcmUvaG9zdC5jDQpAQCAtMzE5LDYgKzMx
OSwxNCBAQCBpbnQgbW1jX29mX3BhcnNlKHN0cnVjdCBtbWNfaG9zdCAqaG9zdCkNCiAJCWhvc3Qt
PmNhcHMyIHw9IE1NQ19DQVAyX05PX1NEOw0KIAlpZiAoZGV2aWNlX3Byb3BlcnR5X3JlYWRfYm9v
bChkZXYsICJuby1tbWMiKSkNCiAJCWhvc3QtPmNhcHMyIHw9IE1NQ19DQVAyX05PX01NQzsNCisJ
aWYgKGRldmljZV9wcm9wZXJ0eV9yZWFkX2Jvb2woZGV2LCAic3VwcG9ydHMtY3FlIikpDQorCQlo
b3N0LT5jYXBzMiB8PSBNTUNfQ0FQMl9DUUU7DQorDQorCS8qIE11c3QgYmUgYWZ0ZXIgInN1cHBv
cnRzLWNxZSIgY2hlY2sgKi8NCisJaWYgKCFkZXZpY2VfcHJvcGVydHlfcmVhZF9ib29sKGRldiwg
ImRpc2FibGUtY3FlLWRjbWQiKSkgew0KKwkJaWYgKGhvc3QtPmNhcHMyICYgTU1DX0NBUDJfQ1FF
KQ0KKwkJCWhvc3QtPmNhcHMyIHw9IE1NQ19DQVAyX0NRRV9EQ01EOw0KKwl9DQogDQogCS8qIE11
c3QgYmUgYWZ0ZXIgIm5vbi1yZW1vdmFibGUiIGNoZWNrICovDQogCWlmIChkZXZpY2VfcHJvcGVy
dHlfcmVhZF91MzIoZGV2LCAiZml4ZWQtZW1tYy1kcml2ZXItdHlwZSIsICZkcnZfdHlwZSkgPT0g
MCkgew0KLS0gDQoxLjkuMQ0K

