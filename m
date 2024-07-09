Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A8C84A05;
	Tue,  9 Jul 2024 02:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720490874; cv=none; b=h1mnA2caeSCZmBfo9xt9FR0sSCrF8VxITXSMQwQEadTPBOcSQwcxQ9ecL4CR5ik7oM1uahC3aDZdxD86HUGEvhq/9k4eW7NdbmWSfSiqrIVxPRgbodkTLmIxM2xvUBndTEaFpx5ow1CLwMWWXmfH184yrNRRDBebpTmYay3YmLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720490874; c=relaxed/simple;
	bh=VCgKxSebXnKSnf8atp3DA3Gb3sEG5HSXXBklLrZkJrY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rXIFqvpoDxktR+TKz4DBzDIFJV5rYH8pOxg7dqTzxB+Qx9WvirOb9TPMqR6RyeDAEO7Xn1UpSSSe29aWoCGW+B/jIqTQGXw2z2/J4QrSga4ntkoRB2LGt1kAdxdD5tvK3TeYAgDSAgcNFgsIYflGppPOFhR8IcGn4pdR2WlXhb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fNet9tni; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fNet9tni"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7035b2947a4so1935013a34.3;
        Mon, 08 Jul 2024 19:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720490872; x=1721095672; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nDEJfC41waAFJyui6XbaohWq/0St+p5gpbPdVOZxMeQ=;
        b=fNet9tniwKKZ4EuDnBg//PyoAtj2RwFfaposAdkYPNqylvR3PDTPKqcL1lPhzn0EdV
         s6uSwQOMaJZ+10lCPYexG4eo0cgQSQwrXGMg4Unl4P5IiSFXpIeFr+lKGCZKr2+fXYrF
         vXVGaBevOEtHhdt0jr+dy8v2NoECERLK345o3aItW8tatcjk3vve+1x8uzXoLAWjyBjY
         ULj/YNwNxTF4A+EysNpLzM1tgbfBEXwi2byo+8YZqp/Fii2q+jsDU7V2+N4uS80vv2/9
         dIN2FPO/H39abI214KNteXdaiDeKjhbER4BhhFuASZ1P0pB9WJ+RlQgcTlQ5U4apkOlP
         ARGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720490872; x=1721095672;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nDEJfC41waAFJyui6XbaohWq/0St+p5gpbPdVOZxMeQ=;
        b=iNZ0Td6//vvpJPZWIkTNf6aUfvcKSkPzFdcdTEgowbNTnTtroi/emAjEbs3ap4bvr/
         MeY63AtTY5Ux7/Fv//pFPOssE3dfw/rU/K55AyhJqcJ/mkt2IpqSnDNfyHgw4W1BytQ0
         TBDXcpBeNU2FqxOvD2kTUQK7gZGgNj92Fq+6ReYLi1jm57IzGAsAl2UPfO5Aw0IIVrxi
         Ag+TQaEQj3hjEGFHlWZK2pnbOGp8fsLnwftv7STP1+yAM0Un2NHMu2cegYtHbp6EUqHm
         9eYY7Ah55+2utdOL7hZTOUxFkJD4s7go50HDw25Ncc+bkO3flNS+w8gVK7R1wK+grSre
         v/fw==
X-Forwarded-Encrypted: i=1; AJvYcCW5wpCbzXXStgiMFKtpY5g6xp9ZnfF+zG+6drVwgp7DKhfqxDteUe658ASbunVMAgtIFCsBoTOfUIwMy6S/BteUnsRGE9booNgGQermE8ibwbXhlKBVpmg2GgxS/Pqe+eVrYMzDDrgi3hhos4sFNal/VGNOvTmWucn2128/lJHPNn+dUA==
X-Gm-Message-State: AOJu0Yy8k2tQ8t2B6i4xQ9O1Xb0NSUTMdyX9NNcnpxEj9IUDaN5T2P6A
	+YAdjHEEZVkHQeNe0LkjF7Ug9+cMTkEqB+Gr29By0neuLgYnyy51
X-Google-Smtp-Source: AGHT+IE+A9/Dr8Nx8WEXZN+Tmm+M3RHgr5pUAvqyPbE+ijUanCZ5yGHMw89D119EVJqCJ4VTZNEJvw==
X-Received: by 2002:a05:6871:286:b0:25e:2748:3fe6 with SMTP id 586e51a60fabf-25eae8327e6mr880997fac.29.1720490871808;
        Mon, 08 Jul 2024 19:07:51 -0700 (PDT)
Received: from [172.19.1.51] (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b439b54fesm578426b3a.173.2024.07.08.19.07.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jul 2024 19:07:51 -0700 (PDT)
Message-ID: <1f3c8a6a-fb6d-4b61-a6ec-7e0e31c7dbf4@gmail.com>
Date: Tue, 9 Jul 2024 10:07:45 +0800
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] mmc: sdhci-of-ma35d1: Add Nuvoton MA35D1 SDHCI
 driver
To: Krzysztof Kozlowski <krzk@kernel.org>, ulf.hansson@linaro.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 adrian.hunter@intel.com, p.zabel@pengutronix.de, pbrobinson@gmail.com,
 serghox@gmail.com, mcgrof@kernel.org,
 prabhakar.mahadev-lad.rj@bp.renesas.com, forbidden405@outlook.com,
 tmaimon77@gmail.com, andy.shevchenko@gmail.com,
 linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: ychuang3@nuvoton.com, schung@nuvoton.com
References: <20240704062623.1480062-1-shanchun1218@gmail.com>
 <20240704062623.1480062-3-shanchun1218@gmail.com>
 <30cb5871-71f1-4b62-91fc-489519125bc2@kernel.org>
Content-Language: en-US
From: Shan-Chun Hung <shanchun1218@gmail.com>
In-Reply-To: <30cb5871-71f1-4b62-91fc-489519125bc2@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Krzysztof,

Thank you for your review.

On 2024/7/8 下午 10:25, Krzysztof Kozlowski wrote:
> On 04/07/2024 08:26, Shan-Chun Hung wrote:
>> Add the SDHCI driver for the MA35D1 platform. It is based upon the
>> SDHCI interface, but requires some extra initialization.
>>
>> Signed-off-by: Shan-Chun Hung <shanchun1218@gmail.com>
>> ---
>>   drivers/mmc/host/Kconfig           |  12 ++
>>   drivers/mmc/host/Makefile          |   1 +
>>   drivers/mmc/host/sdhci-of-ma35d1.c | 297 +++++++++++++++++++++++++++++
>>   3 files changed, 310 insertions(+)
>>   create mode 100644 drivers/mmc/host/sdhci-of-ma35d1.c
>>
>> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
>> index bb0d4fb0892a..aa6922ff4210 100644
>> --- a/drivers/mmc/host/Kconfig
>> +++ b/drivers/mmc/host/Kconfig
>> @@ -252,6 +252,18 @@ config MMC_SDHCI_OF_SPARX5
>>
>>   	  If unsure, say N.
>>
>> +config MMC_SDHCI_OF_MA35D1
>> +	tristate "SDHCI OF support for the MA35D1 SDHCI controller"
>> +	depends on ARCH_MA35 || COMPILE_TEST
>> +	depends on MMC_SDHCI_PLTFM
>> +	help
>> +	  This selects the MA35D1 Secure Digital Host Controller Interface.
>> +	  The controller supports SD/MMC/SDIO devices.
>> +
>> +	  If you have a controller with this interface, say Y or M here.
>> +
>> +	  If unsure, say N.
>> +
>>   config MMC_SDHCI_CADENCE
>>   	tristate "SDHCI support for the Cadence SD/SDIO/eMMC controller"
>>   	depends on MMC_SDHCI_PLTFM
>> diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
>> index f53f86d200ac..3ccffebbe59b 100644
>> --- a/drivers/mmc/host/Makefile
>> +++ b/drivers/mmc/host/Makefile
>> @@ -88,6 +88,7 @@ obj-$(CONFIG_MMC_SDHCI_OF_ESDHC)	+= sdhci-of-esdhc.o
>>   obj-$(CONFIG_MMC_SDHCI_OF_HLWD)		+= sdhci-of-hlwd.o
>>   obj-$(CONFIG_MMC_SDHCI_OF_DWCMSHC)	+= sdhci-of-dwcmshc.o
>>   obj-$(CONFIG_MMC_SDHCI_OF_SPARX5)	+= sdhci-of-sparx5.o
>> +obj-$(CONFIG_MMC_SDHCI_OF_MA35D1)	+= sdhci-of-ma35d1.o
>>   obj-$(CONFIG_MMC_SDHCI_BCM_KONA)	+= sdhci-bcm-kona.o
>>   obj-$(CONFIG_MMC_SDHCI_IPROC)		+= sdhci-iproc.o
>>   obj-$(CONFIG_MMC_SDHCI_NPCM)		+= sdhci-npcm.o
>> diff --git a/drivers/mmc/host/sdhci-of-ma35d1.c b/drivers/mmc/host/sdhci-of-ma35d1.c
>> new file mode 100644
>> index 000000000000..b5aab65b9093
>> --- /dev/null
>> +++ b/drivers/mmc/host/sdhci-of-ma35d1.c
>> @@ -0,0 +1,297 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +/*
>> + * Copyright (C) 2024 Nuvoton Technology Corp.
>> + *
>> + * Author: Shan-Chun Hung <shanchun1218@gmail.com>
>> + */
>> +
>> +#include <linux/align.h>
>> +#include <linux/array_size.h>
>> +#include <linux/bits.h>
>> +#include <linux/build_bug.h>
>> +#include <linux/clk.h>
>> +#include <linux/delay.h>
>> +#include <linux/dev_printk.h>
>> +#include <linux/device.h>
>> +#include <linux/dma-mapping.h>
>> +#include <linux/err.h>
>> +#include <linux/math.h>
>> +#include <linux/mfd/syscon.h>
>> +#include <linux/minmax.h>
>> +#include <linux/mmc/card.h>
>> +#include <linux/mmc/host.h>
>> +#include <linux/mod_devicetable.h>
>> +#include <linux/module.h>
>> +#include <linux/pinctrl/consumer.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/regmap.h>
>> +#include <linux/reset.h>
>> +#include <linux/sizes.h>
>> +#include <linux/types.h>
>> +
>> +#include "sdhci-pltfm.h"
>> +#include "sdhci.h"
>> +
>> +#define MA35_SYS_MISCFCR0	0x070
>> +#define MA35_SDHCI_MSHCCTL	0x508
>> +#define MA35_SDHCI_MBIUCTL	0x510
>> +
>> +#define MA35_SDHCI_CMD_CONFLICT_CHK	BIT(0)
>> +#define MA35_SDHCI_INCR_MSK		GENMASK(3, 0)
>> +#define MA35_SDHCI_INCR16		BIT(3)
>> +#define MA35_SDHCI_INCR8		BIT(2)
>> +
>> +struct ma35_priv {
>> +	struct regmap		*regmap;
> Drop, you don't use it.
I will remove it and use local variables instead.
>
>> +	struct reset_control	*rst;
>> +	struct pinctrl		*pinctrl;
>> +	struct pinctrl_state	*pins_uhs;
>> +	struct pinctrl_state	*pins_default;
>> +};
>> +
>> +struct ma35_restore_data {
>> +	u32	reg;
>> +	u32	width;
>> +};
>> +
> ...
>
>> +
>> +static int ma35_probe(struct platform_device *pdev)
>> +{
>> +	struct device *dev = &pdev->dev;
>> +	struct sdhci_pltfm_host *pltfm_host;
>> +	struct sdhci_host *host;
>> +	struct ma35_priv *priv;
>> +	int err;
>> +	u32 extra, ctl;
>> +
>> +	host = sdhci_pltfm_init(pdev, &sdhci_ma35_pdata, sizeof(struct ma35_priv));
>> +	if (IS_ERR(host))
>> +		return PTR_ERR(host);
>> +
>> +	/* Extra adma table cnt for cross 128M boundary handling. */
>> +	extra = DIV_ROUND_UP_ULL(dma_get_required_mask(dev), SZ_128M);
>> +	extra = min(extra, SDHCI_MAX_SEGS);
>> +
>> +	host->adma_table_cnt += extra;
>> +	pltfm_host = sdhci_priv(host);
>> +	priv = sdhci_pltfm_priv(pltfm_host);
>> +
>> +	pltfm_host->clk = devm_clk_get_optional_enabled(dev, NULL);
>> +	if (IS_ERR(pltfm_host->clk)) {
>> +		err = PTR_ERR(pltfm_host->clk);
>> +		dev_err_probe(dev, err, "failed to get clk\n");
> Syntax is err = dev_err_probe()
I will fix it.
>> +		goto err_sdhci;
>> +	}
>> +
>> +	err = mmc_of_parse(host->mmc);
>> +	if (err)
>> +		goto err_sdhci;
>> +
>> +	priv->rst = devm_reset_control_get_exclusive(dev, NULL);
>> +	if (IS_ERR(priv->rst)) {
>> +		err = PTR_ERR(priv->rst);
>> +		dev_err_probe(dev, err, "failed to get reset control\n");
> err = dev_err_probe
>
> ... so all your previous versions were leaking memory. Double check your
> error paths.
I will fix it and make sure to double check the error paths.
>> +		goto err_sdhci;
>> +	}
>> +
>> +	sdhci_get_of_property(pdev);
>> +
> Best regards,
> Krzysztof

Best Regards,

Shan-Chun

