Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531EE21C16F
	for <linux-mmc@vger.kernel.org>; Tue,  3 Sep 2024 12:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725367098; cv=none; b=g8PxqljMI3y3/0mG3gbNHtOjFbKAO6tylOIrz9CcURi2q57La4e9eg+UlmhRJiACvLK8tyNWgiBFq7oe8ilJ+iJLrNg7cKNGxDgqkki9ncOOdajW1imkTEfZxn1WrohY8toNhDKz+WRN1BI//gOsA/fgsGJGM4mC3i2iaUL94v8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725367098; c=relaxed/simple;
	bh=PHFmIYpMuaIPbbtJKB+FFJR7T5QaUXv/5qyIoj3ad+g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nTfJNsBP5EBeTf0ARG74rfjReahY4KEHrA9yvE9YyKgnQTTI+1/Tto8RoA4dYG267mcQHDPSh9a159Zs9hZUYbRITYefpiJnnDUOoGC1GyEFMZitPzYiN8dyGIMev8NcUojHA6geEXyV0bvRjxB392LJ720eTfj+ixRHtau9kDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Sj2258lo; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Sj2258lo"
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e1ce8a675f7so1583865276.3
        for <linux-mmc@vger.kernel.org>; Tue, 03 Sep 2024 05:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725367094; x=1725971894; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lpBdp/bMtiNkcEVqKYlrcjklKfrSjhz3f/Yq+TwUwZ4=;
        b=Sj2258loOHfI0S9QJH67/OsqadWKqyYcvsB7BYTLsKJaawEKUFvg3wQupANOAOVFl7
         63cgCfqfLLe9wPBTJV+8A+IdOkz5uoeJ/pPvnOkOS1DtgE+0NE9bRT23Q1NLC3cNoaAC
         pDVp7Mpm1jZKb04u5tYPf9n7qZEKaV37qIdE1V8/JxSX+W3alFAPc3NwyMvOmlMka5Zb
         8ztohTTVNyTfROPgIY3NInkwgMeq3Dp2rP2DsduZh4oG7gwB0vXbu/OrdCl7wRsHwfCU
         97a4nMCWL7hAwdIuCgLuFH9hDHv40lONxgaP6jiwoq4Ud+GSWmjHRvE29oqpO4nOZjoV
         1Hag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725367094; x=1725971894;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lpBdp/bMtiNkcEVqKYlrcjklKfrSjhz3f/Yq+TwUwZ4=;
        b=hkShTNB0zzv9dMEyo/FRRaq7Qgr2mZMIgx10mHQPpjfhtPNhosqFl2d0OGkD+HShA0
         eYdqSDzgNerTDkYexY/F1xd8wU9VA89Xcd+MHw5SRUpHspyFiEMm9cjJ1kVoNMsq42op
         TfrSYJaff52fqPI4WBATjIVZnJxcVVfwCZ1bTuCZaKansLMP5kEEz3Hx7YKwXPzpGy6u
         QVnFQTn4gU2cg0yPg+HmVSjVfKufoEbZc2QU/C16BW9z6WUxS56xUTN/cX6Xgu/RzBzG
         c7+dzHkzNU1641LT2Ox8JTZX6Vui9Udq9GvbZubWf3Cr8dCliAofuEie/MmnIlAs+GGg
         Li8A==
X-Forwarded-Encrypted: i=1; AJvYcCV0SOvg8rm2asad6p3L3xBvupkOUO8yMMum3NJo0XNAtapOQNgD85PtW8ln9hqqANLb5PGd5d08Tgg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdM2T12fJWjW/64/j6U/PlRk/R6WpYx0+1BqX67eLB+5OfeoEZ
	et5yatYhtQFDKgFtTh4JYec7dxMyiN6n9mLHmB04vjx5dSMvY1HOrGwPIB7ugaER5ske8nxCSVl
	RzYQ3QqHOjVEhuWbnkQYZYP04S6Wxj3YF8chSxg==
X-Google-Smtp-Source: AGHT+IGtMZcAL/iFXk0ke4oDxanFeDAd8/aJAnGd4nVHUxQM2zNPpeWSAwWuQJ55JPaYKdFUZSETDX7DSJeBRKTavng=
X-Received: by 2002:a05:6902:1088:b0:e0e:cd17:610a with SMTP id
 3f1490d57ef6-e1a79fbec69mr16502764276.6.1725367094246; Tue, 03 Sep 2024
 05:38:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240902151231.3705204-1-jens.wiklander@linaro.org> <20240902151231.3705204-2-jens.wiklander@linaro.org>
In-Reply-To: <20240902151231.3705204-2-jens.wiklander@linaro.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 3 Sep 2024 14:37:38 +0200
Message-ID: <CAPDyKFr+nF5Y-fe6FpKcBt0zX=_oEmy7j-rbvG-1tmP_qQXrWw@mail.gmail.com>
Subject: Re: [PATCH 2/2] optee: add RPMB dependency
To: Jens Wiklander <jens.wiklander@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, 
	op-tee@lists.trustedfirmware.org, Arnd Bergmann <arnd@arndb.de>, 
	Sumit Garg <sumit.garg@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 2 Sept 2024 at 17:12, Jens Wiklander <jens.wiklander@linaro.org> wrote:
>
> Prevent build error when CONFIG_RPMB=m and CONFIG_OPTEE=y by adding a
> dependency to CONFIG_RPMB for CONFIG_OPTEE so the RPMB subsystem always
> is reachable if configured. This means that CONFIG_OPTEE automatically
> becomes compiled as a module if CONFIG_RPMB is compiled as a module. If
> CONFIG_RPMB isn't configured or is configured as built-in, CONFIG_OPTEE
> will remain unchanged.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202409021448.RSvcBPzt-lkp@intel.com/
> Fixes: f0c8431568ee ("optee: probe RPMB device using RPMB subsystem")
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
> Replacing "rpmb: use IS_REACHABLE instead of IS_ENABLED"
> https://lore.kernel.org/lkml/20240902080727.2665235-1-jens.wiklander@linaro.org/
> ---
>  drivers/tee/optee/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/tee/optee/Kconfig b/drivers/tee/optee/Kconfig
> index 976928641aa6..7bb7990d0b07 100644
> --- a/drivers/tee/optee/Kconfig
> +++ b/drivers/tee/optee/Kconfig
> @@ -4,6 +4,7 @@ config OPTEE
>         tristate "OP-TEE"
>         depends on HAVE_ARM_SMCCC
>         depends on MMU
> +       depends on RPMB || !RPMB
>         help
>           This implements the OP-TEE Trusted Execution Environment (TEE)
>           driver.
> --
> 2.34.1
>
