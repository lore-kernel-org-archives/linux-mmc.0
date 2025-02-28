Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F8B27CCE2;
	Fri, 28 Feb 2025 18:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740768023; cv=none; b=kHrU1ioI4vj6pHAL6ThKr0jdTzQrW6HX4/eeKLPwjKUivwlQF90K1AiOhr5Ouhf8rG6re+DxtE/axC5CTIeex+A9/l71mlN583rMh09fM50sh4Y42iy68rok3OzMcEwjsRYgkxnOuDagvGoQP8sduh9EYXLIfyoGx0LDaahVIdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740768023; c=relaxed/simple;
	bh=dgwriYuHai0NswtoP8mHODftMD1l0GOWzgSCZTYh98A=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ato86R4ZIIZBsGMjkmEDxrcwWVtp0dkSd3pnmwCT798rgcbWw9A1SE0bVSwOalp5Pqer/MKrjW7Fof6f3Iq6jUppSt4uuVxyPJZUJfQC9XFjySD+oZrWGXZ+c8MhGZ8HC/ZuBLXFHIHDXEKB0vlalL76zctMDgyBfaoSjtVHejo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=o5KXG+se; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="o5KXG+se"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1740768021; x=1772304021;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=dgwriYuHai0NswtoP8mHODftMD1l0GOWzgSCZTYh98A=;
  b=o5KXG+seUOFXTDHCGPQShy/rAhdwy5zcFQGZxAW3iz1cwzYMKWLJATCb
   pChbHDTnm4i83DHf3YCRdYikpV+57dSEbouysPcqSWuhjvRP70Jx/xGGb
   MMxkifNFrmA6ocTk4om1GZZ+5x/WGL0uO3lt6WmOXCCNL3RJ1UNx/v6Em
   7MRdMrdnoKCktZqga28BeY4ItpxjySUEQ+WaaY/UUE/rIs8FYWwKWl43D
   lVRUujKKlI4C+QGxSxHslFiq9uaUm6BvANaKR3orkilhxTapQNnOgX8QA
   0+Ms/B4eDIB6awXDGYzh+oMAlR47wOI8P901CzElE8WsDKpW00DE4z5ti
   A==;
X-CSE-ConnectionGUID: 0708Gxq6RM22afyZLBfpag==
X-CSE-MsgGUID: LguonwZOQEWh8tU6Da1OdA==
X-IronPort-AV: E=Sophos;i="6.13,323,1732604400"; 
   d="scan'208";a="42424459"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Feb 2025 11:40:15 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 28 Feb 2025 11:39:54 -0700
Received: from [10.171.248.16] (10.10.85.11) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Fri, 28 Feb 2025 11:39:52 -0700
Message-ID: <d1a9fc41-35df-4b30-83cc-5589a649c7ff@microchip.com>
Date: Fri, 28 Feb 2025 19:39:53 +0100
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next] mmc: atmel-mci: Add missing clk_disable_unprepare()
To: Gu Bowen <gubowen5@huawei.com>, <ulf.hansson@linaro.org>
CC: <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>, <ludovic.desroches@microchip.com>,
	<linux-mmc@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <wangweiyang2@huawei.com>
References: <20250225022856.3452240-1-gubowen5@huawei.com>
Content-Language: en-US, fr
From: Aubin Constans <aubin.constans@microchip.com>
In-Reply-To: <20250225022856.3452240-1-gubowen5@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit

On 25/02/2025 03:28, Gu Bowen wrote:
> The error path when atmci_configure_dma() set dma fails in atmci driver
> does not correctly disable the clock.
> Add the missing clk_disable_unprepare() to the error path for pair with
> clk_prepare_enable().
> 
> Fixes: 467e081d23e6 ("mmc: atmel-mci: use probe deferring if dma controller is not ready yet")
> Signed-off-by: Gu Bowen <gubowen5@huawei.com>

Acked-by: Aubin Constans <aubin.constans@microchip.com>

> ---
>   drivers/mmc/host/atmel-mci.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
> index fc360902729d..24fffc702a94 100644
> --- a/drivers/mmc/host/atmel-mci.c
> +++ b/drivers/mmc/host/atmel-mci.c
> @@ -2499,8 +2499,10 @@ static int atmci_probe(struct platform_device *pdev)
>          /* Get MCI capabilities and set operations according to it */
>          atmci_get_cap(host);
>          ret = atmci_configure_dma(host);
> -       if (ret == -EPROBE_DEFER)
> +       if (ret == -EPROBE_DEFER) {
> +               clk_disable_unprepare(host->mck);
>                  goto err_dma_probe_defer;
> +       }
>          if (ret == 0) {
>                  host->prepare_data = &atmci_prepare_data_dma;
>                  host->submit_data = &atmci_submit_data_dma;
> --
> 2.25.1
> 

Thank you for having identified and fixed this.
