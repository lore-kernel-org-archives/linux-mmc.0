From: Peppe CAVALLARO <peppe.cavallaro@st.com>
Subject: Re: [PATCH 2/5] mmc: do not clear the host->pm_flags when suspend
Date: Thu, 11 Nov 2010 08:24:24 +0100
Message-ID: <4CDB9A28.5030408@st.com>
References: <1289402889-14160-1-git-send-email-peppe.cavallaro@st.com>
 <1289402889-14160-2-git-send-email-peppe.cavallaro@st.com>
 <1289402889-14160-3-git-send-email-peppe.cavallaro@st.com>
 <1289402889-14160-4-git-send-email-peppe.cavallaro@st.com>
 <AANLkTik1c0G2HNcXGboP8WA8vo9YvwYkUpM2=MGf-cLW@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog107.obsmtp.com ([207.126.144.123]:59759 "EHLO
	eu1sys200aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750996Ab0KKHYw convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 11 Nov 2010 02:24:52 -0500
In-Reply-To: <AANLkTik1c0G2HNcXGboP8WA8vo9YvwYkUpM2=MGf-cLW@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Hi Ohad,

On 11/10/2010 9:28 PM, Ohad Ben-Cohen wrote:
>
> Hi Giuseppe,
>
> On Wed, Nov 10, 2010 at 5:28 PM, Giuseppe CAVALLARO
> <peppe.cavallaro@st.com> wrote:
> > HC driver will be able to use the pm_flags to
> > undestand if the system can be woken-up by the driver.
> > So the mmc_suspend_host hasn't to reset this field
> > in the host structure.
> >
> > Signed-off-by: Giuseppe Cavallaro <peppe.cavallaro@st.com>
> > ---
> >  drivers/mmc/core/core.c |    1 -
> >  1 files changed, 0 insertions(+), 1 deletions(-)
> >
> > diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> > index 569e94d..6d2d6e4 100644
> > --- a/drivers/mmc/core/core.c
> > +++ b/drivers/mmc/core/core.c
> > @@ -1276,7 +1276,6 @@ int mmc_suspend_host(struct mmc_host *host)
> >                        mmc_claim_host(host);
> >                        mmc_detach_bus(host);
> >                        mmc_release_host(host);
> > -                       host->pm_flags = 0;
>
> This is elapsed because the card is removed at this point (e.g. SDIO
> returned -ENOSYS).
>
> Why would you want to use flags, set by a function driver of an SDIO
> card, that was just removed ?
>
The define MMC_PM_KEEP_POWER has been used to notify that
a device driver (e.g. sdhci-pltfm) want to wakeup the system.
It is set in the pm_flags. When the sdhci suspend is invoked, it can
call the mmc_suspend_host without free the interrupt if
MMC_PM_KEEP_POWER is set.
Then the sdhci_set_wakeup programs the HC to be able to wake up the system.

When the resume is invoked the pm_flags is used to avoid to request the irq.
For this reason I removed the inst "host->pm_flags = 0;" from the
mmc_suspend_host
function. Maybe I could not remove it but add a check if the driver
wants to wakeup
the system and the MMC_PM_KEEP_POWER is set. What do you think?

Thanks
Regards,
Peppe
>
>
> >                        err = 0;
> >                }
> >        }
> > --
> > 1.5.5.6
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >
>
