From: Eliad Peller <eliad@wizery.com>
Subject: Re: [Query] mmc: core "MMC_PM_KEEP_POWER"
Date: Tue, 22 Nov 2011 15:44:10 +0200
Message-ID: <CAB3XZEf3C4EUVYbwR+0Jks8pVUu3V13CNgQ7Ot3_B6iWdryq8Q@mail.gmail.com>
References: <4ECBA3B1.1010808@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:60745 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752608Ab1KVNoK (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 22 Nov 2011 08:44:10 -0500
Received: by iage36 with SMTP id e36so170374iag.19
        for <linux-mmc@vger.kernel.org>; Tue, 22 Nov 2011 05:44:10 -0800 (PST)
In-Reply-To: <4ECBA3B1.1010808@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@stericsson.com>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, nico@fluxnic.net

hi Ulf,

On Tue, Nov 22, 2011 at 3:29 PM, Ulf Hansson <ulf.hansson@stericsson.com> wrote:
> In mmc_resume_host we clear the MMC_PM_KEEP_POWER flag from the pm_flags
> bitfield. This is done by a patch from Eliad Peller a while ago, "mmc: clear
> MMC_PM_KEEP_POWER flag on resume"
>
> I would like to understand if there are any reason to why we want to clear
> this flag after we done a resume. I think it will add complexity to an sdio
> function driver since it must update this flag for after each suspend/resume
> sequence. Should it not just be enough to do this during the initialization
> of the sdio func driver.
>
please check out the sdio_set_host_pm_flags() documentation:

/**
 *	sdio_set_host_pm_flags - set wanted host power management capabilities
 *	@func: SDIO function attached to host
 *
 *	Set a capability bitmask corresponding to wanted host controller
 *	power management features for the upcoming suspend state.
 *	This must be called, if needed, each time the suspend method of
 *	the function driver is called, and must contain only bits that
 *	were returned by sdio_get_host_pm_caps().
 *	The host doesn't need to be claimed, nor the function active,
 *	for this information to be set.
 */
int sdio_set_host_pm_flags(struct sdio_func *func, mmc_pm_flag_t flags)

as we have to set the flags on each suspend, we have to clear them on resume.

regards,
Eliad.
