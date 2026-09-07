Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D13BD4E13EA;
	Mon,  7 Sep 2026 13:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788789510; cv=none; b=ekNlG7YLp56ZvnToNwfdkYAsHiXxvKvn3mM9cG72LBxpPWBph/8JRXloNemHOdhUiu35QnTtkEuPo3KjUcq3m8RoSI95XDds62OCY3sp71Q3YwJ+du/x9ca5O4+NGBFdLgQNfAsUrOFqV+HFkszKq9BbPVcsBy6DDn2NnCe/eko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788789510; c=relaxed/simple;
	bh=+C1CDyK8+eil0VmXqu9ynj6BAwyOsJ/ZwQyq/Z+ba5Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=TGSFmjmQUSoXwgofm7lYF1z0195jnf4ITvMZjU9LKyOqeeGaQnlTr+/akG6XyZZDlKDjtoFjVsBNaGppUORslJJWxDJbjQz7gsncs7mq5B4CZ84HkONv9DQeqj82txqY5GJ6+wGXY01Lqsc9CDkYdU+E7oFQNKwqJRbZTR4ilPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=GTjDvkxM; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="GTjDvkxM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1788789508; x=1820325508;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+C1CDyK8+eil0VmXqu9ynj6BAwyOsJ/ZwQyq/Z+ba5Y=;
  b=GTjDvkxMIdqfaLTIEI3QnKg3M2Hz6KWs3tRBVkr1FN7vWIC67Me8m1UT
   A8Ciz/T58Vhvb/i2CeQLni6qcqamaY52103kcBW9CMHJZZgaBwuQ3nhQ9
   sp0ncv7kotVaax46AlOTz0apUGEKLZJdbA85Vmfu5YIk1n/Jrv9IRWEd0
   jJVz636DOyekOCAzTQuDs2jVbq0Yf/sWppoh70o9duyAu8pQ/xOBmz/ET
   9x1uKhjKdH+U6uoNFe2M9AIQaW2taXDd1YQXVlqcC2DTGOgZ1gzkPSx2v
   pNFPUBihBaZh4X33bAv5NpOWp80hDldhWVeFN63Ka6M4TO19W1+1uVJvl
   A==;
X-CSE-ConnectionGUID: AHnXF5fBTmiIixkQbp6eiA==
X-CSE-MsgGUID: GmtJI3NCSAqck9Dy/IW4VA==
X-IronPort-AV: E=Sophos;i="6.25,267,1779174000"; 
   d="scan'208";a="230362313"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2026 06:58:27 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.87.71) by
 chn-vm-ex3.mchp-main.com (10.10.87.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.45; Mon, 7 Sep 2026 06:58:27 -0700
Received: from [10.159.227.160] (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Mon, 7 Sep 2026 06:58:24 -0700
Message-ID: <ccd8c141-96f8-47d1-99f9-ed684c569815@microchip.com>
Date: Mon, 7 Sep 2026 15:58:26 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/6] arm64: dts: microchip: lan969x: add SDMMC nodes
To: Robert Marko <robert.marko@sartura.hr>, <ulfh@kernel.org>,
	<robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>, <adrian.hunter@intel.com>, <ehristev@kernel.org>,
	<linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: <luka.perkov@sartura.hr>
References: <20260907132617.1198548-1-robert.marko@sartura.hr>
 <20260907132617.1198548-5-robert.marko@sartura.hr>
Content-Language: en-US, fr
From: Aubin Constans <aubin.constans@microchip.com>
In-Reply-To: <20260907132617.1198548-5-robert.marko@sartura.hr>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit

On 07/09/2026 15:25, Robert Marko wrote:
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

Reviewed-by: Aubin Constans <aubin.constans@microchip.com>

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
>                          status = "disabled";
>                  };
> 
> +               sdmmc0: mmc@e0830000 {
> +                       compatible = "microchip,lan9691-sdhci",
> +                                    "microchip,sam9x60-sdhci";
> +                       reg = <0xe0830000 0x00000300>;
> +                       interrupts = <GIC_SPI 64 IRQ_TYPE_LEVEL_HIGH>;
> +                       clocks = <&fabric_clk>, <&clks GCK_ID_SDMMC0>;
> +                       clock-names = "hclock", "multclk";
> +                       assigned-clocks = <&clks GCK_ID_SDMMC0>;
> +                       assigned-clock-rates = <100000000>;
> +                       status = "disabled";
> +               };
> +
>                  qspi2: spi@e0834000 {
>                          compatible = "microchip,lan9691-qspi";
>                          reg = <0xe0834000 0x00000100>,
> @@ -429,6 +441,18 @@ qspi2: spi@e0834000 {
>                          status = "disabled";
>                  };
> 
> +               sdmmc1: mmc@e0838000 {
> +                       compatible = "microchip,lan9691-sdhci",
> +                                    "microchip,sam9x60-sdhci";
> +                       reg = <0xe0838000 0x00000300>;
> +                       interrupts = <GIC_SPI 50 IRQ_TYPE_LEVEL_HIGH>;
> +                       clocks = <&fabric_clk>, <&clks GCK_ID_SDMMC1>;
> +                       clock-names = "hclock", "multclk";
> +                       assigned-clocks = <&clks GCK_ID_SDMMC1>;
> +                       assigned-clock-rates = <50000000>;
> +                       status = "disabled";
> +               };
> +
>                  reset: reset-controller@e201000c {
>                          compatible = "microchip,lan9691-switch-reset",
>                                       "microchip,lan966x-switch-reset";
> --
> 2.55.0

