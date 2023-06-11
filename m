Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2B7FC7EE23
	for <linux-mmc@archiver.kernel.org>; Sun, 11 Jun 2023 19:41:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233752AbjFKTlw (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 11 Jun 2023 15:41:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232630AbjFKTlu (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 11 Jun 2023 15:41:50 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18C42D2
        for <linux-mmc@vger.kernel.org>; Sun, 11 Jun 2023 12:41:49 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4f61b45ee0dso4160146e87.0
        for <linux-mmc@vger.kernel.org>; Sun, 11 Jun 2023 12:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686512507; x=1689104507;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jb6D+kyxjkuniw+/i6BXNpuEvbzBFiePmlC8MrIMF84=;
        b=ueBKRNSj+qiOglYdOAP1NmAJnT4q2z4Ep1yygyyM5QRiFarezlroh/ou7p6rm8MZ6w
         nP+wis0Ox4JspfWfonVcByZdJxGFMy8eyMwGFaPQTNtU90BtTBTrd8K5CuYXOgA/rvft
         a9oM8OL74JRbkYe1+XgVikMGJvHkDZ3M2qRLoEdVI24EKbCV4QuWw+NROf1BS9okGPOJ
         2CjaEdeqLQXRWb8cwVoWyBJus/pRwQ49EQ3uuzE5Hwcbl+W3c8Qj1SBWqkPBi2U59fMo
         /za7FKKny9gkld3v4fbNigf08RtD5n/mdc4Kt7Z/xVrsYlLbS60QY7/vrDeLStL+05gH
         lG6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686512507; x=1689104507;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jb6D+kyxjkuniw+/i6BXNpuEvbzBFiePmlC8MrIMF84=;
        b=a3AHSChPhZeh8SjjbDW0zK0eWpb3KuawfLPyx1P45f5bIUz76qIyhowDf0tbHsdudj
         bTQdbVHcd9hVKTFitcoz248p+7JP60gBtTe1KSW4kti6CffIEg/BXFKfFt9HHxdoAT2r
         nQkiyfLQv8QNOMtjm4rtvPD3SS9kwlhvQSiI3JB/IZ5Kd5S02kGuOU13CLqn+WFFC9Gj
         Ytw8qawjsZ54QkehMFxFdT/p9Pk16S9BhTKE578q2tpXkhtIVsynHozGl8LqfLzstEon
         cCzFhuJuu1uecVutLmgtyu8KR0myyWJOWG9+6vrAmUV5PWrfXb954LJgGwGU6VAaNYdH
         CpSw==
X-Gm-Message-State: AC+VfDy8ym8IBIiyZ/FL4kKnzNYvKcS0bBViObbxxkmExpJ4ngKNyR0w
        9C2RazTv6qyVYswogBqWcca+lg==
X-Google-Smtp-Source: ACHHUZ7jNFBqqbCOkEvQqb29hL+y2cNlyTFSgIIk2Xq0bkD4rLIG8OBydLrmkNXcaYonBXkhtvXHLQ==
X-Received: by 2002:a19:7b04:0:b0:4f3:b61a:a941 with SMTP id w4-20020a197b04000000b004f3b61aa941mr2822391lfc.51.1686512507448;
        Sun, 11 Jun 2023 12:41:47 -0700 (PDT)
Received: from [192.168.1.2] (c-05d8225c.014-348-6c756e10.bbcust.telenor.se. [92.34.216.5])
        by smtp.gmail.com with ESMTPSA id u24-20020ac243d8000000b004f14ae5ded8sm1246960lfl.28.2023.06.11.12.41.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jun 2023 12:41:46 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 11 Jun 2023 21:41:33 +0200
Subject: [PATCH v3 07/10] mmc: mmci: Use state machine state as exit
 condition
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230405-pl180-busydetect-fix-v3-7-cd3d5925ae64@linaro.org>
References: <20230405-pl180-busydetect-fix-v3-0-cd3d5925ae64@linaro.org>
In-Reply-To: <20230405-pl180-busydetect-fix-v3-0-cd3d5925ae64@linaro.org>
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

Return true if and only if we reached the state
MMCI_BUSY_DONE in the ux500 ->busy_complete() callback.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v2->v3:
- Rebased.
ChangeLog v1->v2:
- No changes
---
 drivers/mmc/host/mmci.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 2858d8d67129..fe928f8f4d8f 100644
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
 				host->busy_state = MMCI_BUSY_WAITING_FOR_START_IRQ;
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
 			host->busy_state = MMCI_BUSY_WAITING_FOR_END_IRQ;
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
 			host->busy_state = MMCI_BUSY_DONE;
-			return false;
+			goto out_ret_state;
 		} else {
 			dev_dbg(mmc_dev(host->mmc),
 				"lost busy status when waiting for busy end IRQ\n");
@@ -760,11 +759,14 @@ static bool ux500_busy_complete(struct mmci_host *host, u32 status, u32 err_msk)
 			       ~host->variant->busy_detect_mask, base + MMCIMASK0);
 			host->busy_state = MMCI_BUSY_DONE;
 			host->busy_status = 0;
-			return true;
+			goto out_ret_state;
 		}
 	}
 
 	return true;
+
+out_ret_state:
+	return (host->busy_state == MMCI_BUSY_DONE);
 }
 
 /*

-- 
2.40.1

