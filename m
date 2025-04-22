Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D38E244677;
	Tue, 22 Apr 2025 21:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745355821; cv=none; b=dwDvfNv+eglGj+FKVQsfFtpLBGpVEkInIRaTTsGVCGzOzdh454ehfy1353OIUnfPK4I3bykLxcOmZD7tyGDesQ5uzsdVEiJXqKW9fSP0yo4Jn9dbjPZ/eneVR8kKuz/A3/SlLyznKReVjEHA3N1u9nYmZgjWKsLg8ONPetCUshw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745355821; c=relaxed/simple;
	bh=aLAZefkdS1Yqhu3HlvfIlraeV4CC8+Sc3yfKnjjUre8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=NVTrtSjSgWJsWRfl1QWxzZ8ghbuNvRTYWnJwfNv+nxtrvFoEOZlEB+S+fmCqiTwq6xDWbsDZm5mTvz9oCurANmikt24CrrpDyCrsm/67Wh6tOm8D5PcLAz2/0cSGj1hKfsepaaa1ot4LtkMqrlAT3JL6krcl5hIbgyZxkeklUxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=dlb0u8Az; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="dlb0u8Az"
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53ML3PC42106738
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Apr 2025 16:03:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1745355805;
	bh=ZKS0/gN4dBFreWXVuJOftMxAtj1ZsfyEUQwImitbTEw=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=dlb0u8AzqAanDz5qn48rBJUOsXVrOrgjgQQ94APP52zCIRIP+tfCaAYtbfY08zrEz
	 y2c4mwoUtstOgGuKDAQI32WetlAiB3gQiUnJx/q0CafAnvbz05KFYRaav5wqSV15wE
	 mStvJ81TPu36jCYrnKAA8NmFBDj4plo3bZqH90/k=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53ML3PXX075601
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 22 Apr 2025 16:03:25 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 22
 Apr 2025 16:03:25 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 22 Apr 2025 16:03:25 -0500
Received: from [128.247.81.105] (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53ML3Ox6073564;
	Tue, 22 Apr 2025 16:03:24 -0500
Message-ID: <d271122d-fabb-482f-b5ac-35af56de32f8@ti.com>
Date: Tue, 22 Apr 2025 16:03:24 -0500
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] Add ti,suppress-v1p8-ena
To: Ulf Hansson <ulf.hansson@linaro.org>, Nishanth Menon <nm@ti.com>,
        Adrian
 Hunter <adrian.hunter@intel.com>
CC: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>,
        Josua Mayer <josua@solid-run.com>, <linux-mmc@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Francesco Dolcini <francesco@dolcini.it>,
        Hiago De Franco
	<hialgofranco@gmail.com>
References: <20250422204413.272679-1-jm@ti.com>
Content-Language: en-US
From: Judith Mendez <jm@ti.com>
In-Reply-To: <20250422204413.272679-1-jm@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi all,

On 4/22/25 3:44 PM, Judith Mendez wrote:
> There are MMC boot failures seen with V1P8_SIGNAL_ENA on Kingston eMMC
> and Microcenter/Patriot SD cards on Sitara K3 boards due to the HS200
> initialization sequence involving V1P8_SIGNAL_ENA. Since V1P8_SIGNAL_ENA
> is optional for eMMC, do not set V1P8_SIGNAL_ENA by default for eMMC.
> For SD cards we shall parse DT for ti,suppress-v1p8-ena property to
> determine whether to suppress V1P8_SIGNAL_ENA. Add new ti,suppress-v1p8-ena
> to am62x, am62ax, and am62px SoC dtsi files since there is no internal LDO
> tied to sdhci1 interface so V1P8_SIGNAL_ENA only affects timing.
> 
> This fix was previously merged in the kernel, but was reverted due
> to the "heuristics for enabling the quirk"[0]. This issue is adressed
> in this patch series by adding optional ti,suppress-v1p8-ena DT property
> which determines whether to apply the quirk for SD.
> 

Sorry for the noise. Please ignore this series, will be re-sending with
fixed cc list.

~ Judith

