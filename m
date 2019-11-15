From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v5.4-rc8
Date: Fri, 15 Nov 2019 09:12:52 +0100
Message-ID: <20191115081252.20154-1-ulf.hansson@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org

Hi Linus,

Here's a PR with one trivial MMC fix, intended for v5.4-rc8. Details about the
highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 31f4f5b495a62c9a8b15b1c3581acd5efeb9af8c:

  Linux 5.4-rc7 (2019-11-10 16:17:15 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.4-rc7

for you to fetch changes up to fed23c5829ecab4ddc712d7b0046e59610ca3ba4:

  mmc: sdhci-of-at91: fix quirk2 overwrite (2019-11-14 14:57:53 +0100)

----------------------------------------------------------------
MMC host:
- sdhci-of-at91: Don't overwrite quirk flags

----------------------------------------------------------------
Eugen Hristev (1):
      mmc: sdhci-of-at91: fix quirk2 overwrite

 drivers/mmc/host/sdhci-of-at91.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
