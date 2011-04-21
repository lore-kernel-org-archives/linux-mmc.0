From: Shawn Guo <shawn.guo-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: Re: [PATCH 2/5] mmc: sdhci: eliminate sdhci_of_host and sdhci_of_data
Date: Thu, 21 Apr 2011 16:10:39 +0800
Message-ID: <20110421081038.GE4024@S2100-06.ap.freescale.net>
References: <1301042931-4869-1-git-send-email-shawn.guo@linaro.org>
	<1301042931-4869-3-git-send-email-shawn.guo@linaro.org>
	<20110419102053.GC4164@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20110419102053.GC4164-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Unsubscribe: <http://lists.linaro.org/mailman/options/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linaro.org/pipermail/linaro-dev>
List-Post: <mailto:linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
List-Help: <mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linaro.org/mailman/listinfo/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=subscribe>
Sender: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
Errors-To: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

On Tue, Apr 19, 2011 at 12:20:53PM +0200, Wolfram Sang wrote:
> On Fri, Mar 25, 2011 at 04:48:48PM +0800, Shawn Guo wrote:
> > The patch is to migrate the use of sdhci_of_host and sdhci_of_data
> > to sdhci_pltfm_host and sdhci_pltfm_data, so that the former pair can
> > be eliminated.
> > 
> > Signed-off-by: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> > ---
> 
> [...]
> 
> > diff --git a/drivers/mmc/host/sdhci-pltfm.h b/drivers/mmc/host/sdhci-pltfm.h
> > index a3e4be0..12afe86 100644
> > --- a/drivers/mmc/host/sdhci-pltfm.h
> > +++ b/drivers/mmc/host/sdhci-pltfm.h
> > @@ -19,6 +19,10 @@
> >  struct sdhci_pltfm_host {
> >  	struct clk *clk;
> >  	u32 scratchpad; /* to handle quirks across io-accessor calls */
> > +
> > +	/* migrate from sdhci_of_host */
> > +	unsigned int clock;
> > +	u16 xfer_mode_shadow;
> 
> xfer_mode_shadow can be merged into scratchpad. They both fix the same
> issue.
> 
Yeah.

-- 
Regards,
Shawn
