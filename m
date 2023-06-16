Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3444EB64D7
	for <linux-mmc@archiver.kernel.org>; Fri, 16 Jun 2023 08:30:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245115AbjFPIar (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 16 Jun 2023 04:30:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245419AbjFPIan (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 16 Jun 2023 04:30:43 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 567972D7F
        for <linux-mmc@vger.kernel.org>; Fri, 16 Jun 2023 01:30:42 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4f762b3227dso651989e87.1
        for <linux-mmc@vger.kernel.org>; Fri, 16 Jun 2023 01:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686904240; x=1689496240;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cWdIfBnqggtpxe/X8Z+ZH/SZJCqCCQqCNdgmsOsdMhQ=;
        b=qmOTDNzkugpHumXZcoh3VoKKpvZrpMUikuhc3B4jPLE7z7gO+TTBIY05aggGcO54xQ
         wU3QICVn/5gNcAFjEP4j0pjO+yWxrP2ty0CHUqxR0lc4N+xKdeWHGmY9c8XdWWSvqlUD
         rIlDwRSLQWkULjK17eeUlLBYn6n7bIuBi4WzBH6+G6e5V7S0FEDGZp/GCiIU1WXomPXy
         lvhEFZFw1tyUw8DFrDZGAUbYmL25lOP8ONPgPq1gT7EiH3EobN31sF5FVFtJTRgpTnCy
         dASrK/+1dslsV9ZY7Lwyhshts/b9M6oLKwCt3v8XEykgjfZa/dZW0NtXvCHY3i4m2Eek
         xwEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686904240; x=1689496240;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cWdIfBnqggtpxe/X8Z+ZH/SZJCqCCQqCNdgmsOsdMhQ=;
        b=Jw/dQj0qQ3WlRWEcfb+mQhvAK/K3XSkTOIQvgz2CeO5r8dFu7BR3adiQbRTUiXqKy/
         prxH+IWwhs6huKDRqZ0hqcM2NX3UDMLVx0fjW+qjN04jA8J6FvU5RbebeuHCVc7kxe4a
         VYaEtIn6rzaBlJ+JT3fhkOw+HYczPiY5zqwk0VrapjibB6Y/GhQoBHfJSKxODjYcPjXf
         tMvxrBxUvut5Tq01XdbWimzttWUUnMBUGRd5ZGt2ePbarMRkMnyY3g+OkwOhXuEikScM
         AIXOmDtC6HZXnttrj1dAmRigM4ykZg7q9Bd8bx/IF3GrflfGjecfyDxWNUwTA+R2XXF6
         9RNg==
X-Gm-Message-State: AC+VfDwGrtUr2owGX2dlbgoYHpmh3KRFLJfIrngbWfb6E8s1G4lzSpEu
        inHhff5o/tFwdJtcsrjWc7UWBA==
X-Google-Smtp-Source: ACHHUZ7PjDest9LjXsbK3niqA/tyRClWCXZwHuonUF6zUKXU4gYd6oXf3Sg3iFzSyuX3rHGdiFJTbQ==
X-Received: by 2002:a19:6910:0:b0:4f6:43ac:d28d with SMTP id e16-20020a196910000000b004f643acd28dmr346466lfc.33.1686904240696;
        Fri, 16 Jun 2023 01:30:40 -0700 (PDT)
Received: from [192.168.1.2] (c-05d8225c.014-348-6c756e10.bbcust.telenor.se. [92.34.216.5])
        by smtp.gmail.com with ESMTPSA id j8-20020ac25508000000b004eb44c2ab6bsm2918106lfk.294.2023.06.16.01.30.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jun 2023 01:30:40 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 16 Jun 2023 10:30:38 +0200
Subject: [PATCH v6 6/9] mmc: mmci: Retry the busy start condition
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230405-pl180-busydetect-fix-v6-6-b850ec8019f3@linaro.org>
References: <20230405-pl180-busydetect-fix-v6-0-b850ec8019f3@linaro.org>
In-Reply-To: <20230405-pl180-busydetect-fix-v6-0-b850ec8019f3@linaro.org>
To:     Yann Gautier <yann.gautier@foss.st.com>,
        Stefan Hansson <newbyte@disroot.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc:     linux-mmc@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.2
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

This makes the ux500 ->busy_complete() callback re-read
the status register 10 times while waiting for the busy
signal to assert in the status register.

If this does not happen, we bail out regarding the
command completed already, i.e. before we managed to
start to check the busy status.

There is a comment in the code about this, let's just
implement it to be certain that we can catch this glitch
if it happens.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v4->v6:
- No changes.
ChangeLog v3->v4:
- Accumulate status flags outside the if()-clause in the
  busy detect retry loop.
ChangeLog v2->v3:
- Rebased.
ChangeLog v1->v2:
- Move over the initial saving of host->busy_status from
  an unrelated patch to this one: it is clear what we are
  doing: we don't want to miss any transient
  (MCI_CMDSENT | MCI_CMDRESPEND) in the status register.
---
 drivers/mmc/host/mmci.c | 39 +++++++++++++++++++++++++++------------
 1 file changed, 27 insertions(+), 12 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index ccfca055f9a1..6ae56c973b0d 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -664,6 +664,7 @@ static u32 ux500v2_get_dctrl_cfg(struct mmci_host *host)
 static bool ux500_busy_complete(struct mmci_host *host, u32 status, u32 err_msk)
 {
 	void __iomem *base = host->base;
+	int retries = 10;
 
 	if (status & err_msk) {
 		/* Stop any ongoing busy detection if an error occurs */
@@ -684,21 +685,35 @@ static bool ux500_busy_complete(struct mmci_host *host, u32 status, u32 err_msk)
 	 * Note that, the card may need a couple of clock cycles before
 	 * it starts signaling busy on DAT0, hence re-read the
 	 * MMCISTATUS register here, to allow the busy bit to be set.
-	 * Potentially we may even need to poll the register for a
-	 * while, to allow it to be set, but tests indicates that it
-	 * isn't needed.
 	 */
 	if (host->busy_state == MMCI_BUSY_DONE) {
-		status = readl(base + MMCISTATUS);
-		if (status & host->variant->busy_detect_flag) {
-			writel(readl(base + MMCIMASK0) |
-			       host->variant->busy_detect_mask,
-			       base + MMCIMASK0);
-
-			host->busy_status = status & (MCI_CMDSENT | MCI_CMDRESPEND);
-			host->busy_state = MMCI_BUSY_WAITING_FOR_START_IRQ;
-			return false;
+		/*
+		 * Save the first status register read to be sure to catch
+		 * all bits that may be lost will retrying. If the command
+		 * is still busy this will result in assigning 0 to
+		 * host->busy_status, which is what it should be in IDLE.
+		 */
+		host->busy_status = status & (MCI_CMDSENT | MCI_CMDRESPEND);
+		while (retries) {
+			status = readl(base + MMCISTATUS);
+			/* Keep accumulating status bits */
+			host->busy_status |= status & (MCI_CMDSENT | MCI_CMDRESPEND);
+			if (status & host->variant->busy_detect_flag) {
+				writel(readl(base + MMCIMASK0) |
+				       host->variant->busy_detect_mask,
+				       base + MMCIMASK0);
+				host->busy_state = MMCI_BUSY_WAITING_FOR_START_IRQ;
+				return false;
+			}
+			retries--;
 		}
+		dev_dbg(mmc_dev(host->mmc), "no busy signalling in time\n");
+		writel(host->variant->busy_detect_mask, base + MMCICLEAR);
+		writel(readl(base + MMCIMASK0) &
+		       ~host->variant->busy_detect_mask, base + MMCIMASK0);
+		host->busy_state = MMCI_BUSY_DONE;
+		host->busy_status = 0;
+		return true;
 	}
 
 	/*

-- 
2.40.1

