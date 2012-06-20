From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: Where to power on the wifi device before loading the driver.
Date: Wed, 20 Jun 2012 10:51:42 -0600
Message-ID: <4FE1FF9E.4070604@wwwdotorg.org>
References: <6B4D417B830BC44B8026029FD256F7F1C377BFFE88@HKMAIL01.nvidia.com> <4FD90352.9090606@wwwdotorg.org> <20120614063120.GA20167@avionic-0098.mockup.avionic-design.de> <20120614121234.GC3913@opensource.wolfsonmicro.com> <4FDA092E.10301@wwwdotorg.org> <6B4D417B830BC44B8026029FD256F7F1C377BFFE8D@HKMAIL01.nvidia.com> <4FDB5976.20809@wwwdotorg.org> <6B4D417B830BC44B8026029FD256F7F1C6EE2DD61F@HKMAIL01.nvidia.com> <43E4817426ED174AA81263BCECB4351D138E8ACD6B@sc-vexch3.marvell.com> <6B4D417B830BC44B8026029FD256F7F1C6EE2DD622@HKMAIL01.nvidia.com> <20120619091719.GZ3974@opensource.wolfsonmicro.com> <6B4D417B830BC44B8026029FD256F7F1C6EE2DD626@HKMAIL01.nvidia.com> <4FE112F2.7000506@wwwdotorg.org> <6B4D417B830BC44B8026029FD256F7F1C6EE2DD629@HKMAIL01.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <6B4D417B830BC44B8026029FD256F7F1C6EE2DD629-Q4EWCATADntDw2glCA4ptUEOCMrvLtNR@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wei Ni <wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: 'Mark Brown' <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, 'Philip Rakity' <prakity-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Rakesh Kumar <krakesh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "'frankyl-dY08KVG/lbpWk0Htik3J/w@public.gmane.org'" <frankyl-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>, Mursalin Akon <makon-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "'linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org'" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "'linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org'" <linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On 06/20/2012 05:28 AM, Wei Ni wrote:
...
> Stephen, as Rakesh said that in case of bcm4329, the two GPIO (WF_EN
> and WF_RST) are shorted. So I think we can simply to use the
> power-gpios properity in the SD driver, just use one gpio I test it
> in this way, it runs ok, the bcm4329 can be powered up. We can use
> this option.

Wei, again, your emails and not correctly word-wrapped to well under 80
columns. I know it's a pain to do that with Exchange/Outlook, but it's
really difficult for anyone to read emails that aren't correctly formatted.

So yes, once we'd resolved this general issue, that was going to be my
next topic of discussion.

I looked at the schematic of the 4329 module, and the GPIOs aren't
shorted, but rather there's a stuffing option - either WF_EN or WF_RST
is actually connected to the 4329's WL_SHUTDOWN_N_RST pin. I believe
WF_EN is the one connected. If the two signals were shorted, you'd need
to control both of them to avoid sinking power from one of Tegra's GPIO
outputs into the other if they were set to differing values.

So, yes, using the power-gpios property will probably work in this case.

This rather begs the question: WTF is our downstream kernel doing
actively controlling both GPIOs with time delays between each? Do you
have the schematic for the 4330 module, or indeed any other module
that's used on Cardhu? If so, please do send them to me internally.
While this workaround might work for the 4329, additional research would
be useful so we can determine whether we still have a problem to solve
for other modules.

Thanks.
--
To unsubscribe from this list: send the line "unsubscribe linux-wireless" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
