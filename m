From: <ludovic.desroches@atmel.com>
Subject: [PATCH RESEND v5 0/4] atmel-mci device tree support
Date: Tue, 24 Jul 2012 15:30:02 +0200
Message-ID: <1343136606-8874-1-git-send-email-ludovic.desroches@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eusmtp01.atmel.com ([212.144.249.242]:65147 "EHLO
	eusmtp01.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750897Ab2GXNbL (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 24 Jul 2012 09:31:11 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: cjb@laptop.org, nicolas.ferre@atmel.com, plagnioj@jcrosoft.com

From: Ludovic Desroches <ludovic.desroches@atmel.com>

Hello,

I resend this set of patches because patches 2, 3 and 4 were acked by
Jean-Christophe. Patch 1 was also acked by Jean-Christophe excepted for
cd-inverted property since it was redundant with gpio bindings.

I thought we were agree to go ahead since it was a common binding already
documented and it will concern all drivers.

Chris are you agree to take patch 1/4? Others patches may go to at91 tree,
isn't it?
By the way, I have updated documentation in patch 1/4 in the same way as you
did with the patch 'mmc: dt: Deduplicate binding docs by referencing mmc.txt'.
I didn't remove common properties from slot part because I think it is not
obvious to use these properties into the slot node.

Regards

Ludovic


v5:
- cleanup
- split dts commit: one for SOCs, one for boards

v4:
- cleanup
- add extra chips and boards for atmel-mci dt support

v3:
- use cd-inverted instead of cd-invert to follow mmc common binding.
- don't assign a pointer to pdev->dev.platform.
- add mci controller nodes to other chips and boards.
- put all dts file changes together.

v2:
- squash patch v1 2/4 and 3/4.
- change atmci_get_of_slots to atmci_of_init and manage pdata allocation into
it.
- correct potential issue (e.g. having only one slot which is not slot0 into
the dt) about slots by adding a reg property corresponding to the slot id.

Ludovic Desroches (4):
  mmc: atmel-mci: add device tree support
  ARM: at91: add clocks for DT entries
  ARM: dts: add nodes for atmel hsmci controllers for atmel SOCs
  ARM: dts: add nodes for atmel hsmci controllers for atmel boards

 .../devicetree/bindings/mmc/atmel-hsmci.txt        |   68 ++++++++++++++++
 arch/arm/boot/dts/at91sam9260.dtsi                 |    9 ++
 arch/arm/boot/dts/at91sam9263.dtsi                 |   18 ++++
 arch/arm/boot/dts/at91sam9263ek.dts                |   10 +++
 arch/arm/boot/dts/at91sam9g20ek_2mmc.dts           |   12 +++
 arch/arm/boot/dts/at91sam9g20ek_common.dtsi        |    9 ++
 arch/arm/boot/dts/at91sam9g25ek.dts                |   18 ++++
 arch/arm/boot/dts/at91sam9g45.dtsi                 |   18 ++++
 arch/arm/boot/dts/at91sam9m10g45ek.dts             |   19 +++++
 arch/arm/boot/dts/at91sam9n12.dtsi                 |    9 ++
 arch/arm/boot/dts/at91sam9n12ek.dts                |    9 ++
 arch/arm/boot/dts/at91sam9x5.dtsi                  |   18 ++++
 arch/arm/mach-at91/at91sam9260.c                   |    1 +
 arch/arm/mach-at91/at91sam9263.c                   |    2 +
 arch/arm/mach-at91/at91sam9g45.c                   |    2 +
 arch/arm/mach-at91/at91sam9n12.c                   |    1 +
 arch/arm/mach-at91/at91sam9x5.c                    |    2 +
 drivers/mmc/host/atmel-mci.c                       |   85 +++++++++++++++++++-
 18 files changed, 308 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/atmel-hsmci.txt

-- 
1.7.5.4

