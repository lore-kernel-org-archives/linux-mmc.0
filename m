Return-Path: <SRS0=jIX3=EI=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2FFAC00A89
	for <linux-mmc@archiver.kernel.org>; Mon,  2 Nov 2020 09:29:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93AB22223C
	for <linux-mmc@archiver.kernel.org>; Mon,  2 Nov 2020 09:29:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="GA2QqGK2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728004AbgKBJ3w (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 2 Nov 2020 04:29:52 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:40984 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727953AbgKBJ3w (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 2 Nov 2020 04:29:52 -0500
X-UUID: ee9e8cf0cd8b4c7c82686f8b4d0198cf-20201102
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=LjlcfGE879lSCElaLbbvTmu+Z+aZrJcBJfyjDgoE1O4=;
        b=GA2QqGK2nw84eD6jMw/TT0lKWbuDrPiFYc/HFkex3bBOvOHSHhxtNEnF+/JB8IYzEcHyg4vK3TC1T/3X2kpSa3OCx8/gsR91eXnMCKxjwZDVzRnQiHxX6dt1IACiN8LwlKCXFvYwRNc75XngkQys6CR7JodTimURQenYBT9say8=;
X-UUID: ee9e8cf0cd8b4c7c82686f8b4d0198cf-20201102
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <wenbin.mei@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 457154044; Mon, 02 Nov 2020 17:28:25 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 2 Nov 2020 17:28:24 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 2 Nov 2020 17:28:24 +0800
From:   Wenbin Mei <wenbin.mei@mediatek.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     Chaotian Jing <chaotian.jing@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-mmc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <srv_heupstream@mediatek.com>
Subject: [PATCH v1 0/1] Add HS400 enhanced strobe support
Date:   Mon, 2 Nov 2020 17:28:21 +0800
Message-ID: <20201102092822.5301-1-wenbin.mei@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

V2VuYmluIE1laSAoMSk6DQogIG1tYzogbWVkaWF0ZWs6IGFkZCBIUzQwMCBlbmhhbmNlZCBzdHJv
YmUgc3VwcG9ydA0KDQogZHJpdmVycy9tbWMvaG9zdC9tdGstc2QuYyB8IDQwICsrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KIDEgZmlsZSBjaGFuZ2VkLCA0MCBpbnNlcnRp
b25zKCspDQoNCi0tDQoyLjE4LjANCg==

