From: Simon Horman <horms@verge.net.au>
Subject: [GIT PULL] SuperH Mobile ARM
Date: Thu, 31 Mar 2011 15:21:29 +0900
Message-ID: <1301552490-16064-1-git-send-email-horms@verge.net.au>
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: linux-sh@vger.kernel.org, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Chris Ball <cjb@laptop.org>, Magnus Damm <magnus.damm@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Paul Mundt <lethal@linux-sh.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>
List-Id: linux-mmc@vger.kernel.org

Hi Russell,

please considder pulling
  git://git.kernel.org/pub/scm/linux/kernel/git/horms/shmobile-2.6.git for-russell

To get the following changes since commit 0ce790e7d736cedc563e1fb4e998babf5a4dbc3d:

  Linux 2.6.39-rc1 (2011-03-29 12:09:47 -0700)

I apologised for not sending this earlier, however the last
dependency for this patch only went in just before 2.6.39-rc1 -
the 2nd last patch of the last merge.

I believe that the potential fall out of this patch is
limited to breaking (non-eSD) zboot support for SuperH Mobile ARM
and as such I would like it considered for inclusion in 2.6.39-rc2.

Simon Horman (1):
      mmc, ARM: Add zboot from eSD support for SuperH Mobile ARM

 Documentation/arm/SH-Mobile/zboot-rom-sdhi.txt    |   43 ++
 arch/arm/Kconfig                                  |   33 ++-
 arch/arm/boot/compressed/Makefile                 |   10 +-
 arch/arm/boot/compressed/head-shmobile.S          |   12 +-
 arch/arm/boot/compressed/mmcif-sh7372.c           |    2 +-
 arch/arm/boot/compressed/sdhi-sh7372.c            |   95 +++++
 arch/arm/boot/compressed/sdhi-shmobile.c          |  449 +++++++++++++++++++++
 arch/arm/boot/compressed/sdhi-shmobile.h          |   11 +
 arch/arm/mach-shmobile/include/mach/sdhi-sh7372.h |   21 +
 arch/arm/mach-shmobile/include/mach/sdhi.h        |   16 +
 10 files changed, 675 insertions(+), 17 deletions(-)
 create mode 100644 Documentation/arm/SH-Mobile/zboot-rom-sdhi.txt
 create mode 100644 arch/arm/boot/compressed/sdhi-sh7372.c
 create mode 100644 arch/arm/boot/compressed/sdhi-shmobile.c
 create mode 100644 arch/arm/boot/compressed/sdhi-shmobile.h
 create mode 100644 arch/arm/mach-shmobile/include/mach/sdhi-sh7372.h
 create mode 100644 arch/arm/mach-shmobile/include/mach/sdhi.h
