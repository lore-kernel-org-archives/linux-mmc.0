From: Thomas Abraham <thomas.abraham@linaro.org>
Subject: Re: [PATCH v4 9/9] mmc: dw_mmc: add support for exynos specific
 implementation of dw-mshc
Date: Tue, 28 Aug 2012 17:05:58 +0530
Message-ID: <CAJuYYwQKrfxUBqk_SdJ62pdbEqeSU63ExqXY39mEPqgg1oZ+=Q@mail.gmail.com>
References: <1345981927-26359-1-git-send-email-thomas.abraham@linaro.org>
	<1345981927-26359-10-git-send-email-thomas.abraham@linaro.org>
	<002201cd84eb$a26dfab0$e749f010$%jun@samsung.com>
	<CAJuYYwSPuWmJb-7NFU1DGxLcVak1EUTxJgzAyRnAY7FQSFNUfg@mail.gmail.com>
	<002601cd850a$050dcc90$0f2965b0$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:38417 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751008Ab2H1LgA (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 28 Aug 2012 07:36:00 -0400
Received: by lbbgj3 with SMTP id gj3so3170361lbb.19
        for <linux-mmc@vger.kernel.org>; Tue, 28 Aug 2012 04:35:58 -0700 (PDT)
In-Reply-To: <002601cd850a$050dcc90$0f2965b0$%jun@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>
Cc: linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, cjb@laptop.org, grant.likely@secretlab.ca, rob.herring@calxeda.com, linux-samsung-soc@vger.kernel.org, kgene.kim@samsung.com, girish.shivananjappa@linaro.org, jh80.chung@samsung.com, patches@linaro.org

On 28 August 2012 16:13, Seungwon Jeon <tgih.jun@samsung.com> wrote:
> On Tuesday, August 28, 2012 Thomas Abraham <thomas.abraham@linaro.org> wrote:
>> Hi Seungwon,
>>
>> On 28 August 2012 12:36, Seungwon Jeon <tgih.jun@samsung.com> wrote:

[...]

>> >> +     /*
>> >> +      * Exynos4412 and Exynos5250 extends the use of CMD register with the
>> >> +      * use of bit 29 (which is reserved on standard MSHC controllers) for
>> >> +      * optionally bypassing the HOLD register for command and data. The
>> >> +      * HOLD register should be bypassed in case there is no phase shift
>> >> +      * applied on CMD/DATA that is sent to the card.
>> >> +      */
>> >> +     if (priv->ctrl_type == DW_MCI_TYPE_EXYNOS4412)
>> >> +             drv = SDMMC_CLKSEL_GET_DRV_WD2(mci_readl(host, CLKSEL));
>> > As it  has been mentioned previously,  only exynos4210 uses 2-bit.
>> > So SDMMC_CLKSEL_GET_DRV_WD3 will be right in exynos4412.
>>
>> In the Exynos4412 user manual that I referred, the SelClk_Drv and
>> SelClk_Sample bit fields of the CLKSEL register are 2 bits wide. Could
>> you please confirm that these two bit-fields are in fact 3 bits wide?
> I think you are referring old manual. 3-bit is right.
> I hope you find this.

Ok. Maybe I have an older manual then. I will change it to 3-bit for 4412.

[...]

>> >> +static void dw_mci_exynos_set_ios(struct dw_mci *host, struct mmc_ios *ios)
>> >> +{
>> >> +     struct dw_mci_exynos_priv_data *priv = host->priv;
>> >> +
>> >> +     if (ios->timing == MMC_TIMING_UHS_DDR50)
>> >> +             mci_writel(host, CLKSEL, priv->ddr_timing);
>> >> +     else
>> >> +             mci_writel(host, CLKSEL, priv->sdr_timing);
>> >> +
>> >> +     host->bus_hz = clk_get_rate(host->ciu_clk);
>> >> +     if (priv->ctrl_type == DW_MCI_TYPE_EXYNOS5250)
>> >> +             host->bus_hz /= SDMMC_CLKSEL_GET_DIVRATIO(
>> >> +                                     mci_readl(host, CLKSEL));
>> > bus_hz should be recalculated for exynoxs4 as well.
>> > Could you check the previous mailing?
>>
>> Exynos4 does not have the additional clock divisor, as in Exynos5250.
>> Could you please explain why the bus_hz clock should be divided in
>> Exynos4?
> Yes, clock divisor is used in Exynos5250.
> In case of Exynos4 SoC's, divider value(DIVRATIO) isn't exposed to register.
> But  SDCLKIN is divided by fixed divider value internally.
> As mentioned previously, divider is used like below.
> Exynos4210 : 2
> Exynos4X12 : 4

Ok. Thanks for the information. I will add divisor support for Exynos4
as well. These patches have not been tested with Exynos4 since I do
not have a Exynos4 based board that uses dw-mmc controller.

[...]

>> > DW_MCI_DEF_SDR_TIMING and DW_MCI_DEF_DDR_TIMING are board-specific timing values.
>> > So, these values can't be used commonly. It has been already discussed.
>> > If this property is empty, returning error with message will be fine.
>> > Currently just 0 is always returned.
>>
>> Yes, you had mentioned this previously. But these are only default
>> values. In case, a board cannot work with these default values, the
>> board's dtsi file should provide the correct values by using these
>> bindings. What is your opinion on this, please let me know.
> Is there any basis for these value which you chose?
> If these can be acceptable for the most part, we can consider it for default value.
> But it depends on host of SOC and target board.

Ok. I will remove the optional value and make this property mandatory.

Thanks,
Thomas.
