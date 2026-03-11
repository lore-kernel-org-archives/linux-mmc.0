Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6342A3EAC62
	for <linux-mmc@vger.kernel.org>; Wed, 11 Mar 2026 18:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773253672; cv=none; b=U1akt0IRQf1NV2HdIGaWfuf/gDJ1iA85I3oFt9PeylNQaBGfBGipa4ji9uGAxzEJzoe8eJA3R6vCxjP7JdhzhIDiLWG6nRFRUjUBuO9ntJtSQ+EjTXwRddNS8bKysB/KlMCTx0Vbh5L9tSzmcKHNZVvo4ZRNrwE9wt0NnjFcTvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773253672; c=relaxed/simple;
	bh=TjoT+QU7DQ256ZsGTZFZQrOx2kdA92zG7jdhyfIW6OQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Ci8UNmrvDt654eWzNUNsI4K4dhyLlh8Fl8dRjcq0Llc0tqjX2WyxOD+pU3E8vXUSAcmQr6SYr/SgUCJPsYZb3gy3LlKR9KbyDtUIHF4VGUM5sbGqjrWAp7R2DxGa0qGldzmnTgaY/v6kaCVgxc6zfRQkHbh85p6yoFA7G/VWohg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=xCMrDUe/; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="xCMrDUe/"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-509307e3854so10744011cf.1
        for <linux-mmc@vger.kernel.org>; Wed, 11 Mar 2026 11:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773253667; x=1773858467; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=C4T3EYxVrqjxWDRGqLWvtRoRBBjnZaG3jGkRoHcrE0E=;
        b=xCMrDUe/GlqKY2oy7N2xaj7BU8kOaKbUkpfvQRJ4hfViQ6idv8zms4HEAxM4CbcHkP
         z4hFP7ZAGov43fyKqvjw86Cq4zlJo/BPKYJQYE6o0wyJ2XRLi+SYV9I6qGVzQBPkQMXz
         9XOIVR37/4fIJIU95lRn3ePb5ldw9T7FbDg94MOl2kgVHBn3oHDgEpnkMcEVdG6rbv8V
         25s9j02RbwOeJ+4R/w/ZUG6a2kbEulIoOxqdhw2ODdpJ/FZrvJ/aZyfaXp/cPBYTXoAu
         +1SC9/URMxcD0X+Bvr5jGZbCHypQnS2V3R+nyYz/6D+yaBiuknGKL25/cIzKYpP8ErlN
         At8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773253667; x=1773858467;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C4T3EYxVrqjxWDRGqLWvtRoRBBjnZaG3jGkRoHcrE0E=;
        b=ImtzaFMuJaLQPCIbiKRoYJIz+Q+4n+fh7SCeUWZaNDjaeg7SCePEVTUPG96pbgvbJT
         AphpPDWZBV4J/QL9lnCuHV4/tbbT9cwWvcmI8ScxtTv3k75G+dtsmX83TtXObeSnu5sd
         URX9Y10u1iWw8itYZUMZQjyvmToZzwjTZwfv12KDHBygV5/f2mJnabO311jz5E1HLlCJ
         UzLTE12VIyvNLmTt6FaAiMn2Q3CE44qTry1bhykybl/fvjxyPtOOoVMqa6O4owNwqLnL
         Ruj5gqn8oltwvg5iXpd6NZTM5jo8n+pwDNf7qKrVrQzahuSiKtJnHPQgxfaNH1EkoI28
         MKuA==
X-Forwarded-Encrypted: i=1; AJvYcCVClt/zgIgH8OXapJSr7h9DzmYAuIPSSgi1tB+jvzrNgk0l/eGHgEnr13An1XgY8mDhlrwVTu8BY+I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGMjOE67kMOzuwvW9JW8Ssip6WQa72H/2mG1oRkybTj891kqgZ
	FsWiNezPZnHNCU+tElRZesm6JskBWYNaZcZMYY3MvxyMQzYrcXnuk/PuipcATS/5qYc=
X-Gm-Gg: ATEYQzxGglC+4k4fcADEjeXu+NALMka9VrRaLndb9n81SgK+CxLJEnilabUzkbd4O2f
	20lU1o2cSBiSZzERpF/pQ0Ig1OzdgcyBAbpHuFNO95r9L0Ay4u2fzVWZyIoAj21kGkQ4dN2ItIa
	y7JETkCFFDH5JM6vsfcwhJjRTCOL6Bhu77LH7h03GNXpKiIojdwxHNb46Z2XTooDvwI6P0p+39V
	SIu/cKP3g3FRjlpmscsBypxnXyhtof7n0PED/bo9VQ/qFSBqcE0snU7SSXjcvH4g33q28nIpSZP
	Q6dc5yeYV9wE6ga5VIKvJt0CGEKjDnl5pCJx3ME5auwCJA4o6W5+J0aJcfcLaI67CywNT874qpW
	l2apdNOp/NfqqdFv2ARjeqbcVsugehntfMzh71VTpbxjCSqkpIM3tYCKD1EUAes3CaIzhDMLEcn
	eOUyn5tcYZzLTreJPbZmCPrP71dTs6Po2lt2WcD/2DgElvp0VgzQrPCDqLES502WdWQwbPIS+mK
	IAd9UUJXKcxbEg=
X-Received: by 2002:ac8:7d91:0:b0:509:214a:e521 with SMTP id d75a77b69052e-509471aa41emr7984991cf.10.1773253667086;
        Wed, 11 Mar 2026 11:27:47 -0700 (PDT)
Received: from ?IPV6:2001:1970:3847:e000:4c82:63a9:39e9:5c17? ([2001:1970:3847:e000:4c82:63a9:39e9:5c17])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89a65beb4b3sm19327296d6.14.2026.03.11.11.27.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Mar 2026 11:27:46 -0700 (PDT)
Message-ID: <8e91c86d-ea41-4535-a7cd-5b602c546cb7@baylibre.com>
Date: Wed, 11 Mar 2026 14:27:42 -0400
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Trevor Gamblin <tgamblin@baylibre.com>
Subject: Re: [PATCH v2 6/7] riscv: dts: spacemit: k1-orangepi-rv2: add PMIC
 and power infrastructure
To: Iker Pedrosa <ikerpedrosam@gmail.com>,
 Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
 Yixun Lan <dlan@kernel.org>
Cc: Michael Opdenacker <michael.opdenacker@rootcommit.com>,
 Javier Martinez Canillas <javierm@redhat.com>, linux-mmc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
 spacemit@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20260309-orangepi-sd-card-uhs-v2-0-5bb2b574df5d@gmail.com>
 <20260309-orangepi-sd-card-uhs-v2-6-5bb2b574df5d@gmail.com>
Content-Language: en-US
In-Reply-To: <20260309-orangepi-sd-card-uhs-v2-6-5bb2b574df5d@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 2026-03-09 07:40, Iker Pedrosa wrote:
> Add Spacemit P1 PMIC configuration and board power infrastructure for
> voltage regulation support.
>
> - Add board power regulators (12V input, 4V rail)
> - Enable I2C8 for PMIC communication
> - Configure PMIC with buck4 (vmmc) and aldo1 (vqmmc) regulators
> - Set up regulator constraints for SD card operation
>
> Signed-off-by: Iker Pedrosa <ikerpedrosam@gmail.com>
> ---
>   arch/riscv/boot/dts/spacemit/k1-orangepi-rv2.dts | 48 ++++++++++++++++++++++++
>   1 file changed, 48 insertions(+)
>
> diff --git a/arch/riscv/boot/dts/spacemit/k1-orangepi-rv2.dts b/arch/riscv/boot/dts/spacemit/k1-orangepi-rv2.dts
> index 7b7331cb3c726f11d597f81917f3a3f5fc21e1b9..414b03f5e6480f05f5d7eeaaa0afb4e86425ae36 100644
> --- a/arch/riscv/boot/dts/spacemit/k1-orangepi-rv2.dts
> +++ b/arch/riscv/boot/dts/spacemit/k1-orangepi-rv2.dts
> @@ -19,6 +19,25 @@ aliases {
>   		ethernet1 = &eth1;
>   	};
>   
> +	reg_dc_in: dc-in-12v {
> +		compatible = "regulator-fixed";
> +		regulator-name = "dc_in_12v";
> +		regulator-min-microvolt = <12000000>;
> +		regulator-max-microvolt = <12000000>;
> +		regulator-boot-on;
> +		regulator-always-on;
> +	};
> +
Is this the correct voltage? I don't see a 12V rail in the RV2's 
datasheet, and the board's specifications only indicate a 5V USB-C input.
> +	reg_vcc_4v: vcc-4v {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc_4v";
> +		regulator-min-microvolt = <4000000>;
> +		regulator-max-microvolt = <4000000>;
> +		regulator-boot-on;
> +		regulator-always-on;
> +		vin-supply = <&reg_dc_in>;
> +	};
> +
>   	chosen {
>   		stdout-path = "serial0";
>   	};
> @@ -92,3 +111,32 @@ &uart0 {
>   	pinctrl-0 = <&uart0_2_cfg>;
>   	status = "okay";
>   };
> +
> +&i2c8 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c8_cfg>;
> +	status = "okay";
> +
> +	pmic@41 {
> +		compatible = "spacemit,p1";
> +		reg = <0x41>;
> +		interrupts = <64>;
> +		vin-supply = <&reg_vcc_4v>;
> +
> +		regulators {
> +			sd_vmmc: buck4 {
> +				regulator-min-microvolt = <500000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-ramp-delay = <5000>;
> +				regulator-always-on;
> +			};
> +
> +			sd_vqmmc: aldo1 {
> +				regulator-min-microvolt = <500000>;
> +				regulator-max-microvolt = <3400000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +		};
> +	};
> +};
>

