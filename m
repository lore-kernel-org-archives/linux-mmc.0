Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 436AB2DCBE0
	for <linux-mmc@vger.kernel.org>; Wed,  3 Dec 2025 21:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764798454; cv=none; b=mOH01zz5Larxk49gVz1AwhUlFHgEdPCpHVVFZD6X9hJKvZJLvsyO2lDbzi583emSctAkj31cKlmFLApmzlALDsEGrOav5CXYwDspnMu2kMHYpJttRPIiEsN7CH7DS7sTNHyPRsPsGDJXTl8xW0hlifYPiHTihL/CMMyr8r952C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764798454; c=relaxed/simple;
	bh=VZVdZ44lA0brLQX2RzHeYexOKxCAhiFjKkt9kwiarbM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=udEv5xtBgCNVaH864l+SeZMAMIl5p5zYAZUtwNgtCwbNaxrqlEtOkJ+j8FCE/1mYIPVg+/h3uOd1CAjQCvnF4dg57LgJP1hBL4gU6aOuSMt6mQbojy1ssDyyUS1g6xAf1AAO1kdxngg0X8+Y5TA9ovTeg3JrY6aLxzhu85cIlJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=O2Z8ZpuV; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="O2Z8ZpuV"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7e2762ad850so57466b3a.3
        for <linux-mmc@vger.kernel.org>; Wed, 03 Dec 2025 13:47:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1764798451; x=1765403251; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+qKeGTsD/DT+TUGUNxy2VzIns/N4h+6YktbT6beUiGo=;
        b=O2Z8ZpuV8ycxjwkA+pLMJWenMdQAb+JyRRa6UxvQmtSp6ROtIaJ6plkjItzBou7rjJ
         MN/Z/vt63WKG6WLo8sXOssSFEn6LOtzH8LAj4mD0dMTG1CBvpwhBRgq7KlIlSdvxbS61
         CIyzdJRXWPjHAbknQsTe4JAFiPvS3+EBYP9Io=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764798451; x=1765403251;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+qKeGTsD/DT+TUGUNxy2VzIns/N4h+6YktbT6beUiGo=;
        b=vH+h9EEyAjmN78o5F3SPt1P5qm0ClbeAefldHqOLSYKNUmMJPT4JdQv8cScmmt1u5M
         56tV2IT+3UjsS6aWXYZdRhTBL0XD9QcsDGkf+AjoL82yQ/J8Y69wrpaCr8a19jR+AFc2
         4HKVANsk7MCNljQuBLsyBZOSH6+IoTXlBiuUIyiJujwnzeCxkaMBbJJ+GkFOYLCwLBg4
         LTW+sEO1RF3tUgif2mEWaX+4599y11rPZH2W5qIn1TwSrywKqNag/d295coyrRKO21nq
         pUKoqBHhH5CKVtEfo76Be6E/ADGLrFVEo2CCyPSMWm19QbIorAwj4lliqfAKlZrNu1jD
         BVuA==
X-Forwarded-Encrypted: i=1; AJvYcCUCE4iiNRWOBkn9eT/d/kdwb6XXLB7TIiIRGhKWTpql7UMTuXuNvIEoQai+X0r3MbDafcCXjXTidrg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcL0VWE1GL1AYgOVNOWmXgveWUFR5qGqjBVfk0Knej1wsYoFPM
	PXWZIiE+MGtArzTTupi7blbS5WWxJQyPlNKslBCg9amq0mtsXf26ViJb3gylIaKnfQ==
X-Gm-Gg: ASbGnctVRoubRmoPJPrOf2egZRsGGSaZlP/+uPeGCXsuXDeuReRMADjPmPWvuP8mlOB
	Q3c1UeYxJfGXQzSicxrzeEzoh2H6ui34pzL5YA7pGQfFWIqbSBkPcNOhO4VEhHeUznukAt5/zu5
	eaMHs24ew/YmOKnqJ3ABv/naCXbwy5nKoMoc+mzognARcPWvE5jlj6tLPfrR2S9dcN0csUxt3Kq
	uAwHsG+6tpIplt+YaHEtSnnMidxWg+ecMrpJm13TF5dSok+7+03KsVOtJIpHaDNYG/YYlSIocrP
	/D+DhjTVLy3/6DFnU13Kx9bgwLPmJfqicfi/ZCCbyXcAwxNFTQFVAWDYaNsLeWAsgp/0QPGpwiX
	a0/5TgR2vMb/3ILJvCAVokX743h+d94nDyCDAuO/Ty4Rh4F+zwCVzHrdWLUmnBCNuHCv6pNsqmW
	9MHUev1Jx107B4mrihds/YG3XPyRb+8Jlh3Itrlkgv4J8icyDJew==
X-Google-Smtp-Source: AGHT+IHYOL+UBYAVNBaexNp51zLW4j5ZRWtvPK/36fgfBgTEcmZyfDLkwf8DPOCYg9Guqcci0ODQoA==
X-Received: by 2002:a05:7022:63aa:b0:11d:f464:38b3 with SMTP id a92af1059eb24-11df4643926mr1543335c88.2.1764798449474;
        Wed, 03 Dec 2025 13:47:29 -0800 (PST)
Received: from localhost ([2a00:79e0:2e7c:8:e953:f750:77d0:7f01])
        by smtp.gmail.com with UTF8SMTPSA id a92af1059eb24-11dcb04a07bsm88741033c88.7.2025.12.03.13.47.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Dec 2025 13:47:28 -0800 (PST)
Date: Wed, 3 Dec 2025 13:47:27 -0800
From: Brian Norris <briannorris@chromium.org>
To: Karel Balej <balejk@matfyz.cz>
Cc: Johannes Berg <johannes@sipsolutions.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Duje =?utf-8?Q?Mihanovi=C4=87?= <duje@dujemihanovic.xyz>,
	Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@bootlin.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Francesco Dolcini <francesco@dolcini.it>,
	Ulf Hansson <ulf.hansson@linaro.org>, Frank Li <Frank.Li@nxp.com>,
	linux-wireless@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mmc@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
	phone-devel@vger.kernel.org, Jeff Chen <jeff.chen_1@nxp.com>,
	Peng Fan <peng.fan@nxp.com>
Subject: Re: [DONOTAPPLY RFC PATCH v2 4/4] arm64: dts:
 samsung,coreprimevelte: add wifi node
Message-ID: <aTCv75hjdX5XvgCh@google.com>
References: <20251026182602.26464-1-balejk@matfyz.cz>
 <20251026182602.26464-5-balejk@matfyz.cz>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251026182602.26464-5-balejk@matfyz.cz>

On Sun, Oct 26, 2025 at 07:20:41PM +0100, Karel Balej wrote:
> Add a node for the phone's WiFi serviced by the Marvell SD8777 chip a
> communication with which happens over the SDIO. Also enable a regulator
> without which it is not possible to connect to networks although they
> are discovered properly.
> 
> Signed-off-by: Karel Balej <balejk@matfyz.cz>
> ---
>  .../mmp/pxa1908-samsung-coreprimevelte.dts        | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/marvell/mmp/pxa1908-samsung-coreprimevelte.dts b/arch/arm64/boot/dts/marvell/mmp/pxa1908-samsung-coreprimevelte.dts
> index b2ce5edd9c6a..36d6ae4e902e 100644
> --- a/arch/arm64/boot/dts/marvell/mmp/pxa1908-samsung-coreprimevelte.dts
> +++ b/arch/arm64/boot/dts/marvell/mmp/pxa1908-samsung-coreprimevelte.dts
> @@ -475,6 +475,14 @@ ldo14: ldo14 {
>  				regulator-min-microvolt = <1200000>;
>  				regulator-max-microvolt = <3300000>;
>  			};
> +
> +			/*
> +			 * Needs to be enabled in order for the WiFi to be able
> +			 * to connect to networks.
> +			 */
> +			ldo15 {
> +				regulator-always-on;

Do we have a min/max voltage for this regulator?

> +			};
>  		};
>  	};
>  };
> @@ -523,6 +531,13 @@ &sdh1 {
>  	pinctrl-1 = <&sdh1_fast_pins_0 &sdh1_fast_pins_1 &sdh1_pins_2>;
>  	bus-width = <4>;
>  	non-removable;
> +	#address-cells = <1>;
> +	#size-cells = <0>;

I wonder if this should have:

	vmmc-supply = <&ldo16>;

rather than regulator-always-on above.

Brian

> +
> +	wifi@1 {
> +		compatible = "marvell,sd8777";
> +		reg = <1>;
> +	};
>  };
>  
>  &pwm3 {
> -- 
> 2.51.1
> 
