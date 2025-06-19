Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4575F227B87
	for <linux-mmc@vger.kernel.org>; Thu, 19 Jun 2025 11:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750332039; cv=none; b=e6GYea/Xdd49BxXkUfQLL+8ub5ONtInjnPozBRhPGg1iHx7CuNUbUbullov35KKAYWriLIdNx/A/cO7QKHxs+kjEC8/P8V4gjvuCHuR7plLuJSU+qbbWl/ggCiDqiNLs43XxEgKUgBY1kRzMHllnFCAiH152OJAt5fil3Zl+xKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750332039; c=relaxed/simple;
	bh=p+6k/xGiw5ZknIgpP3UT+OohskWGlnVRm9oxYyRZBOY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Aa38ALS+Puv+iwKPxRzENm76mvy8dd+8SRkquZMEBh8ZrdQGDN4NsW5Q9d609m5tpQKJVnHCsVB5az1oKwI+2WWKMTGE+MZFTed6CJIM+PN+nJPXRGpDQ0TUFM1HEY2cE2xZYquNs3np2X7xXlCaqYW2JmheCqeVM+831kzHDLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BQMPvH7O; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BQMPvH7O"
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e7b4ba530feso635975276.1
        for <linux-mmc@vger.kernel.org>; Thu, 19 Jun 2025 04:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750332037; x=1750936837; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+sYbhL9ZLvHHaG7kEAGZXfC1jyPoB3vqLnyixjq1oqg=;
        b=BQMPvH7OmHe0ef3NVjhO9PBgt7GcgYiBbyPirltx9jYVVuDpEQGgyjz0IfEqEEZhzT
         Xwah+6XzgUHhapmZKqjghq/1kndCMaJVEavVmaOiz141zoI/kFtaojmHpfltDfYHOaL2
         rYPfN43mDV/S3X+spZPycbkj00BfYPtAjA94I8wi6ADSsnEZwQI/ZPVNitfQbOIf+Ysn
         7qmnNwLXKZyBV6ftRzzJCR5oVokG8x4Fy1IK4EYOEMKSyDAwCUCxZO7aeWxQow8C16rV
         kCYLZkPz2PaK2BN+9wSgQPG3QOF6aQiRQfXMEvAbm+O5k/zK+f5ds5botBGZAvFw62PC
         WCLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750332037; x=1750936837;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+sYbhL9ZLvHHaG7kEAGZXfC1jyPoB3vqLnyixjq1oqg=;
        b=ZGtvLdJe5gIi2N3mJc/MOqvCF91q+aUwKswSwPuUejMtdHDOCYEyL6pILaHpN912NH
         KwpPmlPYc8j6/2INmfCZfpHQIU0sYf18TrrDgW23VM4GC+l5VzHpROrHFT1f6jpmHam/
         LnNiDnvX1bxPZ6fw9pp+W0phXQdSv4F1QFU7EmfPHY9eMmfbV7sSfSzBuElZoS8w4mGZ
         Otoz95jhRxAtSVIfHzL3gj5HKRMgC3/uGfhWIORlhYpJRDIEFelIqK1mcJ/lvkEwdBPA
         TT4E5y8fystKnFO962HqpSBOUNm0XfnHm0Nw+EkecQY2kUXx5VsRROKKTDldXfU5Y7z0
         VqLg==
X-Forwarded-Encrypted: i=1; AJvYcCWi09RUiLXp0G73dVukwQ6ahtvPXU/PN9sGk3VaJUo8b/hUKOUksVi1z/2CLGnhDSS9YfrZ3G9lu1o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5QFZE/ZCVo/0hjCYdE2GivQVEFBzwrgq0d5bD54Pj+L5dgYIL
	oSgMy8JWcqjvUXz8yFS5/rkCQBgKy3qijM6F0DnbhuBDbSGzEIdP5yxjYfV4Uoi9UTuin82ygO/
	Ltpj7leD4K05NLxf52lG5XuXbozVwjrzBug9tSYB7oA==
X-Gm-Gg: ASbGncvuCJ8NfxW0U7RvHjxWyVzj0oZ+kn10pOMaFJ2AGANvxVsSbJjOWnKJeTmdAkX
	4ENbEOW06Y+8eB+NFR9zl7F0PXuOjE2E0nRko6PQ9yqqSMgJBolhsoAkmZV8QSpe0NA2MCIxZuc
	1784/sNb84VaalBR2AKsDA52TAaQBFl1sbEJhV8X5jPeoh
X-Google-Smtp-Source: AGHT+IE0S+2O6NUdvbgwCKtjntWC3U8Cib0+DALu2Ic7yFVzJL/11pqe42PXhYa41zVH9IVrQvok2b/HhgAZEEJ246o=
X-Received: by 2002:a05:6902:709:b0:e81:9954:977b with SMTP id
 3f1490d57ef6-e822acc6a95mr27455869276.17.1750332037241; Thu, 19 Jun 2025
 04:20:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250610111633.504366-1-ulf.hansson@linaro.org>
In-Reply-To: <20250610111633.504366-1-ulf.hansson@linaro.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 19 Jun 2025 13:20:01 +0200
X-Gm-Features: AX0GCFuocxAjsuOaKhuD3GQaVuOyIrIQJSjugHONuo2hQMDMoKxF2Rxh6HOK4iU
Message-ID: <CAPDyKFp0-LGghubZS04QpYD1cmBZq5_QME9o8TTPL7bjX-jHDg@mail.gmail.com>
Subject: Re: [PATCH 0/4] mmc: rtsx_usb_sdmmc: Improve sd_set_power_mode()
To: Ricky Wu <ricky_wu@realtek.com>, linux-mmc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, 
	Avri Altman <Avri.Altman@sandisk.com>
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

Applied for next!

Kind regards
Uffe
