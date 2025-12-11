Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1C82D3A70
	for <linux-mmc@vger.kernel.org>; Thu, 11 Dec 2025 11:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765452750; cv=none; b=hVyQKPBHOkLc02cg8cNeFSdeMalixxuL1DJ0+rJJgrFgwsZ/bpHP3vg4lmE1L5jQrOi0nkVWS3PvDyF5Iad4iIG9kOx7t+f9SA7IGZKZkRaYmUtzqabLhVJP/NoPqQMnKSEoO0gs6IcgmSIXh+zX/KdQMCI4ArYsDdVocKNIZO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765452750; c=relaxed/simple;
	bh=POzzpg6IYRZPIIqbdlvOsPFON8CAFCtqiOP8BsCzG6o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=loeX84VemPHqHhc3llRKFY9pHqwExskifqGLUDFSm9eE1/5Q1uL3cEaFdarSdnN7HYCDrBvGRwn4zYlVDwoco+nF3Suv6RTCM351x6HzO1W1wQzJryixxisN57cBzY1Y74h4HrUJznwSmpSaCKjZ+E4lMC+MVPv3B0ObM7zGl6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NtJnTaGk; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NtJnTaGk"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-78a712cfbc0so9670117b3.1
        for <linux-mmc@vger.kernel.org>; Thu, 11 Dec 2025 03:32:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1765452747; x=1766057547; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tsAQFyywzgQt8hTuOma0wGcWOIPVIjI9LIgrRTCikK4=;
        b=NtJnTaGkvuf9r5BFmo4AYj1CaI/INFVazyoJJPcv6K82v1KZBH+lOmxmhfMbLhLfcr
         uVe7oFkhwFobKOHzwGE63T2H9L27wdtFG+lP/ffLqN/Mwa1j979U38NfyOSHMXS4xV3U
         OrdQcgWaJj8CfZdVsKjpGx41q+OVZcHd3SbAOyBbBmsyNmFmA0CWANT/ZLsn+l6reRO1
         iDromQMSouYwyd7ZM/RM76HLP6f9e1+BLAwv/74l3krLepSOQYcYDlUObFz9s5MOBoxu
         N2kKHOYjrMvzXu+SXOX2XqGew8KU/TGDHnk00b1SzSh5f5/FiQLTSjZ2VPcdWiI9COTz
         Jxlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765452747; x=1766057547;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tsAQFyywzgQt8hTuOma0wGcWOIPVIjI9LIgrRTCikK4=;
        b=M0+UioPf3BijeSJ9NNkaCLXZaZXZWKHkvsucqdRhPid7ay6GdNnnFBchI+VFN/S0TP
         MlH4bx0HYyboiq+MsNuU2ptegx4/oZO3/v/najzvDKK7uXJ0BK3g5Q9vm24Wb5RvR8xO
         x3lsXGVLKqXEBc3mRW0j7wdIqCqf7L+zJENvdchtvMn0OtWxGNvReR9XhisFfeYaiqzw
         ZyzjQxZdLsP5dXK0CdVE+/+AiGY73/Qns2ebx1yMh/5ghfckOSWUdkJn7WP7Kyd3G1bJ
         DhcaaeWAiaR7z7TuVwpXe1ZY68eihrhhnpUcMVuCeraHCfMWWXp47oYBqfBxcFV/GMJD
         xiHQ==
X-Forwarded-Encrypted: i=1; AJvYcCXvFIgU88ysbB/PiRDWU0LQ+yl4xGYmcw7cQROdKJ3Vm94NH9w2vwAg9zI9mlJTh/5Evgzzo1O30LA=@vger.kernel.org
X-Gm-Message-State: AOJu0YylDyQOmQQd8PgGi4+wS9puR0w1I0hIt/+5HvLXCwbBKWZYwfqY
	KycCtDbgVUTmTy7RTleABi9LHNXid6GmjHh4U5Ko7XRJnnU8CFZK3bvcJBQtDwflw4AeOWMpz2b
	k0Wf3XGizLgjJ/JrNqITeBIA7yfFvHuPr921Owj8C5g==
X-Gm-Gg: AY/fxX7v7o8r+zPWxZAGZe6U/E0dk5CZfmXa5iaf0E4C8OG3o8nGxhuj8tLOXZVtFRv
	M/oMJPiwlC80aM/x91+NAI3en7yKIsSkhDAz43i0L8aHHpXaV1b/CYpmZSg/f7el5xON4l2dMge
	XAIW765I1l/m3veWPWpWkytGnjaoXgv6WhxJwckkbAJVkqr+2+4eM73k965QK7/27qsI2TRHZNQ
	b9jsR+DvCWJvrTsVug+AEf+LDC4THdbR1CkiBLHpBGmHFqCqMHHnzvSr4MOy0QvtoMJul/0e/MP
	ADO3YFc=
X-Google-Smtp-Source: AGHT+IGi8FI7tue2F1muYiYdXCcwa1VCSq2fLFaLgh7A0p4DE+EvhP5UsxEj9lkt3uuk+LvjC2KVDNW0gmzNrvJK74w=
X-Received: by 2002:a05:690c:45c5:b0:787:bf16:d489 with SMTP id
 00721157ae682-78ca64495eamr51688117b3.62.1765452747098; Thu, 11 Dec 2025
 03:32:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251211-dev-dt-warnings-all-v1-0-21b18b9ada77@codeconstruct.com.au>
 <20251211-dev-dt-warnings-all-v1-8-21b18b9ada77@codeconstruct.com.au>
In-Reply-To: <20251211-dev-dt-warnings-all-v1-8-21b18b9ada77@codeconstruct.com.au>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 11 Dec 2025 12:31:50 +0100
X-Gm-Features: AQt7F2pk6E2fyrBRST0HoIuBOhvmNQUfLJiP182o7R-P0Ig55Fk3IUyQwfYuHbU
Message-ID: <CAPDyKFpQXYFFrZ-unVxa9m2+tKLEyFZyo7Tv7JD_7vTbqqfmDQ@mail.gmail.com>
Subject: Re: [PATCH RFC 08/16] ARM: dts: aspeed: Use specified wp-inverted
 property for AST2600 EVB
To: Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Linus Walleij <linusw@kernel.org>, Joel Stanley <joel@jms.id.au>, 
	linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org, 
	linux-gpio@vger.kernel.org, linux-mmc@vger.kernel.org, 
	linux-crypto@vger.kernel.org, linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 11 Dec 2025 at 09:47, Andrew Jeffery
<andrew@codeconstruct.com.au> wrote:
>
> While sdhci-pltfm supports sdhci,wp-inverted, it also supports
> the un-prefixed and specified wp-inverted property. Switch the EVB
> devicetree to use the specified property to remove warnings when
> checking the DTB.
>
> Signed-off-by: Andrew Jeffery <andrew@codeconstruct.com.au>

FWIW:

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>


> ---
>  arch/arm/boot/dts/aspeed/aspeed-ast2600-evb.dts | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-ast2600-evb.dts b/arch/arm/boot/dts/aspeed/aspeed-ast2600-evb.dts
> index 3eba676e57f1..c51977dcb56b 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-ast2600-evb.dts
> +++ b/arch/arm/boot/dts/aspeed/aspeed-ast2600-evb.dts
> @@ -315,7 +315,7 @@ &sdhci0 {
>         bus-width = <4>;
>         max-frequency = <100000000>;
>         sdhci-caps-mask = <0x7 0x0>;
> -       sdhci,wp-inverted;
> +       wp-inverted;
>         vmmc-supply = <&vcc_sdhci0>;
>         vqmmc-supply = <&vccq_sdhci0>;
>         clk-phase-sd-hs = <7>, <200>;
> @@ -326,7 +326,7 @@ &sdhci1 {
>         bus-width = <4>;
>         max-frequency = <100000000>;
>         sdhci-caps-mask = <0x7 0x0>;
> -       sdhci,wp-inverted;
> +       wp-inverted;
>         vmmc-supply = <&vcc_sdhci1>;
>         vqmmc-supply = <&vccq_sdhci1>;
>         clk-phase-sd-hs = <7>, <200>;
>
> --
> 2.47.3
>
>
