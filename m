From: Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Subject: RE: [RFC PATCH v6 5/5] mmc: queue: Use bigger segments if IOMMU can
	merge the segments
Date: Mon, 17 Jun 2019 07:02:47 +0000
Message-ID: <OSBPR01MB3590289F07A53A33296BC9D6D8EB0@OSBPR01MB3590.jpnprd01.prod.outlook.com>
References: <1560421215-10750-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
	<1560421215-10750-6-git-send-email-yoshihiro.shimoda.uh@renesas.com>
	<20190614072459.GD8420@lst.de>
	<OSBPR01MB3590FA5DB10D9EF34F551335D8EB0@OSBPR01MB3590.jpnprd01.prod.outlook.com>
	<20190617065331.GA5456@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20190617065331.GA5456-jcswGhMUV9g@public.gmane.org>
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
To: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Cc: "axboe-tSWWG44O7X1aa/9Udqfwiw@public.gmane.org" <axboe-tSWWG44O7X1aa/9Udqfwiw@public.gmane.org>, "linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-block-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-block-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "wsa+renesas-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org" <wsa+renesas-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Hi Christoph,

> From: Christoph Hellwig, Sent: Monday, June 17, 2019 3:54 PM
> 
> On Mon, Jun 17, 2019 at 06:46:33AM +0000, Yoshihiro Shimoda wrote:
> > > can_merge seems a little too generic a name to me.  Maybe can_iommu_merge?
> >
> > I'll fix the name. Also, only the device_iommu_mapped() condition wiil cause
> > a problem on iommu=pt [1]. So, I'll add another condition here.
> 
> Instead of adding another condition here I think we need to properly
> abstract it out in the DMA layer.  E.g. have a

Thank you for your comment and sample code! I'll add such functions
on next patch series.

Best regards,
Yoshihiro Shimoda

> unsigned long dma_get_merge_boundary(struct device *dev)
> {
> 	const struct dma_map_ops *ops = get_dma_ops(dev);
> 
> 	if (!ops || !ops->get_merge_boundary)
> 		return 0; /* can't merge */
> 	return ops->get_merge_boundary(dev);
> }
> 
> and then implement the method in dma-iommu.c.
> 
> blk_queue_can_use_iommu_merging then comes:
> 
> bool blk_queue_enable_iommu_merging(struct request_queue *q,
> 		struct device *dev)
> {
> 	unsigned long boundary = dma_get_merge_boundary(dev);
> 
> 	if (!boundary)
> 		return false;
> 	blk_queue_virt_boundary(q, boundary);
> 	return true;
> }
