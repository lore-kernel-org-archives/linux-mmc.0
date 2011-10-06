From: Ulf Hansson <ulf.hansson@stericsson.com>
Subject: Re: [PATCH 2/2] mmc: sdhci-pci: add runtime pm support
Date: Thu, 6 Oct 2011 16:39:00 +0200
Message-ID: <4E8DBD84.8070103@stericsson.com>
References: <1317645214-12316-1-git-send-email-adrian.hunter@intel.com> <1317645214-12316-3-git-send-email-adrian.hunter@intel.com> <4E8C70D7.6080305@stericsson.com> <4E8D5D07.4010604@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog113.obsmtp.com ([207.126.144.135]:41577 "EHLO
	eu1sys200aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754778Ab1JFOji (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 6 Oct 2011 10:39:38 -0400
In-Reply-To: <4E8D5D07.4010604@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Chris Ball <cjb@laptop.org>, linux-mmc <linux-mmc@vger.kernel.org>, Linus WALLEIJ <linus.walleij@stericsson.com>

> 
> It has been discussed on the list before that the host controller driver should 
> be solely responsible for host controller power.

OK I see, sorry that I missed that discussion earlier!

Anyway this should be feasible as well even it might mean duplicated 
code in each host driver. A positive side is that it gets more flexible 
for each host driver.

> 
>>
>> Moreover 1:
>> I have noticed the pm_runtime support is implemented for sdio and when having
>> MMC_CAP_POWER_OFF_CARD. This needs to be "cleaned up" after such a change. It
>> might also conflict with your patch considering "moreover 2" below.
> 
> No.  The card and the host controller are separate devices.  The card can be 
> powered up when the host controller is off and vice versa.  They are not 
> inter-dependent in that regard.

I see your point, but it is somewhere here it is getting a bit "messy". :-)

If I understand correct, you mean that the mmc/sd/sdio framework shall
be responsible of handling power management of the bus/card devices. In
other words the framework shall itself decide when it is feasible of
doing mmc_power_restore_host, mmc_power_save_host, mmc_suspend_host,
mmc_resume_host.

This is not the case right now, since most host drivers are normally in
control of calling these functions themselves. Should this be moved to 
the framework then?

> 
>> Moreover 2:
>> dev_pm_ops with runtime functions, are implemented for the mmc bus (core/bus.c).
>> Maybe this should be moved from the responsibility of the bus into the mmc host
>> drivers instead!? I think it makes more sense to leave such decisions as doing
>> "mmc_power_save_host/mmc_power_restore_host" to each mmc host driver. Just
>> because we get runtime suspended that does not have to mean we wnat to do
>> mmc_power_save_host... What do you think?
> 
> Again, this has been discussed before on the list, that the power management of 
> the card is something that only upper layers control e.g. sdio function driver
> 

I got it, thanks a lot for your answers and feedback!


> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


BR
Ulf Hansson
