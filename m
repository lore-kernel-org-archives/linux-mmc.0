Return-Path: <SRS0=eot0=4F=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66F7EC35242
	for <linux-mmc@archiver.kernel.org>; Mon, 17 Feb 2020 06:33:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DCE5207FD
	for <linux-mmc@archiver.kernel.org>; Mon, 17 Feb 2020 06:33:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="WbaCL1qJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbgBQGdV (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 17 Feb 2020 01:33:21 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:55793 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725873AbgBQGdU (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 17 Feb 2020 01:33:20 -0500
X-UUID: 2840c5bc17b04e2baed5745518effb61-20200217
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=PkRRiXoNRCTEVDkjj3p8QJmpXGiWt6bxoj42JdeBRJA=;
        b=WbaCL1qJFi8cgsk8JQPT7VBdmPmyfow74C+BDZf3+/2N3UQPYRhbpDNjAjfFjl1EFgDPL3fDRbwCjkyz/YA9gfoJhiJ5TEx9gUjIsehWDeXHQ3aN3k+g+D8gsCElewX+I5ocwx7nIXOp2Cirx61LXYG8CCdNRPctWq5hF4xBDkI=;
X-UUID: 2840c5bc17b04e2baed5745518effb61-20200217
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <chun-hung.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1677002943; Mon, 17 Feb 2020 14:33:16 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 17 Feb 2020 14:32:22 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 17 Feb 2020 14:32:50 +0800
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
Subject: [PATCH 4/4] [4/4] dt-bindings: mmc: mediatek: Add document for mt6779
Date:   Mon, 17 Feb 2020 14:31:51 +0800
Message-ID: <1581921111-24172-5-git-send-email-chun-hung.wu@mediatek.com>
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

QWRkIGNvbXBhdGlibGUgbm9kZSBmb3IgbXQ2Nzc5IG1tYw0KDQotLS0NCiBEb2N1bWVudGF0aW9u
L2RldmljZXRyZWUvYmluZGluZ3MvbW1jL210ay1zZC50eHQgfCAxICsNCiAxIGZpbGUgY2hhbmdl
ZCwgMSBpbnNlcnRpb24oKykNCg0KZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJl
ZS9iaW5kaW5ncy9tbWMvbXRrLXNkLnR4dCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5k
aW5ncy9tbWMvbXRrLXNkLnR4dA0KaW5kZXggOGE1MzJmNC4uMGM5Y2Y2YSAxMDA2NDQNCi0tLSBh
L0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tbWMvbXRrLXNkLnR4dA0KKysrIGIv
RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21tYy9tdGstc2QudHh0DQpAQCAtMTIs
NiArMTIsNyBAQCBSZXF1aXJlZCBwcm9wZXJ0aWVzOg0KIAkibWVkaWF0ZWssbXQ4MTczLW1tYyI6
IGZvciBtbWMgaG9zdCBpcCBjb21wYXRpYmxlIHdpdGggbXQ4MTczDQogCSJtZWRpYXRlayxtdDgx
ODMtbW1jIjogZm9yIG1tYyBob3N0IGlwIGNvbXBhdGlibGUgd2l0aCBtdDgxODMNCiAJIm1lZGlh
dGVrLG10ODUxNi1tbWMiOiBmb3IgbW1jIGhvc3QgaXAgY29tcGF0aWJsZSB3aXRoIG10ODUxNg0K
KwkibWVkaWF0ZWssbXQ2Nzc5LW1tYyI6IGZvciBtbWMgaG9zdCBpcCBjb21wYXRpYmxlIHdpdGgg
bXQ2Nzc5DQogCSJtZWRpYXRlayxtdDI3MDEtbW1jIjogZm9yIG1tYyBob3N0IGlwIGNvbXBhdGli
bGUgd2l0aCBtdDI3MDENCiAJIm1lZGlhdGVrLG10MjcxMi1tbWMiOiBmb3IgbW1jIGhvc3QgaXAg
Y29tcGF0aWJsZSB3aXRoIG10MjcxMg0KIAkibWVkaWF0ZWssbXQ3NjIyLW1tYyI6IGZvciBNVDc2
MjIgU29DDQotLSANCjEuOS4xDQo=

