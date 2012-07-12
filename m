From: Chris Ball <cjb@laptop.org>
Subject: [GIT PULL] MMC fixes for 3.5-rc7
Date: Thu, 12 Jul 2012 15:15:28 -0400
Message-ID: <87liiopz8v.fsf@octavius.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hi Linus,

Please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/cjb/mmc.git tags/mmc-fixes-for-3.5-rc7

to receive two small MMC fixes for 3.5-rc7, both regressions against
3.5-rc1.  There are no merge conflicts, and the patches have been tested
in linux-next.  Thanks.


The following changes since commit 5db9a4d99b0157a513944e9a44d29c9cec2e91dc:

  cgroup: fix cgroup hierarchy umount race (2012-07-07 16:08:18 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/cjb/mmc.git tags/mmc-fixes-for-3.5-rc7

for you to fetch changes up to 623b51fc8642fd3c795fa9903be3adaa537ad9c5:

  mmc: cd-gpio: pass IRQF_ONESHOT to request_threaded_irq() (2012-07-10 23:03:57 -0400)

----------------------------------------------------------------
MMC fixes for 3.5-rc7:
 - Revert a patch that made failing to select power class fatal;
   it turns out that it fails non-fatally on Tegra boards.
   Regression against 3.5-rc1.
 - Add the IRQF_ONESHOT flag to the cd-gpio driver, which turned
   into a regression in 3.5-rc1 when IRQF_ONESHOT became required
   for threaded IRQs with no handler.

----------------------------------------------------------------
Guennadi Liakhovetski (1):
      mmc: cd-gpio: pass IRQF_ONESHOT to request_threaded_irq()

Venkatraman S (1):
      mmc: core: Revert "skip card initialization if power class selection fails"

 drivers/mmc/core/cd-gpio.c |    4 ++--
 drivers/mmc/core/mmc.c     |   18 +++++++++++-------
 2 files changed, 13 insertions(+), 9 deletions(-)

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
