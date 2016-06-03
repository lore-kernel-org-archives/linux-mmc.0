From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v.4.7 rc2
Date: Fri, 3 Jun 2016 09:40:01 +0200
Message-ID: <CAPDyKFrsXzJf4BicYUoS4WYu8vgLLh7pCiMK05CPCR3yOtGqww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Jaehoon Chung <jh80.chung@samsung.com>, Chen-Yu Tsai <wens@csie.org>, =?UTF-8?Q?Krzysztof_Koz=C5=82owski?= <k.kozlowski@samsung.com>, Bjorn Andersson <bjorn.andersson@linaro.org>, Marcel Ziswiler <marcel.ziswiler@toradex.com>, Shawn Lin <shawn.lin@rock-chips.com>, Arnd Bergmann <arnd@arndb.de>, Hans de Goede <hdegoede@redhat.com>
List-Id: linux-mmc@vger.kernel.org

Hi Linus,

Here are some mmc fixes intended for v4.7 rc2. They are based on v4.7-rc1.

Details are as usual found in the signed tag. Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 1a695a905c18548062509178b98bc91e67510864:

  Linux 4.7-rc1 (2016-05-29 09:29:24 -0700)

are available in the git repository at:

  git://git.linaro.org/people/ulf.hansson/mmc.git tags/mmc-v4.7-rc1-2

for you to fetch changes up to afefc102df1bf5b75d7106771ecbe0ef546edc96:

  mmc: sunxi: Re-enable eMMC HS-DDR modes on Allwinner A80 (2016-06-02
10:40:20 +0200)

----------------------------------------------------------------
MMC core:
 - Fix/restore behaviour when selecting bus width for (e)MMC

MMC host:
 - sunxi: Fix eMMC HS-DDR modes on Allwinner A80

----------------------------------------------------------------
Chen-Yu Tsai (3):
      mmc: fix mmc mode selection for HS-DDR and higher
      mmc: sunxi: Fix DDR MMC timings for A80
      mmc: sunxi: Re-enable eMMC HS-DDR modes on Allwinner A80

 drivers/mmc/core/mmc.c       | 4 ++--
 drivers/mmc/host/sunxi-mmc.c | 9 ++-------
 2 files changed, 4 insertions(+), 9 deletions(-)
