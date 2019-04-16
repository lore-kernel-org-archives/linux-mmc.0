From: NeilBrown <neil@brown.name>
Subject: [PATCH 0/5] mtk-sd enhancement to support MT7621
Date: Tue, 16 Apr 2019 14:47:29 +1000
Message-ID: <155538933003.25108.3338569916935462285.stgit@noble.brown>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Chaotian Jing <chaotian.jing@mediatek.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, thirtythreeforty@gmail.com
List-Id: linux-mmc@vger.kernel.org

The MT7621 MIPS-based SOC contains an sdhci unit that is
much the same as the units supported by mtk-sd.c.

These patches enhance the driver so that I can use it on my MT7621
board (gnubee.org).

Some thoughts:
- I wonder if voltage-ranges should be a standard option, processed
    by mmc_of_parse(), rather than requiring mmc_of_parse_voltage()
    to be called as well?

- the "compatible" name "ralink,mt7620-sdhci" doesn't fit the pattern
  of other names.  It is a name I found in openwrt - I was previously
  using a driver from there.  I have no objection to changing it,
  but I have no way to determine what the "correct" name it.

- I have tested the card-detect logic but not the write-protect, as
  that doesn't seem to be wired on this board.

- My SOC doesn't have software-controlled clocks (that I can find).
  To get the clocks that the driver requires, I define a "fixed-clock"
  with the appropriate frequency and use that for both  "source" and
  "hclk".  Many these clocks should be optional - at least hclk ??

- I don't need to reconfigure the pins for "uhs" so I just use the
  same pinctrl setting for "default" and for "state_uhs".  Maybe
  "state_uhs" should be optional?


For reference, excerpts from my dts file are below.

Thanks,
NeilBrown


       mmc_clock: mmc_clock@0 {
               #clock-cells = <0>;
               compatible = "fixed-clock";
               clock-frequency = <48000000>;
       };

and

       sdhci: sdhci@1E130000 {
               status = "disabled";

               compatible = "ralink,mt7620-sdhci";
               reg = <0x1E130000 0x4000>;

               bus-width = <4>;
               max-frequency = <48000000>;
               cap-sd-highspeed;
               cap-mmc-highspeed;
               voltage-ranges = <2800 3300>;

               pinctrl-names = "default", "state_uhs";
               pinctrl-0 = <&sdhci_pins>;
               pinctrl-1 = <&sdhci_pins>;
               clocks = <&mmc_clock &mmc_clock>;
               clock-names = "source", "hclk";

               interrupt-parent = <&gic>;
               interrupts = <GIC_SHARED 20 IRQ_TYPE_LEVEL_HIGH>;
       };

---

NeilBrown (5):
      mmc: mtk-sd: support "voltage-ranges" setting.
      mmc: mtk-sd: don't hard-code interrupt trigger type
      mmc: mtk-sd: add support for config found in mt7620 family SOCs.
      mmc: mtk-sd: enable internal card-detect logic.
      mmc: mtk-sd: enable internal write-protect logic.


 Documentation/devicetree/bindings/mmc/mtk-sd.txt |    7 +
 drivers/mmc/host/mtk-sd.c                        |  105 +++++++++++++++++++++-
 2 files changed, 104 insertions(+), 8 deletions(-)

--
Signature
