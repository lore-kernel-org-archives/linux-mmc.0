From: Antonio Ospite <ospite@studenti.unina.it>
Subject: [RESEND PATCH 0/4] mmc_spi: Add support for regulator framework
Date: Thu, 21 Apr 2011 14:27:49 +0200
Message-ID: <1303388873-15467-1-git-send-email-ospite@studenti.unina.it>
References: <1300733202-27316-1-git-send-email-ospite@studenti.unina.it>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp205.alice.it ([82.57.200.101]:53211 "EHLO smtp205.alice.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752121Ab1DUM2B (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 21 Apr 2011 08:28:01 -0400
In-Reply-To: <1300733202-27316-1-git-send-email-ospite@studenti.unina.it>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Antonio Ospite <ospite@studenti.unina.it>, Chris Ball <cjb@laptop.org>, Grant Likely <grant.likely@secretlab.ca>, Mark Brown <broonie@opensource.wolfsonmicro.com>, openezx-devel@lists.openezx.org, spi-devel-general@lists.sourceforge.net

Hi,

resending the patchset as I missed some recipients on the first round.

This patchset has the purpose of adding support for the regulator framework to 
the mmc_spi driver. The first three patches are preparatory cleanups to make 
the forth one more straightforward.

Maybe the fourth patch can be improved, I am open to any suggestions about it.

These changes take strong inspiration from the pxamci driver; they have been 
tested on a Motorola A910, which uses a regulator to powerup the MMC card 
connected to the SPI bus, a test from a current user of the mmc_spi driver 
would not hurt just to be sure no regressions have been introduced.

Thanks,
   Antonio

Antonio Ospite (4):
  mmc_spi.c: factor out the check for power capability
  mmc_spi.c: factor out the SD card shutdown sequence
  mmc_spi.c: factor out a mmc_spi_setpower() function
  mmc_spi.c: add support for the regulator framework

 drivers/mmc/host/mmc_spi.c |  194 +++++++++++++++++++++++++++++---------------
 1 files changed, 129 insertions(+), 65 deletions(-)

-- 
Antonio Ospite
http://ao2.it

PGP public key ID: 0x4553B001

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
