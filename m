From: Simon Horman <horms@verge.net.au>
Subject: mmc: sdhi, tmio: updates
Date: Mon,  9 May 2011 09:55:10 +0900
Message-ID: <1304902516-14150-1-git-send-email-horms@verge.net.au>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:50154 "EHLO
	kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756285Ab1EIAzf (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 8 May 2011 20:55:35 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Magnus Damm <magnus.damm@gmail.com>
Cc: Ian Molton <ian@mnementh.co.uk>, Chris Ball <cjb@laptop.org>, Paul Mundt <lethal@linux-sh.org>, linux-sh@vger.kernel.org, linux-mmc@vger.kernel.org

Hi,

there are currently a number of patches floating around for
TMIO and SDHI. This post is an attempt to collect together the latest
version of each of these patches.

I have also changed the author of the following patches
from Magnus to Guennadi to reflect that Guennadi wrote
the most recent version. In each case I have noted that the patch
is based on work by Magnus and as appropriate work by myself.

	mmc: tmio / sdhi: break out interrupt request/free
	mmc: sdhi: support up to 3 interrupt sources

I have also removed Signed-off-by lines from the following
patches which were not supplied by the person whose name
features in the Signed-off-by line.

	mmc: sdhi: support up to 3 interrupt sources
	mmc: tmio / sdhi: break out interrupt request/free

Or in other words, I removed Magnus's Signed-off-by lines
where Guennadi had posted a revised version of the patch.

Magnus, could you add a Reviewed-by, Acked-by
or Signed-off-by as you feel is appropriate?


For reference the patches are available at:
  git://git.kernel.org/pub/scm/linux/kernel/git/horms/shmobile-2.6.git sdhi-next

Which is based on:
  git://git.kernel.org/pub/scm/linux/kernel/git/cjb/mmc.git mmc/mmc-next


Guennadi Liakhovetski (4):
      MMC: protect the tmio_mmc driver against a theoretical race
      mmc: Add runtime and system-wide PM to the TMIO MMC driver
      mmc: tmio / sdhi: break out interrupt request/free
      mmc: sdhi: support up to 3 interrupt sources

Magnus Damm (2):
      mmc: sdhi: no need for special interrupt flags
      mmc: sdhi: print out something useful

 drivers/mmc/host/sh_mobile_sdhi.c |   44 ++++++++++++-
 drivers/mmc/host/tmio_mmc.c       |   32 ++++++---
 drivers/mmc/host/tmio_mmc.h       |   13 ++++-
 drivers/mmc/host/tmio_mmc_dma.c   |   21 ++++---
 drivers/mmc/host/tmio_mmc_pio.c   |  128 +++++++++++++++++++++++++++++++------
 5 files changed, 195 insertions(+), 43 deletions(-)

