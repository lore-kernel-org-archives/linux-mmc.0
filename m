Return-Path: <SRS0=eot0=4F=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEC1DC35242
	for <linux-mmc@archiver.kernel.org>; Mon, 17 Feb 2020 04:13:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D37621744
	for <linux-mmc@archiver.kernel.org>; Mon, 17 Feb 2020 04:13:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="BXNU0hGD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727811AbgBQENR (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 16 Feb 2020 23:13:17 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:7002 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726591AbgBQENR (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 16 Feb 2020 23:13:17 -0500
X-UUID: 591f7fc95c5e43d0aa5437cdec6f7334-20200217
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=XXQOsLoB7tFXez5/loNRWj7lM3AnXVWqLDHsdOB8kd4=;
        b=BXNU0hGDEK8adlkUOr8DyGZrJB1mBPsp1ySt+5j9n8GmFn21dIs00w3iHd0Hi+5ZLuVYxNcgiJ1Y32T9CCvUwLq0sjAQJRTP8lN8ptFt5PVo3wqIUP8VwF6B/qKK33HvM0mxmnWjAJVJg/+/8z2BRwmnwS083OV6XU3nhClxseA=;
X-UUID: 591f7fc95c5e43d0aa5437cdec6f7334-20200217
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <chun-hung.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 971404532; Mon, 17 Feb 2020 12:13:13 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 17 Feb 2020 12:12:19 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 17 Feb 2020 12:12:59 +0800
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
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v2 0/4] mmc: mediatek: add mmc cqhci support
Date:   Mon, 17 Feb 2020 12:13:06 +0800
Message-ID: <1581912790-19382-1-git-send-email-chun-hung.wu@mediatek.com>
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
YXRlIG1zZGMgdGltZW91dCBhcGkgcmVmaW5lIHRvIGluZGl2aWR1YWwgcGF0Y2gNCg0K

