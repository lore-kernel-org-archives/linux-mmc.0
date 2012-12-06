From: Chris Ball <cjb@laptop.org>
Subject: [GIT PULL] MMC fixes for 3.7
Date: Thu, 06 Dec 2012 16:35:14 -0500
Message-ID: <87txrydfu5.fsf@octavius.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:38942 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1424897Ab2LFVfU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 6 Dec 2012 16:35:20 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Linus,

Please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/cjb/mmc.git tags/mmc-fi=
xes-for-3.7

to receive two small regression fixes for 3.7.  There are no merge
conflicts.  Thanks.


The following changes since commit 0aa55c2367f082876f92660312214cd20c6a=
024b:

  mmc: sdhci-s3c: fix the card detection in runtime-pm (2012-11-07 15:4=
0:52 -0500)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/cjb/mmc.git tags/mmc-fi=
xes-for-3.7

for you to fetch changes up to 91ab252ac5a5c3461dd6910797611e9172626aed=
:

  mmc: sh-mmcif: avoid oops on spurious interrupts (second try) (2012-1=
2-06 13:54:35 -0500)

----------------------------------------------------------------
MMC fixes for 3.7:
 - sdhci-s3c: Fix runtime PM regression against 3.7-rc1
 - sh-mmcif: Fix oops against 3.6

----------------------------------------------------------------
Chris Ball (1):
      Revert misapplied "mmc: sh-mmcif: avoid oops on spurious interrup=
ts"

Guennadi Liakhovetski (1):
      mmc: sh-mmcif: avoid oops on spurious interrupts (second try)

Heiko St=C3=BCbner (1):
      mmc: sdhci-s3c: fix missing clock for gpio card-detect

 drivers/mmc/host/sdhci-s3c.c | 7 +++++++
 drivers/mmc/host/sh_mmcif.c  | 8 ++------
 2 files changed, 9 insertions(+), 6 deletions(-)

--=20
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
