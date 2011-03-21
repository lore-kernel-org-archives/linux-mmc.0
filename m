From: Antonio Ospite <ospite@studenti.unina.it>
Subject: [PATCH 0/4] mmc_spi: Add support for regulator framework
Date: Mon, 21 Mar 2011 19:46:38 +0100
Message-ID: <1300733202-27316-1-git-send-email-ospite@studenti.unina.it>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Antonio Ospite <ospite@studenti.unina.it>, Daniel Ribeiro <drwyrm@gmail.com>, David Brownell <dbrownell@users.sourceforge.net>, Chris Ball <cjb@laptop.org>, Grant Likely <grant.likely@secretlab.ca>, Ernst Schwab <eschwab@online.de>, Sonic Zhang <sonic.zhang@analog.com>, Linus Walleij <linus.walleij@stericsson.com>, openezx-devel@lists.openezx.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hi,

this patchset has the purpose of adding support for the regulator framework to 
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
