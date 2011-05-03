From: Chris Ball <cjb@laptop.org>
Subject: [GIT PULL] MMC fixes for 2.6.39-rc6
Date: Tue, 03 May 2011 06:24:04 -0400
Message-ID: <m31v0gqdyz.fsf@pullcord.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:46311 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751726Ab1ECKVC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 3 May 2011 06:21:02 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org

Hi Linus,

Please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/cjb/mmc.git for-linus

to receive seven small fixes for MMC.  These have been tested in
linux-next.  Thanks.

The following changes since commit e8dad69408a9812d6bb42d03e74d2c314534=
a4fa:
  Linus Torvalds (1):
        Merge branch 'fixes' of git://git.kernel.org/.../jejb/parisc-2.=
6

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/cjb/mmc.git for-linus

Ben Dooks (1):
      mmc: sdhci: Check mrq->cmd in sdhci_tasklet_finish

Chris Ball (2):
      mmc: sdhci-pci: Fix error case in sdhci_pci_probe_slot()
      mmc: sdhci: Check mrq !=3D NULL in sdhci_tasklet_finish

Guennadi Liakhovetski (2):
      mmc: fix a race between card-detect rescan and clock-gate work in=
stances
      mmc: tmio: fix .set_ios(MMC_POWER_UP) handling

Michael Buesch (1):
      mmc: omap: Fix possible NULL pointer deref

Micha=C5=82 Miros=C5=82aw (1):
      mmc: core: mmc_add_card(): fix missing break in switch statement

 drivers/mmc/core/bus.c          |    1 +
 drivers/mmc/core/host.c         |    9 ++++-----
 drivers/mmc/host/omap.c         |    2 +-
 drivers/mmc/host/sdhci-pci.c    |    1 +
 drivers/mmc/host/sdhci.c        |    9 ++++++++-
 drivers/mmc/host/tmio_mmc_pio.c |   10 +++++-----
 include/linux/mmc/host.h        |    1 -
 7 files changed, 20 insertions(+), 13 deletions(-)

--=20
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
