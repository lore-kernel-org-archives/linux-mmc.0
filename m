From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v13 0/2] ARM: sunxi: Add driver for SD/MMC hosts
 found on sunxi SoCs
Date: Mon, 12 May 2014 14:04:46 +0200
Message-ID: <1399896288-5826-1-git-send-email-hdegoede@redhat.com>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sunxi+bncBDRZXY4CYYORB2PRYKNQKGQEETFHSMQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Chris Ball <chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, =?UTF-8?q?David=20Lanzend=C3=B6rfer?= <david.lanzendoerfer-Z7Kmv9EsliU@public.gmane.org>, Emilio Lopez <emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

Hi All,

Here is lucky number v13 of the sunxi-mmc patch-set David Lanzend=C3=B6rfer=
 and I
have been working on, with the __clk_get_hw call moved from sunxi-mmc.c
to clk-sunxi.c where it belongs.

Mike, the first patch in this series modifies clk_sunxi_mmc_phase_control t=
o
take a struct clk * as argument rather then a struct clk_hw *, and should
go upstream through the clk tree. Feel free to squash this into the patch
adding the clk_sunxi_mmc_phase_control function if you prefer.

The second patch in this series is the patch adding the actual mmc driver a=
nd
should go in through the mmc tree.

Changes since v1:
-Using mmc_of_parse instead of diy dt parsing
-Adding nodes for all mmc controller to the dtsi files,
 including sofar unused controllers
-Using generic GPIO slot library for WP/CD
-Adding additional MMC device nodes into DTSI files

Changes since v2:
-Add missing Signed-off-by tags
-Stop using __raw_readl / __raw_writel so that barriers are properly used
-Adding missing new lines
-Adding missing patch for automatic reparenting of clocks

Changes since v3:
-Move clk_enable / disable into host_init / exit (Hans)
-Fix hang on boot caused by irq storm (Hans)

Changes since v4:
-moving sunxi-mci.{c/h} to sunxi-mmc.{c/h}
-removing camel cases from the defines in  sunxi-mmc.h
-moving defines out of the struct definition
 since this is bad coding style
-adding documentation for the device tree binding
Changes since v5:
-adding host initialization for when the sdio irq is enabled
 (just to make sure having a defined state at all time)
-add mmc support fixup: set pullup on cd pins
-fixup: Don't set MMC_CAP_NEEDS_POLL /  MMC_CAP_4_BIT_DATA

Changes since v6:
-fixing copyright info in sunxi-mmc.*
-s/__SUNXI_MCI_H__/__SUNXI_MMC_H__/g
-s/SDXC_RESPONSE_/SDXC_RESP_/g
-s/define/definitions <- Comment from Priit Laes

Changes since v7:
-Merge sunxi-mmc.h into sunxi-mmc.c
-Various style fixes / cleanups based on Maxime's review
-sun6i support
-Fix a race condition in interrupt / tasklet interaction
-Split the dts patches into 3 per platform:
 1) Add mmc nodes to the dtsi
 2) Add mmc pinmux to the dtsi
 3) Add mmc nodes to the various board files
-Moved setting of bus-width and cd gpio polarity from .dtsi to the board-fi=
les
-Added sun6i dts patches

Changes since v8:
-Don't claim MMC_CAP_SDIO_IRQ by default, sdio-irq support appears to not
 always be reliable. Can be re-added to the caps on a per board basis
 through dts
-Added EXPORT_SYMBOL(clk_sunxi_mmc_phase_control)
-Moved bus-width and cd-inverted dts attributes for sun6i from dtsi to dts
-Squashed patches adding sun6i-a31-m9.dts and mmc support for m9 together
-Added a patch enabling the sdio wifi on the cubietruck in dts

Changes since v9:
-Drop the sun5i and sun6i dts pinmux patches as those have already been
 accepted
-Rename the mmc clock for the controller from "mod" to "mmc" so as
 to not confuse it with a regular mod0 clock
-Rename pinmux for the reference design card-detect pin from cd_pin_a to
 cd_pin_reference_design

Changes since v10:
-Dropped all dts and clk patches, as they are all accepted now
-Cleanup some somewhat weird names (leftovers from the android code):
 s/mci_readl/mmc_readl/
 s/mci_writel/mmc_write/
 s/smc_host/host/
-Switched to mmc_regulator_get_supply API and added fixed regulator nodes t=
o
 all board files (introducing new dts patches)
-Got rid of duplicate ios info
-Stop checking card-detect before each request
-Drop usleep after changing the clock rate
-Drop incomplete / wrong voltage switching support
-Drop the large comment with values copy/pasted from the spec
-Move enable/disable clk + reset + irq calls from power up / down to
 probe / remove
-Make sunxi_mmc_clk_set_rate / sunxi_mmc_oclk_onoff return an error
-Use a threaded interrupt handler for sending an explicit stop on data erro=
rs
-Fix sunxi_mmc_send_manual_stop to properly stop ongoing SD_IO_RW_EXTENDED =
cmds

Changes since v11:
-Instead of adding a reg_vmmc0 regulator add a fixed reg_vcc3v3 regulator, =
as
 we may need it in other places too
-Also add a vmmc-supply entry to thr non mmc0 nodes on the 2 boards which h=
ave
 multiple sdcard slots.

Changes since v12:
-Drop all dts patches, as they are all merged for going upstream
-Add a patch modifying clk_sunxi_mmc_phase_control to take a struct clk * a=
s
 argument rather then a struct clk_hw *
-Modify the patch adding the actual sunxi-mmc driver for the
 clk_sunxi_mmc_phase_control API change

Regards,

Hans

--=20
You received this message because you are subscribed to the Google Groups "=
linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.
