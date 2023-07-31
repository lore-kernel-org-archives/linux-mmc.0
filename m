Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE540C04A94
	for <linux-mmc@archiver.kernel.org>; Mon, 31 Jul 2023 08:39:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232105AbjGaIjd (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 31 Jul 2023 04:39:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232036AbjGaIjG (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 31 Jul 2023 04:39:06 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DF1F10C3;
        Mon, 31 Jul 2023 01:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=fSYCwKgFSxRsQnOiMkLD0aWXej2SXCzCx/mya3sKi5Y=; b=dV2+ZSbE5qs9f+j8izISuSCbf7
        KqznQUeNoA6VVk+gZp6aCH5p7R0Iu7mJiXj2prBIgqf8pvHqrUgYoBeXsqedQzBVNAmHVNVlskSwF
        9amCkoRDdyi7pFZUAcPBixlWpZS7aEosSV+UYseKR891VH43+Ub17SxeELAfnm4xzmyCBKVEWIxr4
        6MH4uHlIU9RmCc/1b2lGqy+xoeM3q4PJmM7LhJLdSY8MYO5nFSPtYwM1IV/OK2d/OHWzZhIFWNCiS
        CFJWfgZ5P6F4M0MQ8IKsmajylfs/JW4DNXMALyKYGrAvd2wAcAACcMfgoXYvkRxqQxKRGCxoSbypY
        as/KKrZg==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qQOQ0-00EYsE-1O;
        Mon, 31 Jul 2023 08:38:20 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Yangbo Lu <yangbo.lu@nxp.com>, Joshua Kinard <kumba@gentoo.org>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org (open list),
        linux-mmc@vger.kernel.org, netdev@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-modules@vger.kernel.org
Subject: [PATCH 3/5] rtc: ds1685: use EXPORT_SYMBOL_GPL for ds1685_rtc_poweroff
Date:   Mon, 31 Jul 2023 10:38:04 +0200
Message-Id: <20230731083806.453036-4-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230731083806.453036-1-hch@lst.de>
References: <20230731083806.453036-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

ds1685_rtc_poweroff is only used externally via symbol_get, which was
only ever intended for very internal symbols like this one.  Use
EXPORT_SYMBOL_GPL for it so that symbol_get can enforce only being used
on EXPORT_SYMBOL_GPL symbols.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/rtc/rtc-ds1685.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-ds1685.c b/drivers/rtc/rtc-ds1685.c
index 0f707be0eb87fa..04dbf35cf3b706 100644
--- a/drivers/rtc/rtc-ds1685.c
+++ b/drivers/rtc/rtc-ds1685.c
@@ -1432,7 +1432,7 @@ ds1685_rtc_poweroff(struct platform_device *pdev)
 		unreachable();
 	}
 }
-EXPORT_SYMBOL(ds1685_rtc_poweroff);
+EXPORT_SYMBOL_GPL(ds1685_rtc_poweroff);
 /* ----------------------------------------------------------------------- */
 
 
-- 
2.39.2

