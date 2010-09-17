From: Kukjin Kim <kgene.kim@samsung.com>
Subject: RE: [PATCH 5/5] sdhci-s3c: Add support no internal clock divider in
 host controller
Date: Fri, 17 Sep 2010 10:18:59 +0900
Message-ID: <03a201cb5606$5244bc60$f6ce3520$%kim@samsung.com>
References: <1284626223-18944-1-git-send-email-jeongbae.seo@samsung.com>
 <1284626223-18944-6-git-send-email-jeongbae.seo@samsung.com>
 <AANLkTik23B23RW_kmjaL1PeXNiWtU01aNBwUOPrac6HF@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7BIT
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <AANLkTik23B23RW_kmjaL1PeXNiWtU01aNBwUOPrac6HF@mail.gmail.com>
Content-language: ko
Sender: linux-samsung-soc-owner@vger.kernel.org
To: 'Kyungmin Park' <kmpark@infradead.org>, 'Jeongbae Seo' <jeongbae.seo@samsung.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-mmc@vger.kernel.org, ben-linux@fluff.org, akpm@linux-foundation.org, 'Hyuk Lee' <hyuk1.lee@samsung.com>, 'Chris Ball' <cjb@laptop.org>, =?UTF-8?B?J+ygleyerO2biCc=?= <jh80.chung@samsung.com>
List-Id: linux-mmc@vger.kernel.org

Kyungmin Park wrote:
> 
> Hi,
> 
> Well there are two implementations. and no conclusion yet.
> as s5pc210 don't support internal SDHCI clock, DMC overrides the
> function operation itself when s5pc210. System LSI use the quirks.
> 
I think, this approach is better. Because no added new quirk and no override any function operation.

Actually, used SDHCI_QUIRK_NONSTANDARD_CLOCK quirk to support SDMMC host controller of S5PV310/S5PC210 which does not have internal clock divider in it.

But need to re-submit to two separate patches which one is adding support no internal clock divider and other is adding 'pdata->host_caps' feature.

Chris, how do you think this approach?

> Choose any one from MMC maintainer.
> 
> Thank you,
> Kyungmin Park
> 
> On Thu, Sep 16, 2010 at 5:37 PM, Jeongbae Seo <jeongbae.seo@samsung.com>
> wrote:
> > From: Hyuk Lee <hyuk1.lee@samsung.com>
> >
> > This patch adds to support no internal clock divider in SDHCI.
> > The external clock divider can be used to make a proper clock
> > because SDHCI doesn't support internal clock divider by itself.
> >
> > Signed-off-by: Hyuk Lee <hyuk1.lee@samsung.com>
> > Signed-off-by: Jeongbae Seo <jeongbae.seo@samsung.com>
> > ---
> >  drivers/mmc/host/sdhci-s3c.c |   63
> ++++++++++++++++++++++++++++++++++++++++++
> >  1 files changed, 63 insertions(+), 0 deletions(-)
> >
> > diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
> > index 71ad416..6160960 100644
> > --- a/drivers/mmc/host/sdhci-s3c.c
> > +++ b/drivers/mmc/host/sdhci-s3c.c
> > @@ -96,6 +96,13 @@ static unsigned int sdhci_s3c_get_max_clk(struct
> sdhci_host *host)
> >        unsigned int rate, max;
> >        int clk;
> >
> > +       /*
> > +        * There is only one clock source(sclk) if there is no clock divider
> > +        * in the host controller
> > +        */
> > +       if (host->quirks & SDHCI_QUIRK_NONSTANDARD_CLOCK)
> > +               return clk_round_rate(ourhost->clk_bus[2], UINT_MAX);
> No hard-coded index.

Always, it is #2.

(snip)

> > +       /*
> > +        * There is only one clock source(sclk) if there is no clock divider
> > +        * in the host controller
> > +        */
> > +       if (host->quirks & SDHCI_QUIRK_NONSTANDARD_CLOCK)
> > +               return clk_round_rate(ourhost->clk_bus[2], 400000);
> ditto

Same.

(snip)

> > +       /*
> > +        * If controller does not have internal clock divider,
> > +        * we need to use another method with setup a quirk.
> > +        */
> > +       if (pdata->clk_type)
> check the clk_type with external

I think no need to check it.
Because in the general case, pdata->clk_type is 0, S3C_SDHCI_CLK_DIV_INTERNAL.

But if we want to add new another clock type, checking it is better...but no need now.

> > +               host->quirks |= SDHCI_QUIRK_NONSTANDARD_CLOCK;
> > +
> > +       if (pdata->host_caps)
> > +               host->mmc->caps |= pdata->host_caps;
> > +
> >        ret = sdhci_add_host(host);
> >        if (ret) {
> >                dev_err(dev, "sdhci_add_host() failed\n");
> > --

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
