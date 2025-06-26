Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC7543159;
	Thu, 26 Jun 2025 03:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750910229; cv=none; b=YQeP6scYDBCXvbhYptboUI49CSvWCI8swPIDrrbfa4jKy/Um1TOgkW2USawnrEfZKZ5d5D7yVp5lMku/mcDyHLJFNrVPE7ZCZed47NsbBU2K6dNzkJ2DF97/hrbN646DvgBTjWN19FhAR3fHDjZEPiGvjV2wNzSAauUD6tuYlBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750910229; c=relaxed/simple;
	bh=mI97DoNHfliJSkCCHYtjbCbgIWRPVfu2RIWFNqdlMCo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=u51QYgTgtzZbe7jUASe0bVGicSYFF1vdn+JuaMNqTc6PcJNkX6sMQu7Mvfj4XfNcJ48FYf1NaKLOiKecx1lg7yMlqlZlyxkMDChmMDg//Tealt5XvWx5CqxrIFN2PjOgWSFNHT/H4UIv/ygR1J1sPMOrKTpZrRPLamp3/9S42Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=yYB9fGhR; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="yYB9fGhR"
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 55Q3uuYx2300854;
	Wed, 25 Jun 2025 22:56:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1750910216;
	bh=vBKAcBpn6IE4UyuR5btcSfdmtxt26FB5KnEyD1oJXTM=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=yYB9fGhRRjMCBTrb+Ke6q6aksP5H9IGdnGqK6J4lZfLvFTbMaKrN0hK/YDHwZMcfn
	 jkLG5y1ff+6GF/RtokvY2hnglLeMysa2n7LyoArxLqg1FDKJ1Dn5WG0j94eiDiBvVF
	 yfHhP4VCVBMGe1861JrFpTA8u0z6wkAum+YiuwMA=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 55Q3uupd3271443
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Wed, 25 Jun 2025 22:56:56 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 25
 Jun 2025 22:56:56 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Wed, 25 Jun 2025 22:56:56 -0500
Received: from [172.24.227.245] (uda0132425.dhcp.ti.com [172.24.227.245])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 55Q3upeZ588826;
	Wed, 25 Jun 2025 22:56:52 -0500
Message-ID: <0bf7ccf4-26ae-42f6-b679-d7840e42efc5@ti.com>
Date: Thu, 26 Jun 2025 09:26:52 +0530
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] Workaround for Errata i2312
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
From: Vignesh Raghavendra <vigneshr@ti.com>
Content-Language: en-US
In-Reply-To: <20250624221230.1952291-1-jm@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea



On 25/06/25 03:42, Judith Mendez wrote:
> This patch series includes fix for Errata i2312 [0].
> 
> Also include fixes for removing eMMC HS DDR support for am62
> SK which has been descoped as per datasheet [1] and enabling internal
> pullups for AM62 SK and AM62SIP SK, as per JESD84 spec recommendations.
> 
> [0] https://www.ti.com/lit/pdf/sprz487
> [1] https://www.ti.com/lit/gpn/am625
> 
> Judith Mendez (3):
>   mmc: sdhci_am654: Workaround for Errata i2312
>   arm64: dts: ti: k3-am62-main: Remove eMMC High Speed DDR support
>   arm64: dts: ti: k3-am62*: Move eMMC pinmux to top level board file
> 

2/3 and 3/3 have no relation to 1/3 and they need to go via different
trees. Please post them separately.

>  arch/arm64/boot/dts/ti/k3-am62-lp-sk.dts      | 25 +++++++++++++++++++
>  arch/arm64/boot/dts/ti/k3-am62-main.dtsi      |  1 -
>  arch/arm64/boot/dts/ti/k3-am625-sk.dts        | 25 +++++++++++++++++++
>  .../arm64/boot/dts/ti/k3-am62x-sk-common.dtsi | 24 ------------------
>  drivers/mmc/host/sdhci_am654.c                |  9 ++++---
>  5 files changed, 56 insertions(+), 28 deletions(-)
> 

-- 
Regards
Vignesh
https://ti.com/opensource

