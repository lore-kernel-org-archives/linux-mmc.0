Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5B8230D14
	for <linux-mmc@vger.kernel.org>; Wed, 26 Nov 2025 10:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764154663; cv=none; b=IgwEMiamKDevdV6ljfGY3XKwaOaEWulToH8T4qM+levfgjZaw/YtouZgCczKGa/fZgJfPeCUNh1feQK566eHTdPrCALEz59piciunJuiBjSrrJhosBLbD/H5kYrCJ2gtGzbgc90nMwy7+XfUE73F9DPH9OyJlD1c49moPzNeZvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764154663; c=relaxed/simple;
	bh=NsU6Wd1XEcomoxQo4YAXt5KUFF7FXHBdd4T+CjKp1j4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BFbZ/a6bsZEqfimnCWcwaXZFbnvnb5Bq0fNWprubVAKXUwkSrqV0b7BHta+TWZ0DGbBHAmwRrydsF3vQ2VSexsZVsk5ODI7qGStPGHdb1J1j4X050l/lYm9vcXAVMlTMN5opAungh1oWCO9rZ5zZWkRt6dGQT3VT8zormpIFGVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FicqvStN; arc=none smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FicqvStN"
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-640e065991dso5740683d50.3
        for <linux-mmc@vger.kernel.org>; Wed, 26 Nov 2025 02:57:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1764154660; x=1764759460; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6fJUBJYtX0hwUyO3vk+Ac1lETs5qleohrjV6r1JhUoA=;
        b=FicqvStNda7RNyjUsS7yOUFOa8Zr+rEOW06v9fdCuMCaC3Ud6YC8Xhgh/WCHMj8uk5
         jVqeTG49ATAPM85Z2pLClAQWpbaX0JEtJ9CL7hMgA0S68pdnwndqY8HQaoFM/UsM+HoC
         O8+EGKazDV8tq25TQD1QTdiXrz3DR4x9LfekA2DiSBjNaLmdZBZP9Hz7s1QJH+iUqHJB
         vNHrV7T+/PUeL4o+NrQLq59+LqbNFz26MtEpeoISmBhbfxL0gNVAAn/E9r9ITvbJYykI
         wJKP2BaE+eT47J/NUEoOLRDsxbgxjyTihd9LvGvEUhxEs4dJf2V1HqSgyqL8N4hDErCU
         Kj/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764154660; x=1764759460;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6fJUBJYtX0hwUyO3vk+Ac1lETs5qleohrjV6r1JhUoA=;
        b=Io4sF79W7Em+rr2JuC+2c/H0wM4M7QKW8tV935hduQT6pYew0krf5+11MQMjrHEjtB
         En2ndTddxlxkjJpCKyTl3EwbExoWVbD9dccpWpsvX1OoOTEILFEd6xowIBE5xfDvpbd2
         3z3mUOKnRk36hhFuPkWYgzc325YxZ4viiKEhK+12U1c86FJP1uZDeRLiIOK//z9QAo/C
         gzVcAH5c9KaoHzT0z5HUCdFbQHv8lTlSmFZA/w6nRGSeUl2ERWBMrC+LpgXPwh0PuUmm
         l0uyWrjSipKZOACTPQpSbYT2RsXRE4/tBTUiKlKj3TKjB/IHSAmaxaMyP3F+LmgWzuFw
         Ws6g==
X-Forwarded-Encrypted: i=1; AJvYcCXwihUd1cyUdZ3iQWWJcI4MhndgUZuWpDxMR4RTj54rhknxSlZ8QwZJAUs283AwNKmMP5RWyOxWQZA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWjiiq9AKZSEOlZWAqdsOaQ87t4ncrjykTiloW3ITcA/JAAZff
	mTlqDKrLixVoJVYkMMjyw9dJZKgZyvNPUk537IRVvf+leCWgIFXVVyi+Zs0uaOzAusT6DVjxnLv
	jWoBQ4QYWN1YxDVZ/Rckq5C0eyoh6vpVEWpYOB0m40g==
X-Gm-Gg: ASbGncv8z/T5mjLzFYfwMTrHuu0mGzaC6zb49VvlDlJGEIcFo9HprJPLv4FcHIr/V3T
	4Gp8S059nPnbWsMvhPREo956eBRsV+rylZR0HbgRwt4A+d/PGH7FlYLXW8fCLfKJ489wseUj/vS
	yJPVpIj6gtC+7DyI6hh+ZoaQr9lE+OOOcARKeHjU0Kf0Madcj7kHzEZ5cDINCNrWb6aQabqQsRE
	uaBY3MGWPEiwuMIigg4q5QCooO/E6yZGj6WgzzczJ+zXFMSBoBOwq+4B5hS278Jth4iG9o=
X-Google-Smtp-Source: AGHT+IGIVfCkqztsxPovaCat3kgAGoBlqNAhzXThILxLpNm0K8yeMWglgh9uMdPakEam5up5h0WwXnH85J/mGjFP32k=
X-Received: by 2002:a05:690e:9c9:b0:63f:c52c:3828 with SMTP id
 956f58d0204a3-64302a4ab7fmr10632693d50.26.1764154660515; Wed, 26 Nov 2025
 02:57:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1764113200-237279-1-git-send-email-shawn.lin@rock-chips.com>
In-Reply-To: <1764113200-237279-1-git-send-email-shawn.lin@rock-chips.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 26 Nov 2025 11:57:04 +0100
X-Gm-Features: AWmQ_bmZ5DgR-hX_asnVCtwy_16iVOBue9S505-dzvYgvEvDIm9Pu-dLfhBhOSI
Message-ID: <CAPDyKFrO=xft4pHn-hiTRDK4kcEvv_ANfdyT6fmeZBxjc10h1Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] sdhci-of-dwcmshc improvement and fix for Rockchip SoCs
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: linux-rockchip@lists.infradead.org, linux-mmc@vger.kernel.org, 
	Sebastian Reichel <sebastian.reichel@collabora.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 26 Nov 2025 at 00:27, Shawn Lin <shawn.lin@rock-chips.com> wrote:
>
> This's v2 of these two patches which adds ack-by tags collected and
> rebase on top of linux-next.
>
> The first patch fixes the auto-gating problem of dwc IP when using CQE.
> The second one improves the performance of CQE by reducing CIT.
>
>
> Changes in v2:
> - rebase and add acked-by tag
>
> Shawn Lin (2):
>   mmc: sdhci-of-dwcmshc: Disable internal clock auto gate for Rockchip
>     SOCs
>   mmc: sdhci-of-dwcmshc: reduce CIT for better performance
>
>  drivers/mmc/host/cqhci.h            | 1 +
>  drivers/mmc/host/sdhci-of-dwcmshc.c | 8 +++++++-
>  2 files changed, 8 insertions(+), 1 deletion(-)
>
> --
> 2.7.4
>

The series applied for next, thanks!

Kind regards
Uffe
