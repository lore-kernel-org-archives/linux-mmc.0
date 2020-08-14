Return-Path: <SRS0=tY5E=BY=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D388AC433DF
	for <linux-mmc@archiver.kernel.org>; Fri, 14 Aug 2020 01:44:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC6502078B
	for <linux-mmc@archiver.kernel.org>; Fri, 14 Aug 2020 01:44:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="FaXMGN/3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726684AbgHNBox (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 13 Aug 2020 21:44:53 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:58090 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726546AbgHNBow (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 13 Aug 2020 21:44:52 -0400
X-UUID: e1acfdc0286e42a6be40b2c1d651f5b8-20200814
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=UiYITuOicKAGf3efIhr1L/4MAUvnnb66uoIfzUsZtVU=;
        b=FaXMGN/3mu9mRGovc/79GkziTta5xdIK0GO1fg+tRTEEpx44eRGneQPqOmtiyqdcsd7yCUpTmR7097y3RKkS2XMxNAC8ikJrA7MQjkORMWi6IMYcRCxbx7J7apOygDVwSDAS8yyF+I6tOFhuxJGsADOELLoWqLbUJF2Pub3yorQ=;
X-UUID: e1acfdc0286e42a6be40b2c1d651f5b8-20200814
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw02.mediatek.com
        (envelope-from <wenbin.mei@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1305036608; Fri, 14 Aug 2020 09:44:48 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 14 Aug 2020 09:44:46 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 14 Aug 2020 09:44:45 +0800
From:   Wenbin Mei <wenbin.mei@mediatek.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     Chaotian Jing <chaotian.jing@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <srv_heupstream@mediatek.com>,
        Wenbin Mei <wenbin.mei@mediatek.com>, <stable@vger.kernel.org>
Subject: [v5,1/3] mmc: dt-bindings: Add resets/reset-names for Mediatek MMC bindings
Date:   Fri, 14 Aug 2020 09:43:44 +0800
Message-ID: <20200814014346.6496-2-wenbin.mei@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200814014346.6496-1-wenbin.mei@mediatek.com>
References: <20200814014346.6496-1-wenbin.mei@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

QWRkIGRlc2NyaXB0aW9uIGZvciByZXNldHMvcmVzZXQtbmFtZXMuDQoNCkNjOiA8c3RhYmxlQHZn
ZXIua2VybmVsLm9yZz4gIyB2NS40Kw0KRml4ZXM6IDk2NjU4MGFkMjM2ZSAoIm1tYzogbWVkaWF0
ZWs6IGFkZCBzdXBwb3J0IGZvciBNVDc2MjIgU29DIikNClNpZ25lZC1vZmYtYnk6IFdlbmJpbiBN
ZWkgPHdlbmJpbi5tZWlAbWVkaWF0ZWsuY29tPg0KVGVzdGVkLWJ5OiBGcmFuayBXdW5kZXJsaWNo
IDxmcmFuay13QHB1YmxpYy1maWxlcy5kZT4NCi0tLQ0KIERvY3VtZW50YXRpb24vZGV2aWNldHJl
ZS9iaW5kaW5ncy9tbWMvbXRrLXNkLnR4dCB8IDIgKysNCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNl
cnRpb25zKCspDQoNCmRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGlu
Z3MvbW1jL210ay1zZC50eHQgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbW1j
L210ay1zZC50eHQNCmluZGV4IDhhNTMyZjQ0NTNmMi4uMDlhZWNlYzQ3MDAzIDEwMDY0NA0KLS0t
IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21tYy9tdGstc2QudHh0DQorKysg
Yi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbW1jL210ay1zZC50eHQNCkBAIC00
OSw2ICs0OSw4IEBAIE9wdGlvbmFsIHByb3BlcnRpZXM6DQogCQkgICAgIGVycm9yIGNhdXNlZCBi
eSBzdG9wIGNsb2NrKGZpZm8gZnVsbCkNCiAJCSAgICAgVmFsaWQgcmFuZ2UgPSBbMDoweDddLiBp
ZiBub3QgcHJlc2VudCwgZGVmYXVsdCB2YWx1ZSBpcyAwLg0KIAkJICAgICBhcHBsaWVkIHRvIGNv
bXBhdGlibGUgIm1lZGlhdGVrLG10MjcwMS1tbWMiLg0KKy0gcmVzZXRzOiBQaGFuZGxlIGFuZCBy
ZXNldCBzcGVjaWZpZXIgcGFpciB0byBzb2Z0cmVzZXQgbGluZSBvZiBNU0RDIElQLg0KKy0gcmVz
ZXQtbmFtZXM6IFNob3VsZCBiZSAiaHJzdCIuDQogDQogRXhhbXBsZXM6DQogbW1jMDogbW1jQDEx
MjMwMDAwIHsNCi0tIA0KMi4xOC4wDQo=

