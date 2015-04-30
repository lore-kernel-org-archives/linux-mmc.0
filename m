From: zhangfei <zhangfei.gao@linaro.org>
Subject: Re: [PATCH] mmc: dw_mmc: init desc in dw_mci_idmac_init
Date: Thu, 30 Apr 2015 16:37:27 +0800
Message-ID: <5541E9C7.4010804@linaro.org>
References: <1430314316-15971-1-git-send-email-zhangfei.gao@linaro.org> <5541E13F.2070908@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pd0-f169.google.com ([209.85.192.169]:34772 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750729AbbD3Ihd (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 30 Apr 2015 04:37:33 -0400
Received: by pdbqa5 with SMTP id qa5so54084460pdb.1
        for <linux-mmc@vger.kernel.org>; Thu, 30 Apr 2015 01:37:32 -0700 (PDT)
In-Reply-To: <5541E13F.2070908@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, Fei Wang <w.f@huawei.com>, CPGS <cpgs@samsung.com>



On 04/30/2015 04:01 PM, Jaehoon Chung wrote:
> Hi.
>
> On 04/29/2015 10:31 PM, Zhangfei Gao wrote:
>> Set 0 to des1 in 32bit case.
>> Otherwise the random value of des1 will be used in
>> dw_mci_translate_sglist: IDMAC_64ADDR_SET_BUFFER1_SIZE(desc, length)
>
> I'm not understanding this comment.
> how does it use the IDMAC_64ADDR_SET_BUFFER1_SIZE(desc, length)?

p->des1 contains random value, coming from dmam_alloc_coherent in 
dw_mci_init_dma

In dw_mci_translate_sglist -> IDMAC_SET_BUFFER1_SIZE(desc, length);
#define IDMAC_SET_BUFFER1_SIZE(d, s) \
         ((d)->des1 = ((d)->des1 & 0x03ffe000) | ((s) & 0x1fff))

The random value will be set to des1 as well as length, causing 
unexpected behavior.

So des1 need to be init to 0.
While des0, des2, des3 are set in dw_mci_idmac_init and 
dw_mci_translate_sglist.

Thanks


>
> Best Regards,
> Jaehoon Chung
>>
>> Signed-off-by: Fei Wang <w.f@huawei.com>
>> Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
>> ---
>>   drivers/mmc/host/dw_mmc.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
>> index 241454f..488a8af 100644
>> --- a/drivers/mmc/host/dw_mmc.c
>> +++ b/drivers/mmc/host/dw_mmc.c
>> @@ -589,9 +589,11 @@ static int dw_mci_idmac_init(struct dw_mci *host)
>>   		host->ring_size = PAGE_SIZE / sizeof(struct idmac_desc);
>>
>>   		/* Forward link the descriptor list */
>> -		for (i = 0, p = host->sg_cpu; i < host->ring_size - 1; i++, p++)
>> +		for (i = 0, p = host->sg_cpu; i < host->ring_size - 1; i++, p++) {
>>   			p->des3 = cpu_to_le32(host->sg_dma +
>>   					(sizeof(struct idmac_desc) * (i + 1)));
>> +			p->des1 = 0;
>> +		}
>>
>>   		/* Set the last descriptor as the end-of-ring descriptor */
>>   		p->des3 = cpu_to_le32(host->sg_dma);
>>
>
