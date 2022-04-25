Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 643CDC433EF
	for <linux-mmc@archiver.kernel.org>; Mon, 25 Apr 2022 10:40:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239170AbiDYKnn (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 25 Apr 2022 06:43:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240540AbiDYKn1 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 25 Apr 2022 06:43:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4AE4E1BEA6
        for <linux-mmc@vger.kernel.org>; Mon, 25 Apr 2022 03:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650883220;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3Y91YY01N7UrHQaQhke//8ISQGGOkcgPe3+Pz+wp220=;
        b=a91AdZ5R3mmFPVXYfDS8+B482x8zf7thMir50II1Qvws0HLCro1GD58zN0ChrxI+a31eQM
        SOP6AzNudTsAWndmii5UT+tSx45fVmFKJLfvhrb+UqiNeMnxZ4Lid2O3cyiR3cvwOWkFAe
        xnGwbmqIm8XVMhWO7vWCd1nNXmkGwVs=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-50-09KQFt0LPymNdtLTtYpLfA-1; Mon, 25 Apr 2022 06:40:19 -0400
X-MC-Unique: 09KQFt0LPymNdtLTtYpLfA-1
Received: by mail-ed1-f69.google.com with SMTP id cz24-20020a0564021cb800b00425dfdd7768so1457825edb.2
        for <linux-mmc@vger.kernel.org>; Mon, 25 Apr 2022 03:40:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=3Y91YY01N7UrHQaQhke//8ISQGGOkcgPe3+Pz+wp220=;
        b=3nFHNwqvQ5QQS59vrzZ/kJa+ZWf3uo4s6tyaa6OLqe68ikTXhOGlPc03Ugo2xX5Ht2
         gKnwtoiWNFyFI+7fxeuRRaqR3v/wGYUxaQyDeIBd18DytcDCv8NzMf+N8go0zfgqCQj4
         oqNID4B6s/euAT79BoYaqRcRZzfAOhTTglZbSD5MWnvLFFOyt9yqpAPrcNUOW6x8DmMV
         EXKhN3VAJKeVUDoo2iPuUDGy6f4805orfsYDTb8dNNdbXoC0eMm9GDuIdRCjZfkGAUWj
         mQaOFe3MQileNjttXEyX58NmEGQJ1na3FK97/hr5H3VDcP7wC6dh9v91uCCWbtKOrNKi
         QT0A==
X-Gm-Message-State: AOAM530T/ZxO+qGHDhFabq1fn1YFow2gfvy6yra+fhHG/092qynS4+Kz
        Jikx02xVOQtBDPckd1diNgFfWmsNtIxqAVhsCkfEsjpZKwWx0x1BsUenjO6BxcKgkRi2FF5Qw7k
        lP7aZf5DtTsLun9MAKrDs
X-Received: by 2002:a17:907:c243:b0:6f3:953d:6e2 with SMTP id tj3-20020a170907c24300b006f3953d06e2mr4143258ejc.506.1650883217950;
        Mon, 25 Apr 2022 03:40:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyUrVv8ZCepa/U3q4uft3AB87DDPX1VjjBR7uWVrYkmmUi98hEXzpSCu5QtPh8Y6mSgOFXzlg==
X-Received: by 2002:a17:907:c243:b0:6f3:953d:6e2 with SMTP id tj3-20020a170907c24300b006f3953d06e2mr4143246ejc.506.1650883217736;
        Mon, 25 Apr 2022 03:40:17 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id q11-20020a170906144b00b006cf61dfb03esm3481489ejc.62.2022.04.25.03.40.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Apr 2022 03:40:16 -0700 (PDT)
Message-ID: <dcc1b028-7e53-cb94-9a66-41890393f2ed@redhat.com>
Date:   Mon, 25 Apr 2022 12:40:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] mmc: sunxi-mmc: Correct the maximum segment size
Content-Language: en-US
To:     Samuel Holland <samuel@sholland.org>,
        Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>, Chen-Yu Tsai <wens@csie.org>,
        Chris Ball <chris@printf.net>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Mike Turquette <mturquette@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev
References: <20220424230640.31735-1-samuel@sholland.org>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220424230640.31735-1-samuel@sholland.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Samuel,

On 4/25/22 01:06, Samuel Holland wrote:
> According to the DMA descriptor documentation, the lowest two bits of
> the size field are ignored, so the size must be rounded up to a multiple
> of 4 bytes. Furthermore, 0 is not a valid buffer size; setting the size
> to 0 will cause that DMA descriptor to be ignored.
> 
> Together, these restrictions limit the maximum DMA segment size to 4
> less than the power-of-two width of the size field.

I assume that you were seeing some problems where things where not working
which caused you to investigate this; and that this patch fixes those
problems?   If yes then it would be good to also mention the problems +
investigative process in the commit message.

I'm no longer involved in sunxi development, but still I wonder if the
substraction of 4 from the max_seg_size is really necessary? This seems
to be based on the notion that as you say "0 is not a valid buffer size"
where as the code so far has been operating under the assumption that
putting 0 in sunxi_idma_des.buf_size means maximum buf-size.

I'm pretty sure that 0 meaning maximum buf-size is correct for at least
the older chips where idma_des_size_bits equals 13, which means that
only 2 4K pages fit in a single desc, so we almost certainly have been
hitting this code path ?

Although: drivers/mmc/host/dw_mmc.c which seems to be for similar
hw suggests that on designs where idma_des_size_bits == 13 only
4k can be used, which sorta matches what you are doing here except
that you limit things to 8k - 4 instead of to just 4k.

Anyways I was just wondering about all this...

Regards,

Hans



> 
> Fixes: 3cbcb16095f9 ("mmc: sunxi: Add driver for SD/MMC hosts found on Allwinner sunxi SoCs")
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
> 
>  drivers/mmc/host/sunxi-mmc.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
> index c62afd212692..4bd5f37b1036 100644
> --- a/drivers/mmc/host/sunxi-mmc.c
> +++ b/drivers/mmc/host/sunxi-mmc.c
> @@ -214,6 +214,9 @@
>  #define SDXC_IDMAC_DES0_CES	BIT(30) /* card error summary */
>  #define SDXC_IDMAC_DES0_OWN	BIT(31) /* 1-idma owns it, 0-host owns it */
>  
> +/* Buffer size must be a multiple of 4 bytes. */
> +#define SDXC_IDMAC_SIZE_ALIGN	4
> +
>  #define SDXC_CLK_400K		0
>  #define SDXC_CLK_25M		1
>  #define SDXC_CLK_50M		2
> @@ -361,17 +364,15 @@ static void sunxi_mmc_init_idma_des(struct sunxi_mmc_host *host,
>  {
>  	struct sunxi_idma_des *pdes = (struct sunxi_idma_des *)host->sg_cpu;
>  	dma_addr_t next_desc = host->sg_dma;
> -	int i, max_len = (1 << host->cfg->idma_des_size_bits);
> +	int i;
>  
>  	for (i = 0; i < data->sg_len; i++) {
>  		pdes[i].config = cpu_to_le32(SDXC_IDMAC_DES0_CH |
>  					     SDXC_IDMAC_DES0_OWN |
>  					     SDXC_IDMAC_DES0_DIC);
>  
> -		if (data->sg[i].length == max_len)
> -			pdes[i].buf_size = 0; /* 0 == max_len */
> -		else
> -			pdes[i].buf_size = cpu_to_le32(data->sg[i].length);
> +		pdes[i].buf_size = cpu_to_le32(ALIGN(data->sg[i].length,
> +						     SDXC_IDMAC_SIZE_ALIGN));
>  
>  		next_desc += sizeof(struct sunxi_idma_des);
>  		pdes[i].buf_addr_ptr1 =
> @@ -1420,7 +1421,8 @@ static int sunxi_mmc_probe(struct platform_device *pdev)
>  	mmc->max_blk_count	= 8192;
>  	mmc->max_blk_size	= 4096;
>  	mmc->max_segs		= PAGE_SIZE / sizeof(struct sunxi_idma_des);
> -	mmc->max_seg_size	= (1 << host->cfg->idma_des_size_bits);
> +	mmc->max_seg_size	= (1 << host->cfg->idma_des_size_bits) -
> +				  SDXC_IDMAC_SIZE_ALIGN;
>  	mmc->max_req_size	= mmc->max_seg_size * mmc->max_segs;
>  	/* 400kHz ~ 52MHz */
>  	mmc->f_min		=   400000;

