From: Chris Ball <cjb@laptop.org>
Subject: Re: [Query] mmc: core "MMC_PM_KEEP_POWER"
Date: Tue, 22 Nov 2011 08:53:37 -0500
Message-ID: <87ty5w2rha.fsf@laptop.org>
References: <4ECBA3B1.1010808@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:42989 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755421Ab1KVNxo (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 22 Nov 2011 08:53:44 -0500
In-Reply-To: <4ECBA3B1.1010808@stericsson.com> (Ulf Hansson's message of "Tue,
	22 Nov 2011 14:29:21 +0100")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@stericsson.com>
Cc: linux-mmc@vger.kernel.org, eliad@wizery.com, nico@fluxnic.net

Hi,

On Tue, Nov 22 2011, Ulf Hansson wrote:
> Hi,
>
> In mmc_resume_host we clear the MMC_PM_KEEP_POWER flag from the
> pm_flags bitfield. This is done by a patch from Eliad Peller a while
> ago, "mmc: clear MMC_PM_KEEP_POWER flag on resume"
>
> I would like to understand if there are any reason to why we want to
> clear this flag after we done a resume. I think it will add complexity
> to an sdio function driver since it must update this flag for after
> each suspend/resume sequence. Should it not just be enough to do this
> during the initialization of the sdio func driver.

The sdio function driver should just call sdio_set_host_pm_flags() in
its suspend function, if it wants to stay awake at the next suspend.
It's just one line of code, so I don't think it's overly complex.

We clear the flag because that's how the API is defined --
sdio_set_host_pm_flags() says "This must be called, if needed, each
time the suspend method of the function driver is called".

There's a separate question of "Why is the API this way, and should
we change it?".  I think the API ended up this way because it was
created for a wifi device where a suspend would usually happen while
you're unassociated, so you don't need to preserve power (because
nothing interesting can happen to wake you up), but will sometimes
happen while you're associated, in which case you do.  It sounds like
you're considering a device that *always* wants to stay awake, which
is different to the rest of the users of this API.

But it's just the difference between (your proposal) having
sdio_set_host_pm_flags() be called during init, and (the API) having
sdio_set_host_pm_flags() be called during suspend.  It's the same
line of code either way, so I don't see why it's annoying this way.

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
