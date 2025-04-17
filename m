Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC7120F087;
	Thu, 17 Apr 2025 22:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744929555; cv=none; b=D6B9F9Jmu7EcoRi738LbJVlVydZzOeCon8jOlu1XKEicJOz4l4/TczrooAJa0hyiPwCKSyx6aw+RVkMmG2bGazKiMaNR+6Ul8R3zgxODirRIY0oTKqMNESZS9pCd2j/318bxwfKqjI/L71y+v8Ef+Un3WRI7Zp8+/VZ9ppDckM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744929555; c=relaxed/simple;
	bh=5WqWlcIveNteoAGBdrjqB+Xha02+8TcvSi1tpAGku3g=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=fUcbWSqLwYwvx98M+2E727nSqiM9kxOYQVyvjkUhc/xw0Z8+ISHuQaxGSHOoWubSyLJx3YZ37i8DDsqXDrT3xEn4OkW25w72tXYb2dMy4QVm9cVsTuts9h18IAlEj5vBwNwBrFn8hMsOO32ED6tBFcm+LBOK744dEHeiAQH77j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=SB786bVS; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="SB786bVS"
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53HMckqm128952
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Apr 2025 17:38:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1744929526;
	bh=AWUb8tvMlFEEKiPyxJvkrbL7zQiJ0ZFreEAhyJ2fFBM=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=SB786bVSicD/RGT2a0FA9PliFRhuiEAqaSH6x58qO4otFNDogMgJUa4MwgUbpC6Yy
	 NorwiI+ILQbf0baXQrEFnOI+Wa5FCDqvJ6D4lsMN3GWdfddS6i5gTMOMny00IRKQw9
	 N0NdtXLWdJqQAZCkQSyyQiyepX8aDSONeUGkJhb8=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53HMckfe095464
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 17 Apr 2025 17:38:46 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 17
 Apr 2025 17:38:45 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 17 Apr 2025 17:38:45 -0500
Received: from [128.247.81.105] (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53HMcjf6099463;
	Thu, 17 Apr 2025 17:38:45 -0500
Message-ID: <41cb896b-be6c-4594-aa73-a5a475d49d05@ti.com>
Date: Thu, 17 Apr 2025 17:38:45 -0500
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] Fix V1P8_SIGNAL_ENA
To: Francesco Dolcini <francesco@dolcini.it>
CC: Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter
	<adrian.hunter@intel.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, <linux-mmc@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Josua Mayer <josua@solid-run.com>, Moteen
 Shah <m-shah@ti.com>,
        Hiago De Franco <hiagofranco@gmail.com>
References: <20250417182652.3521104-1-jm@ti.com>
 <aAFU8K9j4fZ-njwP@gaggiata.pivistrello.it>
Content-Language: en-US
From: Judith Mendez <jm@ti.com>
In-Reply-To: <aAFU8K9j4fZ-njwP@gaggiata.pivistrello.it>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Francesco,

On 4/17/25 2:22 PM, Francesco Dolcini wrote:
> On Thu, Apr 17, 2025 at 01:26:50PM -0500, Judith Mendez wrote:
>> There are eMMC boot failures seen with V1P8_SIGNAL_ENA on Kingston
>> eMMC and variouse types of SD cards on Sitara K3 SoCs due to the
>> sequencing when enumerating to HS200 mode. Since V1P8_SIGNAL_ENA is
>> optional for eMMC, do not set V1P8_SIGNAL_ENA by default for eMMC.
>> For SD cards we shall parse DT for ti,suppress-v1p8-ena property
>> to determine whether to apply the quirk.
> 
> I assume this ti,suppress-v1p8-ena should be added to some SoC dtsi, am I
> wrong?
> 

I was planning to add in a separate series once this was merged but I
can add to v3 no problem, thanks for reviewing.

~ Judith

