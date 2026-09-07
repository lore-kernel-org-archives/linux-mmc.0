Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1275367F31;
	Mon,  7 Sep 2026 14:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788790727; cv=none; b=gBm4yFSOwORkMy6COpk/ZGE577PB8YzcOfkN8vLAZnT1fcYUXtpgFRGkvvb6S98yj7Zod5NcBD2LUVGjIOCrU3EdN2n31l2Joii0FRTgMcyssKTyMBJyIeHKupwbWm01X8NhZKt0ufXWzfHuofW4KSsEih77rncAjnB05ZXSBSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788790727; c=relaxed/simple;
	bh=+yTc0TN0axwr4N0poPrQVeuMRS9TLZb+RsMgDYZ0muc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=tQ+DVxYPjOqmM55+xefxVQoZOxxqmvjZNQ6MvLHDCyaeRlcb9iTyMN3IsfLc1rproLIO1GgzoAsPdHmncCWQfzXcq4IfRm9V1t95Pl6P33zcsxBHvKVg8ltsonNHpZC5itk8HXYsf/w6H4y3y4gvdoKn9elWkbhOeo4pMm9APNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=YmRJDj3l; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="YmRJDj3l"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1788790725; x=1820326725;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+yTc0TN0axwr4N0poPrQVeuMRS9TLZb+RsMgDYZ0muc=;
  b=YmRJDj3lsf+5WMW9XKjeDBaDJq4Q1cAylmCwGjmwL2wksd1xJQ90FIso
   qzxCRwkJAZAvu5ft3pQEQkSuKi4egMh6DB5rTtAdEUYk5UDX0R/twBhdv
   t3ojCJqjAXvkFtwBNggjpzICHzQcVT4kc4fdr2upbVbEy5gEOzhOfCaYD
   fq6CgNuPx7T7AS3l//zVmzFpZ6IaY1KY/mNcMAy2qiaxusTfuDn0DXTHH
   bPJDbbdQ6ht06SGQhZ8hFV8dwrw0WNucpfI7iyLu4jL6KqfwbFNbSAfKn
   OlPcyR6QcudzRXswhgg0Uzln6HyVc2UqLZSE4KjmKfbFk9aS4qx/yOvYl
   g==;
X-CSE-ConnectionGUID: dbz7uW7GS2CjyRTC8ExmBg==
X-CSE-MsgGUID: XaA/IM8TTbSM4Z+6hnZyaw==
X-IronPort-AV: E=Sophos;i="6.25,267,1779174000"; 
   d="scan'208";a="62340739"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2026 07:18:44 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.87.151) by
 chn-vm-ex4.mchp-main.com (10.10.87.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.45; Mon, 7 Sep 2026 07:18:44 -0700
Received: from [10.159.227.160] (10.10.85.11) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Mon, 7 Sep 2026 07:18:41 -0700
Message-ID: <e228ce18-3939-426b-8029-e53cafb1a8a1@microchip.com>
Date: Mon, 7 Sep 2026 16:18:42 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/6] arm64: dts: microchip: ev23x71a: enable eMMC
To: Robert Marko <robert.marko@sartura.hr>, <ulfh@kernel.org>,
	<robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>, <adrian.hunter@intel.com>, <ehristev@kernel.org>,
	<linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: <luka.perkov@sartura.hr>
References: <20260907132617.1198548-1-robert.marko@sartura.hr>
 <20260907132617.1198548-7-robert.marko@sartura.hr>
Content-Language: en-US, fr
From: Aubin Constans <aubin.constans@microchip.com>
In-Reply-To: <20260907132617.1198548-7-robert.marko@sartura.hr>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit

On 07/09/2026 15:25, Robert Marko wrote:
> Enable the non-removable eMMC connected to SDMMC0. Configure its 8-bit bus
> for 1.8 V DDR operation.

Adding the no-sd and no-sdio properties may be considered to speed
initialization up a bit.

> 
> Signed-off-by: Robert Marko <robert.marko@sartura.hr>

Reviewed-by: Aubin Constans <aubin.constans@microchip.com>

> ---
> Changes in v2:
> * Remove the unnecessary maximum-frequency property.
> * Expand the commit description.
> 
>   arch/arm64/boot/dts/microchip/lan9696-ev23x71a.dts | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/microchip/lan9696-ev23x71a.dts b/arch/arm64/boot/dts/microchip/lan9696-ev23x71a.dts
> index 985ca31e74e7..89a161b87d6f 100644
> --- a/arch/arm64/boot/dts/microchip/lan9696-ev23x71a.dts
> +++ b/arch/arm64/boot/dts/microchip/lan9696-ev23x71a.dts
> @@ -478,6 +478,16 @@ flash@0 {
>          };
>   };
> 
> +&sdmmc0 {
> +       pinctrl-0 = <&emmc_sd_pins>;
> +       pinctrl-names = "default";
> +       bus-width = <8>;
> +       mmc-ddr-1_8v;
> +       non-removable;
> +       disable-wp;
> +       status = "okay";
> +};
> +
>   &serdes {
>          status = "okay";
>   };
> --
> 2.55.0

