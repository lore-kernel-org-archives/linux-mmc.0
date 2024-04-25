Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A2F14D290
	for <linux-mmc@vger.kernel.org>; Thu, 25 Apr 2024 16:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714062124; cv=none; b=WKNLnBHNxAvlw9dinaetfGxtuUjETGo6bqcnM6C+sNPA12t0VOUG6dwM0KYI9c/mTPBuscZwVxwGj0TEtUTZzB8+U1BfrOC1kbE8zI/2cOzq6p7lZ4EDoN0Rh381ug5F5YV/LarvRR5kr+n52DOS+y6Sun1VRkj4B3XKUyqUj4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714062124; c=relaxed/simple;
	bh=/BJezWf4e46PL8G6qGv9NS2seGXW/HjeqGqtrsDYyV4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uL4kZeY1lDRN1mN//q3Phx4xc2csZiSZEn3ZlN22FmMe/WQEWQXxRCSZhpe0UK9eAs3orbmIV5vDLIhjk8Z/1NAC6VriF9bHPbYOb4Z7C9YtBeEQg1cUj6WZ4xoMAUVVmyhBIDKz5dJgnn4KJ1erak3xEvQDTV4U4I4eKaKGs3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XsGGCR+O; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XsGGCR+O"
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-dc236729a2bso1209376276.0
        for <linux-mmc@vger.kernel.org>; Thu, 25 Apr 2024 09:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714062122; x=1714666922; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=450cETtePbIzFtnBgqpbAAvZVlAXASIsvHnqkeRgfUc=;
        b=XsGGCR+OsjItS0w0pVL8wuWLvW8LYPRujj1KZSmjfEUapxtZdvEj8jifLxFu3qlJPU
         iDLp51Jfwr1c66zKCVjr+hE8bsrOJiPfgzmcklFQTdJFtPHkmqugL6VaZi3xn7p0IM2j
         j2hneQta/7l3e+5xqjej+itloBzH6vqCnI0WjP7SQQp2h/gtGzdnpkmg1HRH8EBIoO7r
         Dg5IWWGiYanIJ2a+4h0uwNBIL1FzYb3Heeam8ZCR5U2OZV1/9sNISX6lf6pxZtfHtRKw
         dbu3zfoYgdp6cMA7y1uH5qGKpoh3NFEzHn0JasqagXcUXDCFzTz0PcJCPdI5pbrQ7W03
         StCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714062122; x=1714666922;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=450cETtePbIzFtnBgqpbAAvZVlAXASIsvHnqkeRgfUc=;
        b=QgvXQT1ROBS9ce+Dk8fxIO32xhY60evRWSTWGn6tinxommpp/Baw+WYAR0osPSrd2W
         MffywbT7QMX5qCzKzT/zT4U14rqiVdvuOTmTkwVjaKiQXUn1Y9VeVqGs1ohRqxNR1dbG
         O7tVLFOBp4kk8W4L4/AGbM9qwqAG0DTauyYIt5KovhUgGd1mnsW3oStKKA1xGl3sZtIQ
         6w6Sgx8YK22HyGv37fmuqklWR+2ez9cbLCLgaCLhYLEkWRvW4pmanxlffZNwnmfNq5yE
         Ah8eelcdY8OhsBtXB4BYk9Abn36JEmLAX/muIA8W+SV/jKIpE8Uv+1T6cNMgGsFrwK+z
         hFJg==
X-Forwarded-Encrypted: i=1; AJvYcCUPy1EB3NvjxVW3ExkCsbWIFSgES7/Tvr/N2kiBnay8PNS3B+14WETLVeFomjmcctRbnyVNN/zNQU7p/GyAOfaFUTxCJSN5Jd1u
X-Gm-Message-State: AOJu0YzUt+6c4eiSv/Wc0VwwhL6Xf085zJljUa3iGrjuT6xCMTR10UD7
	HsxiqfGBOOZHrG86ELh3jjMwnGmkEaaTswwzv2LYgbTS2tEAm3+G3m7fz7sPWQWrHootm9RwHg6
	ufv7yqmXsJB9wKxobhJd9nZXFfU4eshh0EuT2oHhHrO+QPMdF
X-Google-Smtp-Source: AGHT+IHsG8sOX+WEM/DoCeWBuYZYXfvv+few4ykMeW0zvDFtHXXNKa2GVvb/k/dFJo58xurRemLXIdiAoSF+q/fPATg=
X-Received: by 2002:a25:bccd:0:b0:de5:53a9:253f with SMTP id
 l13-20020a25bccd000000b00de553a9253fmr133982ybm.15.1714062121878; Thu, 25 Apr
 2024 09:22:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1712757795.git.u.kleine-koenig@pengutronix.de>
In-Reply-To: <cover.1712757795.git.u.kleine-koenig@pengutronix.de>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 25 Apr 2024 18:21:26 +0200
Message-ID: <CAPDyKFoMp_tUM5wLMF00RcQogAVQSjm7e5_WQp5AE=+uNiTyMA@mail.gmail.com>
Subject: Re: [PATCH 0/3] memstick: Convert to platform remove callback
 returning void
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Maxim Levitsky <maximlevitsky@gmail.com>, Alex Dubov <oakad@yahoo.com>, linux-mmc@vger.kernel.org, 
	kernel@pengutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 10 Apr 2024 at 16:05, Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> Hello,
>
> this series converts all platform drivers below drivers/memstick/ to not
> use struct platform_device::remove() any more. See commit 5c5a7680e67b
> ("platform: Provide a remove callback that returns no value") for an
> extended explanation and the eventual goal.
>
> All conversations are trivial, because the driver's .remove() callbacks
> returned zero unconditionally.
>
> There are no interdependencies between these patches, so they can be
> applied independently if needed. This is merge window material.
>
> Best regards
> Uwe
>
> Uwe Kleine-K=C3=B6nig (3):
>   memstick: rtsx_pci_ms: Drop if block with always false condition
>   memstick: rtsx_pci_ms: Convert to platform remove callback returning
>     void
>   memstick: rtsx_usb_ms: Convert to platform remove callback returning
>     void
>
>  drivers/memstick/host/rtsx_pci_ms.c | 9 ++-------
>  drivers/memstick/host/rtsx_usb_ms.c | 6 ++----
>  2 files changed, 4 insertions(+), 11 deletions(-)

The series applied for next, thanks!

Kind regards
Uffe
