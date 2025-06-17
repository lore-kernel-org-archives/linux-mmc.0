Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846B72E717D
	for <linux-mmc@vger.kernel.org>; Tue, 17 Jun 2025 13:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750168609; cv=none; b=SwwXQCqNASHys9ipgeMelsQGvPf7M73wMkYR3YFOUR7BnPr+2ftiOQDQKXdjkAy0SNIf8iYNZKolhusaa7+r/yllCzoKV20mN82IZJGSVx0t6xy3x8rHbhUZczYIrYh9+CLki7ql/3JjUZPDXRgT4Eol4xPQAqBbN8LvtmtBsrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750168609; c=relaxed/simple;
	bh=3zbvvtG7YQuVKX9TYGQMUeZBbqaW7QzuUhVqFlHBOaM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UE+k28cGm/UCW8pWLPW3EwAtY/wDmuaKEqg9GJVW4gBKaCPR3W49Av5R3MOAS4oxvToWBmlACIMHFr919xKZLtyQCnoWWC0uAA4uWBdn+1EL5e2oCy1BuQc4phdtmhKMdkOwmf6HBwr1Lp6U9KSPYEvDuT6JtKAejqgW0GyK4PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lc6HioDs; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lc6HioDs"
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e8187601f85so4969527276.2
        for <linux-mmc@vger.kernel.org>; Tue, 17 Jun 2025 06:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750168606; x=1750773406; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xofT8fwCIcw3ss7J9p9tyTyHI6bgKbUW4cnKWlrbyJw=;
        b=lc6HioDsR8xWZDKQ9gdlqf5qRxHNWNvCkGJuP2EY8RUswu9W/4Kls77VCdEITwslWh
         6MXrzV6q6MV4iASm74QHizstBUy/xFgZd+ppQpYD7sbFmuE/tY+9RGJAS32u0OFx19Yq
         r2RLciR4xRdDJzbPLycrb2sTahnQM5gW+SdtLZYk0TpiKOrSFfBz+4EcTT6YsYYoi8az
         HPeaQoRln5u55zFjOZIfvUtA0Oo1SF2AfB7pHziqmwXKMjcQ1iTmIHp5381FrpS7EXku
         FBM522ukZptoB5oQiZhRRraEfTMdGxj+Z52H0fe03crLn2EDPDM7JY6uw84H6eGSfAr5
         xuaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750168606; x=1750773406;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xofT8fwCIcw3ss7J9p9tyTyHI6bgKbUW4cnKWlrbyJw=;
        b=everiHv8FGpopKGkeiLGVZcC4iS8K1UB98O3peCKLp9gADU+kLu/ks61d2xEw+sr11
         HnrQ0eDw/jwZtPIpj40M8ZdaAVyifw18i05wb7kQA1ntCF6Vomy60rVqhvZ4OekysCIl
         YWULpkV5hPkFWOBBc1mPjHzRW8uevyn2i/836T1llanbnmx9sZ8zEndtUJTsI9MF9V3z
         v0F2VaoQraCiOK53MuiMAaTXW0O2e5eSvZmTCUaDENt0JpQ89p+yQ7AXZRNo1HnPosel
         gJZZ3zNs2r9Gw3qSnOe+9oWCu91JNuoDHYdnqdzL+pzPZGpEHhnWA2D2gIHUPoBlKYYV
         3F2g==
X-Forwarded-Encrypted: i=1; AJvYcCW2NK0mt6qql0hiBT04rQLaDDvXzVx/tiWa2SGlopdImLbJCXCzDjWBWfpj9kG/d3JNunaKLHe5XOs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxaTIEb8RHq1Ve2SjlexgW7BFdfCh8N9/f26bWTV0JXHzS7rLD
	yeJ2HKhmX4AKFE4WAAK+F/v+5ZauDurXAIpfDKgnCyEbWiYjBymhId9S4pAkXnRERS703oayK+A
	eY91BE2ci1FuGs25PBexKOe3IyJQgsHt09d0JPghlqg==
X-Gm-Gg: ASbGnctG00yo3h9njBxfw7SNCLPfweICDSq6XuEreNi5JFmmnvhkF4uobfkEnlRm6em
	fZgLIAgXjFoO8ime7ReMneJXKfMlecfo5024PWRbZ9xaC2MqDqFQgzUdrwhMqBqJ/ufGKhYVLG8
	iMr6lsvdjAT4Poho11vouXtWricDCvUSaWUaOCQ0jauLL5
X-Google-Smtp-Source: AGHT+IHuXsga1oBDQoLkES6fJaLQd3hottwmMudsb72N1YF49HztC//8v/4qepEDNCi8SqWDXlsgFDqxRNIpopuLq+w=
X-Received: by 2002:a05:6902:1687:b0:e82:c36:feb5 with SMTP id
 3f1490d57ef6-e822abf7a10mr17023480276.16.1750168606542; Tue, 17 Jun 2025
 06:56:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250610111633.504366-1-ulf.hansson@linaro.org>
In-Reply-To: <20250610111633.504366-1-ulf.hansson@linaro.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 17 Jun 2025 15:56:10 +0200
X-Gm-Features: AX0GCFtmZtjXZ3TSs816xYOPxJZIfqU9jxiY-vmD84gGmwkB_IMpvHaAnZiwJew
Message-ID: <CAPDyKFpWrBDQjUdGkhnRVxrYGLMfqmyd9U8Kv44aRZWwhqTG3A@mail.gmail.com>
Subject: Re: [PATCH 0/4] mmc: rtsx_usb_sdmmc: Improve sd_set_power_mode()
To: Ricky Wu <ricky_wu@realtek.com>, linux-mmc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 10 Jun 2025 at 13:16, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> The code in sd_set_power_mode() is a bit obfuscated and also has some minor
> issue in its error-path. This small series addresses these problems.
>
> Ulf Hansson (4):
>   mmc: rtsx_usb_sdmmc: Fix error-path in sd_set_power_mode()
>   mmc: rtsx_usb_sdmmc: Print debug-messages at power-on/off errors
>   mmc: rtsx_usb_sdmmc: Convert sd_set_power_mode() into void
>   mmc: rtsx_usb_sdmmc: Re-work the code in sd_set_power_mode()
>
>  drivers/mmc/host/rtsx_usb_sdmmc.c | 31 ++++++++++++++++++++-----------
>  1 file changed, 20 insertions(+), 11 deletions(-)
>
> --
> 2.43.0
>

Ricky, I would appreciate your feedback on these too. Or at least an ack.

Kind regards
Uffe
