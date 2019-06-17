From: Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Subject: RE: [RFC PATCH v6 3/5] block: add a helper function to merge the
	segments by an IOMMU
Date: Mon, 17 Jun 2019 06:29:31 +0000
Message-ID: <OSBPR01MB3590A1AA199894E8220777EFD8EB0@OSBPR01MB3590.jpnprd01.prod.outlook.com>
References: <1560421215-10750-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
	<1560421215-10750-4-git-send-email-yoshihiro.shimoda.uh@renesas.com>
	<039d7388-ed24-c7e7-dd6a-656c719a5ed9@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <039d7388-ed24-c7e7-dd6a-656c719a5ed9-5wv7dgnIgG8@public.gmane.org>
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
Cc: "axboe-tSWWG44O7X1aa/9Udqfwiw@public.gmane.org" <axboe-tSWWG44O7X1aa/9Udqfwiw@public.gmane.org>, "linux-block-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-block-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "wsa+renesas-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org" <wsa+renesas-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "hch-jcswGhMUV9g@public.gmane.org" <hch-jcswGhMUV9g@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Hi Robin,

> From: Robin Murphy, Sent: Friday, June 14, 2019 6:55 PM
> 
> On 13/06/2019 11:20, Yoshihiro Shimoda wrote:
<snip>
> > +bool blk_queue_can_use_iommu_merging(struct request_queue *q,
> > +				     struct device *dev)
> > +{
> > +	struct iommu_domain *domain;
> > +
> > +	/*
> > +	 * If the device DMA is translated by an IOMMU, we can assume
> > +	 * the device can merge the segments.
> > +	 */
> > +	if (!device_iommu_mapped(dev))
> 
> Careful here - I think this validates the comment I made when this
> function was introduced, in that that name doesn't necesarily mean what
> it sounds like it might mean - "iommu_mapped" was as close as we managed
> to get to a convenient shorthand for "performs DMA through an
> IOMMU-API-enabled IOMMU". Specifically, it does not imply that
> translation is *currently* active; if you boot with "iommu=pt" or
> equivalent this will still return true even though the device will be
> using direct/SWIOTLB DMA ops without any IOMMU translation.

Thank you for your comments. I understood the mean of "iommu_mapped" and
this patch's condition causes a problem on iommu=pt.
So, I'll add and additional condition like
"domain->type == IOMMU_DOMAIN_DMA" to check whether the translation is
currently active on the domain or not.

Best regards,
Yoshihiro Shimoda
