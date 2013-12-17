From: John Tobias <john.tobias.ph@gmail.com>
Subject: [PATCH 3/3]: Support cpu frequency scaling and power management for iMX6SL
Date: Mon, 16 Dec 2013 17:40:20 -0800
Message-ID: <CACUGKYOKEk9RUVS52gGc=CUNFYm1q+zT6rURnB4hwPkC0GCC1g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ob0-f177.google.com ([209.85.214.177]:33706 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751019Ab3LQBkU (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 16 Dec 2013 20:40:20 -0500
Received: by mail-ob0-f177.google.com with SMTP id vb8so5578333obc.8
        for <linux-mmc@vger.kernel.org>; Mon, 16 Dec 2013 17:40:20 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, Shawn Guo <shawn.guo@linaro.org>, Fabio Estevam <festevam@gmail.com>, Chris Ball <cjb@laptop.org>

Enable cpu frequency on imx6 config

From: John Tobias <john.tobias.ph@gmail.com>


diff --git a/arch/arm/configs/imx_v6_v7_defconfig
b/arch/arm/configs/imx_v6_v7_defconfig
index 8d0c5a0..a56cb2c 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -43,6 +43,17 @@ CONFIG_PREEMPT_VOLUNTARY=y
 CONFIG_AEABI=y
 # CONFIG_OABI_COMPAT is not set
 CONFIG_CMDLINE="noinitrd console=ttymxc0,115200"
+CONFIG_CPU_FREQ=y
+CONFIG_CPU_FREQ_GOV_COMMON=y
+CONFIG_CPU_FREQ_STAT=y
+CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=y
+CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
+CONFIG_CPU_FREQ_GOV_POWERSAVE=y
+CONFIG_CPU_FREQ_GOV_USERSPACE=y
+CONFIG_CPU_FREQ_GOV_ONDEMAND=y
+CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y
+CONFIG_GENERIC_CPUFREQ_CPU0=y
+CONFIG_ARM_IMX6Q_CPUFREQ=y
 CONFIG_VFP=y
 CONFIG_NEON=y
 CONFIG_BINFMT_MISC=m
