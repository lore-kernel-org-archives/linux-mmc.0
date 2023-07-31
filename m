Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E08D9C41513
	for <linux-mmc@archiver.kernel.org>; Mon, 31 Jul 2023 08:39:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232079AbjGaIj2 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 31 Jul 2023 04:39:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232023AbjGaIjA (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 31 Jul 2023 04:39:00 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D4ACE5B;
        Mon, 31 Jul 2023 01:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=NogRc+PV5Ggqg3zuB9ufDe2OOc/ycxdytdzIcHbUmmE=; b=LnBJRrWLCidFZOfw/o0WLM6JbO
        a5PqWi1N1j5x3vvveGCItTRyv+xxUvBqQcPc44Y4kGy0bFdMyxp2Nc4ZsbNhzBa0ijkoTFO5NJga9
        1QwdoNnOQO8JKPHZ7ATsJSdpMrnl7629LUiyiWPdrI6/UVssAOYdRi/Ncg2FbkF4+t/aiCgLWIYzS
        W9x2f6EVNUpU/iuvwos6YmYMdJmRcdi5Ov3Kc7aa55xLGItypOxn7JPt1sCxoxknytEEbkW3ZQTt8
        2YudLQf4mgBxSPBjoWnNGKIIiuBkeE698M9f3Qw5xIYicWrIQJF1amInOj3GDbUE2//dGJT7eA2KY
        clnLosvA==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qQOPt-00EYrF-2B;
        Mon, 31 Jul 2023 08:38:14 +0000
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
Subject: [PATCH 1/5] ARM/pxa: use EXPORT_SYMBOL_GPL for sharpsl_battery_kick
Date:   Mon, 31 Jul 2023 10:38:02 +0200
Message-Id: <20230731083806.453036-2-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230731083806.453036-1-hch@lst.de>
References: <20230731083806.453036-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

sharpsl_battery_kick is only used via symbol_get, which was only ever
intended for very internal symbols like this one.  Use EXPORT_SYMBOL_GPL
for it so that symbol_get can enforce only being used on
EXPORT_SYMBOL_GPL symbols.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/arm/mach-pxa/sharpsl_pm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-pxa/sharpsl_pm.c b/arch/arm/mach-pxa/sharpsl_pm.c
index d29bdcd5270e0f..08eec58632c988 100644
--- a/arch/arm/mach-pxa/sharpsl_pm.c
+++ b/arch/arm/mach-pxa/sharpsl_pm.c
@@ -216,7 +216,7 @@ void sharpsl_battery_kick(void)
 {
 	schedule_delayed_work(&sharpsl_bat, msecs_to_jiffies(125));
 }
-EXPORT_SYMBOL(sharpsl_battery_kick);
+EXPORT_SYMBOL_GPL(sharpsl_battery_kick);
 
 
 static void sharpsl_battery_thread(struct work_struct *private_)
-- 
2.39.2

