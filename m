Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 026AF2749CB;
	Mon,  5 May 2025 21:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746480277; cv=none; b=BdOk8ngjApsZkAjqYa9XkqwPZfDClg/aZP8AKFWSogIQOYVMSNMUuv05Edc1q5+4fqgrTl75ihIjntJpbo3JN2og3BVvGCl5EsZhWHg4gZ+Nf6zp3kTr9UvWi652czGFoZcmCgRnXHLJw6gJqHjUVfTSVK1kFC4ghS3mGN54KUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746480277; c=relaxed/simple;
	bh=zJqaToRRd+EWgnbbC+sw2JqSytIFt/UF15dVawQhX+g=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=P8Lae8pXB0Ef9kYFomVgxJFw1u7zGUNr22uNDYk6lI1sSG6HpJZi7LgTJXpfk3KnGBfagy8hnX7fwDethlsxcWa1MakvCggWqMn2/Kv0pD6H/SRluW+xHQA2Jpq1Qu6mQWBp70SBZKJyeSWcbMpZD7Zzkw3tWHlnISLJQYXjC2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=nokAAiNX; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="nokAAiNX"
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 545LOMwM876295
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 5 May 2025 16:24:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1746480262;
	bh=F7LLIU8n02+Spa7/x+VOFmyc13ovyTwQ/Eu0VEiiCSw=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=nokAAiNXqGYUokDhkdskIQljJr0Ci3lAn6WEJv6aCpZ5qmNSQhzXCcPu+z3EPNJT6
	 kKCHUjkYbyu0rnhIUwXg7ExInjlVHcv3BqBVVvAoU8imRdS29c/QqizSl5LC8qF53Q
	 KDfBaQZ3xTgtWjL/HlC9Pm4+llva5hALds4HVEoY=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 545LOMBe074380
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 5 May 2025 16:24:22 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 5
 May 2025 16:24:22 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 5 May 2025 16:24:22 -0500
Received: from [10.250.32.148] ([10.250.32.148])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 545LOMWw047564;
	Mon, 5 May 2025 16:24:22 -0500
Message-ID: <849a5e47-5b37-40e4-8b76-a58adb7e9b90@ti.com>
Date: Mon, 5 May 2025 16:24:21 -0500
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/2] Add SDHCI_QUIRK2_SUPPRESS_V1P8_ENA
To: Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson
	<ulf.hansson@linaro.org>
CC: Josua Mayer <josua@solid-run.com>, <linux-mmc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Nishanth Menon <nm@ti.com>,
        Francesco Dolcini
	<francesco@dolcini.it>,
        Hiago De Franco <hiagofranco@gmail.com>, Moteen Shah
	<m-shah@ti.com>
References: <20250424180036.1541568-1-jm@ti.com>
Content-Language: en-US
From: "Mendez, Judith" <jm@ti.com>
In-Reply-To: <20250424180036.1541568-1-jm@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi all,

On 4/24/2025 1:00 PM, Judith Mendez wrote:
> There are MMC boot failures seen with V1P8_SIGNAL_ENA on Kingston eMMC and
> Microcenter/Patriot SD cards on am62* Sitara K3 boards due to the HS200
> initialization sequence involving V1P8_SIGNAL_ENA. Since V1P8_SIGNAL_ENA
> is optional for eMMC and only affects timing for host controllers using
> ti,am62-sdhci compatible so far, add a new platform data structure for am62
> compatible and append the new SDHCI_QUIRK2_SUPPRESS_V1P8_ENA quirk.
> 
> This fix was previously merged in the kernel, but was reverted due
> to the "heuristics for enabling the quirk"[0]. This issue is adressed
> in this patch series by adding the quirk based on compatible string,
> ensuring the quirk is never applied to devices with internal LDOs, then
> V1P8_SIGNAL_ENA also has a voltage component tied to it.

Gentle ping on this, are there any comments or any issues with this
type of implementation?

Thanks,

~ Judith

