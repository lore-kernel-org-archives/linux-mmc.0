Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8C71E507
	for <linux-mmc@vger.kernel.org>; Mon, 27 May 2024 13:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716814847; cv=none; b=D0EfonWwsXShG3Qz6SteyWSk3erTTy6ZZMlstH4Cf8Q1nSGzsHaEkOvwVNH/vhsjmITnkh3QZRnRJFFGKv3qFyJOXaephKWVHA+QrvFZCh/jzFFnC01JYQmDGL2At2kJT8nByRnDQj3UI9zX4+aXN2t0n8Rc6NWcKsqFcHLqmqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716814847; c=relaxed/simple;
	bh=EUyCbnhS3BlHRRSjjBnZZZsociF0Jq1G5n0SD0UfcYc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YO6i002HSuWquCFhcfuFN12oXjMqStmdDKUTq9DtltPe+B0+9QzlJ57mkWiSwNsMjyCABeUl4PNgzcByRNFxhNZ9EuLIQFC3pV8MyH9meNeyYdjbOEKD3rXpxCVdDXhDobrMtsL3BYFe5thh5M1ASihvgGOYVbFqEw3+GeweiaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=K8hjuvfR; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K8hjuvfR"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5238b5c07efso10749736e87.3
        for <linux-mmc@vger.kernel.org>; Mon, 27 May 2024 06:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716814843; x=1717419643; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MpJ6vCZMz7EOGVjorfIQKnCKCEyg0Yd4/DGxKW7l3C4=;
        b=K8hjuvfR6H1aFQH5cvVPt2IO9VGMjy54hau72GqCWJmIFzBZtvug0B4xR8theIMtz1
         QQcvUbTCrb0KdRlIsUJRkDhWT8jMgQG84ADwpULn996fclSlqzz/vq7FayyhS328xyYQ
         ViRGkHQspcjFeQDXMUaHKv/eYMxYVLl/ah9wDqO7jZjOgIymKvGYPIf1WmBtPst+uTOy
         Xhu+uRvJo9EAB+1GGWnDZ8TbGzFLIuGE+PvBqZ42Ja3sg+T03xH5lJq/yj0vjyLos6rZ
         JoN449shwVcau6VJ+L2L2JPyXJrtnqrxbqoQa82ZLxs3fbtOZT6d+35zCiqM8rQUDxCF
         s58w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716814843; x=1717419643;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MpJ6vCZMz7EOGVjorfIQKnCKCEyg0Yd4/DGxKW7l3C4=;
        b=VuWIk3CZV6xA1O9HZ1EfDn03Uj444tMnFYqVdl/i97VZmTRhOIlMj9tirR4QpD/2OG
         65KqjSIA0yWuE7lmCPof/6MpqC7qQL0kkfR1uN19Irp2U0XqsRXkIOW1nSJrT1fAjIun
         cWZgoS2FWEKC42QHKFj/BMD2lKG64izEB8A35jX0gnQRS3EZLU5jSLzEZjn4rCH3Gg36
         hu6rLIZ2Wd4AfDruiTPE6RxEFM23VvtxIfsxHsmJKL8Cr0OtrBropuyQWvi0i5Gh4P+p
         M8c1KZrdabPczz151BuAvThsfdyAxNSmTM20EJZxWeEzFLcMH6DHWzUeahlxZ37yevN7
         VwaA==
X-Forwarded-Encrypted: i=1; AJvYcCXPsZkcZgKgf0Pu0uDYV2Sjjsy20ib7OY6JcJVf9imYvl6KtfSKDJ8rXCO3Ff6Eqcgag1gt55SiH4sczd56NrxZRT7Ix6h9kdlt
X-Gm-Message-State: AOJu0Yz5spcBAVAsNgc7uZVtgIaUG4cTDg3zMxACyj/mnx/Jhm2ARABA
	TKPtora0p9frdH3dr/mmFL1b4HkwhHHX46Qd2Nc32fxJr9yph8M3SBIOeHax2jw=
X-Google-Smtp-Source: AGHT+IEDtPIGNSFITefCjH6Zw9Wwfz0YD1Jqj60Q7SNk+Nsx4qFaryKs3KQrEdvR2BRRRnu+5T3UAw==
X-Received: by 2002:a05:6512:1388:b0:51a:c8bb:fcf7 with SMTP id 2adb3069b0e04-5296410a55dmr7155320e87.3.1716814843603;
        Mon, 27 May 2024 06:00:43 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:6677:431e:31d2:9da9? ([2a01:e0a:3cb:7bb0:6677:431e:31d2:9da9])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-579deb8f406sm615511a12.34.2024.05.27.06.00.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 May 2024 06:00:43 -0700 (PDT)
Message-ID: <fc3bfebb-78b7-428e-8da5-5221f4921faa@linaro.org>
Date: Mon, 27 May 2024 15:00:41 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 4/4] optee: probe RPMB device using RPMB subsystem
To: Jens Wiklander <jens.wiklander@linaro.org>, linux-kernel@vger.kernel.org,
 linux-mmc@vger.kernel.org, op-tee@lists.trustedfirmware.org
Cc: Shyam Saini <shyamsaini@linux.microsoft.com>,
 Ulf Hansson <ulf.hansson@linaro.org>,
 Linus Walleij <linus.walleij@linaro.org>, Sumit Garg
 <sumit.garg@linaro.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Bart Van Assche <bvanassche@acm.org>, Randy Dunlap <rdunlap@infradead.org>,
 Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Manuel Traut <manut@mecka.net>, Mikko Rapeli <mikko.rapeli@linaro.org>
References: <20240527121340.3931987-1-jens.wiklander@linaro.org>
 <20240527121340.3931987-5-jens.wiklander@linaro.org>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <20240527121340.3931987-5-jens.wiklander@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/27/24 14:13, Jens Wiklander wrote:
> Adds support in the OP-TEE drivers (both SMC and FF-A ABIs) to probe and
> use an RPMB device via the RPMB subsystem instead of passing the RPMB
> frames via tee-supplicant in user space. A fallback mechanism is kept to
> route RPMB frames via tee-supplicant if the RPMB subsystem isn't
> available.
> 
> The OP-TEE RPC ABI is extended to support iterating over all RPMB
> devices until one is found with the expected RPMB key already
> programmed.
> 
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> Tested-by: Manuel Traut <manut@mecka.net>
> ---
>  Documentation/ABI/testing/sysfs-class-tee |  15 ++
>  MAINTAINERS                               |   1 +
>  drivers/tee/optee/core.c                  |  96 +++++++++++-
>  drivers/tee/optee/device.c                |   7 +
>  drivers/tee/optee/ffa_abi.c               |  14 ++
>  drivers/tee/optee/optee_ffa.h             |   2 +
>  drivers/tee/optee/optee_private.h         |  26 +++-
>  drivers/tee/optee/optee_rpc_cmd.h         |  35 +++++
>  drivers/tee/optee/optee_smc.h             |   2 +
>  drivers/tee/optee/rpc.c                   | 177 ++++++++++++++++++++++
>  drivers/tee/optee/smc_abi.c               |  14 ++
>  11 files changed, 387 insertions(+), 2 deletions(-)
>  create mode 100644 Documentation/ABI/testing/sysfs-class-tee
> 
> diff --git a/Documentation/ABI/testing/sysfs-class-tee b/Documentation/ABI/testing/sysfs-class-tee
> new file mode 100644
> index 000000000000..c9144d16003e
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-class-tee
> @@ -0,0 +1,15 @@
> +What:		/sys/class/tee/tee{,priv}X/rpmb_routing_model

Wouldn't /sys/class/tee/teeX/rpmb_routing_model be good enough?

Thanks,
-- 
Jerome
