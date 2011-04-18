From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH] dw_mmc: add support for pre_req and post_req
Date: Mon, 18 Apr 2011 13:55:11 +0900
Message-ID: <4DABC42F.30405@samsung.com>
References: <4D9D7024.2030404@samsung.com>
 <20110416161634.GB17935@S2100-06.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:59510 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751429Ab1DRE5Q (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 18 Apr 2011 00:57:16 -0400
Received: from epmmp2 (mailout1.samsung.com [203.254.224.24])
 by mailout1.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LJU00L8J0FE8F60@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 18 Apr 2011 13:57:14 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
 by mmp2.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTPA id <0LJU001GM0FEM2@mmp2.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 18 Apr 2011 13:57:14 +0900 (KST)
In-reply-to: <20110416161634.GB17935@S2100-06.ap.freescale.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Guo <shawn.guo@freescale.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Per Forlin <per.forlin@linaro.org>, will.newton@imgtec.com, Kyungmin Park <kyungmin.park@samsung.com>

Hi Shawn..

Shawn Guo wrote:
> Hi Jaehoon,
> 
> On Thu, Apr 07, 2011 at 05:04:52PM +0900, Jaehoon Chung wrote:
> [...]
>> +static unsigned int dw_mci_pre_dma_transfer(struct dw_mci *host,
>> +			struct mmc_data *data, struct dw_mci_next *next)
>> +{
>> +	unsigned int sg_len;
>> +
>> +	BUG_ON(next && data->host_cookie);
>> +	BUG_ON(!next && data->host_cookie &&
>> +			data->host_cookie != host->next_data.cookie);
>> +
>> +	if (!next && data->host_cookie &&
>> +			data->host_cookie != host->next_data.cookie) {
>> +		data->host_cookie = 0;
>> +	}
>> +
> I'm unsure if the 'if' statement makes any sense here, since the
> exactly same conditions have been caught by the BUG_ON just above
> it.
> 
You're right..i'll modify this..

>> +	if (next ||
>> +		(!next && data->host_cookie != host->next_data.cookie)) {
>> +		sg_len = dma_map_sg(&host->pdev->dev, data->sg,
>> +				data->sg_len, ((data->flags & MMC_DATA_WRITE)
>> +			      ? DMA_TO_DEVICE : DMA_FROM_DEVICE));
>> +	} else {
>> +		sg_len = host->next_data.sg_len;
>> +		host->next_data.sg_len = 0;
>> +	}
>> +
>> +	if (sg_len == 0)
>> +		return -EINVAL;
>> +
>> +	if (next) {
>> +		next->sg_len = sg_len;
>> +		data->host_cookie = ++next->cookie < 0 ? 1 : next->cookie;
>> +	} else
>> +		data->sg_len = sg_len;
>> +
>> +	return sg_len;
>> +}
>> +
> Function dw_mci_pre_dma_transfer() returns non-zero value anyway,
> either -EINVAL or sg_len ...
> 
Sorry,, i didn't understand this your comments..

> [...]
>> +static void dw_mci_pre_request(struct mmc_host *mmc, struct mmc_request *mrq,
>> +		bool is_first_req)
>> +{
>> +	struct dw_mci_slot *slot = mmc_priv(mmc);
>> +	struct mmc_data *data = mrq->data;
>> +
>> +	if (!data)
>> +		return;
>> +
>> +	BUG_ON(mrq->data->host_cookie);
>> +
>> +	if (slot->host->use_dma) {
>> +		if (dw_mci_pre_dma_transfer(slot->host, mrq->data,
>> +					&slot->host->next_data))
>> +			mrq->data->host_cookie = 0;
> ... while it steps back to old blocking way by setting
> data->host_cookie 0 when dw_mci_pre_dma_transfer returns non-zero.
> 
> Per my understanding, it means the non-blocking optimization will
> always get bypassed anyway, so I doubt the patch can really gain
> performance improvement.  Did you get the chance to measure?
> 
Actually, i didn't get performance improvement, but didn't fully affect by CPU_FREQ.
Somebody get performance improvement?

Regards,
Jaehoon Chung

