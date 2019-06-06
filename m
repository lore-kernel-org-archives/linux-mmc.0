From: Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Subject: RE: [RFC PATCH v5 3/8] iommu: add a new capable IOMMU_CAP_MERGING
Date: Thu, 6 Jun 2019 05:53:56 +0000
Message-ID: <OSAPR01MB3089C968A7434A635AF5B7C2D8170@OSAPR01MB3089.jpnprd01.prod.outlook.com>
References: <1559733114-4221-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
	<1559733114-4221-4-git-send-email-yoshihiro.shimoda.uh@renesas.com>
	<7dfeb7d8-b777-b4af-d892-2829cd05241b@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <7dfeb7d8-b777-b4af-d892-2829cd05241b-5wv7dgnIgG8@public.gmane.org>
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
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Cc: "ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "wsa+renesas-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org" <wsa+renesas-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "hch-jcswGhMUV9g@public.gmane.org" <hch-jcswGhMUV9g@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Hi Robin,

Thank you for your comments!

> From: Robin Murphy, Sent: Wednesday, June 5, 2019 9:22 PM
<snip>
> > @@ -902,8 +914,18 @@ static int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
> >   	if (iommu_map_sg(domain, iova, sg, nents, prot) < iova_len)
> >   		goto out_free_iova;
> >
> > -	return __finalise_sg(dev, sg, nents, iova);
> > +	ret = __finalise_sg(dev, sg, nents, iova);
> > +	/*
> > +	 * Check whether the sg entry is single if a device requires and
> > +	 * the IOMMU driver has the capable.
> > +	 */
> > +	if (iova_contiguous && ret != 1)
> > +		goto out_unmap_sg;
> 
> I don't see that just failing really gives this option any value.
> Clearly the MMC driver has to do *something* to handle the failure (plus
> presumably the case of not having IOMMU DMA ops at all), which begs the
> question of why it couldn't just do whatever that is anyway, without all
> this infrastructure. For starters, it would be a far simpler and less
> invasive patch:
> 
> 	if (dma_map_sg(...) > 1) {
> 		dma_unmap_sg(...);
> 		/* split into multiple requests and try again */
> 	}

I understood it.

> But then it would make even more sense to just have the driver be
> proactive about its special requirement in the first place, and simply
> validate the list before it even tries to map it:
> 
> 	for_each_sg(sgl, sg, n, i)
> 		if ((i > 0 && sg->offset % PAGE_SIZE) ||
> 		    (i < n - 1 && sg->length % PAGE_SIZE))
> 			/* segment will not be mergeable */

In previous version, I made such a code [1].
But, I think I misunderstood Christoph's comments [2] [3].

[1]
https://patchwork.kernel.org/patch/10970047/

[2]
https://marc.info/?l=linux-renesas-soc&m=155956751811689&w=2

[3]
https://marc.info/?l=linux-renesas-soc&m=155852814607202&w=2

> For reference, I think v4l2 and possibly some areas of DRM already do
> something vaguely similar to judge whether they get contiguous buffers
> or not.

I see. I'll check these areas later.

> > +
> > +	return ret;
> >
> > +out_unmap_sg:
> > +	iommu_dma_unmap_sg(dev, sg, nents, dir, attrs);
> >   out_free_iova:
> >   	iommu_dma_free_iova(cookie, iova, iova_len);
> >   out_restore_sg:
> > diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> > index 91af22a..f971dd3 100644
> > --- a/include/linux/iommu.h
> > +++ b/include/linux/iommu.h
> > @@ -104,6 +104,7 @@ enum iommu_cap {
> >   					   transactions */
> >   	IOMMU_CAP_INTR_REMAP,		/* IOMMU supports interrupt isolation */
> >   	IOMMU_CAP_NOEXEC,		/* IOMMU_NOEXEC flag */
> > +	IOMMU_CAP_MERGING,		/* IOMMU supports segments merging */
> 
> This isn't a 'capability' of the IOMMU - "segment merging" equates to
> just remapping pages, and there's already a fundamental assumption that
> IOMMUs are capable of that. Plus it's very much a DMA API concept, so
> hardly belongs in the IOMMU API anyway.

I got it.

> All in all, I'm struggling to see the point of this. Although it's not a
> DMA API guarantee, iommu-dma already merges scatterlists as aggressively
> as it is allowed to, and will continue to do so for the foreseeable
> future (since it avoids considerable complication in the IOVA
> allocation), so if you want to make sure iommu_dma_map_sg() merges an
> entire list, just don't give it a non-mergeable list.

Thank you for the explanation. I didn't know that a driver should not
give it a non-mergeable list.

> And if you still
> really really want dma_map_sg() to have a behaviour of "merge to a
> single segment or fail", then that should at least be a DMA API
> attribute, which could in principle be honoured by bounce-buffering
> implementations as well.

I got it. For this patch series, it seems I have to modify a block layer
so that such a new DMA API is not needed though.

> And if the problem is really that you're not getting merging because of
> exposing the wrong parameters to the DMA API and/or the block layer, or
> that you just can't quite express your requirement to the block layer in
> the first place, then that should really be tackled at the source rather
> than worked around further down in the stack.

I'll reply on Christoph email about this topic later.

Best regards,
Yoshihiro Shimoda

> Robin.
