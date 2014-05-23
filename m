From: srinivas.kandagatla@linaro.org
Subject: [PATCH v3 00/13] Add Qualcomm SD Card Controller support
Date: Fri, 23 May 2014 13:49:22 +0100
Message-ID: <1400849362-7007-1-git-send-email-srinivas.kandagatla@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:47198 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751074AbaEWMuC (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 23 May 2014 08:50:02 -0400
Received: by mail-wi0-f177.google.com with SMTP id f8so802569wiw.10
        for <linux-mmc@vger.kernel.org>; Fri, 23 May 2014 05:50:01 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King <linux@arm.linux.org.uk>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Cc: Chris Ball <chris@printf.net>, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linus.walleij@linaro.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

Thankyou Linus W and everyone for reviewing RFC to v3 patches.

This patch series adds Qualcomm SD Card Controller support in pl180 mmci
driver. QCom SDCC is basically a pl180, but bit more customized, some of the
register layouts and offsets are different to the ones mentioned in pl180
datasheet. The plan is to totally remove the standalone SDCC driver
drivers/mmc/host/msm_sdcc.* and start using generic mmci driver for all
Qualcomm parts, as we get chance to test on other Qcom boards.

To start using the existing mmci driver, a fake amba id for Qualcomm is added
in patches:
 mmc: mmci: Add Qualcomm Id to amba id table.

Second change is, adding a 3 clock cycle delay for register writes on QCOM SDCC
registers, which is done in patches:
  mmc: mmci: Add register read/write wrappers.
  mmc: mmci: Qcomm: Add 3 clock cycle delay after register write

Third change is to accommodate CLK, DATCTRL and MMCICLK register layout changes
in Qcom SDCC and provide more flexibity in driver to specify these changes via
variant datastructure. Which are done in patches:
  mmc: mmci: Add Qcom datactrl register variant
  mmc: mmci: add ddrmode mask to variant data
  mmc: mmci: add 8bit bus support in variant data
  mmc: mmci: add edge support to data and command out in variant data.
  mmc: mmci: add Qcom specifics of clk and datactrl registers.
  mmc: mmci: Add support to data commands via variant structure.
  mmc: mmci: add explicit clk control

Fourth major change was to add qcom specfic pio read function, the need for
this is because the way MCIFIFOCNT register behaved in QCOM SDCC is very
 different to the one in pl180. This change is done in patch:
  mmc: mmci: Add Qcom specific pio_read function.

Last some Qcom unrelated changes/cleanup to driver are done in patches:
  mmc: mmci: use NSEC_PER_SEC macro
  mmc: mmci: convert register bits to use BIT() macro.

This patches are tested in PIO mode on IFC8064 board with both eMMC and
external SD card. I would like to get this support in v3.16.

Changes from v2:
	- merged fbclk latch patch with clkreg_enable patch as suggested by Linus W.
	- remove qcom prefix for explicit clk control pointed by Linus W.
	- cleaned up mmci_qcom_pio_read and consider SDIO as suggested by Linus W.

Changes from v1:
	- moved most of the SOC specifics to variant parameters as suggested
	  by Linus W.
	- renamed registers as suggested by Linus W.
	- Added comments in the code as suggested by Linus W.
	- moved out AMBA ID addition patch from this series.
	- rebased the patches to 
		git://git.linaro.org/people/ulf.hansson/mmc.git next 
	  as suggested by Ulf H.

Changes from RFC:
	- moved out clk setup out of spinlock as pointed by Stephen B.

Am hoping to get this for v3.16.

All these patches are tested on IF6410 board on both eMMC and external SD card.

Thanks,
srini

Srinivas Kandagatla (13):
  mmc: mmci: use NSEC_PER_SEC macro
  mmc: mmci: convert register bits to use BIT() macro.
  mmc: mmci: Add Qualcomm Id to amba id table
  mmc: mmci: Add Qcom datactrl register variant
  mmc: mmci: Add register read/write wrappers.
  mmc: mmci: Qcomm: Add 3 clock cycle delay after register write
  mmc: mmci: add ddrmode mask to variant data
  mmc: mmci: add 8bit bus support in variant data
  mmc: mmci: add edge support to data and command out in variant data.
  mmc: mmci: add Qcom specifics of clk and datactrl registers.
  mmc: mmci: Add support to data commands via variant structure.
  mmc: mmci: add explicit clk control
  mmc: mmci: Add Qcom specific pio_read function.

 drivers/mmc/host/mmci.c | 252 ++++++++++++++++++++++++++++++++++++------------
 drivers/mmc/host/mmci.h | 232 ++++++++++++++++++++++++--------------------
 2 files changed, 318 insertions(+), 166 deletions(-)

-- 
1.9.1

