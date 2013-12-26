From: Dinh Nguyen <dinh.linux@gmail.com>
Subject: Re: [PATCHv4] mmc: dw_mmc: Enable the hold reg for certain speed
 modes
Date: Thu, 26 Dec 2013 11:26:25 -0600
Message-ID: <52BC66C1.9070501@gmail.com>
References: <1387213279-22020-1-git-send-email-dinguyen@altera.com> <52B00737.6050701@linaro.org> <52B059A1.1000306@gmail.com> <52B065B2.6010703@linaro.org> <52BB9B21.7010101@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ig0-f178.google.com ([209.85.213.178]:55267 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753470Ab3LZRdJ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 26 Dec 2013 12:33:09 -0500
Received: by mail-ig0-f178.google.com with SMTP id ut6so19990338igb.5
        for <linux-mmc@vger.kernel.org>; Thu, 26 Dec 2013 09:33:08 -0800 (PST)
In-Reply-To: <52BB9B21.7010101@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>, zhangfei <zhangfei.gao@linaro.org>, dinguyen@altera.com, arnd@arndb.de, cjb@laptop.org, tgih.jun@samsung.com, heiko@sntech.de, dianders@chromium.org, alim.akhtar@samsung.com, bzhao@marvell.com
Cc: linux-mmc@vger.kernel.org

Hi Jaehoon,

On 12/25/13 8:57 PM, Jaehoon Chung wrote:
> On 12/17/2013 11:54 PM, zhangfei wrote:
>>
>> On 12/17/2013 10:03 PM, Dinh Nguyen wrote:
>>> Hi Zhangfei,
>>>
>>> On 12/17/13 2:11 AM, zhangfei wrote:
>>>>
>>>> On 12/17/2013 01:01 AM, dinguyen@altera.com wrote:
>>>>> From: Dinh Nguyen <dinguyen@altera.com>
>>>>>
>>>>> This patch will enable the SDMMC_CMD_USE_HOLD_REG bit when the slot is
>>>>> operating all timing modes, except for SDR50, DDR50, SDR104, and
>>>>> MMC_HS200.
>>>>>
>>>>> According to the Synopsys databook :"To meet the relatively high
>>>>> Input Hold
>>>>> Time requirement for SDR12, SDR25, and other MMC speed modes, you should
>>>>> program bit[29]use_hold_Reg of the CMD register to 1'b1;"..."However,
>>>>> for
>>>>> the higher speed modes of SDR104, SDR50 and DDR50, you can meet the much
>>>>> smaller Input Hold Time requirement of 0.8ns by bypassing the Hold
>>>>> Register
>>>>> (Path A in Figure 10-8, programming CMD.use_hold_reg = 1'b0) and then
>>>>> adding
>>>>> delay elements on the output path as indicated.
>>>>>
>>>>> Also, "Never set CMD.use_hold_reg = 1 and cclk_in_drv phase shift to
>>>>> 0 at the
>>>>> same time. This would add an extra one-cycle delay on the output
>>>>> path, resulting
>>>>> in incorrect behavior."
>>>>>
>>>>> This patch also checks the IHR(Implement Hold Register) in the HCON
>>>>> register.
>>>>>
>>>>> This information is taking from the v2.50a of the Synopsys Designware
>>>>> Cores
>>>>> Mobile Storage Host Databook.
>>>>>
>>>>> Signed-off-by: Dinh Nguyen <dinguyen@altera.com>
>>>>> Acked-by: Arnd Bergmann <arnd@arndb.de>
>>>>> Acked-by: Heiko Stuebner <heiko@sntech.de>
>>>>> Tested-by: Heiko Stuebner <heiko@sntech.de>
>>>>> ---
>>>>> v4: use_hold_reg should be set for all modes when cclk_in_drv is
>>>>> non-zero.
>>>>> v3: Read the IHR(Implement Hold Register) in the HCON
>>>>> v2: Add check for cclk_in_drv phase shift in conjunction with
>>>>> use_hold_reg.
>>>>> ---
>>>>>    drivers/mmc/host/dw_mmc.c  |   52
>>>>> ++++++++++++++++++++++++++++++++++++++++++++
>>>>>    drivers/mmc/host/dw_mmc.h  |    4 ++++
>>>>>    include/linux/mmc/dw_mmc.h |    3 +++
>>>>>    3 files changed, 59 insertions(+)
>>>>>
>>>>> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
>>>>>        /*
>>>>>         * Use mirror of ios->clock to prevent race with mmc
>>>>>         * core ios update when finding the minimum.
>>>>> @@ -2339,6 +2361,8 @@ static struct dw_mci_board
>>>>> *dw_mci_parse_dt(struct dw_mci *host)
>>>>>        const struct dw_mci_drv_data *drv_data = host->drv_data;
>>>>>        int idx, ret;
>>>>>        u32 clock_frequency;
>>>>> +    int sdr_timing[2];
>>>>> +    int ddr_timing[2];
>>>>>
>>>>>        pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
>>>>>        if (!pdata) {
>>>>> @@ -2389,6 +2413,25 @@ static struct dw_mci_board
>>>>> *dw_mci_parse_dt(struct dw_mci *host)
>>>>>        if (of_find_property(np, "caps2-mmc-hs200-1_2v", NULL))
>>>>>            pdata->caps2 |= MMC_CAP2_HS200_1_2V_SDR;
>>>>>
>>>>> +    /* Check for the "samsung,dw-mshc-sdr-timing" and the
>>>>> +     * "samsung,dw-mshc-ddr-timing" bindings as this will tell us if we
>>>>> +     * can safely set the SDMMC_CMD_USE_HOLD_REG bit. The second
>>>>> paramater
>>>>> +     * in these 2 bindings is the value of the cclk_in_drv. If
>>>>> cclk_in_drv
>>>>> +     * is 0, we cannot set the SDMMC_CMD_USE_HOLD_REG bit. The default
>>>>> +     * behavior will be to set cclk_in_drv, as some platforms do not
>>>>> have
>>>>> +     * to set the sdr or ddr timing parameters.
>>>>> +     */
>>>>> +    sdr_timing[1] = ddr_timing[1] = 1;
>>>>> +    of_property_read_u32_array(np,
>>>>> +            "samsung,dw-mshc-sdr-timing", sdr_timing, 2);
>>>>> +
>>>>> +    of_property_read_u32_array(np,
>>>>> +            "samsung,dw-mshc-ddr-timing", ddr_timing, 2);
>>>>> +
>>>>> +    pdata->cclk_in_drv = 1;
>>>>> +    if ((sdr_timing[1] == 0) || (ddr_timing[1] == 0))
>>>>> +        pdata->cclk_in_drv = 0;
>>>>> +
>>>> Have some concern about whether it is suitable putting "samsung,~"
>>>> property in dw_mmc.c, is it supposed to be platform related?
>>>> Any conflict with drivers/mmc/host/dw_mmc-exynos.c?
>>>> If they are really commonly used, how about change name and define in
>>>> Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt?
>>> I had submitted a patch to make this a common binding before:
>>>
>>> http://www.spinics.net/lists/devicetree/msg00638.html
>>>
>>> I think the ultimate conclusion to that thread was that its perfectly
>>> acceptable to re-use bindings from other
>>> platforms.
>>>
>> Hmm, ususally I may look for the properties of dw_mmc.c in synopsys-dw-mshc.txt.
>> If this is the conclusion before, then just ignore this noise.
> If can be removed the samsung property, then i think property of clock timing can be used into dw-mmc.c
> But if samsung property is used, well. I think right that it's used into dw_mmc-exynos.c.
> Dw-mmc.c is general driver..so we don't want to include any SoC specific code.
Then do you suggest I go forward with an attempt to add a new generic
"snps,dw-mshc-sdr-timing"
binding?

Dinh
>
> If i missed something, then let me know, plz.
>
> Best Regards,
> Jaehoon Chung
>> Thanks
>>

