Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1B5CC4332F
	for <linux-mmc@archiver.kernel.org>; Thu, 10 Nov 2022 15:08:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231187AbiKJPIn (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 10 Nov 2022 10:08:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbiKJPIm (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 10 Nov 2022 10:08:42 -0500
X-Greylist: delayed 450 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 10 Nov 2022 07:08:38 PST
Received: from mx.msync.work (mx.msync.work [185.250.0.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05DCF22B21;
        Thu, 10 Nov 2022 07:08:38 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E961B1231BF;
        Thu, 10 Nov 2022 15:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lexina.in; s=dkim;
        t=1668092468; h=from:subject:date:message-id:to:mime-version:
         content-transfer-encoding:in-reply-to:references;
        bh=1SsZIFbb2kZbNj0UZIQdbQ3Ryb9RW7TBdyeqOwWDSP8=;
        b=Kcgutp29e8mIhN54VxuwUvbroBo4WK8m4eNhrhlJzw/isHYXIGIy0+z/Mn9Uxu5pG/p8MG
        RoVPKrWlmAcR4eC7fA/qprLwh8TCN7p9NKqYUhF25AqUxKjm7HkjdKS4LAdtyHlMw2UNGH
        eCrbkPSpeoVdGvezxtTQ4OWg3ChMIuwZakR7YGF+ZroxS66W5tzV+9QBEnLJf1Kmk8W4dh
        LlUOtnkfzcKn3y4TQOz0OAQs/C4na6tkr9lW5Jw65ZFE10L6wwZPCvmDg4lYwIu8I8Gvqn
        7lvG++NWulRBJygF1QRUbZu+RvG4koI+zpW1D9r4WaXqbr9W8mHJphHtCDqK5A==
From:   Vyacheslav Bocharov <adeep@lexina.in>
To:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] arm64: amlogic: mmc: meson-gx: Add dts binding include for core, tx, rx eMMC/SD/SDIO phase clock settings from devicetree data
Date:   Thu, 10 Nov 2022 18:00:33 +0300
Message-Id: <20221110150035.2824580-3-adeep@lexina.in>
In-Reply-To: <20221110150035.2824580-1-adeep@lexina.in>
References: <20221110150035.2824580-1-adeep@lexina.in>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The mmc driver has the same phase values for all meson platforms. However,
some platforms (and even some boards) require different values. This patch
transfers the values from the set in the code to the variables in the
device-tree file.

Signed-off-by: Vyacheslav Bocharov <adeep@lexina.in>

 create mode 100644 include/dt-bindings/mmc/meson-gx-mmc.h

diff --git a/include/dt-bindings/mmc/meson-gx-mmc.h b/include/dt-bindings/mmc/meson-gx-mmc.h
new file mode 100644
index 000000000000..cfc4a9d75b2b
--- /dev/null
+++ b/include/dt-bindings/mmc/meson-gx-mmc.h
@@ -0,0 +1,35 @@
+/* SPDX-License-Identifier: (GPL-2.0+ or MIT) */
+/*
+ * Copyright (c) 2022 JetHome, Vyacheslav Bocharov
+ * Author: Vyacheslav Bocharov <adeep@lexina.in>
+ */
+
+#ifndef _DT_BINDINGS_MESON_GX_MMC_H
+#define _DT_BINDINGS_MESON_GX_MMC_H
+
+/*
+ * Cfg_rx_phase: RX clock phase
+ * bits: 9:8 R/W
+ * default: 0
+ * Recommended value: 0
+ *
+ * Cfg_tx_phase: TX clock phase
+ * bits: 9:8 R/W
+ * default: 0
+ * Recommended value: 2
+ *
+ * Cfg_co_phase: Core clock phase
+ * bits: 9:8 R/W
+ * default: 0
+ * Recommended value: 2
+ *
+ * values: 0: 0 phase, 1: 90 phase, 2: 180 phase, 3: 270 phase.
+ */
+
+#define   CLK_PHASE_0 0
+#define   CLK_PHASE_90 1
+#define   CLK_PHASE_180 2
+#define   CLK_PHASE_270 3
+
+
+#endif
-- 
2.30.2

