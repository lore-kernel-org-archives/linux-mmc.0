From: Grant Likely <grant.likely@secretlab.ca>
Subject: Request for SPI testing
Date: Tue, 29 Jun 2010 21:30:34 -0600
Message-ID: <AANLkTimVajsJq9lRSLbv8_lzu7g_CL5ptmV5OLG6dBds@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:38121 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751182Ab0F3Daz (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 29 Jun 2010 23:30:55 -0400
Received: by gyd12 with SMTP id 12so188163gyd.19
        for <linux-mmc@vger.kernel.org>; Tue, 29 Jun 2010 20:30:54 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: spi-devel-general@lists.sourceforge.net, linux-mmc@vger.kernel.org, Ernst Schwab <eschwab@online.de>, Antonio Ospite <ospite@studenti.unina.it>, Ned Forrester <nforrester@whoi.edu>

I've pushed out Ernst's spi bus locking API patches to the following
branch.  Before I push them into linux-next, I'd like to get some
testing.  Can I have some volunteers please to pull this branch and
give it a spin?  Bonus points for people who have mmc cards
multiplexed with other devices on their SPI bus.

Cheers,
g.

The following changes since commit 5904b3b81d25166e5e39b9727645bb47937618e3:
  Linus Torvalds (1):
        Merge branch 'perf-fixes-for-linus' of
git://git.kernel.org/.../tip/linux-2.6-tip

are available in the git repository at:

  git://git.secretlab.ca/git/linux-2.6 spi/test

Cory Maccarrone (1):
      SPI100k: Fix 8-bit and RX-only transfers

Ernst Schwab (2):
      spi/mmc_spi: SPI bus locking API, using mutex
      spi/mmc_spi: mmc_spi adaptations for SPI bus locking API

 drivers/mmc/host/mmc_spi.c  |   59 ++---------
 drivers/spi/omap_spi_100k.c |   23 +++--
 drivers/spi/spi.c           |  225 ++++++++++++++++++++++++++++++++++++-------
 include/linux/spi/spi.h     |   12 +++
 4 files changed, 227 insertions(+), 92 deletions(-)

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
