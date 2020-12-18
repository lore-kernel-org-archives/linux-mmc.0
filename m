Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F195C4361B
	for <linux-mmc@archiver.kernel.org>; Fri, 18 Dec 2020 09:10:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F20A923A7B
	for <linux-mmc@archiver.kernel.org>; Fri, 18 Dec 2020 09:10:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733121AbgLRJJr (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 18 Dec 2020 04:09:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733118AbgLRJJq (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 18 Dec 2020 04:09:46 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F900C0617A7
        for <linux-mmc@vger.kernel.org>; Fri, 18 Dec 2020 01:09:06 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id w5so1291130wrm.11
        for <linux-mmc@vger.kernel.org>; Fri, 18 Dec 2020 01:09:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=KJrDC06cZ0SpABxvrfpFdiN11jLrtZ0nLH/aYVW+QaQ=;
        b=KIvu4XctqG3iWAW1rMqin4vw90x6wDijOFhioi9BfBT2GaaTEc+JAQgpBjULRGj4Bh
         rbf0YAHdWMk7fsBltrgz48AJR1wSSnCHyo+C6ZQ2FZQuW2bXQJ+0Rdm5ncO6D7FUDihs
         tOUNlbWYkOUOcnpySOo6GQyXPFkdOHyx7OMKqXhKK45surAFbN2YSs9NijollyKpyT4c
         NVEc/eHQLgjtRU9wEVP9G2Id9G9/fsz5pZQfk2LPvTHmTnGEZ5NmBvlxGZe6AGDJ5Ua0
         EOVSuj6QzBU9oIIqCsFn05tfAtzzfBXfPC0hkDeOqjD6/0OuoRS/Zzqd+V9JP5XzEsX4
         KOUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=KJrDC06cZ0SpABxvrfpFdiN11jLrtZ0nLH/aYVW+QaQ=;
        b=O6js6m7te/dGadE1Ng4TCQ/kOYy8Jb1rXM/e7R0fhyxdodvywV8UVVaF7ulx08E2aJ
         SCLJTs4Ohea6m2c+sDbxll0k9M4/V8zEy4Haf3GhuDdI+5qlUzn8T85qwfgYX2IrjTKZ
         J4kGcCkS/BncIEcUGLMulmhMVC1TqS4eLlnStiFiNNL7BwheuSh3Mk/08pFQbqDmkQC7
         /jQdcuJ9O3UXOjQdomN9XAitZ2TaZRB6apCXHDQ0ROq0Gf575vTP+JUpCjLco9kC8A7e
         /vjlVQfQEXG4NuI4/bBfmWfrjzVM2VwxlLd/9aak+unRzWLBENKpZz4p+inLQLpnjH/W
         dIJw==
X-Gm-Message-State: AOAM533i5FsFMpSdBg7zt0yEVcdu9Z9LTlCnuDb0FEhosVj2A7YE7cZe
        5ijSfDS6I0RdtaxQFORLL4U=
X-Google-Smtp-Source: ABdhPJzxwU1zdZDWToSWLG1H9Tb8Dcht4DsqJlZQ+QYBJSeQMabp0NVOXBBSwyJ9GVy0ZGjaAE1gqg==
X-Received: by 2002:a5d:47cc:: with SMTP id o12mr1944215wrc.236.1608282545045;
        Fri, 18 Dec 2020 01:09:05 -0800 (PST)
Received: from ?IPv6:2003:ea:8f06:5500:4c80:78d4:f61b:d5eb? (p200300ea8f0655004c8078d4f61bd5eb.dip0.t-ipconnect.de. [2003:ea:8f06:5500:4c80:78d4:f61b:d5eb])
        by smtp.googlemail.com with ESMTPSA id l8sm11488894wmf.35.2020.12.18.01.09.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Dec 2020 01:09:04 -0800 (PST)
Subject: Re: [PATCH] mmc: meson-gx: check for scatterlist size alignment in
 block mode
To:     Dmitry Lebed <lebed.dmitry@gmail.com>,
        linux-amlogic@lists.infradead.org
Cc:     linux-mmc@vger.kernel.org, martin.blumenstingl@googlemail.com
References: <20201218075312.67338-1-lebed.dmitry@gmail.com>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <b52f9e34-5170-59a0-fede-96cf2f999600@gmail.com>
Date:   Fri, 18 Dec 2020 10:08:59 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20201218075312.67338-1-lebed.dmitry@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Am 18.12.2020 um 08:53 schrieb Dmitry Lebed:
> Enable SGDMA support for SD_IO_RW_EXTENDED and add proper check
> for scatterlist size alignment in block mode.
> 
> According to documentation, in SDIO block mode meson-gx DMA could
> only handle buffers with sizes that are multiples of SDIO block size.
> 
> Some SDIO drivers like brcmfmac use scatterlist API, but do not enforce
> proper scatterlist buffer size alignemnt, this looks like a root cause
> of non-working CMD53.
> 
It's been too long ago that I worked on this to provide real feedback.
Just one comment: Your commit description sounds like there's a problem
in drivers like brcmfmac. Wouldn't it be better then to first fix these
drivers?

> Some minor style fixes.
> 
> Signed-off-by: Dmitry Lebed <lebed.dmitry@gmail.com>
> ---
>  drivers/mmc/host/meson-gx-mmc.c | 37 ++++++++++++++++++++-------------
>  1 file changed, 22 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
> index 13f6a2c0ed04..eb6c02bc4a02 100644
> --- a/drivers/mmc/host/meson-gx-mmc.c
> +++ b/drivers/mmc/host/meson-gx-mmc.c
> @@ -227,7 +227,6 @@ static void meson_mmc_get_transfer_mode(struct mmc_host *mmc,
>  	struct mmc_data *data = mrq->data;
>  	struct scatterlist *sg;
>  	int i;
> -	bool use_desc_chain_mode = true;
>  
>  	/*
>  	 * When Controller DMA cannot directly access DDR memory, disable
> @@ -237,25 +236,33 @@ static void meson_mmc_get_transfer_mode(struct mmc_host *mmc,
>  	if (host->dram_access_quirk)
>  		return;
>  
> -	/*
> -	 * Broken SDIO with AP6255-based WiFi on Khadas VIM Pro has been
> -	 * reported. For some strange reason this occurs in descriptor
> -	 * chain mode only. So let's fall back to bounce buffer mode
> -	 * for command SD_IO_RW_EXTENDED.
> -	 */
> -	if (mrq->cmd->opcode == SD_IO_RW_EXTENDED)
> -		return;
> +	if (data->blocks > 1) {
> +		/*
> +		 * In block mode DMA descriptor format, "length" field indicates
> +		 * number of blocks and there is no way to pass DMA size that
> +		 * is not multiple of SDIO block size, making it impossible to
> +		 * tie more than one memory buffer with single SDIO block.
> +		 * Block mode sg buffer size should be aligned with SDIO block
> +		 * size, otherwise chain mode could not be used.
> +		 */
> +		for_each_sg(data->sg, sg, data->sg_len, i) {
> +			if (sg->length % data->blksz) {
> +				WARN_ONCE(1, "unaligned sg len %u blksize %u\n",
> +					  sg->length, data->blksz);
> +				return;
> +			}
> +		}
> +	}
>  
> -	for_each_sg(data->sg, sg, data->sg_len, i)
> +	for_each_sg(data->sg, sg, data->sg_len, i) {
>  		/* check for 8 byte alignment */
> -		if (sg->offset & 7) {
> +		if (sg->offset % 8) {
>  			WARN_ONCE(1, "unaligned scatterlist buffer\n");
> -			use_desc_chain_mode = false;
> -			break;
> +			return;
>  		}
> +	}
>  
> -	if (use_desc_chain_mode)
> -		data->host_cookie |= SD_EMMC_DESC_CHAIN_MODE;
> +	data->host_cookie |= SD_EMMC_DESC_CHAIN_MODE;
>  }
>  
>  static inline bool meson_mmc_desc_chain_mode(const struct mmc_data *data)
> 

