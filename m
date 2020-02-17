Return-Path: <SRS0=eot0=4F=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC100C7619D
	for <linux-mmc@archiver.kernel.org>; Mon, 17 Feb 2020 06:56:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 821B320718
	for <linux-mmc@archiver.kernel.org>; Mon, 17 Feb 2020 06:56:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="jRGH5ydk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725935AbgBQG4h (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 17 Feb 2020 01:56:37 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:1215 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725855AbgBQG4h (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 17 Feb 2020 01:56:37 -0500
X-UUID: 5d501fb805464c1e82191af93ed39066-20200217
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=EDdherEAiYug6KK8QJ6Wlc6yBvU5OsQws/RitVE+q9o=;
        b=jRGH5ydkkBrGTiG15D+1WpU8hLTFcdHSmmTkbwBB8W/L+hrKN7VcByITkHskEBZWTeC9j4jzKTUaGs0NfxwiMVeu+Jua7IDbK+laJdhyIydeE9jexe+Ar352IvC5FrmdpC6fWb2EpvEODujlVdev1W+DGacpGezfOyOqB/T+/zc=;
X-UUID: 5d501fb805464c1e82191af93ed39066-20200217
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <chun-hung.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1998459750; Mon, 17 Feb 2020 14:56:30 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 17 Feb 2020 14:55:34 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 17 Feb 2020 14:54:31 +0800
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
Subject: [PATCH v3 0/4] mmc: mediatek: add mmc cqhci support
Date:   Mon, 17 Feb 2020 14:56:00 +0800
Message-ID: <1581922564-24914-1-git-send-email-chun-hung.wu@mediatek.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

VGhpcyBzZXJpZXMgcHJvdmlkZXMgTWVkaWFUZWsgY3FoY2kgaW1wbGVtZW50YXRpb25zIGFzIGJl
bG93Og0KICAtIEFkZCBleHBvc2UgTU1DX0NBUDJfQ1FFKiB0byBkdA0KICAtIFJlZmluZSBtc2Rj
IHRpbWVvdXQgYXBpIHRvIHJlZHVjZSByZWR1bmRhbnQgY29kZQ0KICAtIE1lZGlhVGVrIGNvbW1h
bmQgcXVldWUgc3VwcG9ydA0KICAtIGR0LWJpbmRpbmdzIGZvciBtdDY3NzkNCg0KdjEgLT4gdjI6
DQogIC0gQWRkIG1vcmUgcGF0Y2ggZGV0YWlscyBpbiBjb21taXQgbWVzc2FnZQ0KICAtIFNlcGFy
YXRlIG1zZGMgdGltZW91dCBhcGkgcmVmaW5lIHRvIGluZGl2aWR1YWwgcGF0Y2gNCg0KdjIgLT4g
djM6DQogIC0gUmVtb3ZlIENSLUlkLCBDaGFuZ2UtSWQgYW5kIEZlYXR1cmUgaW4gcGF0Y2hlcw0K
ICAtIEFkZCBTaWduZWQtb2ZmLWJ5IGluIHBhdGNoZXMNCg0KQ2h1bi1IdW5nIFd1ICg0KToNCiAg
WzEvNF0gbW1jOiBjb3JlOiBleHBvc2UgTU1DX0NBUDJfQ1FFKiB0byBkdA0KICBbMi80XSBtbWM6
IG1lZGlhdGVrOiByZWZpbmUgbXNkYyB0aW1lb3V0IGFwaQ0KICBbMy80XSBtbWM6IG1lZGlhdGVr
OiBjb21tYW5kIHF1ZXVlIHN1cHBvcnQNCiAgWzQvNF0gZHQtYmluZGluZ3M6IG1tYzogbWVkaWF0
ZWs6IEFkZCBkb2N1bWVudCBmb3IgbXQ2Nzc5DQoNCiBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUv
YmluZGluZ3MvbW1jL210ay1zZC50eHQgfCAgIDEgKw0KIGRyaXZlcnMvbW1jL2NvcmUvaG9zdC5j
ICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgOCArKw0KIGRyaXZlcnMvbW1jL2hvc3QvbXRr
LXNkLmMgICAgICAgICAgICAgICAgICAgICAgICB8IDE1MSArKysrKysrKysrKysrKysrKysrKyst
LQ0KIDMgZmlsZXMgY2hhbmdlZCwgMTUwIGluc2VydGlvbnMoKyksIDEwIGRlbGV0aW9ucygtKQ0K
DQotLSANCjEuOS4xDQo=

