Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2518C7EE2A
	for <linux-mmc@archiver.kernel.org>; Thu, 18 May 2023 21:02:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbjERVC5 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 18 May 2023 17:02:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbjERVC4 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 18 May 2023 17:02:56 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0633136
        for <linux-mmc@vger.kernel.org>; Thu, 18 May 2023 14:02:54 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2ad89c7a84fso27354771fa.2
        for <linux-mmc@vger.kernel.org>; Thu, 18 May 2023 14:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684443773; x=1687035773;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4G/ypnTlXP4W9YP4yFZVLIByppuXGY5xpC0A2Ptkn3o=;
        b=DFdOB7eKGcqxxSuHNtOSjwyWO2dAjoPmGTPylJ1IpBJspPmIa+u/kfPx8yW4k5Zt+v
         b6IShs/9RGcBNORsufG0710YZkbM5P6skUh6ytsSfeQwH324NbXsBmzzRempIb099Sy9
         bL67x+FwyC0QkrBDdfGAbq/DSfDWtrrzEIus64R/ANDCwWmZan23ILgPKO1AOiyboJpF
         Z+myqL7xGiS1azy96kVbX8Glmt+OqnBxPRaHtC+LI0CerhrKny/VDWMZDzQMRsBggJtM
         Zw5dec39O7OcO8zUNd0MOH9QutA4w7UFLCSQjC1qpY/HTuaQ8l03RzmCpLD7l03Bx1/r
         wNkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684443773; x=1687035773;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4G/ypnTlXP4W9YP4yFZVLIByppuXGY5xpC0A2Ptkn3o=;
        b=QgidL9NoNiF6Uy0EwZKbHtrm3WIe6vXf01kyW526jLtFMQMzAoJEvuwwxtWmFmAPxc
         c/hOotU51N1LtpVf0CzQsxuF6UisWfJcIV+TUiUTLxtNx10KDfqrprnOCcGlaf1sOkZm
         sHz8GAflZC3+Hcwk+xulXkWwERoT2rtA8K+KVZXbeWX3jJBQwKlmZlMUcdEIp2lBq9pb
         Wv69F4N8qrUzd43eWlW5sdJUJilZEtFNSMQFNGtMZ7mT4mUWcPaM706WB2kHr3seB8N7
         vJYQ5zDq1wvIH7nByx4LNM2q0xxGXg8WfAnp/a/Hm8cdIbtrDFpdr/HewxuiKOW4RUZT
         t0zw==
X-Gm-Message-State: AC+VfDzjtKCGbEffVqjVNF590p5v99y5KA+rCeSmwY5DgI581HnCunNO
        spkMDbPpcsGQzuBVcp8EST71aQ==
X-Google-Smtp-Source: ACHHUZ6p5AD48mQDJSPMyJR1xmeALZxRdNttjQaQKjI3gTpssk9h4Kvj4nRFh7kTVHC8olyzm88VKw==
X-Received: by 2002:ac2:5973:0:b0:4f3:7a8c:d46c with SMTP id h19-20020ac25973000000b004f37a8cd46cmr62166lfp.66.1684443773143;
        Thu, 18 May 2023 14:02:53 -0700 (PDT)
Received: from Fecusia.lan (c-05d8225c.014-348-6c756e10.bbcust.telenor.se. [92.34.216.5])
        by smtp.gmail.com with ESMTPSA id i13-20020ac25d2d000000b004b40c1f1c70sm354976lfb.212.2023.05.18.14.02.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 14:02:52 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Stephan Gerhold <stephan@gerhold.net>
Cc:     Russell King <linux@armlinux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        stable@vger.kernel.org, phone-devel@vger.kernel.org,
        Stefan Hansson <newbyte@disroot.org>
Subject: [PATCH v3] mmc: mmci: Add busydetect timeout
Date:   Thu, 18 May 2023 23:02:46 +0200
Message-Id: <20230518210246.2401737-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Add a timeout for busydetect IRQs using a delayed work.
It might happen (and does happen) on Ux500 that the first
busy detect IRQ appears and not the second one. This will
make the host hang indefinitely waiting for the second
IRQ to appear.

Fire a delayed work after 10ms and re-engage the command
IRQ so the transaction finishes: we are certainly done
at this point, or we will catch an error in the status
register.

This makes the eMMC work again on Skomer and Codina phones.

Notice that the hardware time-out cannot be used, because
the state machine in the MMCI will not see that something
is wrong.

Cc: stable@vger.kernel.org
Cc: phone-devel@vger.kernel.org
Cc: Stefan Hansson <newbyte@disroot.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v2->v3:
- Took out the most urgent fix from the pile of changes
  and send separately, without the rest of the refactorings
  that were used for debugging the issue. After this the
  Skomer and Codina with problematic eMMC boots fine.
- Now just a single patch!
- This version should be easier to backport as well.
---
 drivers/mmc/host/mmci.c | 22 ++++++++++++++++++++++
 drivers/mmc/host/mmci.h |  1 +
 2 files changed, 23 insertions(+)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index f2b2e8b0574e..f3349fb99590 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -37,6 +37,7 @@
 #include <linux/pinctrl/consumer.h>
 #include <linux/reset.h>
 #include <linux/gpio/consumer.h>
+#include <linux/workqueue.h>
 
 #include <asm/div64.h>
 #include <asm/io.h>
@@ -695,6 +696,8 @@ static bool ux500_busy_complete(struct mmci_host *host, u32 status, u32 err_msk)
 	if (host->busy_status &&
 	    (status & host->variant->busy_detect_flag)) {
 		writel(host->variant->busy_detect_mask, base + MMCICLEAR);
+		schedule_delayed_work(&host->busy_timeout_work,
+				      msecs_to_jiffies(10));
 		return false;
 	}
 
@@ -1429,6 +1432,22 @@ mmci_cmd_irq(struct mmci_host *host, struct mmc_command *cmd,
 	}
 }
 
+/*
+ * This busy timeout worker is used to "kick" the command IRQ if a
+ * busy detect IRQ fails to appear in reasonable time. Only used on
+ * variants with busy detection IRQ delivery.
+ */
+static void busy_timeout_work(struct work_struct *work)
+{
+        struct mmci_host *host =
+		container_of(work, struct mmci_host, busy_timeout_work.work);
+	u32 status;
+
+	dev_dbg(mmc_dev(host->mmc), "timeout waiting for busy IRQ\n");
+	status = readl(host->base + MMCISTATUS);
+	mmci_cmd_irq(host, host->cmd, status);
+}
+
 static int mmci_get_rx_fifocnt(struct mmci_host *host, u32 status, int remain)
 {
 	return remain - (readl(host->base + MMCIFIFOCNT) << 2);
@@ -2242,6 +2261,9 @@ static int mmci_probe(struct amba_device *dev,
 			goto clk_disable;
 	}
 
+	if (host->variant->busy_detect && host->ops->busy_complete)
+		INIT_DELAYED_WORK(&host->busy_timeout_work, busy_timeout_work);
+
 	writel(MCI_IRQENABLE | variant->start_err, host->base + MMCIMASK0);
 
 	amba_set_drvdata(dev, mmc);
diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
index e1a9b96a3396..de2c1436f4cd 100644
--- a/drivers/mmc/host/mmci.h
+++ b/drivers/mmc/host/mmci.h
@@ -437,6 +437,7 @@ struct mmci_host {
 	void			*dma_priv;
 
 	s32			next_cookie;
+	struct delayed_work	busy_timeout_work;
 };
 
 #define dma_inprogress(host)	((host)->dma_in_progress)
-- 
2.40.1

