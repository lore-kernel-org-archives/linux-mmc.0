Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54BFD12B170
	for <linux-mmc@vger.kernel.org>; Wed, 17 Apr 2024 09:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713345026; cv=none; b=tkjBGbbZ+BzX7GWogabkUqE724b4lpRCXB7JRoE4mXqvlDo/Y1W9V9MdPlBHDJ0LtvhxA0nu/CSBSvNirUQzgs4LUYaUhGqeJxX06SC7EOirWx+R1+Heb+SkQiwpwjALdDD2Q+g2yLnllesVoh6ngtWIZLR05WX2ZB+WlCqk/Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713345026; c=relaxed/simple;
	bh=+QeEIqFP1x7pjxGVBLX2oJJ3QMIreSoze6Axcpun5SQ=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=K0Lr2SY/kjwW+vY4JeDTdVwiSy4wn0R3zoBD5TeZPDFNE5k8cNAwOwYCMEYjGtSxh4tCcoau2JCBpsQYqcQO1vIsawsRYnfqiTjEsJ/6LIKGy4fDRQJXYTNUcz7VsfjaUXlUnYFo7JzwT7/UKk0G4FsdR/ZHhCLqo0Dnt56IXQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=kSsB5pTZ; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="kSsB5pTZ"
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1713345021;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JPZOh8qgnWmEGT/5r73g/lb1+OERAT2Q0obHNfTKROY=;
	b=kSsB5pTZ8PrcAFeIaXtZysBriUEPjEGbqjSGoGeYysW0V3B7wOFUsU9mb9yQXUSLPUq1GX
	L2Oe/9s31xZQM3/dM/xecDr9iSja+CVp5XuiFFu9ocJMaMGQmaY2vhu8thob4YAebRouP1
	ViHOdEDs6tuDmFW0B0BfKNWVG29UcPb3xXp/cC+110R1MOzamJdP25wICzRBNtF67R7ILK
	Wy5Iv4g326nPuJhEsszkt4SanAb7jo22HJK1AyeFqRW0hQFx2/Si7MDeeZiYlxuQBXwaZj
	AvITYffspzVxEKOrm2Jq1427xMrTjBKIfIDzMwGei1f0ksfIeevorj+nFSKkLw==
Date: Wed, 17 Apr 2024 11:10:20 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Felix Qin <xiaokeqinhealth@126.com>
Cc: ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, Avri.Altman@wdc.com
Subject: Re: [PATCH v2 1/1] mmc: core: increase the number of retries of the
 ACMD41
In-Reply-To: <20240417084500.152486-1-xiaokeqinhealth@126.com>
References: <20240417084500.152486-1-xiaokeqinhealth@126.com>
Message-ID: <a440b197809c7c86913ff5aaf0dee69c@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-04-17 10:45, Felix Qin wrote:
> Extensive testing has shown that a few specific SD cards require
> an increase in the number of command retries to successfully
> initialize.
> 
> More info:
> Platform: Rockchip SoC + DW Multimedia host Controller
> SD card: Xvv microSD CMH34A17TMA12 (Made in Korea)
> Note: The SD card is custom-made by the customer in collaboration
> with the wafer foundry.
> 
> Signed-off-by: Felix Qin <xiaokeqinhealth@126.com>
> Acked-by: Avri Altman <avri.altman@wdc.com>

Looking good to me.  Thanks for including the additional details.

Reviewed-by: Dragan Simic <dsimic@manjaro.org>

> ---
> v2: Add more info
> ---
> ---
>  drivers/mmc/core/sd_ops.c | 4 ++--
>  drivers/mmc/core/sd_ops.h | 8 ++++++++
>  2 files changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/core/sd_ops.c b/drivers/mmc/core/sd_ops.c
> index a59cd592f06e..b3b6e8725b80 100644
> --- a/drivers/mmc/core/sd_ops.c
> +++ b/drivers/mmc/core/sd_ops.c
> @@ -127,7 +127,7 @@ int mmc_send_app_op_cond(struct mmc_host *host,
> u32 ocr, u32 *rocr)
>  		cmd.arg = ocr;
>  	cmd.flags = MMC_RSP_SPI_R1 | MMC_RSP_R3 | MMC_CMD_BCR;
> 
> -	for (i = 100; i; i--) {
> +	for (i = SD_APP_OP_COND_RETRIES; i; i--) {
>  		err = mmc_wait_for_app_cmd(host, NULL, &cmd);
>  		if (err)
>  			break;
> @@ -147,7 +147,7 @@ int mmc_send_app_op_cond(struct mmc_host *host,
> u32 ocr, u32 *rocr)
> 
>  		err = -ETIMEDOUT;
> 
> -		mmc_delay(10);
> +		mmc_delay(SD_APP_OP_COND_INTERVAL);
>  	}
> 
>  	if (!i)
> diff --git a/drivers/mmc/core/sd_ops.h b/drivers/mmc/core/sd_ops.h
> index 7667fc223b74..80c5c836ccd1 100644
> --- a/drivers/mmc/core/sd_ops.h
> +++ b/drivers/mmc/core/sd_ops.h
> @@ -10,6 +10,14 @@
> 
>  #include <linux/types.h>
> 
> +/*
> + * Extensive testing has shown that a few specific SD cards require
> + * an increase in the number of command retries to successfully
> + * initialize.
> + */
> +#define SD_APP_OP_COND_RETRIES  200
> +#define SD_APP_OP_COND_INTERVAL 10	/* millisecond */
> +
>  struct mmc_card;
>  struct mmc_host;
