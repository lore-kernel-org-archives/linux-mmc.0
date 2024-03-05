Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF695A119
	for <linux-mmc@vger.kernel.org>; Tue,  5 Mar 2024 12:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709641457; cv=none; b=uX2zW4LW4H1Oi93R7rpxye6hb0KAfD+c8gbKAiYaSSBKmwDK4RamCJgMzBN6PBsVNRYHhI6vC5KU0Kq5OMu+i22A8eYxTJGL+m1V5KxF3Bt9KRgxQy0kuChCBwgdnz3MnoOd4JCLSdf2AE5Q+8sjo3SMpntkOQWuEtk9kpK8LY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709641457; c=relaxed/simple;
	bh=CS3p1MBudwYKblcteI/2NOPXI4ddkTXb99n7xdy/Gb4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jHvno4eZwRVUp9bORdfsi1q6dzitaWSAGSBA2aCMub6flNjHCc7HkcNJdS7/ZfaOoZwI8mlsZoLEQPPIpJPVH8NvZ/2498cri36hRIpp9dapNAOZxk/PK/MMN8Xr5jLBztVx82qWOwDeTuk4+Uz3emPVhWjpqbDA8QhGE/t3PKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XQJHsty3; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XQJHsty3"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-60978479651so51357147b3.3
        for <linux-mmc@vger.kernel.org>; Tue, 05 Mar 2024 04:24:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709641454; x=1710246254; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CgWnngIT/gJ2CN/6Q6lG/bumlZMowmI03npuEMQCBAM=;
        b=XQJHsty32one0Z/DC+DOsBj888PoIR9MgaSaINszUAU6nMN/yoYHrQZJ0BUbKiJO2+
         hMycc3VXUJsXbYnmIenlWBjNLs7UmNNcP5yOkcu/+4347xOz1bdwiEuJZZqmFdUAAQV3
         A3xE0EPQWIqki7bGqVUlzV65K3RrC7BZAAYvn1Hpk4RhX5Z20Z3RKL5AZcMdU++uuqdF
         GQ1O/ERZnoA2J70Z5231Hvh9GpBgLWFgEXgngK/xbXJ7z7TA1M7OaVOb7vKQKQ+UegeY
         9AJxiHMIa2FRToAF9RZFM6rONYsELFxPUtHehJqEqGLT18+c24vkuI1J1vCnsJnN75eM
         vQdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709641454; x=1710246254;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CgWnngIT/gJ2CN/6Q6lG/bumlZMowmI03npuEMQCBAM=;
        b=OIBGsJNEGBqrHfAb5y/2rXgaUD79uHw8V9j9xjtVCf6aXRLUx46a23XJBvsy+T19ea
         8aDdk/xofrvgdDjGr3yRBoO7bTaBwmvefHdcmdvaRhcFMYwNYXX53Whw8ll0n2OUQCc1
         r4lz0/3tjol7RO90VBjJWoOcgcCqQo4iNz3ySiJjKZh1l8CixTGJq997ciHuHqP0ebQy
         6Y6D6LmpjlL2FHjI3qiqw4veZc4YprdUmksXUZXqbB8hDiT+HkDQtWiwO9eE/xEqi072
         +OPnow7Dv560sfKw3Jt34RYXtzFf99T69B6Aadx4sK9EWVoyfed15EPcCUSWvI28mY2x
         PWNA==
X-Forwarded-Encrypted: i=1; AJvYcCV/1BoZyVPXKW49+14536/UyYetZzf3lwo5FI5lfbMfJy4bQz9DhnVyCfgayA3r7e3AUxk7OT3YY37zGhc7ykTMGdQOcqSFDdsu
X-Gm-Message-State: AOJu0Yy1iRjVGu0Xn0bDsYk5Me0wJ3J28KhygGFbNObNbb7SWGsELP3u
	3Za7zwjAA4sW+IgsIyQw8jLrR+SddCC4SqhQxu1DkOTydFvmZ3A28bGEHVJDnTV8HBMfy2d0x65
	PyBX5bWkwoQPfYToDD4Fs8ce4RrrbUqZe6mb9Wg==
X-Google-Smtp-Source: AGHT+IHUBgwcmPr3wx5OxoHWv1ZUZdP1ZVL1rLQBhjwJNL8fZY5l0lFsxJWNgG2Iv1hIDyeVJFsQ1t3tYOxVyeL6KpA=
X-Received: by 2002:a81:720a:0:b0:609:2104:3cf8 with SMTP id
 n10-20020a81720a000000b0060921043cf8mr12997879ywc.41.1709641454552; Tue, 05
 Mar 2024 04:24:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240227153132.2611499-1-jens.wiklander@linaro.org> <20240227153132.2611499-2-jens.wiklander@linaro.org>
In-Reply-To: <20240227153132.2611499-2-jens.wiklander@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 5 Mar 2024 13:24:02 +0100
Message-ID: <CACRpkdZBWBio8kvKuVzj2CknCb4eS=VB2EqUsAK-vf4e328icg@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] rpmb: add Replay Protected Memory Block (RPMB) subsystem
To: Jens Wiklander <jens.wiklander@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, 
	op-tee@lists.trustedfirmware.org, 
	Shyam Saini <shyamsaini@linux.microsoft.com>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Jerome Forissier <jerome.forissier@linaro.org>, Sumit Garg <sumit.garg@linaro.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Bart Van Assche <bvanassche@acm.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tomas Winkler <tomas.winkler@intel.com>, 
	=?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jens,

thanks for your patch!

On Tue, Feb 27, 2024 at 4:31=E2=80=AFPM Jens Wiklander
<jens.wiklander@linaro.org> wrote:

> A number of storage technologies support a specialised hardware
> partition designed to be resistant to replay attacks. The underlying
> HW protocols differ but the operations are common. The RPMB partition
> cannot be accessed via standard block layer, but by a set of specific
> RPMB commands: WRITE, READ, GET_WRITE_COUNTER, and PROGRAM_KEY. Such a
> partition provides authenticated and replay protected access, hence
> suitable as a secure storage.
>
> The initial aim of this patch is to provide a simple RPMB driver
> interface which can be accessed by the optee driver to facilitate early
> RPMB access to OP-TEE OS (secure OS) during the boot time.
>
> A TEE device driver can claim the RPMB interface, for example, via
> rpmb_interface_register() or rpmb_dev_find_device(). The RPMB driver
> provides a callback to route RPMB frames to the RPMB device accessible
> via rpmb_route_frames().
>
> The detailed operation of implementing the access is left to the TEE
> device driver itself.
>
> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Signed-off-by: Shyam Saini <shyamsaini@linux.microsoft.com>
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>

I would mention in the commit that the subsystem is currently
only used with eMMC but is designed to be used also by UFS
and NVME. Nevertheless, no big deal so:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

> +config RPMB
> +       tristate "RPMB partition interface"
> +       depends on MMC

depends on MMC || SCSI_UFSHCD || NVME_CORE
?

Or do we want to hold it off until we implement the backends?

Yours,
Linus Walleij
