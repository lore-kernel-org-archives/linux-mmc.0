From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [Query] mmc: core "MMC_PM_KEEP_POWER"
Date: Tue, 22 Nov 2011 08:52:28 -0500 (EST)
Message-ID: <alpine.LFD.2.02.1111220851070.17904@xanadu.home>
References: <4ECBA3B1.1010808@stericsson.com>
 <CAB3XZEf3C4EUVYbwR+0Jks8pVUu3V13CNgQ7Ot3_B6iWdryq8Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from relais.videotron.ca ([24.201.245.36]:12990 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752608Ab1KVNwp (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 22 Nov 2011 08:52:45 -0500
Received: from xanadu.home ([66.130.28.92]) by VL-VM-MR005.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0LV2005VDEJANS10@VL-VM-MR005.ip.videotron.ca> for
 linux-mmc@vger.kernel.org; Tue, 22 Nov 2011 08:52:23 -0500 (EST)
In-reply-to: <CAB3XZEf3C4EUVYbwR+0Jks8pVUu3V13CNgQ7Ot3_B6iWdryq8Q@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Eliad Peller <eliad@wizery.com>
Cc: Ulf Hansson <ulf.hansson@stericsson.com>, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>

On Tue, 22 Nov 2011, Eliad Peller wrote:

> hi Ulf,
> 
> On Tue, Nov 22, 2011 at 3:29 PM, Ulf Hansson <ulf.hansson@stericsson.com> wrote:
> > In mmc_resume_host we clear the MMC_PM_KEEP_POWER flag from the pm_flags
> > bitfield. This is done by a patch from Eliad Peller a while ago, "mmc: clear
> > MMC_PM_KEEP_POWER flag on resume"
> >
> > I would like to understand if there are any reason to why we want to clear
> > this flag after we done a resume. I think it will add complexity to an sdio
> > function driver since it must update this flag for after each suspend/resume
> > sequence. Should it not just be enough to do this during the initialization
> > of the sdio func driver.
> >
> please check out the sdio_set_host_pm_flags() documentation:
> 
> /**
>  *	sdio_set_host_pm_flags - set wanted host power management capabilities
>  *	@func: SDIO function attached to host
>  *
>  *	Set a capability bitmask corresponding to wanted host controller
>  *	power management features for the upcoming suspend state.
>  *	This must be called, if needed, each time the suspend method of
>  *	the function driver is called, and must contain only bits that
>  *	were returned by sdio_get_host_pm_caps().
>  *	The host doesn't need to be claimed, nor the function active,
>  *	for this information to be set.
>  */
> int sdio_set_host_pm_flags(struct sdio_func *func, mmc_pm_flag_t flags)
> 
> as we have to set the flags on each suspend, we have to clear them on resume.

When I introduced this interface, the flags were cleared by the core 
code upon resume.


Nicolas
