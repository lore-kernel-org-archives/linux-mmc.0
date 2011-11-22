From: Chris Ball <cjb@laptop.org>
Subject: Re: [Query] mmc: core "MMC_PM_KEEP_POWER"
Date: Tue, 22 Nov 2011 10:50:38 -0500
Message-ID: <87hb1w2m29.fsf@laptop.org>
References: <4ECBA3B1.1010808@stericsson.com> <87ty5w2rha.fsf@laptop.org>
	<4ECBC0C1.7080904@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:51316 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756752Ab1KVPup (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 22 Nov 2011 10:50:45 -0500
In-Reply-To: <4ECBC0C1.7080904@stericsson.com> (Ulf Hansson's message of "Tue,
	22 Nov 2011 16:33:21 +0100")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@stericsson.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "eliad@wizery.com" <eliad@wizery.com>, "nico@fluxnic.net" <nico@fluxnic.net>

Hi Ulf,

On Tue, Nov 22 2011, Ulf Hansson wrote:
> Thanks for the quick reply! I understand the idea better now. Just a
> minor follow-up question..
>
> The power_restore function for sdio also uses this flag, which is a
> little bit strange I think.

Yeah, it's being used to detect whether we're in the middle of a powered
resume, and therefore shouldn't be trying to reinit the card.  Then the
value of MMC_PM_KEEP_POWER gets reset once the resume's finished.

> Especially since the mmc_power_off|up is always called no matter of
> the value of this flag.

Hm, I don't think that's true.

mmc_suspend_host() checks !mmc_card_keep_power(host) before mmc_power_off()
mmc_resume_host() checks !mmc_card_keep_power(host) before mmc_power_up()

static inline int mmc_card_keep_power(struct mmc_host *host)
{
        return host->pm_flags & MMC_PM_KEEP_POWER;
}

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
