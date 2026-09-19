Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB54342151
	for <linux-mmc@vger.kernel.org>; Sat, 19 Sep 2026 14:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789827267; cv=none; b=L9xV6jA26bUwp9iW9uVAqRAq9wR3JcvwmatiRrl+FP8JZeM9CsSyfGLxdOMGQpwJnRL7VE1zBMq+iTt8QSxkNYtOfPlj3d3cqaH/EhrhNgAO2e0XM/uXJUoSxA/T0rM+2tqF1173m3UVmrXuCozLzXp3nmHvuArXmzPRx5XM5ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789827267; c=relaxed/simple;
	bh=WRSgkDBY5tNM3yui/Kxcf6xHhw9r2/E8S3QTsi7mNCE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lwy62v/lxPZqHgj/xJECkM0p71NWmU5N1X+aYjJeYjOy5MtdFtEH9PKZL6KeDtT/bTa8sHlkdKOwDb/ndQbgaLhfqYryuD1BXx00qJMwwhTG9sgaB9jWVdF4D0EMU6b1n5hmAZDyrhU2NzAcBOJSrptiMkSAaoBV3Ivx/O3GhI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=N3aLYUGW; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="N3aLYUGW"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49cd38e0f79so9598145e9.3
        for <linux-mmc@vger.kernel.org>; Sat, 19 Sep 2026 07:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1789827262; x=1790432062; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HJXc10uVHArrgWQfirQzw4xfu+i+JBRRlfN/XUL1Ils=;
        b=N3aLYUGWG+ZBzslmo9NV7uQrfldnC5ieq+ODz2/aLQjkbybklidpv0eJFxQu5CAkLK
         WsrfTF3owFQXuHDHvPdzpaGgSemo+MGalvYy+o9/EMlU7QRz6Os8JANmP0oivVVF+Uav
         /flOaO8pyVrC0HCKDZMXMPNGHFFRaRYeQMAa1LlEueLiCXqSGCKnqLShyqahmH1OYbMi
         +SAWFLWHEiYvdAhO31IsfvCRx4wIPX1N7qgAKZvrNmQTddby0bEtiJ1UPmXgL8kDkO+d
         WYa45q2Yrb5wYbjQ1mY7mV2Q68V/4kbZ/3AJQltk4xrp3TgSa53iRGQeOnuw+FqqiaTJ
         r43Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789827262; x=1790432062;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HJXc10uVHArrgWQfirQzw4xfu+i+JBRRlfN/XUL1Ils=;
        b=FtQQjKqUk9nlCuK8HI82oWGdv8CWMbqzw6ZRAuqZ/dmi+ntpXkb1rIZnix/u7/eGbI
         u8+r3hX0jlvgVG62Wtse7YvdIiipS8tT4Iuiw7eymagyx4EByvpPUavat8LqU+c/S8p8
         qelzHzS4RX/2W58WgEvRf4dqeaK86E+VrA0tzPpXflUOSjTJmBpFt0O1/QP8zpuOOdVE
         rvfOUd5GM34JgfX+ApA3thx/wq0mknX/ssvOhKU5DLH/tJofTSfmSRG++eU9Y268o+fL
         MtQ3/v3h1bUv+/Xh0Jmy8Hu2+sSlQDFzyTsj42TjPA8F6GA/5Rpw5IETtTM5jiRlxe8E
         Bs2g==
X-Forwarded-Encrypted: i=1; AKwUvBz0OUZxxOwK/Y4Ppba2l3xPBWlXH4neMQ7YVp0gAbzMFW7IIRze4DC6jh+/RI21pmK9GzTTsBzYc8Y=@vger.kernel.org
X-Gm-Message-State: AFuF++l6TBve5HP71gD38SBKAItrsLuD+6jNDjGseCRTWG+Q+YIO3Mly
	FkkkKOHb95bYeV4Fq5GC9CatuEPkF5J4sFD4CbZKyITiVnwdkbq6t+WN6Yx2U7cYxW4=
X-Gm-Gg: AYBFou03VJQd1zJhOiP5HW/zsaZ9w8u/DP6xLaKR4gD/86tG/5YXzrBf8nN4SeE0+j1
	ZSCkITrtdugg6es3HiOR2dGCyqMoo0YoqMVNArKvqZZOin5ir2X6HxLZ10LED1WW1lZYsmq8QW+
	IyxJAuE6wG4q+9nTCwxMvxUwlcycIVHYW7a+tmAYKsVPtpST2XZMkXgH2E7/HRRyY/yFvJ2ICpD
	kK7NSri35QD34eV2P7pTOEP8rLYf4mSF1P071gMSyBWfksOsTj9VGh5vYqKpBvTwMupFU/HbdRN
	p7fvUCIt4MiC//T1F/4kMq9FlGX7eFPeqV4NrjY5XDJX/CMNYglbRjVJsRxLrrIm3y304H4qX7z
	uNT+oRLhdJeCMh8FlNRrhWU5TSPTLfPAufUWPI4tPiWIbdmnucbUZT85dgbsD1zMVBDTrxx3U4+
	3QzcH8W9YetIsBgqW9dMRM22Vlai1w50/tsPQJMdCVNj9b8fvTSIgOVDvyxBDwdm1pPEzF1ShUz
	V0rVdaBxoHIWWGz91RXT9bCjCfVWmFlLH9pR1mgdh5bD4DBc2g7jynX
X-Received: by 2002:a05:600c:19c8:b0:49f:ce78:3565 with SMTP id 5b1f17b1804b1-49fce7835f7mr20772865e9.22.1789827262336;
        Sat, 19 Sep 2026 07:14:22 -0700 (PDT)
Received: from ?IPV6:2a02:2f05:1204:e000:2cf7:c250:64a9:ae77? ([2a02:2f05:1204:e000:2cf7:c250:64a9:ae77])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fcd090f0csm106078635e9.15.2026.09.19.07.14.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Sep 2026 07:14:21 -0700 (PDT)
Message-ID: <09c057fe-bcaa-4e57-bedc-40dc1fcc770c@tuxon.dev>
Date: Sat, 19 Sep 2026 17:14:18 +0300
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/6] arm64: dts: microchip: lan969x: add SDMMC nodes
To: Robert Marko <robert.marko@sartura.hr>, ulfh@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, nicolas.ferre@microchip.com,
 alexandre.belloni@bootlin.com, adrian.hunter@intel.com,
 aubin.constans@microchip.com, ehristev@kernel.org,
 linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: luka.perkov@sartura.hr
References: <20260907132617.1198548-1-robert.marko@sartura.hr>
 <20260907132617.1198548-5-robert.marko@sartura.hr>
Content-Language: en-US
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20260907132617.1198548-5-robert.marko@sartura.hr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi, Roberto,

On 9/7/26 16:25, Robert Marko wrote:
> Add nodes for both SDMMC controllers. Connect their bus interface clock to
> the fabric clock and their core clock to the corresponding generated clock.
> 
> Configure SDMMC0 with a 100 MHz generated clock for 50 MHz eMMC DDR
> operation. Configure SDMMC1 with an exact 50 MHz generated clock so the
> integer base clock encoded in the SDHCI capabilities remains accurate and
> the identification clock does not exceed 400 kHz.
> 
> Keep both nodes ordered by unit address.
> 
> Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> ---
> Changes in v2:
> * Use the fabric clock for the SDMMC bus interface clock.
> * Configure SDMMC1 with an exact 50 MHz generated clock.
> * Move the SDMMC1 node to preserve unit-address ordering.
> * Explain the selected clock rates in the commit description.
> 
>   arch/arm64/boot/dts/microchip/lan9691.dtsi | 24 ++++++++++++++++++++++
>   1 file changed, 24 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/microchip/lan9691.dtsi b/arch/arm64/boot/dts/microchip/lan9691.dtsi
> index a8541c6a098d..5e330d5fab50 100644
> --- a/arch/arm64/boot/dts/microchip/lan9691.dtsi
> +++ b/arch/arm64/boot/dts/microchip/lan9691.dtsi
> @@ -414,6 +414,18 @@ qspi0: spi@e0804000 {
>   			status = "disabled";
>   		};
>   
> +		sdmmc0: mmc@e0830000 {
> +			compatible = "microchip,lan9691-sdhci",
> +				     "microchip,sam9x60-sdhci";
> +			reg = <0xe0830000 0x00000300>;

s/0x00000300/0x300
> +			interrupts = <GIC_SPI 64 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&fabric_clk>, <&clks GCK_ID_SDMMC0>;
> +			clock-names = "hclock", "multclk";
> +			assigned-clocks = <&clks GCK_ID_SDMMC0>;
> +			assigned-clock-rates = <100000000>;
> +			status = "disabled";
> +		};
> +
>   		qspi2: spi@e0834000 {
>   			compatible = "microchip,lan9691-qspi";
>   			reg = <0xe0834000 0x00000100>,
> @@ -429,6 +441,18 @@ qspi2: spi@e0834000 {
>   			status = "disabled";
>   		};
>   
> +		sdmmc1: mmc@e0838000 {
> +			compatible = "microchip,lan9691-sdhci",
> +				     "microchip,sam9x60-sdhci";
> +			reg = <0xe0838000 0x00000300>;

Same here. I can adjust it while applying.

With that addressed:
Reviewed-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>

