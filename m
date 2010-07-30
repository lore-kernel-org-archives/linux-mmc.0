From: Anton Vorontsov <cbouatmailru@gmail.com>
Subject: Re: [PATCH 3/3] mmc: Add ESDHC weird register workaround
Date: Fri, 30 Jul 2010 11:37:31 +0400
Message-ID: <20100730073731.GA26137@oksana.dev.rtsoft.ru>
References: <1280296461-17077-1-git-send-email-tie-fei.zang@freescale.com>
	<20100728080312.GA16994@oksana.dev.rtsoft.ru>
	<83024545B35D6445A690EFD603E7869A0512E0@zch01exm23.fsl.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
Content-Disposition: inline
In-Reply-To: <83024545B35D6445A690EFD603E7869A0512E0@zch01exm23.fsl.freescale.net>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Sender: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
To: Zang Roy-R61911 <r61911@freescale.com>
Cc: linuxppc-dev@ozlabs.org, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Wed, Jul 28, 2010 at 05:43:00PM +0800, Zang Roy-R61911 wrote:
[...]
> > > +	/* The default value of DMAS bits of Protocol Control 
> > Register is not
> > > +	 * correct. clear these two bits to use simple DMA */
> > > +#define  ESDHCI_CTRL_DMAS_MASK		0xFFFFFCFF
> > > +	if (host->quirks & SDHCI_QUIRK_QORIQ_REG_WEIRD) {
> > > +		ctrl = sdhci_readl(host, SDHCI_HOST_CONTROL);
> > > +		ctrl = ctrl & ESDHCI_CTRL_DMAS_MASK;
> > > +		sdhci_writel(host, ctrl, SDHCI_HOST_CONTROL);
> > > +	}
> > 
> > You should implement register quirks via SDHCI IO accessors.
> What does you mean "SDHCI IO accessors?

See drivers/mmc/host/sdhci-of-esdhc.c

struct sdhci_of_data sdhci_esdhc = {
...
        .ops = {
...
                .write_l = sdhci_be32bs_writel,
...
        },
};

You can implement your own write_l and put the quirk in
there, as we do for esdhc_readw, esdhc_writew, etc.

OTOH, as you say it has wrong default value, not behaviour,
so I think you can just initialize the HOST_CONTROL register
just once somewhere in sdhci-of-esdhc, e.g. ->enable_dma
callback?

> It makes more sense to define something like:
> SDHCI_QUIRK_QORIQ_PROCTL_WEIRD.

I don't think so.

Thanks,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
