Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26F4CEB64DA
	for <linux-mmc@archiver.kernel.org>; Tue, 13 Jun 2023 20:34:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231651AbjFMUeg (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 13 Jun 2023 16:34:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231839AbjFMUee (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 13 Jun 2023 16:34:34 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6A6EE0
        for <linux-mmc@vger.kernel.org>; Tue, 13 Jun 2023 13:34:33 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4f4b2bc1565so7429750e87.2
        for <linux-mmc@vger.kernel.org>; Tue, 13 Jun 2023 13:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686688472; x=1689280472;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Adhu9PdZtBYOCnLOWJSJpjhVZuSODtE/R96GA6MZfjQ=;
        b=b1IIp6tt+uAkYRZ4sjwCMJY2mQWcMcxObRQyDRGapb0uq+3wtwjqry1BMVU75W9mly
         YDbIBMdxJPRvJqDWgZYbQRtQWWcsTbRw7XIao9rlOspi6q3VP4oepKVapJK+Ote9sWDa
         NHoa07QULjJSomeMim4Rt1eDp260UMLH8uQVQYCuaFUPRzqFmSloEqdz3XYF3otGErfK
         v06i3XW9iFXZ8oKeT45ZB69ITGUmM4tjXuxH9uXLOChv8/2SqVtMgTL1xWkm8ByYWM3+
         9bLPL9fI/83GT9YWafMXf6ayomvKLnSlAFpHmazHQVIOgKl3sZYkNfX81Nv9wTzQfazs
         xL5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686688472; x=1689280472;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Adhu9PdZtBYOCnLOWJSJpjhVZuSODtE/R96GA6MZfjQ=;
        b=gO+IxmMbh2a9m1X1gU7sJr77LEtX9IbDfouvvyvgRY29M/YsuDEL2lOWF3neKA1Ed3
         CuVCyIRfF/yBgFPCVvaOhDstlMaSAPqIx2j23aCb/q8Llplmh5tYTrutQ8rJFjDoUUrs
         V+vKeB407oR9OBZrGjLLDqHI+mb5VgPYxFkb33ybn7+h/rOQ0VPYjFNrijxtjm5TWAFQ
         kszBkN2r7W9OvRBQPeU+tbEEvAaA9PM82puUKhRdIqUpMo0cGAnqPSEsCwdC8o8wYVWs
         lnrRgtcvJ/W01NdyzgqX8oz5tFWlB+Jsna6JXOqhVagTQR4Gv8Z0JQVPdL04kfUUMtUL
         hVxw==
X-Gm-Message-State: AC+VfDw16u48kzaKCe+aYR6j6uyDZBRqMgGIW9DAFad4/T7kG2e4MFxf
        ixk4N5MuH8SpKFgUcdBCPUblzw==
X-Google-Smtp-Source: ACHHUZ4UoekS54u0lEghgz1uB/kpxKJ1A49IdD+1ZrPrZSOBsgoSFklRjb3PcnBvW99Chfi+MrX1bg==
X-Received: by 2002:ac2:498e:0:b0:4ec:8615:303e with SMTP id f14-20020ac2498e000000b004ec8615303emr7491271lfl.33.1686688472016;
        Tue, 13 Jun 2023 13:34:32 -0700 (PDT)
Received: from [192.168.1.2] (c-05d8225c.014-348-6c756e10.bbcust.telenor.se. [92.34.216.5])
        by smtp.gmail.com with ESMTPSA id l12-20020a19c20c000000b004f26f699e9dsm1897813lfc.184.2023.06.13.13.34.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 13:34:31 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 13 Jun 2023 22:34:23 +0200
Subject: [PATCH v4 07/10] mmc: mmci: Use state machine state as exit
 condition
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230405-pl180-busydetect-fix-v4-7-df9c8c504353@linaro.org>
References: <20230405-pl180-busydetect-fix-v4-0-df9c8c504353@linaro.org>
In-Reply-To: <20230405-pl180-busydetect-fix-v4-0-df9c8c504353@linaro.org>
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
index a412ecdee63a..48714e570116 100644
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
@@ -703,7 +703,7 @@ static bool ux500_busy_complete(struct mmci_host *host, u32 status, u32 err_msk)
 				       host->variant->busy_detect_mask,
 				       base + MMCIMASK0);
 				host->busy_state = MMCI_BUSY_WAITING_FOR_START_IRQ;
-				return false;
+				goto out_ret_state;
 			}
 			retries--;
 		}
@@ -712,8 +712,7 @@ static bool ux500_busy_complete(struct mmci_host *host, u32 status, u32 err_msk)
 		writel(readl(base + MMCIMASK0) &
 		       ~host->variant->busy_detect_mask, base + MMCIMASK0);
 		host->busy_state = MMCI_BUSY_DONE;
-		host->busy_status = 0;
-		return true;
+		goto out_ret_state;
 	}
 
 	/*
@@ -732,7 +731,7 @@ static bool ux500_busy_complete(struct mmci_host *host, u32 status, u32 err_msk)
 			host->busy_status |= status & (MCI_CMDSENT | MCI_CMDRESPEND);
 			writel(host->variant->busy_detect_mask, base + MMCICLEAR);
 			host->busy_state = MMCI_BUSY_WAITING_FOR_END_IRQ;
-			return false;
+			goto out_ret_state;
 		} else {
 			dev_dbg(mmc_dev(host->mmc),
 				"lost busy status when waiting for busy start IRQ\n");
@@ -741,7 +740,7 @@ static bool ux500_busy_complete(struct mmci_host *host, u32 status, u32 err_msk)
 			       ~host->variant->busy_detect_mask, base + MMCIMASK0);
 			host->busy_state = MMCI_BUSY_DONE;
 			host->busy_status = 0;
-			return true;
+			goto out_ret_state;
 		}
 	}
 
@@ -750,7 +749,7 @@ static bool ux500_busy_complete(struct mmci_host *host, u32 status, u32 err_msk)
 			host->busy_status |= status & (MCI_CMDSENT | MCI_CMDRESPEND);
 			writel(host->variant->busy_detect_mask, base + MMCICLEAR);
 			host->busy_state = MMCI_BUSY_DONE;
-			return false;
+			goto out_ret_state;
 		} else {
 			dev_dbg(mmc_dev(host->mmc),
 				"lost busy status when waiting for busy end IRQ\n");
@@ -759,11 +758,14 @@ static bool ux500_busy_complete(struct mmci_host *host, u32 status, u32 err_msk)
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

