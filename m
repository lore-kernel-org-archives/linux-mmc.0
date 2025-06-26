Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56DC2E5411;
	Thu, 26 Jun 2025 14:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750947548; cv=none; b=aLOeg9PNxZTollRrM0ukG3Xk+RQyYcd+1Zaz/rXVpAAHxYPQ7jH/kUUb6h+3+2yMYmCNErqWOKIio3sbkSMZX+xKIj73CuH5NzehDuzl0jgNn7bteSie0beb3d1baJZYigYauiZVEjdOH+m9d17mZZhVqIFXfobTCbW1QCRbYSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750947548; c=relaxed/simple;
	bh=gd5wsOvo6eYcw7FYl9OPfbJCOvOhsKfh7GYlKa8F2QI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=AUji4cUQDBiHEitPx6O0s5zue5o+XshMgxcrlGwMjHG6yP1/0VzIzFHlcJdp1hFzpGIU/r13kiAunK+jdnq87yue5hdYmDmzw6J5VeCqSFPoI2/FfC5VsmstWCvLx73QN/e20FKCDmTbKrrsCzZDE74zGXi5nuColzngSpQC66M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=dAF6pKi4; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="dAF6pKi4"
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 55QEIvQM1757161;
	Thu, 26 Jun 2025 09:18:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1750947537;
	bh=LEpiTYfrKQjJZ0APtPysPfd88bdBjGszmoPLyAL9M+g=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=dAF6pKi4p4zZmoNuM4NJTMa6nVYijZNpgEAvIBPG3wLPLM1/JC2mFzbggocG7z0S5
	 tFUJYk3EeC85DNynYB9eSPVwVbYPP5hGoc0UcALeP6DmOSyuRHeNyiX5rQblSOwA1b
	 gkg4aKNvQ3cYvItw2V2zb3gRg1bhl0As6PZx07co=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 55QEIvpX3694908
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Thu, 26 Jun 2025 09:18:57 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 26
 Jun 2025 09:18:56 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Thu, 26 Jun 2025 09:18:56 -0500
Received: from [128.247.81.105] (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 55QEIuul1133313;
	Thu, 26 Jun 2025 09:18:56 -0500
Message-ID: <ba694996-0a17-480f-b286-4cfed81165f0@ti.com>
Date: Thu, 26 Jun 2025 09:18:56 -0500
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] Workaround for Errata i2312
To: Vignesh Raghavendra <vigneshr@ti.com>,
        Ulf Hansson
	<ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
CC: Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>
References: <20250624221230.1952291-1-jm@ti.com>
 <0bf7ccf4-26ae-42f6-b679-d7840e42efc5@ti.com>
Content-Language: en-US
From: Judith Mendez <jm@ti.com>
In-Reply-To: <0bf7ccf4-26ae-42f6-b679-d7840e42efc5@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Vignesh,

On 6/25/25 10:56 PM, Vignesh Raghavendra wrote:
> 
> 
> On 25/06/25 03:42, Judith Mendez wrote:
>> This patch series includes fix for Errata i2312 [0].
>>
>> Also include fixes for removing eMMC HS DDR support for am62
>> SK which has been descoped as per datasheet [1] and enabling internal
>> pullups for AM62 SK and AM62SIP SK, as per JESD84 spec recommendations.
>>
>> [0] https://www.ti.com/lit/pdf/sprz487
>> [1] https://www.ti.com/lit/gpn/am625
>>
>> Judith Mendez (3):
>>    mmc: sdhci_am654: Workaround for Errata i2312
>>    arm64: dts: ti: k3-am62-main: Remove eMMC High Speed DDR support
>>    arm64: dts: ti: k3-am62*: Move eMMC pinmux to top level board file
>>
> 
> 2/3 and 3/3 have no relation to 1/3 and they need to go via different
> trees. Please post them separately.

Will separate the patches, thanks (:

~ Judith

> 
>>   arch/arm64/boot/dts/ti/k3-am62-lp-sk.dts      | 25 +++++++++++++++++++
>>   arch/arm64/boot/dts/ti/k3-am62-main.dtsi      |  1 -
>>   arch/arm64/boot/dts/ti/k3-am625-sk.dts        | 25 +++++++++++++++++++
>>   .../arm64/boot/dts/ti/k3-am62x-sk-common.dtsi | 24 ------------------
>>   drivers/mmc/host/sdhci_am654.c                |  9 ++++---
>>   5 files changed, 56 insertions(+), 28 deletions(-)
>>
> 

