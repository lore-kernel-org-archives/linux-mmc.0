From: Wolfram Sang <w.sang@pengutronix.de>
Subject: [PATCH V4 0/3] adding write_protect and card_detect for mx25/35
Date: Sat, 26 Feb 2011 14:44:38 +0100
Message-ID: <1298727881-12141-1-git-send-email-w.sang@pengutronix.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:55082 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751409Ab1BZNoo (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 26 Feb 2011 08:44:44 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Chris Ball <cjb@laptop.org>, Wolfram Sang <w.sang@pengutronix.de>

Last tests showed some problems with MX51, especially with card_detect. While
the approach in general will suffice for i.MX5x, it seems there are a few
details missing right now. Because I do not have the resources (both time and
hardware) to deal with these issues, I propose a step by step approach. Let's
add the functionality for mx25/35 first and make sure there is no difference in
behaviour for mx5x. (Note that the i.MX5x can route the pins directly to the
controller, so a properly designed board should not need these gpio-additions.)
That is what this patch series does: The main change is that mx5x won't notice
any difference. For mx25/35, it is the same as it has been tested by Eric and
Marc.

Thanks to all involved in providing feedback, I hope it can go in now. If you
want to add support for it to your board, please CC me.

Have a nice weekend,

   Wolfram

Wolfram Sang (3):
  mmc: sdhci-esdhc-imx: add support for write protect on custom GPIO on
    mx25/35
  mmc: sdhci-esdhc: broken card detection is not a default quirk
  mmc: sdhci-esdhc-imx: add card detect on custom GPIO for mx25/35

 arch/arm/plat-mxc/include/mach/esdhc.h |   12 +++-
 drivers/mmc/host/sdhci-esdhc-imx.c     |  134 +++++++++++++++++++++++++++++---
 drivers/mmc/host/sdhci-esdhc.h         |    1 -
 drivers/mmc/host/sdhci-of-esdhc.c      |    3 +-
 4 files changed, 135 insertions(+), 15 deletions(-)

-- 
1.7.2.3

