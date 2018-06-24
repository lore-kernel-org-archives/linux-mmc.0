From: Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>
Subject: Suspend of SDIO function devices
Date: Sun, 24 Jun 2018 22:46:39 +0200
Message-ID: <b8a41e3a-7100-ae17-1275-d1b40a026201@zonque.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Language: en-US
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Chris Ball <chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org>
Cc: "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "libertas-dev-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <libertas-dev-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "netdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <netdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Hi,

I'm currently looking into the suspend callbacks of drivers of hardware 
that use an SDIO interface, specifically the libertas_sdio driver:

    drivers/net/wireless/marvell/libertas/if_sdio.c

The comments in if_sdio_suspend() suggest that by returning -ENOSYS due 
to runtime-dependant circumstances, the MMC core will remove the card 
entirely at suspend time. I then searched for the bits that do that and 
failed, until I came across this old commit, which first appeared in 3.16:

    573185cc7e6 mmc: core: Invoke sdio func driver's PM callbacks from 
the sdio bus

Before that commit, the mmc core did in fact invoke the card's 
.suspend() callback manually and if it returned a non-zero result, it 
would remove the card. Now that the generic pm functions are in place, 
this does no longer happen because the host and its clients are 
independent entities. Consequently, systems fail to suspend when the 
libertas_sdio module is loaded.

The pm notifier code in drivers/mmc/core/core.c does still handle cases 
where no pm functions are provided at all (in which case it removes the 
card), but it doesn't handle -ENOSYS return values at runtime.

Now I'm wondering how this is supposed to work, and which end needs 
fixing. The mmc/sdio core by restoring the old logic from before 
573185cc7e6, or the libertas driver.

The platform I'm working on does not retain power for the SDIO slaves, 
so a complete re-init is necessary after resume.

Please advise, I'm happy to test approaches and send patches.


Thanks,
Daniel
