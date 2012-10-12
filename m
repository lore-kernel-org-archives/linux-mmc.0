From: Chris Ball <cjb@laptop.org>
Subject: [GIT PULL] MMC merge for 3.7-rc1, part 2
Date: Fri, 12 Oct 2012 08:17:54 -0400
Message-ID: <87lifb3mvh.fsf@octavius.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:57793 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758977Ab2JLMSH (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 12 Oct 2012 08:18:07 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org

Hi Linus,

Please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/cjb/mmc.git tags/mmc-merge-for-3.7-rc1-part2

to receive two more changes for 3.7.  There are no conflicts.  Thanks.


The following changes since commit 12250d843e8489ee00b5b7726da855e51694e792:

  Merge branch 'i2c-embedded/for-next' of git://git.pengutronix.de/git/wsa/linux (2012-10-11 10:27:51 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/cjb/mmc.git tags/mmc-merge-for-3.7-rc1-part2

for you to fetch changes up to 60fe5771be6aa3f37d5887aa01c04f733130a559:

  UAPI: (Scripted) Disintegrate include/linux/mmc (2012-10-11 17:27:54 -0400)

----------------------------------------------------------------
 - Disintegrate UAPI, fix a mismerge that caused a build error.

----------------------------------------------------------------
David Howells (1):
      UAPI: (Scripted) Disintegrate include/linux/mmc

Marek Vasut (1):
      mmc: mxs-mmc: Fix merge issue causing build error

 drivers/mmc/host/mxs-mmc.c           | 2 +-
 include/linux/mmc/Kbuild             | 1 -
 include/uapi/linux/mmc/Kbuild        | 1 +
 include/{ => uapi}/linux/mmc/ioctl.h | 0
 4 files changed, 2 insertions(+), 2 deletions(-)
 rename include/{ => uapi}/linux/mmc/ioctl.h (100%)

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
