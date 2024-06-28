Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44607D27E;
	Fri, 28 Jun 2024 06:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719556216; cv=none; b=a+9MryD2hF3+trTx3OQJNMjicCt36xX03ONtE8N0KBlAuxok9RePJ/yvR1ineoA0ZroR3jJ8mKUHqObzhtvt0Gg85qaznVf24UgmdkDyf3K/YZOyPj2+JrnBSKLuoFGk3CajnOISMKECi6p88PRX4iBSXKqJKQSXnVn6Y2CKfLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719556216; c=relaxed/simple;
	bh=m7dw62S3Q6LB+PDEet0EmwIoMbvLLx7q9QgY3t818mg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d1VI6OYfrCRQiLWaJ2lXT0P8N5iKZ4A20Av7aK/YWgbgZbtfEKoH1nP0JKfvykpD8r1WXuRwwzcXeE4eRkPs5GUJtOKvD5i/qcxo/Xx9xa3MchxUzHvIB0/olvP0kmAMEnBXuFRh5jjyGOYz15SipPdCOu9V92vE3b86sUTBkqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fTuBTOP0; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fTuBTOP0"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1fab03d2eecso1533745ad.0;
        Thu, 27 Jun 2024 23:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719556211; x=1720161011; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eJI8CoegsQSblgaxpAcPY+GasAht7djCZBsspSkXw9E=;
        b=fTuBTOP03NN7zruZBWvml2cErWac73vPpw87uEp9kHpG01vuNyXK0jrzb0O1B3Iafi
         +zqhu8jjDlkGQze4akHrVCsIXLD4WP1O10GLli4omMoS9M2GGiH2QTCpbvuwVoUw/e1l
         hg0hU8QZ1sgyucZGXn4X7SwijeTqohEaZzXDWfD5Wgs1viKok+Ls8+ntJPzka6J97TGg
         O5OubxJGffqLLHlLvT2QhcnqNvLp7HA+Hqfg4nuahmD0cWZGPaVO7AvEHoNAXmJrrWAS
         EbamPE93JGg5S00fSlYFNrJ8TiFNLFfZhO4D9OjrbfztvZ6Lcd9e3VbCcK/ne56Jcj85
         9/JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719556211; x=1720161011;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eJI8CoegsQSblgaxpAcPY+GasAht7djCZBsspSkXw9E=;
        b=qJPakd1RCkwln8GglUO4ACfGr4IQWWhI9dBbqLWiXuEEC1JafQVYoVknYJh9Zd/6xh
         CryQSWQ8mKk1acs5jdvFH3Hli3LRdCjbgzNL6GeuzZMaarNFstN9NhcQ6OYLWz590VhB
         oVYa112Ad0st4tF5AD9K+LenD/ZZSQP4wUxBeIgKsWnVgVMa0wxzN3EfX841qT5X4zhI
         Mj76HIjiMjFbm0r2uJOhRc1bBbITVuwvQPDVCduUO3UVt3YOjplM2HND2ytYahAPNqyD
         Zsm1tGYZ2GjoqsGEh2/ZRZH543VT18pzqyCU3+nyl7khzW1/ZCJm6izZIwHnAhpzOD2i
         O+4Q==
X-Forwarded-Encrypted: i=1; AJvYcCU3QAIl+cR3H6+V0lj7W/NUwdY2TsyR064KwsSn57+bv1afORPPkmdJIlBXvQRsk8QJBh+AJWK8MEg0CB4bxMMUgb4fu7JuhWhvpxtrrZpQ5lPApKbP/XKDsPpCkD9cMvs+Rflurc6EHibrtW72tiPwsxSIPepyxcaVsKoMK2C1vhaMsQ==
X-Gm-Message-State: AOJu0Yxi/XEGej9fereKkjEzCdJFT6MVmR4cr7D42b11ew6qdeBgZGvX
	3Qqz14fnotch+nybmv6VpF2uLgfSP1KrrS8tccMXDZ739ujFbCIm
X-Google-Smtp-Source: AGHT+IEM9HmlqKw+KBqFk3dFjKHYTEj5153rd+m7gPASYexw8c59mqW7ztS8gsRU7dqMbSVjzm6lVA==
X-Received: by 2002:a17:902:c212:b0:1f9:f559:d8c8 with SMTP id d9443c01a7336-1fa1d3de5f8mr132827735ad.4.1719556211024;
        Thu, 27 Jun 2024 23:30:11 -0700 (PDT)
Received: from [172.19.1.51] (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac11d8ae4sm7777105ad.104.2024.06.27.23.30.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jun 2024 23:30:10 -0700 (PDT)
Message-ID: <f0ae92ec-ae2c-418d-9cfd-199e312e2c23@gmail.com>
Date: Fri, 28 Jun 2024 14:30:04 +0800
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] mmc: sdhci-of-ma35d1: Add Nuvoton MA35D1 SDHCI
 driver
To: Adrian Hunter <adrian.hunter@intel.com>, ulf.hansson@linaro.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 p.zabel@pengutronix.de, pbrobinson@gmail.com, serghox@gmail.com,
 mcgrof@kernel.org, prabhakar.mahadev-lad.rj@bp.renesas.com,
 forbidden405@outlook.com, tmaimon77@gmail.com, andy.shevchenko@gmail.com,
 linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: ychuang3@nuvoton.com, schung@nuvoton.com
References: <20240626094900.581552-1-shanchun1218@gmail.com>
 <20240626094900.581552-3-shanchun1218@gmail.com>
 <216059e5-2160-4797-b431-b391ff69cd2c@intel.com>
Content-Language: en-US
From: Shan-Chun Hung <shanchun1218@gmail.com>
In-Reply-To: <216059e5-2160-4797-b431-b391ff69cd2c@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Adrian,

Thanks for your review.

On 2024/6/27 下午 05:40, Adrian Hunter wrote:
> On 26/06/24 12:49, Shan-Chun Hung wrote:
>> Add the SDHCI driver for the MA35D1 platform. It is based upon the
>> SDHCI interface, but requires some extra initialization.
>>
>> Signed-off-by: Shan-Chun Hung <shanchun1218@gmail.com>
>> ---
>>   drivers/mmc/host/Kconfig           |  14 ++
>>   drivers/mmc/host/Makefile          |   1 +
>>   drivers/mmc/host/sdhci-of-ma35d1.c | 291 +++++++++++++++++++++++++++++
>>   3 files changed, 306 insertions(+)
>>   create mode 100644 drivers/mmc/host/sdhci-of-ma35d1.c
>>
>> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
>> index bb0d4fb0892a..31cd076e1c53 100644
>> --- a/drivers/mmc/host/Kconfig
>> +++ b/drivers/mmc/host/Kconfig
>> @@ -252,6 +252,20 @@ config MMC_SDHCI_OF_SPARX5
>>
> Patch did not apply cleanly:
>
> Applying: mmc: sdhci-of-ma35d1: Add Nuvoton MA35D1 SDHCI driver
> error: corrupt patch at line 14
> Patch failed at 0001 mmc: sdhci-of-ma35d1: Add Nuvoton MA35D1 SDHCI driver
I will fix it.
>> 	  If unsure, say N.
>>
>> +config MMC_SDHCI_OF_MA35D1
>> +	tristate "SDHCI OF support for the MA35D1 SDHCI controller"
>> +	depends on ARCH_MA35
> Does this dependency serve a purpose?  At least add COMPILE_TEST
>
> 	depends on ARCH_MA35 || COMPILE_TEST
I will modify "depends on ARCH_MA35 || COMPILE_TEST"
>> +	depends on MMC_SDHCI_PLTFM
>> +	depends on COMMON_CLK
>> +	depends on OF || COMPILE_TEST
>> +	help
>> +	  This selects the MA35D1 Secure Digital Host Controller Interface.
>> +
>> +	  If you have a controller with this interface, say Y or M here. You
>> +	  also need to enable an appropriate bus interface.
>> +
>> +	  If unsure, say N.
>> +
>>   config MMC_SDHCI_CADENCE
>> 	tristate "SDHCI support for the Cadence SD/SDIO/eMMC controller"
>> 	depends on MMC_SDHCI_PLTFM
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
>> index 000000000000..e260aeb12d7f
>> --- /dev/null
>> +++ b/drivers/mmc/host/sdhci-of-ma35d1.c
>> @@ -0,0 +1,291 @@
>> +// SPDX-License-Identifier: GPL-2.0
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
>> +static const struct ma35_restore_data restore_data[] = {
>> +	{ SDHCI_CLOCK_CONTROL,		sizeof(u32)},
>> +	{ SDHCI_BLOCK_SIZE,		sizeof(u32)},
>> +	{ SDHCI_INT_ENABLE,		sizeof(u32)},
>> +	{ SDHCI_SIGNAL_ENABLE,		sizeof(u32)},
>> +	{ SDHCI_AUTO_CMD_STATUS,	sizeof(u32)},
>> +	{ SDHCI_HOST_CONTROL,		sizeof(u32)},
>> +	{ SDHCI_TIMEOUT_CONTROL,	sizeof(u8) },
>> +	{ MA35_SDHCI_MSHCCTL,		sizeof(u16)},
>> +	{ MA35_SDHCI_MBIUCTL,		sizeof(u16)},
>> +};
>> +
>> +/*
>> + * If DMA addr spans 128MB boundary, we split the DMA transfer into two
>> + * so that each DMA transfer doesn't exceed the boundary.
>> + */
>> +static void ma35_adma_write_desc(struct sdhci_host *host, void **desc,
>> +				  dma_addr_t addr, int len, unsigned int cmd)
> Please take a look at checkpatch --strict output.  Fixing "Alignment" and
> "spaces preferred around" CHECKs tends to make the code look better.
I will fix it.
>> +{
>> +	int tmplen, offset;
>> +
>> +	if (likely(!len || (ALIGN(addr, SZ_128M) == ALIGN(addr+len-1, SZ_128M)))) {
>> +		sdhci_adma_write_desc(host, desc, addr, len, cmd);
>> +		return;
>> +	}
>> +
>> +	offset = addr & (SZ_128M - 1);
>> +	tmplen = SZ_128M - offset;
>> +	sdhci_adma_write_desc(host, desc, addr, tmplen, cmd);
>> +
>> +	addr += tmplen;
>> +	len -= tmplen;
>> +	sdhci_adma_write_desc(host, desc, addr, len, cmd);
>> +}
>> +
>> +static void ma35_set_clock(struct sdhci_host *host, unsigned int clock)
>> +{
>> +	u32 ctl;
>> +
>> +	/* If the clock frequency exceeds MMC_HIGH_52_MAX_DTR,
>> +	 * disable command conflict check.
>> +	 */
> Please use the following style for multi-line comments:
>
> 	/*
> 	 * If the clock frequency exceeds MMC_HIGH_52_MAX_DTR,
> 	 * disable command conflict check.
> 	 */
I will fix it.
>> +	ctl = sdhci_readw(host, MA35_SDHCI_MSHCCTL);
>> +	if (clock > MMC_HIGH_52_MAX_DTR)
>> +		ctl &= ~MA35_SDHCI_CMD_CONFLICT_CHK;
>> +	else
>> +		ctl |= MA35_SDHCI_CMD_CONFLICT_CHK;
>> +	sdhci_writew(host, ctl, MA35_SDHCI_MSHCCTL);
>> +
>> +	sdhci_set_clock(host, clock);
>> +}
>> +
>> +static int ma35_start_signal_voltage_switch(struct mmc_host *mmc,
>> +					      struct mmc_ios *ios)
>> +{
>> +	struct sdhci_host *host = mmc_priv(mmc);
>> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>> +	struct ma35_priv *priv = sdhci_pltfm_priv(pltfm_host);
>> +
>> +	switch (ios->signal_voltage) {
>> +	case MMC_SIGNAL_VOLTAGE_180:
>> +		if (!IS_ERR(priv->pinctrl) && !IS_ERR(priv->pins_uhs))
>> +			pinctrl_select_state(priv->pinctrl, priv->pins_uhs);
>> +		break;
>> +	case MMC_SIGNAL_VOLTAGE_330:
>> +		if (!IS_ERR(priv->pinctrl) && !IS_ERR(priv->pins_default))
>> +			pinctrl_select_state(priv->pinctrl, priv->pins_default);
>> +		break;
>> +	default:
>> +		dev_err(mmc_dev(host->mmc), "Unsupported signal voltage!\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	return sdhci_start_signal_voltage_switch(mmc, ios);
>> +}
>> +
>> +static void ma35_voltage_switch(struct sdhci_host *host)
>> +{
>> +	/* Wait for 5ms after set 1.8V signal enable bit */
>> +	fsleep(5000);
>> +}
>> +
>> +static int ma35_execute_tuning(struct mmc_host *mmc, u32 opcode)
>> +{
>> +	struct sdhci_host *host = mmc_priv(mmc);
>> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>> +	struct ma35_priv *priv = sdhci_pltfm_priv(pltfm_host);
>> +	int idx;
>> +	u32 regs[ARRAY_SIZE(restore_data)] = { };
>> +
>> +	/* Limitations require a reset of SD/eMMC before tuning and
>> +	 * saving the registers before resetting, then restoring
>> +	 * after the reset.
>> +	 */
> Please use the following style for multi-line comments:
>
> 	/*
> 	 * Limitations require a reset of SD/eMMC before tuning and
> 	 * saving the registers before resetting, then restoring
> 	 * after the reset.
> 	 */
I will fix it.
>> +	for (idx = 0; idx < ARRAY_SIZE(restore_data); idx++) {
>> +		if (restore_data[idx].width == sizeof(u32))
>> +			regs[idx] = sdhci_readl(host, restore_data[idx].reg);
>> +		else if (restore_data[idx].width == sizeof(u16))
>> +			regs[idx] = sdhci_readw(host, restore_data[idx].reg);
>> +		else if (restore_data[idx].width == sizeof(u8))
>> +			regs[idx] = sdhci_readb(host, restore_data[idx].reg);
>> +	}
>> +
>> +	reset_control_assert(priv->rst);
>> +	reset_control_deassert(priv->rst);
>> +
>> +	for (idx = 0; idx < ARRAY_SIZE(restore_data); idx++) {
>> +		if (restore_data[idx].width == sizeof(u32))
>> +			sdhci_writel(host, regs[idx], restore_data[idx].reg);
>> +		else if (restore_data[idx].width == sizeof(u16))
>> +			sdhci_writew(host, regs[idx], restore_data[idx].reg);
>> +		else if (restore_data[idx].width == sizeof(u8))
>> +			sdhci_writeb(host, regs[idx], restore_data[idx].reg);
>> +	}
>> +
>> +	return sdhci_execute_tuning(mmc, opcode);
>> +}
>> +
>> +static const struct sdhci_ops sdhci_ma35_ops = {
>> +	.set_clock		= ma35_set_clock,
>> +	.set_bus_width		= sdhci_set_bus_width,
>> +	.set_uhs_signaling	= sdhci_set_uhs_signaling,
>> +	.get_max_clock		= sdhci_pltfm_clk_get_max_clock,
>> +	.reset			= sdhci_reset,
>> +	.adma_write_desc	= ma35_adma_write_desc,
>> +	.voltage_switch	= ma35_voltage_switch,
> Last one does not line up
I will fix it
>> +};
>> +
>> +static const struct sdhci_pltfm_data sdhci_ma35_pdata = {
>> +	.ops = &sdhci_ma35_ops,
>> +	.quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
>> +	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN | SDHCI_QUIRK2_BROKEN_DDR50 |
>> +		   SDHCI_QUIRK2_ACMD23_BROKEN,
>> +};
>> +
>> +static void ma35_sdhci_pltfm_free(void *data)
>> +{
>> +	sdhci_pltfm_free(data);
>> +}
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
>> +	err = devm_add_action_or_reset(dev, ma35_sdhci_pltfm_free, pdev);
> This just looks like it is going to call sdhci_pltfm_free()
> for a second time after it is called by sdhci_pltfm_remove()

During the testing process, we only simulated the scenario where 
ma35_probe() returned an error.

We overlooked the fact that sdhci_pltfm_remove would also be called when 
ma35_probe() succeeds.

This issue was confirmed through testing using the module method. I will 
fix it.

>> +	if (err)
>> +		return dev_err_probe(dev, err, "Failed to register sdhci_pltfm_free action\n");
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
>> +	if (IS_ERR(pltfm_host->clk))
>> +		return dev_err_probe(dev, IS_ERR(pltfm_host->clk), "failed to get clk\n");
>> +
>> +	err = mmc_of_parse(host->mmc);
>> +	if (err)
>> +		return err;
>> +
>> +	priv->rst = devm_reset_control_get_exclusive(dev, NULL);
>> +	if (IS_ERR(priv->rst))
>> +		return dev_err_probe(dev, PTR_ERR(priv->rst), "failed to get reset control\n");
>> +
>> +	sdhci_get_of_property(pdev);
>> +
>> +	priv->pinctrl = devm_pinctrl_get(dev);
>> +	if (!IS_ERR(priv->pinctrl)) {
>> +		priv->pins_default = pinctrl_lookup_state(priv->pinctrl, "default");
>> +		priv->pins_uhs = pinctrl_lookup_state(priv->pinctrl, "state_uhs");
>> +		pinctrl_select_state(priv->pinctrl, priv->pins_default);
>> +	}
>> +
>> +	if (!(host->quirks2 & SDHCI_QUIRK2_NO_1_8_V)) {
>> +		u32 reg;
>> +
>> +		priv->regmap = syscon_regmap_lookup_by_phandle(dev_of_node(dev), "nuvoton,sys");
>> +
>> +		if (!IS_ERR(priv->regmap)) {
>> +			/* Enable SDHCI voltage stable for 1.8V */
>> +			regmap_read(priv->regmap, MA35_SYS_MISCFCR0, &reg);
>> +			reg |= BIT(17);
>> +			regmap_write(priv->regmap, MA35_SYS_MISCFCR0, reg);
>> +		}
>> +
>> +		host->mmc_host_ops.start_signal_voltage_switch =
>> +					ma35_start_signal_voltage_switch;
>> +	}
>> +
>> +	host->mmc_host_ops.execute_tuning = ma35_execute_tuning;
>> +
>> +	err = sdhci_add_host(host);
>> +	if (err)
>> +		return err;
>> +
>> +	/* Enable INCR16 and INCR8 */
> Comment would be more useful if it said what INCR16 and
> INCR8 are

I will modify as follows:

/*
  * Split data into chunks of 16 or 8 bytes for sending.
  * Each chunk transfer is guaranteed to be uninterrupted on the bus.
  */

>> +	ctl = sdhci_readw(host, MA35_SDHCI_MBIUCTL);
>> +	ctl &= ~MA35_SDHCI_INCR_MSK;
>> +	ctl |= MA35_SDHCI_INCR16|MA35_SDHCI_INCR8;
>> +	sdhci_writew(host, ctl, MA35_SDHCI_MBIUCTL);
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct of_device_id sdhci_ma35_dt_ids[] = {
>> +	{ .compatible = "nuvoton,ma35d1-sdhci" },
>> +	{}
>> +};
>> +
>> +static struct platform_driver sdhci_ma35_driver = {
>> +	.driver	= {
>> +		.name	= "sdhci-ma35",
>> +		.of_match_table = sdhci_ma35_dt_ids,
>> +	},
>> +	.probe	= ma35_probe,
>> +	.remove_new = sdhci_pltfm_remove,
>> +};
>> +module_platform_driver(sdhci_ma35_driver);
>> +
>> +MODULE_DESCRIPTION("SDHCI platform driver for Nuvoton MA35");
>> +MODULE_AUTHOR("Shan-Chun Hung <shanchun1218@google.com>");
> "From:" is shanchun1218@gmail.com
> "Signed-off-by" is shanchun1218@gmail.com
>
> but here it is shanchun1218@google.com
>
> Please be consistent
I will fix it.
>
>> +MODULE_LICENSE("GPL v2");
> checkpatch says:
>
> WARNING: Prefer "GPL" over "GPL v2" - see commit bf7fbeeae6db ("module: Cure the MODULE_LICENSE "GPL" vs. "GPL v2" bogosity")
> #351: FILE: drivers/mmc/host/sdhci-of-ma35d1.c:291:
> +MODULE_LICENSE("GPL v2");
I will fix it.
>> --
>> 2.25.1

Best Regards,

Shan-Chun

