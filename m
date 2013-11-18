From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH 01/16] gpio: rcar: use postcore_init()
Date: Mon, 18 Nov 2013 15:00:39 +0100
Message-ID: <1556705.9JOUK7Uj8L@avalon>
References: <87li0rz3to.wl%kuninori.morimoto.gx@renesas.com> <2397666.YV2gHto7Bb@avalon> <87fvqyo6gl.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:42811 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751341Ab3KRN75 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 18 Nov 2013 08:59:57 -0500
In-Reply-To: <87fvqyo6gl.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Simon <horms@verge.net.au>, Chris Ball <cjb@laptop.org>, Magnus <magnus.damm@gmail.com>, Linux-SH <linux-sh@vger.kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, linux-mmc@vger.kernel.org, linus.walleij@linaro.org

Hi Morimoto-san,

(CC'ing Linus Walleij)

On Thursday 14 November 2013 16:26:53 Kuninori Morimoto wrote:
> Hi Laurent
> 
> > > Renesas GPIO is being interlocked with PFC, and GPIO is
> > > very basic system for R-Car.
> > > GPIO should be initialised in same timing as PFC.
> > > The GPIO based system doesn't work correctly without this patch.
> > 
> > Could you please describe the failure in a bit more details ?
> 
> Real kernel log is better than my explain :P
> These series needs gpio-regulator.
> *before* case, sh_mobile_sdhi can't use gpio-regulator because of timing
> issue.
> 
> ----------------- before ---------------------
> ...
> sh-pfc pfc-r8a7790: r8a77900_pfc support registered
> ...
> SDHI0Vcc: Failed to request enable GPIO184: -517
> reg-fixed-voltage reg-fixed-voltage.1: Failed to register regulator: -517
> platform reg-fixed-voltage.1: Driver reg-fixed-voltage requests probe
> deferral SDHI2Vcc: Failed to request enable GPIO185: -517
> reg-fixed-voltage reg-fixed-voltage.2: Failed to register regulator: -517
> platform reg-fixed-voltage.2: Driver reg-fixed-voltage requests probe
> deferral gpio-regulator gpio-regulator.0: Could not obtain regulator
> setting GPIOs: -517 platform gpio-regulator.0: Driver gpio-regulator
> requests probe deferral gpio-regulator gpio-regulator.1: Could not obtain
> regulator setting GPIOs: -517 platform gpio-regulator.1: Driver
> gpio-regulator requests probe deferral ...

Except for the verbosity of the error messages, this looks pretty sane to me. 
Regulator probe gets deferred because the required GPIO isn't accessible yet, 
and the device gets reprobed later on.

I'm not against moving the gpio-rcar initialization to postcore or subsys 
initcall, but in that case I believe we should standardize (or at least try 
to) this across the GPIO drivers. We currently have

$ cat drivers/gpio/gpio-*.c | grep _initcall | grep '^[a-z]' | sed 's/(.*//' | 
sort | uniq -c
      2 arch_initcall
      1 core_initcall
      1 device_initcall
      1 late_initcall
     11 postcore_initcall
      2 pure_initcall
     31 subsys_initcall

$ cat drivers/gpio/gpio-*.c | grep 'module_.*_driver' | sed 's/(.*//' | sort | 
uniq -c
      3 module_i2c_driver
      4 module_pci_driver
     23 module_platform_driver
      1 module_spi_driver

Linus, do you have any guidelines on this ?

> gpio_rcar gpio_rcar.0: driving 32 GPIOs
> gpio_rcar gpio_rcar.1: driving 32 GPIOs
> gpio_rcar gpio_rcar.2: driving 32 GPIOs
> gpio_rcar gpio_rcar.3: driving 32 GPIOs
> gpio_rcar gpio_rcar.4: driving 32 GPIOs
> gpio_rcar gpio_rcar.5: driving 32 GPIOs
> ...
> sh_mobile_sdhi sh_mobile_sdhi.0: mmc0 base at 0xee100000 clock rate 97 MHz
> sh_mobile_sdhi sh_mobile_sdhi.2: mmc1 base at 0xee140000 clock rate 48 MHz
> ...
> SDHI0Vcc: 3300 mV
> SDHI2Vcc: 3300 mV
> vqmmc: 1800 <--> 3300 mV at 3300 mV
> vqmmc: 1800 <--> 3300 mV at 3300 mV
> ...
> 
> ---------------- after ------------------
> ...
> sh-pfc pfc-r8a7790: r8a77900_pfc support registered
> gpio_rcar gpio_rcar.0: driving 32 GPIOs
> gpio_rcar gpio_rcar.1: driving 32 GPIOs
> gpio_rcar gpio_rcar.2: driving 32 GPIOs
> gpio_rcar gpio_rcar.3: driving 32 GPIOs
> gpio_rcar gpio_rcar.4: driving 32 GPIOs
> gpio_rcar gpio_rcar.5: driving 32 GPIOs
> ...
> SDHI0Vcc: 3300 mV
> SDHI2Vcc: 3300 mV
> vqmmc: 1800 <--> 3300 mV at 3300 mV
> vqmmc: 1800 <--> 3300 mV at 3300 mV
> ...
> sh_mobile_sdhi sh_mobile_sdhi.0: mmc0 base at 0xee100000 clock rate 97 MHz
> sh_mobile_sdhi sh_mobile_sdhi.2: mmc1 base at 0xee140000 clock rate 48 MHz

-- 
Regards,

Laurent Pinchart

