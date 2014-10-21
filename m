From: Vivek Gautam <gautam.vivek@samsung.com>
Subject: Re: [PATCH] mmc: dw_mmc: exynos: Add support for exynos7
Date: Tue, 21 Oct 2014 13:50:10 +0530
Message-ID: <CAFp+6iFYF+pp01WtcWPnqZ1PkPp8Td0Stuii67kX4cGjV4ojnw@mail.gmail.com>
References: <1409231933-14796-1-git-send-email-yuvaraj.cd@samsung.com>
	<54005990.8070306@samsung.com>
	<CAM4voan4ih-dD1qm85CQP9Yd0fo8xDbf7WyMdPFyHse9qO9=JA@mail.gmail.com>
	<CAFp+6iFFq0SBwbd1m5yKK04=FVPtxZHvh+q_WSOPmriv=Uk0YQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qg0-f51.google.com ([209.85.192.51]:43514 "EHLO
	mail-qg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753484AbaJUIUL (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 21 Oct 2014 04:20:11 -0400
In-Reply-To: <CAFp+6iFFq0SBwbd1m5yKK04=FVPtxZHvh+q_WSOPmriv=Uk0YQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Abhilash Kesavan <kesavan.abhilash@gmail.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Prabu Thangamuthu <prabu.t@synopsys.com>, Yuvaraj Kumar C D <yuvaraj.cd@gmail.com>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Doug Anderson <dianders@google.com>, Tomasz Figa <tomasz.figa@gmail.com>, Douglas Anderson <dianders@chromium.org>, cjb@laptop.org, Seungwon Jeon <tgih.jun@samsung.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Sonny Rao <sonnyrao@chromium.org>, Kukjin Kim <kgene.kim@samsung.com>, sunil joshi <joshi@samsung.com>, Prashanth G <prashanth.g@samsung.com>, ALIM AKHTAR <alim.akhtar@samsung.com>, Yuvaraj Kumar C D <yuvaraj.cd@samsung.com>, CPGS <cpgs@samsung.com>

On Tue, Oct 21, 2014 at 1:47 PM, Vivek Gautam <gautam.vivek@samsung.com> wrote:

Corrected Tomasz's mail id, as the earlier samsung one is not valid now.
Also giving a Tested-by

> On Mon, Sep 1, 2014 at 11:14 AM, Abhilash Kesavan
> <kesavan.abhilash@gmail.com> wrote:
>> Hi Jaehoon,
>>
>> +Prabu Thangamuthu
>>
>> On Fri, Aug 29, 2014 at 4:14 PM, Jaehoon Chung <jh80.chung@samsung.com> wrote:
>>> Hi, Abhilash.
>>>
>>> On 08/28/2014 10:18 PM, Yuvaraj Kumar C D wrote:
>>>> From: Abhilash Kesavan <a.kesavan@samsung.com>
>>>>
>>>> The Exynos7 has a DWMMC controller (v2.70a) which is different from
>>>> prior versions. This patch adds new compatible strings for exynos7.
>>>> This patch also fixes the CLKSEL register offset on exynos7.
>>>
>>> If support the 64bit, dw-mmc.c need to modify.(according to v2.70, some offset is changed for 64-bit address)
>>> But i didn't see any patches at mailing.
>>> Do you have the plan which send patch of dw-mmc.c?
>>
>> We are using a rebased version of
>> http://www.spinics.net/lists/linux-mmc/msg21742.html to handle the
>> dwmmc side changes. We should have mentioned this dependency as the
>> patch is required for proper functioning of dwmmc on Exynos7.
>> Stress tests are on-going with that patch and once it looks good, we
>> will post our results so that the original patch may be taken forward.
>>
>> Regards,
>> Abhilash
>>>
>>> Best Regards,
>>> Jaehoon Chung
>>>>
>>>> Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
>>>> Signed-off-by: Yuvaraj Kumar C D <yuvaraj.cd@samsung.com>
>>>> ---
>
> I have tested this patch following set of patches:
>
> On Exynos7 support side:
> 1) dts, kbuild: Implement support for dtb vendor subdirs" patchset
> http://comments.gmane.org/gmane.linux.kbuild.devel/12131
> 2) arch: arm64: Enable support for Samsung Exynos7 SoC  (V5)
> http://www.spinics.net/lists/linux-samsung-soc/msg37047.html
> 3) Serial clean-up patches for Exynos7
> http://www.spinics.net/lists/arm-kernel/msg367348.html
> http://www.spinics.net/lists/arm-kernel/msg367349.html
> 4) Add initial support for pinctrl on Exynos7  (V5)
> http://www.spinics.net/lists/linux-samsung-soc/msg37708.html
>
> On MMC side:
> 1) mmc: dw_mmc: Add IDMAC 64-bit address mode support  (V7)
> https://lkml.org/lkml/2014/10/20/58
> 2) mmc: dw_mmc: Reset DMA before enabling IDMAC  (V2)
> http://www.gossamer-threads.com/lists/linux/kernel/2028229
>
> eMMC and SD are running fine on Exynos7.

Tested-by: Vivek Gautam <gautam.vivek@samsung.com>

>
> If this change looks good, then we can take it in.
>
>>>>  .../devicetree/bindings/mmc/exynos-dw-mshc.txt     |    4 +
>>>>  drivers/mmc/host/dw_mmc-exynos.c                   |   91 +++++++++++++++++---
>>>>  2 files changed, 82 insertions(+), 13 deletions(-)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/mmc/exynos-dw-mshc.txt b/Documentation/devicetree/bindings/mmc/exynos-dw-mshc.txt
>>>> index 6cd3525..ee4fc05 100644
>>>> --- a/Documentation/devicetree/bindings/mmc/exynos-dw-mshc.txt
>>>> +++ b/Documentation/devicetree/bindings/mmc/exynos-dw-mshc.txt
>>>> @@ -18,6 +18,10 @@ Required Properties:
>>>>         specific extensions.
>>>>       - "samsung,exynos5420-dw-mshc": for controllers with Samsung Exynos5420
>>>>         specific extensions.
>>>> +     - "samsung,exynos7-dw-mshc": for controllers with Samsung Exynos7
>>>> +       specific extensions.
>>>> +     - "samsung,exynos7-dw-mshc-smu": for controllers with Samsung Exynos7
>>>> +       specific extensions having an SMU.
>>>>
>>>>  * samsung,dw-mshc-ciu-div: Specifies the divider value for the card interface
>>>>    unit (ciu) clock. This property is applicable only for Exynos5 SoC's and
>>>> diff --git a/drivers/mmc/host/dw_mmc-exynos.c b/drivers/mmc/host/dw_mmc-exynos.c
>>>> index 0fbc53a..509365c 100644
>>>> --- a/drivers/mmc/host/dw_mmc-exynos.c
>>>> +++ b/drivers/mmc/host/dw_mmc-exynos.c
>>>> @@ -25,6 +25,7 @@
>>>>  #define NUM_PINS(x)                  (x + 2)
>>>>
>>>>  #define SDMMC_CLKSEL                 0x09C
>>>> +#define SDMMC_CLKSEL64                       0x0A8
>>>>  #define SDMMC_CLKSEL_CCLK_SAMPLE(x)  (((x) & 7) << 0)
>>>>  #define SDMMC_CLKSEL_CCLK_DRIVE(x)   (((x) & 7) << 16)
>>>>  #define SDMMC_CLKSEL_CCLK_DIVIDER(x) (((x) & 7) << 24)
>>>> @@ -65,6 +66,8 @@ enum dw_mci_exynos_type {
>>>>       DW_MCI_TYPE_EXYNOS5250,
>>>>       DW_MCI_TYPE_EXYNOS5420,
>>>>       DW_MCI_TYPE_EXYNOS5420_SMU,
>>>> +     DW_MCI_TYPE_EXYNOS7,
>>>> +     DW_MCI_TYPE_EXYNOS7_SMU,
>>>>  };
>>>>
>>>>  /* Exynos implementation specific driver private data */
>>>> @@ -95,6 +98,12 @@ static struct dw_mci_exynos_compatible {
>>>>       }, {
>>>>               .compatible     = "samsung,exynos5420-dw-mshc-smu",
>>>>               .ctrl_type      = DW_MCI_TYPE_EXYNOS5420_SMU,
>>>> +     }, {
>>>> +             .compatible     = "samsung,exynos7-dw-mshc",
>>>> +             .ctrl_type      = DW_MCI_TYPE_EXYNOS7,
>>>> +     }, {
>>>> +             .compatible     = "samsung,exynos7-dw-mshc-smu",
>>>> +             .ctrl_type      = DW_MCI_TYPE_EXYNOS7_SMU,
>>>>       },
>>>>  };
>>>>
>>>> @@ -102,7 +111,8 @@ static int dw_mci_exynos_priv_init(struct dw_mci *host)
>>>>  {
>>>>       struct dw_mci_exynos_priv_data *priv = host->priv;
>>>>
>>>> -     if (priv->ctrl_type == DW_MCI_TYPE_EXYNOS5420_SMU) {
>>>> +     if (priv->ctrl_type == DW_MCI_TYPE_EXYNOS5420_SMU ||
>>>> +             priv->ctrl_type == DW_MCI_TYPE_EXYNOS7_SMU) {
>>>>               mci_writel(host, MPSBEGIN0, 0);
>>>>               mci_writel(host, MPSEND0, DWMCI_BLOCK_NUM);
>>>>               mci_writel(host, MPSCTRL0, DWMCI_MPSCTRL_SECURE_WRITE_BIT |
>>>> @@ -153,11 +163,22 @@ static int dw_mci_exynos_resume(struct device *dev)
>>>>  static int dw_mci_exynos_resume_noirq(struct device *dev)
>>>>  {
>>>>       struct dw_mci *host = dev_get_drvdata(dev);
>>>> +     struct dw_mci_exynos_priv_data *priv = host->priv;
>>>>       u32 clksel;
>>>>
>>>> -     clksel = mci_readl(host, CLKSEL);
>>>> -     if (clksel & SDMMC_CLKSEL_WAKEUP_INT)
>>>> -             mci_writel(host, CLKSEL, clksel);
>>>> +     if (priv->ctrl_type == DW_MCI_TYPE_EXYNOS7 ||
>>>> +             priv->ctrl_type == DW_MCI_TYPE_EXYNOS7_SMU)
>>>> +             clksel = mci_readl(host, CLKSEL64);
>>>> +     else
>>>> +             clksel = mci_readl(host, CLKSEL);
>>>> +
>>>> +     if (clksel & SDMMC_CLKSEL_WAKEUP_INT) {
>>>> +             if (priv->ctrl_type == DW_MCI_TYPE_EXYNOS7 ||
>>>> +                     priv->ctrl_type == DW_MCI_TYPE_EXYNOS7_SMU)
>>>> +                     mci_writel(host, CLKSEL64, clksel);
>>>> +             else
>>>> +                     mci_writel(host, CLKSEL, clksel);
>>>> +     }
>>>>
>>>>       return 0;
>>>>  }
>>>> @@ -169,6 +190,7 @@ static int dw_mci_exynos_resume_noirq(struct device *dev)
>>>>
>>>>  static void dw_mci_exynos_prepare_command(struct dw_mci *host, u32 *cmdr)
>>>>  {
>>>> +     struct dw_mci_exynos_priv_data *priv = host->priv;
>>>>       /*
>>>>        * Exynos4412 and Exynos5250 extends the use of CMD register with the
>>>>        * use of bit 29 (which is reserved on standard MSHC controllers) for
>>>> @@ -176,8 +198,14 @@ static void dw_mci_exynos_prepare_command(struct dw_mci *host, u32 *cmdr)
>>>>        * HOLD register should be bypassed in case there is no phase shift
>>>>        * applied on CMD/DATA that is sent to the card.
>>>>        */
>>>> -     if (SDMMC_CLKSEL_GET_DRV_WD3(mci_readl(host, CLKSEL)))
>>>> -             *cmdr |= SDMMC_CMD_USE_HOLD_REG;
>>>> +     if (priv->ctrl_type == DW_MCI_TYPE_EXYNOS7 ||
>>>> +             priv->ctrl_type == DW_MCI_TYPE_EXYNOS7_SMU) {
>>>> +             if (SDMMC_CLKSEL_GET_DRV_WD3(mci_readl(host, CLKSEL64)))
>>>> +                     *cmdr |= SDMMC_CMD_USE_HOLD_REG;
>>>> +      } else {
>>>> +             if (SDMMC_CLKSEL_GET_DRV_WD3(mci_readl(host, CLKSEL)))
>>>> +                     *cmdr |= SDMMC_CMD_USE_HOLD_REG;
>>>> +     }
>>>>  }
>>>>
>>>>  static void dw_mci_exynos_set_ios(struct dw_mci *host, struct mmc_ios *ios)
>>>> @@ -188,12 +216,20 @@ static void dw_mci_exynos_set_ios(struct dw_mci *host, struct mmc_ios *ios)
>>>>       u8 div = priv->ciu_div + 1;
>>>>
>>>>       if (ios->timing == MMC_TIMING_MMC_DDR52) {
>>>> -             mci_writel(host, CLKSEL, priv->ddr_timing);
>>>> +             if (priv->ctrl_type == DW_MCI_TYPE_EXYNOS7 ||
>>>> +                     priv->ctrl_type == DW_MCI_TYPE_EXYNOS7_SMU)
>>>> +                     mci_writel(host, CLKSEL64, priv->ddr_timing);
>>>> +             else
>>>> +                     mci_writel(host, CLKSEL, priv->ddr_timing);
>>>>               /* Should be double rate for DDR mode */
>>>>               if (ios->bus_width == MMC_BUS_WIDTH_8)
>>>>                       wanted <<= 1;
>>>>       } else {
>>>> -             mci_writel(host, CLKSEL, priv->sdr_timing);
>>>> +             if (priv->ctrl_type == DW_MCI_TYPE_EXYNOS7 ||
>>>> +                     priv->ctrl_type == DW_MCI_TYPE_EXYNOS7_SMU)
>>>> +                     mci_writel(host, CLKSEL64, priv->sdr_timing);
>>>> +             else
>>>> +                     mci_writel(host, CLKSEL, priv->sdr_timing);
>>>>       }
>>>>
>>>>       /* Don't care if wanted clock is zero */
>>>> @@ -265,26 +301,51 @@ static int dw_mci_exynos_parse_dt(struct dw_mci *host)
>>>>
>>>>  static inline u8 dw_mci_exynos_get_clksmpl(struct dw_mci *host)
>>>>  {
>>>> -     return SDMMC_CLKSEL_CCLK_SAMPLE(mci_readl(host, CLKSEL));
>>>> +     struct dw_mci_exynos_priv_data *priv = host->priv;
>>>> +
>>>> +     if (priv->ctrl_type == DW_MCI_TYPE_EXYNOS7 ||
>>>> +             priv->ctrl_type == DW_MCI_TYPE_EXYNOS7_SMU)
>>>> +             return SDMMC_CLKSEL_CCLK_SAMPLE(mci_readl(host, CLKSEL64));
>>>> +     else
>>>> +             return SDMMC_CLKSEL_CCLK_SAMPLE(mci_readl(host, CLKSEL));
>>>>  }
>>>>
>>>>  static inline void dw_mci_exynos_set_clksmpl(struct dw_mci *host, u8 sample)
>>>>  {
>>>>       u32 clksel;
>>>> -     clksel = mci_readl(host, CLKSEL);
>>>> +     struct dw_mci_exynos_priv_data *priv = host->priv;
>>>> +
>>>> +     if (priv->ctrl_type == DW_MCI_TYPE_EXYNOS7 ||
>>>> +             priv->ctrl_type == DW_MCI_TYPE_EXYNOS7_SMU)
>>>> +             clksel = mci_readl(host, CLKSEL64);
>>>> +     else
>>>> +             clksel = mci_readl(host, CLKSEL);
>>>>       clksel = (clksel & ~0x7) | SDMMC_CLKSEL_CCLK_SAMPLE(sample);
>>>> -     mci_writel(host, CLKSEL, clksel);
>>>> +     if (priv->ctrl_type == DW_MCI_TYPE_EXYNOS7 ||
>>>> +             priv->ctrl_type == DW_MCI_TYPE_EXYNOS7_SMU)
>>>> +             mci_writel(host, CLKSEL64, clksel);
>>>> +     else
>>>> +             mci_writel(host, CLKSEL, clksel);
>>>>  }
>>>>
>>>>  static inline u8 dw_mci_exynos_move_next_clksmpl(struct dw_mci *host)
>>>>  {
>>>> +     struct dw_mci_exynos_priv_data *priv = host->priv;
>>>>       u32 clksel;
>>>>       u8 sample;
>>>>
>>>> -     clksel = mci_readl(host, CLKSEL);
>>>> +     if (priv->ctrl_type == DW_MCI_TYPE_EXYNOS7 ||
>>>> +             priv->ctrl_type == DW_MCI_TYPE_EXYNOS7_SMU)
>>>> +             clksel = mci_readl(host, CLKSEL64);
>>>> +     else
>>>> +             clksel = mci_readl(host, CLKSEL);
>>>>       sample = (clksel + 1) & 0x7;
>>>>       clksel = (clksel & ~0x7) | sample;
>>>> -     mci_writel(host, CLKSEL, clksel);
>>>> +     if (priv->ctrl_type == DW_MCI_TYPE_EXYNOS7 ||
>>>> +             priv->ctrl_type == DW_MCI_TYPE_EXYNOS7_SMU)
>>>> +             mci_writel(host, CLKSEL64, clksel);
>>>> +     else
>>>> +             mci_writel(host, CLKSEL, clksel);
>>>>       return sample;
>>>>  }
>>>>
>>>> @@ -411,6 +472,10 @@ static const struct of_device_id dw_mci_exynos_match[] = {
>>>>                       .data = &exynos_drv_data, },
>>>>       { .compatible = "samsung,exynos5420-dw-mshc-smu",
>>>>                       .data = &exynos_drv_data, },
>>>> +     { .compatible = "samsung,exynos7-dw-mshc",
>>>> +                     .data = &exynos_drv_data, },
>>>> +     { .compatible = "samsung,exynos7-dw-mshc-smu",
>>>> +                     .data = &exynos_drv_data, },
>>>>       {},
>>>>  };
>>>>  MODULE_DEVICE_TABLE(of, dw_mci_exynos_match);
>>>>
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>
> --
> Best Regards
> Vivek Gautam
> Samsung R&D Institute, Bangalore
> India



-- 
Best Regards
Vivek Gautam
Samsung R&D Institute, Bangalore
India
