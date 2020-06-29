Return-Path: <SRS0=XB32=AK=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3715C433E1
	for <linux-mmc@archiver.kernel.org>; Mon, 29 Jun 2020 21:40:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C153A2072D
	for <linux-mmc@archiver.kernel.org>; Mon, 29 Jun 2020 21:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593466832;
	bh=t6v5DZt1l1daNu/bUPS5nyAIjtuuXbZlqsHTaDwr+nM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=louGoV6y0WGg/zBbMm3A8HlMry5PtGAh2/LVbRHwCJ8qXPSsnqUkx+Oma+R4o245C
	 j07zniT5WLaZplvzwVTBvuEh2ZygLmxx2OVPff72MCfraBZrJDd7IIXEwxv/7bAldn
	 HE0RV6wm7kaJVp2H1fYYvhwb84IKzPKFDItJo37U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727052AbgF2Vkb (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:40:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:60594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726818AbgF2Sk1 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 29 Jun 2020 14:40:27 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 17ECB206E2;
        Mon, 29 Jun 2020 08:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593417790;
        bh=t6v5DZt1l1daNu/bUPS5nyAIjtuuXbZlqsHTaDwr+nM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0M9Maneao5FvAVD0BmAOoIxq7d6OuBmjWSWAKjDQM+J0/8XN5KzRFqh+90I/UyfL8
         +jKxBhB5WxBjt4qsg4gGdLiJyoRjivO57nxPIMmqRU2kUKAh6EwYKsRIbnvQ8tw64V
         8npSKbq+Guk1jcRBXhg00ia8tVkekCzqeMa/1b7A=
Received: by pali.im (Postfix)
        id 3078B81F; Mon, 29 Jun 2020 10:03:08 +0200 (CEST)
Date:   Mon, 29 Jun 2020 10:03:08 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     haibo.chen@nxp.com
Cc:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org, linux-imx@nxp.com, fugang.duan@nxp.com,
        dianders@chromium.org, huyue2@yulong.com, mka@chromium.org
Subject: Re: [PATCH] mmc: sdio: fix clock rate setting for SDR12/SDR25 mode
Message-ID: <20200629080308.2763brhbflqwauad@pali>
References: <1592813959-5914-1-git-send-email-haibo.chen@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1592813959-5914-1-git-send-email-haibo.chen@nxp.com>
User-Agent: NeoMutt/20180716
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Monday 22 June 2020 16:19:19 haibo.chen@nxp.com wrote:
> From: Haibo Chen <haibo.chen@nxp.com>
> 
> In current code logic, when work in SDR12/SDR25 mode, the final clock
> rate is incorrect, just the legancy 400KHz, because the
> card->sw_caps.sd3_bus_mode do not has the flag SD_MODE_UHS_SDR12 or
> SD_MODE_UHS_SDR25. Besides, SDIO_SPEED_SDR12 is actually value 0, and
> every mode need to config the timing and clock rate, so remove the
> ‘if’ operator.
> 
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>

Hello! I do not know what should be the correct behavior according to
sdio standards, but I tested this patch with DDR50 card and behavior of
that card was not changed, it is working as before.

Tested-by: Pali Rohár <pali@kernel.org>

> ---
>  drivers/mmc/core/sdio.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
> index 0e32ca7b9488..7b40553d3934 100644
> --- a/drivers/mmc/core/sdio.c
> +++ b/drivers/mmc/core/sdio.c
> @@ -176,15 +176,18 @@ static int sdio_read_cccr(struct mmc_card *card, u32 ocr)
>  			if (mmc_host_uhs(card->host)) {
>  				if (data & SDIO_UHS_DDR50)
>  					card->sw_caps.sd3_bus_mode
> -						|= SD_MODE_UHS_DDR50;
> +						|= SD_MODE_UHS_DDR50 | SD_MODE_UHS_SDR50
> +							| SD_MODE_UHS_SDR25 | SD_MODE_UHS_SDR12;
>  
>  				if (data & SDIO_UHS_SDR50)
>  					card->sw_caps.sd3_bus_mode
> -						|= SD_MODE_UHS_SDR50;
> +						|= SD_MODE_UHS_SDR50 | SD_MODE_UHS_SDR25
> +							| SD_MODE_UHS_SDR12;
>  
>  				if (data & SDIO_UHS_SDR104)
>  					card->sw_caps.sd3_bus_mode
> -						|= SD_MODE_UHS_SDR104;
> +						|= SD_MODE_UHS_SDR104 | SD_MODE_UHS_SDR50
> +							| SD_MODE_UHS_SDR25 | SD_MODE_UHS_SDR12;
>  			}
>  
>  			ret = mmc_io_rw_direct(card, 0, 0,
> @@ -537,10 +540,8 @@ static int sdio_set_bus_speed_mode(struct mmc_card *card)
>  	max_rate = min_not_zero(card->quirk_max_rate,
>  				card->sw_caps.uhs_max_dtr);
>  
> -	if (bus_speed) {
> -		mmc_set_timing(card->host, timing);
> -		mmc_set_clock(card->host, max_rate);
> -	}
> +	mmc_set_timing(card->host, timing);
> +	mmc_set_clock(card->host, max_rate);
>  
>  	return 0;
>  }
> -- 
> 2.17.1
> 
