From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 3/3] mmc: SDHI: DMA slave ID 0 is invalid
Date: Mon, 20 Jun 2011 15:37:13 -0400
Message-ID: <m2tybkxpjq.fsf@bob.laptop.org>
References: <Pine.LNX.4.64.1105241147010.31628@axis700.grange>
	<Pine.LNX.4.64.1105241222470.31628@axis700.grange>
	<Pine.LNX.4.64.1106201527210.11365@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:33267 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752789Ab1FTThd (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 20 Jun 2011 15:37:33 -0400
In-Reply-To: <Pine.LNX.4.64.1106201527210.11365@axis700.grange> (Guennadi
	Liakhovetski's message of "Mon, 20 Jun 2011 16:52:16 +0200 (CEST)")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-sh@vger.kernel.org, linux-mmc@vger.kernel.org, Simon Horman <horms@verge.net.au>, Magnus Damm <damm@opensource.se>, Ian Molton <ian@mnementh.co.uk>, Dan Williams <dan.j.williams@intel.com>, Vinod Koul <vinod.koul@intel.com>

Hi Guennadi,

On Mon, Jun 20 2011, Guennadi Liakhovetski wrote:
> Can we please get this patch too in for 3.0? It is a part of a 
> patch-series, of which all others havs already been applied. This specific 
> patch makes the behaviour of the SDHI driver consistent with other DMA 
> users on sh-mobile, namely, that default platform data with no DMA 
> information provided immediately switches the driver to the PIO mode. This 
> patch fixes this logical error of trying to acquire DMA channels with 
> invalid configuration information and avoids ugly error messages in the 
> kernel log.
>
> Thanks
> Guennadi
>
> On Tue, 24 May 2011, Guennadi Liakhovetski wrote:
>
>> Don't try to allocate DMA resources, if the platform didn't specify
>> positive DMA slave IDs.
>> 
>> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
>> ---
>>  drivers/mmc/host/sh_mobile_sdhi.c |    2 +-
>>  1 files changed, 1 insertions(+), 1 deletions(-)
>> 
>> diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mobile_sdhi.c
>> index c05d699..e646741 100644
>> --- a/drivers/mmc/host/sh_mobile_sdhi.c
>> +++ b/drivers/mmc/host/sh_mobile_sdhi.c
>> @@ -132,7 +132,7 @@ static int __devinit sh_mobile_sdhi_probe(struct platform_device *pdev)
>>  		mmc_data->ocr_mask = p->tmio_ocr_mask;
>>  		mmc_data->capabilities |= p->tmio_caps;
>>  
>> -		if (p->dma_slave_tx >= 0 && p->dma_slave_rx >= 0) {
>> +		if (p->dma_slave_tx > 0 && p->dma_slave_rx > 0) {
>>  			priv->param_tx.slave_id = p->dma_slave_tx;
>>  			priv->param_rx.slave_id = p->dma_slave_rx;
>>  			priv->dma_priv.chan_priv_tx = &priv->param_tx;
>> -- 
>> 1.7.2.5

Thanks, pushed to mmc-next for 3.0.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
