Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF17F1386A1
	for <linux-mmc@vger.kernel.org>; Thu, 15 Feb 2024 16:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708016142; cv=none; b=dSBV/ILC5te+WTpjWaMPlNDizC/rHb6Q+OKodawVSzDTJ9s/Qy6eadSPSsVOhLiKePXmDgVMb81wICZ9Ik8gy0xo1+qnGhozIkcUUYF3HBdbR6+rT4uxSdLZvCl1Zz6JgXchPy+m+Y7fkwjRlIxM2bX8HseMBFiZr+VnBT/G5Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708016142; c=relaxed/simple;
	bh=qvJ5qbwn2BmVDlIUhG5wF9yLSoq3pWBF3UcQUAEUMxE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dfWp+6Gf3t4XMPwMEspi9biOcVMtnd6GQDQxrgwcqWzLJgegUoBQ6OLTFwNiFfAT1uMWTUio5x8PitTPdZTFA9Bjb5jwaFym8QtswaKz0Un2xm284E7+OxXEyGHz4CEi1++uVw2Jk05HItK4rAmZSk3VyznNFYmyGuxY/yledpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fFWQGJSp; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fFWQGJSp"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-607d5af59feso6463457b3.3
        for <linux-mmc@vger.kernel.org>; Thu, 15 Feb 2024 08:55:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708016140; x=1708620940; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mavaEeqDY43r+hbPveMgq+e4V1kSTNuj4BBopaLVP9o=;
        b=fFWQGJSpzgtZp1gvZ2ZpECEMMS3hK0LHHpL3WkZb4W1XxcbMp22tuE5X7k9N9aPYfl
         uMTAr5fazRmETMPwC+IP0ZqW6LkseErbDyuUwNOmP+7DM3+y8kKKtXmvdWKh75z+OXls
         DOlTaCEIIo9bcjacM49bGFLW1cYg0RQVxDPg4E3iCvgEs7w03hLHakYM31lAVORfnHiq
         RgVYtDOmFcw9BpdIvdOx8m1uNm+nHq1F3MvCSHdwZX0skhwyPn8IBhj+x1Os0K3bMGWd
         MVZxI25g8UNd0vwpWxDOc1b9JPhW7M4KSHHoD7vtmEpmUC8cfHFs9jBpxKyw7VLLyAeF
         AcWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708016140; x=1708620940;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mavaEeqDY43r+hbPveMgq+e4V1kSTNuj4BBopaLVP9o=;
        b=oUBGFzpueRVwM6sKTtZ6xtc1ynyakL8pMAo74xG1MocHybE5GEWbDTTsZRg/ok1Kyr
         PxDJsqD/hz5XybP85O2ANWWA/bq1OXlcDe0PU+9k9xR+aMZRbhUjuEHpHNWnaZNSJjZH
         zKbwS76z+VKI8FK57M6T9ne5+VHJOUX8fnHCh/O+z7rOYQdQCc4rYLQpZL+fk89a3HMM
         dn6AzNAtYa2riHjdKfhZ+d04vwTAm0XPk64nFhno2XKbpg2tRwZBioXJdcqIlITloihz
         u7TJUAdVoxrULigrRdZy4fjhYJRvlWWg44IoAonxI2OVSumAuP1kXuR3lzDzKNTj9GBu
         BXag==
X-Forwarded-Encrypted: i=1; AJvYcCVz2RtmDhODMuSGxZPAjpuiboGbL+MiwKDaBaGxYMXgkTA/LH2SCKrxT4aj30onqbvl4Jx6zhd/W2vIth4yI9VZnQLZaiHhDc9a
X-Gm-Message-State: AOJu0YyjoOAGwvoADuGBj/ctvI7uHIGj/c4uc5bs0HdSRbJdLqmJMncg
	OeyibDTJK9KmrToR+QK8Am3JarMiCYNsK8g750ZW2p8KsMldj4kyfAtT+wZGGq+BUUr5n9eeIKu
	FBpVikektTOI9eZlJQ0Y1QpC7G/rD8rMCmERB4Q==
X-Google-Smtp-Source: AGHT+IEmnEUIgHPSNuLrZq9N8eJn1ypwTTeIQisd+2mSZZhFJ7DAsspyNvt6N62JeqEiZnmoIVAQ6ki/uIYU6o0wnTc=
X-Received: by 2002:a81:b049:0:b0:607:db04:1591 with SMTP id
 x9-20020a81b049000000b00607db041591mr1602884ywk.14.1708016139721; Thu, 15 Feb
 2024 08:55:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240215-mmc-fix-davinci-v1-1-a593678ca7bf@linaro.org>
In-Reply-To: <20240215-mmc-fix-davinci-v1-1-a593678ca7bf@linaro.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 15 Feb 2024 17:55:04 +0100
Message-ID: <CAPDyKFpAaQWaXMWUH4o+theu_AWmNMPu7Nub4vqgYfOaZKUHKA@mail.gmail.com>
Subject: Re: [PATCH] mmc: davinci_mmc: Drop dangling variable
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, linux-mmc@vger.kernel.org, 
	kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 15 Feb 2024 at 14:28, Linus Walleij <linus.walleij@linaro.org> wrote:
>
> The sg_miter conversion left a dangling unused variable.
> Drop it.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202402142042.vg0lnLdb-lkp@intel.com/
> Fixes: ed01d210fd91 ("mmc: davinci_mmc: Use sg_miter for PIO")
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/davinci_mmc.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/mmc/host/davinci_mmc.c b/drivers/mmc/host/davinci_mmc.c
> index c46577305138..8bd938919687 100644
> --- a/drivers/mmc/host/davinci_mmc.c
> +++ b/drivers/mmc/host/davinci_mmc.c
> @@ -211,7 +211,6 @@ static void davinci_fifo_data_trans(struct mmc_davinci_host *host,
>                                         unsigned int n)
>  {
>         struct sg_mapping_iter *sgm = &host->sg_miter;
> -       size_t sglen;
>         u8 *p;
>         unsigned int i;
>
> @@ -224,7 +223,6 @@ static void davinci_fifo_data_trans(struct mmc_davinci_host *host,
>                 return;
>         }
>         p = sgm->addr;
> -       sglen = sgm->length;
>
>         /* NOTE:  we never transfer more than rw_threshold bytes
>          * to/from the fifo here; there's no I/O overlap.
>
> ---
> base-commit: 26d7d52b6253574d5b6fec16a93e1110d1489cef
> change-id: 20240215-mmc-fix-davinci-bda788e8ee69
>
> Best regards,
> --
> Linus Walleij <linus.walleij@linaro.org>
>
