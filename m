Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2292C10957
	for <linux-mmc@vger.kernel.org>; Tue,  7 Oct 2025 14:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759846866; cv=none; b=ugg7cBwyODa/whsis6totHncrKHcWl4gRn1G8/nLWr2dw+tJDGGq0s3fTyMg178/ka4LbKSenuxr/a+x8ze8anDN+9FHPR4OkWKk3RWkoBZaihIW4kQN/zvcMKTTEG6uFCAFQqxfxOuxgYIYMgowl+09S4hvvt+aWmANRcYrJ3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759846866; c=relaxed/simple;
	bh=eYh267DpK0JEPWYWeQXSr0dMemZXuGTwZ1cjG7C/2GY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VVpBUdPyP0HoguTHaPoGUaSK6ii/iKgkM4YbDrFoQ7+s6Ei4glEw1UlpUaalkg9CGqgoF+UF5kEZ2TASOBF92MK3awY6A7glV0Wk+hyebqiq5kUpQKArYBLhHhlLZlcO52CjF8RuodrmSe77xxSwSaOUqlfirj1/ckhim5i96Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VgPjb8FL; arc=none smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VgPjb8FL"
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-635fde9cd06so5978053d50.0
        for <linux-mmc@vger.kernel.org>; Tue, 07 Oct 2025 07:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759846864; x=1760451664; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3kLAmeOzoiivbz2Rz1intsMYvYNbnajfLd/kVGShh0c=;
        b=VgPjb8FLFTlF22SytV36Vx3dd/s2qjET0Vc5Dt/0Doy+Ur71aV1lf/DvzjN/c7VV98
         krkAihFnbiMFOWhL29FWtG1AuPC9huOgwqXXCupYyCy8BtDnIYSTZHRoNOSLX0IEvpil
         TrNLmN1QoQgJr6LGxyNn8L/JhMh5lwB5ckRBGh3rPW8v6ytn7VhEvW3o7gN1iF2953Xx
         mcMZXOIgZmVmBn4Hxgetg86hvwaoKseEZa0JvJJBLSr/jd3P2Cxl4ZtIMa0N+e7IqaxN
         wXjEnEbadMves3wkBfLN7iZENHSqO02V36C3hFKtPxldvAxdvs/xKRUVbx9rWbu3RY71
         X8CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759846864; x=1760451664;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3kLAmeOzoiivbz2Rz1intsMYvYNbnajfLd/kVGShh0c=;
        b=CJCCdZVepyt6IpymZsSxvkRm9hS8eHTLI32IV9aPkgFgq6f48vWyo01M0G+89XlsXf
         UcC7jjJNmeRKKoMgmj76C6yPkVxdzgS+t2gK4Yv6T0dSxRyfSOkWgsSpANnSXcpyTx5D
         VfAJgWfBmxAxOaKO1mdbY90LP+VP+sgF7ArbM/fDxuUMoN49QTaw5//haUeQeUzQwQ5T
         iKxmh9OMn823v5pJyFFEwXP/HV7gCtLI38dG3FcsFYw/I3/MH/NnAIyCiSEt/hMtw8Ml
         0FpQkO34oDFdfToo7m5iQnIoKln6X+ji5MCpepcrV9wK3hLcyx324J7DeQB+TuQGiWTB
         jQ2Q==
X-Forwarded-Encrypted: i=1; AJvYcCUrHjSYvOBsDxgRz37QJgJmL3aNyhud+dDw9+VFpn1KEuGD+GL5UgZYRXjm836+qEDB6EZ01oNjp6E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJJiHTVP/9aFIXnkdzus7wL+BKEaGZQ6TWeuKv31RBsG7Kgm38
	VTcTE+HF2eHjuHWEGZQV+LtYZar7SgyFrGMpbDNDD3ZYRXAIZ6bU8Nf2yU1U6zq924z+GV8z2aB
	CNpWXmVxqmt5ZKuFqjceky/Ukr1a/JoNTJelEYkI8fg==
X-Gm-Gg: ASbGncvlkBWPbw9+dJpSfmtg3i69Uw1xoInWObt93KWXNaMWB9fx9kyooq+EFdVxjYv
	c7swg/Cmat4+LOzB4n/3veJPx0nec7xRHD8XF9dyF4HhvDi1yuVrorpvMGA/22w9uIz9xq4TlJO
	y/OBXW6QnRDif6JJhgNM/heGon2yTxcOnvgDodWRGOMjuer5G8mVPGxG5uzlFljNH9U2+r6wgvx
	+Mm+s5RP62Yv5qZFAIAXfswrIscEfqKatde
X-Google-Smtp-Source: AGHT+IHSu/XJh+M6pXg6w283e6qpfz26caVJ7eid1O8N8+iWFGTtXTS3y40R+fiRfyZEmkxA4OGvQcU2hkcnBIWtEAc=
X-Received: by 2002:a05:690e:2490:b0:633:a47c:6e35 with SMTP id
 956f58d0204a3-63b9a0f0cabmr13114664d50.35.1759846863578; Tue, 07 Oct 2025
 07:21:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251007-mmc-no-advert-v1-1-0e16989d28ef@linaro.org>
In-Reply-To: <20251007-mmc-no-advert-v1-1-0e16989d28ef@linaro.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 7 Oct 2025 16:20:26 +0200
X-Gm-Features: AS18NWAOO_m_RwP1_tkC1Z18kCa67QlTsJoT-fje8jLLTgPaLM6lvL_IB-sGLFk
Message-ID: <CAPDyKFoKV6K5AJgXHrJ0DBycCJZfx9D5cJhDUJjRnTR_W2EegA@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci: Stop advertising the driver in dmesg
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 7 Oct 2025 at 15:15, Linus Walleij <linus.walleij@linaro.org> wrote:
>
> As much as we have grown used to seeing this message on
> every kernel boot, it does not add any technical value.
>
> Demote the init banner to pr_debug() like other similar
> messages in the driver and drop the copyright message
> altogether.
>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/mmc/host/sdhci.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index ac7e11f37af71fa5a70eb579fd812227b9347f83..001802a3aa202c4d8f185ff4924838579ee44c4f 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -4999,9 +4999,8 @@ EXPORT_SYMBOL_GPL(sdhci_remove_host);
>
>  static int __init sdhci_drv_init(void)
>  {
> -       pr_info(DRIVER_NAME
> -               ": Secure Digital Host Controller Interface driver\n");
> -       pr_info(DRIVER_NAME ": Copyright(c) Pierre Ossman\n");
> +       pr_debug(DRIVER_NAME
> +                ": Secure Digital Host Controller Interface driver\n");
>

Why do we need a print at all during module init?

Typically sdhci drivers end up printing a message at the log level if
they succeed to probe in __sdhci_add_host() - along with the other
error/debug messages during ->probe(). That seems sufficient to me,
but I'm not sure what other people think.

Kind regards
Uffe

>         return 0;
>  }
>
> ---
> base-commit: fd94619c43360eb44d28bd3ef326a4f85c600a07
> change-id: 20251007-mmc-no-advert-8f5646c44dd6
>
> Best regards,
> --
> Linus Walleij <linus.walleij@linaro.org>
>
