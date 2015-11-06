From: Ludovic Desroches <ludovic.desroches@atmel.com>
Subject: [PATCH 0/2] mmc: sdhci: potentially bad behavior when using vmmc supply
Date: Fri, 6 Nov 2015 16:59:28 +0100
Message-ID: <1446825570-30029-1-git-send-email-ludovic.desroches@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eusmtp01.atmel.com ([212.144.249.243]:18088 "EHLO
	eusmtp01.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752343AbbKFP7g (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 6 Nov 2015 10:59:36 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org, nicolas.ferre@atmel.com, alexandre.belloni@free-electrons.com
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, plagnioj@jcrosoft.com, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, pierre.samat@atmel.com, Ludovic Desroches <ludovic.desroches@atmel.com>

Hi,

I would like to have some feedback for these two patches. I have two questions.

1.

To suppress the warnings telling me I have no vmmc and vqmmc supplies, I have
added them and discovered that adding a vmmc supply involve only writing 1 in
the Power Control Register involves enabling the SD Bus Power with a non valid
value for the SD Bus Voltage. If the host controllers strictly follows the
specification, it shall not enable SD Bus Power. So enough if it seems useless
to configure SD Bus Voltage because we have an external regulator, do it.

By the way, I am curious to understand what is really the SD Bus Voltage. I
mean talking about bus voltage makes me thinking more about vqmmc than vmmc.
Is it only bad naming or do I miss something?

>From the specification, there is this figure:

                    HOST
---------------------------------------------------
| ------------        3.3V                        |       VDD
| | Power SW |------------------------------------|----------
| ------------   |              |                 |
|       ---------|              |                 |
|       |                       |                 |
| --------------     ----------------------       |
| | Ref. Volt. |-----| Regulator/Selector |       |
| --------------     ----------------------       |
|                    3.3V/1.8V  |                 |
|                               |                 |
|                               |---------------  |
|                               |       |  |   |  |
|                               |       R  R   _  |
|                               |       |  |   _  |
|                               |       |  |   |  |
|                               |       |  |  /// |
|                            -------    |  |      |       CLK
|                            |     |----)--)------|----------
|  -----------------------   |Multi|    |  |      |       CMD
|  |Random Logic Circuits|---|Drive|----)---------|----------
|  -----------------------   |I/O  |    |         |       DAT
|                            |     |--------------|----------
|                            -------              |
---------------------------------------------------

In my mind vmmc is the 3.3V signal and vqmmc is the 3.3V/1.8V signal, so why
talking about bus voltage?


2.

Is the regulator-gpio usage the right thing to do for vqmmc? In my case it is
not really driven by a gpio but by a pio from the sdhci device. In the binding,
declaring the gpio is an option so I thought using this regulator fits my need.


P.S. patch 2 is based on another patch not yet in next:
http://www.spinics.net/lists/arm-kernel/msg453447.html

Thanks

Ludovic


Ludovic Desroches (2):
  mmc: sdhci: set bus voltage before enabling bus power
  ARM: at91/dt: sama5d2 Xplained: add regulators for sdhci devices

 arch/arm/boot/dts/at91-sama5d2_xplained.dts | 14 ++++++++++++++
 drivers/mmc/host/sdhci.c                    |  7 -------
 2 files changed, 14 insertions(+), 7 deletions(-)

-- 
2.5.0

