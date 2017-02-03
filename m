From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v.4.10 rc7
Date: Fri, 3 Feb 2017 11:08:03 +0100
Message-ID: <CAPDyKFqO-VViRKPfK3WiVVgTL-tvnPVEOnUUoQ5=oqHP1zNZkg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus <torvalds@linux-foundation.org>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Gabriel Krisman Bertazi <krisman@collabora.co.uk>
List-Id: linux-mmc@vger.kernel.org

Hi Linus,

Here's one mmc fix intended for v4.10 rc7. Based on v4.10-rc6.

Details are as usual found in the signed tag. Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 566cf877a1fcb6d6dc0126b076aad062054c2637:

  Linux 4.10-rc6 (2017-01-29 14:25:17 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v4.10-rc6

for you to fetch changes up to 161e6d44a5e2d3f85365cb717d60e363171b39e6:

  mmc: sdhci: Ignore unexpected CARD_INT interrupts (2017-01-31 11:26:49 +0100)

----------------------------------------------------------------
MMC host:
 - sdhci: Avoid hang when receiving spurious CARD_INT interrupts

----------------------------------------------------------------
Gabriel Krisman Bertazi (1):
      mmc: sdhci: Ignore unexpected CARD_INT interrupts

 drivers/mmc/host/sdhci.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)
