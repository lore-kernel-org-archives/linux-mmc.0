From: Philip Rakity <prakity@marvell.com>
Subject: Re: [PATCH] mmc: support sdhci-mmp2
Date: Sat, 28 May 2011 09:25:00 -0700
Message-ID: <A68B8B3A-AED9-407D-ABD7-0A0FA63F30B8@marvell.com>
References: <1306156882-12124-1-git-send-email-zhangfei.gao@marvell.com>
 <F4CA7B04-7898-4C6A-814E-DE84588E3C94@marvell.com>
 <201105281052.39803.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:45014 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753727Ab1E1QZN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 28 May 2011 12:25:13 -0400
In-Reply-To: <201105281052.39803.arnd@arndb.de>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Zhangfei Gao <zgao6@marvell.com>, Nicolas Pitre <nico@fluxnic.net>, Wolfram Sang <w.sang@pengutronix.de>, Chris Ball <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Jun Nie <njun@marvell.com>, Raymond Wu <xywu@marvell.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Mark Brown <mark.brown314@gmail.com>, Shawn Guo <shawn.guo@linaro.org>


On May 28, 2011, at 1:52 AM, Arnd Bergmann wrote:

> On Saturday 28 May 2011 07:00:38 Philip Rakity wrote:
>> In some sense all of this is backwards.  Once the SoC is known (pxa910 or mmp2),
>> it knows that SDHCI controller it supports.  It should set a config option
>> like USES_MRVL_V3_SD_CONTROLLER.  The Kconfig entry in mmc/host should
>> depend on THAT selection to allow the user to enable the SD option.
> 
> I would actually prefer in general if the Kconfig file listed only
> the strictly necessary dependencies for building the driver.
> If this driver can be built anywhere, I would list no dependency at
> all. If it depends on something ARM specific, I'd make it depend
> on CONFIG_ARM.
> 
> Then change the defconfig for the particular board to enable the
> driver.
> 
> The main advantage of this is to increase build coverage on test
> building machines doing an allyesconfig and randconfig once we
> get there (right now, these have too many build errors, but we
> have plans to work on that). 

The controller is built into the mmp2 SoC.  No build error could
occur if once the SoC is determined it selected the type of
controller available (in the arch/arm).  Like the patch you
helped me with a while ago (which never was accepted).

The Kconfig entry for MMP2 in drivers/mmc/host would
add the line 
depends on 

This is not a general as depending on ARM but at least
the code would work.

The best solution would be far more general and involve
generic probing and registration but that is a lot of work and
should be done for all of the arm/ directory. 

> 
>>> --- /dev/null
>>> +++ b/drivers/mmc/host/sdhci-mmp2.c
>> 
>> It is probably better to NOT name the file sdhci-mmp2.c but
>> something like sdchi-pxaV3.c since other SoC's may use this controller.
> 
> Good point.
> 
>>> +       pxa = kzalloc(sizeof(struct sdhci_pxa), GFP_KERNEL);
>>> +       if (!pxa) {
>>> +               ret = -ENOMEM;
>>> +               goto out;
>>> +       }
>>> +       pxa->ops = kzalloc(sizeof(struct sdhci_ops), GFP_KERNEL);
>> why is  pxa->ops needed ?
> 
> I guess the idea was to be able to free the structure later. I already
> commented that it should be statically allocation instead of kzalloc,
> so that would make the pointer unnecessary.

I do not understand why pxa->ops is needed at all.  More general 
question.

> 
> 	Arnd
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

