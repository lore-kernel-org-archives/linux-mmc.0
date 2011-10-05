From: Ulf Hansson <ulf.hansson@stericsson.com>
Subject: Re: [PATCH 2/2] mmc: sdhci-pci: add runtime pm support
Date: Wed, 5 Oct 2011 16:59:35 +0200
Message-ID: <4E8C70D7.6080305@stericsson.com>
References: <1317645214-12316-1-git-send-email-adrian.hunter@intel.com> <1317645214-12316-3-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog115.obsmtp.com ([207.126.144.139]:34005 "EHLO
	eu1sys200aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S934672Ab1JEPAT (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 5 Oct 2011 11:00:19 -0400
In-Reply-To: <1317645214-12316-3-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Chris Ball <cjb@laptop.org>, linux-mmc <linux-mmc@vger.kernel.org>, elinwal <linus.walleij@stericsson.com>

Adrian Hunter wrote:
> Ths patch allows runtime PM for sdhci-pci, runtime suspending
> after inactivity of 50ms and ensuring runtime resume before
> SDHC registers are accessed.  During runtime suspend, interrupts
> are masked.  The host controller state is restored at runtime
> resume.
> 
> For Medfield, the host controller's card detect mechanism
> is supplanted by an always-on GPIO which provides for card
> detect wake-up.
> 
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>


I am not that into how the sdhci host drivers is working, myself is more 
working with the mmci driver and about to sent out patches with improved 
power management support soon. I would like to take the opportunity to 
discuss in general pm_runtime for mmc/sd/sdio.

Right now the mmc framework supports MMC_CAP_DISABLE, which means the 
host driver shall implement an enable/disable function. Very similar to 
what pm_runtime can be used for, but pm_runtime is a more modern way of 
solving power management. Is this your overall view on this as well?

Anyway, I would then suggest that it should be the framework 
responsibilities of doing:

1. pm_runtime_get_sync -> To make sure the mmc host is runtime resumed 
before the framework is using it. This could be done when "claiming" the 
host or more precisely as the first thing in the mmc_host_enable function.

2. pm_runtime_mark_last_busy -> To put a time stamp at the last time the 
framework used the mmc host. This could be done as the first thing in 
mmc_host_lazy_disable/mmc_host_disable.

3. pm_runtime_put_sync_autosuspend -> To trigger the timer of runtime 
suspending the mmc host driver. This could be done as the first thing in 
mmc_host_lazy_disable/mmc_host_disable.


The mmc host drivers will be responsible of the following:

1. Implementing the runtime_resume, runtime_suspend and possibly 
runtime_idle functions and register them in the device driver struct.

2. Initializing and setup pm_runtime for the mmc host driver. For 
example use:
pm_runtime_set_autosuspend_delay
pm_runtime_use_autosuspend
pm_runtime_enable


Moreover 1:
I have noticed the pm_runtime support is implemented for sdio and when 
having MMC_CAP_POWER_OFF_CARD. This needs to be "cleaned up" after such 
a change. It might also conflict with your patch considering "moreover 
2" below.

Moreover 2:
dev_pm_ops with runtime functions, are implemented for the mmc bus 
(core/bus.c). Maybe this should be moved from the responsibility of the 
bus into the mmc host drivers instead!? I think it makes more sense to 
leave such decisions as doing 
"mmc_power_save_host/mmc_power_restore_host" to each mmc host driver. 
Just because we get runtime suspended that does not have to mean we wnat 
to do mmc_power_save_host... What do you think?

Best regards
Ulf Hansson




