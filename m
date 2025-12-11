Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE6592222D0
	for <linux-mmc@vger.kernel.org>; Thu, 11 Dec 2025 11:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765452745; cv=none; b=DAyOWKEL4PaY++g1Qcul6KdwiTdSqXOYeQobDHqaChjqH0I5fgbimU+9Yv9wcRVGY3V0iSF7RKrg19yG1RiprnA1wI8zMbvGfgkO3uwxJOpW8cg+gJKcTBcX4D2oQ9vFRAmGuDmcGsZl2b1wpeQD84CY4elmVKvnfI9fhkgIJQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765452745; c=relaxed/simple;
	bh=fTSH993Mk+TXcNH7gBcDzv8X8Zy3Ya7TfMmE6MvGpFc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MB4z1pF1mcvT93FEcx8ouR23cZ4Wbl0YoRp4JGuUoUi6i+zjoJhqdJ4LRmuxsYaEXKQ4gKApznw36ddRrg/LFc05b6kvgFqPp+VF8qTCSWcRhCWQQupaXcz//exoUxv0SOxoWQgTXpNEKOSv3XAiLHGBQxQf4hb6pAAzhRqNKZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JqjYI0+Q; arc=none smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JqjYI0+Q"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-6420c0cf4abso817923d50.1
        for <linux-mmc@vger.kernel.org>; Thu, 11 Dec 2025 03:32:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1765452742; x=1766057542; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=phiy9ied8gdfxveKkebHqanag2hE7Otb50tt4bxl1+s=;
        b=JqjYI0+QfCo2XJtf6glhKa4oS63fM3EiwnAyqO6fTI6BPzirD8QQyM48d/AjqlE5ni
         olrWKVMLmfSuw93+pIqY5JAs7SerzbNm2dv6TfsSzoUjHr7PQURGgJ+nDJiVPl3xx+Ht
         RyKElP1puHDfVaeIp94/WkUNFhMX2hG2Ffl68cgargk44w5ddzae5456iRqF8yaeS5wk
         1S+F/0+PhyVM4URNyoPHK1fCsp66FOQI0z8deC6xLLqYD60Z+F9TRohmLaufyDOlOxfH
         8YF980pLwUbReSRDgr3F7kC9SdQMEtWwVKlsPlFElx2xxfTWbXw5GXr0Q90dgOrqZuis
         1y6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765452742; x=1766057542;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=phiy9ied8gdfxveKkebHqanag2hE7Otb50tt4bxl1+s=;
        b=O596OiNGh6RYbrpTVejHAVgAL1ljXU0NkW3oS/JDargfhR57MmZO7MOsLX1FMm89Z6
         NR/i212RvVMP1UfIbxutSpRJQ0lFyXQi6vaAt1V14ok/od5AM72u8rCNsUggFmyDBDkq
         GXwMvG96a6a95HP67Sd48uaNpbtLhnp8Yok/nD8rY0o/OQS6FnlJuiX55QGJAjNWkL7n
         X4WLaLMl1graXJ/gs8wCNNVR+X2dpNMY/KFTr79O+Ml+ChGbXxvZjFz/JWm21fylB2eu
         VX5KGrkRYMDySq1lRll9sVWbaKPsLs5ouQ07qMcQL8EL6W+hgwW+YzNFpq3F9HvMac96
         MY4A==
X-Forwarded-Encrypted: i=1; AJvYcCUEoPtHfO90k+NB7cI5ppTCvctXY6D6ClpNcSfQxiYUi1/xR4fhFSHxUsyiNlsfB15aW+6dnlRiklw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxmch5GBgrpoQ28wcnIGPYZ9tyc9ZtN25lUzpx5FZZ4EEGD00Ej
	Mu3Yy4YRiZiLBHTdGbXGt6Jsk3YQLoLRPkiEEP9iMV9bI5IwVFrB62yKYVXwXjYmKhAYdB20YjO
	Swf73PIpqpMtqUAqW3ti86iqbNRPEypw8oyvwxT37u5R3oEYt1wix
X-Gm-Gg: AY/fxX6/+QBiOgUxcDloUM37e3kgMZiwvXZnOUZHl15es9DnbFkryAa8dnWG6UcvV+D
	Rg8BguuahTFoV3liA/P6M+YfbCTYfHqVK4I2kscWgqvipj87shGnjVoc4EDfKb7dLbgRSFx6aIS
	RDNwOTJpSf6xZ+uAacPDDxoBpyqN8fHGwvyjJgDjUsbecYtO6lFHTvaTtzg+jmL2893pvwLeO3B
	ZVMVLc10XL5jgq6aULMTJeBNHyQ40ld5sPgm1RGoixzqbLaBizkQE1PO8pLjyLZ+baDKHEy
X-Google-Smtp-Source: AGHT+IGcqwaxtfJMJnD56RcASi/uVKO/lK/0JnQ8qMBQTGtHR3OnnoyAdnC7R6PIycF4XsJLibnnvktvbwIlYjUAVZY=
X-Received: by 2002:a05:690e:120e:b0:63f:96d7:a350 with SMTP id
 956f58d0204a3-6446eb4a92cmr4347837d50.66.1765452742333; Thu, 11 Dec 2025
 03:32:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251211-dev-dt-warnings-all-v1-0-21b18b9ada77@codeconstruct.com.au>
 <20251211-dev-dt-warnings-all-v1-7-21b18b9ada77@codeconstruct.com.au>
In-Reply-To: <20251211-dev-dt-warnings-all-v1-7-21b18b9ada77@codeconstruct.com.au>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 11 Dec 2025 12:31:45 +0100
X-Gm-Features: AQt7F2oiHWORIK5IUrdndTpX-opjO6A0dESgetC9ddqm2QKKAaLxTanuvA5lEio
Message-ID: <CAPDyKFqZQUurBNSNUBKE7rgBf+UHxKiYBWt+xxSY+dh7PgdPPQ@mail.gmail.com>
Subject: Re: [PATCH RFC 07/16] ARM: dts: aspeed: Remove sdhci-drive-type
 property from AST2600 EVB
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
> The property isn't specified in the bindings and is not used by the
> corresponding driver, so drop it.
>
> Signed-off-by: Andrew Jeffery <andrew@codeconstruct.com.au>

FWIW:

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>


> ---
>  arch/arm/boot/dts/aspeed/aspeed-ast2600-evb.dts | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-ast2600-evb.dts b/arch/arm/boot/dts/aspeed/aspeed-ast2600-evb.dts
> index de83c0eb1d6e..3eba676e57f1 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-ast2600-evb.dts
> +++ b/arch/arm/boot/dts/aspeed/aspeed-ast2600-evb.dts
> @@ -314,7 +314,6 @@ &sdhci0 {
>         status = "okay";
>         bus-width = <4>;
>         max-frequency = <100000000>;
> -       sdhci-drive-type = /bits/ 8 <3>;
>         sdhci-caps-mask = <0x7 0x0>;
>         sdhci,wp-inverted;
>         vmmc-supply = <&vcc_sdhci0>;
> @@ -326,7 +325,6 @@ &sdhci1 {
>         status = "okay";
>         bus-width = <4>;
>         max-frequency = <100000000>;
> -       sdhci-drive-type = /bits/ 8 <3>;
>         sdhci-caps-mask = <0x7 0x0>;
>         sdhci,wp-inverted;
>         vmmc-supply = <&vcc_sdhci1>;
>
> --
> 2.47.3
>
>
