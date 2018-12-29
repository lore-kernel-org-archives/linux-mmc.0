From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 0/3] ARM: dts: meson: fix SD card cd-gpio (pre v4.21-rc)
Date: Sat, 29 Dec 2018 13:57:08 +0100
Message-ID: <20181229125711.5205-1-martin.blumenstingl@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-amlogic@lists.infradead.org, khilman@baylibre.com, linus.walleij@linaro.org
Cc: linus.luessing@c0d3.blue, bgolaszewski@baylibre.com, balbes-150@yandex.ru, linux-mmc@vger.kernel.org, linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Martin Blumenstingl <martin.blumenstingl@googlemail.com>, linux@roeck-us.net
List-Id: linux-mmc@vger.kernel.org

Today I noticed that my Odroid-C1 doesn't see it's SD card anymore.
My board is not the only one, Odroid-C1 on KernelCI suffers from the
same problem:
v4.20-6428-g00c569b567c7 still sees the SD card (mmc0): [0]
v4.20-8955-g903b77c63167 doesn't see the SD card (mmc0) anymore: [1]

My Endless Mini (EC-100) is also affected by this issue.

a git bisect run points to this commit:
89a5e15bcba87df5120d4656e0ff33d4f7cd6152 ("gpio/mmc/of: Respect polarity
in the device tree")

and indeed, reverting it makes my Odroid-C1 and EC-100 see the SD card
again.

However, while reviewing the .dts files for the 32-bit Amlogic Meson
boards I found that the cd-gpios are specified incorrectly in the .dts.
Documentation/devicetree/bindings/mmc/mmc.txt states: "[...] using the
"cd-inverted" property means, that the CD line is active high, i.e. it
is high, when a card is inserted".
This is not the case on all currently supported 32-bit Meson boards, so
this switches the cd-gpios
- from GPIO_ACTIVE_HIGH with the "cd-inverted" property being set
- to GPIO_ACTIVE_LOW with the "cd-inverted" property being absent

This fix also works even if the following two commits are reverted:
- 89a5e15bcba87d ("gpio/mmc/of: Respect polarity in the device tree")
- 81c85ec15a1946 ("gpio: OF: Parse MMC-specific CD and WP properties")

Linus, I have seen that there was some fallout that commit
89a5e15bcba87d ("gpio/mmc/of: Respect polarity in the device tree") is
supposed to fix. In commit 81c85ec15a1946 ("gpio: OF: Parse
MMC-specific CD and WP properties") you mentioned "the [MMC]  core will
use the MMC_CAP2_CD_ACTIVE_HIGH [...] I plan to clean this up at a later
point passing the handling of inversion semantics over to gpiolib". I'm
not sure how the MMC core / GPIO subsystem is supposed to handle the
"cd-inverted" case since I believe this property is now evaluated twice:
- first in of_gpio_flags_quirks
- but also in mmc_gpio_get_cd (using ctx->override_cd_active_level)
doesn't this essentially make "cd-inverted" a no-op?
(attention: this series only fixes three 32-bit Meson boards, but I
believe that this issue is not limited to the 32-bit Meson boards)


[0] https://kernelci.org/boot/id/5c25a73d59b51464fb6edd2c/
[1] https://kernelci.org/boot/id/5c27306159b514268f6edd2e/


Martin Blumenstingl (3):
  ARM: dts: meson8b: odroidc1: mark the SD card detection GPIO
    active-low
  ARM: dts: meson8b: ec100: mark the SD card detection GPIO active-low
  ARM: dts: meson8m2: mxiii-plus: mark the SD card detection GPIO
    active-low

 arch/arm/boot/dts/meson8b-ec100.dts       | 3 +--
 arch/arm/boot/dts/meson8b-odroidc1.dts    | 3 +--
 arch/arm/boot/dts/meson8m2-mxiii-plus.dts | 3 +--
 3 files changed, 3 insertions(+), 6 deletions(-)

-- 
2.20.1
