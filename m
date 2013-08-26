From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: RE: [PATCH 1/3] mmc: core: do power-off with resume failure
Date: Mon, 26 Aug 2013 19:56:17 +0900
Message-ID: <002f01cea24a$e3d99450$ab8cbcf0$%jun@samsung.com>
References: <002201ce9e6b$e0b32850$a21978f0$%jun@samsung.com>
 <CAPDyKFq2uXxsjMZcKK=u0dNJnw5fXj5L0=Rd=OP=nk41Zadong@mail.gmail.com>
 <002701cea226$ff998070$fecc8150$%jun@samsung.com>
 <CAPDyKFpDEt-aMUBQPtMytSYYVasO_a56+j397v9P2SmVNTwfdQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=Windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:21774 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755268Ab3HZK4T (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 26 Aug 2013 06:56:19 -0400
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MS400ITLX1T0S00@mailout2.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 26 Aug 2013 19:56:18 +0900 (KST)
In-reply-to: <CAPDyKFpDEt-aMUBQPtMytSYYVasO_a56+j397v9P2SmVNTwfdQ@mail.gmail.com>
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Ulf Hansson' <ulf.hansson@linaro.org>
Cc: 'linux-mmc' <linux-mmc@vger.kernel.org>, 'Chris Ball' <cjb@laptop.org>

On Mon, August 26, 2013, Ulf Hansson wrote:
> On 26 August 2013 08:39, Seungwon Jeon <tgih.jun@samsung.com> wrote:
> > On Friday, August 23, 2013, Ulf Hansson wrote:
> >> On 21 August 2013 14:42, Seungwon Jeon <tgih.jun@samsung.com> wrote:
> >> > Currently there is no mmc_power_off() when resume failed.
> >> > Somehow, state from mmc_power_on() will be kept. This change
> >> > makes a pair with its use in case of failure.
> >>
> >> Hi Seungwon,
> >>
> >> To be safe, we can not power off, even if a resume failures. The
> >> reason is that the bus/card/host is still available for sending
> >> commands to it and those will then likely hang since IP controllers
> >> internal registers is configured for "power off" state.
> > Generally when host drivers get MMC_POWER_OFF, host doesn't gate clock for host running.
> > MMC_POWER_ON/OFF is related to card side. So, I guess hanging isn't expected because host is kept
> ready.
> 
> At least for mmci host driver a hang may happen. Internal IP registers
> needs to be set properly as done for MMC_POWER_ON mode, otherwise a
> cmd can not be sent to the card without a potential hang, forever
> waiting for an interrupt.
I looked into the set_ios function of mmci host.
Power for I/O bus lines are controlled there. Then unexpected occurrence from host may be possible.
Host can raise interrupt though.
Ok.

Thanks,
Seungwon Jeon

> 
> I would be surprised if similar issues could not occur for other host
> controllers/drivers.
> 
> Kind regards
> Ulf Hansson
> 
> >
> >>
> >> Instead, we must leave the power off to be handled from the next
> >> rescan work when the card is no longer properly "detected". For
> >> NONREMOVABLE we will instead at error path try to do a
> >> "power_restore_host".
> > It might be needed graceful error handling.
> > Ok, I'll consider further.
> >
> > Thanks,
> > Seungwon Jeon
> >
> >>
> >> Kind regards
> >> Ulf Hansson
> >>
> >>
> >> >
> >> > Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
> >> > ---
> >> >  drivers/mmc/core/mmc.c  |    3 +++
> >> >  drivers/mmc/core/sd.c   |    3 +++
> >> >  drivers/mmc/core/sdio.c |    3 +++
> >> >  3 files changed, 9 insertions(+), 0 deletions(-)
> >> >
> >> > diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> >> > index 6d02012..704a561 100644
> >> > --- a/drivers/mmc/core/mmc.c
> >> > +++ b/drivers/mmc/core/mmc.c
> >> > @@ -1536,6 +1536,9 @@ static int mmc_resume(struct mmc_host *host)
> >> >         mmc_power_up(host);
> >> >         mmc_select_voltage(host, host->ocr);
> >> >         err = mmc_init_card(host, host->ocr, host->card);
> >> > +       if (err)
> >> > +               mmc_power_off(host);
> >> > +
> >> >         mmc_release_host(host);
> >> >
> >> >         return err;
> >> > diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
> >> > index 176d125..2690ae1 100644
> >> > --- a/drivers/mmc/core/sd.c
> >> > +++ b/drivers/mmc/core/sd.c
> >> > @@ -1099,6 +1099,9 @@ static int mmc_sd_resume(struct mmc_host *host)
> >> >         mmc_power_up(host);
> >> >         mmc_select_voltage(host, host->ocr);
> >> >         err = mmc_sd_init_card(host, host->ocr, host->card);
> >> > +       if (err)
> >> > +               mmc_power_off(host);
> >> > +
> >> >         mmc_release_host(host);
> >> >
> >> >         return err;
> >> > diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
> >> > index 80d89cf..8c65669 100644
> >> > --- a/drivers/mmc/core/sdio.c
> >> > +++ b/drivers/mmc/core/sdio.c
> >> > @@ -1033,6 +1033,9 @@ static int mmc_sdio_resume(struct mmc_host *host)
> >> >                 }
> >> >         }
> >> >
> >> > +       if (err && !mmc_card_keep_power(host))
> >> > +               mmc_power_off(host);
> >> > +
> >> >         host->pm_flags &= ~MMC_PM_KEEP_POWER;
> >> >         return err;
> >> >  }
> >> > --
> >> > 1.7.0.4
> >> >
> >> >
> >> > --
> >> > To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> >> > the body of a message to majordomo@vger.kernel.org
> >> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> >> the body of a message to majordomo@vger.kernel.org
> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

