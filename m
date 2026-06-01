Received: from mail.auroraos.dev (unknown [95.181.193.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C0838AC93
	for <linux-mmc@vger.kernel.org>; Mon,  1 Jun 2026 14:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.181.193.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780325892; cv=none; b=enP/DjhIe4X2IMRv/UhexqPX+/YWduYxH/5Evh29A2pVUUuIxBfI3rQkShQTxLU2LIa4yCIqZ4QUUHoK/XUDUj5W/K6WwT8o84MHJATi6ogYrcsy/rx97zbVd+FcEyzHf3N2uePCmuR/P74C6/yw8M0wSrIJ4itQbC1SlH0o8Fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780325892; c=relaxed/simple;
	bh=+WYOVwm4/5cc/WGBR9IqdjIaR3XwTSLBss7bWN5fs2M=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=X4r2BCtJCuEMhd1cVu1e+yIFh1JF45R0nHj1SLoGbWoyO/EIWnP1K2iUkE5Q5sZr62TBV8Ct5NrPQdEuzfACkCrLIdr5N0Hxmm5jxqfWC6vIHaSKSouFoC56dhupsnMFQMvNH9TUWYmG0aLd8OgHXZt3SFn/wVw+pseOnGe/voM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=auroraos.dev; spf=pass smtp.mailfrom=auroraos.dev; arc=none smtp.client-ip=95.181.193.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=auroraos.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=auroraos.dev
Received: from [192.168.2.104] (91.78.2.227) by exch16.corp.auroraos.dev
 (10.189.209.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1847.3; Mon, 1 Jun 2026
 17:58:06 +0300
Message-ID: <4eabfc20-0bdb-47c7-ae56-e6eb3e06b8b7@auroraos.dev>
Date: Mon, 1 Jun 2026 17:58:05 +0300
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] mmc: sdhci-of-dwcmshc: check bus clock enable result
 in the probe() method
To: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulfh@kernel.org>,
	<linux-mmc@vger.kernel.org>
CC: Jisheng Zhang <jszhang@kernel.org>
References: <dd3aa530-d06f-4733-ba5a-ccc95d8fa91a@auroraos.dev>
 <ed075232-69a9-4f93-95d9-0e2a815a041b@intel.com>
Content-Language: en-US
From: Sergey Shtylyov <s.shtylyov@auroraos.dev>
In-Reply-To: <ed075232-69a9-4f93-95d9-0e2a815a041b@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: exch16.corp.auroraos.dev (10.189.209.38) To
 exch16.corp.auroraos.dev (10.189.209.38)

On 6/1/26 5:55 PM, Adrian Hunter wrote:
[...]
>> In the driver's probe() method, clk_disable_unprepare() for the bus clock
>> is called on the error path even if the prior clk_prepare_enable() call has
>> failed (and the same thing happens in the remove() method as well) -- that
>> would cause the prepare/enable counter imbalance.  Also, the same problem
>> can happen in the driver's suspend() method; note that the resume() method
>> does check the clk_prepare_enable()'s result -- let's be consistent and do
>> that in probe() method as well.  BTW, I don't know for sure what does the
>> bus clock control -- if it affects the register accesses, the driver will
>> likely cause (e.g. on ARM) a kernel oops if it fails to prepare/enable the
>> bus clock in the probe() method...
>>
>> Found by Linux Verification Center (linuxtesting.org) with the Svace static
>> analysis tool.
>>
>> Fixes: e438cf49b305 ("mmc: sdhci-of-dwcmshc: add SDHCI OF Synopsys DWC MSHC driver")
>> Fixes: bccce2ec7790 ("mmc: sdhci-of-dwcmshc: add suspend/resume support")
>> Signed-off-by: Sergey Shtylyov <s.shtylyov@auroraos.dev>
> 
> Try to remember to add tags from previous submissions, like:
> 
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>

   Oops, I was going to but finally forgot... Sorry about that!

[...]

MBR, Sergey

