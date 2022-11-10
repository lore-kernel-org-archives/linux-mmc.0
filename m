Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E466C4167D
	for <linux-mmc@archiver.kernel.org>; Thu, 10 Nov 2022 15:08:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231235AbiKJPIq (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 10 Nov 2022 10:08:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230397AbiKJPIm (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 10 Nov 2022 10:08:42 -0500
Received: from mx.msync.work (mx.msync.work [185.250.0.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9991823157;
        Thu, 10 Nov 2022 07:08:38 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id F14AD123169;
        Thu, 10 Nov 2022 15:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lexina.in; s=dkim;
        t=1668092469; h=from:subject:date:message-id:to:mime-version:
         content-transfer-encoding:in-reply-to:references;
        bh=dONz83S/sl0lvYKGXEj7vcvWK71sD2+ztpm57yFpufg=;
        b=OTavFoQLMbkEqY41c8FhiUtigQYo9tCEen8cj5clEkrfIdSs/a2eaDQC69VZY0uoB2otoN
        ++qyL00LAa2ymvVaLaAGYwr8PD0HNk97Qd40oz/Wl1PGUx/mTFQYYzZNFsM+UkwvhUlrPU
        b59Au0227AfMxPCq0qq0vaLAwxlBWdoCxPooBnfsCwmAIjkZdp0SmUoosZ8e3TL2eAIvEx
        ScisEvn3ghRTbEUg/EeAHFm1B9EHSvfiMT2mvvWYbLnEUc4EJitW3mJ6kCZPjRdFiVyV5x
        lZmA9Y/zZoI+PQDDl0JNUuLKyemTzhFLZe/AfNsqGhBY8ukXMVPAJBg3rvGmPQ==
From:   Vyacheslav Bocharov <adeep@lexina.in>
To:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] arm64: dts: docs: Update mmc meson-gx documentation for new config option amlogic,mmc-phase
Date:   Thu, 10 Nov 2022 18:00:35 +0300
Message-Id: <20221110150035.2824580-5-adeep@lexina.in>
In-Reply-To: <20221110150035.2824580-1-adeep@lexina.in>
References: <20221110150035.2824580-1-adeep@lexina.in>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

- amlogic,mmc-phases: 3-element array of clock phases for core, tx, rx
clock with values:
	0: CLK_PHASE_0 - 0 phase
	1: CLK_PHASE_90 - 90 phase
	2: CLK_PHASE_180 - 180 phase
	3: CLK_PHASE_270 - 270 phase
By default driver use <CLK_PHASE_180 CLK_PHASE_0 CLK_PHASE_0> value.

Signed-off-by: Vyacheslav Bocharov <adeep@lexina.in>

diff --git a/Documentation/devicetree/bindings/mmc/amlogic,meson-gx.txt b/Documentation/devicetree/bindings/mmc/amlogic,meson-gx.txt
index ccc5358db131..98c89c5b3455 100644
--- a/Documentation/devicetree/bindings/mmc/amlogic,meson-gx.txt
+++ b/Documentation/devicetree/bindings/mmc/amlogic,meson-gx.txt
@@ -25,6 +25,12 @@ Required properties:
 Optional properties:
 - amlogic,dram-access-quirk: set when controller's internal DMA engine cannot access the
   DRAM memory, like on the G12A dedicated SDIO controller.
+- amlogic,mmc-phases: 3-element array of clock phases for core, tx, rx clock with values:
+	0: CLK_PHASE_0 - 0 phase
+	1: CLK_PHASE_90 - 90 phase
+	2: CLK_PHASE_180 - 180 phase
+	3: CLK_PHASE_270 - 270 phase
+  By default driver use <CLK_PHASE_180 CLK_PHASE_0 CLK_PHASE_0> value.
 
 Example:
 
@@ -36,4 +42,5 @@ Example:
 		clock-names = "core", "clkin0", "clkin1";
 		pinctrl-0 = <&emmc_pins>;
 		resets = <&reset RESET_SD_EMMC_A>;
+		amlogic,mmc-phases = <CLK_PHASE_180 CLK_PHASE_0 CLK_PHASE_0>;
 	};
-- 
2.30.2

