From: Fabio Estevam <festevam@gmail.com>
Subject: sdhci-esdhc-imx: could not set regulator OCR (-22)
Date: Mon, 5 Mar 2012 16:10:13 -0300
Message-ID: <CAOMZO5CYu82TkaNEMVMAVe82-Zu-T=hydi8GKS1_wgGNNWmkcw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:48365 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757133Ab2CETKP (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 5 Mar 2012 14:10:15 -0500
Received: by eekc41 with SMTP id c41so1614878eek.19
        for <linux-mmc@vger.kernel.org>; Mon, 05 Mar 2012 11:10:13 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Sascha Hauer <kernel@pengutronix.de>

Hi,

On a mx51babbage board running linux-next I get:

sdhci: Secure Digital Host Controller Interface driver
sdhci: Copyright(c) Pierre Ossman
sdhci-pltfm: SDHCI platform and OF driver helper
sdhci-esdhc-imx51.0 supply vmmc not found, using dummy regulator
mmc0: SDHCI controller on sdhci-esdhc-imx51.0 [sdhci-esdhc-imx51.0] using DMA
mmc0: mmc_rescan_try_freq: trying to init card at 400000 Hz
sdhci-esdhc-imx sdhci-esdhc-imx51.0: could not set regulator OCR (-22)
sdhci-esdhc-imx51.1 supply vmmc not found, using dummy regulator

Before I start investigating I would like to check whether these
regulator message errors have been fixed by some recent patches?

Thanks,

Fabio Estevam
