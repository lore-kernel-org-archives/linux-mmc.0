Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3D98C77B6C
	for <linux-mmc@archiver.kernel.org>; Sat,  8 Apr 2023 22:00:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229495AbjDHWAk (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sat, 8 Apr 2023 18:00:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjDHWAj (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 8 Apr 2023 18:00:39 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFA9455A1
        for <linux-mmc@vger.kernel.org>; Sat,  8 Apr 2023 15:00:37 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id t20so2261760lfd.5
        for <linux-mmc@vger.kernel.org>; Sat, 08 Apr 2023 15:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680991236;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5nydUHwsIwjtIyju2PPVdWDGkaHFsBAEFCxHgjn6c38=;
        b=o7QDfJtBk3tXHOEoou4q9FOBDB1hNBSTcVIuhUOc2NYgNXlxNOzU8NTQHmzhyBOxs/
         Hc72lhgqMXu/6SfdhFCIto4XGOCM0zcEirTLVbSPJvAv9dj9aWPfgGca2iisGXTa+Bwz
         qE9VXB25fsIi/xExwkKa+dELWqgr+1cbh5yWp0nD+OvI2T5c+LWbnl+WaoUy1rgarsBS
         OXOGzt8kFNU/LcaY7RnDqoZaYMU9StEsAwH29gOClQY4SfjRFOkTJrpivIRadwvVwHAw
         s4++l06b6jMkA569csDPQQfDYdNkU5iPj40V7Zmruno48fTDa1zFTJaIKhrngl7i9nBP
         6img==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680991236;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5nydUHwsIwjtIyju2PPVdWDGkaHFsBAEFCxHgjn6c38=;
        b=6AawZfU7B32crzP1PPrrHQrXvAzRWw0SQCR9JSYyLWUsM0Zw2CHIzGNeDdMNMhTh+b
         KcJY0MEDZyQTaSdJC6Dw6OkTU/ZZ2YNwi7o9lZIhjal5mKTL7dWmAd3NsStmVrwVPoI5
         2F1RtlCEW738XQvtDWxW+XlxCRSayCEMeHnGANT0AL4V7q181RFfLldRQAVu5RzLxIRn
         9sXShYhD/XPbDrmWW8w9VNCt2lPfPWVHF4KW5Q1QssDfn88+kNSa02TYbw8XfJ8CtPfP
         LTDwQC3VLdQdT6CR1LP/ZSm5xPCOsQevE8UJHLySqpSbCuiJvxqmKVAvih5vahlEZuvP
         +oFw==
X-Gm-Message-State: AAQBX9eDHWdhJQT+T1faWo0qACjO+DIvT6x+VBodU8crkbXkhCzksHx+
        awTlohrbGgwiyLQEmV+WFPQ+Hg==
X-Google-Smtp-Source: AKy350azw0lQFoJtbHGZb4b39JvnxqRzxzCjAtZiWUW4js1hCbiF1B1tHHNT7s5to9J8iBxLTeOcWQ==
X-Received: by 2002:ac2:4d11:0:b0:4db:25f2:c116 with SMTP id r17-20020ac24d11000000b004db25f2c116mr2068158lfi.18.1680991236063;
        Sat, 08 Apr 2023 15:00:36 -0700 (PDT)
Received: from [192.168.1.2] (c-05d8225c.014-348-6c756e10.bbcust.telenor.se. [92.34.216.5])
        by smtp.gmail.com with ESMTPSA id v9-20020a056512048900b004e9cad1cd7csm1328904lfq.229.2023.04.08.15.00.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Apr 2023 15:00:35 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 09 Apr 2023 00:00:23 +0200
Subject: [PATCH v2 02/12] mmc: mmci: Unwind big if() clause
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230405-pl180-busydetect-fix-v2-2-eeb10323b546@linaro.org>
References: <20230405-pl180-busydetect-fix-v2-0-eeb10323b546@linaro.org>
In-Reply-To: <20230405-pl180-busydetect-fix-v2-0-eeb10323b546@linaro.org>
To:     Yann Gautier <yann.gautier@foss.st.com>,
        Stefan Hansson <newbyte@disroot.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc:     linux-mmc@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.0
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

This does two things: firsr replace the hard-to-read long
if-expression:

  if (!host->busy_status && !(status & err_msk) &&
      (readl(base + MMCISTATUS) & host->variant->busy_detect_flag)) {

With the more readable:

  if (!host->busy_status && !(status & err_msk)) {
     status = readl(base + MMCISTATUS);
     if (status & host->variant->busy_detect_flag) {

Second notice that the re-read MMCISTATUS register is now
stored into the status variable, using logic OR because what
if something else changed too?

While we are at it, explain what the function is doing.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- Only assign the cached status in host->busy_status if
  we have busy detect signalling going on.
---
 drivers/mmc/host/mmci.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 9b48df842425..8496df2020d9 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -654,6 +654,13 @@ static u32 ux500v2_get_dctrl_cfg(struct mmci_host *host)
 	return MCI_DPSM_ENABLE | (host->data->blksz << 16);
 }
 
+/*
+ * ux500_busy_complete() - this will wait until the busy status
+ * goes off, saving any status that occur in the meantime into
+ * host->busy_status until we know the card is not busy any more.
+ * The function returns true when the busy detection is ended
+ * and we should continue processing the command.
+ */
 static bool ux500_busy_complete(struct mmci_host *host, u32 status, u32 err_msk)
 {
 	void __iomem *base = host->base;
@@ -671,14 +678,16 @@ static bool ux500_busy_complete(struct mmci_host *host, u32 status, u32 err_msk)
 	 * while, to allow it to be set, but tests indicates that it
 	 * isn't needed.
 	 */
-	if (!host->busy_status && !(status & err_msk) &&
-	    (readl(base + MMCISTATUS) & host->variant->busy_detect_flag)) {
-		writel(readl(base + MMCIMASK0) |
-		       host->variant->busy_detect_mask,
-		       base + MMCIMASK0);
+	if (!host->busy_status && !(status & err_msk)) {
+		status = readl(base + MMCISTATUS);
+		if (status & host->variant->busy_detect_flag) {
+			writel(readl(base + MMCIMASK0) |
+			       host->variant->busy_detect_mask,
+			       base + MMCIMASK0);
 
-		host->busy_status = status & (MCI_CMDSENT | MCI_CMDRESPEND);
-		return false;
+			host->busy_status = status & (MCI_CMDSENT | MCI_CMDRESPEND);
+			return false;
+		}
 	}
 
 	/*

-- 
2.39.2

