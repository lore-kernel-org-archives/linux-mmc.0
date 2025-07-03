Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C7AA23C512
	for <linux-mmc@vger.kernel.org>; Thu,  3 Jul 2025 14:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751552310; cv=none; b=SUnfMuVUhTSm+eyQrAcw6x7+wXHb4UW9Y7RAznjxKOh5KkaFkmqXc7zX7dTCvrsajXzJJfBvzKvWmIWme3+tGsDTIi9/+8HfV5vvms8a95xbiNqoOjgGKJaJFRhGxeSlnrCMDBampnylLH9DMzepkhfAHkgakj7sJIjZIBcFTHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751552310; c=relaxed/simple;
	bh=ERH+Sdv7GXno1Imeo+4fgGH4RS9yil0Gw9IjwI0Jnx4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ilw8ni6JLN4leO44rfC4yKZKXMIYKpEoGa2J3+iflzMxuW46qLqGz1NguFR3lRJp9bG7+eM96XA8CJUb4vwfVozJ3a3lAVm803SNeIBEiMBz/HR+28iWAVk/WuJ1ICkbYz9aMXrt90R3C4KUb2YOmolrWfQkc04Pn7hC82jft1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FbAeuY7o; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FbAeuY7o"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-71101668dedso82396957b3.1
        for <linux-mmc@vger.kernel.org>; Thu, 03 Jul 2025 07:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1751552308; x=1752157108; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WsE5lpOllDAHOtA1Ajy5IFanrHLSYP8QdOkPhO+rymo=;
        b=FbAeuY7oExE/pF171QDUOo2yD62yl0DlX8FX5hYgAN7upq93MYqzc6u2DVCGYGJKfw
         BO83FsnksPggPAwcdLBUEAaSAVzkBoS0AtNNn7Gwhbr3v2mH3QPUrYg1w6gLlVlwZhW5
         ZZTKL4qltBZxsVUAUX2f7VP4bpc9hySxa4+BC6KUYsNCUM7nRVD8f//MoD37TFUHAbHs
         zlJuHq4aP5HCFQa96Y2Zsp2nkznEXsR/FU/Cqbr5oB1wGjrGOtx6a9zOeYMtZ8CvnTOs
         /2ovOs2W/yaCVLjPLYbBo457wqajbmynwZaLMMeYtIXayCAsKVCP9VlER9A0915LnL6j
         2eHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751552308; x=1752157108;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WsE5lpOllDAHOtA1Ajy5IFanrHLSYP8QdOkPhO+rymo=;
        b=mQ+8J80J0XYj/onih68tANl+/NQjjE4cEq1tl5ARcfbrg2cAOfE6vCjgcdpgBGSX56
         hVs5//b5eAViuNkcTls9Sh6nICVlxPZQZETcm6qQYsO0fEg8S8QxuCaxEgANc3YXLiSr
         5sPssB5IeEQ8YOooJOMy9lCIuxiE3jJYkh58+iOq2MfhzcSRC1uAd5TyDWTq8daKPmCq
         Z87/8d1yQEDoS69O9BiZ+kery4U67yoOma7VK1fUyxsoqa++d+1VgQAFNexVH2wQWiaE
         FoN4r/p2oPKgvVl4ngW3JM+JnC+HIT2S7vuhCu1EJ+rZMPxJ1Ng/QbI60Ugo12hQmFIr
         /mIQ==
X-Gm-Message-State: AOJu0Yw4sXV9ARsq7ZusttZCGKnuQZct0Q/GGmZUZ4fCg8MDvOXzbGt9
	57zOjdv8AMxWWAwqQpzJH+niC96zEWNrVlTxGNs7PuRk2JxyJ3n79lXrXxVFtb8kCzV+zW0hMEL
	nBcH4kXMDwv3HDHhbxrre3QKRXtwaV0s6e99Dg1Z5SdMNaOLg0OrJ
X-Gm-Gg: ASbGnct3f1HbmPXGMYm87kfKTzxOGD5FzxKmdER9Z6ml8yTCa0wOHJF6n/T7djG/jJH
	BhIW0br1lWqLEBnRsZ3U914XfhK7SkxME2WjFWjZPFpogHbef7U5BPe8eIoElmDQIwM+sWhHzM4
	xBndTwZM0B6t+zyqMZCqPzxwiI0Gbh3/K7SrzwtrX0Pl/taNB0YKpYky0=
X-Google-Smtp-Source: AGHT+IFne2vi8SBKEYL2sGkgL3IDhj2qT6iWgMFzfsnPufKFonhOFi6RGSaWlWuX1YUxQJny5x2OvtnhMhn8H39giuU=
X-Received: by 2002:a05:690c:dd1:b0:712:cc11:af0 with SMTP id
 00721157ae682-7164d0f8231mr98704517b3.0.1751552307975; Thu, 03 Jul 2025
 07:18:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250703054845.49206-1-avri.altman@sandisk.com>
In-Reply-To: <20250703054845.49206-1-avri.altman@sandisk.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 3 Jul 2025 16:17:51 +0200
X-Gm-Features: Ac12FXyhg7ierCYV8KD-W6BXHGifE0tQUH9uwFcu5Qlvv_ndkVdE-tPBzphVSeE
Message-ID: <CAPDyKFqUueREyxgCx5E=2Ytz8doi9f9DhXcwzNZ=F=7YF7LCxA@mail.gmail.com>
Subject: Re: [PATCH] mmc-utils: Remove unnecessary null pointer checks
To: Avri Altman <avri.altman@sandisk.com>
Cc: linux-mmc@vger.kernel.org, Markus Elfring <Markus.Elfring@web.de>
Content-Type: text/plain; charset="UTF-8"

On Thu, 3 Jul 2025 at 07:49, Avri Altman <avri.altman@sandisk.com> wrote:
>
> Simplify memory cleanup by removing redundant NULL checks before calling
> free() on pointers. Markus suggested it following static analysis by
> Coccinelle.
>
> Suggested-by: Markus Elfring <Markus.Elfring@web.de>
> Signed-off-by: Avri Altman <avri.altman@sandisk.com>

Applied for mmc-utils master, thanks!

Kind regards
Uffe


> ---
>  mmc_cmds.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
>
> diff --git a/mmc_cmds.c b/mmc_cmds.c
> index 7994223..b16ac69 100644
> --- a/mmc_cmds.c
> +++ b/mmc_cmds.c
> @@ -3421,8 +3421,7 @@ static int __do_ffu(int nargs, char **argv, enum ffu_download_mode ffu_mode)
>                 fprintf(stderr, "FFU finished successfully\n");
>
>  out:
> -       if (fw_buf)
> -               free(fw_buf);
> +       free(fw_buf);
>         close(img_fd);
>         close(dev_fd);
>         return ret;
> @@ -3651,10 +3650,8 @@ int do_alt_boot_op(int nargs, char **argv)
>         ret = 0;
>
>  alloced_error:
> -       if (mioc)
> -               free(mioc);
> -       if (boot_buf)
> -               free(boot_buf);
> +       free(mioc);
> +       free(boot_buf);
>  boot_data_close:
>         close(boot_data_fd);
>  dev_fd_close:
> --
> 2.34.1
>
