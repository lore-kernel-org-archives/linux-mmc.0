From: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Subject: [BUG/RFC] SDHCI_QUIRK_NO_MULTIBLOCK for i.MX35/25
Date: Fri, 15 Nov 2013 10:15:37 +0100
Message-ID: <20131115091537.GF28658@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:38983 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757099Ab3KOJPk (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 15 Nov 2013 04:15:40 -0500
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>

Hi!


1 Actual Use-Case
=================

  I have a SDIO card with a Marvell 8787, that works fine on an i.MX53
  with the drivers/net/wireless/mwifiex/sdio.c driver. On an i.MX35
  however the loading of the firmware errors out on the very first
  single-block transfer with 1024 bytes payload.


2 Reason for failure
====================

  sdhci defines SDHCI_QUIRK_NO_MULTIBLOCK to completely disable
  multi-block transfers for a host. The max_blk_count is simply set to 1
  to achieve this. Currently only i.MX35 and i.MX25 seem to be the only
  users of that quirk.  The quirk is used to fix an errata on these
  SoCs, that says, that "CMD12 abort operation does not abort data
  transfer on AHB". (ENGcm07207)

  So, this is a problem regarding only SD and not SDIO.  On this special
  SDIO card, it looks like multi-block transfer has to be used for
  anything >16 bytes. Removing the quirk fixes the firmware loading
  error. The device is detected successfully after loading and can
  connect to an AP.


3 Question
==========

  And here comes the question: What would be the correct approach to fix
  that and differentiate those two cases, so that we can use multi-block
  transfers with CMD53 but not with CMD25(?!) ?

  1a. As I see no other users of that quirk, it might be okay to rename
      it, to better reflect the actual problem it fixes (broken CMD12 or
      something).

  1b. When the host knows with what it deals with (SDIO or SD) set the
      max_blk_count according to the quirk. And only in the SD case, that is.

  or

  2. Introduce a max_blk_count_sd and max_blk_count_sdio and use them
     everywhere. Seems rather invasive and over the top.

  or

  3. something better.


Regards,
Steffen

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
