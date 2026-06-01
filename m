Received: from mail.auroraos.dev (unknown [95.181.193.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23FCC38655E
	for <linux-mmc@vger.kernel.org>; Mon,  1 Jun 2026 07:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.181.193.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780300316; cv=none; b=qf0M90/pSQhaV7+Db3xGlxUMg9ClMRtD3fg+ebTlXCFOwTjADVPPJA8BO3GDhwXzuwjplstLp0chsgM+fI0bQTQqBZ1KpH+IVdslMeh2nBNmsH+K/iDLVyNKaUEmcLHtZjDKIF8FMRWw6EqhcYEsgoiT6weaSSFN8xjvfZuXTZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780300316; c=relaxed/simple;
	bh=6UfgSZ4zOBkyvz6DtSaWaVK+fgOVgA78f+T8WZC8L5w=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Xum6mTNTIqkNOdU3UXULwa/qFyFJVO2u2InMVHt1k62SPzmMDtUOdpLFx/rL50f3gc7goeYo7aMHNpGktXk3xFc/wEetypK6GpEKEhHFPCFEAFoCggkyaEaqL15NKkpVvJA3HS+kIuc1PBbQ1e8op57m3tqRNf5srPOeAm0V50U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=auroraos.dev; spf=pass smtp.mailfrom=auroraos.dev; arc=none smtp.client-ip=95.181.193.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=auroraos.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=auroraos.dev
Received: from [192.168.2.104] (213.87.162.94) by exch16.corp.auroraos.dev
 (10.189.209.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1847.3; Mon, 1 Jun 2026
 10:51:43 +0300
Message-ID: <aba25e4b-0eca-4200-ae0f-9afabb989155@auroraos.dev>
Date: Mon, 1 Jun 2026 10:51:42 +0300
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mmc: sdhci-of-dwcmshc: check bus clock enable result
 in the, probe() method
To: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulfh@kernel.org>,
	<linux-mmc@vger.kernel.org>
CC: Jisheng Zhang <jszhang@kernel.org>
References: <b5dea73a-3c79-4beb-96cb-55d619a1f538@auroraos.dev>
 <a3068d05-4568-4a06-b51c-b4bd7dc2db4c@intel.com>
Content-Language: en-US
From: Sergey Shtylyov <s.shtylyov@auroraos.dev>
In-Reply-To: <a3068d05-4568-4a06-b51c-b4bd7dc2db4c@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: exch16.corp.auroraos.dev (10.189.209.38) To
 exch16.corp.auroraos.dev (10.189.209.38)

On 6/1/26 10:43 AM, Adrian Hunter wrote:

> On 29/05/2026 23:28, Sergey Shtylyov wrote:
>> In the driver's probe() method, clk_disable_unprepare() for the bus clock
>> is called on the error path even if the prior clk_prepare_enable() call has
>> failed (and the same thing happens in the remove() method as well) -- that
>> would cause the prepare/enable counter imbalance.  Also, the same problem
> 
> Doesn't clk_disable_unprepare() do nothing if clk is IS_ERR_OR_NULL()?

   Yes, I does. But my patch is not about this case, it's about the case when
clk_prepare_enable() for the bus clock fails...
 
>> can happen in the driver's suspend() method; note that the resume() method
>> does check the clk_prepare_enable()'s result -- let's be consistent and do
>> that in probe() method as well.  BTW, I don't know for sure what does the
>> bus clock control -- if it affects the register accesses, the driver will
>> likely to cause (e.g. on ARM) a kernel oops if it fails to prepare/enable
>> the bus clock in the probe() method...
>>
>> Found by Linux Verification Center (linuxtesting.org) with the Svace static
>> analysis tool.
>>
>> Fixes: e438cf49b305 ("mmc: sdhci-of-dwcmshc: add SDHCI OF Synopsys DWC MSHC driver")
>> Fixes: bccce2ec7790 ("mmc: sdhci-of-dwcmshc: add suspend/resume support")
>> Signed-off-by: Sergey Shtylyov <s.shtylyov@auroraos.dev>

[...]

MBR, Sergey

