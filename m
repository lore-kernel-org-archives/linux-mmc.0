Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D30DC1531C8;
	Tue, 25 Aug 2026 17:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787678086; cv=none; b=QM9/dk6u6t4alk8nJfLyfdclCfDKtlCaZ5FcFxbS4rKRVPB/Wq0P+VLk6s7aIgS66GyMTGbxsWPj6OObPYkuNgEKt226jutWlAaM/OyDRawJQetLNrgHDv49XgsIRbeOJb2qlaJ9WdL++bUxZLGWOFPLCWOMJFA4QsVU/aCSWgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787678086; c=relaxed/simple;
	bh=lgQBRPrl/nvc5f3CC0Mq/mPd8cl7M4MjjXACHNFSUxo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=rw97NESH36zgJOre2MJRzSSp79/YoIFtz4wlsdCHgFPMtxEmRQKs83LQlLcsMC1Qr+iO5WkgZg0gfuLtU+MP2dhhed60P1JadR6GxCHAJL2oyNv5r/AdiMEH1uS4xiEdo+Do/8aCvPrdcC37LIc6FvSvPP9IC7VfVnOqF/musnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=1RTb0kI9; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="1RTb0kI9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1787678084; x=1819214084;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=lgQBRPrl/nvc5f3CC0Mq/mPd8cl7M4MjjXACHNFSUxo=;
  b=1RTb0kI9HVKKdwLmtx2YpwOrM60VvZtv1aE2Y0jMYsTuFg6QE/EUW45u
   YlP/Fiqso/mPyinM7rDAYoPHNUE0g4rV505De3rQd/xeuXWMFU5inbNKN
   LXlID4PPvNrSaE2a9QSxdCp7Wr3U16KksmtncGNcps+E/RScOqGkllJpV
   kBizIqIfdkmzL71qc/+3PyZNndYh/j0zFMxayhY/jw+rAUro+X+KXK2ho
   yGlU95UBlW1cQXuXJhiy5Mv9nKNffMFhaEkpBkUBzMuW1BFD46AH0eikI
   BVwMmNZeaQPzlidtwnoCjK7vAbJtHE3G+ZJ75I921b+QE6ruprOMDibUl
   A==;
X-CSE-ConnectionGUID: Fm4WJO+JQtCEf0ZpwAwKqA==
X-CSE-MsgGUID: 4+gyDQLjQUepiV5YM5XrCA==
X-IronPort-AV: E=Sophos;i="6.25,243,1779174000"; 
   d="scan'208";a="61743666"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Aug 2026 10:14:43 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Tue, 25 Aug 2026 10:14:43 -0700
Received: from [10.159.227.160] (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Tue, 25 Aug 2026 10:14:41 -0700
Message-ID: <0cc2d875-7aab-4091-816c-031f21f3cbac@microchip.com>
Date: Tue, 25 Aug 2026 19:14:43 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] arm64: dts: microchip: lan969x: add SDMMC nodes
To: Robert Marko <robert.marko@sartura.hr>, <ulfh@kernel.org>,
	<robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>, <linux-mmc@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: <luka.perkov@sartura.hr>
References: <20260824110432.1074136-1-robert.marko@sartura.hr>
 <20260824110432.1074136-2-robert.marko@sartura.hr>
Content-Language: en-US, fr
From: Aubin Constans <aubin.constans@microchip.com>
In-Reply-To: <20260824110432.1074136-2-robert.marko@sartura.hr>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit

On 24/08/2026 12:56, Robert Marko wrote:
> Add nodes for both SDMMC controllers.
> 
> Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> ---
>   arch/arm64/boot/dts/microchip/lan9691.dtsi | 24 ++++++++++++++++++++++
>   1 file changed, 24 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/microchip/lan9691.dtsi b/arch/arm64/boot/dts/microchip/lan9691.dtsi
> index a8541c6a098d..2d943ea75768 100644
> --- a/arch/arm64/boot/dts/microchip/lan9691.dtsi
> +++ b/arch/arm64/boot/dts/microchip/lan9691.dtsi
> @@ -414,6 +414,30 @@ qspi0: spi@e0804000 {
>                          status = "disabled";
>                  };
> 
> +               sdmmc0: mmc@e0830000 {
> +                       compatible = "microchip,lan9691-sdhci",
> +                                    "microchip,sam9x60-sdhci";
> +                       reg = <0xe0830000 0x00000300>;
> +                       interrupts = <GIC_SPI 64 IRQ_TYPE_LEVEL_HIGH>;
> +                       clocks = <&clks GCK_ID_SDMMC0>, <&clks GCK_ID_SDMMC0>;
> +                       clock-names = "hclock", "multclk";
> +                       assigned-clocks = <&clks GCK_ID_SDMMC0>;
> +                       assigned-clock-rates = <100000000>;

If always targeting an e.MMC, capped at the High Speed DDR mode, one might consider
a multiple of 52 MHz here.

> +                       status = "disabled";
> +               };
> +
> +               sdmmc1: mmc@e0838000 {
> +                       compatible = "microchip,lan9691-sdhci",
> +                                    "microchip,sam9x60-sdhci";
> +                       reg = <0xe0838000 0x00000300>;
> +                       interrupts = <GIC_SPI 50 IRQ_TYPE_LEVEL_HIGH>;
> +                       clocks = <&clks GCK_ID_SDMMC1>, <&clks GCK_ID_SDMMC1>;
> +                       clock-names = "hclock", "multclk";
> +                       assigned-clocks = <&clks GCK_ID_SDMMC1>;
> +                       assigned-clock-rates = <45000000>;
> +                       status = "disabled";
> +               };
> +
>                  qspi2: spi@e0834000 {
>                          compatible = "microchip,lan9691-qspi";
>                          reg = <0xe0834000 0x00000100>,
> --
> 2.55.0
> 

