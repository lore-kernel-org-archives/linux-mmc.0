From: Thomas Abraham <thomas.abraham@linaro.org>
Subject: Re: [PATCH 4/7] mmc: dw_mmc: add samsung exynos5250 specific extentions
Date: Thu, 10 May 2012 16:08:28 +0530
Message-ID: <CAJuYYwT=AyR8aP_6tvi_kUAZ9xWoEpeEszVj0PX4yPeeO8MDOg@mail.gmail.com>
References: <1335935266-25289-1-git-send-email-thomas.abraham@linaro.org>
	<1335935266-25289-5-git-send-email-thomas.abraham@linaro.org>
	<CAH9JG2XBinh=XAVnt3EnWrEqeTKz34d9yB6wfiuF-J-Se_Q__Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:57471 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758827Ab2EJKi3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 10 May 2012 06:38:29 -0400
Received: by vbbff1 with SMTP id ff1so1341003vbb.19
        for <linux-mmc@vger.kernel.org>; Thu, 10 May 2012 03:38:28 -0700 (PDT)
In-Reply-To: <CAH9JG2XBinh=XAVnt3EnWrEqeTKz34d9yB6wfiuF-J-Se_Q__Q@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kyungmin Park <kmpark@infradead.org>
Cc: linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-samsung-soc@vger.kernel.org, patches@linaro.org, linux-kernel@vger.kernel.org, rob.herring@calxeda.com, grant.likely@secretlab.ca, kgene.kim@samsung.com, cjb@laptop.org, linux-arm-kernel@lists.infradead.org

Dear Mr. Park,

On 2 May 2012 12:31, Kyungmin Park <kmpark@infradead.org> wrote:
> Hi,
>
> On 5/2/12, Thomas Abraham <thomas.abraham@linaro.org> wrote:
>> The instantiation of the Synopsis Designware controller on Exynos525=
0
>> include extension for SDR and DDR specific tx/rx phase shift timing
>> and CIU internal divider. In addition to that, the option to skip th=
e
>> command hold stage is also introduced. Add support for these Exynos5=
250
>> specfic extenstions.
>>

[...]

>> +static struct dw_mci_drv_data exynos5250_drv_data =3D {
>> + =A0 =A0 .ctrl_type =A0 =A0 =A0=3D DW_MCI_TYPE_EXYNOS5250,
>> + =A0 =A0 .caps =A0 =A0 =A0 =A0 =A0 =3D MMC_CAP_UHS_DDR50 | MMC_CAP_=
1_8V_DDR |
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 MMC_CAP_8_=
BIT_DATA | MMC_CAP_CMD23,
> These caps should be board specific. So it's not proper place. Esp.,
> MMC_CAP_8_BIT_DATA.

Yes, this is incorrect. I will fix this. Thanks for pointing this out.

>> +};
>> +
>> =A0static const struct of_device_id dw_mci_pltfm_match[] =3D {
>> =A0 =A0 =A0 { .compatible =3D "synopsis,dw-mshc",
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .data =3D (void *)&synop=
sis_drv_data, },
>> + =A0 =A0 { .compatible =3D "synopsis,dw-mshc-exynos5250",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .data =3D (void *)&exynos5=
250_drv_data, },
>> =A0 =A0 =A0 {},
>> =A0};
>> =A0MODULE_DEVICE_TABLE(of, dw_mci_pltfm_match);
>> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
>> index bcf66d7..9174a69 100644
>> --- a/drivers/mmc/host/dw_mmc.c
>> +++ b/drivers/mmc/host/dw_mmc.c
>> @@ -236,6 +236,7 @@ static void dw_mci_set_timeout(struct dw_mci *ho=
st)
>> =A0static u32 dw_mci_prepare_command(struct mmc_host *mmc, struct mm=
c_command
>> *cmd)
>> =A0{
>> =A0 =A0 =A0 struct mmc_data *data;
>> + =A0 =A0 struct dw_mci_slot *slot =3D mmc_priv(mmc);
>> =A0 =A0 =A0 u32 cmdr;
>> =A0 =A0 =A0 cmd->error =3D -EINPROGRESS;
>>
>> @@ -265,6 +266,10 @@ static u32 dw_mci_prepare_command(struct mmc_ho=
st *mmc,
>> struct mmc_command *cmd)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cmdr |=3D SDMMC_CMD_DAT_=
WR;
>> =A0 =A0 =A0 }
>>
>> + =A0 =A0 if (slot->host->drv_data->ctrl_type =3D=3D DW_MCI_TYPE_EXY=
NOS5250)
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (SDMMC_CLKSEL_GET_SELCLK_DRV(mci_readl(=
slot->host, CLKSEL)))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cmdr |=3D SDMMC_USE_HOLD_R=
EG;
> Some other board, custom SOC also can use this HOLD register. So it's
> not EXYNOS5250 specific one. I think we introduce the more generic
> quirks for this instead of SOC specific.

The above code is Exynos5250 specific. The Exynos5250 hardware manual
specifies additional restrictions on when the hold register can be
used. These restrictions are specific to Exynos5250 and hence there is
check for type of the controller.


>> +
>> =A0 =A0 =A0 return cmdr;
>> =A0}
>>
>> @@ -787,10 +792,19 @@ static void dw_mci_set_ios(struct mmc_host *mm=
c,
>> struct mmc_ios *ios)
>> =A0 =A0 =A0 regs =3D mci_readl(slot->host, UHS_REG);
>>
>> =A0 =A0 =A0 /* DDR mode set */
>> - =A0 =A0 if (ios->timing =3D=3D MMC_TIMING_UHS_DDR50)
>> + =A0 =A0 if (ios->timing =3D=3D MMC_TIMING_UHS_DDR50) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 regs |=3D (0x1 << slot->id) << 16;
>> - =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 mci_writel(slot->host, CLKSEL, slot->host-=
>ddr_timing);
> As you wrote, does CLKSEL is some SOC specific registers?

Yes, the CLKSEL is a Exynos specific register.


>> + =A0 =A0 } else {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 regs &=3D ~(0x1 << slot->id) << 16;
>> + =A0 =A0 =A0 =A0 =A0 =A0 mci_writel(slot->host, CLKSEL, slot->host-=
>sdr_timing);
>> + =A0 =A0 }
>> +
>> + =A0 =A0 if (slot->host->drv_data->ctrl_type =3D=3D DW_MCI_TYPE_EXY=
NOS5250) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 slot->host->bus_hz =3D clk_get_rate(slot->=
host->ciu_clk);
>> + =A0 =A0 =A0 =A0 =A0 =A0 slot->host->bus_hz /=3D SDMMC_CLKSEL_GET_D=
IVRATIO(
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 mci_readl(slot->host, CLKSEL));
>> + =A0 =A0 }
>>
>> =A0 =A0 =A0 mci_writel(slot->host, UHS_REG, regs);
>>
>> @@ -2074,6 +2088,20 @@ static struct dw_mci_board *dw_mci_parse_dt(s=
truct
>> dw_mci *host)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (of_get_property(np, of_quriks[idx].q=
uirk, NULL))
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata->quirks |=3D of_qu=
riks[idx].id;
>>
>> + =A0 =A0 if (of_property_read_u32_array(dev->of_node,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "samsung,dw-mshc-sdr-timin=
g", timing, 3))
>> + =A0 =A0 =A0 =A0 =A0 =A0 host->sdr_timing =3D DW_MCI_DEF_SDR_TIMING=
;
>> + =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 host->sdr_timing =3D SDMMC_CLKSEL_TIMING(t=
iming[0],
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 timing[1], timing[2]);
>> +
>> + =A0 =A0 if (of_property_read_u32_array(dev->of_node,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "samsung,dw-mshc-ddr-timin=
g", timing, 3))
>> + =A0 =A0 =A0 =A0 =A0 =A0 host->ddr_timing =3D DW_MCI_DEF_DDR_TIMING=
;
>> + =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 host->ddr_timing =3D SDMMC_CLKSEL_TIMING(t=
iming[0],
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 timing[1], timing[2]);
>> +
>> =A0 =A0 =A0 if (of_property_read_u32(np, "fifo-depth", &pdata->fifo_=
depth))
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_info(dev, "fifo-depth property not f=
ound, using "
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "value o=
f FIFOTH register as default\n");
>> diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
>> index 8b8862b..4b7e42b 100644
>> --- a/drivers/mmc/host/dw_mmc.h
>> +++ b/drivers/mmc/host/dw_mmc.h
>> @@ -53,6 +53,7 @@
>> =A0#define SDMMC_IDINTEN =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x090
>> =A0#define SDMMC_DSCADDR =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x094
>> =A0#define SDMMC_BUFADDR =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x098
>> +#define SDMMC_CLKSEL =A0 =A0 =A0 =A0 0x09C /* specific to Samsung E=
xynos5250 */
> Another Samsung Custom SOC also used it.

Right, it is used in Exynos4 as well. So I will fix the comment accordi=
ngly.

Thanks,
Thomas.
