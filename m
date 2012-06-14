From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: Where to power on the wifi device before loading the driver.
Date: Thu, 14 Jun 2012 09:54:22 -0600
Message-ID: <4FDA092E.10301@wwwdotorg.org>
References: <6B4D417B830BC44B8026029FD256F7F1C377BFFE88@HKMAIL01.nvidia.com> <4FD90352.9090606@wwwdotorg.org> <20120614063120.GA20167@avionic-0098.mockup.avionic-design.de> <20120614121234.GC3913@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120614121234.GC3913-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Cc: Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>, Wei Ni <wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Mursalin Akon <makon-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "'linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org'" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "'linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org'" <linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rakesh Kumar <krakesh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On 06/14/2012 06:12 AM, Mark Brown wrote:
> On Thu, Jun 14, 2012 at 08:31:20AM +0200, Thierry Reding wrote:
>> On Wed, Jun 13, 2012 at 03:17:06PM -0600, Stephen Warren wrote:
> 
>>> The core of the issue is that:
> 
>>> * Tegra30 support is via device tree. * We have an SDIO bus,
>>> and the WiFi device attached to that bus is enumerable. * Since
>>> the WiFi device is enumerable, no node exists in the DT to 
>>> represent it. * However, the driver for the WiFi device needs
>>> certain information, such as the reset GPIO ID and perhaps
>>> power GPIO.
> 
>> PCI devices are also enumerable and yet they can be matched up
>> with nodes in the device tree. Perhaps something similar could be
>> added for the SDIO bus?
> 
> This seems to make the most sense - pushing this through the
> regulator API is just a bodge.

Yes, that seems reasonable.

Presumably the power GPIO should be a fixed regulator though, since it
is a power control not just a plain old GPIO? That said, the current
driver apparently deals with this as a GPIO already.

The reset GPIO can separately/directly controlled by the WiFi driver
though.
--
To unsubscribe from this list: send the line "unsubscribe linux-wireless" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
