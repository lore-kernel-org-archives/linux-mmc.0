From: ludovic.desroches@atmel.com
Subject: [PATCH v2 0/3] atmel-mci device tree support
Date: Wed, 28 Mar 2012 12:05:47 +0200
Message-ID: <1332929150-14240-1-git-send-email-ludovic.desroches@atmel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from newsmtp5.atmel.com ([204.2.163.5]:41107 "EHLO
	sjogate2.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751364Ab2C1IIQ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 28 Mar 2012 04:08:16 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: nicolas.ferre@atmel.com, ludovic.desroches@atmel.com, plagnioj@jcrosoft.com, devicetree-discuss@lists.ozlabs.org

Hi,

This patch-set adds device tree support for atmel-mci.

Regards

Ludovic

v2:
- squash patch v1 2/4 and 3/4.
- change atmci_get_of_slots to atmci_of_init and manage pdata allocation into
it.
- correct potential issue (e.g. having only one slot which is not slot0 into
the dt) about slots by adding a reg property corresponding to the slot id.


.../devicetree/bindings/mmc/atmel-hsmci.txt        |   67 ++++++++++++++++
arch/arm/boot/dts/at91sam9g25ek.dts                |   16 ++++
arch/arm/boot/dts/at91sam9x5.dtsi                  |   24 ++++++
arch/arm/mach-at91/at91sam9x5.c                    |    2 +
drivers/mmc/host/atmel-mci.c                       |   80 ++++++++++++++++++++

