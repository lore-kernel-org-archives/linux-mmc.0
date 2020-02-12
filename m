Return-Path: <SRS0=ptsr=4A=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C318C3B187
	for <linux-mmc@archiver.kernel.org>; Wed, 12 Feb 2020 04:14:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40E7020842
	for <linux-mmc@archiver.kernel.org>; Wed, 12 Feb 2020 04:14:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e/MKSaug"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727984AbgBLEOK (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 11 Feb 2020 23:14:10 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40510 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727602AbgBLEOK (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 11 Feb 2020 23:14:10 -0500
Received: by mail-pg1-f194.google.com with SMTP id z7so498064pgk.7;
        Tue, 11 Feb 2020 20:14:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=341fIr27AyNPBcsww4i3en3R4df0bv31VLkS1AGBqK0=;
        b=e/MKSaugs0NVZ5zlKgcrjRIFDkFKH1MjbOdhMjZXao0ijbBhSU+TRLzKOGcqJEH4kw
         bOW9HADRj7zS069n4EL9GFEQ7Cju5gLZQU9ItS1jjQ0bPxAGby6FxjRtndkja5rrDqVN
         y8+hJF8YcOtIpcT04MtsJb+FEBv3Nyn8iFcc2GouBWuy68Bjl+c7wvWJDr9p3kaxP+I+
         p+pJnXJp5K+zPw6GVo/jbkFapBQYUWLXZHnC+SFtE/JEnOWEYxT9UP1IoTxXQ1pohvDP
         1Oc3J3oklEnn4BraoA5kRVMN1l1xqO/gb+xqppmBVzru2HjTkPWiiHcd3RPQSp0wrNag
         P41Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=341fIr27AyNPBcsww4i3en3R4df0bv31VLkS1AGBqK0=;
        b=nzku3OQtDwLde36SfYmHczubkj6S/d7Hjj5k1E6xlBoixE+pB/PRVs4hylbfG+8xJJ
         drODWG8VDYmFn9CJEcVfijK9R7ldOXwtROEPV2rFAFu7IAiKeVEMzz12TtfPe04ubmr5
         +Ir0g8OefuHOqs7y9xQHbNWDABGlFaGKJnBfEdRHyq87mZa/MKoQFvk/5KgkhVzSnli1
         H5lH+L27zMslLhRpMa3tKOvgKKBrW1ybcp3Q6sdXziUX26HTZXE7oJzGPF56lHQTfOM6
         iuCR6qpQijaAd8nXx6/NKiiycpzIoA0tcnL9fPlT1SYr94iNp8XQFrDG0B3BC6++ZaKV
         N1bQ==
X-Gm-Message-State: APjAAAXtDBOQTKgumiF5Z/4Ny6dp8SYoUhTfeNS/bOuHJskri/98kVKW
        JDVFCYxV58ujKTuOow511rY=
X-Google-Smtp-Source: APXvYqzTeweseuqdQBHIGo33w8FKX03J53/5SGk3JtJ3+YlIHYRE7zP9U1X2AgjnVPGPrwB3mqNqog==
X-Received: by 2002:aa7:8755:: with SMTP id g21mr9774050pfo.36.1581480849589;
        Tue, 11 Feb 2020 20:14:09 -0800 (PST)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id q66sm6424762pfq.27.2020.02.11.20.14.06
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 11 Feb 2020 20:14:09 -0800 (PST)
From:   Baolin Wang <baolin.wang7@gmail.com>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        asutoshd@codeaurora.org
Cc:     orsonzhai@gmail.com, zhang.lyra@gmail.com, arnd@arndb.de,
        linus.walleij@linaro.org, baolin.wang@linaro.org,
        baolin.wang7@gmail.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v9 2/5] mmc: core: Enable the MMC host software queue for the SD card
Date:   Wed, 12 Feb 2020 12:12:57 +0800
Message-Id: <0065b4631fef2d61c3b89d14a4ea4f2b7499ea56.1581478568.git.baolin.wang7@gmail.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1581478568.git.baolin.wang7@gmail.com>
References: <cover.1581478568.git.baolin.wang7@gmail.com>
In-Reply-To: <cover.1581478568.git.baolin.wang7@gmail.com>
References: <cover.1581478568.git.baolin.wang7@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Baolin Wang <baolin.wang@linaro.org>

Enable the MMC host software queue for the SD card if the host controller
supports the MMC host software queue.

On my Spreadtrum platform, I did not see any obvious performance changes
in 4K block size when changing to use hsq for the SD cards, I think the
reason is the SD card works at a low speed on my platform, and most of
time is spent in the hardware. But we can see some obvious improvements
when enabling the packed request based on hsq, that's why we still add hsq
support for the SD cards.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>
---
 drivers/mmc/core/sd.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index fe914ff..76c7add 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -1082,6 +1082,16 @@ static int mmc_sd_init_card(struct mmc_host *host, u32 ocr,
 		}
 	}
 
+	if (host->cqe_ops && !host->cqe_enabled) {
+		err = host->cqe_ops->cqe_enable(host, card);
+		if (!err) {
+			host->cqe_enabled = true;
+			host->hsq_enabled = true;
+			pr_info("%s: Host Software Queue enabled\n",
+				mmc_hostname(host));
+		}
+	}
+
 	if (host->caps2 & MMC_CAP2_AVOID_3_3V &&
 	    host->ios.signal_voltage == MMC_SIGNAL_VOLTAGE_330) {
 		pr_err("%s: Host failed to negotiate down from 3.3V\n",
-- 
1.7.9.5

