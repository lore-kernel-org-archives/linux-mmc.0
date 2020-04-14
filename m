Return-Path: <SRS0=djOR=56=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6223FC2BB1D
	for <linux-mmc@archiver.kernel.org>; Tue, 14 Apr 2020 03:41:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1659F206C0
	for <linux-mmc@archiver.kernel.org>; Tue, 14 Apr 2020 03:40:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="jzD7fvwa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404882AbgDNDk7 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 13 Apr 2020 23:40:59 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:17287 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2404875AbgDNDk7 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 13 Apr 2020 23:40:59 -0400
X-UUID: 344a3ead54e64d4eac2fd6ca9645b960-20200414
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=lZk7qtXX5SljhlQi4LWZc844oiypHsd54Xbib8jcjgc=;
        b=jzD7fvwaNUCO2X3hO1in4mLfxNhAvGpYH1XrYw7wvjVIBtsJ1UXLdYYQ4lDTKKpwYPvZ1lxaswCV6pLwRb+N5IIc8RdhA+q2Doou+UE6H0Rf99tfvh+U3I6vPt+mNwjqGlqPhdGcPmM1kurenlHGQ50JWR3Q246j1AUC88twWIg=;
X-UUID: 344a3ead54e64d4eac2fd6ca9645b960-20200414
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <yong.mao@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 394519622; Tue, 14 Apr 2020 11:40:54 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 14 Apr 2020 11:40:53 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 14 Apr 2020 11:40:48 +0800
From:   Yong Mao <yong.mao@mediatek.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     Chaotian Jing <chaotian.jing@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-mmc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <srv_heupstream@mediatek.com>
Subject: Fix sdio reinit card fail issue 
Date:   Tue, 14 Apr 2020 11:40:08 +0800
Message-ID: <1586835611-13857-1-git-send-email-yong.mao@mediatek.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

U29tZSBVSFMgc2RpbyBkZXZpY2VzIGNhbid0IGVudGVyIHRvIHN0YWJsZSBzdGF0ZSBhZnRlciBj
aGFuZ2luZw0KdGhlIHZvbHRhZ2UgZnJvbSAxLjh2IHRvIDMuM3YgaW4gcmUtaW5pdGlhbGl6ZSBm
bG93LiBOZWVkIGRvIHNvbWUNCmVycm9yIGhhbmRsZSB0byByZWNvdmVyeSBTRElPIGRldmljZS4N
Cg==

