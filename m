From: yongd <yongd@marvell.com>
Subject: (unknown)
Date: Fri, 28 Sep 2012 18:28:30 +0800
Message-ID: <1348828113-19668-1-git-send-email-yongd@marvell.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog124.obsmtp.com ([74.125.149.151]:34009 "EHLO
	na3sys009aog124.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751294Ab2I1K25 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 28 Sep 2012 06:28:57 -0400
Subject: 
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>, Anton Vorontsov <anton.vorontsov@linaro.org>, Marek Szyprowski <m.szyprowski@samsung.com>, Shawn Guo <shawn.guo@linaro.org>, Wolfram Sang <w.sang@pengutronix.de>, Daniel Drake <dsd@laptop.org>, Sascha Hauer <s.hauer@pengutronix.de>, Wilson Callan <wilson.callan@savantsystems.com>, Ben Dooks <ben-linux@fluff.org>
Cc: zhangfei.gao@marvell.com, kevin.liu@marvell.com, jlfu@marvell.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

ngd@marvell.com> # This line is ignored.
From: yongd <yongd@marvell.com>
Subject:[PATCH 0/3] mmc: enable card-detection polling in host driver rather than in sdhci_add_host
In-Reply-To:


Hi all,
As checked, SDHCI_QUICK_BROKEN_CARD_DETECTION was previously introduced by Anton Vorontsov in commit
68d1fb7e229c6f95be4fbbe3eb46b24e41184924. For a removable card (MMC_CAP_NONREMOVABLE is not set),
if this QUICK is set, sdhci_add_host will set MMC_CAP_NEEDS_POLL to enable card-detection polling method,
and sdhci_set_card_detection will not enable host controller card insert/remove interrupts (the host
internal card detection method).

However, we can have some other card detection methods besides host internal card detection and polling
methods. For example, we might use an external GPIO pin for detection. In such case, we will not set
MMC_CAP_NONREMOVABLE since removable, and set SDHCI_QUICK_BROKEN_CARD_DETECTION since we don't use controller
card insert/remove interrupts. But unexpectedly, sdhci_add_host will still enable polling for us. This
is redundant.

So, here comes the following solution.
1st, enable card-detection polling in vendor host driver itself so that it will not rely on sdhci_add_host.
 [PATCH 1/3]: for sdhci-esdhc-imx.c
 [PATCH 2/3]: for sdhci-s3c.c
 And for other vendor host drivers(sdhci-pxav2/3.c, sdhci-pci.c, sdhci-of-esdhc.c), as checked, those who
set SDHCI_QUICK_BROKEN_CARD_DETECTION actually do not set this for enabling polling. So no similar change is          
needed.

2nd, remove MMC_CAP_NEEDS_POLL setting in sdhci_add_host, as in [PATCH 3/3].

++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
Actually I have had some discussion with Anton, and now added more reviewers here since my proposal influences
others. I will appreciate your review and comments. Thanks a lot:-)
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
