Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4161EB64DB
	for <linux-mmc@archiver.kernel.org>; Fri, 16 Jun 2023 08:30:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233268AbjFPIas (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 16 Jun 2023 04:30:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242847AbjFPIap (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 16 Jun 2023 04:30:45 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F3102966
        for <linux-mmc@vger.kernel.org>; Fri, 16 Jun 2023 01:30:43 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4f640e48bc3so492888e87.2
        for <linux-mmc@vger.kernel.org>; Fri, 16 Jun 2023 01:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686904241; x=1689496241;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AKBnKIdK2CO+P/WwZHo2AYQY3pe5441V6fpY4p0irEc=;
        b=rK4mZCX/IjZuLgF8DNqx1Su73VwpJdM0o0SzCj50IzO4/6TsEcJHwanPqvaMP8Ldcb
         zw+HivJZThGGPCh9dAW3zNu8Nfopj38bxnvpNvhBGo/Vzvg2hmyHZVQI9+ybocZXwIdj
         EyxYjrZDWuRLMiuQIRDXFRkraIVC8Euo+0buQ7MPgaDo6Tob4b7tODOhzqEvmzYZnjHy
         vjPIKqquUl77LAzsxMuSJZwVcRnIf6gfcayvek5y80lzfnBr+gYjwoHWficJOPt0/dZ7
         m6R+e5a4/ptMecSECvjhXTTuKhlDsCL+NN5YRtp3koLs9nJ93U3/4/MbfZNo48F8IfE5
         FJ5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686904241; x=1689496241;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AKBnKIdK2CO+P/WwZHo2AYQY3pe5441V6fpY4p0irEc=;
        b=KlHuB0sHyEX/+5DPKLxkI9Cmnkgx7QG1pnVtGVkWdsgPX+M9uio6kJpqK02cVeJbvc
         07ccfkB8rDAchLde5DfV29mqw5knLBd8LR5+OeBaIZrh00w8UrHgRRx6kaefuYUKnM6t
         sIz+LAGngEbHwdpgDo7vrCReRwgFaYkqkYyeYbhHxIELsJoRt6kXLqLg4QQYCthpx75K
         IRICiaZHeEyCzjU8gnhEV2KuG+eBRAqMd8R9PJFqv32rh7zMoa5EWb8jmoPUwOK5kbjS
         xGYOTS3T2HrU5pIYE6zy2kb3tOcJ3esS0K2juwRS+eQM10SVI/rcmR+0g7sUNP8Y6ba4
         nnrg==
X-Gm-Message-State: AC+VfDxwT6R6ycx38pRt2uhCM26FtVcVk8+cJl8cNsr/MqSW2Eohu6Au
        ElB9m/W5ldJCKO+ND7oMil+FFg==
X-Google-Smtp-Source: ACHHUZ69GNE4ZOqc3XtliTEHCTLTnYoMy/Zbi656rhwXpt06TURFYrcxTdKki18tWOPEX1/NdQoXRg==
X-Received: by 2002:ac2:5b08:0:b0:4f7:4f30:1532 with SMTP id v8-20020ac25b08000000b004f74f301532mr727845lfn.31.1686904241687;
        Fri, 16 Jun 2023 01:30:41 -0700 (PDT)
Received: from [192.168.1.2] (c-05d8225c.014-348-6c756e10.bbcust.telenor.se. [92.34.216.5])
        by smtp.gmail.com with ESMTPSA id j8-20020ac25508000000b004eb44c2ab6bsm2918106lfk.294.2023.06.16.01.30.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jun 2023 01:30:41 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 16 Jun 2023 10:30:39 +0200
Subject: [PATCH v6 7/9] mmc: mmci: Use state machine state as exit
 condition
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230405-pl180-busydetect-fix-v6-7-b850ec8019f3@linaro.org>
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

Return true if and only if we reached the state
MMCI_BUSY_DONE in the ux500 ->busy_complete() callback.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
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
index 6ae56c973b0d..437b2144ecd4 100644
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
 
@@ -749,7 +748,7 @@ static bool ux500_busy_complete(struct mmci_host *host, u32 status, u32 err_msk)
 		if (!(status & host->variant->busy_detect_flag)) {
 			host->busy_status |= status & (MCI_CMDSENT | MCI_CMDRESPEND);
 			host->busy_state = MMCI_BUSY_DONE;
-			return false;
+			goto out_ret_state;
 		} else {
 			dev_dbg(mmc_dev(host->mmc),
 				"busy status still asserted when handling busy end IRQ\n");
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

