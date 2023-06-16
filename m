Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B71DEB64DA
	for <linux-mmc@archiver.kernel.org>; Fri, 16 Jun 2023 20:42:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232827AbjFPUmk (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 16 Jun 2023 16:42:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244916AbjFPUmj (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 16 Jun 2023 16:42:39 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E0C03A91
        for <linux-mmc@vger.kernel.org>; Fri, 16 Jun 2023 13:42:38 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4f619c2ba18so1602921e87.1
        for <linux-mmc@vger.kernel.org>; Fri, 16 Jun 2023 13:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686948156; x=1689540156;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zlsqifmiy9RHgiGZhPS+dUQEdIvZeWv3JFMxBbM8nEg=;
        b=rmijbMYGLGZ1raQKJLQ2P4DOrZXd9qydalbHVLmJYg2KC+f6rCQ/z6k3mtOKNZNirH
         6hUH1T3OtNHaUHTY0wufHPUND38W2KRt10Q2C/x6C7dzvbQsw9ZCGxlqrByJjc/yj7PT
         bj0NypLuQOIPzwsQcOsVgu/1EKt9pkXRsUg6A9h4rMNQmn6Ej4m1kd4hOPuGqIroYZog
         wEtkMzLnX/+3oKpJpATKkde1YgY0cyKbYQdX2q3PRDyN+sDLUOpzd1lRFuP0xnQyaZor
         i89de23EH8LvpORkwh6+yx1K1N91QvQsTrOn/S7AvdJCDTenEYtr2Lt5FGjPYkEjaHu3
         KYCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686948156; x=1689540156;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zlsqifmiy9RHgiGZhPS+dUQEdIvZeWv3JFMxBbM8nEg=;
        b=RtH9FRGd7FvT1m1rynVIfOvqPGF7DYZq7t2fZnJqWhTnC0mM0NDENchHvD6WWHjDuY
         TY5CyGRrddVbXfw5mZ1PuxF9jRMbWK+6JmqgM2ZJ88sR4aEcw5O5VKWlknfm0JKdBtnH
         w2E0EoMDWch/AWniZTlfDR5yCd/6/m29TRmy7853oWMUqYsoKA6WEF+pKlaKP3EHljiR
         Vv5zKOExdwbD7JTcrQ3jLPOi9/FtCHXNKFgH2arsxwsWDwVhlLaDRmE54LA4Na+usfCx
         1R4O2zvt9zmOvaxPffxwueXmRYoVN/Numm75gK5L1IUddWwDAW8okDPsfuLyAZ24xNAc
         MVWw==
X-Gm-Message-State: AC+VfDy9CbGbBRvNQoyBVxey5miaOWvsDD4KBBRFiLMXLNZ0Dc9DHK/i
        mVHJct3lOHz1eFWcCvceBav9ug==
X-Google-Smtp-Source: ACHHUZ5hzcjTLMcpSuRJdwyHwbgflB9k7mRnmcZLmblovwVPy6X2OIda+S4MSNIKUZDc/pBW0AdFSw==
X-Received: by 2002:a19:2d17:0:b0:4f8:55dd:e726 with SMTP id k23-20020a192d17000000b004f855dde726mr2191563lfj.12.1686948156618;
        Fri, 16 Jun 2023 13:42:36 -0700 (PDT)
Received: from [192.168.1.2] (c-05d8225c.014-348-6c756e10.bbcust.telenor.se. [92.34.216.5])
        by smtp.gmail.com with ESMTPSA id d22-20020ac244d6000000b004f845907454sm770981lfm.232.2023.06.16.13.42.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jun 2023 13:42:36 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 16 Jun 2023 22:42:25 +0200
Subject: [PATCH v7 7/9] mmc: mmci: Use state machine state as exit
 condition
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230405-pl180-busydetect-fix-v7-7-69a7164f2a61@linaro.org>
References: <20230405-pl180-busydetect-fix-v7-0-69a7164f2a61@linaro.org>
In-Reply-To: <20230405-pl180-busydetect-fix-v7-0-69a7164f2a61@linaro.org>
To:     Stefan Hansson <newbyte@disroot.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.2
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Return true if and only if we reached the state
MMCI_BUSY_DONE in the ux500 ->busy_complete() callback.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v6->v7:
- No changes.
ChangeLog v4->v6:
- No changes.
ChangeLog v3->v4:
- No changes.
ChangeLog v2->v3:
- Rebased.
ChangeLog v1->v2:
- No changes
---
 drivers/mmc/host/mmci.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index b38c471a7f8b..f89e4c44ea04 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -683,7 +683,7 @@ static bool ux500_busy_complete(struct mmci_host *host, u32 status, u32 err_msk)
 		       ~host->variant->busy_detect_mask, base + MMCIMASK0);
 		host->busy_state = MMCI_BUSY_DONE;
 		host->busy_status = 0;
-		return true;
+		goto out_ret_state;
 	}
 
 	/*
@@ -713,7 +713,7 @@ static bool ux500_busy_complete(struct mmci_host *host, u32 status, u32 err_msk)
 				       host->variant->busy_detect_mask,
 				       base + MMCIMASK0);
 				host->busy_state = MMCI_BUSY_WAITING_FOR_START_IRQ;
-				return false;
+				goto out_ret_state;
 			}
 			retries--;
 		}
@@ -722,8 +722,7 @@ static bool ux500_busy_complete(struct mmci_host *host, u32 status, u32 err_msk)
 		writel(readl(base + MMCIMASK0) &
 		       ~host->variant->busy_detect_mask, base + MMCIMASK0);
 		host->busy_state = MMCI_BUSY_DONE;
-		host->busy_status = 0;
-		return true;
+		goto out_ret_state;
 	}
 
 	/*
@@ -742,7 +741,7 @@ static bool ux500_busy_complete(struct mmci_host *host, u32 status, u32 err_msk)
 			host->busy_status |= status & (MCI_CMDSENT | MCI_CMDRESPEND);
 			writel(host->variant->busy_detect_mask, base + MMCICLEAR);
 			host->busy_state = MMCI_BUSY_WAITING_FOR_END_IRQ;
-			return false;
+			goto out_ret_state;
 		} else {
 			dev_dbg(mmc_dev(host->mmc),
 				"lost busy status when waiting for busy start IRQ\n");
@@ -751,7 +750,7 @@ static bool ux500_busy_complete(struct mmci_host *host, u32 status, u32 err_msk)
 			       ~host->variant->busy_detect_mask, base + MMCIMASK0);
 			host->busy_state = MMCI_BUSY_DONE;
 			host->busy_status = 0;
-			return true;
+			goto out_ret_state;
 		}
 	}
 
@@ -759,15 +758,18 @@ static bool ux500_busy_complete(struct mmci_host *host, u32 status, u32 err_msk)
 		if (!(status & host->variant->busy_detect_flag)) {
 			host->busy_status |= status & (MCI_CMDSENT | MCI_CMDRESPEND);
 			host->busy_state = MMCI_BUSY_DONE;
-			return true;
+			goto out_ret_state;
 		} else {
 			dev_dbg(mmc_dev(host->mmc),
 				"busy status still asserted when handling busy end IRQ - will keep waiting\n");
-			return false;
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

