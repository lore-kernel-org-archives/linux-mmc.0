From: Philip Rakity <prakity-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
Subject: RE: Where to power on the wifi device before loading the driver.
Date: Mon, 18 Jun 2012 18:23:35 -0700
Message-ID: <43E4817426ED174AA81263BCECB4351D138E8ACD6B@sc-vexch3.marvell.com>
References: <6B4D417B830BC44B8026029FD256F7F1C377BFFE88@HKMAIL01.nvidia.com>
 <4FD90352.9090606@wwwdotorg.org>
 <20120614063120.GA20167@avionic-0098.mockup.avionic-design.de>
 <20120614121234.GC3913@opensource.wolfsonmicro.com>
 <4FDA092E.10301@wwwdotorg.org>
 <6B4D417B830BC44B8026029FD256F7F1C377BFFE8D@HKMAIL01.nvidia.com>
 <4FDB5976.20809@wwwdotorg.org>,<6B4D417B830BC44B8026029FD256F7F1C6EE2DD61F@HKMAIL01.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <6B4D417B830BC44B8026029FD256F7F1C6EE2DD61F-Q4EWCATADntDw2glCA4ptUEOCMrvLtNR@public.gmane.org>
Content-Language: en-US
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wei Ni <wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, 'Stephen Warren' <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Rakesh Kumar <krakesh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, "'frankyl-dY08KVG/lbpWk0Htik3J/w@public.gmane.org'" <frankyl-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>, Mursalin Akon <makon-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "'linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org'" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "'linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org'" <linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Why can't you use the regulator notify to get called back on power or voltage change options to plumb in the manipulation of the gpio. I can imagine you might need to add a notify call in core.c if you need to assert the gpio before power is applied


________________________________________
From: linux-mmc-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org [linux-mmc-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org] On Behalf Of Wei Ni [wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org]
Sent: Sunday, June 17, 2012 11:20 PM
To: 'Stephen Warren'; Rakesh Kumar
Cc: Mark Brown; 'frankyl-dY08KVG/lbpWk0Htik3J/w@public.gmane.org'; Thierry Reding; Mursalin Akon; 'linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org'; devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org; 'linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org'; linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Subject: RE: Where to power on the wifi device before loading the driver.

On Fri, Jun 15, 2012 at 23:49:10, Stephen Warren wrote:
>> I talked with Franky, this power sequence is generally for 4329, so
>> it mean this sequence can be put into the wifi driver.
>> We can use the virtual platform device both for OOB and non OOB.
>> I will send out patches later.
>
>Can you please expand on what a "virtual platform device" is; device tree typically represents real hardware rather than anything "virtual".

The "virtual platform device" is created before the real wifi device, so that it can pass the gpios to the driver, and power up the device before calling sdio_register_driver.
But as Franky said, this power sequence is only generally for 4329, not for the USB dongle chips. So it's not a good idea to add this "power up" in brcmfmac.

>
>Now if this means adding a child node under the SDIO controller to represent the attached device, and storing any settings required by that device in that child node, that's probably a reasonable basic approach.
>
>BTW, which GPIO is the power GPIO; is it WF_EN on the schematic? That seems reasonable to represent as a GPIO rather than a regulator since it connects directly into the WiFi device as a GPIO, and its use within the WiFi device can indeed be governed purely internally to the WiFi driver/HW. However, if this is some GPIO that controls the power to e.g.
>VBAT3V3_IN_WF, VDDIO_WF, or other power supply to the WiFi card, then it'd be better represented as a regulator, since the control point is outside the WiFi device.

I think Rakesh may can answer this.

Wei.
---
nvpublic


--
To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
