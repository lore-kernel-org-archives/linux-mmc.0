From: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v3 07/12] dma: edma: Add function to dump a PaRAM set
	from PaRAM
Date: Mon, 12 Aug 2013 11:22:36 +0530
Message-ID: <52087824.60002@ti.com>
References: <1375719297-12871-1-git-send-email-joelf@ti.com>
	<1375719297-12871-8-git-send-email-joelf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <1375719297-12871-8-git-send-email-joelf-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: Joel Fernandes <joelf-l0cyMroinI0@public.gmane.org>
Cc: Mark Brown <broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Sricharan R <r.sricharan-l0cyMroinI0@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org>, Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Rajendra Nayak <rnayak-l0cyMroinI0@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Jason Kridner <jkridner-hcmAuCOw+vXj4SYmN/TMmA@public.gmane.org>, Linux OMAP List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux ARM Kernel List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Linux DaVinci Kernel List <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>, Balaji TK <balajitk-l0cyMroinI0@public.gmane.org>, Linux MMC List <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Santosh Shilimkar <santosh.shilim>
List-Id: linux-mmc@vger.kernel.org

On Monday 05 August 2013 09:44 PM, Joel Fernandes wrote:
> Previously, such a dump function was used but it wasn't reading
> from the PaRAM, rather just from a edmacc_param structure, we
> add a helpful function for debugging that directly reads from
> the PaRAM and gives the current state correctly (including links
> and interrupt information).
> 
> Signed-off-by: Joel Fernandes <joelf-l0cyMroinI0@public.gmane.org>

You should convert existing instances of PaRAM set dump to use this new
function along with introducing it.

Thanks,
Sekhar

> ---
>  drivers/dma/edma.c |   31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
> 
> diff --git a/drivers/dma/edma.c b/drivers/dma/edma.c
> index 080d669..a242269 100644
> --- a/drivers/dma/edma.c
> +++ b/drivers/dma/edma.c
> @@ -102,6 +102,37 @@ static void edma_desc_free(struct virt_dma_desc *vdesc)
>  	kfree(container_of(vdesc, struct edma_desc, vdesc));
>  }
>  
> +static inline void dump_pset(struct edma_chan *echan, int slot,
> +		     struct edmacc_param *pset_unused, int pset_idx)
> +{
> +	struct edmacc_param pset_local, *pset;
> +	pset = &pset_local;
> +
> +	edma_read_slot(slot, pset);
> +
> +	dev_dbg(echan->vchan.chan.device->dev,
> +		"\n pset[%d]:\n"
> +		"  chnum\t%d\n"
> +		"  slot\t%d\n"
> +		"  opt\t%08x\n"
> +		"  src\t%08x\n"
> +		"  dst\t%08x\n"
> +		"  abcnt\t%08x\n"
> +		"  ccnt\t%08x\n"
> +		"  bidx\t%08x\n"
> +		"  cidx\t%08x\n"
> +		"  lkrld\t%08x\n",
> +		pset_idx, echan->ch_num, slot,
> +		pset[0].opt,
> +		pset[0].src,
> +		pset[0].dst,
> +		pset[0].a_b_cnt,
> +		pset[0].ccnt,
> +		pset[0].src_dst_bidx,
> +		pset[0].src_dst_cidx,
> +		pset[0].link_bcntrld);
> +}
> +
>  /* Dispatch a queued descriptor to the controller (caller holds lock) */
>  static void edma_execute(struct edma_chan *echan)
>  {
> 
