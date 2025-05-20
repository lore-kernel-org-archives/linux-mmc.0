Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC4D727054F
	for <linux-mmc@vger.kernel.org>; Tue, 20 May 2025 16:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747760048; cv=none; b=ojTXGnvkQ8rLlyIjdJzBelgNkOhzNysaV9HlZbpRbAMF6szdWe0WxU4rApiXJhxlVai+va+EhzepK+f14039czKTImerO6o+rCu1/SVSgJ72jkYOfQfk7GjK/ScJI88xJSh/ffo+YUndTJ4cip39Gacqxi2ttHFaMc5oI7MMSyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747760048; c=relaxed/simple;
	bh=XQSfEcN5oD2pWaXOwNhhEpy/svp3DefoLOrIBl9tCSE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:Content-Type; b=t4NOMg4E8a0qWjdEjO+8ddEjP1qovMXWzfVupRBCNako0GjVFwJWjEQnVoSI42uNj6O+NehjM6h9sdVyLC4zK15l/FV7Yt4yG8oDX4ucvDDGClUXA9TtVeNAAJMIIwuCDs6UC67m3emk+NEJgs2yqQmHkqF9uG+Jk66u5DklRZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=uvgJ6tAU; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="uvgJ6tAU"
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 54KGs3YR086600;
	Tue, 20 May 2025 11:54:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1747760043;
	bh=EmAEilAit8HtoQqA/EwbjMXQEqeeFzSdN4xoB7CvthU=;
	h=Date:From:Subject:To:CC;
	b=uvgJ6tAUegYa4F7xzLHDbyLzTwtXTU4s8qNdQ9erFvnlQxus7ltExSpsxHl6j6mo3
	 cMe8JRTNhIx2KUaFgBCbsdsnzzAzDiHvV3rYQZzKxpkIEgQ8QEk8wfv4VAbgE8Tqyo
	 nxW2OnybWFF4TQvfAxB1kZI5ZhHQoKs7QJJ+RQxE=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 54KGs3mM2113658
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Tue, 20 May 2025 11:54:03 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 20
 May 2025 11:54:03 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 20 May 2025 11:54:03 -0500
Received: from [10.250.202.83] ([10.250.202.83])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 54KGs1Ok034570;
	Tue, 20 May 2025 11:54:02 -0500
Message-ID: <b7c85fa9-1b70-4ca2-893e-4f0e9399c97e@ti.com>
Date: Tue, 20 May 2025 19:54:01 +0300
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: "Nemanov, Michael" <michael.nemanov@ti.com>
Subject: mmc: Synchronization of in-band SDIO IRQ
To: Ulf Hansson <ulf.hansson@linaro.org>
CC: <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi,

I'm working on a WLAN driver that will use SDIO transport and will 
support both GPIO and SDIO IRQ sources (only 1 source will be selected 
at runtime).
During driver cleanup there is a need to synchronize the IRQ handler and 
guarantee it is no longer running. For GPIO IRQs is trivial via 
synchronize_irq(). For SDIO IRQs I see no similar option and thinking 
about possible solution.

Is calling flush_work(host->sdio_irq_work) a reasonable approach here? 
This can be done either directly from my driver or added as an API in 
mmc/host.h.

Another solution might be registering with MMC core a minimal handler 
that only triggers a driver-local work item which can be easily flushed 
by the driver. Though in that case handling IRQs that are already 
"in-flight" is a bit more tricky.

Any guidance is much appreciated.

Thanks you and best regards,
Michael.
