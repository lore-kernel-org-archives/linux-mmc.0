From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v.4.12 rc6
Date: Fri, 16 Jun 2017 08:24:37 +0200
Message-ID: <CAPDyKFo5NJh91bx_sn171timAX4FpEXc4hvxUXRmV7M+W5qFvg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus <torvalds@linux-foundation.org>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

Hi Linus,

Here is one mmc fix intended for v4.12 rc6. It's based on v4.12-rc5.

Details are as usual found in the signed tag. Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 32c1431eea4881a6b17bd7c639315010aeefa452:

  Linux 4.12-rc5 (2017-06-11 16:48:20 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v4.12-rc5

for you to fetch changes up to 24835611a96e9b41ad57dd5024915106293be7e9:

  mmc: meson-gx: work around broken SDIO with certain WiFi chips
(2017-06-12 08:58:16 +0200)

----------------------------------------------------------------
MMC host:
 - meson-gx: work around broken SDIO with certain WiFi chips

----------------------------------------------------------------
Heiner Kallweit (1):
      mmc: meson-gx: work around broken SDIO with certain WiFi chips

 drivers/mmc/host/meson-gx-mmc.c | 9 +++++++++
 1 file changed, 9 insertions(+)
