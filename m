From: ludovic.desroches@atmel.com
Subject: [PATCH 0/4] atmel-mci device tree support
Date: Wed, 21 Mar 2012 19:03:10 +0100
Message-ID: <1332352994-20983-1-git-send-email-ludovic.desroches@atmel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from newsmtp5.atmel.com ([204.2.163.5]:10669 "EHLO
	sjogate2.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754428Ab2CUQEM (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 21 Mar 2012 12:04:12 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: nicolas.ferre@atmel.com, ludovic.desroches@atmel.com, plagnioj@jcrosoft.com

Hi,

This patch-set adds device tree support for atmel-mci.

Regards

Ludovic

 .../devicetree/bindings/mmc/atmel-hsmci.txt        |   55 +++++++++++++++
 arch/arm/boot/dts/at91sam9g25ek.dts                |   16 ++++
 arch/arm/boot/dts/at91sam9x5.dtsi                  |   14 ++++
 arch/arm/mach-at91/at91sam9x5.c                    |    2 +
 drivers/mmc/host/atmel-mci.c                       |   74 +++++++++++++++++++-
 5 files changed, 158 insertions(+), 3 deletions(-)
 

