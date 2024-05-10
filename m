Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57EEF446BD;
	Fri, 10 May 2024 16:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715357596; cv=none; b=N535h7IcACBY/aasjQVbxYrQXN4uDrli8YHSNaUcwdnnTrjpPfNoYMGpVyDX3giUx8lmmZvmFWoJJqzWaGR43KE3785OhbKFwjNuamAbbNZnz5N8Ztjn/lyN9nnXBWRNEAbpg0zqVueXUbGWL9OL9a65AZkCM8FjgmpiW2tx2tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715357596; c=relaxed/simple;
	bh=yXGrs/eTjT4agxaYblkMzIWYx2DuBXJA2AYYKw7Nb2w=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=JT6G9pBWy45JdHF79lNHH83Ss7c6AbCm0YVsCgvQLI+/M3NmCOCzApNTclvgOwnHUJjYXfdv8k6ACRPkMepzSyUvgti1Wqd1t7HtfbNBuQbuy/hbLVZvNHTvThdyANNV0hDjyUsMjxa7jIM06sIiZXrcB37Pora9h7iByP07xVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qN84oVx6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qN84oVx6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23DF8C113CC;
	Fri, 10 May 2024 16:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715357596;
	bh=yXGrs/eTjT4agxaYblkMzIWYx2DuBXJA2AYYKw7Nb2w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qN84oVx6B94xCmFMUzOl4TqBCSsVnZwJWehYaf6faaRPOj5bLGuxebqXT5oq2R6Zk
	 Xv9gNiKlkxGtiBod3Kezx5R4mwVwjH+86ODKuZJiptVpfdcydHFFkhq7WOoJ83SIlj
	 BG9K/qus3XyPxLNj8B/FWHvVeXWKExFBrsPfzh0RTFcy/1HTIYgqeqqCYMnN8BZQQ/
	 3uLFGoF3PKHeGCe2oRy6MGnfhmJIvasHeBZLxOTe+D2f8DzuRJ/lUIp7SVZI2PytJ9
	 JYjtFxPk9C2fH+S4nBbzp8QW6OPZ8nz3/+VP7qOsEQzeCZBjECZUsvfEHZh/j0uT8o
	 2M+k0oJvnrczg==
Received: from disco-boy.misterjones.org ([217.182.43.188] helo=www.loen.fr)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1s5Srx-00CG3e-NP;
	Fri, 10 May 2024 17:13:13 +0100
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 10 May 2024 17:13:13 +0100
From: Marc Zyngier <maz@kernel.org>
To: Andrea della Porta <andrea.porta@suse.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Florian Fainelli <florian.fainelli@broadcom.com>, Ray Jui
 <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, Broadcom
 internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Ulf
 Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Kamal Dasu <kamal.dasu@broadcom.com>, Al Cooper <alcooperx@gmail.com>, Eric
 Anholt <eric@anholt.net>, Stefan Wahren <wahrenst@gmx.net>,
 devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mmc@vger.kernel.org
Subject: Re: [PATCH v2 4/4] arm64: dts: broadcom: Add support for BCM2712
In-Reply-To: <59a3015c3a6f2f0b70a38c030274a163773e7757.1715332922.git.andrea.porta@suse.com>
References: <cover.1715332922.git.andrea.porta@suse.com>
 <59a3015c3a6f2f0b70a38c030274a163773e7757.1715332922.git.andrea.porta@suse.com>
User-Agent: Roundcube Webmail/1.4.15
Message-ID: <12363be5b11c752b7155cc0c416fdfd2@kernel.org>
X-Sender: maz@kernel.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 217.182.43.188
X-SA-Exim-Rcpt-To: andrea.porta@suse.com, robh@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, florian.fainelli@broadcom.com, rjui@broadcom.com, sbranden@broadcom.com, bcm-kernel-feedback-list@broadcom.com, ulf.hansson@linaro.org, adrian.hunter@intel.com, kamal.dasu@broadcom.com, alcooperx@gmail.com, eric@anholt.net, wahrenst@gmx.net, devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

On 2024-05-10 15:35, Andrea della Porta wrote:
> The BCM2712 SoC family can be found on Raspberry Pi 5.
> Add minimal SoC and board (Rpi5 specific) dts file to be able to
> boot from SD card and use console on debug UART.
> 
> Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
> ---
>  arch/arm64/boot/dts/broadcom/Makefile         |   1 +
>  .../boot/dts/broadcom/bcm2712-rpi-5-b.dts     |  62 ++++
>  arch/arm64/boot/dts/broadcom/bcm2712.dtsi     | 302 ++++++++++++++++++
>  3 files changed, 365 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dts
>  create mode 100644 arch/arm64/boot/dts/broadcom/bcm2712.dtsi
> 

[...]

> +	psci {
> +		method = "smc";
> +		compatible = "arm,psci-1.0", "arm,psci-0.2", "arm,psci";
> +		cpu_on = <0xc4000003>;
> +		cpu_suspend = <0xc4000001>;
> +		cpu_off = <0x84000002>;

Please drop the PSCI function numbers. From PSCI-0.2, these are 
standard,
and what is implemented is discoverable.

> +	};
> +

[...]

> +	timer {
> +		compatible = "arm,armv8-timer";
> +		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) |
> +					  IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(4) |
> +					  IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(4) |
> +					  IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(4) |
> +					  IRQ_TYPE_LEVEL_LOW)>;

This is missing the EL2 virtual timer interrupt, as this is a 
VHE-capable
system.


> +		/* This only applies to the ARMv7 stub */
> +		arm,cpu-registers-not-fw-configured;

Please drop this. It makes no sense on a modern platform.

> +	};
> +};

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
