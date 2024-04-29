Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 296D36FCB
	for <linux-mmc@vger.kernel.org>; Mon, 29 Apr 2024 07:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714374554; cv=none; b=a3SrJh21axs5wsjlvZ80BoFn31rjALGbLVS81NpoZ+1jOOTT55Q5RSfGs3+kJTv7ydTOAWVmZ3jFppO+s0Asths7eiFlQuy4jlK9QOXPdrPH4dimqNuI2pZsW6rTJVTQrmCmn3Jy3CdFDbNH+4yQ3i2jAZQRo5k6f2uPvbTsXgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714374554; c=relaxed/simple;
	bh=oBwI1sD+Fose8cRRx5ZE+F88sYAmiYTA1ItXxBYLO9w=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=Z4Vh4QIPwlseah0EQx92dnSyjx3F0MmSGvTsXPiA7M41rK8ftFPR6RQsfKAb/VFonon+8st0Gy/xra/3W4MXO0/ZP/ed0/okXjrJdROCUvE3PdfAabFaaf3Ji8U2mINCBNsquamqiBRLjp4o2/27C56fvpgnWVS7PHVsMf07Lb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=m52dl93g; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="m52dl93g"
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1714374550;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Sn/F6ybE1nxOiK0RADlCSlfvvLYyScRFZdtuB3RdW/U=;
	b=m52dl93g+kItg0EmEIhGpwA0gMT/npJ5RUVUgPr1//NKCHmYzuQPfgxBoUnLJkSAzMAipL
	dBsp6Dki843qY7Ms/p31oneuYdHaYoeb3zejeXxj/0+t8crse0K/NpUQm9eemw1LrYFDNk
	yjoWL71tJxLyyZ0CQdsihIUUcTPOF+HwICV2zhuJKAdjrGqcjU2pExb2T/acNe/K7YR4zY
	np4ksM/N9S2icV2Q+7jTZ76AzodVQjaUAdn/4a9oSvu9ubx24DTRy6UpwqBeoUYgdBTSCm
	Njb4oHFISGrp62pTfypzV4/v+8ZAMKoen86BArgn7fpGnDGdahkQmLKCqxG2UQ==
Date: Mon, 29 Apr 2024 09:09:09 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Felix Qin <xiaokeqinhealth@126.com>
Cc: ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, Avri Altman
 <avri.altman@wdc.com>
Subject: Re: [PATCH v3 1/1] mmc: core: increase the timeout period of the
 ACMD41 command.
In-Reply-To: <20240429063847.162247-1-xiaokeqinhealth@126.com>
References: <20240429063847.162247-1-xiaokeqinhealth@126.com>
Message-ID: <a8d9ed3ae3b6d884235594e31baa28ff@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Felix,

On 2024-04-29 08:38, Felix Qin wrote:
> Extensive testing has shown that some specific SD cards require an
> increased command timeout to be successfully initialized.
> 
> More info:
> Platform: Rockchip SoC + DW Multimedia host Controller
> SD card: Xvv microSD CMH34A17TMA12 (Made in Korea)
> Note: The SD card is custom-made by the customer in collaboration
> with the wafer foundry.
> 
> Signed-off-by: Felix Qin <xiaokeqinhealth@126.com>
> Acked-by: Avri Altman <avri.altman@wdc.com>
> Reviewed-by: Dragan Simic <dsimic@manjaro.org>

Huh, the v3 looks nowhere like the v2, so please consider
my Reviewed-by tag revoked until I get some time to check what
actually happened to the patch.

> ---
> v2: Add more info
> v3: Based on the __mmc_poll_for_busy API for modification
> ---
>  drivers/mmc/core/sd_ops.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/core/sd_ops.c b/drivers/mmc/core/sd_ops.c
> index 3ce1ff336826..a1c028303ba7 100644
> --- a/drivers/mmc/core/sd_ops.c
> +++ b/drivers/mmc/core/sd_ops.c
> @@ -19,8 +19,13 @@
>  #include "sd_ops.h"
>  #include "mmc_ops.h"
> 
> +/*
> + * Extensive testing has shown that some specific SD cards
> + * require an increased command timeout to be successfully
> + * initialized.
> + */
>  #define SD_APP_OP_COND_PERIOD_US	(10 * 1000) /* 10ms */
> -#define SD_APP_OP_COND_TIMEOUT_MS	1000 /* 1s */
> +#define SD_APP_OP_COND_TIMEOUT_MS	2000 /* 2s */
> 
>  struct sd_app_op_cond_busy_data {
>  	struct mmc_host *host;
