From: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
Subject: [PATCH-v2 0/7] mmc: sdhci-pxav3: Enable support for PXA1928 SDCHI controller
Date: Mon,  7 Sep 2015 16:48:34 +0530
Message-ID: <1441624721-15612-1-git-send-email-vaibhav.hiremath@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:34452 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750946AbbIGLVB (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 7 Sep 2015 07:21:01 -0400
Received: by padhy16 with SMTP id hy16so92703746pad.1
        for <linux-mmc@vger.kernel.org>; Mon, 07 Sep 2015 04:21:01 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, robh+dt@kernel.org, ulf.hansson@linaro.org, Vaibhav Hiremath <vaibhav.hiremath@linaro.org>

PXA1928 SDHCI controller has few differences, for example,

                         PXAxxx                    PXA1928
                         =3D=3D=3D=3D=3D=3D                    =3D=3D=3D=
=3D=3D=3D=3D
 SDCLK_DELAY field       0x10A                     0x114
 SDCLK_DELAY mask        0x1F                      0x3FF
 SDCLK_DELAY shift        9                          8
 SDCLK_SEL shift          8                          2 (SEL1)

So this patch series introduces new compatible device_id
(marvell,pxav3-1928-sdhci), and makes use of .data for handling
such differences.

The series also adds support like,

 - independent ->set_clock() api, as we need to enable internal clock g=
ate
   and TX clock
 - pinctrl configuration based on bus speed.
 - introduce new quirk SDHCI_QUIRK2_MUST_SET_SDHCI_BUS_POWER
   SD_BUS_POWER & SD_BUS_VLT bit-fields are used internally to gate the
   clocks, so it is important to configure them as part of ->set_power(=
)
   More detailed description is written into commit log.
 - Enable SDHCI_QUIRK_BROKEN_TIMEOUT_VAL for PXA1928 device_id
 - Enable SDHCI_QUIRK2_CARD_ON_NEEDS_BUS_ON quirk for pxa1928 device


V1 =3D> V2:
=3D=3D=3D=3D=3D=3D=3D=3D=3D
 - Fixed typo issue (residual change remained by mistake)
 - Added new patch updating DT binding document for pxa1928 support
 - Added new patch enabling CARD_ON_NEEDS_BUS_ON for pxa1928 device

Testing:
I have done basic testing on both eMMC and SD card on PXA1928 based
platform.

Note: I tried to made sure that I do not break any other platform, whic=
h
used sdhci, except HS200 configuration.=C2=B7
Unfortunately I do not have access to any other datasheets, where I can
cross check the details on HS200 bit-fields. Probably someone who has
access can confirm [PATCH 4/5], whether it impacts other platforms.

Kevin Liu (1):
  mmc: sdhci-pxav3: Fix HS200 mode support

Vaibhav Hiremath (6):
  mmc: sdhci-pxav3: Enable pxa1928 device support
  mmc: sdhci-pxav3: binding: Add pxa1928 compatible support
  mmc: sdhci-pxav3: Add platform specific set_clock ops
  mmc: sdhci-pxav3: Add pinctl setting according to bus clock
  mmc: sdhci: add new quirk for setting BUS_POWER & BUS_VLT fields
  mmc: sdhci: enable SDHCI_QUIRK2_CARD_ON_NEEDS_BUS_ON for pxa1928

 .../devicetree/bindings/mmc/sdhci-pxa.txt          |   2 +-
 drivers/mmc/host/sdhci-pltfm.c                     |   4 +
 drivers/mmc/host/sdhci-pxav3.c                     | 168 +++++++++++++=
++++++--
 drivers/mmc/host/sdhci.c                           |   3 +-
 drivers/mmc/host/sdhci.h                           |   2 +
 5 files changed, 165 insertions(+), 14 deletions(-)

--=20
1.9.1

