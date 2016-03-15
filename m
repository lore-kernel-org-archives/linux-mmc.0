From: David Lechner <david@lechnology.com>
Subject: Re: [PATCH v2 4/5] mmc: davinci: don't use dma platform resources
Date: Tue, 15 Mar 2016 12:14:22 -0500
Message-ID: <56E842EE.7030301@lechnology.com>
References: <56E6BF7E.7020401@ti.com>
 <1457996081-21975-1-git-send-email-david@lechnology.com>
 <1457996081-21975-5-git-send-email-david@lechnology.com>
 <56E7CDAC.1090907@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from vern.gendns.com ([206.190.152.46]:52359 "EHLO vern.gendns.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934767AbcCOROt (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 15 Mar 2016 13:14:49 -0400
In-Reply-To: <56E7CDAC.1090907@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>, nsekhar@ti.com
Cc: ulf.hansson@linaro.org, khilman@kernel.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 03/15/2016 03:54 AM, Peter Ujfalusi wrote:
> On 03/15/16 00:54, David Lechner wrote:
>>
>>   	host->dma_tx =
>> -		dma_request_slave_channel_compat(mask, edma_filter_fn,
>> -				&host->txdma, mmc_dev(host->mmc), "tx");
>> +		dma_request_slave_channel(mmc_dev(host->mmc), "tx");
>
> you would need to use dma_request_chan() to be able to rely on the legacy
> channel mapping.
> I have staged commits for converting all daVinci and OMAP drivers, I'll attach
> the patch I have for davinci-mmc for reference.
> When we convert to use the dma_request_chan() we can handle deferred probing
> also...
>

OK. So I should redo this patch on top of the patch you attached?

