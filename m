Return-Path: <SRS0=t5qd=3K=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6F26C33CAA
	for <linux-mmc@archiver.kernel.org>; Tue, 21 Jan 2020 07:21:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E3B522522
	for <linux-mmc@archiver.kernel.org>; Tue, 21 Jan 2020 07:21:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="pFlzyxHo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725890AbgAUHVc (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 21 Jan 2020 02:21:32 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:3173 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725789AbgAUHVc (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 21 Jan 2020 02:21:32 -0500
X-UUID: 57ebe05eca894da19a48dfaa0779a4d8-20200121
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=AEp2wHIess4/ILGCkyl2C/BzMPPTKjrRdre9MKipK4A=;
        b=pFlzyxHoxin/bt5RDOzjvzkDtI+4Rf0KnsBwG18KSG6HL/HJhoHQVn2arRg9HmnPzbd8UqqUMQ9fp53QytaJlXnGJbH6Jg6IMjV6g4uhkke7+K0fzNpzGxz8gH/ycSI/NusvnsctyT73alUh9mzhzizPg/+OGwo4oBYi5+NDGME=;
X-UUID: 57ebe05eca894da19a48dfaa0779a4d8-20200121
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <yong.mao@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1738107707; Tue, 21 Jan 2020 15:21:27 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 21 Jan 2020 15:20:53 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 21 Jan 2020 15:19:12 +0800
From:   Yong Mao <yong.mao@mediatek.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     Chaotian Jing <chaotian.jing@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-mmc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <srv_heupstream@mediatek.com>
Subject: [PATCH] mmc: mediatek: fix SDIO irq issue
Date:   Tue, 21 Jan 2020 15:20:57 +0800
Message-ID: <1579591258-30940-1-git-send-email-yong.mao@mediatek.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

eW9uZyBtYW8gKDEpOg0KICBtbWM6IG1lZGlhdGVrOiBmaXggU0RJTyBpcnEgaXNzdWUNCg0KIGRy
aXZlcnMvbW1jL2hvc3QvbXRrLXNkLmMgfCAzOCArKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKw0KIDEgZmlsZSBjaGFuZ2VkLCAzOCBpbnNlcnRpb25zKCspDQoNCi0tIA0KMi4y
NC4xDQo=

