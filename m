Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8FC912B156
	for <linux-mmc@vger.kernel.org>; Tue, 16 Apr 2024 16:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713286764; cv=none; b=RD9U7rEZA8Nf4swXNh2a6FRCgRNXudxdfGgylNZQ77Il0CZhcA2CFvpN2AiFIZXPgjt8RH5QZwcabVRsqCxkTWyBXxW8XnIKByaaupFMs0GBAu83DLcNxn9xFB7KDav8J5vUFmnX6aUujtStl5yQHcm7LwZquqXSHXhlMBwag5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713286764; c=relaxed/simple;
	bh=OMAJboWezlSnuVmllcTyvCWnwKagFHDJfhHMEplfjAs=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=fpbACSKbOU5qA0q1C5m1ktMYGx/LRMHDqqsIT88FUsG7/Upk63kXC5IPCdZPB/RqODbIWooRWCCks78ip9HY/12/i0EhxHfwOnmDAydPuPdaNbuR2aNCZKwqt5uGDTHa5VusnV9Uv+DMRCXC5tVxRJXCMsSM0ciZLRILA5CGnng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=J42bH3r5; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="J42bH3r5"
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1713286754;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q4K1b5mUiONJGT07xA7UEAThSFbCPbePNdB1bTOqoSs=;
	b=J42bH3r5NudVqBl0pN5d+xnmgwNXtsCQO4y8BvlIYj6RGKOlaiYDRQdp/WdXM/36HJ4Rp2
	BbxoQlxxppFCdZ7KV0cRiCVlNJrmR6KZaj0njgs+HeHKpWzuJUPvK+4Nl/VMNY4h7U1ppW
	tbTmNVk/QY1MJD5G/4f1cuWXBuxFY2M3nr6jv+nWYUf2kyBA+sKQ2x49iulXKtrs5JMUM3
	OlbdpJ7B5FA3RqSuU5AkAT7GQwRzF4J0IxVOMTGxK77ShUiaPfkZVgHVmB4LMrzuvXzlCB
	nD7B8G1Uq7WWGXubbAyr7z7YtdIWOep7/pFpwxfJcGvYTNspcMDyi1tcIhUaVA==
Date: Tue, 16 Apr 2024 18:59:14 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Felix Qin <xiaokeqinhealth@126.com>
Cc: ulf.hansson@linaro.org, linux-mmc@vger.kernel.org
Subject: Re: [PATCH] mmc: core: increase the number of retries of the ACMD41
In-Reply-To: <20240416145912.114409-1-xiaokeqinhealth@126.com>
References: <20240416145912.114409-1-xiaokeqinhealth@126.com>
Message-ID: <d13bf7701ab694fe273b82318f3c6bc3@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Felix,

On 2024-04-16 16:59, Felix Qin wrote:
> Extensive testing has shown that a few specific SD cards require
> an increase in the number of command retries to successfully
> initialize.

Any chances, please, to include the models of the affected  SD cards
in the patch description, together with the model of the used host
hardware?  That might be helpful to the people wanting to replicate
(or debug further) such card initialization issues.

> Signed-off-by: Felix Qin <xiaokeqinhealth@126.com>
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
