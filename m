Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A201C433EF
	for <linux-mmc@archiver.kernel.org>; Tue, 18 Jan 2022 12:44:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237989AbiARMoX (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 18 Jan 2022 07:44:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237770AbiARMoV (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 18 Jan 2022 07:44:21 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38C66C06161C
        for <linux-mmc@vger.kernel.org>; Tue, 18 Jan 2022 04:44:21 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id b3so15163465plc.7
        for <linux-mmc@vger.kernel.org>; Tue, 18 Jan 2022 04:44:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4i6vQaoV3DjwHFO2PmOCtUq+/IFC+1oV80n6E6OJqos=;
        b=TVR33fZujaiioly8Ds0P1A0e2Xa9F/XhrVHptxG1wgQVF7iRdmYU5Q0qFoe+XLji8T
         4pwbdtXdgGldPDKF5eG2op+yxBZ8xFmko4ZYhrHMAHG4bzsSdn7KDCKVvZfCsoKCxgAS
         2omr6hUxxi2bdy6HqvcXG4pFW8Pvwat7+1m1/iiBFq08atP51ttTOB+YpbqX/DXh/c6/
         V+sJYf7TwH1n6ExWNhk+bHSf0rOtFtpEAtrEcHOU6370U4NHpf4Cg9a/DNI7eNDY6LKX
         /vKDvDA+G+9ssseweJVyFsLgD3gwLT6/GzA+d2SK8+JZAmIQm1hgqj0b6G1cvvBqg/uJ
         cnVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4i6vQaoV3DjwHFO2PmOCtUq+/IFC+1oV80n6E6OJqos=;
        b=Lz7qHA3li9HMX2l/jTK0x1mYX/CFS5aIXrwXW4cHv1wZV/dHgLyENmFaAKSwUtazT9
         +Tam/hBWrvn+EMTTQncs33/IkXEQooURB1DMB7W7siISUVrR9Q0fa/rlzXATzQzwWfeN
         E03uAYZ4dVvCr962Ft3hNkMYsxqHfc4F72uJVrYl736AXeNppyTd76aHj8M6p/eAWLsb
         KR3xqy0QfO1C5/0PcthHDVmhb5Bi8sZU7gbNVeNiR8OILyzJ9Sae4x4/zbL6YykNnxIZ
         nbMSqdm3jMTfsOBZXnbFPkTNNK/H8dlHO3bXhuck6jtC+nmcOsk4Wkve4Jsr5LuKdhNT
         pf6w==
X-Gm-Message-State: AOAM531iq3ES4h2wFVQ9rG0KibkjMqfUvbZiBO5z0ARVtMUIdToZSLV9
        8fp+Hv4Dkzn1hX78S8ljazI=
X-Google-Smtp-Source: ABdhPJxS9MrN+y7Jobf6QOl5iQ5fCGXqPed8XN/xThJY2kPfzhjsrecutdVTg2w+H3jhNhDTABijCQ==
X-Received: by 2002:a17:903:120a:b0:149:8b16:ee19 with SMTP id l10-20020a170903120a00b001498b16ee19mr27412033plh.11.1642509860783;
        Tue, 18 Jan 2022 04:44:20 -0800 (PST)
Received: from jason-z170xgaming7.genesyslogic.com.tw (60-251-58-169.hinet-ip.hinet.net. [60.251.58.169])
        by smtp.gmail.com with ESMTPSA id n10sm362005pfj.120.2022.01.18.04.44.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jan 2022 04:44:20 -0800 (PST)
From:   Jason Lai <jasonlai.genesyslogic@gmail.com>
To:     ulf.hansson@linaro.org, takahiro.akashi@linaro.org,
        adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, ben.chuang@genesyslogic.com.tw,
        greg.tu@genesyslogic.com.tw, jason.lai@genesyslogic.com.tw,
        otis.wu@genesyslogic.com.tw,
        Jason Lai <jasonlai.genesyslogic@gmail.com>
Subject: [PATCH v2 7/7] mmc: core: Support UHS-II card access
Date:   Tue, 18 Jan 2022 20:43:55 +0800
Message-Id: <20220118124355.167552-8-jasonlai.genesyslogic@gmail.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20220118124355.167552-1-jasonlai.genesyslogic@gmail.com>
References: <20220118124355.167552-1-jasonlai.genesyslogic@gmail.com>
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
index 19b409179..e00569df2 100644
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
2.34.0

