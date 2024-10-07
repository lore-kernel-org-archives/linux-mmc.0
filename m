Received: from msa.smtpout.orange.fr (smtp-70.smtpout.orange.fr [80.12.242.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC1B613B58B;
	Mon,  7 Oct 2024 18:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728325136; cv=none; b=tPWdLQfbQTB5IU9h/zOxmyMhj3fjRRM8RSkXJ6emLudiZNypgsV9l/lCttAu6U4qX12+yOKGa0VMJ6FRGoq/OXO3ai7w6oemOKIuxvvogabNsWGDzMuTdPxBoBXdLBDLi5j5Qg/ogF8hq8VEgnhplXEQLSsNzBEsxJl/4bP0VtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728325136; c=relaxed/simple;
	bh=XmZxPZ8JkLb+//fye6zfG4L5bwmJqgM4PRz5TJ6LBLs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ks2qRdN66rlq0GRI24KwPuJq/v4x5iQy2gC4jE1g+glEBVkPy+7rOfBnt0HxRX1Yr6RZdbJdp5PD3Kz44ELe2A51SRSIXrXLv+OTU5Ype/OUFfKCJ9V+/Q4Nje60eflWmBycfH2ldMC8Q5pwdvCI0IDY95VFe60cIc5+3Tmo5BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=MDifJrNg; arc=none smtp.client-ip=80.12.242.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="MDifJrNg"
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id xsAUsPNLLguzwxsAVszuYO; Mon, 07 Oct 2024 20:09:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1728324555;
	bh=G1CPisHeyZTWeInEMF2Vg7HPLH33I9V0z68PYIvIiTE=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=MDifJrNg64Frq1Mxqp3lU9cEIezPI62Z+4z9D3D/eTtgblnEyiqVgwomMryWGtWbL
	 TCnWKhqcJNsPsZwR+3W79X2zF6zIsvJVubKDVpBSa0nV+OaG3VAHgFbMlrLtD2mJHJ
	 CjkgOH65YMdAHDz3cFyzVE/GdaykfupYT7nl8iMir0isRslEhXt7Xsn0yN4PFGANT6
	 NxQzVWtVfWjeTpk+7IWhikhik1cYX+AWqbtGcuDQR7S4iX6mTRmSjw3xH1qNPC2RyA
	 3to3/XzmwAwq13cRHfGigD1LT8lDhn1ENKHSgWFBY+YmcQMMq63NmdjbBHrSq+hbwq
	 KIPGjMT38xfpQ==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Mon, 07 Oct 2024 20:09:15 +0200
X-ME-IP: 90.11.132.44
Message-ID: <ab1180ff-b435-46c8-82a8-66fea41db110@wanadoo.fr>
Date: Mon, 7 Oct 2024 20:09:14 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: mmc_spi: fix snprintf() output buffer size
To: Bartosz Golaszewski <brgl@bgdev.pl>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <20241007114549.51213-1-brgl@bgdev.pl>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20241007114549.51213-1-brgl@bgdev.pl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 07/10/2024 à 13:45, Bartosz Golaszewski a écrit :
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> GCC 13 complains about the truncated output of snprintf():
> 
> drivers/mmc/host/mmc_spi.c: In function ‘mmc_spi_response_get’:
> drivers/mmc/host/mmc_spi.c:227:64: error: ‘snprintf’ output may be truncated before the last format character [-Werror=format-truncation=]
>    227 |         snprintf(tag, sizeof(tag), "  ... CMD%d response SPI_%s",
>        |                                                                ^
> drivers/mmc/host/mmc_spi.c:227:9: note: ‘snprintf’ output between 26 and 43 bytes into a destination of size 32
>    227 |         snprintf(tag, sizeof(tag), "  ... CMD%d response SPI_%s",
>        |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    228 |                 cmd->opcode, maptype(cmd));
> 
> Increase the size of the target buffer.
> 
> Fixes: 15a0580ced08 ("mmc_spi host driver")
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>   drivers/mmc/host/mmc_spi.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/mmc_spi.c b/drivers/mmc/host/mmc_spi.c
> index 8fee7052f2ef..fa1d1a1b3142 100644
> --- a/drivers/mmc/host/mmc_spi.c
> +++ b/drivers/mmc/host/mmc_spi.c
> @@ -222,7 +222,7 @@ static int mmc_spi_response_get(struct mmc_spi_host *host,
>   	u8 	leftover = 0;
>   	unsigned short rotator;
>   	int 	i;
> -	char	tag[32];
> +	char	tag[43];
>   
>   	snprintf(tag, sizeof(tag), "  ... CMD%d response SPI_%s",
>   		cmd->opcode, maptype(cmd));

'tag' is only used in a dev_dbg() at the end of the function.

Maybe "  ... CMD%d response SPI_%s" could me moved directly within the 
dev_dbg(). This would save a few bytes on the stack, save a snprintf() 
in the normal path and fix the warning without the need of magic number.

just my 2c.

CJ
