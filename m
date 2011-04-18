From: Shawn Guo <shawn.guo@freescale.com>
Subject: Re: [PATCH] dw_mmc: add support for pre_req and post_req
Date: Mon, 18 Apr 2011 13:10:23 +0800
Message-ID: <20110418051022.GC18623@S2100-06.ap.freescale.net>
References: <4D9D7024.2030404@samsung.com>
 <20110416161634.GB17935@S2100-06.ap.freescale.net>
 <4DABC42F.30405@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from va3ehsobe005.messaging.microsoft.com ([216.32.180.31]:25050
	"EHLO VA3EHSOBE005.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751783Ab1DRFIP (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 18 Apr 2011 01:08:15 -0400
Content-Disposition: inline
In-Reply-To: <4DABC42F.30405@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Per Forlin <per.forlin@linaro.org>, will.newton@imgtec.com, Kyungmin Park <kyungmin.park@samsung.com>

On Mon, Apr 18, 2011 at 01:55:11PM +0900, Jaehoon Chung wrote:
> Hi Shawn..
> 
> Shawn Guo wrote:
> > Hi Jaehoon,
> > 
> > On Thu, Apr 07, 2011 at 05:04:52PM +0900, Jaehoon Chung wrote:
> > [...]
> >> +static unsigned int dw_mci_pre_dma_transfer(struct dw_mci *host,
> >> +			struct mmc_data *data, struct dw_mci_next *next)
> >> +{
> >> +	unsigned int sg_len;
> >> +
> >> +	BUG_ON(next && data->host_cookie);
> >> +	BUG_ON(!next && data->host_cookie &&
> >> +			data->host_cookie != host->next_data.cookie);
> >> +
> >> +	if (!next && data->host_cookie &&
> >> +			data->host_cookie != host->next_data.cookie) {
> >> +		data->host_cookie = 0;
> >> +	}
> >> +
> > I'm unsure if the 'if' statement makes any sense here, since the
> > exactly same conditions have been caught by the BUG_ON just above
> > it.
> > 
> You're right..i'll modify this..
> 
> >> +	if (next ||
> >> +		(!next && data->host_cookie != host->next_data.cookie)) {
> >> +		sg_len = dma_map_sg(&host->pdev->dev, data->sg,
> >> +				data->sg_len, ((data->flags & MMC_DATA_WRITE)
> >> +			      ? DMA_TO_DEVICE : DMA_FROM_DEVICE));
> >> +	} else {
> >> +		sg_len = host->next_data.sg_len;
> >> +		host->next_data.sg_len = 0;
> >> +	}
> >> +
> >> +	if (sg_len == 0)
> >> +		return -EINVAL;
> >> +
> >> +	if (next) {
> >> +		next->sg_len = sg_len;
> >> +		data->host_cookie = ++next->cookie < 0 ? 1 : next->cookie;
> >> +	} else
> >> +		data->sg_len = sg_len;
> >> +
> >> +	return sg_len;
> >> +}
> >> +
> > Function dw_mci_pre_dma_transfer() returns non-zero value anyway,
> > either -EINVAL or sg_len ...
> > 
> Sorry,, i didn't understand this your comments..
> 
> > [...]
> >> +static void dw_mci_pre_request(struct mmc_host *mmc, struct mmc_request *mrq,
> >> +		bool is_first_req)
> >> +{
> >> +	struct dw_mci_slot *slot = mmc_priv(mmc);
> >> +	struct mmc_data *data = mrq->data;
> >> +
> >> +	if (!data)
> >> +		return;
> >> +
> >> +	BUG_ON(mrq->data->host_cookie);
> >> +
> >> +	if (slot->host->use_dma) {
> >> +		if (dw_mci_pre_dma_transfer(slot->host, mrq->data,
> >> +					&slot->host->next_data))
> >> +			mrq->data->host_cookie = 0;
> > ... while it steps back to old blocking way by setting
> > data->host_cookie 0 when dw_mci_pre_dma_transfer returns non-zero.
> > 
> > Per my understanding, it means the non-blocking optimization will
> > always get bypassed anyway, so I doubt the patch can really gain
> > performance improvement.  Did you get the chance to measure?
> > 
> Actually, i didn't get performance improvement, but didn't fully affect by CPU_FREQ.
> Somebody get performance improvement?
> 
Though the performance improvement is limited, I did see nearly 4%
improvement with best case on mxs-mmc.


Try the following change in dw_mci_pre_request to see if you can see
any performance difference.

	if (slot->host->use_dma) {
		if (dw_mci_pre_dma_transfer(slot->host, mrq->data,
					&slot->host->next_data) < 0)
			mrq->data->host_cookie = 0;

-- 
Regards,
Shawn

