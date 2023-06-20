Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30C39EB64DB
	for <linux-mmc@archiver.kernel.org>; Tue, 20 Jun 2023 10:47:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232295AbjFTKrz (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 20 Jun 2023 06:47:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232301AbjFTKrs (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 20 Jun 2023 06:47:48 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5335E3
        for <linux-mmc@vger.kernel.org>; Tue, 20 Jun 2023 03:47:47 -0700 (PDT)
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 374C686359;
        Tue, 20 Jun 2023 12:47:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1687258066;
        bh=ZnnWoa3Bd9N8jj4RihC5dDZX+ySbFdQgnGriPTF8ymA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sKIiZVkWQw/KXFR+ACl7FhnK+rlo94BDa32a0dEoGA8+WNxNTcL2bcDtsq8CLf0sP
         bwald+W9Fkl9vLJ+sDFAcnr2MUKZzlVfLIsE6K88N1Y+lGzQyFibPvA9TKYEpT4gIa
         5t5+2tJ2jWvjKy/sCyY3vlJBFV+5T6Xt5mR0VT9WDOHBYoSA/JmKxxqRnRQUDp13fX
         YpatwLFkM+zMyvT1tmtS4vXznrikWNIas0OS3ZUw7asU6O91Nqz98D/J82pbmJcp2I
         gF6OwzvIe+W/ChtOGwadwLahE+SskWbZyzPZjEV2PCfeAP5FZlZYBr2lWFv1SxWhTu
         9RBJr3Nhz2/oQ==
From:   Marek Vasut <marex@denx.de>
To:     linux-mmc@vger.kernel.org
Cc:     Marek Vasut <marex@denx.de>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Avri Altman <avri.altman@wdc.com>, Bo Liu <liubo03@inspur.com>,
        Deren Wu <deren.wu@mediatek.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Pierre Ossman <pierre@ossman.eu>,
        Russell King <linux@armlinux.org.uk>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Yang Yingliang <yangyingliang@huawei.com>
Subject: [PATCH 11/11] mmc: wbsd: Use BIT() macro
Date:   Tue, 20 Jun 2023 12:47:22 +0200
Message-Id: <20230620104722.16465-11-marex@denx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230620104722.16465-1-marex@denx.de>
References: <20230620104722.16465-1-marex@denx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Use the BIT(n) macro instead of (1<<n), no functional change.
Regex 's@(1 \?<< \?\([0-9A-Z_]\+\))@BIT(\1)' .

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Avri Altman <avri.altman@wdc.com>
Cc: Bo Liu <liubo03@inspur.com>
Cc: Deren Wu <deren.wu@mediatek.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Pierre Ossman <pierre@ossman.eu>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Yang Yingliang <yangyingliang@huawei.com>
Cc: linux-mmc@vger.kernel.org
---
 drivers/mmc/host/wbsd.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/wbsd.h b/drivers/mmc/host/wbsd.h
index be30b4d8ce4c7..e78258d00b868 100644
--- a/drivers/mmc/host/wbsd.h
+++ b/drivers/mmc/host/wbsd.h
@@ -141,8 +141,8 @@ struct wbsd_host
 
 	int			flags;		/* Driver states */
 
-#define WBSD_FCARD_PRESENT	(1<<0)		/* Card is present */
-#define WBSD_FIGNORE_DETECT	(1<<1)		/* Ignore card detection */
+#define WBSD_FCARD_PRESENT	BIT(0)		/* Card is present */
+#define WBSD_FIGNORE_DETECT	BIT(1)		/* Ignore card detection */
 
 	struct mmc_request*	mrq;		/* Current request */
 
-- 
2.39.2

