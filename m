Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A46A15821F
	for <linux-mmc@vger.kernel.org>; Tue, 18 Jun 2024 09:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718703656; cv=none; b=t1wRLuvj+cbrLJD8MUKiWeaRdr8/S6uXc925ln7ce3eUHIucPlkhMvZP5CDMyz8AC8C4vFw3+OH7FCBDr0AhEp/va4SvD3DqV5tiIN67mdM9dxdw9hHyey6eZb9KqfKajqsKVOZ6min7N5myGoGPLkIyeSoc+L5LLR8UosejHNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718703656; c=relaxed/simple;
	bh=33e3Ihd5f40K6c24G0nShy9Rg94fJg63CaJ6eSr53bk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JqpCW5UMxAZri4lkQIEguAj0LEtBkuztr/YXuCwS/B0BoKuMv9jQEYUcVPHQxf93yGjPiKueodgA60P571pLyOAZ29dv6RcoZced2dKGyrFdgN4dUgd2yXLnTo0h6AAkBn2ii+6GHmD/yAL+PBUMcn0YVaUFr6Sc5XFlwlKq5ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MDtNs3mg; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MDtNs3mg"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-52bc035a7ccso5504279e87.2
        for <linux-mmc@vger.kernel.org>; Tue, 18 Jun 2024 02:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718703653; x=1719308453; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Q1dUAwLlzqf/kLhtXAP0bzcDfhg1+v3m5zpzjEvnZvI=;
        b=MDtNs3mggdVouNpqDU60+H3JixK706UbVesqull81s8P2PR6dT1FT1GZuQLR2qRDf6
         8prNIY+A2SHEWwNYa8PdBA/pUWqT472oHyf2JbwKKG5VRwdYwWEASrDsJ+2F3/iiRq5O
         5kg6MtEHS7jG4OmKdkT5YikqWgTvzrnHLMmAgfu48R1iN7kLI40IlY3pCj4+a6o2kaMx
         uCJD5PI+dHrCguyos3mCm7Cjp4OULFonT2nVvYPkzXv8cXnHccQmrt+vUR3tYtO13shI
         yLic5v7xxwrhYf7QhzKmrxOVm/S7KnX+cyLykwuGuFL475iCrOq/odO5n34fAxkHb2mJ
         M4dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718703653; x=1719308453;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q1dUAwLlzqf/kLhtXAP0bzcDfhg1+v3m5zpzjEvnZvI=;
        b=boLrBD4HHiZV93jfC79m82r8rY+t0hEjnEe8dJ+b9qvOtN3VgNudPLh4aWPCONZpvW
         tWqKkLwc1ccOt3dU3qG4TyPw0mv11skCTVFNP+twE2vTXmC0nPS6dl0lLcw3NdkEXLNm
         qYC+Jmcm6ezTb5mZh+uyUKJJ0vUJdgOdTmldogjaAE/TzQy4amQTHqFQ9ZziCaqCz7jl
         4LczzSQYJYqR78s9aC8/8kp6eG9BZ0OY/G+UHg0cCHUD3hP5bK1ZestyChEKCRqGWFE7
         fQUIQEyZ05t9T2X29Ywgun+WCaicZSRzAgMxMhmAlcxdzpwPJU/RXDiPA3YMlAHr+0ec
         idzA==
X-Forwarded-Encrypted: i=1; AJvYcCUCpKiqXvTKc3XylhEXmK+l7JOt3pUE5BTTyvbPsBdNYjOjzdLZWOoSqkHhsSVPe4CH1FpQgH3z3OaLkbX8E7HqKi2xoSzlDHev
X-Gm-Message-State: AOJu0Yw7s1O/Wp96Ue1drDZK5sNia8+a5hkpwbltY03Uqcf0r2pe0qhj
	Y0AUoKUn57ALyAg9QeZPrv97ysGLskIZL4kpiMyNEY0T9okqst0biovULtHxTxU=
X-Google-Smtp-Source: AGHT+IFW4Mx2N85kJ7p6HdOoFLfWozgy2f4xtgZ+uqGFT3wZK0oboBOmMnX4YcNUGqA3hYiDQhDaZg==
X-Received: by 2002:a19:2d1c:0:b0:52c:a5d6:2f27 with SMTP id 2adb3069b0e04-52ca6e9035emr6828300e87.50.1718703653227;
        Tue, 18 Jun 2024 02:40:53 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422f602f620sm182613095e9.19.2024.06.18.02.40.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jun 2024 02:40:52 -0700 (PDT)
Message-ID: <bb6036e2-613c-4d36-bcbc-3a407e3c727b@linaro.org>
Date: Tue, 18 Jun 2024 11:40:48 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/4] riscv: dts: add mmc controllers for Sophgo SG2042
 SoC
To: Chen Wang <unicornxw@gmail.com>, adrian.hunter@intel.com,
 aou@eecs.berkeley.edu, conor+dt@kernel.org, guoren@kernel.org,
 inochiama@outlook.com, jszhang@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, palmer@dabbelt.com,
 paul.walmsley@sifive.com, robh@kernel.org, ulf.hansson@linaro.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mmc@vger.kernel.org, linux-riscv@lists.infradead.org,
 chao.wei@sophgo.com, haijiao.liu@sophgo.com, xiaoguang.xing@sophgo.com,
 tingzhu.wang@sophgo.com
Cc: Chen Wang <unicorn_wang@outlook.com>
References: <cover.1718697954.git.unicorn_wang@outlook.com>
 <e2d3b19e06fa29116b8032addc70c8dc1ec3866e.1718697954.git.unicorn_wang@outlook.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <e2d3b19e06fa29116b8032addc70c8dc1ec3866e.1718697954.git.unicorn_wang@outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 18/06/2024 10:39, Chen Wang wrote:
> From: Chen Wang <unicorn_wang@outlook.com>
> 
> SG2042 has two MMC controller, one for emmc, another for sd-card.
> 
> Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
> ---
>  .../boot/dts/sophgo/sg2042-milkv-pioneer.dts  | 17 ++++++++++
>  arch/riscv/boot/dts/sophgo/sg2042.dtsi        | 32 +++++++++++++++++++
>  2 files changed, 49 insertions(+)
> 
> diff --git a/arch/riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts b/arch/riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts
> index 49b4b9c2c101..164db23586e0 100644
> --- a/arch/riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts
> +++ b/arch/riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts
> @@ -14,6 +14,23 @@ chosen {
>  	};
>  };
>  
> +&emmc {
> +	bus-width = <4>;
> +	no-sdio;
> +	no-sd;
> +	non-removable;
> +	wp-inverted;
> +	status = "okay";
> +};
> +
> +&sd {
> +	bus-width = <4>;
> +	no-sdio;
> +	no-mmc;
> +	wp-inverted;
> +	status = "okay";
> +};
> +
>  &uart0 {
>  	status = "okay";
>  };
> diff --git a/arch/riscv/boot/dts/sophgo/sg2042.dtsi b/arch/riscv/boot/dts/sophgo/sg2042.dtsi
> index 81fda312f988..bfdfd6f32912 100644
> --- a/arch/riscv/boot/dts/sophgo/sg2042.dtsi
> +++ b/arch/riscv/boot/dts/sophgo/sg2042.dtsi
> @@ -346,5 +346,37 @@ uart0: serial@7040000000 {
>  			resets = <&rstgen RST_UART0>;
>  			status = "disabled";
>  		};
> +
> +		emmc: mmc@704002a000 {
> +			compatible = "sophgo,sg2042-dwcmshc";
> +			reg = <0x70 0x4002A000 0x0 0x1000>;

Lowercase hex.

> +			interrupt-parent = <&intc>;
> +			interrupts = <134 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks =

Odd wrapping. Don't. See DTS coding style.

> +				<&clkgen GATE_CLK_AXI_EMMC>,
> +				<&clkgen GATE_CLK_100K_EMMC>,
> +				<&clkgen GATE_CLK_EMMC_100M>;
> +			clock-names =

Ditto

> +				"core",
> +				"timer",
> +				"card";
> +			status = "disabled";


Best regards,
Krzysztof

