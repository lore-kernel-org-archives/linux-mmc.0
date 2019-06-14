From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [RFC PATCH v6 3/5] block: add a helper function to merge the
	segments by an IOMMU
Date: Fri, 14 Jun 2019 10:54:38 +0100
Message-ID: <039d7388-ed24-c7e7-dd6a-656c719a5ed9@arm.com>
References: <1560421215-10750-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
	<1560421215-10750-4-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1560421215-10750-4-git-send-email-yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Content-Language: en-GB
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, axboe-tSWWG44O7X1aa/9Udqfwiw@public.gmane.org, ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, wsa+renesas-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org
Cc: linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-block-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, hch-jcswGhMUV9g@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

On 13/06/2019 11:20, Yoshihiro Shimoda wrote:
> This patch adds a helper function whether a queue can merge
> the segments by an IOMMU.
> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
> ---
>   block/blk-settings.c   | 28 ++++++++++++++++++++++++++++
>   include/linux/blkdev.h |  2 ++
>   2 files changed, 30 insertions(+)
> 
> diff --git a/block/blk-settings.c b/block/blk-settings.c
> index 45f2c52..4e4e13e 100644
> --- a/block/blk-settings.c
> +++ b/block/blk-settings.c
> @@ -4,9 +4,11 @@
>    */
>   #include <linux/bio.h>
>   #include <linux/blkdev.h>
> +#include <linux/device.h>
>   #include <linux/gcd.h>
>   #include <linux/gfp.h>
>   #include <linux/init.h>
> +#include <linux/iommu.h>
>   #include <linux/jiffies.h>
>   #include <linux/kernel.h>
>   #include <linux/lcm.h>
> @@ -831,6 +833,32 @@ void blk_queue_write_cache(struct request_queue *q, bool wc, bool fua)
>   }
>   EXPORT_SYMBOL_GPL(blk_queue_write_cache);
>   
> +/**
> + * blk_queue_can_use_iommu_merging - configure queue for merging segments.
> + * @q:		the request queue for the device
> + * @dev:	the device pointer for dma
> + *
> + * Tell the block layer about the iommu merging of @q.
> + */
> +bool blk_queue_can_use_iommu_merging(struct request_queue *q,
> +				     struct device *dev)
> +{
> +	struct iommu_domain *domain;
> +
> +	/*
> +	 * If the device DMA is translated by an IOMMU, we can assume
> +	 * the device can merge the segments.
> +	 */
> +	if (!device_iommu_mapped(dev))

Careful here - I think this validates the comment I made when this 
function was introduced, in that that name doesn't necesarily mean what 
it sounds like it might mean - "iommu_mapped" was as close as we managed 
to get to a convenient shorthand for "performs DMA through an 
IOMMU-API-enabled IOMMU". Specifically, it does not imply that 
translation is *currently* active; if you boot with "iommu=pt" or 
equivalent this will still return true even though the device will be 
using direct/SWIOTLB DMA ops without any IOMMU translation.

Robin.

> +		return false;
> +
> +	domain = iommu_get_domain_for_dev(dev);
> +	/* No need to update max_segment_size. see blk_queue_virt_boundary() */
> +	blk_queue_virt_boundary(q, iommu_get_minimum_page_size(domain) - 1);
> +
> +	return true;
> +}
> +
>   static int __init blk_settings_init(void)
>   {
>   	blk_max_low_pfn = max_low_pfn - 1;
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 592669b..4d1f7dc 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -1091,6 +1091,8 @@ extern void blk_queue_dma_alignment(struct request_queue *, int);
>   extern void blk_queue_update_dma_alignment(struct request_queue *, int);
>   extern void blk_queue_rq_timeout(struct request_queue *, unsigned int);
>   extern void blk_queue_write_cache(struct request_queue *q, bool enabled, bool fua);
> +extern bool blk_queue_can_use_iommu_merging(struct request_queue *q,
> +					    struct device *dev);
>   
>   /*
>    * Number of physical segments as sent to the device.
> 
