Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05F0266B4E
	for <linux-mmc@vger.kernel.org>; Mon, 28 Apr 2025 16:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745856560; cv=none; b=hKOh1/pcqZ8E+x13RAeqhGkBunPGCrooRyt5Vmg7JdxCbs54Q07t+nvmDCAyO6GNPZNuDe9HYtQKAP5Zm1t7wujgFIYZu6st6NqRvbbhIuofYFdlMq6P18uGgO53ex7LFmaM9+rupBuCIcN99XGOrWWRtlvixoX2X2rVc6H1mzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745856560; c=relaxed/simple;
	bh=FxpVlTj9Og0fal9AGjqztLBuWeXzj8BFTeMP3+xLTPc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X1lI/dVJio5C3QJlmYE/PLa/Kcr/rBNHOgHSTiEhPw0Ojc05Rba4OEONzqPTE+wZ+ohhAwGB7plhtp5CKd7FuP9vzHwV8x7hoxHhZyJLonifljRgOto4JfKL1FGwxIbkTGMF9ALba95Y2QZzJ8gqbkgxZqzaR7kPL5xtLaQVbbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=n5jIOwE0; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="n5jIOwE0"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-70821dba48eso38223517b3.0
        for <linux-mmc@vger.kernel.org>; Mon, 28 Apr 2025 09:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745856557; x=1746461357; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yqcC00DctTwElBMGXfCuGugRSRS3FAHgs7qozz2W9RE=;
        b=n5jIOwE0DWmAW06B+ZC2nZwA7AzTiognNPjeOs8wRH78SiwEUr3jwXA7+0orCXuzdV
         vvXizioTevDKVxckEmQ7/bJecDI7fCiPCKCaC+xb0pFrs3jrK+tzKRf/vHGduCD8cZPi
         WtEUyh5Cw1f+BH/l5tn7V/NGS2frrT8LV6QWewyVJV8LeIp4GRdkCzj8/b8AkA5UEJNK
         OS4tJQY5Xnm1Tb/Lp9+esDM2X6vpCU4HG0MqbulPmhOcwajTDYJm8N3pJI2PvDlQaG0Q
         E69LKrSokfiMVco8xmvLMZ1hyxqnX35eVyfqfiOGFhzVHlG8YRgRpZb4Tnzlp5xXf9jt
         5SDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745856557; x=1746461357;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yqcC00DctTwElBMGXfCuGugRSRS3FAHgs7qozz2W9RE=;
        b=cqtMP1k4zVh+JEv1nrISpa8fzdXdPm+iwdeLW+6nkSkYiNfU0e4wNQ3IwrgSL79UV6
         +O0UQxHRw46C/UftHJMKs6wQsgojRvfh94YNnc9TcprbyToFpVj0GNIYTcjqGJOUouTd
         a3hgh9ZMkEbEBPzhXD3qYvgqLt/DVTJpYjuWpl95toyjyxzvu2W0Y0abZnwE43LFxboJ
         E/XguSGBVc/8amKSw4pkiHgmebpmj9bR/fBoUFNtg+j446G9kvQ8DKNtsTEosgPIoBAe
         CYvh5qs+W50cKbme+ISI5tt5GTvMT5N3J8YauQfE2DsY0+QaV6O/arRvgTzYPGEXjsvn
         fdeQ==
X-Forwarded-Encrypted: i=1; AJvYcCXsUpC5dVy99COe44M8r8+dsZW4L4ze6bqYf/F7jLxgfUbH0tfRJA38S+QC3PmTHV+5bs+tzhqbK4s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMYD9iWHUCMpc2hXKJEMxQYqq/8al694+k9+QFDPz05n0z0cWk
	jtqrUzUgd4vZ767uGAgCul7NYaXPBF/QIdBVcBsac6RzxUXkaQiV8w9TxaFf59OAxJGMW9vMARs
	Ebhb9gcQLrATIvJ4xshjd25ky5HMZInK1zAKK5A==
X-Gm-Gg: ASbGncvgQDdU+ZLhMI7SWyLhkO1fk2YuqJG7wPFAcFnwggVMZHKkyCVYWrI5C1uONuv
	OytUaaoFNlf3f3z8DptHwDe1cD3WAxKTyUUBIh5DxU0bDsE8c+EFEhtX6C5GLL3jy31iYdpNBFv
	Ycp/kJ970z8CV6kswnMnaRYso=
X-Google-Smtp-Source: AGHT+IFEFlpBt75E9EmIVPvfAWV/hGclcHZhuGr+yR9C3ot2RgIFPMVPhVt5NG3pmNSvDkBdKNsEDpJt2mO9I3DlqTs=
X-Received: by 2002:a05:690c:b9b:b0:6f2:9704:405c with SMTP id
 00721157ae682-7085f183418mr133016977b3.15.1745856557599; Mon, 28 Apr 2025
 09:09:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250421031536.1173373-1-ricky_wu@realtek.com>
In-Reply-To: <20250421031536.1173373-1-ricky_wu@realtek.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 28 Apr 2025 18:08:41 +0200
X-Gm-Features: ATxdqUHSoZXSXQAQyumHjEg_3CVlyJjSwwyw2GG_4aqVXDoXNhtZeDVWMOl3qBE
Message-ID: <CAPDyKFqNWirdJMA_7kpWjUcNYh4q9RLOLW+eY1hPztw4roEsMw@mail.gmail.com>
Subject: Re: [PATCH] mmc: rtsx: usb add 100ms delay before power on
To: Ricky Wu <ricky_wu@realtek.com>
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 21 Apr 2025 at 05:15, Ricky Wu <ricky_wu@realtek.com> wrote:
>
> this delay make sure the last time power off did the discharge clean.
> During the card recognition process, card power will be toggled in 1ms=EF=
=BC=8C
> and 1ms is not enough to discharge cleanly
>
> Signed-off-by: Ricky Wu <ricky_wu@realtek.com>
> ---
>  drivers/mmc/host/rtsx_usb_sdmmc.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/mmc/host/rtsx_usb_sdmmc.c b/drivers/mmc/host/rtsx_us=
b_sdmmc.c
> index 1edfe2acf809..e5820b2bb380 100644
> --- a/drivers/mmc/host/rtsx_usb_sdmmc.c
> +++ b/drivers/mmc/host/rtsx_usb_sdmmc.c
> @@ -952,6 +952,8 @@ static int sd_power_on(struct rtsx_usb_sdmmc *host)
>         struct rtsx_ucr *ucr =3D host->ucr;
>         int err;
>
> +       msleep(100);
> +

Wouldn't it be better to do this at power-off instead then? Otherwise
you may end up adding 100ms at card-initialization even if the card
has been off for a long time?

Or maybe this is because we are worried about bootloaders turning on
the card and leaving it in that state when the kernel boots?

>         dev_dbg(sdmmc_dev(host), "%s\n", __func__);
>         rtsx_usb_init_cmd(ucr);
>         rtsx_usb_add_cmd(ucr, WRITE_REG_CMD, CARD_SELECT, 0x07, SD_MOD_SE=
L);
> --
> 2.25.1
>

Kind regards
Uffe
