From: Ulf Hansson <ulf.hansson@stericsson.com>
Subject: Re: [Query] mmc: core "MMC_PM_KEEP_POWER"
Date: Tue, 22 Nov 2011 16:33:21 +0100
Message-ID: <4ECBC0C1.7080904@stericsson.com>
References: <4ECBA3B1.1010808@stericsson.com> <87ty5w2rha.fsf@laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog101.obsmtp.com ([207.126.144.111]:57450 "EHLO
	eu1sys200aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757007Ab1KVPdv (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 22 Nov 2011 10:33:51 -0500
In-Reply-To: <87ty5w2rha.fsf@laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "eliad@wizery.com" <eliad@wizery.com>, "nico@fluxnic.net" <nico@fluxnic.net>

Hi Chris,

Thanks for the quick reply! I understand the idea better now. Just a 
minor follow-up question..

The power_restore function for sdio also uses this flag, which is a 
little bit strange I think. Especially since the mmc_power_off|up is 
always called no matter of the value of this flag.

Br
Ulf Hansson

Chris Ball wrote:
> Hi,
> 
> On Tue, Nov 22 2011, Ulf Hansson wrote:
>> Hi,
>>
>> In mmc_resume_host we clear the MMC_PM_KEEP_POWER flag from the
>> pm_flags bitfield. This is done by a patch from Eliad Peller a while
>> ago, "mmc: clear MMC_PM_KEEP_POWER flag on resume"
>>
>> I would like to understand if there are any reason to why we want to
>> clear this flag after we done a resume. I think it will add complexity
>> to an sdio function driver since it must update this flag for after
>> each suspend/resume sequence. Should it not just be enough to do this
>> during the initialization of the sdio func driver.
> 
> The sdio function driver should just call sdio_set_host_pm_flags() in
> its suspend function, if it wants to stay awake at the next suspend.
> It's just one line of code, so I don't think it's overly complex.
> 
> We clear the flag because that's how the API is defined --
> sdio_set_host_pm_flags() says "This must be called, if needed, each
> time the suspend method of the function driver is called".
> 
> There's a separate question of "Why is the API this way, and should
> we change it?".  I think the API ended up this way because it was
> created for a wifi device where a suspend would usually happen while
> you're unassociated, so you don't need to preserve power (because
> nothing interesting can happen to wake you up), but will sometimes
> happen while you're associated, in which case you do.  It sounds like
> you're considering a device that *always* wants to stay awake, which
> is different to the rest of the users of this API.
> 
> But it's just the difference between (your proposal) having
> sdio_set_host_pm_flags() be called during init, and (the API) having
> sdio_set_host_pm_flags() be called during suspend.  It's the same
> line of code either way, so I don't see why it's annoying this way.
> 
> Thanks,
> 
> - Chris.

