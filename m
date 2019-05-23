From: Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Subject: RE: [PATCH v3 3/3] mmc: renesas_sdhi: use multiple segments if
	possible
Date: Thu, 23 May 2019 04:15:58 +0000
Message-ID: <OSAPR01MB30890D412403BE3DF5C34D6BD8010@OSAPR01MB3089.jpnprd01.prod.outlook.com>
References: <1558520319-16452-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
	<1558520319-16452-4-git-send-email-yoshihiro.shimoda.uh@renesas.com>
	<20190522122901.GA4583@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20190522122901.GA4583-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Content-Language: ja-JP
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Christoph Hellwig <hch-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Cc: "linux-block-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-block-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "wsa+renesas-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org" <wsa+renesas-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Hi Christoph,

Thank you for your review!

> From: Christoph Hellwig, Sent: Wednesday, May 22, 2019 9:29 PM
> 
> On Wed, May 22, 2019 at 07:18:39PM +0900, Yoshihiro Shimoda wrote:
> > In IOMMU environment, since it's possible to merge scatter gather
> > buffers of memory requests to one iova, this patch changes the max_segs
> > value when init_card of mmc_host timing to improve the transfer
> > performance on renesas_sdhi_internal_dmac.
> 
> Well, you can't merge everything with an IOMMU.  For one not every
> IOMMU can merge multiple scatterlist segments,

I didn't know such IOMMU exists. But, since R-Car Gen3 IOMMU device
(handled by ipmmu-vmsa.c) can merge multiple scatterlist segments,
should this mmc driver check whether the IOMMU device is used or not somehow?

> second even it can merge
> segements the segments need to be aligned to the IOMMU page size.

If this driver checks whether the segments are aligned to the IOMMU
page size before DMA API is called every time, is it acceptable?
If one of the segments is not aligned, this driver should not use
the DMAC.

>  And
> then of course we might have an upper limit on the total mapping.

IIUC, if such a case, DMA API will fail. What do you think?

> > +	if (host->pdata->max_segs < SDHI_MAX_SEGS_IN_IOMMU &&
> > +	    host->pdev->dev.iommu_group &&
> > +	    (mmc_card_mmc(card) || mmc_card_sd(card)))
> > +		host->mmc->max_segs = SDHI_MAX_SEGS_IN_IOMMU;
> 
> This is way to magic.  We'll need a proper DMA layer API to expose
> this information, and preferably a block layer helper to increase
> max_segs instead of hacking that up in the driver.

I think I should have described the detail somewhere. This can expose
this information to a block layer by using blk_queue_max_segments()
that mmc_setup_queue() calls. In other words, this init_card() ops
is called before a block device is created. Is this acceptable if
such a comment is described here?

Best regards,
Yoshihiro Shimoda
