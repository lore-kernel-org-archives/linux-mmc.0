From: Ulf Hansson <ulf.hansson@stericsson.com>
Subject: Re: [Query] mmc: core "MMC_PM_KEEP_POWER"
Date: Wed, 23 Nov 2011 09:53:44 +0100
Message-ID: <4ECCB498.4070809@stericsson.com>
References: <4ECBA3B1.1010808@stericsson.com> <87ty5w2rha.fsf@laptop.org>	<4ECBC0C1.7080904@stericsson.com> <87hb1w2m29.fsf@laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog102.obsmtp.com ([207.126.144.113]:37261 "EHLO
	eu1sys200aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750864Ab1KWIyp (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 23 Nov 2011 03:54:45 -0500
In-Reply-To: <87hb1w2m29.fsf@laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "eliad@wizery.com" <eliad@wizery.com>, "nico@fluxnic.net" <nico@fluxnic.net>

Chris Ball wrote:
> Hi Ulf,
> 
> On Tue, Nov 22 2011, Ulf Hansson wrote:
>> Thanks for the quick reply! I understand the idea better now. Just a
>> minor follow-up question..
>>
>> The power_restore function for sdio also uses this flag, which is a
>> little bit strange I think.
> 
> Yeah, it's being used to detect whether we're in the middle of a powered
> resume, and therefore shouldn't be trying to reinit the card.  Then the
> value of MMC_PM_KEEP_POWER gets reset once the resume's finished.
> 
>> Especially since the mmc_power_off|up is always called no matter of
>> the value of this flag.
> 
> Hm, I don't think that's true.

I were thinking of mmc_power_save|restore_host, those functions is 
always doing power_off|on.


> 
> mmc_suspend_host() checks !mmc_card_keep_power(host) before mmc_power_off()
> mmc_resume_host() checks !mmc_card_keep_power(host) before mmc_power_up()
> 
> static inline int mmc_card_keep_power(struct mmc_host *host)
> {
>         return host->pm_flags & MMC_PM_KEEP_POWER;
> }
> 
> Thanks,
> 
> - Chris.

BR
Uffe

