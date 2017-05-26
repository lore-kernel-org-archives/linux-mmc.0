From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v.4.12 rc3 - take 2/2
Date: Fri, 26 May 2017 15:08:41 +0200
Message-ID: <CAPDyKFofp6qdgcqha6uNWJz4ApEc2y5dEkEo51LQyq-U3onpgQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qk0-f169.google.com ([209.85.220.169]:36841 "EHLO
        mail-qk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1764382AbdEZNIn (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 26 May 2017 09:08:43 -0400
Received: by mail-qk0-f169.google.com with SMTP id u75so6680994qka.3
        for <linux-mmc@vger.kernel.org>; Fri, 26 May 2017 06:08:42 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus <torvalds@linux-foundation.org>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "arm@kernel.org" <arm@kernel.org>, Arnd Bergmann <arnd@arndb.de>

Hi Linus,

Here are a couple of mmc and arm64-dts fixes intended for v4.12 rc3.
They are based on v4.12-rc2.

Details are as usual found in the signed tag. Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 08332893e37af6ae779367e78e444f8f9571511d:

  Linux 4.12-rc2 (2017-05-21 19:30:23 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v4.12-rc2

for you to fetch changes up to ea452678734eb782126f999bf5c4fb3e71d3b196:

  arm64: dts: hikey: Fix WiFi support (2017-05-23 14:18:10 +0200)

----------------------------------------------------------------
This pull request contains fixes to make the WiFi work again for the ARM64
Hikey board.  Together with a couple of DTS updates for the Hikey board we have
also extended the mmc pwrseq_simple, to support a new power-off-delay-us DT
property, as that was required to enable a graceful power off sequence for the
WiFi chip.

----------------------------------------------------------------
Daniel Lezcano (2):
      mfd: dts: hi655x: Add clock binding for the pmic
      arm64: dts: hikey: Add clock for the pmic mfd

Ulf Hansson (6):
      mmc: dt: pwrseq-simple: Invent power-off-delay-us
      mmc: pwrseq_simple: Parse DTS for the power-off-delay-us property
      arm64: dts: hi6220: Move the fixed_5v_hub regulator to the hikey dts
      arm64: dts: hikey: Add the SYS_5V and the VDD_3V3 regulators
      arm64: dts: hi6220: Move board data from the dwmmc nodes to hikey dts
      arm64: dts: hikey: Fix WiFi support

 .../devicetree/bindings/mfd/hisilicon,hi655x.txt   |  6 ++
 .../devicetree/bindings/mmc/mmc-pwrseq-simple.txt  |  2 +
 arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts     | 78 +++++++++++++++++-----
 arch/arm64/boot/dts/hisilicon/hi6220.dtsi          | 31 +--------
 drivers/mmc/core/pwrseq_simple.c                   |  7 ++
 5 files changed, 79 insertions(+), 45 deletions(-)
