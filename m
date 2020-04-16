Return-Path: <SRS0=WBH1=6A=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B864CC2BB55
	for <linux-mmc@archiver.kernel.org>; Thu, 16 Apr 2020 18:24:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9780B2222D
	for <linux-mmc@archiver.kernel.org>; Thu, 16 Apr 2020 18:24:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tU5V57h/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730928AbgDPSYY (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 16 Apr 2020 14:24:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726435AbgDPSYW (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 16 Apr 2020 14:24:22 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B6C1C061A0C;
        Thu, 16 Apr 2020 11:24:22 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id d7so12339653oif.9;
        Thu, 16 Apr 2020 11:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2E+VoUpcxjbQphezSMSElLeeuveF/zt0QguBrsX5PCw=;
        b=tU5V57h/iPNI4Y1l78anoeSVneu4LlVuHUKxUiMbl8Oy9YR3fE1vFQ54wH7wyaQgPI
         W0LOtOGtwSCtnAVZ725R+5RVA7GGFdpaol+0gzHRFwJL7N9uFl9ckkZSlOCLUh0oB2ZR
         p0t9R/48+mm/QXh4v+8xRp26i0cZu7fkKHmPL6b0TaK0/lC2TAWh9J9pZoCt6DxR7HPM
         dC2WIUlP7P6P5he2r92zp7PIuvR6VAWDL2DuGvCuu98DcvpwNGKzAupDuCVscNSgkmqW
         IIZBNi5m1XUY22XCmTVQkjStgiYYGJSgLC3lUU9CDQBByMp+Bx37BYctTiZw+difdveo
         FLOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2E+VoUpcxjbQphezSMSElLeeuveF/zt0QguBrsX5PCw=;
        b=RAFLDM5byGugCTq455Oz4A1lmIrDMa2Ebkc52zYIepwkkVBoGHKHoNx+OO28Kw9+at
         W7W8vCVMlHLm4z2weUo4bslf3Tui0sS6NgKKMD+Cn5t1MuwBTWsMp7Ffzx2RXfnHgT/a
         vZF/lBxVhJ0Mi3NqLcb9v7JJ8NjKzZQ4zu8T8V7sBMTLfI15WFxQB37d/MnuFpLNGIYc
         bX+NOc/MItumIk/XtXBXSQMR6xpWivF93JgC3XFLzNAcjIG8bLJ3CtfAhWKYohodJ5r7
         KeP0q54DVY8c7fD4yANLOEQsCUQAowRuFQuZyY11vVfowo15/yvwxkGGdoC9UVvs905G
         qQ+g==
X-Gm-Message-State: AGi0PuZOwJlwhUf+te+tQGUyEL8Fy/wa+O14AX2L3IynzTWOuVQpqFJc
        0kQeVwur5Ikb/4P6HCNp91s=
X-Google-Smtp-Source: APiQypJYh1NRb4Bfqrxrls0PNIPJSeRz4pqPGg+Id5hgSKPZZZfHQFC+goUmyTwlAmRhqTKJJj0n0A==
X-Received: by 2002:aca:d705:: with SMTP id o5mr3958283oig.67.1587061461676;
        Thu, 16 Apr 2020 11:24:21 -0700 (PDT)
Received: from localhost.localdomain ([2604:1380:4111:8b00::3])
        by smtp.gmail.com with ESMTPSA id f45sm7307785otf.30.2020.04.16.11.24.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2020 11:24:20 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Michal Simek <michal.simek@xilinx.com>,
        Manish Narani <manish.narani@xilinx.com>,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>,
        "kernelci . org bot" <bot@kernelci.org>
Subject: [PATCH] mmc: sdhci-of-arasan: Remove uninitialized ret variables
Date:   Thu, 16 Apr 2020 11:24:02 -0700
Message-Id: <20200416182402.16858-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.26.1
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Clang warns:

drivers/mmc/host/sdhci-of-arasan.c:784:9: warning: variable 'ret' is
uninitialized when used here [-Wuninitialized]
        return ret;
               ^~~
drivers/mmc/host/sdhci-of-arasan.c:738:9: note: initialize the variable
'ret' to silence this warning
        int ret;
               ^
                = 0
drivers/mmc/host/sdhci-of-arasan.c:860:9: warning: variable 'ret' is
uninitialized when used here [-Wuninitialized]
        return ret;
               ^~~
drivers/mmc/host/sdhci-of-arasan.c:810:9: note: initialize the variable
'ret' to silence this warning
        int ret;
               ^
                = 0
2 warnings generated.

This looks like a copy paste error. Neither function has handling that
needs ret so just remove it and return 0 directly.

Fixes: f73e66a36772 ("sdhci: arasan: Add support for Versal Tap Delays")
Link: https://github.com/ClangBuiltLinux/linux/issues/996
Reported-by: kernelci.org bot <bot@kernelci.org>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/mmc/host/sdhci-of-arasan.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
index 16e26c217a77..18bf0e76b1eb 100644
--- a/drivers/mmc/host/sdhci-of-arasan.c
+++ b/drivers/mmc/host/sdhci-of-arasan.c
@@ -735,7 +735,6 @@ static int sdhci_versal_sdcardclk_set_phase(struct clk_hw *hw, int degrees)
 		container_of(clk_data, struct sdhci_arasan_data, clk_data);
 	struct sdhci_host *host = sdhci_arasan->host;
 	u8 tap_delay, tap_max = 0;
-	int ret;
 
 	/*
 	 * This is applicable for SDHCI_SPEC_300 and above
@@ -781,7 +780,7 @@ static int sdhci_versal_sdcardclk_set_phase(struct clk_hw *hw, int degrees)
 		sdhci_writel(host, regval, SDHCI_ARASAN_OTAPDLY_REGISTER);
 	}
 
-	return ret;
+	return 0;
 }
 
 static const struct clk_ops versal_sdcardclk_ops = {
@@ -807,7 +806,6 @@ static int sdhci_versal_sampleclk_set_phase(struct clk_hw *hw, int degrees)
 		container_of(clk_data, struct sdhci_arasan_data, clk_data);
 	struct sdhci_host *host = sdhci_arasan->host;
 	u8 tap_delay, tap_max = 0;
-	int ret;
 
 	/*
 	 * This is applicable for SDHCI_SPEC_300 and above
@@ -857,7 +855,7 @@ static int sdhci_versal_sampleclk_set_phase(struct clk_hw *hw, int degrees)
 		sdhci_writel(host, regval, SDHCI_ARASAN_ITAPDLY_REGISTER);
 	}
 
-	return ret;
+	return 0;
 }
 
 static const struct clk_ops versal_sampleclk_ops = {

base-commit: a3ca59b9af21e68069555ffff1ad89bd2a7c40fc
-- 
2.26.1

