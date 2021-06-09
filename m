Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD15EC48BCF
	for <linux-mmc@archiver.kernel.org>; Wed,  9 Jun 2021 14:45:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90DB2613AE
	for <linux-mmc@archiver.kernel.org>; Wed,  9 Jun 2021 14:45:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238079AbhFIOrk (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 9 Jun 2021 10:47:40 -0400
Received: from foss.arm.com ([217.140.110.172]:33532 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238100AbhFIOri (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 9 Jun 2021 10:47:38 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 86EBCD6E;
        Wed,  9 Jun 2021 07:45:43 -0700 (PDT)
Received: from [10.57.6.115] (unknown [10.57.6.115])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B97EF3F73D;
        Wed,  9 Jun 2021 07:45:41 -0700 (PDT)
Subject: Re: [RFC] mmc: meson-gx: use memcpy_to/fromio for dram-access-quirk
To:     Neil Armstrong <narmstrong@baylibre.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        ulf.hansson@linaro.org
Cc:     khilman@baylibre.com, jbrunet@baylibre.com,
        martin.blumenstingl@googlemail.com, linux-mmc@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
References: <CGME20210608153357eucas1p24cbc7a2ddb00beada8cdd51ae2337c53@eucas1p2.samsung.com>
 <20210608153344.3813661-1-narmstrong@baylibre.com>
 <e9f057f6-324e-0637-b57a-cc2f87e0d108@samsung.com>
 <ebb1421c-e55c-eee3-ea42-09ae051659d4@baylibre.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <92024ca5-c6fa-0e6a-b6ba-f35f92222e76@arm.com>
Date:   Wed, 9 Jun 2021 15:45:36 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <ebb1421c-e55c-eee3-ea42-09ae051659d4@baylibre.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 2021-06-09 14:07, Neil Armstrong wrote:
> Hi,
> 
> On 08/06/2021 17:50, Marek Szyprowski wrote:
>> Hi
>>
>> On 08.06.2021 17:33, Neil Armstrong wrote:
>>> It has been reported that usage of memcpy() to/from an iomem mapping is invalid,
>>> and and recent arm64 memcpy update [1] triggers a memory abort when dram-access-quirk
>>> is used on the G12A/G12B platforms.
>>>
>>> This adds a local sg_copy_to_buffer which makes usage of io versions of memcpy
>>> when dram-access-quirk is enabled.
>>>
>>> Fixes: acdc8e71d9bb ("mmc: meson-gx: add dram-access-quirk")
>>> Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
>>> Suggested-by: Mark Rutland <mark.rutland@arm.com>
>>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>>>
>>> [1] 285133040e6c ("arm64: Import latest memcpy()/memmove() implementation")
>>>
>>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>>> ---
>>> Hi Ulf, Marek, Mark,
>>>
>>> I haven't tested the patch yet, but should fix issue reported at [2].
>>
>> Works fine here and fixed the issue.
>>
>> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> 
> Thanks, I'll need to rework to pass an __iomem pointer to memcpy_to/fromio so sparse doesn't scream anymore.

Hmm, might it be worth factoring out general sg_copy_{to,from}_iomem() 
helpers? From a quick grep I found at least mv_cesa_sg_copy() already 
doing essentially the same thing as meson_mmc_copy_buffer().

Robin.

> 
> Neil
> 
>>
>>> Neil
>>>
>>> [2] https://lore.kernel.org/r/acb244ad-0759-5a96-c659-5c23003d3dcd@samsung.com
>>>
>>>    drivers/mmc/host/meson-gx-mmc.c | 48 ++++++++++++++++++++++++++++++---
>>>    1 file changed, 44 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
>>> index b8b771b643cc..89ff6038092d 100644
>>> --- a/drivers/mmc/host/meson-gx-mmc.c
>>> +++ b/drivers/mmc/host/meson-gx-mmc.c
>>> @@ -742,6 +742,48 @@ static void meson_mmc_desc_chain_transfer(struct mmc_host *mmc, u32 cmd_cfg)
>>>    	writel(start, host->regs + SD_EMMC_START);
>>>    }
>>>    
>>> +/* local sg copy to buffer version with _to/fromio usage for dram_access_quirk */
>>> +static void meson_mmc_copy_buffer(struct meson_host *host, struct mmc_data *data,
>>> +				  size_t buflen, bool to_buffer)
>>> +{
>>> +	unsigned int sg_flags = SG_MITER_ATOMIC;
>>> +	struct scatterlist *sgl = data->sg;
>>> +	unsigned int nents = data->sg_len;
>>> +	struct sg_mapping_iter miter;
>>> +	void *buf = host->bounce_buf;
>>> +	unsigned int offset = 0;
>>> +
>>> +	if (to_buffer)
>>> +		sg_flags |= SG_MITER_FROM_SG;
>>> +	else
>>> +		sg_flags |= SG_MITER_TO_SG;
>>> +
>>> +	sg_miter_start(&miter, sgl, nents, sg_flags);
>>> +
>>> +	while ((offset < buflen) && sg_miter_next(&miter)) {
>>> +		unsigned int len;
>>> +
>>> +		len = min(miter.length, buflen - offset);
>>> +
>>> +		/* When dram_access_quirk, the bounce buffer is a iomem mapping */
>>> +		if (host->dram_access_quirk) {
>>> +			if (to_buffer)
>>> +				memcpy_toio(buf + offset, miter.addr, len);
>>> +			else
>>> +				memcpy_fromio(miter.addr, buf + offset, len);
>>> +		} else {
>>> +			if (to_buffer)
>>> +				memcpy(buf + offset, miter.addr, len);
>>> +			else
>>> +				memcpy(miter.addr, buf + offset, len);
>>> +		}
>>> +
>>> +		offset += len;
>>> +	}
>>> +
>>> +	sg_miter_stop(&miter);
>>> +}
>>> +
>>>    static void meson_mmc_start_cmd(struct mmc_host *mmc, struct mmc_command *cmd)
>>>    {
>>>    	struct meson_host *host = mmc_priv(mmc);
>>> @@ -785,8 +827,7 @@ static void meson_mmc_start_cmd(struct mmc_host *mmc, struct mmc_command *cmd)
>>>    		if (data->flags & MMC_DATA_WRITE) {
>>>    			cmd_cfg |= CMD_CFG_DATA_WR;
>>>    			WARN_ON(xfer_bytes > host->bounce_buf_size);
>>> -			sg_copy_to_buffer(data->sg, data->sg_len,
>>> -					  host->bounce_buf, xfer_bytes);
>>> +			meson_mmc_copy_buffer(host, data, xfer_bytes, true);
>>>    			dma_wmb();
>>>    		}
>>>    
>>> @@ -955,8 +996,7 @@ static irqreturn_t meson_mmc_irq_thread(int irq, void *dev_id)
>>>    	if (meson_mmc_bounce_buf_read(data)) {
>>>    		xfer_bytes = data->blksz * data->blocks;
>>>    		WARN_ON(xfer_bytes > host->bounce_buf_size);
>>> -		sg_copy_from_buffer(data->sg, data->sg_len,
>>> -				    host->bounce_buf, xfer_bytes);
>>> +		meson_mmc_copy_buffer(host, data, xfer_bytes, false);
>>>    	}
>>>    
>>>    	next_cmd = meson_mmc_get_next_command(cmd);
>>
>> Best regards
>>
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
