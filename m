Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1197C433E0
	for <linux-mmc@archiver.kernel.org>; Mon,  4 Jan 2021 09:19:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8526E21D7F
	for <linux-mmc@archiver.kernel.org>; Mon,  4 Jan 2021 09:19:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbhADJT5 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 4 Jan 2021 04:19:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbhADJT4 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 4 Jan 2021 04:19:56 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27C9AC061574
        for <linux-mmc@vger.kernel.org>; Mon,  4 Jan 2021 01:19:16 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id t16so6332329ejf.13
        for <linux-mmc@vger.kernel.org>; Mon, 04 Jan 2021 01:19:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:message-id
         :date:mime-version;
        bh=DueC5htyr1VhszUpmTm/tUVLrShThCg3h0/N3NarSwU=;
        b=A61zspJyVrET5bTumm0JSaxaUCSMDw0g8u6TZ1yADrWhPPWSaJ/nVlpBnHERM1nizQ
         hOYhIy51OyR2Vj6Um/wAlqOHnt2n2/ET2pdwf/0ovKJ0OXz+BLsoDYZYoQqUHFJDbqWF
         UmL+PUhQIT/qnQ7L2ye3fRa57+ajmccN3wqO+sXE71HGXN+nrpaYlEpazLl1svL4qSXd
         wAhOL8V9HQA7piUP2IJLwG1yGrQsP7M+RjwQ3BOy2mg+Nxj575ms9e9kSBdL4lZx8J7w
         FAfuFlVs+kQVe5VPkMaEyBa1APIvRpooat7UCOWO3juQsCRovne1wVwMsQqRBID4ss5z
         qi0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:message-id:date:mime-version;
        bh=DueC5htyr1VhszUpmTm/tUVLrShThCg3h0/N3NarSwU=;
        b=YvZ191ZydNKsvi3BBgCm6d6+Q+cL1LvX3XwIJO5JgYsxJjbJCzVYDXLGPUncA/guyN
         E6Qeg9RKd56asBEXBuYOYz6DOCJc9vH2LY4kSixSgeOJ7pqkQZ/8SdVwlCJC777EEsoS
         M4zN4f7ZrXk7u0S04O/9QhJNI19ZykSzDm3bT5FMTLXHD0BDxJ9OwAKPMRbsXOUy2dzS
         +yzdBz5H9J1eO7qYVKZaThjk/IM6H1jjoLSz6TNCuU1cR//nrfeiBZ1uzD5tMRp8YAhf
         3o0lCqWM9o8IlXKrUuJfU3l5VPVvEzWrrsNKPg7Q6l8ZL98Mer8452rchRUY0n3VeC2H
         dfQw==
X-Gm-Message-State: AOAM531m1BJKaI4ZEeQMTEg6s3iANXt3aynLEgp0C2KP+p7ZwClTfG85
        dBXs2A87Tp7cahMUswKUwiXk3Q==
X-Google-Smtp-Source: ABdhPJxqFryCMELbN8WJJJjZ5a7Uk1KXymyUk57FkCsFhIM+ZX2JhMxlKrqs3m4qRgYb1qqMpb7ogA==
X-Received: by 2002:a17:906:56ca:: with SMTP id an10mr66060606ejc.498.1609751954834;
        Mon, 04 Jan 2021 01:19:14 -0800 (PST)
Received: from localhost (82-65-169-74.subs.proxad.net. [82.65.169.74])
        by smtp.gmail.com with ESMTPSA id e21sm43094575edv.96.2021.01.04.01.19.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jan 2021 01:19:14 -0800 (PST)
References: <20201218075312.67338-1-lebed.dmitry@gmail.com>
 <b52f9e34-5170-59a0-fede-96cf2f999600@gmail.com>
User-agent: mu4e 1.4.10; emacs 27.1
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Heiner Kallweit <hkallweit1@gmail.com>,
        Dmitry Lebed <lebed.dmitry@gmail.com>,
        linux-amlogic@lists.infradead.org
Cc:     martin.blumenstingl@googlemail.com, linux-mmc@vger.kernel.org
Subject: Re: [PATCH] mmc: meson-gx: check for scatterlist size alignment in
 block mode
In-reply-to: <b52f9e34-5170-59a0-fede-96cf2f999600@gmail.com>
Message-ID: <1j8s99xdny.fsf@starbuckisacylon.baylibre.com>
Date:   Mon, 04 Jan 2021 10:19:13 +0100
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org


On Fri 18 Dec 2020 at 10:08, Heiner Kallweit <hkallweit1@gmail.com> wrote:

> Am 18.12.2020 um 08:53 schrieb Dmitry Lebed:
>> Enable SGDMA support for SD_IO_RW_EXTENDED and add proper check
>> for scatterlist size alignment in block mode.
>> 
>> According to documentation, in SDIO block mode meson-gx DMA could
>> only handle buffers with sizes that are multiples of SDIO block size.
>> 
>> Some SDIO drivers like brcmfmac use scatterlist API, but do not enforce
>> proper scatterlist buffer size alignemnt, this looks like a root cause
>> of non-working CMD53.
>> 
> It's been too long ago that I worked on this to provide real feedback.
> Just one comment: Your commit description sounds like there's a problem
> in drivers like brcmfmac. Wouldn't it be better then to first fix these
> drivers?

While this may be true, I think the proposed change is better than the
device/command specific work around we had so far.

>
>> Some minor style fixes.
>> 
>> Signed-off-by: Dmitry Lebed <lebed.dmitry@gmail.com>

Thx.

Reviewed-by: Jerome Brunet <jbrunet@baylibre.com>

>> ---
>>  drivers/mmc/host/meson-gx-mmc.c | 37 ++++++++++++++++++++-------------
>>  1 file changed, 22 insertions(+), 15 deletions(-)
>> 
>> diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
>> index 13f6a2c0ed04..eb6c02bc4a02 100644
>> --- a/drivers/mmc/host/meson-gx-mmc.c
>> +++ b/drivers/mmc/host/meson-gx-mmc.c
>> @@ -227,7 +227,6 @@ static void meson_mmc_get_transfer_mode(struct mmc_host *mmc,
>>  	struct mmc_data *data = mrq->data;
>>  	struct scatterlist *sg;
>>  	int i;
>> -	bool use_desc_chain_mode = true;
>>  
>>  	/*
>>  	 * When Controller DMA cannot directly access DDR memory, disable
>> @@ -237,25 +236,33 @@ static void meson_mmc_get_transfer_mode(struct mmc_host *mmc,
>>  	if (host->dram_access_quirk)
>>  		return;
>>  
>> -	/*
>> -	 * Broken SDIO with AP6255-based WiFi on Khadas VIM Pro has been
>> -	 * reported. For some strange reason this occurs in descriptor
>> -	 * chain mode only. So let's fall back to bounce buffer mode
>> -	 * for command SD_IO_RW_EXTENDED.
>> -	 */
>> -	if (mrq->cmd->opcode == SD_IO_RW_EXTENDED)
>> -		return;
>> +	if (data->blocks > 1) {
>> +		/*
>> +		 * In block mode DMA descriptor format, "length" field indicates
>> +		 * number of blocks and there is no way to pass DMA size that
>> +		 * is not multiple of SDIO block size, making it impossible to
>> +		 * tie more than one memory buffer with single SDIO block.
>> +		 * Block mode sg buffer size should be aligned with SDIO block
>> +		 * size, otherwise chain mode could not be used.
>> +		 */
>> +		for_each_sg(data->sg, sg, data->sg_len, i) {
>> +			if (sg->length % data->blksz) {
>> +				WARN_ONCE(1, "unaligned sg len %u blksize %u\n",
>> +					  sg->length, data->blksz);
>> +				return;
>> +			}
>> +		}
>> +	}
>>  
>> -	for_each_sg(data->sg, sg, data->sg_len, i)
>> +	for_each_sg(data->sg, sg, data->sg_len, i) {
>>  		/* check for 8 byte alignment */
>> -		if (sg->offset & 7) {
>> +		if (sg->offset % 8) {
>>  			WARN_ONCE(1, "unaligned scatterlist buffer\n");
>> -			use_desc_chain_mode = false;
>> -			break;
>> +			return;
>>  		}
>> +	}
>>  
>> -	if (use_desc_chain_mode)
>> -		data->host_cookie |= SD_EMMC_DESC_CHAIN_MODE;
>> +	data->host_cookie |= SD_EMMC_DESC_CHAIN_MODE;
>>  }
>>  
>>  static inline bool meson_mmc_desc_chain_mode(const struct mmc_data *data)
>> 
>
>
> _______________________________________________
> linux-amlogic mailing list
> linux-amlogic@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-amlogic

