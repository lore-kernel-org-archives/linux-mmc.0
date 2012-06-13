From: "Franky Lin" <frankyl-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Subject: Re: Where to power on the wifi device before loading the
 driver.
Date: Wed, 13 Jun 2012 10:33:13 -0700
Message-ID: <4FD8CED9.6030901@broadcom.com>
References: <6B4D417B830BC44B8026029FD256F7F1C377BFFE88@HKMAIL01.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=iso-8859-1;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <6B4D417B830BC44B8026029FD256F7F1C377BFFE88-Q4EWCATADntDw2glCA4ptUEOCMrvLtNR@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wei Ni <wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "'linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org'" <linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "'linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org'" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Mursalin Akon <makon-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Rakesh Kumar <krakesh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Hi Wei,

On 06/13/2012 03:40 AM, Wei Ni wrote:
> In the brcmfmac init routine, it call sdio_register_driver() to register driver, if the wifi device is powered on, then the mmc driver will enumerate it, and call the probe callback routine.
>
> On the Cardhu, the wifi's power is controlled by two gpios (power-gpio and reset-gpio), the default state is power-off. So we need to power on it before calling sdio_register_driver(), if not, the mmc driver can't enumerate it, and will not call the probe routine.
> This power on sequence is:
> set power-gpio to 1 ;
> mdelay(100) ;
> set reset-gpio to 1 ;
> mdelay(200);
>
> My question is where to power on the wifi. We may have three places to power on it:
> 1. power on it in the brcmfmac driver before calling sdio_register_driver(). But I think this power sequence is special for tegra30 cardhu, it's not good to add it in the generic wifi driver, because different board may use the different way to power on the wifi.
> 2. power on it in the mmc driver. In our tegra SD driver, it has power-gpios property, which allow the slot to be powered. But this power is for mmc slot, could we add this wifi power sequence in the tegra SD driver?
> 3. hard-coded into DT. Set these gpios in the DT, something like pinmux settings, but in this way, it's not good to put the mdelay() value in the DT.

We introduced oob interrupt support in 3.5 [1]. We are using a virtual 
platform device to retrieve board specific oob interrupt GPIO setting. 
You should be able to implement the power control in this way as well. 
Brcmfmac gets the GPIOs through platform device interface, powers up the 
chip and triggers a card detection. Then 4329 should be enumerated by 
MMC stack. The reason we didn't implement this is the card detection. 
Some design doesn't have hardware card detection since the WiFi chip is 
already on board. And the current MMC stack doesn't have virtual card 
detection interface.

Franky

[1]: http://www.spinics.net/lists/linux-wireless/msg89335.html

--
To unsubscribe from this list: send the line "unsubscribe linux-wireless" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
