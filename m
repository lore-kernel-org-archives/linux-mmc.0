From: Philip Rakity <prakity@marvell.com>
Subject: [PATCH 0/2] mmc: sdhci/sdhci-pxa: add support for hardware clock
 gating callback
Date: Sun, 13 Feb 2011 23:22:00 -0800
Message-ID: <6DE5791C-CCB8-4ED8-AE25-BDD578695F46@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:57066 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751367Ab1BNHZd convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 14 Feb 2011 02:25:33 -0500
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Mark Brown <markb@marvell.com>



Patch set 11/12

[PATCH 1/2] mmc: add support for H/W clock gating of SD controller
This code extends software clock gating in the MMC layer by adding the ability
to indicate that the SD controller supports hardware clock gating.

Hardware clock gating is enabled by setting the MMC capability
MMC_CAP_HW_CLOCK_GATING in the SD driver.

eg: host->mmc->caps |= MMC_CAP_HW_CLOCK_GATING

The approach follows the suggestion of Nico Pitre.

SD/MMC/eMMC cards use dynamic clocks
SDIO uses continuous clocks to properly detect SDIO card interrupts

The code has been tested using marvell linux and linux-next for MMP2.
The Marvell pxa controllers support H/W clock gating.

[PATCH 2/2] sdhci: sdhci-pxa: add support for hardware clock gating callback

enable controller caps to support h/w clock gating