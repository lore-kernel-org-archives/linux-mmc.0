From: Zang Roy-R61911 <r61911@freescale.com>
Subject: RE: [PATCH 3/3] mmc: Add ESDHC weird register workaround
Date: Wed, 28 Jul 2010 17:43:00 +0800
Message-ID: <83024545B35D6445A690EFD603E7869A0512E0@zch01exm23.fsl.freescale.net>
References: <1280296461-17077-1-git-send-email-tie-fei.zang@freescale.com>
	<20100728080312.GA16994@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
Content-Class: urn:content-classes:message
In-Reply-To: <20100728080312.GA16994@oksana.dev.rtsoft.ru>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Sender: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
To: Anton Vorontsov <cbouatmailru@gmail.com>
Cc: linuxppc-dev@ozlabs.org, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

 

> -----Original Message-----
> From: Anton Vorontsov [mailto:cbouatmailru@gmail.com] 
> Sent: Wednesday, July 28, 2010 16:03 PM
> To: Zang Roy-R61911
> Cc: linux-mmc-approval@vger.kernel.org; linuxppc-dev@ozlabs.org
> Subject: Re: [PATCH 3/3] mmc: Add ESDHC weird register workaround
> 
> On Wed, Jul 28, 2010 at 01:54:21PM +0800, Roy Zang wrote:
> > P4080 ESDHC controller induces weird register setting.
> > This patch adds the workaround to correct the weird 
> register setting.
> > 
> > Signed-off-by: Roy Zang <tie-fei.zang@freescale.com>
> > ---
> >  drivers/mmc/host/sdhci-of-core.c |    5 +++++
> >  drivers/mmc/host/sdhci.c         |   13 +++++++++++++
> >  drivers/mmc/host/sdhci.h         |    2 ++
> >  3 files changed, 20 insertions(+), 0 deletions(-)
> > 
> > diff --git a/drivers/mmc/host/sdhci-of-core.c 
> b/drivers/mmc/host/sdhci-of-core.c
> > index 0c30242..1b6945a 100644
> > --- a/drivers/mmc/host/sdhci-of-core.c
> > +++ b/drivers/mmc/host/sdhci-of-core.c
> > @@ -164,6 +164,11 @@ static int __devinit 
> sdhci_of_probe(struct of_device *ofdev,
> >  	if (sdhci_of_wp_inverted(np))
> >  		host->quirks |= SDHCI_QUIRK_INVERTED_WRITE_PROTECT;
> >  
> > +	if (of_device_is_compatible(np, "fsl,p4080-esdhc")) {
> > +		host->quirks |= SDHCI_QUIRK_QORIQ_REG_WEIRD;
> > +		host->quirks &= ~SDHCI_QUIRK_INVERTED_WRITE_PROTECT;
> 
> You do not mention this change in the patch description, why?
This is not needed any more. Will be removed.
> 
> > +	}
> > +
> >  	clk = of_get_property(np, "clock-frequency", &size);
> >  	if (clk && size == sizeof(*clk) && *clk)
> >  		of_host->clock = *clk;
> > diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> > index 1424d08..b5b3627 100644
> > --- a/drivers/mmc/host/sdhci.c
> > +++ b/drivers/mmc/host/sdhci.c
> > @@ -788,6 +788,15 @@ static void sdhci_prepare_data(struct 
> sdhci_host *host, struct mmc_data *data)
> >  		sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
> >  	}
> >  
> > +	/* The default value of DMAS bits of Protocol Control 
> Register is not
> > +	 * correct. clear these two bits to use simple DMA */
> > +#define  ESDHCI_CTRL_DMAS_MASK		0xFFFFFCFF
> > +	if (host->quirks & SDHCI_QUIRK_QORIQ_REG_WEIRD) {
> > +		ctrl = sdhci_readl(host, SDHCI_HOST_CONTROL);
> > +		ctrl = ctrl & ESDHCI_CTRL_DMAS_MASK;
> > +		sdhci_writel(host, ctrl, SDHCI_HOST_CONTROL);
> > +	}
> 
> You should implement register quirks via SDHCI IO accessors.
What does you mean "SDHCI IO accessors?
It makes more sense to define something like:
SDHCI_QUIRK_QORIQ_PROCTL_WEIRD.
Any comment?

> 
> See esdhc_writew() for example.
> 
> >  	if (!(host->flags & SDHCI_REQ_USE_DMA)) {
> >  		int flags;
> >  
> > @@ -1699,6 +1708,10 @@ int sdhci_add_host(struct sdhci_host *host)
> >  
> >  	caps = sdhci_readl(host, SDHCI_CAPABILITIES);
> >  
> > +	 /* Workaround for P4080 host controller capabilities */
> > +	if (host->quirks & SDHCI_QUIRK_QORIQ_REG_WEIRD)
> > +		caps &= ~(SDHCI_CAN_VDD_180 | SDHCI_CAN_VDD_330);
> 
> Ditto. Make a quirk for cap register. Or implement
> SDHCI_QUIRK_NO_VDD_180 and SDHCI_QUIRK_NO_VDD_300 quirks
> instead.
Second proposal more makes sense to me.
Thanks.
Roy
