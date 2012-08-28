From: Thomas Abraham <thomas.abraham@linaro.org>
Subject: Re: [PATCH v4 9/9] mmc: dw_mmc: add support for exynos specific
 implementation of dw-mshc
Date: Tue, 28 Aug 2012 13:12:54 +0530
Message-ID: <CAJuYYwSPuWmJb-7NFU1DGxLcVak1EUTxJgzAyRnAY7FQSFNUfg@mail.gmail.com>
References: <1345981927-26359-1-git-send-email-thomas.abraham@linaro.org>
	<1345981927-26359-10-git-send-email-thomas.abraham@linaro.org>
	<002201cd84eb$a26dfab0$e749f010$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:43563 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752484Ab2H1Hmz (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 28 Aug 2012 03:42:55 -0400
Received: by lagy9 with SMTP id y9so3080985lag.19
        for <linux-mmc@vger.kernel.org>; Tue, 28 Aug 2012 00:42:54 -0700 (PDT)
In-Reply-To: <002201cd84eb$a26dfab0$e749f010$%jun@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>
Cc: linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, cjb@laptop.org, grant.likely@secretlab.ca, rob.herring@calxeda.com, linux-samsung-soc@vger.kernel.org, kgene.kim@samsung.com, girish.shivananjappa@linaro.org, jh80.chung@samsung.com, patches@linaro.org

Hi Seungwon,

On 28 August 2012 12:36, Seungwon Jeon <tgih.jun@samsung.com> wrote:
> Hi Thomas,
>
> Thank you for your effort.
> Some reviews seems like to be omitted. Please check more.
>
> On Sunday, August 26, 2012 Thomas Abraham <thomas.abraham@linaro.org> wrote:
>> Samsung Exynos SoC's extend the dw-mshc controller for additional clock and bus
>> control. Add support for these extensions and include provide device tree based
>> discovery suppory as well.

[...]

>> +static struct dw_mci_exynos_compatible {
>> +     char                            *compatible;
>> +     enum dw_mci_exynos_type         ctrl_type;
>> +} exynos_compat[] = {
>> +     {
>> +             .compatible     = "samsung,exynos4210-dw-mshc",
>> +             .ctrl_type      = DW_MCI_TYPE_EXYNOS4210,
>> +     }, {
>> +             .compatible     = "samsung,exynos4210-dw-mshc",
> typo? exynos4412-dw-mshc is expected.

Yes, that was a typo. I will fix it.

[...]

>> +static void dw_mci_exynos_prepare_command(struct dw_mci *host, u32 *cmdr)
>> +{
>> +     struct dw_mci_exynos_priv_data *priv = host->priv;
>> +     u8 drv;
>> +
>> +     /*
>> +      * Exynos4412 and Exynos5250 extends the use of CMD register with the
>> +      * use of bit 29 (which is reserved on standard MSHC controllers) for
>> +      * optionally bypassing the HOLD register for command and data. The
>> +      * HOLD register should be bypassed in case there is no phase shift
>> +      * applied on CMD/DATA that is sent to the card.
>> +      */
>> +     if (priv->ctrl_type == DW_MCI_TYPE_EXYNOS4412)
>> +             drv = SDMMC_CLKSEL_GET_DRV_WD2(mci_readl(host, CLKSEL));
> As it  has been mentioned previously,  only exynos4210 uses 2-bit.
> So SDMMC_CLKSEL_GET_DRV_WD3 will be right in exynos4412.

In the Exynos4412 user manual that I referred, the SelClk_Drv and
SelClk_Sample bit fields of the CLKSEL register are 2 bits wide. Could
you please confirm that these two bit-fields are infact 3 bits wide?

>
>> +     else if (priv->ctrl_type == DW_MCI_TYPE_EXYNOS5250)
>> +             drv = SDMMC_CLKSEL_GET_DRV_WD3(mci_readl(host, CLKSEL));
>> +     else
>> +             return;
>> +     if (drv)
>> +             *cmdr |= SDMMC_CMD_USE_HOLD_REG;
>> +}
>> +
>> +static void dw_mci_exynos_set_ios(struct dw_mci *host, struct mmc_ios *ios)
>> +{
>> +     struct dw_mci_exynos_priv_data *priv = host->priv;
>> +
>> +     if (ios->timing == MMC_TIMING_UHS_DDR50)
>> +             mci_writel(host, CLKSEL, priv->ddr_timing);
>> +     else
>> +             mci_writel(host, CLKSEL, priv->sdr_timing);
>> +
>> +     host->bus_hz = clk_get_rate(host->ciu_clk);
>> +     if (priv->ctrl_type == DW_MCI_TYPE_EXYNOS5250)
>> +             host->bus_hz /= SDMMC_CLKSEL_GET_DIVRATIO(
>> +                                     mci_readl(host, CLKSEL));
> bus_hz should be recalculated for exynoxs4 as well.
> Could you check the previous mailing?

Exynos4 does not have the additional clock divisor, as in Exynos5250.
Could you please explain why the bus_hz clock should be divided in
Exynos4?

>
>> +}
>> +
>> +static int dw_mci_exynos_parse_dt(struct dw_mci *host)
>> +{
>> +     struct dw_mci_exynos_priv_data *priv = host->priv;
>> +     u32 timing[3];
>> +
>> +     if (of_property_read_u32_array(host->dev->of_node,
>> +                     "samsung,dw-mshc-sdr-timing", timing, 3))
>> +             priv->sdr_timing = DW_MCI_DEF_SDR_TIMING;
>> +     else
>> +             priv->sdr_timing = SDMMC_CLKSEL_TIMING(timing[0],
>> +                                     timing[1], timing[2]);
>> +
>> +     if (of_property_read_u32_array(host->dev->of_node,
>> +                     "samsung,dw-mshc-ddr-timing", timing, 3))
>> +             priv->ddr_timing = DW_MCI_DEF_DDR_TIMING;
>> +     else
>> +             priv->ddr_timing = SDMMC_CLKSEL_TIMING(timing[0],
>> +                                     timing[1], timing[2]);
>> +     return 0;
> DW_MCI_DEF_SDR_TIMING and DW_MCI_DEF_DDR_TIMING are board-specific timing values.
> So, these values can't be used commonly. It has been already discussed.
> If this property is empty, returning error with message will be fine.
> Currently just 0 is always returned.

Yes, you had mentioned this previously. But these are only default
values. In case, a board cannot work with these default values, the
board's dtsi file should provide the correct values by using these
bindings. What is your opinion on this, please let me know.

Thanks for your time reviewing this patch series.

Regards,
Thomas.
