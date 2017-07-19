From: Ludovic Desroches <ludovic.desroches@microchip.com>
Subject: Re: vmmc-supply
Date: Wed, 19 Jul 2017 14:39:30 +0200
Message-ID: <20170719123930.33j2ep3yfgrhigw4@rfolt0960.corp.atmel.com>
References: <d8b762f1-efb1-21df-0760-505eb9ff2a03@mnementh.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:51256 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751991AbdGSMkR (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 19 Jul 2017 08:40:17 -0400
Content-Disposition: inline
In-Reply-To: <d8b762f1-efb1-21df-0760-505eb9ff2a03@mnementh.co.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ian Molton <ian@mnementh.co.uk>
Cc: linux-mmc@vger.kernel.org

Hi Ian,

On Wed, Jul 12, 2017 at 04:28:19PM +0100, Ian Molton wrote:
> Hi folks,
> 
> I'm working on a SDIO wifi card and I'm attempting to figure out how on
> earth voltage regulation works for MMC slots.
> 
> The mmc host is an imx6ul
> 
> In its DT, it has the following:
> 
> &usdhc1 {
>         #address-cells = <1>;
>         #size-cells = <0>;
>         pinctrl-names = "default", "state_100mhz", "state_200mhz";
>         pinctrl-0 = <&pinctrl_usdhc1>;
>         pinctrl-1 = <&pinctrl_usdhc1_100mhz>;
>         pinctrl-2 = <&pinctrl_usdhc1_200mhz>;
>         no-1-8-v;
>         keep-power-in-suspend;
>         enable-sdio-wakeup;
>         vmmc-supply = <&reg_sd1_vmmc>;
>         non-removable;
>         status = "okay";
> }
> 
> Its working, however I cannot seem to get it to turn off power to the
> slot. I would expect that if the card is probed and no driver wants to
> attach, the slot can be turned off.
> 

I don't think your regulator will be turned off automatically, you may rely on
your bootloader to do it. MMC core will turn it on. I let you dig into the
code. Regulator state is updated when calling set_ios() depending on
ios power_mode.

> cat /sys/class/regulator/regulator.5/state tells me the regulator is
> enabled, and num_users is 1
> 
> whats really puzzling me is that nowhere in the code does git grep show
> *any* attempt to look up a regulator called vmmc-supply, or a dt
> property with the same name. Unless I'm being blind...
> 

Have a look to of_get_regulator.

Regards

Ludovic

> I assume the of regulator code is looking up the parent device and
> enabling the regulator for me, but then I cannot see how the MMC core /
> host driver might control the regulator.
> 
> Is this all as it is expected to be?
> 
> What I'd like is for an attempt to load the wifi module to cause the MMC
> host to turn on the power and let the card try to re-enumerate/probe,
> and for driver unloading to cause the card to get turned off again.
> 
> I cant see a good way to toggle slot power from userspace either -
> although I may just be missing this?
> 
> TIA for comments,
> 
> -Ian
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
