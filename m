Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D090616D4C7;
	Fri, 21 Jun 2024 08:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718957217; cv=none; b=uzkMpGWBoAw49Nd+p7RUxLSM6b5YD9wIZ4ShwXGMGHDsJFuBwj8TiZjvyYQn8SHeiTs4rPe55j6IkBIHZ0jXsPvNIwLJA+aJKcSH0v4ECNAEb86wkwHMxECNAgvi0K1tUmIObOrCybRuY3eUleYcpx+PBKzmJNFs8KvC2hy+ZZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718957217; c=relaxed/simple;
	bh=YU7O6AGOx12tvKfqFO4NbDrfDBd6CzF/8qv8GE1w1uM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=LvKwPDehe8zA7R9VNLl0kkQ46D8N8IUlp+jlJmJcSDMnMMmLV3sfj01QOrHxdkO35m1UglKCKl3liZCt2oC8lAdKmbtvpPathQ7zFGofjMKSZgi4G5qNoMsh+JXILWobsrguFaiN2IHQrKzIzJIormrCMj/jYqLF563oa2tmRgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bsFWwRLO; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bsFWwRLO"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-6f8ef63714cso982426a34.1;
        Fri, 21 Jun 2024 01:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718957215; x=1719562015; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AvWL0wj3A/i0gS74gMUgMtb/mv9EjdRvYDNJx0i61hc=;
        b=bsFWwRLOoGwn7cQVnNAJ0n6TgW0c5vwN17m4Nv8SQJeroSwsem08qjRX59tUAf45GN
         4ve1vJ6O/blElvedr6tFGm+Z08giN0loIKNHwrRnmJAE6GMIbLLcDsiHE+G6Hp3VjIcO
         89L0+rrRzNFCB4MEtPSLd87a8vJcaNichNSx19KRme70LgBoQg8NHM14G+Neym6LF6QL
         0t1Wb5rDraflLzDR7FY42HpIi9nJEtifoW4vOZgpJeSy7BAFDVkq8T81y5Y+7ZMXSdMI
         C1QdVVVQ01CVjCEtUmQgEsJDH1hGi/CkZPzy2UqT7lWcuekP0nXFrjMzmjJC9q9SH6bv
         5Qgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718957215; x=1719562015;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AvWL0wj3A/i0gS74gMUgMtb/mv9EjdRvYDNJx0i61hc=;
        b=bbtDPveuSOf5q/HlX15orrVG7gWTygTEo5A8y6BY+LSQKlW5PFHM/jwBgCMeQfazOh
         qn8m4kYPg0804S+Dw0yDbjY+Q7S1IG5LiYhNZyO5JvLhdS4GvZUrtlHh2RNnauLv4t40
         +OCwOyEbXMNUqa7HLio58uz9eg81l3WM/IhbD9TkMvAggAh3+O0R75x0oC5iuejTAMRo
         apnXdLzxjRNKSAL1OwiOMrrALm1Ltkwf6NpcfLaymh4VJWMC5IWRJZl5pwhyQ3N3FdtM
         KdVbYn8yj1X5/s08745C0mLyxi0ZaxdPzT7Hw/xR/JZugnOcwn7AvSNWwVyuC8jrdKTa
         Y3fQ==
X-Forwarded-Encrypted: i=1; AJvYcCV8xXHpyaSxPbNCqrDP0gqF9DEwVAipCZYUcfbblOp5B9YdsK7f787QG/JbRtTZzUX0cbBuOhycF2m0pCtOlvKlEXzt1O8ACQrT2RuJN8uL07ItoCYbcyzkLAXJDh/lJYbl/BxPR+9gM2pUVF5BGNQWMaWjtFq1/RBtT6VTt6R+loQa9w==
X-Gm-Message-State: AOJu0YynFqaWMtKb0P4MXYLOGOMwHXS0071ER7E/esy5Ls8jhXbRCx9p
	EjtfnS9CPeC1VE21YDKd6uSz2f6T1gTAoQOLMpO9paCtsnjIaEoi
X-Google-Smtp-Source: AGHT+IGNxn3y66ounzSsDGs7VdmSG+BnCQ7CjXvUV2vuZifwOgwlSEySSHcFYeSH0KDy0+wtbHUz3A==
X-Received: by 2002:a05:6870:c14f:b0:258:42c1:2523 with SMTP id 586e51a60fabf-25c94a67c23mr8415683fac.18.1718957214669;
        Fri, 21 Jun 2024 01:06:54 -0700 (PDT)
Received: from [172.19.1.51] (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70651192a4csm824304b3a.54.2024.06.21.01.06.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jun 2024 01:06:54 -0700 (PDT)
Message-ID: <1e249c77-def1-4ffc-bbd6-d64f7e95b0ac@gmail.com>
Date: Fri, 21 Jun 2024 16:06:49 +0800
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Shan-Chun Hung <shanchun1218@gmail.com>
Subject: Re: [PATCH 2/2] mmc: sdhci-of-ma35d1: Add Novoton MA35D1 SDHCI driver
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: ulf.hansson@linaro.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, adrian.hunter@intel.com, p.zabel@pengutronix.de,
 pbrobinson@gmail.com, serghox@gmail.com, mcgrof@kernel.org,
 prabhakar.mahadev-lad.rj@bp.renesas.com, forbidden405@outlook.com,
 tmaimon77@gmail.com, linux-arm-kernel@lists.infradead.org,
 linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, ychuang3@nuvoton.com, schung@nuvoton.com
References: <20240619054641.277062-1-shanchun1218@gmail.com>
 <20240619054641.277062-3-shanchun1218@gmail.com>
 <CAHp75VcJGoDaAbD7vWin8yTGarrLZbVQqucHs+M9rAAS0BZd9g@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAHp75VcJGoDaAbD7vWin8yTGarrLZbVQqucHs+M9rAAS0BZd9g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Andy,

Thanks for your review.

On 2024/6/20 上午 03:09, Andy Shevchenko wrote:
> On Wed, Jun 19, 2024 at 7:47 AM Shan-Chun Hung<shanchun1218@gmail.com>  wrote:
>> This adds the SDHCI driver for the MA35 series SoC. It is based upon the
>> SDHCI interface, but requires some extra initialization.
>>
>> Signed-off-by: schung<schung@nuvoton.com>
> Even I agree with Markus' remarks, so please correct your SoB by using
> something similar to the From line.
I will fix it.
>
> ...
>
>> +config MMC_SDHCI_OF_MA35D1
>> +       tristate "SDHCI OF support for the MA35D1 SDHCI controller"
>> +       depends on ARCH_A35 || COMPILE_TEST
>> +       depends on MMC_SDHCI_PLTFM
>> +       depends on OF && COMMON_CLK
> OF is not compile dependency AFAICS, if you want make it functional, use
>
>    depends on OF || COMPILE_TEST
>
> ...
>
> You are missing a lot of header inclusions, please follow IWYU principle.
I am not familiar with IWYU yet, but I will learn it and use it for 
checks later on.

For new, I am adding these header files.

> + array_size.h
> + bits.h
>
>> +#include <linux/clk.h>
> + device.h
>
>> +#include <linux/dma-mapping.h>
> + err.h
>
>> +#include <linux/mfd/syscon.h>
> + math.h
> + mod_devicetable.h
>
>> +#include <linux/module.h>
>> +#include <linux/mmc/mmc.h>
>> +#include <linux/pinctrl/consumer.h>
> + platform_device.h
>
>> +#include <linux/regmap.h>
>> +#include <linux/reset.h>
>> +#include <linux/slab.h>
> + types.h
> ...
>
>> +#define BOUNDARY_OK(addr, len) \
>> +       ((addr | (SZ_128M - 1)) == ((addr + len - 1) | (SZ_128M - 1)))
> Besides sizes.h being missed, this can be done with help of ALIGN()
> macro (or alike). So, kill this and use the globally defined macro
> inline.
I will add sizes.h and directly apply globally defined  ALIGN() macro 
instead
> ...
>
>> +       /* If the clock frequency exceeds MMC_HIGH_52_MAX_DTR,
>> +        *      disable command conflict check.
>> +        */
>    /*
>     * The comment style is wrong and
>     * the indentation in the second line.
>     * Fix it as in this example.
>     */
>
> ...
I will fix it.
>> +static void ma35_voltage_switch(struct sdhci_host *host)
>> +{
>> +       /* Wait for 5ms after set 1.8V signal enable bit */
>> +       usleep_range(5000, 5500);
> Use fsleep()
I will use fsleep() instead of usleep_range().
>> +}
>> +
>> +static int ma35_execute_tuning(struct mmc_host *mmc, u32 opcode)
>> +{
>> +       struct sdhci_host *host = mmc_priv(mmc);
>> +       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>> +       struct ma35_priv *priv = sdhci_pltfm_priv(pltfm_host);
>> +
>> +       /* Limitations require a reset SD/eMMC before tuning. */
>> +       if (!IS_ERR(priv->rst)) {
> It's way too big for indentation, moreover it uses an unusual pattern,
> usually we check for an error case first. So, invert the conditional
> and this all code will become much better.
I will fix it.
>> +               int idx;
>> +               u32 *val;
>> +
>> +               val = kmalloc(ARRAY_SIZE(restore_data), GFP_KERNEL);
>> +               for (idx = 0; idx < ARRAY_SIZE(restore_data); idx++) {
>> +                       if (restore_data[idx].width == 32)
> sizeof(u32) ?
Your idea is better, I will change it.
>> +                               val[idx] = sdhci_readl(host, restore_data[idx].reg);
>> +                       else if (restore_data[idx].width == 8)
> sizeof(u8) ?
I will fix it.
>> +                               val[idx] = sdhci_readb(host, restore_data[idx].reg);
>> +               }
>> +
>> +               reset_control_assert(priv->rst);
>> +               reset_control_deassert(priv->rst);
>> +
>> +               for (idx = 0; idx < ARRAY_SIZE(restore_data); idx++) {
>> +                       if (restore_data[idx].width == 32)
>> +                               sdhci_writel(host, val[idx], restore_data[idx].reg);
>> +                       else if (restore_data[idx].width == 8)
>> +                               sdhci_writeb(host, val[idx], restore_data[idx].reg);
> As per above?
I will fix it.
>> +               }
>> +
>> +               kfree(val);
>> +       }
>> +
>> +       return sdhci_execute_tuning(mmc, opcode);
>> +}
> ...
>
>> +static int ma35_probe(struct platform_device *pdev)
>> +{
>> +       struct device *dev = &pdev->dev;
> Since you have it, use it!
I will use "dev" instead of "&pdev->dev".
>> +       struct sdhci_pltfm_host *pltfm_host;
>> +       struct sdhci_host *host;
>> +       struct ma35_priv *priv;
>> +       int err;
>> +       u32 extra, ctl;
>> +
>> +       host = sdhci_pltfm_init(pdev, &sdhci_ma35_pdata,
>> +                               sizeof(struct ma35_priv));
> One line?
I will fix it.
>> +       if (IS_ERR(host))
>> +               return PTR_ERR(host);
>> +
>> +       /*
>> +        * extra adma table cnt for cross 128M boundary handling.
>> +        */
> Wrong comment style.
I will fix it.
>> +       extra = DIV_ROUND_UP_ULL(dma_get_required_mask(&pdev->dev), SZ_128M);
>> +       if (extra > SDHCI_MAX_SEGS)
>> +               extra = SDHCI_MAX_SEGS;
> min() ? clamp() ?
I will use min() macro to fix it
>> +       host->adma_table_cnt += extra;
>> +       pltfm_host = sdhci_priv(host);
>> +       priv = sdhci_pltfm_priv(pltfm_host);
>> +       if (dev->of_node) {
> Why?
I will remove the "if ..."
>> +               pltfm_host->clk = devm_clk_get(&pdev->dev, NULL);
>> +               if (IS_ERR(pltfm_host->clk)) {
>> +                       err = PTR_ERR(pltfm_host->clk);
>> +                       dev_err(&pdev->dev, "failed to get clk: %d\n", err);
> Use
>
>    return dev_err_probe(...);
I will use dev_err_probe() instead of dev_err()
>> +                       goto free_pltfm;
> This is wrong. You may not call non-devm before devm ones, otherwise
> it makes a room for subtle mistakes on remove-probe or unbind-bind
> cycles. Have you tested that?
I have tested it, there is no error messages during driver initial process.

My thought is that sdhci_pltfm_init and sdhci_pltfm_free are used together.

If there's any error after the successful execution of sdhci_pltfm_init, 
I'll use sdhci_pltfm_free.

I am not entirely sure if this answers your question.

>> +               }
>> +               err = clk_prepare_enable(pltfm_host->clk);
>> +               if (err)
>> +                       goto free_pltfm;
> Use _enabled variant of devm_clk_get() instead.
I will use devm_clk_get_optional_enabled() instead.
>> +       }
>> +
>> +       err = mmc_of_parse(host->mmc);
>> +       if (err)
>> +               goto err_clk;
>> +
>> +       priv->rst = devm_reset_control_get(&pdev->dev, NULL);
> No error check?!
I will add an error check.
>> +       sdhci_get_of_property(pdev);
>> +
>> +       priv->pinctrl = devm_pinctrl_get(&pdev->dev);
>> +       if (!IS_ERR(priv->pinctrl)) {
>> +               priv->pins_default = pinctrl_lookup_state(priv->pinctrl, "default");
>> +               priv->pins_uhs = pinctrl_lookup_state(priv->pinctrl, "state_uhs");
>> +               pinctrl_select_state(priv->pinctrl, priv->pins_default);
>> +       }
>> +
>> +       if (!(host->quirks2 & SDHCI_QUIRK2_NO_1_8_V)) {
>> +               u32 reg;
>> +
>> +               priv->regmap = syscon_regmap_lookup_by_phandle(
>> +                               pdev->dev.of_node, "nuvoton,sys");
> dev_of_node(dev)
I will fix it.
>> +
>> +               if (!IS_ERR(priv->regmap)) {
>> +                       /* Enable SDHCI voltage stable for 1.8V */
>> +                       regmap_read(priv->regmap, MA35_SYS_MISCFCR0, &reg);
>> +                       reg |= BIT(17);
>> +                       regmap_write(priv->regmap, MA35_SYS_MISCFCR0, reg);
>> +               }
>> +
>> +               host->mmc_host_ops.start_signal_voltage_switch =
>> +                                       ma35_start_signal_voltage_switch;
>> +       }
>> +
>> +       host->mmc_host_ops.execute_tuning = ma35_execute_tuning;
>> +
>> +       err = sdhci_add_host(host);
>> +       if (err)
>> +               goto err_clk;
>> +
>> +       /* Enable INCR16 and INCR8 */
>> +       ctl = sdhci_readw(host, MA35_SDHCI_MBIUCTL);
>> +       ctl &= ~MA35_SDHCI_INCR_MSK;
>> +       ctl |= MA35_SDHCI_INCR16|MA35_SDHCI_INCR8;
>> +       sdhci_writew(host, ctl, MA35_SDHCI_MBIUCTL);
>> +
>> +       return 0;
>> +err_clk:
>> +       clk_disable_unprepare(pltfm_host->clk);
> This will go with the _enabled variant being used.
I will use devm_clk_get_optional_enabled, so I will remove it.
>> +free_pltfm:
>> +       sdhci_pltfm_free(pdev);
> This should go to be correct in ordering.

I am not entirely sure if it is a similar to "goto free_pltfm;" issue.

>> +       return err;
>> +}
>> +
>> +static int ma35_remove(struct platform_device *pdev)
> Use remove_new callback.
I will fix it.
>> +{
>> +       struct sdhci_host *host = platform_get_drvdata(pdev);
>> +       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>> +
>> +       sdhci_remove_host(host, 0);
>> +       clk_disable_unprepare(pltfm_host->clk);
>> +       sdhci_pltfm_free(pdev);
> At least these two will go away as per probe error path.
I will use sdhci_pltfm_remove instead of  the ma35_remove.
>> +       return 0;
>> +}
> ...
>
>> +MODULE_AUTHOR("shanchun1218@google.com");
> Needs to be fixed as Markus said.
I will fix it.

Best Regards,

Shan-Chun

