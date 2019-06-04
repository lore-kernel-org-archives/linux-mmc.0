From: Baolin Wang <baolin.wang@linaro.org>
Subject: Re: [PATCH 4/9] mmc: sdhci-sprd: Implement the get_max_timeout_count()
 interface
Date: Tue, 4 Jun 2019 16:03:18 +0800
Message-ID: <CAMz4kuKEOQwOK2Yh+y+-ZhZDndA2tf9V45J_o-OittuSRJcurQ@mail.gmail.com>
References: <cover.1558346019.git.baolin.wang@linaro.org> <ae6e23d4de6bb25cd697412f1402036d5ecc9843.1558346019.git.baolin.wang@linaro.org>
 <ed5bdd08-7227-4d55-23de-e78e15d315c7@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <ed5bdd08-7227-4d55-23de-e78e15d315c7@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Chunyan Zhang <zhang.lyra@gmail.com>, Orson Zhai <orsonzhai@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, Vincent Guittot <vincent.guittot@linaro.org>, arm-soc <arm@kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-mmc <linux-mmc@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, DTML <devicetree@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Mon, 3 Jun 2019 at 20:35, Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 20/05/19 1:11 PM, Baolin Wang wrote:
> > Implement the get_max_timeout_count() interface to set the Spredtrum SD
> > host controller actual maximum timeout count.
> >
> > Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
>
> Seems surprising that there isn't a custom ->set_timeout() as well.

Until now we did not find issues when using sdhci_calc_timeout().
Thanks for your reviewing.

> Nevertheless:
>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
>
> > ---
> >  drivers/mmc/host/sdhci-sprd.c |    7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.c
> > index 31ba7d6..d91281d 100644
> > --- a/drivers/mmc/host/sdhci-sprd.c
> > +++ b/drivers/mmc/host/sdhci-sprd.c
> > @@ -285,6 +285,12 @@ static void sdhci_sprd_hw_reset(struct sdhci_host *host)
> >       usleep_range(300, 500);
> >  }
> >
> > +static unsigned int sdhci_sprd_get_max_timeout_count(struct sdhci_host *host)
> > +{
> > +     /* The Spredtrum controller actual maximum timeout count is 1 << 31 */
> > +     return 1 << 31;
> > +}
> > +
> >  static struct sdhci_ops sdhci_sprd_ops = {
> >       .read_l = sdhci_sprd_readl,
> >       .write_l = sdhci_sprd_writel,
> > @@ -296,6 +302,7 @@ static void sdhci_sprd_hw_reset(struct sdhci_host *host)
> >       .reset = sdhci_reset,
> >       .set_uhs_signaling = sdhci_sprd_set_uhs_signaling,
> >       .hw_reset = sdhci_sprd_hw_reset,
> > +     .get_max_timeout_count = sdhci_sprd_get_max_timeout_count,
> >  };
> >
> >  static void sdhci_sprd_request(struct mmc_host *mmc, struct mmc_request *mrq)
> >
>


-- 
Baolin Wang
Best Regards
