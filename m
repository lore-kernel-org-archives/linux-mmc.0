Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECBF5C77B6C
	for <linux-mmc@archiver.kernel.org>; Sat,  8 Apr 2023 22:00:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbjDHWAr (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sat, 8 Apr 2023 18:00:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjDHWAo (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 8 Apr 2023 18:00:44 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AB4872A2
        for <linux-mmc@vger.kernel.org>; Sat,  8 Apr 2023 15:00:42 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id e11so2231950lfc.10
        for <linux-mmc@vger.kernel.org>; Sat, 08 Apr 2023 15:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680991240;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=68Rc2WXbmYgQ43B8wxGeYxLEsTfSBnBHmmvyKE+wjgE=;
        b=Jng6vM67VkLbQpEqx8soGTvigQAOITwa4rDGWidfa2GHkOXL86H3Vq1tRTtiU6vA4G
         P5WvV6/xJ1NRw98f2cY+/GZgPFodUaspwGjMFtctx17JbDn9My2G88RztkuimPoDcboV
         swYRndtqyjuBLAmHXEFVVZep5N/aUo1QZuBZ6mCy5sB7BIbDLJwEcNLBgAVuFQyodkBN
         ev/bm768A0Dve3wQab2svqiatzbiAdl3INZQOkHU1MXLzERHwNFy4FNAH8hV1/d3JFMc
         9VynWj09z6ZLRgbvCkgUNwJSrO7+sOpiktCRhJMQxrJfp8qbWzVNTNJgQozoKWvn54tF
         8nRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680991240;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=68Rc2WXbmYgQ43B8wxGeYxLEsTfSBnBHmmvyKE+wjgE=;
        b=tY0+msS6LPnFw/0CuQ7JxPhS1sgKKbrniZ7/F1+FNpVvuRW362z7Wj2fSRTnKDIMNb
         MAzFAfYbouNs7pZCcLC3x88n7LpyPRU+OlqYS1sJODpiQi0ZoEnezPxZk3xCoJv+FE2A
         6AJYUhyDd1t3jiSrX0DUGL6w/ZiZUWfRChHGGAyCmtxUNKVapMkCApacY/GbBN3H1Yb5
         faLfxDNytrg6aRa+MRIKnnBVGIyqAPRGmUzySB8rmdSLRtJ3XKikJ64AUkFGnjDu+KHz
         j+RxqP4msNMuvqYcM2AOUKG12gkSUSmDGESiR9Z7I2V6GCVSgTS+VU++8IsfKrAWqibH
         nY7Q==
X-Gm-Message-State: AAQBX9eFNwth37BaEBnKAZ3IPZnVcT/dPMbf6exnBG5+7znoChPAMlYz
        OGpmumtuCdyEzxTa1Tt/mwD5mgqOvkq3d2AGv2g=
X-Google-Smtp-Source: AKy350YlfCdenr9RWRKwBxE0XtY7Fl0xZTzRe9Mb8WEbRjfGWi9vUwzBUMckkJButIQ1kGSAgitciQ==
X-Received: by 2002:ac2:47ec:0:b0:4e0:a426:6ddc with SMTP id b12-20020ac247ec000000b004e0a4266ddcmr1890164lfp.0.1680991240796;
        Sat, 08 Apr 2023 15:00:40 -0700 (PDT)
Received: from [192.168.1.2] (c-05d8225c.014-348-6c756e10.bbcust.telenor.se. [92.34.216.5])
        by smtp.gmail.com with ESMTPSA id v9-20020a056512048900b004e9cad1cd7csm1328904lfq.229.2023.04.08.15.00.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Apr 2023 15:00:40 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 09 Apr 2023 00:00:28 +0200
Subject: [PATCH v2 07/12] mmc: mmci: Use state machine state as exit
 condition
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230405-pl180-busydetect-fix-v2-7-eeb10323b546@linaro.org>
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

Return true if and only if we reached the state
MMCI_BUSY_DONE in the ux500 ->busy_complete() callback.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- No changes
---
 drivers/mmc/host/mmci.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 590703075bbc..2689c6bb62d6 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -673,7 +673,7 @@ static bool ux500_busy_complete(struct mmci_host *host, u32 status, u32 err_msk)
 		       ~host->variant->busy_detect_mask, base + MMCIMASK0);
 		host->busy_state = MMCI_BUSY_DONE;
 		host->busy_status = 0;
-		return true;
+		goto out_ret_state;
 	}
 
 	/*
@@ -704,7 +704,7 @@ static bool ux500_busy_complete(struct mmci_host *host, u32 status, u32 err_msk)
 				/* Keep accumulating status bits */
 				host->busy_status |= status & (MCI_CMDSENT | MCI_CMDRESPEND);
 				host->busy_state = MMCI_BUSY_WAITING_FOR_IRQS;
-				return false;
+				goto out_ret_state;
 			}
 			retries--;
 		}
@@ -713,8 +713,7 @@ static bool ux500_busy_complete(struct mmci_host *host, u32 status, u32 err_msk)
 		writel(readl(base + MMCIMASK0) &
 		       ~host->variant->busy_detect_mask, base + MMCIMASK0);
 		host->busy_state = MMCI_BUSY_DONE;
-		host->busy_status = 0;
-		return true;
+		goto out_ret_state;
 	}
 
 	/*
@@ -733,7 +732,7 @@ static bool ux500_busy_complete(struct mmci_host *host, u32 status, u32 err_msk)
 			host->busy_status |= status & (MCI_CMDSENT | MCI_CMDRESPEND);
 			writel(host->variant->busy_detect_mask, base + MMCICLEAR);
 			host->busy_state = MMCI_BUSY_START_IRQ;
-			return false;
+			goto out_ret_state;
 		} else {
 			dev_dbg(mmc_dev(host->mmc),
 				"lost busy status when waiting for busy start IRQ\n");
@@ -742,7 +741,7 @@ static bool ux500_busy_complete(struct mmci_host *host, u32 status, u32 err_msk)
 			       ~host->variant->busy_detect_mask, base + MMCIMASK0);
 			host->busy_state = MMCI_BUSY_DONE;
 			host->busy_status = 0;
-			return true;
+			goto out_ret_state;
 		}
 	}
 
@@ -751,7 +750,7 @@ static bool ux500_busy_complete(struct mmci_host *host, u32 status, u32 err_msk)
 			host->busy_status |= status & (MCI_CMDSENT | MCI_CMDRESPEND);
 			writel(host->variant->busy_detect_mask, base + MMCICLEAR);
 			host->busy_state = MMCI_BUSY_END_IRQ;
-			return false;
+			goto out_ret_state;
 		} else {
 			dev_dbg(mmc_dev(host->mmc),
 				"lost busy status when waiting for busy end IRQ\n");
@@ -760,7 +759,7 @@ static bool ux500_busy_complete(struct mmci_host *host, u32 status, u32 err_msk)
 			       ~host->variant->busy_detect_mask, base + MMCIMASK0);
 			host->busy_state = MMCI_BUSY_DONE;
 			host->busy_status = 0;
-			return true;
+			goto out_ret_state;
 		}
 	}
 
@@ -774,7 +773,7 @@ static bool ux500_busy_complete(struct mmci_host *host, u32 status, u32 err_msk)
 		if (status & host->variant->busy_detect_flag) {
 			/* We should just get two IRQs for busy detect */
 			dev_err(mmc_dev(host->mmc), "spurious busy detect IRQ\n");
-			return false;
+			goto out_ret_state;
 		}
 
 		writel(host->variant->busy_detect_mask, base + MMCICLEAR);
@@ -783,9 +782,13 @@ static bool ux500_busy_complete(struct mmci_host *host, u32 status, u32 err_msk)
 
 		host->busy_state = MMCI_BUSY_DONE;
 		host->busy_status = 0;
+	} else {
+		dev_dbg(mmc_dev(host->mmc), "fell through on state %d\n",
+			host->busy_state);
 	}
 
-	return true;
+out_ret_state:
+	return (host->busy_state == MMCI_BUSY_DONE);
 }
 
 /*

-- 
2.39.2

