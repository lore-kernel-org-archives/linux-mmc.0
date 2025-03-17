Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FCEF221730
	for <linux-mmc@vger.kernel.org>; Mon, 17 Mar 2025 10:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742208698; cv=none; b=XUpb72/sm8FiqTO/ILA0IWnhhD0W7scRzE3ZEFvMko/jra8MuwvrH602d83XUGZ5IMzq98VAHsJf4QuQDhKaBfex921X8NJDwNSmuyIeV1Zzxz4+bBUwQ8CdADIaZbPbLekIVKJV3YyC7Q/FzAL1TLNKDUh52PXKrXqz9hN25kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742208698; c=relaxed/simple;
	bh=G9bGpVVumkh4EkeQ8f+423AnFKXvZJS9Sk4lm4BBydc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DgUt2h65osm0NxDMkvAtQuhZSRlasEginEyyE8xrkm5nOzZNzR++zkCjqAfNSMP/RwRiNk8V7a27Nis1O0A/oMdwiaSRA+HISaLSyllSnlTcr+/FTggw0G2ZWykiwptKgqiFF9A9fl3w67VWVeiYEv2VOFy57BGe4gfe+y5+pF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JFkbfuaE; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JFkbfuaE"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6ff27ad48beso35606137b3.0
        for <linux-mmc@vger.kernel.org>; Mon, 17 Mar 2025 03:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742208695; x=1742813495; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XfVnG4HkUsVDQ5d3JfJrfe7r2SoolZoIbYsONCWi4uo=;
        b=JFkbfuaEHPPFPnEVdlGF7mLpnEi2v0/MwVP90rSOewDXxHN1fIuV2oev9W8p8CcRFQ
         2pLeOf0EmooRC8O0aThuUdl9HNG4YtUCCJL3x4ORe85+gVJ6N//Ne4pv3zEznbPZBksR
         F/61d79m+O07U6asq8eQmhZ2OFlBaHtXzemdAhRiyOMvBGtT6G5SUST5g8CEhoAROEbg
         RGIxMjhXcRhibDQ4GkZpdZs1PTRctaDeqWf43knlnK+PDCn7LaqFZRsrjRpdx5yGpRUR
         8MLCsO3vxdVl2nXFU6P831tYrnmnODgpPcmTfBYjj2ce/pc0pt8nlo3kkpqXHL6niq4B
         8wUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742208695; x=1742813495;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XfVnG4HkUsVDQ5d3JfJrfe7r2SoolZoIbYsONCWi4uo=;
        b=o8hKS9E+uOG1m+4eHwDVkUQ24QWhD5W4s2uniao8r1zpdpEHA6NkG8tktEfCNem6oH
         SQSDP59TNKHyrOQLXrMhH/g1UYY0YqnLOheft5g3ENQn15pBeSSWJnve/1YkRtZAdG0N
         q/1DlqyL3+ZhWRtkcCSrSo7Wt/0IddMZdHuyVkUiLyE+nDAMIFNseBHB0+G3mCrxSztA
         yRfagP+8A+O6dr8u91dvp+JVv64GsYLJOH0/CjJKt06JWpFUR7kpcs9kwzxj2vkC/LmA
         NZV+4NXN12vV3OlgklavnkuIO8v8JkFz8k8/qVBZFdpPiCP3J31eaEiyi8c/KmbSMSY+
         Orsg==
X-Forwarded-Encrypted: i=1; AJvYcCWxak9qWzzaST69PrY07Wl1ktglBN6+KR/3WAKTSCKwaUVENUEATL5YIqxx017ZFWfZxTaHnNPUZF8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0I2lg0mgEKIgJKFAH3SGwn60nonMnGlWy4Tl1VgIoMcVuIjMZ
	fDs1czDGXB4JmvqHnrNQM7SglXOhvGCJKEjyt57XF5UHi/fqjim6e9vBuXvI51l8Y0qR01qWk76
	MT7xc7DOWz+FHYode9l+GqU+yPsCKzz096i2sAA==
X-Gm-Gg: ASbGncuDsxMeWZMHPv2l/Rl4z2OeCxJayg/IewsEbVF2V5ZRyh0gP0uCpqs8D1timvl
	ME8dUQaRQQsRWiQcMmhgl4uEwCZqAfg+1M/NpEMY3FkHuDVfWUQ0Ftbrw5mP1BWc6XSD9HrLfaJ
	42CWVPr0oSjL7crVpy6ttlGGjjetpl9xK6lw6TLw==
X-Google-Smtp-Source: AGHT+IHG+hqqY7z4YWoNHFwken+n5F9fRUkOdKWXpn1zIzLsSXAtBJ1qYKxYTQkl9v5HsBxDmf6GRlQfnrNNQji4duU=
X-Received: by 2002:a05:690c:740a:b0:6fb:b2de:a2c3 with SMTP id
 00721157ae682-6ff45f615d8mr143741577b3.9.1742208695401; Mon, 17 Mar 2025
 03:51:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250317070046.24386-1-jirislaby@kernel.org> <20250317070046.24386-18-jirislaby@kernel.org>
In-Reply-To: <20250317070046.24386-18-jirislaby@kernel.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 17 Mar 2025 11:50:59 +0100
X-Gm-Features: AQ5f1JozYMb7s-WMdJg9CTQSW8y02swNli38bn-VGUEE_cdcqwI1tkZFu3cBTsg
Message-ID: <CAPDyKFrwNfd3F5EvXvTJHM4dd+mUuy6jQXxVpq4FtCzPN0X2Qg@mail.gmail.com>
Subject: Re: [PATCH v2 17/31] tty: mmc: sdio: use bool for cts and remove parentheses
To: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Cc: gregkh@linuxfoundation.org, linux-serial@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 17 Mar 2025 at 08:01, Jiri Slaby (SUSE) <jirislaby@kernel.org> wrote:
>
> 'cts' in sdio_uart_check_modem_status() is considered a 'bool', but
> typed as signed 'int'. Make it 'bool' so it is clear the code does not
> care about the masked value, but true/false.
>
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: linux-mmc@vger.kernel.org

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/core/sdio_uart.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/core/sdio_uart.c b/drivers/mmc/core/sdio_uart.c
> index 6b7471dba3bf..7423a601e1e5 100644
> --- a/drivers/mmc/core/sdio_uart.c
> +++ b/drivers/mmc/core/sdio_uart.c
> @@ -471,7 +471,7 @@ static void sdio_uart_check_modem_status(struct sdio_uart_port *port)
>                 port->icount.cts++;
>                 tty = tty_port_tty_get(&port->port);
>                 if (tty && C_CRTSCTS(tty)) {
> -                       int cts = (status & UART_MSR_CTS);
> +                       bool cts = status & UART_MSR_CTS;
>                         if (tty->hw_stopped) {
>                                 if (cts) {
>                                         tty->hw_stopped = false;
> --
> 2.49.0
>
