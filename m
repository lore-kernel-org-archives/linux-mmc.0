From: Saeed Bishara <saeed@marvell.com>
Subject: RE: [PATCH] MMC: add support for the Marvell platform SDHCI
 controller
Date: Wed, 27 Oct 2010 10:46:17 +0200
Message-ID: <FCBE654890C0334289D0AD3AF4EF009FE1475AA356@IL-MB01.marvell.com>
References: <1288166860-28556-1-git-send-email-mike@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:41761 "HELO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752367Ab0J0Ix6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 27 Oct 2010 04:53:58 -0400
In-Reply-To: <1288166860-28556-1-git-send-email-mike@compulab.co.il>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Mike Rapoport <mike@compulab.co.il>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

 
 
>+config MMC_SDHCI_MV
>+	bool "SDHCI support on Marvell's SoC"
>+	depends on MMC_SDHCI
>+	depends on MMC_SDHCI_PLTFM
>+	select MMC_SDHCI_IO_ACCESSORS
>+	help
>+	  This selects the Secure Digital Host Controller Interface in
>+	  Marvell's SoC controllers.
>+
>+	  If you have a controller with this interface, say Y or M here.
>+
>+	  If unsure, say N.
>+
Mike, the config name and description is too generic as there are several sdhci controllers on Marvell devices (see like pxa), I suggest to name it SDHCI_DOVE and make it depends on ARCH_DOVE and modify the description accordingly.

>+#include <linux/clk.h>
>+#include <linux/delay.h>
>+#include <linux/err.h>
>+#include <linux/platform_device.h>
>+#include <linux/io.h>
>+#include <linux/mmc/host.h>
>+#include "sdhci.h"
>+#include "sdhci-pltfm.h"
are those includes are realy needed? At least the delay.h and clk.h not needed for now.

saeed