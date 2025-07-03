Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2340E246767
	for <linux-mmc@vger.kernel.org>; Thu,  3 Jul 2025 11:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751543137; cv=none; b=E1S93VxEsJjzEgVKZS7T3HTfw3dv1PyfNZ1H24woPE7S02jdsxjdPxKotiiEN4gNJtMTbqKjLlNT9jLLEW2NgYqFkCsELX7LEdpMOiE1nUTjF86ipS708BUivOTTokhD5RXqay+Y2ipT5W4QtAaZ/ie6KKq0oWCNIi2bHHOHC0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751543137; c=relaxed/simple;
	bh=ufg+B70X7aP7F23Q5oPvyOEHmvxo2rkW1n6fSVYDXkE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jrkpd/WjVH8ceGDT3lW6v+Fk/9ouNtKjxRPaUbbtQqaHEryVvbz6nzMYfx2akHxkZHQ1yOtcQG5RhWJm5O/mpanoponzn/o+C6WhPaUgyAzYATLReWlCJQp2LyhYt0PpcSSxhUXiF30MU5qdLL9L79/JwneRwQU1262626hbmUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TUcFk0yM; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TUcFk0yM"
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e81877c1ed6so807977276.0
        for <linux-mmc@vger.kernel.org>; Thu, 03 Jul 2025 04:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1751543133; x=1752147933; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=N1iz/e5NRfJrhtB0eQ2BcRjvFxPOgvR/kC92MdpwYNQ=;
        b=TUcFk0yMjI5fTGo7+hVoSix/JyjwL1ooZMwSWTzBUaEvP9WwI8XTlOOHqiPc5+Aev9
         9cGbvwrDoV4E3FjX1eCNCvE4Eh169gRA27LhHFORPhc4v7EHcGKaC5JxjDwbFX9SeO+i
         P4/9sGEScwUvoDU5+7X2HrP3FLEPbROl0L7SJjP4A0bySyL8L+0eRBdzMFW8BL1CqipX
         wMnGEhCNCGIhAbAvI0tHG/CowQ59I+0Q/KJLAQ/V9pBR+afUjYHd1TSpiae/qvO10UGE
         kgk9dxBO4NPkDqw/lZQzxlDoQOeVwpTSqKyHcQ/dGHZzGTQqdR03DiT49IJnpKvap1Hk
         3tqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751543133; x=1752147933;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N1iz/e5NRfJrhtB0eQ2BcRjvFxPOgvR/kC92MdpwYNQ=;
        b=oQtkWJv5HzvK73bZPeaxosOfXqpSvoHUHD7kQ1AojkZRK2ovnfj07gyyXlYs3PIUbv
         W2ezzGKJf1Chvm6Z1pnblBNlbrYHxYH9dEO0Ui2vsUzec002MjJy8lga+heDIREkHkeK
         RVX7FiuFF5w3rXYZ3OJFU3ZTno9fWEnRd/3ZOAKBpzuZzvUrl3ELJpYAcU0SE0DFZOsV
         d3inHQgo/kzwIwRLMXPL3eaoWL0nO1bMdWpPYGJ6gQE6Z+JAqIN5FDf+alpnD21uYLro
         S/FgaExOyA2F9wh6ITmawhqvj7GcbYNGmkHW2LdEjMf8FqrzE95eXWAiSYgINfnZH7U3
         7TLg==
X-Forwarded-Encrypted: i=1; AJvYcCUJug48aUgrFAQFVeAKq02C5FbMZWUhjTe2PBMQxuQfGWBD3LqWovJvjS9P/kXkDaK2j2Eu1yIavVA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6Jxxw2oQCes4m87RFPYcmwEmhF/+HVG1nCssiIEhppSilU+Nt
	+jfQJ0qbUJaS7XylULikr0BvQvU2/0wEQ6VCrxfsXHuEy5WpFTLcaVIcE+CnMsEZWwRnBW2XP8m
	bmvcduvHZLrV1HjXvdx4/5pu+M379BsZKetYE7KXdhXVy6BCVX2+6
X-Gm-Gg: ASbGnctUAc+XUjoLMUFRKtIDENRH2mfElbSzrDuRIbpzy08kWM9RALQ55FS8zn5oebN
	hrI+JkP2YYJ/c/Blrx5xGCmaQU41NjXtpWn779MSdLcSF6i/keCIFIBKDqT01VYNejemUeTebcT
	deBydFuoSHcZt4ViTlKTHKjL23qY6MnTiHHvRXelJFjcCm
X-Google-Smtp-Source: AGHT+IEp1wj9Rai0DdK3r0vDhPMGACkImKRtje3K/ymGfr6lDVD3CkCODfqj5tv4WURqmZDE94YbRR4FFTKVm14VM54=
X-Received: by 2002:a05:690c:3388:b0:70e:4d8:5cab with SMTP id
 00721157ae682-7165d018322mr22408857b3.2.1751543132824; Thu, 03 Jul 2025
 04:45:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250627025032.1192873-1-rex.chen_1@nxp.com> <20250627025032.1192873-2-rex.chen_1@nxp.com>
In-Reply-To: <20250627025032.1192873-2-rex.chen_1@nxp.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 3 Jul 2025 13:44:57 +0200
X-Gm-Features: Ac12FXwdOEAYvQpv69Hkae4YSQrT-f7QlRUKjnzjvqkPZe59zluB3tNy1WI-mT0
Message-ID: <CAPDyKFon5w7=yV367u7-4kaztxKSzMNBbH6Egjo_toqOigpvQQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] mmc: core: SPI mode remove cmd7
To: Rex Chen <rex.chen_1@nxp.com>
Cc: conor.dooley@microchip.com, bartosz.golaszewski@linaro.org, 
	viro@zeniv.linux.org.uk, linux-mmc@vger.kernel.org, avri.altman@wdc.com, 
	shawn.lin@rock-chips.com, adrian.hunter@intel.com, 
	wsa+renesas@sang-engineering.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 27 Jun 2025 at 04:50, Rex Chen <rex.chen_1@nxp.com> wrote:
>
> SPI mode doesn't support cmd7, so remove it in mmc_sdio_alive() and
> confirm if sdio is active by checking CCCR register value is available
> or not.
>
> Signed-off-by: Rex Chen <rex.chen_1@nxp.com>
> ---
>  drivers/mmc/core/sdio.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
> index 0f753367aec1..a5679a0add16 100644
> --- a/drivers/mmc/core/sdio.c
> +++ b/drivers/mmc/core/sdio.c
> @@ -945,7 +945,13 @@ static void mmc_sdio_remove(struct mmc_host *host)
>   */
>  static int mmc_sdio_alive(struct mmc_host *host)
>  {
> -       return mmc_select_card(host->card);
> +       u8 data;
> +
> +       if (!mmc_host_is_spi(host))
> +               return mmc_select_card(host->card);
> +       else
> +               return mmc_io_rw_direct(host->card, 0, 0, SDIO_CCCR_CCCR, 0,
> +                                       &data);

There is no reason to provide &data as the out-parameter unless we are
going to use it. Just provide NULL instead.

>  }
>
>  /*
> --
> 2.25.1
>

Kind regards
Uffe
