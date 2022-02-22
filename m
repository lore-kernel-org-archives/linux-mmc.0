Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81B99C433FE
	for <linux-mmc@archiver.kernel.org>; Tue, 22 Feb 2022 03:40:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234283AbiBVDkv (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 21 Feb 2022 22:40:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230249AbiBVDkt (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 21 Feb 2022 22:40:49 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFF01240BF
        for <linux-mmc@vger.kernel.org>; Mon, 21 Feb 2022 19:40:25 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id u16so10626060pfg.12
        for <linux-mmc@vger.kernel.org>; Mon, 21 Feb 2022 19:40:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NvjS1M3rcUh28hIfgWBVsCClvMhLur1EPoXMsswx40c=;
        b=kHR/KWxx+XeJNVhUZfXvLH9MJnsuRAewxhvW1xuVccBNWqjyHqARx27IyYJT2pz7UH
         W5SDbrIMfHPbij9kWO7mKsq58TZUqQ0WeB3zhFa7HNbfKGz2+S6IB5YEM2YIrup+mAPA
         9FoQPcJOnJ4Cligp7rWjy7x8+DlOjQciNP631cyHEliZp4vv/45+RjgigPxTRGCrg6le
         e3sV4oEarW8tVQxWnsNbFt7h3dK/zR5vllCG9ZWbZJcu0zLEwy77dmONWMAY4vNV/LUt
         0iSQhVz787m3bDJZffnrS4UYGef1dNI5jFZE+rrKiEcKHcMdfxw96a0byl+bdtx1j3+r
         WwbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NvjS1M3rcUh28hIfgWBVsCClvMhLur1EPoXMsswx40c=;
        b=oh1gmMoF9ezItRbLblam2fhnxcvqQUAStVmdPtIm3+HsuRPlRoq2yaHKK2YKhyiUAT
         fn6k7c6aZZpW+JGBJNXvs5oFr67rJS/feoKgruTiF+o2DeyQDs9beSpR0DrX07E/a0PM
         jeZCj58MWnH3HAmwU3V8NPKym7qTgcbWPy4EDdcGMVYGq9Kv7ht3NtxYXI/x7TbgLF/T
         zADe32LGD6k/eZLFht7WDW1lXSq3/6K3QOWluCTglbINZld3jO5A1laEBTgrVUvnumjY
         JD2LAGHvIpID79yoha+Ubp/1cqbmxokibfJeFPX9Ag0Qp/Lf+iCxlzUyWjn0W88y6aNa
         FLtA==
X-Gm-Message-State: AOAM532fuQz74AlJCTVJr3AE9xi+bJee+kF6Qjd0DbyqY8KWjzHL3iru
        iWx14UMJclCM59bKREDLDU4=
X-Google-Smtp-Source: ABdhPJyFczlMKjCKBa0gmQGoP75Ta4TSGYCEiesDt5E4n6KGSu68DkXP4t6VTeFc2xKLBmm9Znp1jQ==
X-Received: by 2002:a05:6a00:21cd:b0:4e1:b09b:18e8 with SMTP id t13-20020a056a0021cd00b004e1b09b18e8mr22713668pfj.60.1645501225296;
        Mon, 21 Feb 2022 19:40:25 -0800 (PST)
Received: from localhost.localdomain (220-128-190-163.hinet-ip.hinet.net. [220.128.190.163])
        by smtp.gmail.com with ESMTPSA id ng16sm703542pjb.12.2022.02.21.19.40.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 19:40:25 -0800 (PST)
From:   Jason Lai <jasonlai.genesyslogic@gmail.com>
To:     ulf.hansson@linaro.org, takahiro.akashi@linaro.org,
        adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, dlunev@chromium.org,
        ben.chuang@genesyslogic.com.tw, greg.tu@genesyslogic.com.tw,
        jason.lai@genesyslogic.com.tw, otis.wu@genesyslogic.com.tw,
        jasonlai.genesyslogic@gmail.com
Subject: [PATCH V3 7/7] mmc: core: Support UHS-II card access
Date:   Tue, 22 Feb 2022 11:39:31 +0800
Message-Id: <20220222033931.237638-8-jasonlai.genesyslogic@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220222033931.237638-1-jasonlai.genesyslogic@gmail.com>
References: <20220222033931.237638-1-jasonlai.genesyslogic@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Jason Lai <jason.lai@genesyslogic.com.tw>

Embed UHS-II access functionality into the MMC request processing flow.

Signed-off-by: Jason Lai <jason.lai@genesyslogic.com.tw>
---
 drivers/mmc/core/core.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index fc3d8d61a97c..d2dcaa64bf27 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -31,6 +31,7 @@
 #include <linux/mmc/mmc.h>
 #include <linux/mmc/sd.h>
 #include <linux/mmc/slot-gpio.h>
+#include <linux/mmc/sd_uhs2.h>
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/mmc.h>
@@ -42,6 +43,7 @@
 #include "host.h"
 #include "sdio_bus.h"
 #include "pwrseq.h"
+#include "sd_uhs2.h"
 
 #include "mmc_ops.h"
 #include "sd_ops.h"
@@ -335,6 +337,8 @@ static int mmc_mrq_prep(struct mmc_host *host, struct mmc_request *mrq)
 
 int mmc_start_request(struct mmc_host *host, struct mmc_request *mrq)
 {
+	struct uhs2_command uhs2_cmd;
+	u32 payload[4]; /* for maximum size */
 	int err;
 
 	init_completion(&mrq->cmd_completion);
@@ -352,6 +356,13 @@ int mmc_start_request(struct mmc_host *host, struct mmc_request *mrq)
 	if (err)
 		return err;
 
+	if (host->uhs2_caps.flags & MMC_UHS2_SUPPORT &&
+	    host->uhs2_caps.flags & MMC_UHS2_INITIALIZED) {
+		uhs2_cmd.payload = payload;
+		mrq->cmd->uhs2_cmd = &uhs2_cmd;
+		sd_uhs2_prepare_cmd(host, mrq);
+	}
+
 	led_trigger_event(host->led, LED_FULL);
 	__mmc_start_request(host, mrq);
 
@@ -431,6 +442,8 @@ EXPORT_SYMBOL(mmc_wait_for_req_done);
  */
 int mmc_cqe_start_req(struct mmc_host *host, struct mmc_request *mrq)
 {
+	struct uhs2_command uhs2_cmd;
+	u32 payload[4]; /* for maximum size */
 	int err;
 
 	/*
@@ -451,6 +464,13 @@ int mmc_cqe_start_req(struct mmc_host *host, struct mmc_request *mrq)
 	if (err)
 		goto out_err;
 
+	if (host->uhs2_caps.flags & MMC_UHS2_SUPPORT &&
+	    host->uhs2_caps.flags & MMC_UHS2_INITIALIZED) {
+		uhs2_cmd.payload = payload;
+		mrq->cmd->uhs2_cmd = &uhs2_cmd;
+		sd_uhs2_prepare_cmd(host, mrq);
+	}
+
 	err = host->cqe_ops->cqe_request(host, mrq);
 	if (err)
 		goto out_err;
@@ -899,8 +919,10 @@ static inline void mmc_set_ios(struct mmc_host *host)
  */
 void mmc_set_chip_select(struct mmc_host *host, int mode)
 {
-	host->ios.chip_select = mode;
-	mmc_set_ios(host);
+	if (!(host->uhs2_caps.flags & MMC_UHS2_INITIALIZED)) {
+		host->ios.chip_select = mode;
+		mmc_set_ios(host);
+	}
 }
 
 /*
-- 
2.35.1

