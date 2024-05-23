Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 529587E574
	for <linux-mmc@vger.kernel.org>; Thu, 23 May 2024 08:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716453017; cv=none; b=BdxNs/Qr6QvV86c3HGkqOTEe6ZXmA+Tb3nKvW8NeKL9W+ih71yQZHOk51yLTFgW4NvdplDLAsQiq6owQrAJ+1RasooFHs8p8feTNoS6a/1wu8iyYh26r4q1UdauheY1qlz1vMPmYtfh8PyLpY9JvjFsztgQysj5aaf2kBLgd8iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716453017; c=relaxed/simple;
	bh=QFFlolgExiov97UFQP4keWeXNEvKYYDaqUUsSeV1nfs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=YQkWu1h9+PY3wjd5gc39V9Gjl1xv506Ndy0D09lLlGqQ1bgA3C4vBwtJA7v/hfJNqadyr9KoNBMLl/w6uRE8z1GsH/ZjGjjKkUklpk1Yd+30X7LLp9eCVDlh4bnYF1q6wfIJqNZCoYeWd2Lb4e6r7pLUgEMBhcbpBgCVrciFKeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5F5FFDA7;
	Thu, 23 May 2024 01:30:38 -0700 (PDT)
Received: from [10.57.4.79] (unknown [10.57.4.79])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 78A783F766;
	Thu, 23 May 2024 01:30:13 -0700 (PDT)
Message-ID: <d9c28991-aaaa-4e7e-8f90-eb1f3b1f7fb7@arm.com>
Date: Thu, 23 May 2024 09:30:11 +0100
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: core: allow detection of locked cards
To: linux-mmc@danman.eu, linux-mmc@vger.kernel.org, ulf.hansson@linaro.org
References: <20240521210455.543587-1-linux-mmc@danman.eu>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <20240521210455.543587-1-linux-mmc@danman.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/21/24 22:04, linux-mmc@danman.eu wrote:
> From: Daniel Kucera <linux-mmc@danman.eu>
> 
> Signed-off-by: Daniel Kucera <linux-mmc@danman.eu>
> ---
>  drivers/mmc/core/sd.c | 19 ++++++++++++++++---
>  1 file changed, 16 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
> index 1c8148cdd..b22c30348 100644
> --- a/drivers/mmc/core/sd.c
> +++ b/drivers/mmc/core/sd.c
> @@ -1475,9 +1475,22 @@ static int mmc_sd_init_card(struct mmc_host *host, u32 ocr,
>  			goto free_card;
>  	}
>  
> -	err = mmc_sd_setup_card(host, card, oldcard != NULL);
> -	if (err)
> -		goto free_card;
> +        u32 card_status;
> +
> +        err = mmc_send_status(card, &card_status);
> +        if (err){
> +                pr_err("%s: unable to get card status\n",
> +                        mmc_hostname(host));
> +                goto free_card;
> +        }
> +
> +        if (card_status & R1_CARD_IS_LOCKED){
> +                pr_warn("%s: card is locked\n", mmc_hostname(host));
> +        } else {
> +                err = mmc_sd_setup_card(host, card, oldcard != NULL);
> +                if (err)
> +                        goto free_card;
> +        }
>  
>  	/*
>  	 * If the card has not been power cycled, it may still be using 1.8V

