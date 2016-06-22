From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH 0/5] mmc: bcm2835-sdhost: Add new driver for the internal SD
 controller.
Date: Wed, 22 Jun 2016 13:42:13 +0200
Message-ID: <1466595738-2229-1-git-send-email-kraxel@redhat.com>
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
Cc: Eric Anholt <eric@anholt.net>, linux-mmc@vger.kernel.org, Gerd Hoffmann <kraxel@redhat.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

  Hi,

Here is the bcm2835-sdhost driver.  Patches 1+2 are unmodified from
Eric, patches 3+4 are incremental fixes.  Left them separate for now,
to make it easier to review, should probably squashed in for the final
version.  Patch 5 adds it to the device tree, in disabled state.

Actually enabling the thing depends on a bunch of changes in the gpio
handling of the device tree.  Leaving that for another day ...

cheers,
  Gerd

Eric Anholt (2):
  dt-bindings: Add binding for brcm,bcm2835-sdhost.
  mmc: bcm2835-sdhost: Add new driver for the internal SD controller.

Gerd Hoffmann (3):
  mmc: bcm2835-sdhost: zap mmiowb() [fixup]
  mmc: bcm2835-sdhost: reset tweaks. [fixup]
  mmc: bcm2835-sdhost: add to devicetree

 .../devicetree/bindings/mmc/brcm,bcm2835-sdhci.txt |    3 +
 .../bindings/mmc/brcm,bcm2835-sdhost.txt           |   24 +
 arch/arm/boot/dts/bcm283x.dtsi                     |    8 +
 drivers/mmc/host/Kconfig                           |    9 +
 drivers/mmc/host/Makefile                          |    1 +
 drivers/mmc/host/bcm2835-sdhost.c                  | 1652 ++++++++++++++++++++
 6 files changed, 1697 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mmc/brcm,bcm2835-sdhost.txt
 create mode 100644 drivers/mmc/host/bcm2835-sdhost.c

-- 
1.8.3.1
