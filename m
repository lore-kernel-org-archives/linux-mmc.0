Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02B81C4338F
	for <linux-mmc@archiver.kernel.org>; Sat,  7 Aug 2021 11:07:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D908860C51
	for <linux-mmc@archiver.kernel.org>; Sat,  7 Aug 2021 11:07:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232025AbhHGLHq (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sat, 7 Aug 2021 07:07:46 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:54169 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232027AbhHGLHp (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 7 Aug 2021 07:07:45 -0400
Received: from localhost.localdomain ([37.4.249.97]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MJVU0-1mRe5r2OGO-00JoSb; Sat, 07 Aug 2021 13:07:07 +0200
From:   Stefan Wahren <stefan.wahren@i2se.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Maxime Ripard <maxime@cerno.tech>, iivanov@suse.de,
        devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH V2 00/10] ARM: dts: Add Raspberry Pi CM4 & CM4 IO Board support
Date:   Sat,  7 Aug 2021 13:06:31 +0200
Message-Id: <1628334401-6577-1-git-send-email-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.7.4
X-Provags-ID: V03:K1:cn0kz0To6yBNIprAf5qZusQ6Ko69d5rZyv3uumJ+FvDuEd9WD+C
 2rrQzZ/Z7nXwa7vZ5DjCMSEx9XAU5LbAau0BJ4AlfcUnDCoY4OWkWYP8gcjiKOYeGww4WVZ
 kxBX2lm72Nhb9GrdkObq3Rn9nMuhaDGAffSiWbjIhC8Gl0oa33VORx750mlvKBRMLCOIfxO
 mT+ARUotK7J4Ww2bROzYQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Z5QpbPh6wXs=:tbZJnP3dOyqtlngG2yRZaP
 INdElJKdOV8AVQDmQnGQZ9D4NgeYt5gd8WgMbQfQwgN2YQGa3QmFSYuA6LF3XKYTDRGbS36YK
 hCCejdnFaUnWerWqpEmsbaM0ug+lwQx6hAQ2dP/+Zvo986jj291S/MzYGcHkiPNVYdNqOUpQX
 +yMNG4ymAp3rpabvj70P0y6jXKmXMHPF09EBXJQiN9DRpTMd4mXwpxruaw2xGQ3eMshSknYny
 E0ERcLPREQHusQ0x+aaGK24Wfamr6jSucwajL+IMEYjTOiZVvmlM9fL3bBzt051KSxN6bt2wP
 XTCF9YcGfPeHfHbXRKnDVVb/jm8J+3t/ON6qxbARnTqnPIZC9aHyYjHf5L6q6Jl6UW53Gwd82
 KxBnTNojQkAAn6LhD9nn+zIGF5CmUlOB9bQhGkQTtWWArQAGnVDiDnMVWgiddviQwoRscF8ox
 Q4arL4JOkKzZO2B3dNDyafdz+aWoR1xmQuFMBNmuQTUZVOm3/VWe8TnL5PBsPPjbsGeF0uq9F
 aXixnkMl8+QlGefzPOLrxTraJE3YTBEdvk39kj0feaHsu91QuxkymOyG6EssDx2jaJwymWOWw
 hlXWzymNlKn6GtFFl3z64i4Plb84P+7MVEKFTCNzdeZCf9d53docsjqdQPsanyj4h00LstJhj
 xG0A8FMcPgZHMtGrvKcQ4KwIANRMZOenL5VuOU/OiqKH2HBS+EfHgbQ4N+RM+c9monNb6Zoib
 86jR3HSSsiRV6YpSMv7CD8ITciXv+U+KkWzxE+VIMi1bol+1kJIom+COxV+w9LomIYSMkFaQW
 ql2xzSA09nh2u/nmAC64BnUQfkRb+ZH4jJgeyQxVhSinq/2i6LwBqzmjR+nXRSTHCeRyl09wV
 ibaBP/xaEnFH1Jnz8XAQ==
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

This series add support for the Raspberry Pi Compute Module 4 and its
IO board.

Changes in V2:
- drop emmc2bus patch as it affects userspace (thanks to Marc Zyngier)
- tested with CM4 and integrate sdhci patches from Nicolas (just include kHz fixups)
- add Rob's Acked-by
- add HS200 property to emmc2 node for a slight performance gain
- move antenna comment to the proper position

Nicolas Saenz Julienne (2):
  mmc: sdhci-iproc: Cap min clock frequency on BCM2711
  mmc: sdhci-iproc: Set SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN on BCM2711

Stefan Wahren (8):
  ARM: dts: bcm2711: fix MDIO #address- and #size-cells
  ARM: dts: bcm2711-rpi-4-b: fix sd_io_1v8_reg regulator states
  dt-bindings: display: bcm2835: add optional property power-domains
  ARM: dts: bcm283x-rpi: Move Wifi/BT into separate dtsi
  dt-bindings: arm: bcm2835: Add Raspberry Pi Compute Module 4
  ARM: dts: Add Raspberry Pi Compute Module 4
  ARM: dts: Add Raspberry Pi Compute Module 4 IO Board
  arm64: dts: broadcom: Add reference to RPi CM4 IO Board

 .../devicetree/bindings/arm/bcm/bcm2835.yaml       |   1 +
 .../bindings/display/brcm,bcm2835-dsi0.yaml        |   3 +
 .../bindings/display/brcm,bcm2835-hdmi.yaml        |   3 +
 .../bindings/display/brcm,bcm2835-v3d.yaml         |   3 +
 .../bindings/display/brcm,bcm2835-vec.yaml         |   3 +
 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/bcm2711-rpi-4-b.dts              |  42 ++-----
 arch/arm/boot/dts/bcm2711-rpi-cm4-io.dts           | 138 +++++++++++++++++++++
 arch/arm/boot/dts/bcm2711-rpi-cm4.dtsi             | 113 +++++++++++++++++
 arch/arm/boot/dts/bcm2711.dtsi                     |   4 +-
 arch/arm/boot/dts/bcm2835-rpi-zero-w.dts           |  31 ++---
 arch/arm/boot/dts/bcm2837-rpi-3-a-plus.dts         |  36 ++----
 arch/arm/boot/dts/bcm2837-rpi-3-b-plus.dts         |  36 ++----
 arch/arm/boot/dts/bcm2837-rpi-3-b.dts              |  36 ++----
 arch/arm/boot/dts/bcm283x-rpi-wifi-bt.dtsi         |  34 +++++
 arch/arm64/boot/dts/broadcom/Makefile              |   1 +
 .../arm64/boot/dts/broadcom/bcm2711-rpi-cm4-io.dts |   2 +
 drivers/mmc/host/sdhci-iproc.c                     |  21 +++-
 18 files changed, 366 insertions(+), 142 deletions(-)
 create mode 100644 arch/arm/boot/dts/bcm2711-rpi-cm4-io.dts
 create mode 100644 arch/arm/boot/dts/bcm2711-rpi-cm4.dtsi
 create mode 100644 arch/arm/boot/dts/bcm283x-rpi-wifi-bt.dtsi
 create mode 100644 arch/arm64/boot/dts/broadcom/bcm2711-rpi-cm4-io.dts

-- 
2.7.4

