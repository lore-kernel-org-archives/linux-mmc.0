Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A112153DA;
	Thu, 17 Apr 2025 22:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744929452; cv=none; b=PZmeFFp+o6n3HfJJMq4tEWVJH50ZlPOXvLHkkaYqhGa8vEpoV5/Ur07xZ7hEaifZR05nsBdTN1TDZUEdzgz37ZDksD/oxq8+rqH2/DajqhPSTnJGhlcoN2rWb9wtcrXBtXrh1mLXbn7L4kcA9Q0gRKSEvRdKFg5GYJdKmXRZST0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744929452; c=relaxed/simple;
	bh=JHXfpGGe/uR83dLp3mAuiZphzSxIQ2v4Ej9z1EZAQ/4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=mMRtQMonr8Zowm5aHf/d5p3FWeeFd+V0dHw+hC0FfcHA/EC8jQxezj/z5fHRlafdfQyyvW53HTQ7WssfSm8eL/IP6kpEXxSF8D1UtdNLuF5Pjm8Zgsq7h0uIo69ktpq9YRP0z4sUv5tj+wesmXtiPAo3BDCPsuF4Pm4rcn7afsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=EHQSjooy; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="EHQSjooy"
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53HMbGsF773861
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Apr 2025 17:37:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1744929436;
	bh=zOUVcUXBkJ4sxE5jY53zdLeJ0NM3c39bCqxQ74K5jfc=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=EHQSjooy9Zn06l4HhoTnxH6KBBZMMLYsUW733WVZaOJeX1v7yjUKbum0kN3WSwvCn
	 Us8GInzUsPbTKMl/SQ1s+/gQXObvB53w7V2Jvjkwx91m75dQGtzkd7+aO4MLv8wy6X
	 aUtJEbk6EN0uhciRIknenrRH1C0uOjf3WkweKcVE=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53HMbGZM094612
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 17 Apr 2025 17:37:16 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 17
 Apr 2025 17:37:15 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 17 Apr 2025 17:37:16 -0500
Received: from [128.247.81.105] (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53HMbFYV098138;
	Thu, 17 Apr 2025 17:37:16 -0500
Message-ID: <b051466d-534d-4e93-9ba5-52401aed82ef@ti.com>
Date: Thu, 17 Apr 2025 17:37:15 -0500
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] dt-bindings: mmc: sdhci-am654: Add
 ti,suppress-v1p8-ena
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
 <20250417182652.3521104-3-jm@ti.com>
 <aAFULUo9BMf306s3@gaggiata.pivistrello.it>
Content-Language: en-US
From: Judith Mendez <jm@ti.com>
In-Reply-To: <aAFULUo9BMf306s3@gaggiata.pivistrello.it>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Francesco,

On 4/17/25 2:19 PM, Francesco Dolcini wrote:
> Hello Judith,
> thanks for the patch.
> 
> On Thu, Apr 17, 2025 at 01:26:52PM -0500, Judith Mendez wrote:
>> This patch documents ti,suppress-v1p8-ena which is a flag
>> used to suppress V1P8_SIGNAL_ENA in sdhci_am654 driver. This
>> quirk is necessary to fix fail init issues across various
>> types of SD cards tested on Sitara K3 SoCs.
> 
> bindings are supposed to describe the hardware, not the driver.
> 
> You should rephrase the commit message and the description of the property with
> this in mind.
> 
> In addition, I think that the dt-bindings is supposed to be before the driver
> patch in the series.
> 

Right, will fix for v3 along with adding fixes tags.

~ Judith

