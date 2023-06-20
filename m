Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DED5EB64D8
	for <linux-mmc@archiver.kernel.org>; Tue, 20 Jun 2023 10:47:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232278AbjFTKrs (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 20 Jun 2023 06:47:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231191AbjFTKrq (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 20 Jun 2023 06:47:46 -0400
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15786E3
        for <linux-mmc@vger.kernel.org>; Tue, 20 Jun 2023 03:47:45 -0700 (PDT)
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 7E1028621C;
        Tue, 20 Jun 2023 12:47:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1687258063;
        bh=O1B5W8YRKbL28jB5zXlP6jQZRRvE9HyDOB/sGe8V4CY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QD+KZyJxLedJMxodMp1e+DHHNs+H/qEJn+cyQDhAwWWw40UW6slyt9z3APMMl+Wt3
         z28y6yruaXtG0jP5Uzgrru3GZeDtVehci33AK4DFQwbFHlBlNLhImZfCRAyjg4NJ8m
         UT8L0MfCK6zyH8HHcr0HXtTkFln6mM7LgIopEzBPdBnaW0kRJPLbq5y9z17j19iU4U
         fji+LJ09Fojk/J0ODdHtHjGroq9mYmkAJYVHYyBwJHZrqffFdIf+La9ohvHKVytLN6
         j+07yVQUFNQYDKAfwmABAOZO7vDZ1xcTiDJ1pqbaeiuUA9+N5SVcXptlCDG3X+Hid+
         jFx0gGu8aQzuA==
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
Subject: [PATCH 05/11] mmc: sd: Use BIT() macro
Date:   Tue, 20 Jun 2023 12:47:16 +0200
Message-Id: <20230620104722.16465-5-marex@denx.de>
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
 include/linux/mmc/sd.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/mmc/sd.h b/include/linux/mmc/sd.h
index 6727576a87555..6cf44c337e832 100644
--- a/include/linux/mmc/sd.h
+++ b/include/linux/mmc/sd.h
@@ -34,10 +34,10 @@
 #define SD_WRITE_EXTR_SINGLE     49   /* adtc [31:0]             R1  */
 
 /* OCR bit definitions */
-#define SD_OCR_S18R		(1 << 24)    /* 1.8V switching request */
+#define SD_OCR_S18R		BIT(24)    /* 1.8V switching request */
 #define SD_ROCR_S18A		SD_OCR_S18R  /* 1.8V switching accepted by card */
-#define SD_OCR_XPC		(1 << 28)    /* SDXC power control */
-#define SD_OCR_CCS		(1 << 30)    /* Card Capacity Status */
+#define SD_OCR_XPC		BIT(28)    /* SDXC power control */
+#define SD_OCR_CCS		BIT(30)    /* Card Capacity Status */
 
 /*
  * SD_SWITCH argument format:
-- 
2.39.2

