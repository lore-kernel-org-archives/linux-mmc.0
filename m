From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: RE: [PATCH 2/3] sdhci-s3c: add support for the non standard minimal
	clock value
Date: Mon, 12 Jul 2010 12:16:34 +0200
Message-ID: <000001cb21ab$525bc020$f7134060$%szyprowski@samsung.com>
References: <1276670996-17729-1-git-send-email-m.szyprowski@samsung.com>
 <1276670996-17729-3-git-send-email-m.szyprowski@samsung.com>
 <20100709141903.d883ad05.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <20100709141903.d883ad05.akpm@linux-foundation.org>
Content-language: pl
Sender: linux-samsung-soc-owner@vger.kernel.org
To: 'Andrew Morton' <akpm@linux-foundation.org>
Cc: kgene.kim@samsung.com, 'Anton Vorontsov' <avorontsov@mvista.com>, linux-mmc@vger.kernel.org, kyungmin.park@samsung.com, linux-samsung-soc@vger.kernel.org, ben-linux@fluff.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

Hello,

On Friday, July 09, 2010 11:19 PM Andrew Morton wrote:

> On Wed, 16 Jun 2010 08:49:55 +0200
> Marek Szyprowski <m.szyprowski@samsung.com> wrote:
> 
> > S3C SDHCI host controller can change the source for generating mmc clock.
> > By default host bus clock is used, what causes some problems on machines
> > with 133MHz bus, because the SDHCI divider cannot be as high get proper
> > clock value for identification mode. This is not a problem for the
> > controller, because it can generate lower frequencies from other clock
> > sources. This patch adds a new quirk to SDHCI driver to calculate the
> > minimal supported clock frequency.
> >
> > This fixes the flood of the following warnings on Samsung S5PV210 SoCs:
> > mmc0: Minimum clock frequency too high for identification mode
> >
> > Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> > Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> > ---
> >  drivers/mmc/host/sdhci-of-esdhc.c |    1 +
> >  drivers/mmc/host/sdhci-s3c.c      |   29 +++++++++++++++++++++++++++++
> >  drivers/mmc/host/sdhci.c          |    2 +-
> >  drivers/mmc/host/sdhci.h          |    2 ++
> >  4 files changed, 33 insertions(+), 1 deletions(-)
> 
> This patch doesn't know about Anton's
> sdhci-pltfm-add-support-for-cns3xxx-soc-devices.patch.  Please check my
> fixup:
> 
> --- a/drivers/mmc/host/sdhci-cns3xxx.c~sdhci-s3c-add-support-for-the-non-
> standard-minimal-clock-value-fix
> +++ a/drivers/mmc/host/sdhci-cns3xxx.c
> @@ -93,5 +93,6 @@ struct sdhci_pltfm_data sdhci_cns3xxx_pd
>  		  SDHCI_QUIRK_INVERTED_WRITE_PROTECT |
>  		  SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN |
>  		  SDHCI_QUIRK_BROKEN_TIMEOUT_VAL |
> +		  SDHCI_QUIRK_NONSTANDARD_MINCLOCK |
>  		  SDHCI_QUIRK_NONSTANDARD_CLOCK,
>  };

cns3xxx-soc shdci implementation does not provide get_min_clock callback,
although it uses non standard clock management. In this case it doesn't
matter if this quirk is set or not - in both cases the min clock value is
calculated by default formula: host->max_clk/256.

I would prefer not to set this quirk for cns3xxx-soc to make the code easier
to understand.

Best regards
--
Marek Szyprowski
Samsung Poland R&D Center
