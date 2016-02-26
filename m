From: Eric Anholt <eric@anholt.net>
Subject: [PATCH 0/4] bcm2835 SDHOST controller
Date: Fri, 26 Feb 2016 15:05:38 -0800
Message-ID: <1456527942-3045-1-git-send-email-eric@anholt.net>
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
To: linux-rpi-kernel@lists.infradead.org
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Ian Campbell <ijc+devicetree@hellion.org.uk>, Florian Fainelli <f.fainelli@gmail.com>, Pawel Moll <pawel.moll@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Lee Jones <lee@kernel.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Eric Anholt <eric@anholt.net>, Rob Herring <robh+dt@kernel.org>, Kumar Gala <galak@codeaurora.org>, Ulf Hansson <ulf.hansson@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

Here's a series to enable the SDHOST controller.  It gives us better
performance than our old sdhci-bcm2835.c.  The downstream Raspberry Pi
kernel appears to be using this controller by default at this point.

I've tried to do some testing on it (mounting filesystem,
reading/writing files, speed tests), but I'm not sure what a good
testing regimen for storage drivers would be.

Eric Anholt (4):
  dt-bindings: Add binding for brcm,bcm2835-sdhost.
  mmc: bcm2835-sdhost: Add new driver for the internal SD controller.
  ARM: bcm2835: Include SDHOST in the device tree.
  ARM: bcm2835: Enable SDHOST by default.

 .../bindings/mmc/brcm,bcm2835-sdhost.txt           |   25 +
 arch/arm/boot/dts/bcm2835-rpi.dtsi                 |   10 +-
 arch/arm/boot/dts/bcm283x.dtsi                     |    8 +
 drivers/mmc/host/Kconfig                           |    9 +
 drivers/mmc/host/Makefile                          |    1 +
 drivers/mmc/host/bcm2835-sdhost.c                  | 1652 ++++++++++++++++++++
 6 files changed, 1704 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/brcm,bcm2835-sdhost.txt
 create mode 100644 drivers/mmc/host/bcm2835-sdhost.c

-- 
2.7.0
