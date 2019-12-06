Return-Path: <SRS0=q/7Q=Z4=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CEFBC43603
	for <linux-mmc@archiver.kernel.org>; Fri,  6 Dec 2019 07:54:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 204A12467B
	for <linux-mmc@archiver.kernel.org>; Fri,  6 Dec 2019 07:54:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cZy4v5tU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726225AbfLFHy0 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 6 Dec 2019 02:54:26 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40992 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726184AbfLFHy0 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 6 Dec 2019 02:54:26 -0500
Received: by mail-pf1-f196.google.com with SMTP id s18so2920719pfd.8;
        Thu, 05 Dec 2019 23:54:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Hx0Dc0G+WpaLdiZbsrH+BmbfA0t0DBuGqouWtY55sH4=;
        b=cZy4v5tUbC3xpWDc5GZvcFrePBeYct6b/5y1wSxnsa087k4NVqGDh8kFxN0jX4BwP6
         QuascSIc2NmNi4S56acshPAEmU5hYWGPqrux+4n9LUVE3M80CKL1WkLiRhxP9Zy4r0vr
         FuwHPbsJY9KlboGT95zH28tLw3Hb/B0hjo9BH6+MDLst2SOtTRMNvKwBJv0VBvzbefT+
         CMQQ2pgUs9d56vT1qnCVsAU1rsZPgTLUx3SZPs2oMz59G8msO4/fiVJdwwhSsOWBXIpy
         5bbDEGJbY9+q4YbEhTaa5Vw0aA5pcuS/rt3kwXnjlIxp08vEeI8wHEsq2vW62V9VjKFy
         QHpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Hx0Dc0G+WpaLdiZbsrH+BmbfA0t0DBuGqouWtY55sH4=;
        b=Evns+Md5aH9CNxlWEOJfspiw9HM2LaZmazC27KiW8bDDgEG8ZytEJ2Lv5aXuf4w/un
         ybj4RmkbjTAT/LII7epdKMbdmNqmJ9WulChcGrU7wVZCI+5CFZhK5XQcGyEfstaMjl/p
         Nr5wJjytu/WKD9bZ2QTKmqbQ3WrJYKUnLqKDyDbIvU5LlfPhQOvlWHoJ5KTmWKXvwUWo
         nCRTEhcMH/FUwHH5rRz65L4a76CxYX8piFTk559O8G6CdWvyClxV5X6dMpOARrrPrnIB
         nRusE37w9p6t+JQYEBh/PR+r+vlZIBGVX5erWD96MKkW4nZ7TGSDokdORbltDWTrnh/7
         3cFQ==
X-Gm-Message-State: APjAAAVhWgD6J8buELIY/fzlxQojRdN59/+0Vbl5ARSUufwP4IkSiNd6
        vK0FwZQwVezNBS/LKMFP/M8=
X-Google-Smtp-Source: APXvYqw/E1N8zRwj8QQCutTm6hKdpScwtunL8LQFur62/Zs24KXMKN8LZD1+jgsFOaIn84nkECvaNg==
X-Received: by 2002:a63:36c4:: with SMTP id d187mr2082263pga.108.1575618865656;
        Thu, 05 Dec 2019 23:54:25 -0800 (PST)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.gmail.com with ESMTPSA id q41sm2178144pja.20.2019.12.05.23.54.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2019 23:54:25 -0800 (PST)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Jan Glauber <jglauber@cavium.com>,
        David Daney <david.daney@cavium.com>,
        "Steven J . Hill" <Steven.Hill@cavium.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH] mmc: cavium: Add missed pci_release_regions
Date:   Fri,  6 Dec 2019 15:54:08 +0800
Message-Id: <20191206075408.18355-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The driver forgets to call pci_release_regions() in probe failure
and remove.
Add the missed calls to fix it.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
 drivers/mmc/host/cavium-thunderx.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/cavium-thunderx.c b/drivers/mmc/host/cavium-thunderx.c
index eee08d81b242..76013bbbcff3 100644
--- a/drivers/mmc/host/cavium-thunderx.c
+++ b/drivers/mmc/host/cavium-thunderx.c
@@ -76,8 +76,10 @@ static int thunder_mmc_probe(struct pci_dev *pdev,
 		return ret;
 
 	host->base = pcim_iomap(pdev, 0, pci_resource_len(pdev, 0));
-	if (!host->base)
-		return -EINVAL;
+	if (!host->base) {
+		ret = -EINVAL;
+		goto error;
+	}
 
 	/* On ThunderX these are identical */
 	host->dma_base = host->base;
@@ -86,12 +88,14 @@ static int thunder_mmc_probe(struct pci_dev *pdev,
 	host->reg_off_dma = 0x160;
 
 	host->clk = devm_clk_get(dev, NULL);
-	if (IS_ERR(host->clk))
-		return PTR_ERR(host->clk);
+	if (IS_ERR(host->clk)) {
+		ret = PTR_ERR(host->clk);
+		goto error;
+	}
 
 	ret = clk_prepare_enable(host->clk);
 	if (ret)
-		return ret;
+		goto error;
 	host->sys_freq = clk_get_rate(host->clk);
 
 	spin_lock_init(&host->irq_handler_lock);
@@ -157,6 +161,7 @@ static int thunder_mmc_probe(struct pci_dev *pdev,
 		}
 	}
 	clk_disable_unprepare(host->clk);
+	pci_release_regions(pdev);
 	return ret;
 }
 
@@ -175,6 +180,7 @@ static void thunder_mmc_remove(struct pci_dev *pdev)
 	writeq(dma_cfg, host->dma_base + MIO_EMM_DMA_CFG(host));
 
 	clk_disable_unprepare(host->clk);
+	pci_release_regions(pdev);
 }
 
 static const struct pci_device_id thunder_mmc_id_table[] = {
-- 
2.24.0

