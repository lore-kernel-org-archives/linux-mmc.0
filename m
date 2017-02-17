From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v.4.10 rc9
Date: Fri, 17 Feb 2017 08:37:03 +0100
Message-ID: <CAPDyKFruFwqFyxBQ1Ey11mwvyz=_fdjtH5WhnTzmyv=FW1fsEQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus <torvalds@linux-foundation.org>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

Hi Linus,

Here's one mmc fix intended for v4.10 rc9 (or final if no new rc).
Based on v4.10-rc8.

Details are as usual found in the signed tag. Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 7089db84e356562f8ba737c29e472cc42d530dbc:

  Linux 4.10-rc8 (2017-02-12 13:03:20 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v4.10-rc8

for you to fetch changes up to 3d4ef329757cfd5e0b23cce97cdeca7e2df89c99:

  mmc: core: fix multi-bit bus width without high-speed mode
(2017-02-14 08:50:10 +0100)

----------------------------------------------------------------
MMC core:
 - Fix multi-bit bus width without high-speed mode for MMC

----------------------------------------------------------------
Anssi Hannula (1):
      mmc: core: fix multi-bit bus width without high-speed mode

 drivers/mmc/core/mmc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)
