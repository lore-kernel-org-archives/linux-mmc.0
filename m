Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85ACBC76188
	for <linux-mmc@archiver.kernel.org>; Wed,  5 Apr 2023 06:50:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236779AbjDEGuo (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 5 Apr 2023 02:50:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237022AbjDEGun (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 5 Apr 2023 02:50:43 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A41F4699
        for <linux-mmc@vger.kernel.org>; Tue,  4 Apr 2023 23:50:42 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id bi9so45296992lfb.12
        for <linux-mmc@vger.kernel.org>; Tue, 04 Apr 2023 23:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680677440;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SedxMfIaYADPukzZhH8Geg5DKkhSk0IMn5jBUH6WQ7c=;
        b=sKYVbnpmuCmXmd11jodJYOCxpGxuL4BUxhbyfMi7lHX+/WmeAsgbyeFU+pBvpdGJj/
         OSnbKCfMGCyjjWSZ38H+KyCuzhMLZaPq2YToZ9JW2ZxKAUrdZLm3wl4M3D/Oc9hXknUj
         XvMyrnjRXYdI7dr5Jn0/y9KDi2+GwG/aWmACwMLAj0GWVr5gX6qEM4bcFeDuLtomHt/3
         LPkjTMQtaPQRf5YNR2A0ManO7FtcQG3hpjQ+QSR7zoora7/kYXp85roBnnJbk0zfpjAd
         xLmaiHUU/GQ0jfvAQk+vTJdYYwrUdl2SDCYzAVe3a1pk95EgftcjpI94ROWB5gVnlQra
         WZ7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680677440;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SedxMfIaYADPukzZhH8Geg5DKkhSk0IMn5jBUH6WQ7c=;
        b=5tw7NOnbrtRqEIzSEpynF55U/hBq7zaCEvc/ofRJEFQ4D6Mf24QmUsZuX2pNOL70yt
         s/FsAlmLvxOCoFb5tcjWp9+67lW33wmXLSoYP5LNm4/LidvjkSSqewRSObuSjOh5LyRK
         IOuH7DxX2/y31ckzRnok2hi8Kfs7kJlBiXRhfu04IE1fYVF0Ed87frmLIhBNYN9MJgYP
         ckNztJWkz3TeaqxVgPKfyJafEEpQhQwB+jXfMEA9oE5q0FU4acpsA7+Yufyr0AbPJvKj
         qmEbYuhSjA7NX/0UAJC7LeUZj6MhbnkJJL9RyhYKYiC64Mp5QO2U5Ch56uKZ8B2erN01
         IqQQ==
X-Gm-Message-State: AAQBX9cWODsKUPS2XocFNKzeExbfSovo6fPNEKeBfnEQqi/AXVRnS2X0
        nVwIo0vLEmvdCj94sZdOENN+6g==
X-Google-Smtp-Source: AKy350ae5XuGbnSNHcqmrQvRUyQYF8kbODHnokFj4Kv5Dc/ENzkhYswUuLUVjYMfQR/kno9SN1buSw==
X-Received: by 2002:ac2:43c2:0:b0:4d8:56d8:92ee with SMTP id u2-20020ac243c2000000b004d856d892eemr1205865lfl.35.1680677440764;
        Tue, 04 Apr 2023 23:50:40 -0700 (PDT)
Received: from [192.168.1.2] (c-05d8225c.014-348-6c756e10.bbcust.telenor.se. [92.34.216.5])
        by smtp.gmail.com with ESMTPSA id z19-20020ac25df3000000b004eb274b3a43sm2683086lfq.134.2023.04.04.23.50.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 23:50:40 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 05 Apr 2023 08:50:34 +0200
Subject: [PATCH 08/13] mmc: mmci: Use state machine state as exit condition
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230405-pl180-busydetect-fix-v1-8-28ac19a74e5e@linaro.org>
References: <20230405-pl180-busydetect-fix-v1-0-28ac19a74e5e@linaro.org>
In-Reply-To: <20230405-pl180-busydetect-fix-v1-0-28ac19a74e5e@linaro.org>
To:     Stefan Hansson <newbyte@disroot.org>,
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
 drivers/mmc/host/mmci.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 670b1622d282..734e8364b2f6 100644
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
@@ -697,7 +697,7 @@ static bool ux500_busy_complete(struct mmci_host *host, u32 status, u32 err_msk)
 
 				host->busy_status |= status & (MCI_CMDSENT | MCI_CMDRESPEND);
 				host->busy_state = MMCI_BUSY_WAITING_FOR_IRQS;
-				return false;
+				goto out_ret_state;
 			}
 			retries--;
 		}
@@ -706,8 +706,7 @@ static bool ux500_busy_complete(struct mmci_host *host, u32 status, u32 err_msk)
 		writel(readl(base + MMCIMASK0) &
 		       ~host->variant->busy_detect_mask, base + MMCIMASK0);
 		host->busy_state = MMCI_BUSY_DONE;
-		host->busy_status = 0;
-		return true;
+		goto out_ret_state;
 	}
 
 	/*
@@ -726,7 +725,7 @@ static bool ux500_busy_complete(struct mmci_host *host, u32 status, u32 err_msk)
 			host->busy_status |= status & (MCI_CMDSENT | MCI_CMDRESPEND);
 			writel(host->variant->busy_detect_mask, base + MMCICLEAR);
 			host->busy_state = MMCI_BUSY_START_IRQ;
-			return false;
+			goto out_ret_state;
 		} else {
 			dev_dbg(mmc_dev(host->mmc),
 				"lost busy status when waiting for busy start IRQ\n");
@@ -735,7 +734,7 @@ static bool ux500_busy_complete(struct mmci_host *host, u32 status, u32 err_msk)
 			       ~host->variant->busy_detect_mask, base + MMCIMASK0);
 			host->busy_state = MMCI_BUSY_DONE;
 			host->busy_status = 0;
-			return true;
+			goto out_ret_state;
 		}
 	}
 
@@ -744,7 +743,7 @@ static bool ux500_busy_complete(struct mmci_host *host, u32 status, u32 err_msk)
 			host->busy_status |= status & (MCI_CMDSENT | MCI_CMDRESPEND);
 			writel(host->variant->busy_detect_mask, base + MMCICLEAR);
 			host->busy_state = MMCI_BUSY_END_IRQ;
-			return false;
+			goto out_ret_state;
 		} else {
 			dev_dbg(mmc_dev(host->mmc),
 				"lost busy status when waiting for busy end IRQ\n");
@@ -753,7 +752,7 @@ static bool ux500_busy_complete(struct mmci_host *host, u32 status, u32 err_msk)
 			       ~host->variant->busy_detect_mask, base + MMCIMASK0);
 			host->busy_state = MMCI_BUSY_DONE;
 			host->busy_status = 0;
-			return true;
+			goto out_ret_state;
 		}
 	}
 
@@ -767,7 +766,7 @@ static bool ux500_busy_complete(struct mmci_host *host, u32 status, u32 err_msk)
 		if (status & host->variant->busy_detect_flag) {
 			/* We should just get two IRQs for busy detect */
 			dev_err(mmc_dev(host->mmc), "spurious busy detect IRQ\n");
-			return false;
+			goto out_ret_state;
 		}
 
 		writel(host->variant->busy_detect_mask, base + MMCICLEAR);
@@ -776,9 +775,13 @@ static bool ux500_busy_complete(struct mmci_host *host, u32 status, u32 err_msk)
 
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

