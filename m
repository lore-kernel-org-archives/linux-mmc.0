Received: from mail.auroraos.dev (unknown [95.181.193.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24BA73876D0
	for <linux-mmc@vger.kernel.org>; Fri, 29 May 2026 17:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.181.193.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780075680; cv=none; b=AXBsIXis7RRq6BhlFfcuXvWu+x4V+qPrlopKoCI0JMi2zxhgY6/R75uQtTQRe3RkYlL3BAnq3W+zS7OYiPVpYNBveFGEDFOS9Ie7khe0tUAZGLWiUN6KS507FW3xMO/z1ACwhxWpf90VmvvZRhJxPix9ztgPDNcPqwdXRGHheuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780075680; c=relaxed/simple;
	bh=5jUbwihCajI2rOntUm5QAr21DAgBvs2FDbqzxkXVxLE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=rkcKluMtCSQhTeOBXhNRRihgvYB7sPLgDFsTxolHneioAR25hF3QkwpJAsE5zSHDyUhkJ7IoMeX2zKaTb8SUHW1QsNPqdmDGdtl3RidTtcYaeC94j2+EaBM5OPRpqNi8ARt5rhKw0lXNRJDlC8aAVKGfva8DZm8wyy8wcyzl7T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=auroraos.dev; spf=pass smtp.mailfrom=auroraos.dev; arc=none smtp.client-ip=95.181.193.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=auroraos.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=auroraos.dev
Received: from [192.168.2.104] (91.78.16.248) by exch16.corp.auroraos.dev
 (10.189.209.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1847.3; Fri, 29 May
 2026 20:27:48 +0300
Message-ID: <784193db-813b-4ef4-ab56-cbdfd73fe72a@auroraos.dev>
Date: Fri, 29 May 2026 20:27:48 +0300
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: sdhci-of-dwcmshc: check bus clock enable result in
 the, probe() method
From: Sergey Shtylyov <s.shtylyov@auroraos.dev>
To: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulfh@kernel.org>,
	<linux-mmc@vger.kernel.org>
CC: Jisheng Zhang <jszhang@kernel.org>
References: <34ef000c-907f-40b2-86e2-0c4fab094cfd@auroraos.dev>
Content-Language: en-US
In-Reply-To: <34ef000c-907f-40b2-86e2-0c4fab094cfd@auroraos.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: exch16.corp.auroraos.dev (10.189.209.38) To
 exch16.corp.auroraos.dev (10.189.209.38)

On 5/28/26 11:42 PM, Sergey Shtylyov wrote:

> In the driver's probe() method, clk_disable_unprepare() for the bus clock
> is called on the error path even if the prior clk_prepare_enable() call has
> failed -- that causes the prepare/enable counter imbalance.  Also, the same

   I missed the fact that the remove() would be affected by the imbalance as well.
I'll update the description and repost...

> kind of problem can happen in the driver's suspend() method; note that the
> resume() method does check for the clk_prepare_enable()'s success -- let's
> just be consistent and do that in probe() method too (BTW, I don't know for
> sure what does the bus clock control -- if it affects the register access,
> the driver is likely to cause a kernel oops iff it fails to prepare/enable
> the bus clock in the probe() method)...
> 
> Found by Linux Verification Center (linuxtesting.org) with the Svace static
> analysis tool.
> 
> Fixes: e438cf49b305 ("mmc: sdhci-of-dwcmshc: add SDHCI OF Synopsys DWC MSHC driver")
> Fixes: bccce2ec7790 ("mmc: sdhci-of-dwcmshc: add suspend/resume support")
> Signed-off-by: Sergey Shtylyov <s.shtylyov@auroraos.dev>
[...]

MBR, Sergey

