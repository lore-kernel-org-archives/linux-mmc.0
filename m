From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: adding aliases to mmc ... again
Date: Thu, 22 May 2014 17:30:21 +0200
Message-ID: <1400772623-8390-1-git-send-email-s.hauer@pengutronix.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:60852 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751422AbaEVPaf (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 22 May 2014 11:30:35 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Dirk Behme <dirk.behme@de.bosch.com>, Fabio Estevam <festevam@gmail.com>, ptx@pengutronix.de, Stephen Warren <swarren@wwwdotorg.org>

Hi all,

The wish to have persistent MMC block device names for passing a suitable
root=/dev/mmcblkX option came up several times already and has been discussed
at least in these threads:

http://lists.infradead.org/pipermail/linux-arm-kernel/2012-July/109984.html
https://www.mail-archive.com/linux-mmc@vger.kernel.org/msg22104.html
http://comments.gmane.org/gmane.linux.kernel.mmc/21519

Several patches have been proposed to nail the slot index to a known number.
Arguments against these patches were:

- Use an initrd and locate the correct root device there
  even Thomas who suggested this admitted this would be painful to do
- use root=UUID= or root=PARTUUID=
  This generally works but has an important downside. With the UUID
  approach devices which should boot from the internal eMMC may start
  booting from an external SD slot when somebody deliberately inserts
  a SD card with the same UUID.

The following patches should have the technical issues fixed. It works
by counting the mmc aliases in the devicetree during initialization of
the mmc framework. Those slot numbers will never be assigned to other
hosts.

Sascha

----------------------------------------------------------------
Sascha Hauer (2):
      of: Add helper for getting the maximum alias index for a stem
      mmc: Allow setting slot index via devicetree alias

 drivers/mmc/card/block.c | 11 ++++++++++-
 drivers/mmc/core/core.c  | 37 +++++++++++++++++++++++++++++++++++++
 drivers/mmc/core/host.c  | 17 +++++++++++++++--
 drivers/of/base.c        | 29 +++++++++++++++++++++++++++++
 include/linux/mmc/core.h |  3 +++
 include/linux/of.h       |  6 ++++++
 6 files changed, 100 insertions(+), 3 deletions(-)
