From: Philip Rakity <prakity@marvell.com>
Subject: [PATCH 0/2] sdhci/sdhci-pxa. Allow platform specific reset
 processing
Date: Sun, 13 Feb 2011 23:08:22 -0800
Message-ID: <500B3702-AA75-4763-BC33-DECC6BFA08CC@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:53891 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751861Ab1BNHLT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 14 Feb 2011 02:11:19 -0500
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Mark Brown <markb@marvell.com>

Patch set 6/12

[PATCH 1/2] sdhci: sdhci.c: Add pre / post reset processing for chip 
specific reset
pxa controllers have private registers that may need to be
modified before and after a reset is done.

For example, the SD reset
operation, RESET_ALL,  will reset the private registers to their
default state.  This will cause the clock adjustment registers that
may have been programmed to have incorrect values.

RESET_DATA sometimes needs to be delayed before the reset is done
(depending on SoC) to enable any transactions being handled by the
SDIO card to be completed.  Needed in pre SD 3.0 silicon to handle
clock gating.

Implement hooks to allow this to happen.

[PATCH 2/2] sdhci: sdhci-pxa.c: Add post reset processing for chip 
specific registers

RESET_ALL resets chips private registers.
Reset to values specified in board file.

depends on board specific mach-mmp/plat-pxa sdhci.h definitions

