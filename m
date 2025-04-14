Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 333FAEC4;
	Mon, 14 Apr 2025 14:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744641490; cv=none; b=a3B3wniRxka+TeSdb6zIi63Cu9vAeVZKSiC9hl4vfRv3eIU8hKV5ZKd3Vp5HBlGgSOm2n4Sq4UBB/n2ZB1gTxg/p6d+lka1LjMEq9NzDI7oo0LB37OM7NYUfmL2MWmjlz0DLbsluttH4YCX/DW5PIwVu8kA0/7UFnuM5ztodvUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744641490; c=relaxed/simple;
	bh=L/J0AmkibIg4ZG+O4+FClzNVHaDwTTVY7iHUZg6U9k8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=fXnKqUMDShB9ZJ3I1sUp3p1EWjc+5my7NOPoj6WtsCa02WeRZr5KcHEbWCk1adXY8smcZi9NnNcRYaycKJoB9Y3GrwoLtnsrO7s0OTnsBxw6Uwf1b9g8DqFqexC9+BBcu3FhFUFks4SAV0DhjbOsR9kgAaCAlY7BqfDt0s46Uiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=cu4YiffD; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="cu4YiffD"
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53EEbsd02082720
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Apr 2025 09:37:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1744641474;
	bh=4rK0A9UMpj1kGHbXtIjjRIKa3M+N2J82j6cK7DYIxMU=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=cu4YiffDqkQedKUId7tHwR5CWD6KoabHcGPWjMwGS77vSNeGfBV9ciCHRqLcq30/M
	 Tb5UGxyky4zOs0td5xt4Xh5iGH2jqXz+7VIuT538pz8duQ4r4dbL+uu6knOZhcQ8Wq
	 6Fl0Bh+jYrKf4BkTtc47HynC5NJEl3q50ypG/u2k=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53EEbs7v067711
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 14 Apr 2025 09:37:54 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 14
 Apr 2025 09:37:53 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 14 Apr 2025 09:37:53 -0500
Received: from [128.247.81.105] (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53EEbrma003772;
	Mon, 14 Apr 2025 09:37:53 -0500
Message-ID: <65119d3a-6907-4911-ba19-e3bcdb65b529@ti.com>
Date: Mon, 14 Apr 2025 09:37:53 -0500
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Fix V1P8_SIGNAL_ENA and HIGH_SPEED_ENA
To: Francesco Dolcini <francesco@dolcini.it>
CC: Hiago De Franco <hiagofranco@gmail.com>,
        Adrian Hunter
	<adrian.hunter@intel.com>,
        Josua Mayer <josua@solid-run.com>,
        Ulf Hansson
	<ulf.hansson@linaro.org>, <linux-mmc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Moteen Shah <m-shah@ti.com>,
        Hiago De Franco
	<hiago.franco@toradex.com>
References: <20250407222702.2199047-1-jm@ti.com>
 <20250411130354.dc3sv3e7ruekkhkp@hiago-nb>
 <d8e45e50-f0eb-41d0-9c50-56147eaf262a@ti.com>
 <20250411194813.c4ft2uxgdiuza5cm@hiago-nb>
 <5f36ec5d-bb31-4b6c-aa4e-4ec48cb1d067@ti.com>
 <20250414065119.GA6309@francesco-nb>
Content-Language: en-US
From: Judith Mendez <jm@ti.com>
In-Reply-To: <20250414065119.GA6309@francesco-nb>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Francesco,

On 4/14/25 1:51 AM, Francesco Dolcini wrote:
> Hello Judith
> 
> On Fri, Apr 11, 2025 at 04:55:39PM -0500, Judith Mendez wrote:
>> My understanding was that we do not like adding new DT properties if
>> we can find a way to apply the quirk in the driver.
> ...
> 
>> If this implementation flies with the maintainers, then we can go back to DT
>> property implementation.
> 
> Not sure if this is clear, but this patch is NOT working according to
> our tests, we would need to fix it in a different way.

Not sure if you are following the thread with Hiago, but we are fixing
it a different way; add a new DT property: "ti,suppress-v1p8-ena" for SD
card which allows us to have granular control on when v1p8 is suppressed
for MMC1.

With this method, we make sure the quirk is never applied to your board (;

~ Judith

