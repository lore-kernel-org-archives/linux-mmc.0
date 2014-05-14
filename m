From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: wmt-sdmmc: Use GFP_KERNEL instead of hard-coded value
Date: Wed, 14 May 2014 13:13:45 +0200
Message-ID: <CAPDyKFq9Nz99WBLmYdz3Tar1LuXmfiyoF=QhaM3JNr4-v-DAJQ@mail.gmail.com>
References: <1398646711.10750.0.camel@phoenix>
	<CAFRkauBCjiePz-Nj46JmDoTmgOM7ch7BoA0s5SxQ2pn29F5aNg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qg0-f43.google.com ([209.85.192.43]:61603 "EHLO
	mail-qg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754947AbaENLNp (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 14 May 2014 07:13:45 -0400
Received: by mail-qg0-f43.google.com with SMTP id 63so2480577qgz.2
        for <linux-mmc@vger.kernel.org>; Wed, 14 May 2014 04:13:45 -0700 (PDT)
In-Reply-To: <CAFRkauBCjiePz-Nj46JmDoTmgOM7ch7BoA0s5SxQ2pn29F5aNg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Axel Lin <axel.lin@ingics.com>
Cc: Chris Ball <chris@printf.net>, Tony Prisk <linux@prisktech.co.nz>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-mmc <linux-mmc@vger.kernel.org>

On 14 May 2014 13:01, Axel Lin <axel.lin@ingics.com> wrote:
> 2014-04-28 8:58 GMT+08:00 Axel Lin <axel.lin@ingics.com>:
>> Signed-off-by: Axel Lin <axel.lin@ingics.com>
>> ---
>>  drivers/mmc/host/wmt-sdmmc.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/mmc/host/wmt-sdmmc.c b/drivers/mmc/host/wmt-sdmmc.c
>> index 34231d5..3605c37 100644
>> --- a/drivers/mmc/host/wmt-sdmmc.c
>> +++ b/drivers/mmc/host/wmt-sdmmc.c
>> @@ -852,7 +852,7 @@ static int wmt_mci_probe(struct platform_device *pdev)
>>         priv->dma_desc_buffer = dma_alloc_coherent(&pdev->dev,
>>                                                    mmc->max_blk_count * 16,
>>                                                    &priv->dma_desc_device_addr,
>> -                                                  208);
>> +                                                  GFP_KERNEL);
>
> Hi Ulf,
> This is a pretty trivial patch.
> Would you pick up this patch?

Done.

Kind regards
Ulf Hansson

>
> Regards,
> Axel
