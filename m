Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D13D5B21A;
	Wed, 20 Aug 2025 18:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755714362; cv=none; b=TJjqVEdcfI7GJxABqfY/EsusV+F08mawNKHxKz2IoHVpuYBttnjpYGkmTbrHGjqIRnjYE8jSkDVgd8OIVYVtvdeBVcKGNIYPC9UUg83EquXja2EHSstz4DnzaJDiM7UXIXfICFcViCJzhxoD6aNmiYLONspyUnOC30j3Vs04tB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755714362; c=relaxed/simple;
	bh=a3/QN22dcvT3Yg/vlcYiDhP8eMd2anLNLD4wzYnZvPM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=fyQHCzjq2fYTAVbQiGIjHD+XJ8HRk14EbUtebS25JG1XV2AKX/GUJIVWQ7KgZSiqUiRQiZXnEvPhQ8eB3sehWtaTRaZ/C8CQP/TJcOWz9r/HQRczTL01WPqy5Y3mLiwSVgA3eTPsKRz0ODRiPiZHiKuNayMiuprhk/XZkMAmhHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=zT+DsaFt; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="zT+DsaFt"
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57KIPpCS3193497;
	Wed, 20 Aug 2025 13:25:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1755714351;
	bh=uUbvAfczOBFAdoknsBSNG4wjlrEiKz1KbASawl+Zlek=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=zT+DsaFt1a0koEIfKbW95+suw4WtsiJjzg8LRCvnWq+WEHrmGawmXq1lHZ0tv8NdO
	 3JOeJeqRT+vNbjj9fF2PIt0p3c13cXFDvOVi/CbBZ2jAO0giOVWUgVlQTrWXOlr/01
	 Bmd7D5E3i7fJZYUw1X0PkW7cfA0KNYLjQ5bE2Y0s=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57KIPpJ41970990
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Wed, 20 Aug 2025 13:25:51 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 20
 Aug 2025 13:25:51 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Wed, 20 Aug 2025 13:25:51 -0500
Received: from [128.247.81.105] (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57KIPpL0639034;
	Wed, 20 Aug 2025 13:25:51 -0500
Message-ID: <063807ac-72f2-42f9-863a-d2e2a48a0bb9@ti.com>
Date: Wed, 20 Aug 2025 13:25:51 -0500
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] mmc: sdhci_am654: Disable HS400 for AM62P SR1.0 and
 SR1.1
To: Ulf Hansson <ulf.hansson@linaro.org>
CC: Adrian Hunter <adrian.hunter@intel.com>, <linux-mmc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Andrew Davis <afd@ti.com>
References: <20250819152854.3117844-1-jm@ti.com>
 <CAPDyKFrZ7jLfAQ1N4_nXZndFvtvKeLqhK-9MjuHUoJA073Pdcg@mail.gmail.com>
Content-Language: en-US
From: Judith Mendez <jm@ti.com>
In-Reply-To: <CAPDyKFrZ7jLfAQ1N4_nXZndFvtvKeLqhK-9MjuHUoJA073Pdcg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Ulf,

On 8/20/25 11:11 AM, Ulf Hansson wrote:
> On Tue, 19 Aug 2025 at 17:28, Judith Mendez <jm@ti.com> wrote:
>>
>> This adds SDHCI_AM654_QUIRK_DISABLE_HS400 quirk which shall be used
>> to disable HS400 support. AM62P SR1.0 and SR1.1 do not support HS400
>> due to errata i2458 [0] so disable HS400 for these SoC revisions.
>>
>> [0] https://www.ti.com/lit/er/sprz574a/sprz574a.pdf
>> Signed-off-by: Judith Mendez <jm@ti.com>
>> Reviewed-by: Andrew Davis <afd@ti.com>
>> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
> 
> Can we add a fixes tag? And should this be tagged for stable too?

Sure I can add and respin.

~ Judith

...

