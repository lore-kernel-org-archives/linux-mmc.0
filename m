Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E846E28B4F9
	for <linux-mmc@vger.kernel.org>; Tue, 10 Jun 2025 09:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749547326; cv=none; b=EGclWbpzWnUpRnWMuqA2X4tzX93VeND97OaE94Yga3sy02z4mayopZRHu37xzwydbzj9oYY8AFSUiAL3UjKMJDl89oikXqVdbwTL/g1lKU8l7ZnVYSdt31Ope8wHfI4G5jZyFuCRdKP8qscxlCcJ2m2L/0PwuN3JfKjhX8LJ5zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749547326; c=relaxed/simple;
	bh=soo9AlJeYPxqShHJLAQJ3fhswwH3OyTJ/BWrOJyYxhA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Ansbxp6L7B5/O1WZOoMAzBKSadFrKIML6TgMStIAl1/p3tlkGx+gDFoF/7Ho6Wrdf/4oNQ2cTPqnf3kHTszXzn7SaRgzvC0IDB2ZyUWtG47Pr+z0q27TFgLaI7WhKRN910ezmHKhVM4seVVDX+eFp4gbelexXTxqkrQRKEfc+XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=AKVr4rcR; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="AKVr4rcR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1749547324; x=1781083324;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=soo9AlJeYPxqShHJLAQJ3fhswwH3OyTJ/BWrOJyYxhA=;
  b=AKVr4rcRi4gCrX6+/LH6EZ+JNrSbaoXM+Kf6mrBJILuBSLASDseo26WQ
   UoaGJz46q6KH63QrodMecoVIbDSt9Y22E9pbO+ovJT7yqb4axdE/0wVFZ
   8iGir/oGhIEUOZBtiZATpl0cZ8yqbUqjYa7ui9DpxYbXlH/a4ZsZEtubw
   FLFHLhGNvQRiWhZ5PWdS18LjR0AhD8I4h+V0t7PQj5mq6GZE2UvBMHkXd
   ptORRqcbMb/WkwXngruICl9Vle6ZGEcGYri49FDJfA4hJ3zRcL5K/fREl
   s2dHn76DjuStRgkz0fv/0pZMbfyrBIR6F+zOqHxRqOAnLUg5pDVFwv6xN
   A==;
X-CSE-ConnectionGUID: sWGg/w0dT1y6UBvrZ3YtPA==
X-CSE-MsgGUID: KSih9dsTTiaH1Vk1sqG07g==
X-IronPort-AV: E=Sophos;i="6.16,224,1744095600"; 
   d="scan'208";a="47583116"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Jun 2025 02:22:03 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 10 Jun 2025 02:21:33 -0700
Received: from [10.159.227.108] (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.44 via Frontend
 Transport; Tue, 10 Jun 2025 02:21:31 -0700
Message-ID: <1bb2658a-8615-481d-a569-ba7c9a8e2a67@microchip.com>
Date: Tue, 10 Jun 2025 11:21:43 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/36] mmc: atmel: Use devm_mmc_alloc_host() helper
To: Binbin Zhou <zhoubinbin@loongson.cn>, Binbin Zhou
	<zhoubb.aaron@gmail.com>, Huacai Chen <chenhuacai@loongson.cn>, Ulf Hansson
	<ulf.hansson@linaro.org>
CC: Huacai Chen <chenhuacai@kernel.org>, <linux-mmc@vger.kernel.org>, "Nicolas
 Ferre" <nicolas.ferre@microchip.com>, Alexandre Belloni
	<alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>
References: <cover.1748933789.git.zhoubinbin@loongson.cn>
 <0688b77b93d27bd2f2e155fca6f53a1766fc3a80.1748933789.git.zhoubinbin@loongson.cn>
Content-Language: en-US, fr
From: Aubin Constans <aubin.constans@microchip.com>
In-Reply-To: <0688b77b93d27bd2f2e155fca6f53a1766fc3a80.1748933789.git.zhoubinbin@loongson.cn>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit

On 03/06/2025 14:25, Binbin Zhou wrote:
> Use new function devm_mmc_alloc_host() to simplify the code.
> 
> Cc: Aubin Constans <aubin.constans@microchip.com>
> Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
> Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Cc: Claudiu Beznea <claudiu.beznea@tuxon.dev>
> Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>
> Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>

Acked-by: Aubin Constans <aubin.constans@microchip.com>

> ---
>   drivers/mmc/host/atmel-mci.c | 7 ++-----
>   1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
> index 14e981b834b6..f72fe4b805f6 100644
> --- a/drivers/mmc/host/atmel-mci.c
> +++ b/drivers/mmc/host/atmel-mci.c
> @@ -2247,7 +2247,7 @@ static int atmci_init_slot(struct atmel_mci *host,
>          struct atmel_mci_slot           *slot;
>          int ret;
> 
> -       mmc = mmc_alloc_host(sizeof(struct atmel_mci_slot), dev);
> +       mmc = devm_mmc_alloc_host(dev, sizeof(*slot));
>          if (!mmc)
>                  return -ENOMEM;
> 
> @@ -2320,10 +2320,8 @@ static int atmci_init_slot(struct atmel_mci *host,
>          host->slot[id] = slot;
>          mmc_regulator_get_supply(mmc);
>          ret = mmc_add_host(mmc);
> -       if (ret) {
> -               mmc_free_host(mmc);
> +       if (ret)
>                  return ret;
> -       }
> 
>          if (slot->detect_pin) {
>                  timer_setup(&slot->detect_timer, atmci_detect_change, 0);
> @@ -2361,7 +2359,6 @@ static void atmci_cleanup_slot(struct atmel_mci_slot *slot,
>          }
> 
>          slot->host->slot[id] = NULL;
> -       mmc_free_host(slot->mmc);
>   }
> 
>   static int atmci_configure_dma(struct atmel_mci *host)
> --
> 2.47.1
> 

