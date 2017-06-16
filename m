From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH/RFC 2/5] mmc: tmio: add complete to DMA ops
Date: Fri, 16 Jun 2017 09:09:31 +0200
Message-ID: <CAMuHMdVpE+2QK2WbfyDCCUq1fzHqnuyAKsGgzj+ZonOwc96w3A@mail.gmail.com>
References: <1496927368-18897-1-git-send-email-horms+renesas@verge.net.au>
 <1496927368-18897-4-git-send-email-horms+renesas@verge.net.au>
 <CAMuHMdUkhkDEqsDZUQ94dFnLU+dFcZ+ed=qHokH3sEWGFdkkuw@mail.gmail.com>
 <20170616060602.GA16534@verge.net.au> <CAMuHMdV58Gp+M3eDG3wmgcG6S7L=HBoeFY3gNPVAA1HBWATOcw@mail.gmail.com>
 <20170616070432.GC16534@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-it0-f67.google.com ([209.85.214.67]:32982 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751879AbdFPHJd (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 16 Jun 2017 03:09:33 -0400
In-Reply-To: <20170616070432.GC16534@verge.net.au>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Simon Horman <horms@verge.net.au>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulf.hansson@linaro.org>, Magnus Damm <magnus.damm@gmail.com>, Linux MMC List <linux-mmc@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>

Hi Simon,

On Fri, Jun 16, 2017 at 9:04 AM, Simon Horman <horms@verge.net.au> wrote:
> On Fri, Jun 16, 2017 at 08:25:12AM +0200, Geert Uytterhoeven wrote:
>> On Fri, Jun 16, 2017 at 8:06 AM, Simon Horman <horms@verge.net.au> wrote:
>> > On Fri, Jun 09, 2017 at 09:35:20AM +0200, Geert Uytterhoeven wrote:
>> >> On Thu, Jun 8, 2017 at 3:09 PM, Simon Horman <horms+renesas@verge.net.au> wrote:
>> >> > Add complete to DMA ops to allow DMAC implementation dependent
>> >> > handling of DMA completion.
>> >> >
>> >> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
>> >> > ---
>> >> >  drivers/mmc/host/tmio_mmc.h      |  1 +
>> >> >  drivers/mmc/host/tmio_mmc_core.c | 10 ++++++++--
>> >> >  2 files changed, 9 insertions(+), 2 deletions(-)
>> >> >
>> >> > diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
>> >> > index 9c94b6eb9b49..82725f9de359 100644
>> >> > --- a/drivers/mmc/host/tmio_mmc.h
>> >> > +++ b/drivers/mmc/host/tmio_mmc.h
>> >> > @@ -121,6 +121,7 @@ struct tmio_mmc_dma_ops {
>> >> >                         struct tmio_mmc_data *pdata);
>> >> >         void (*release)(struct tmio_mmc_host *host);
>> >> >         void (*abort)(struct tmio_mmc_host *host);
>> >> > +       void (*complete)(struct tmio_mmc_host *host);
>> >> >  };
>> >> >
>> >> >  struct tmio_mmc_host {
>> >> > diff --git a/drivers/mmc/host/tmio_mmc_core.c b/drivers/mmc/host/tmio_mmc_core.c
>> >> > index 0e76e099dc7f..26fe9bb64849 100644
>> >> > --- a/drivers/mmc/host/tmio_mmc_core.c
>> >> > +++ b/drivers/mmc/host/tmio_mmc_core.c
>> >> > @@ -86,6 +86,12 @@ static inline void tmio_mmc_abort_dma(struct tmio_mmc_host *host)
>> >> >                 host->dma_ops->abort(host);
>> >> >  }
>> >> >
>> >> > +static inline void tmio_mmc_complete_dma(struct tmio_mmc_host *host)
>> >> > +{
>> >> > +       if (host->dma_ops)
>> >> > +               host->dma_ops->complete(host);
>> >>
>> >> I believe this will cause a crash and thus break bisection, as no driver
>> >> fills in the complete pointer yet.
>> >
>> > Indeed. And it seems to cause a panic on non-Gen3 users of the driver.
>> >
>> > I think the fix should be:
>> >
>> > diff --git a/drivers/mmc/host/tmio_mmc_core.c b/drivers/mmc/host/tmio_mmc_core.c
>> > index 26fe9bb64849..9ec2e933b6f0 100644
>> > --- a/drivers/mmc/host/tmio_mmc_core.c
>> > +++ b/drivers/mmc/host/tmio_mmc_core.c
>> > @@ -88,7 +88,7 @@ static inline void tmio_mmc_abort_dma(struct tmio_mmc_host *host)
>> >
>> >  static inline void tmio_mmc_complete_dma(struct tmio_mmc_host *host)
>> >  {
>> > -       if (host->dma_ops)
>> > +       if (host->dma_ops && host->dma_ops->complete)
>> >                 host->dma_ops->complete(host);
>> >  }
>>
>> Is it? Now nothing will be completed?
>>
>> The old code did:
>>
>>      complete(&host->dma_dataend);
>>
>> so perhaps
>>
>>     else
>>             complete(&host->dma_dataend);
>>
>> with the "else" branch to be deleted when all drivers that need it provide
>> their own complete callback?
>
> Thanks, I see that is still a problem.
>
> As there is only one other driver and its closerly related
> perhaps it could just implement the callback in this patch?

Yes, that sounds good to me.
Else you need 3 patches:
  1. Introduced .complete field,
  2. Update driver to provide .complete handledr,
  3. Update generic code.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
