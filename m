From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: mmc: dw_mmc: miscaculated the fifo-depth with wrong bit operation
Date: Wed, 11 Jan 2012 18:59:06 +0900
Message-ID: <4F0D5D6A.9040200@samsung.com>
References: <4F0A3DA4.8010909@samsung.com> <4F0AB63B.4030202@imgtec.com>
 <4F0D5635.50201@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:14187 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752499Ab2AKJ7M (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 11 Jan 2012 04:59:12 -0500
Received: from epcpsbgm2.samsung.com (mailout1.samsung.com [203.254.224.24])
 by mailout1.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LXM00GF2P27LCY0@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 11 Jan 2012 18:59:10 +0900 (KST)
Received: from [165.213.219.108] by mmp2.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTPA id <0LXM00JTEP2LEY80@mmp2.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 11 Jan 2012 18:59:10 +0900 (KST)
In-reply-to: <4F0D5635.50201@imgtec.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: James Hogan <james.hogan@imgtec.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>, Will Newton <will.newton@imgtec.com>

Hi James,

Thank you..:)

Best Regards,
Jaehoon Chung

On 01/11/2012 06:28 PM, James Hogan wrote:

> On 09/01/12 09:41, James Hogan wrote:
>> On 01/09/2012 01:06 AM, Jaehoon Chung wrote:
>>> In FIFOTH register, can find "bit[27:16] = FIFO_DEPTH - 1".
>>> Finally, FIFO_DEPTH = bit[27:16] + 1.
>>>
>>> Now, Used the 0x7ff. but 0xfff is right.
>>
>> Nice catch. The patch itself looks okay, but I don't think the commit
>> message is very understandable, maybe something like this would be better?:
>>
>> In FIFOTH register, the RX_WMark field (bits[27:16]) defaults to
>> FIFO_DEPTH - 1. When reading it, bits[26:16] were being used, so fix it
>> to use the mask 0xfff instead of 0x7ff.
>>
>> Cheers
>> James
> 
> Are you happy having your signed-off-by against this identical patch with
> a modified message Jaehoon?
> 
> From: Jaehoon Chung <jh80.chung@samsung.com>
> 
> In FIFOTH register, the RX_WMark field (bits[27:16]) defaults to
> FIFO_DEPTH - 1. When reading it, bits[26:16] were being used, so fix it
> to use the mask 0xfff instead of 0x7ff.
> 
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> Reviewed-by: James Hogan <james.hogan@imgtec.com>
> ---
>  drivers/mmc/host/dw_mmc.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index cc54808..6ea6185 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -2075,7 +2075,7 @@ static int dw_mci_probe(struct platform_device *pdev)
>  		 * should put it in the platform data.
>  		 */
>  		fifo_size = mci_readl(host, FIFOTH);
> -		fifo_size = 1 + ((fifo_size >> 16) & 0x7ff);
> +		fifo_size = 1 + ((fifo_size >> 16) & 0xfff);
>  	} else {
>  		fifo_size = host->pdata->fifo_depth;
>  	}


