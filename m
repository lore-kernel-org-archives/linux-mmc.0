Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1FF0229B01
	for <linux-mmc@vger.kernel.org>; Tue, 10 Jun 2025 11:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749554878; cv=none; b=aslfwgRwFsPaqiiJbuzERAo6dfa4ybU9Bpi01BHB4vxG6+a9C0OKm1G1iZWd4oY+Pu2bBGOa/dLPDLqbqUiCdUSuld5a7pOEltz5iito/3pCJTWqQjg3JOMjCPj97I7Y9ZWul2gvD9lu8UKrIIjs9nZ6MKDfOP5aCZmM0QVhpcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749554878; c=relaxed/simple;
	bh=vZplNQpW4Kdm+uGw/ALGf60FNHHCr90goj7mCRdgSVk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a1ZvJpg0+Tbxu/IM502wnJ+uW5al9Tre7Sefu0luq050UEo6LEbrWHgG57msKgB4FA4qKLiRtwROM0eOAiBc6/6dsoSGwl0DgCbZ05dZVhj1z2Dp5Kq7XYJVrHItVbwzEEE6GceZl35qtm/T0JlxBpsTmMuUTWZq9lV9TkEfQp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Q3i/vWic; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q3i/vWic"
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e812fc35985so4758999276.0
        for <linux-mmc@vger.kernel.org>; Tue, 10 Jun 2025 04:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1749554875; x=1750159675; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ghUgwcJRDF54uwI455ubpjB5C5gzyoTjCqDBFTWCMHk=;
        b=Q3i/vWicUBv8ER9Q5fRxwKGrShrdh2uh9Qjlz9EXbptqtqnDNT+doXiRExXzlFWZIB
         KKOky6E1HQ65p3H+thGgpQbvpfd9MUf3fTCE4Nz0yd8eQgES3UZNOg7s9yweMBe/Ts1a
         c6mBn2zg1Zsmc7KZaLF00NHct1G+3zOT09lsFLhxPuUWb/zyqj2ZhAGoP2JBIGr9h6tB
         yJDqk/a/HzaAIKHk26I4b38ow1hsjqBb74CedKCo5ylmd9JF3GBLsq6ZScczi4T4RLkH
         qqeUmZvhmSe5KDv99uOyrRRPWV58dereuaNK3cKDd7RntyCF7TWBBq///ieuXgQiCeWj
         pOSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749554875; x=1750159675;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ghUgwcJRDF54uwI455ubpjB5C5gzyoTjCqDBFTWCMHk=;
        b=QrdiCheBXqzTO6eEfrjDqL9vZ+jFBu16mDsyeD7ln3KppuV8500+uD3h4X8POySjac
         Tym3ZBEdkGktU/Sk5cPh2bhU+rUruknY46Qwxi9U2JmzCakgCco9Ze31n7R0IseStkLF
         wQNNUpI/VBpZ20dLcIlB7MCyYc4iORyNh4Me1k21aN8ly+tVPqmLEmFXWQRr0JwfHpOI
         At+5c68Dc3WRsuPkJXN+uFNCANIAvbPNXexx4Djlwbndo/LXsZRD8WuKl7sRrefCevpy
         ni22hYNl4b8DPmi7y930ZZHudmKwdPvYV/fZS8hzD4eOiDPvg0sbr5Wgd7q4GR9fknPZ
         lDNQ==
X-Forwarded-Encrypted: i=1; AJvYcCUDsw9ws6dHbywEnnjnfgCGHPkbrnmkMTLZ7rizuoOILY/mYQcOqtI5tQLCFEHMBnyfy1DA7pJfNBI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeUEB48/T6cPofmrHjBnaSPuno9nPSsngk1Z8vpaMpQtVCNPDe
	6EQOBtfVVcI5Kn/mJLGiLiOkTHn494Fs5Xxpq1ssj7tnZ+Ei+Ls1V04m28r9l2YGqkvy+xwDhHw
	USXz3FE/JMS9EKAuS7YKqVSIdd9wYGuueYeusWYGVIA==
X-Gm-Gg: ASbGncsxGHOkN4ZPQpRSHU8LgHPw/AE3fqggqdu0bVxLZrCQGvBjVRzDwpilxwBNEVD
	2tmimvWu4JHp7iW06ft3GQNLpahSvJwV1PJdgDesxSrNQsXyts7qDU/hyYp4uREEt7WHrmrDicr
	Lj+l9kaj/e2f2PnPTHjFOfw7NMeaG5wsTDUDO7qEJclPZs9B+I+h+icO8=
X-Google-Smtp-Source: AGHT+IHaXIQBlJX6AevUD9L1mnT0PM9CRgJ8oCkRDaWqwAf3jmN5DRjOXayJZtYpNPaGNd4bstUllo4nDy7qlFpYde8=
X-Received: by 2002:a05:6902:2212:b0:e81:2740:2d96 with SMTP id
 3f1490d57ef6-e81f35fb2abmr2798929276.17.1749554874790; Tue, 10 Jun 2025
 04:27:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250606030545.1743961-1-ricky_wu@realtek.com>
In-Reply-To: <20250606030545.1743961-1-ricky_wu@realtek.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 10 Jun 2025 13:27:19 +0200
X-Gm-Features: AX0GCFsv-5-jjIFHT1wPanu_4OSSvcbRzjHkON4AWucIRUPqgmoGevTh0__rd_Q
Message-ID: <CAPDyKFofk3LC1Qo4HSigDhdR2-iDwOze=sYftoRB5U9i9wqXsg@mail.gmail.com>
Subject: Re: [PATCH v3] mmc: rtsx: usb add 74 clocks in poweron flow
To: Ricky Wu <ricky_wu@realtek.com>
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

On Fri, 6 Jun 2025 at 05:05, Ricky Wu <ricky_wu@realtek.com> wrote:
>
> SD spec definition:
> "Host provides at least 74 Clocks before issuing first command"
>
> add issue the clocks when power_mode is POWER_UP
> and stop the signal when power_mode is POWER_up to POWER_ON
>
> Signed-off-by: Ricky Wu <ricky_wu@realtek.com>

Thanks for trying to re-work the code according to my earlier
suggestions. However, $subject patch still seems a bit messy in my
opinion. I decided to try to help out a bit and posted a series [1],
please try to re-base your patch on top of this.

Kind regards
Uffe

[1]
https://lore.kernel.org/all/20250610111633.504366-1-ulf.hansson@linaro.org/

> ---
> v2: remove delay 100ms in power_on
> v3: Use switch-case instead of if statements
> ---
>  drivers/mmc/host/rtsx_usb_sdmmc.c | 36 ++++++++++++++++++++++---------
>  1 file changed, 26 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/mmc/host/rtsx_usb_sdmmc.c b/drivers/mmc/host/rtsx_usb_sdmmc.c
> index d229c2b83ea9..1c808cfb44ff 100644
> --- a/drivers/mmc/host/rtsx_usb_sdmmc.c
> +++ b/drivers/mmc/host/rtsx_usb_sdmmc.c
> @@ -1014,24 +1014,40 @@ static int sd_set_power_mode(struct rtsx_usb_sdmmc *host,
>                 unsigned char power_mode)
>  {
>         int err;
> +       struct rtsx_ucr *ucr = host->ucr;
>
> -       if (power_mode != MMC_POWER_OFF)
> -               power_mode = MMC_POWER_ON;
> -
> -       if (power_mode == host->power_mode)
> -               return 0;
> -
> -       if (power_mode == MMC_POWER_OFF) {
> +       switch (power_mode) {
> +       case MMC_POWER_OFF:
> +               if (host->power_mode == MMC_POWER_OFF)
> +                       return 0;
>                 err = sd_power_off(host);
>                 pm_runtime_put_noidle(sdmmc_dev(host));
> -       } else {
> +               break;
> +       case MMC_POWER_UP:
> +       case MMC_POWER_ON:
> +               if (host->power_mode == MMC_POWER_ON) {
> +                       return 0;
> +               } else if (host->power_mode == MMC_POWER_UP) {
> +                       /* stop to send the clock signals */
> +                       rtsx_usb_write_register(ucr, SD_BUS_STAT, SD_CLK_TOGGLE_EN, 0x00);
> +                       host->power_mode = power_mode;
> +                       return 0;
> +               }
>                 pm_runtime_get_noresume(sdmmc_dev(host));
>                 err = sd_power_on(host);
> +               break;
> +       default:
> +               return 0;
>         }
> +       if (!err) {
> +               if (power_mode == MMC_POWER_UP) {
> +                       /* issue the clock signals to card */
> +                       rtsx_usb_write_register(ucr, SD_BUS_STAT, SD_CLK_TOGGLE_EN,
> +                               SD_CLK_TOGGLE_EN);
> +               }
>
> -       if (!err)
>                 host->power_mode = power_mode;
> -
> +       }
>         return err;
>  }
>
> --
> 2.25.1
>
