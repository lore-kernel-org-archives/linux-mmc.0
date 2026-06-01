Received: from mail.auroraos.dev (unknown [95.181.193.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D19C3AE1B1
	for <linux-mmc@vger.kernel.org>; Mon,  1 Jun 2026 14:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.181.193.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780322513; cv=none; b=FZMCoe1YudkWAHcS2xK0QdiwMoQsZy3087Co4AweFcY8OGja8Sv79A+hIo1GpRYXLTA0+8Ydo5xuk44nsfuv8BUtz3AJlzQFECBElNe2qlnMWsSrXSA8hU3THhkcHOZw7RTb+/70uuSHlZdCeNLrCI2SllGTFJvmOF7KImDGeUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780322513; c=relaxed/simple;
	bh=mUqB+RL7wSsfHiHYPesi3+U874pb1IiIn1X9kAmZt3U=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=OQaJ+wgtfyQYDtni0n19knqm7fERdj7MOYb2FcEB4BnSvXONJAVmua1hWOaFIAs2GcACNLiIQEF8ke5zFc6/Doao6JLmJATcB6WVPVLxhc3sMxXy+psBJhxdYibOCDY6ZvmqyZZ4Sg1HjpaEu10LKrhigEy96Z8/6eF1bmHJ/K0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=auroraos.dev; spf=pass smtp.mailfrom=auroraos.dev; arc=none smtp.client-ip=95.181.193.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=auroraos.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=auroraos.dev
Received: from [192.168.2.104] (91.78.2.227) by exch16.corp.auroraos.dev
 (10.189.209.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1847.3; Mon, 1 Jun 2026
 17:01:45 +0300
Message-ID: <ce53283f-bfe3-4889-8eac-a4f75a546ac4@auroraos.dev>
Date: Mon, 1 Jun 2026 17:01:44 +0300
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
 <05400788-da59-4ef8-9c2b-4efff298be2a@intel.com>
Content-Language: en-US
From: Sergey Shtylyov <s.shtylyov@auroraos.dev>
In-Reply-To: <05400788-da59-4ef8-9c2b-4efff298be2a@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: exch16.corp.auroraos.dev (10.189.209.38) To
 exch16.corp.auroraos.dev (10.189.209.38)

On 6/1/26 12:19 PM, Adrian Hunter wrote:
[...]
>> In the driver's probe() method, clk_disable_unprepare() for the bus clock
>> is called on the error path even if the prior clk_prepare_enable() call has
>> failed (and the same thing happens in the remove() method as well) -- that
>> would cause the prepare/enable counter imbalance.  Also, the same problem
>> can happen in the driver's suspend() method; note that the resume() method
>> does check the clk_prepare_enable()'s result -- let's be consistent and do
>> that in probe() method as well.  BTW, I don't know for sure what does the
>> bus clock control -- if it affects the register accesses, the driver will
>> likely to cause (e.g. on ARM) a kernel oops if it fails to prepare/enable

   Oops, "to" wasn't need here. I'll post v4 (with the stray comma removed as
well)...

>> the bus clock in the probe() method...
>>
>> Found by Linux Verification Center (linuxtesting.org) with the Svace static
>> analysis tool.
>>
>> Fixes: e438cf49b305 ("mmc: sdhci-of-dwcmshc: add SDHCI OF Synopsys DWC MSHC driver")
>> Fixes: bccce2ec7790 ("mmc: sdhci-of-dwcmshc: add suspend/resume support")
>> Signed-off-by: Sergey Shtylyov <s.shtylyov@auroraos.dev>
> 
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
   Thanks!

[...]

MBR, Sergey

