From: Chunyan Zhang <zhang.lyra@gmail.com>
Subject: Re: [PATCH] mmc: sdhci: use goto rather than return directly
Date: Wed, 17 Oct 2018 10:35:51 +0800
Message-ID: <CAAfSe-sX3yx4K5WP_yT3TP7aiL-EOJinvkgL63TdUKZh3Emv1g@mail.gmail.com>
References: <1539677982-13762-1-git-send-email-zhang.chunyan@linaro.org> <88801a36-44cf-237f-a762-985bb215c104@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <88801a36-44cf-237f-a762-985bb215c104@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Chunyan Zhang <zhang.chunyan@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linus.walleij@linaro.org
List-Id: linux-mmc@vger.kernel.org

On Tue, 16 Oct 2018 at 16:30, Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 16/10/18 11:19 AM, Chunyan Zhang wrote:
> > The driver should clean resources requested in the function before
> > unnormal return.
> >
> > CC: Linus Walleij <linus.walleij@linaro.org>
> > Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org>
> > Fixes: bd9b902798ab ("mmc: sdhci: Implement an SDHCI-specific bounce buffer")
> > ---
> >  drivers/mmc/host/sdhci.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> > index 1b3fbd9..f6b57e1 100644
> > --- a/drivers/mmc/host/sdhci.c
> > +++ b/drivers/mmc/host/sdhci.c
> > @@ -3991,7 +3991,7 @@ int sdhci_setup_host(struct sdhci_host *host)
> >               /* This may alter mmc->*_blk_* parameters */
> >               ret = sdhci_allocate_bounce_buffer(host);
>
> Do we need the error return?  It seems to be zero always.

Or we don't need to check 'ret' for now, right?

>
> >               if (ret)
> > -                     return ret;
> > +                     goto unreg;
> >       }
> >
> >       return 0;
> >
>
