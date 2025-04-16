Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F26F81DC04A;
	Wed, 16 Apr 2025 16:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744822775; cv=none; b=Oh3F2csvBOVgbb8p3sHwQygt7NvZI2q922Jfy9o7dk6YWGQ2dHzT4r3NgVO7uTNROs40c/QzsJt0H22HPM5lrqw2awqQk/meMORIzMKS9AHSaEhx8Qzpgk46sbatjabAWDuZMh3fmv/RAqLUTVoIrRAVfocScHzQ8kSFfOk/3+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744822775; c=relaxed/simple;
	bh=GqYHw0v/gtP59M6Lf3YVXV6rLfdQbRV82DntEGZnLQM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=OSh6F00sPLhzZcdjUsJU++/wkn1ZBgKondp4IN28PHGnzfIZwoGIUbQOpES3+9ml3UPntWQ6NXAstBJg64F1j1pOt+TIk0f0rxpjIv3SN3EPpB3FartKckzf6M6ggxb3T78vUwz6Zk60IBg7VEcn77v6cRITeUdM9UBaQIuVGhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=sYx0ANO4; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="sYx0ANO4"
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53GGxGlt406925
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Apr 2025 11:59:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1744822757;
	bh=LBDgSFCK3SAhha4nzURy7p7QwmnfoixA9SlLrNVbvS0=;
	h=Date:Subject:From:To:CC:References:In-Reply-To;
	b=sYx0ANO4aIsQhL9y4OdgJM9Foaq1DmeMHvdSGp8Pvpb8NhfmzwHvjuuFdxRXUgZV9
	 rdH6il6NOaLYoosMlKsR/U3YV41bhRYzBg/Qy5d8zJmCSnQ+Z3FpUMJzgdOlXzG6b8
	 thc2Pjq3wstyEqH8UoZYKyNwMmhKS8v8dxPl9FqI=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53GGxGQW122656
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 16 Apr 2025 11:59:16 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 16
 Apr 2025 11:59:16 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 16 Apr 2025 11:59:16 -0500
Received: from [128.247.81.105] (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53GGxGPu105224;
	Wed, 16 Apr 2025 11:59:16 -0500
Message-ID: <3f31eded-4a7b-43f0-819f-a3be48cffc7b@ti.com>
Date: Wed, 16 Apr 2025 11:59:16 -0500
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Fix V1P8_SIGNAL_ENA and HIGH_SPEED_ENA
From: Judith Mendez <jm@ti.com>
To: Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson
	<ulf.hansson@linaro.org>
CC: <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Josua Mayer
	<josua@solid-run.com>, Moteen Shah <m-shah@ti.com>,
        Hiago De Franco
	<hiago.franco@toradex.com>
References: <20250407222702.2199047-1-jm@ti.com>
Content-Language: en-US
In-Reply-To: <20250407222702.2199047-1-jm@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hello Adrian,

On 4/7/25 5:27 PM, Judith Mendez wrote:
> For all TI devices, timing was closed For Legacy and HS modes in
> half cycle timing, where data is launched on the negative edge of
> clock and latched on the following positive edge of clock. The
> switch to full cycle timing happens when any of HIGH_SPEED_ENA,
> V1P8_SIGNAL_ENA, or UHS_MODE_SELECT is set.
> 
> Currently HIGH_SPEED_ENA is set for HS modes and violates timing
> requirements for TI devices so add a .set_hs_ena callback in
> sdhci_am654 driver so that HIGH_SPEED_ENA is not set for this mode.
> 
> There are eMMC boot failures seen with V1P8_SIGNAL_ENA with a
> specific Kingston eMMC due to the sequencing when enumerating to
> HS200 mode. Since V1P8_SIGNAL_ENA is optional for eMMC, do not
> set V1P8_SIGNAL_ENA be default. This fix was previously merged in
> the kernel, but was reverted due to the "heuristics for enabling
> the quirk"[0]. The new implementation applies the quirk based-off of
> bus width, which should not be an issue since there is no internal
> LDO for MMC0 8bit wide interface and hence V1P8_SIGNAL_ENA should only
> effect timing for MMC0 interface.


On this patch series, I am bringing back the fix for V1P8_SIGNAL_ENA,
Ulf requested a change [0] which I am planning to do for v2. But I was
hoping to get your opinion on whether Hiago's suggestion [1] is doable
so I can add that as well to v2. Thanks for your attention.


[0] 
https://lore.kernel.org/linux-mmc/CAPDyKFqx-G4NynanFWrspz7-uXXF74RfjcU-Sw2nq2JhL3LPuQ@mail.gmail.com/
[1] 
https://lore.kernel.org/linux-mmc/20250412132012.xpjywokcpztb4jg4@hiago-nb/

~ Judith
