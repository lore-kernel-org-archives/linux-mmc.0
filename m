From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 2/2] mmc: sdhci-pci: add runtime pm support
Date: Thu, 06 Oct 2011 10:47:19 +0300
Message-ID: <4E8D5D07.4010604@intel.com>
References: <1317645214-12316-1-git-send-email-adrian.hunter@intel.com> <1317645214-12316-3-git-send-email-adrian.hunter@intel.com> <4E8C70D7.6080305@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:45073 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755824Ab1JFHrc (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 6 Oct 2011 03:47:32 -0400
In-Reply-To: <4E8C70D7.6080305@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@stericsson.com>
Cc: Chris Ball <cjb@laptop.org>, linux-mmc <linux-mmc@vger.kernel.org>, elinwal <linus.walleij@stericsson.com>

On 05/10/11 17:59, Ulf Hansson wrote:
> I am not that into how the sdhci host drivers is working, myself is more working
> with the mmci driver and about to sent out patches with improved power
> management support soon. I would like to take the opportunity to discuss in
> general pm_runtime for mmc/sd/sdio.
>
> Right now the mmc framework supports MMC_CAP_DISABLE, which means the host
> driver shall implement an enable/disable function. Very similar to what
> pm_runtime can be used for, but pm_runtime is a more modern way of solving power
> management. Is this your overall view on this as well?

Yes

>
> Anyway, I would then suggest that it should be the framework responsibilities of
> doing:
>
> 1. pm_runtime_get_sync -> To make sure the mmc host is runtime resumed before
> the framework is using it. This could be done when "claiming" the host or more
> precisely as the first thing in the mmc_host_enable function.
>
> 2. pm_runtime_mark_last_busy -> To put a time stamp at the last time the
> framework used the mmc host. This could be done as the first thing in
> mmc_host_lazy_disable/mmc_host_disable.
>
> 3. pm_runtime_put_sync_autosuspend -> To trigger the timer of runtime suspending
> the mmc host driver. This could be done as the first thing in
> mmc_host_lazy_disable/mmc_host_disable.
>
>
> The mmc host drivers will be responsible of the following:
>
> 1. Implementing the runtime_resume, runtime_suspend and possibly runtime_idle
> functions and register them in the device driver struct.
>
> 2. Initializing and setup pm_runtime for the mmc host driver. For example use:
> pm_runtime_set_autosuspend_delay
> pm_runtime_use_autosuspend
> pm_runtime_enable

It has been discussed on the list before that the host controller driver should 
be solely responsible for host controller power.

>
>
> Moreover 1:
> I have noticed the pm_runtime support is implemented for sdio and when having
> MMC_CAP_POWER_OFF_CARD. This needs to be "cleaned up" after such a change. It
> might also conflict with your patch considering "moreover 2" below.

No.  The card and the host controller are separate devices.  The card can be 
powered up when the host controller is off and vice versa.  They are not 
inter-dependent in that regard.

>
> Moreover 2:
> dev_pm_ops with runtime functions, are implemented for the mmc bus (core/bus.c).
> Maybe this should be moved from the responsibility of the bus into the mmc host
> drivers instead!? I think it makes more sense to leave such decisions as doing
> "mmc_power_save_host/mmc_power_restore_host" to each mmc host driver. Just
> because we get runtime suspended that does not have to mean we wnat to do
> mmc_power_save_host... What do you think?

Again, this has been discussed before on the list, that the power management of 
the card is something that only upper layers control e.g. sdio function driver

