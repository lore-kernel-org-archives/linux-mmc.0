Received: from mail-m49205.qiye.163.com (mail-m49205.qiye.163.com [45.254.49.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B911EA7F4
	for <linux-mmc@vger.kernel.org>; Fri, 27 Mar 2026 14:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774622964; cv=none; b=rt+dIAVDW4JnbPVHfiz98Ya+bkjJ3PaFRyB63XWPqgIsX7vchaT1VutMWtPUXAkCkrSh45lQEn0jHVsvXDT/s6ABATHFEawxtuAuxlJi2psdMOm+N8LoUkBZMkvI1w9OrIZ0KdWMxpjG+jOBgT2XtmQ7/Sd7bB0PhAAMlvuYkOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774622964; c=relaxed/simple;
	bh=13js6nVyDqrYB9wXeeF0IFazWNt8m9uLZNpBKx9yoEw=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=GpVh5kl/i8LTBuyN8cTOdNa3iVNM28Z+t5LVsLvxqJc79jp/fZUhID6CMx0Kh8/Bn+EjwGR1wurcpEzbE6BzjkMB8O4GIFtodo//AOXOGA4N4D2FKlF0eAZd456njLh98510RkPCxghcDcppgdCaHURfcVixkjeHWfdCRvRbv1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=ghVs/z5M; arc=none smtp.client-ip=45.254.49.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="ghVs/z5M"
Received: from [172.16.12.17] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 389397c21;
	Fri, 27 Mar 2026 21:33:38 +0800 (GMT+08:00)
Message-ID: <f3886e89-43ab-8eef-80bf-79d7d1e14812@rock-chips.com>
Date: Fri, 27 Mar 2026 21:33:36 +0800
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Cc: shawn.lin@rock-chips.com, linux-mmc@vger.kernel.org,
 linux-rockchip@lists.infradead.org, Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: sdhci-of-dwcmshc: Refactor Rockchip platform data
 for controller revisions
To: Adrian Hunter <adrian.hunter@intel.com>
References: <1774597872-179908-1-git-send-email-shawn.lin@rock-chips.com>
 <20fe4fbb-df3d-4fa3-a595-3f446520f50f@intel.com>
 <793af56e-3a2b-632e-ed18-9a2bc0844351@rock-chips.com>
 <481b7725-2ae6-420d-adeb-acdabd113962@intel.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <481b7725-2ae6-420d-adeb-acdabd113962@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9d2f801e7309cckunm866b5e0eca9412
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQkJDS1ZISBodSE0fHR1DSR1WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=ghVs/z5MQZXGsfSXGVjM8fDmxtPVqyK8/BKt8tcvRRcKj9wjNCkC6OujgFxJJ1QEs+QJhob/IjFXjca5bXFri3scKvBBa5fOG0Otr9KeNSvD55YCdcGdLTriFLhT3jQ2O7RM4K7vkgTCL32pB6LemzadAH2CWCvoMOAXMiD6x7c=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=d4hgngE6+fvjsI9OO8NcKrlZNVZTrgs8cP5PNC0IYxs=;
	h=date:mime-version:subject:message-id:from;

在 2026/03/27 星期五 19:34, Adrian Hunter 写道:
> On 27/03/2026 13:28, Shawn Lin wrote:
>> Hi Adrian
>>
>> 在 2026/03/27 星期五 17:29, Adrian Hunter 写道:
>>> On 27/03/2026 09:51, Shawn Lin wrote:
>>>> The driver previously used an enum (dwcmshc_rk_type) to distinguish
>>>> platforms like the RK3568 and RK3588 based on DT compatible names.
>>>> This approach is inflexible, scales poorly for future revisions or
>>>> mixed-revision platforms, and conflates SoC names with controller
>>>> revisions.
>>>>
>>>> Introduces a new struct rockchip_pltfm_data containing a dedicated
>>>> revision field. The old enum is removed, and all code paths are
>>>> updated to use the revision-based data.
>>>>
>>>> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
>>>> ---
>>>>
>>>>    drivers/mmc/host/sdhci-of-dwcmshc.c | 87 ++++++++++++++++++++++---------------
>>>>    1 file changed, 52 insertions(+), 35 deletions(-)
>>>>
>>>> diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
>>>> index a91b3e7..6b43ba9 100644
>>>> --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
>>>> +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
>>>> @@ -278,14 +278,8 @@
>>>>    #define PHY_DELAY_CODE_EMMC        0x17
>>>>    #define PHY_DELAY_CODE_SD        0x55
>>>>    -enum dwcmshc_rk_type {
>>>> -    DWCMSHC_RK3568,
>>>> -    DWCMSHC_RK3588,
>>>> -};
>>>> -
>>>>    struct rk35xx_priv {
>>>>        struct reset_control *reset;
>>>> -    enum dwcmshc_rk_type devtype;
>>>>        u8 txclk_tapnum;
>>>>    };
>>>>    @@ -330,6 +324,11 @@ struct k230_pltfm_data {
>>>>        u32 write_prot_bit;
>>>>    };
>>>>    +struct rockchip_pltfm_data {
>>>> +    struct dwcmshc_pltfm_data dwcmshc_pdata;
>>>> +    int revision;
>>>
>>> Does this "revision" match HW specs, otherwise maybe need
>>> to clarify where it comes from.
>>>
>>
>> This "revision" originates from our internal IP development
>> documentation, not the public chip specifications. The public manuals do not label these specific IP versions.
>>
>> Revision 0 (Initial IP): This is the initial version of the IP used in
>> the RK3568 and RK3566. Post-silicon validation identified certain errata
>> requiring workarounds, and this version lacks HS400 support.
>>
>> Revision 1 (Fixed IP): This is the updated IP version (with
>> documentation number updated internally). It fixes the previous issues
>> and adds HS400 support. This revision is used in all subsequent chips
>> (RK3576, RK3588, etc.).
>>
>> Since the public specs do not expose this distinction, I believe using
>> the internal IP development document revision is the most accurate way
>> to differentiate the hardware behavior in software. I will add a comment
>> in the code to clarify this origin and the specific differences between
>> the revisions.
>>
>>>> +};
>>>> +
>>>>    static void dwcmshc_enable_card_clk(struct sdhci_host *host)
>>>>    {
>>>>        u16 ctrl;
>>>> @@ -749,6 +748,7 @@ static void dwcmshc_rk3568_set_clock(struct sdhci_host *host, unsigned int clock
>>>>        struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>>>>        struct dwcmshc_priv *dwc_priv = sdhci_pltfm_priv(pltfm_host);
>>>>        struct rk35xx_priv *priv = dwc_priv->priv;
>>>> +    const struct rockchip_pltfm_data *rockchip_pdata = to_pltfm_data(dwc_priv, rockchip);
>>>>        u8 txclk_tapnum = DLL_TXCLK_TAPNUM_DEFAULT;
>>>>        u32 extra, reg;
>>>>        int err;
>>>> @@ -816,7 +816,7 @@ static void dwcmshc_rk3568_set_clock(struct sdhci_host *host, unsigned int clock
>>>>         * we must set it in higher speed mode.
>>>>         */
>>>>        extra = DWCMSHC_EMMC_DLL_DLYENA;
>>>> -    if (priv->devtype == DWCMSHC_RK3568)
>>>> +    if (rockchip_pdata->revision == 0)
>>>>            extra |= DLL_RXCLK_NO_INVERTER << DWCMSHC_EMMC_DLL_RXCLK_SRCSEL;
>>>>        sdhci_writel(host, extra, DWCMSHC_EMMC_DLL_RXCLK);
>>>>    @@ -842,7 +842,7 @@ static void dwcmshc_rk3568_set_clock(struct sdhci_host *host, unsigned int clock
>>>>            host->mmc->ios.timing == MMC_TIMING_MMC_HS400)
>>>>            txclk_tapnum = priv->txclk_tapnum;
>>>>    -    if ((priv->devtype == DWCMSHC_RK3588) && host->mmc->ios.timing == MMC_TIMING_MMC_HS400) {
>>>> +    if ((rockchip_pdata->revision == 1) && host->mmc->ios.timing == MMC_TIMING_MMC_HS400) {
>>>>            txclk_tapnum = DLL_TXCLK_TAPNUM_90_DEGREES;
>>>>              extra = DLL_CMDOUT_SRC_CLK_NEG |
>>>> @@ -898,11 +898,6 @@ static int dwcmshc_rk35xx_init(struct device *dev, struct sdhci_host *host,
>>>>        if (!priv)
>>>>            return -ENOMEM;
>>>>    -    if (of_device_is_compatible(dev->of_node, "rockchip,rk3588-dwcmshc"))
>>>> -        priv->devtype = DWCMSHC_RK3588;
>>>> -    else
>>>> -        priv->devtype = DWCMSHC_RK3568;
>>>> -
>>>>        priv->reset = devm_reset_control_array_get_optional_exclusive(mmc_dev(host->mmc));
>>>>        if (IS_ERR(priv->reset)) {
>>>>            err = PTR_ERR(priv->reset);
>>>> @@ -2115,30 +2110,52 @@ static const struct cqhci_host_ops rk35xx_cqhci_ops = {
>>>>        .set_tran_desc    = dwcmshc_set_tran_desc,
>>>>    };
>>>>    -static const struct dwcmshc_pltfm_data sdhci_dwcmshc_rk35xx_pdata = {
>>>> -    .pdata = {
>>>> -        .ops = &sdhci_dwcmshc_rk35xx_ops,
>>>> -        .quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN |
>>>> -              SDHCI_QUIRK_BROKEN_TIMEOUT_VAL,
>>>> -        .quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
>>>> -               SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN,
>>>> +static const struct rockchip_pltfm_data sdhci_dwcmshc_rk3568_pdata = {
>>>> +    .dwcmshc_pdata = {
>>>> +        .pdata = {
>>>> +            .ops = &sdhci_dwcmshc_rk35xx_ops,
>>>> +            .quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN |
>>>> +                  SDHCI_QUIRK_BROKEN_TIMEOUT_VAL,
>>>> +            .quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
>>>> +                   SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN,
>>>> +        },
>>>> +        .cqhci_host_ops = &rk35xx_cqhci_ops,
>>>> +        .init = dwcmshc_rk35xx_init,
>>>> +        .postinit = dwcmshc_rk35xx_postinit,
>>>>        },
>>>> -    .cqhci_host_ops = &rk35xx_cqhci_ops,
>>>> -    .init = dwcmshc_rk35xx_init,
>>>> -    .postinit = dwcmshc_rk35xx_postinit,
>>>> +    .revision = 0,
>>>>    };
>>>>    -static const struct dwcmshc_pltfm_data sdhci_dwcmshc_rk3576_pdata = {
>>>> -    .pdata = {
>>>> -        .ops = &sdhci_dwcmshc_rk35xx_ops,
>>>> -        .quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN |
>>>> -              SDHCI_QUIRK_BROKEN_TIMEOUT_VAL,
>>>> -        .quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
>>>> -               SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN,
>>>> +static const struct rockchip_pltfm_data sdhci_dwcmshc_rk3588_pdata = {
>>>
>>> Better order: sdhci_dwcmshc_rk3568_pdata, sdhci_dwcmshc_rk3576_pdata,
>>> sdhci_dwcmshc_rk3588_pdata
>>
>>
>> Sure， will do.
>>
>>>
>>>> +    .dwcmshc_pdata = {
>>>> +        .pdata = {
>>>> +            .ops = &sdhci_dwcmshc_rk35xx_ops,
>>>> +            .quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN |
>>>> +                  SDHCI_QUIRK_BROKEN_TIMEOUT_VAL,
>>>> +            .quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
>>>> +                   SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN,
>>>> +        },
>>>> +        .cqhci_host_ops = &rk35xx_cqhci_ops,
>>>> +        .init = dwcmshc_rk35xx_init,
>>>> +        .postinit = dwcmshc_rk35xx_postinit,
>>>> +    },
>>>> +    .revision = 1,
>>>> +};
>>>> +
>>>> +static const struct rockchip_pltfm_data sdhci_dwcmshc_rk3576_pdata = {
>>>> +    .dwcmshc_pdata = {
>>>> +        .pdata = {
>>>> +            .ops = &sdhci_dwcmshc_rk35xx_ops,
>>>> +            .quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN |
>>>> +                  SDHCI_QUIRK_BROKEN_TIMEOUT_VAL,
>>>> +            .quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
>>>> +                   SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN,
>>>> +        },
>>>> +        .cqhci_host_ops = &rk35xx_cqhci_ops,
>>>> +        .init = dwcmshc_rk35xx_init,
>>>> +        .postinit = dwcmshc_rk3576_postinit,
>>>>        },
>>>> -    .cqhci_host_ops = &rk35xx_cqhci_ops,
>>>> -    .init = dwcmshc_rk35xx_init,
>>>> -    .postinit = dwcmshc_rk3576_postinit,
>>>> +    .revision = 1,
>>>
>>> Isn't rk3576 revision = 0 ?
>>
>> As explained above, rk3576 is revision 1.
> 
> Ok, but was it behaving that way before, since the code was:
> 
>       if (of_device_is_compatible(dev->of_node, "rockchip,rk3588-dwcmshc"))
>           priv->devtype = DWCMSHC_RK3588;
>       else
>           priv->devtype = DWCMSHC_RK3568;
> 

Yes, you are absolutely right to be confused，the old code logic was 
indeed the root of the problem, which is why this cleanup is necessary.

As you can see in the Device Tree [1], RK3576 explicitly lists 
"rockchip,rk3588-dwcmshc" as a secondary compatible string to select
DWCMSHC_RK3588(now revision 1) as the devtype.

[1] 
https://elixir.bootlin.com/linux/v7.0-rc5/source/arch/arm64/boot/dts/rockchip/rk3576.dtsi#L1922



>>
>>>
>>>>    };
>>>>      static const struct dwcmshc_pltfm_data sdhci_dwcmshc_th1520_pdata = {
>>>> @@ -2309,7 +2326,7 @@ static const struct of_device_id sdhci_dwcmshc_dt_ids[] = {
>>>>        },
>>>>        {
>>>>            .compatible = "rockchip,rk3588-dwcmshc",
>>>> -        .data = &sdhci_dwcmshc_rk35xx_pdata,
>>>> +        .data = &sdhci_dwcmshc_rk3588_pdata,
>>>>        },
>>>>        {
>>>>            .compatible = "rockchip,rk3576-dwcmshc",
>>>> @@ -2317,7 +2334,7 @@ static const struct of_device_id sdhci_dwcmshc_dt_ids[] = {
>>>>        },
>>>>        {
>>>>            .compatible = "rockchip,rk3568-dwcmshc",
>>>> -        .data = &sdhci_dwcmshc_rk35xx_pdata,
>>>> +        .data = &sdhci_dwcmshc_rk3568_pdata,
>>>>        },
>>>>        {
>>>>            .compatible = "snps,dwcmshc-sdhci",
>>>
>>>
> 
> 
