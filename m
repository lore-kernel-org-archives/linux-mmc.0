Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B136E20C03E;
	Thu, 26 Jun 2025 03:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750910301; cv=none; b=S7iQG/12yzwAXU0QkUhs14D4YHFUpzswqnJNWM44/Vrhpbhk9T9jtDHqGqIEfkY/M+C5XfsLWGaZD06aUB3Ul3aIYuQecxZ+vapPosx8aHFP+QHIPenMSpG5VYC8eMzH7WjI1VA/VrdK+c/tLEZwHKEyxyOwSdJNRAVtX3aSVD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750910301; c=relaxed/simple;
	bh=i3cwc5DEp74Q7e/G9rtpoJI0teGt/fy+bPuNljlXaS8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=d+HFTVX7Etr6Ntfj4i1/834/076cEP5bRS6DvzLNDfkWnyTmqWnRQ3tv5h1370Mivw1Qs4AMEP31YQkrj4Olxu2EHpYEWqjzGPL7ApaU4WmGZQ636ozQRPdvps9W2Jfy+ZEvfGddDLzS78QiZ0Ed/RE0HIiTVROL74fWbEtAGvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=UxaGLZSS; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="UxaGLZSS"
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 55Q3w9P82042696;
	Wed, 25 Jun 2025 22:58:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1750910289;
	bh=3AP4dwXI1t7oeLyfh2CSNUlA5VPDAe2FDrqRdo7EbqI=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=UxaGLZSS7yOLjrrDFfN1zU1gvqZVioDDjrslDZnDoeXprRvtjnXfR3dqzwA1O0NJO
	 NhK3U7vOMbjrgIvbshyH3jcOkkSxcZRR92mst+70ToOV/u6TKc0lru9ypTzpP47XQe
	 O871KjPwy2jKEQ0mU3CohYAICEG9J8cFaemebT3U=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 55Q3w9QR3219249
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Wed, 25 Jun 2025 22:58:09 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 25
 Jun 2025 22:58:09 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Wed, 25 Jun 2025 22:58:08 -0500
Received: from [172.24.227.245] (uda0132425.dhcp.ti.com [172.24.227.245])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 55Q3w5VF590037;
	Wed, 25 Jun 2025 22:58:05 -0500
Message-ID: <5428ecbd-8154-43b1-a77c-9eda550c47e7@ti.com>
Date: Thu, 26 Jun 2025 09:28:05 +0530
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] arm64: dts: ti: k3-am62-main: Remove eMMC High Speed
 DDR support
To: Judith Mendez <jm@ti.com>, Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian
 Hunter <adrian.hunter@intel.com>
CC: Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>
References: <20250624221230.1952291-1-jm@ti.com>
 <20250624221230.1952291-3-jm@ti.com>
From: Vignesh Raghavendra <vigneshr@ti.com>
Content-Language: en-US
In-Reply-To: <20250624221230.1952291-3-jm@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea



On 25/06/25 03:42, Judith Mendez wrote:
> For eMMC, High Speed DDR mode is not supported [0], so remove
> mmc-ddr-1_8v flag which adds the capability.
> 

Needs a Fixes tag.

> [0] https://www.ti.com/lit/gpn/am625
> Signed-off-by: Judith Mendez <jm@ti.com>
> ---
>  arch/arm64/boot/dts/ti/k3-am62-main.dtsi | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
> index 9e0b6eee9ac7..120ba8f9dd0e 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
> @@ -553,7 +553,6 @@ sdhci0: mmc@fa10000 {
>  		clocks = <&k3_clks 57 5>, <&k3_clks 57 6>;
>  		clock-names = "clk_ahb", "clk_xin";
>  		bus-width = <8>;
> -		mmc-ddr-1_8v;
>  		mmc-hs200-1_8v;
>  		ti,clkbuf-sel = <0x7>;
>  		ti,otap-del-sel-legacy = <0x0>;

-- 
Regards
Vignesh
https://ti.com/opensource

