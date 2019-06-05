From: Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
Subject: Re: [RFC PATCH v5 3/8] iommu: add a new capable IOMMU_CAP_MERGING
Date: Wed, 5 Jun 2019 19:17:42 +0300
Message-ID: <35f63f36-ea4d-850f-8a59-805e67c06b68@cogentembedded.com>
References: <1559733114-4221-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
	<1559733114-4221-4-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1559733114-4221-4-git-send-email-yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Content-Language: en-MW
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, wsa+renesas-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org, hch-jcswGhMUV9g@public.gmane.org, m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org
Cc: linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

On 06/05/2019 02:11 PM, Yoshihiro Shimoda wrote:

> This patch adds a new capable IOMMU_CAP_MERGING to check whether
> the IOVA would be contiguous strictly if a device requires and
> the IOMMU driver has the capable.

   s/has/is/? Or capable what?

> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
> ---
>  drivers/iommu/dma-iommu.c | 26 ++++++++++++++++++++++++--
>  include/linux/iommu.h     |  1 +
>  2 files changed, 25 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 034caae..ecf1a04 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
[...]
> @@ -867,6 +872,13 @@ static int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
>  		sg_dma_len(s) = s_length;
>  		s->offset -= s_iova_off;
>  		s_length = iova_align(iovad, s_length + s_iova_off);
> +		/*
> +		 * Check whether the IOVA would be contiguous strictly if
> +		 * a device requires and the IOMMU driver has the capable.

   Same question here...

> +		 */
> +		if (iova_contiguous && i > 0 &&
> +		    (s_iova_off || s->length != s_length))
> +			return 0;
>  		s->length = s_length;
>  
>  		/*
> @@ -902,8 +914,18 @@ static int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
>  	if (iommu_map_sg(domain, iova, sg, nents, prot) < iova_len)
>  		goto out_free_iova;
>  
> -	return __finalise_sg(dev, sg, nents, iova);
> +	ret = __finalise_sg(dev, sg, nents, iova);
> +	/*
> +	 * Check whether the sg entry is single if a device requires and
> +	 * the IOMMU driver has the capable.

   You  meant capability perhaps?

[...]

MBR, Sergei
