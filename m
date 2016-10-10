From: Ritesh Harjani <riteshh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [PATCH v5 11/12] mmc: sdhci-msm: Add calibration tuning for
 CDCLP533 circuit
Date: Mon, 10 Oct 2016 21:12:14 +0530
Message-ID: <6993d3a2-7961-2507-60d2-153c14e0bc17@codeaurora.org>
References: <1475678440-3525-1-git-send-email-riteshh@codeaurora.org>
 <1475678440-3525-12-git-send-email-riteshh@codeaurora.org>
 <183c2e6a-179b-b042-aef9-d1e5cb90b17d@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <183c2e6a-179b-b042-aef9-d1e5cb90b17d-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org
Cc: david.brown-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, andy.gross-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, georgi.djakov-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, alex.lemberg-XdAiOPVOjttBDgjK7y7TUQ@public.gmane.org, mateusz.nowak-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, Yuliy.Izrailov-XdAiOPVOjttBDgjK7y7TUQ@public.gmane.org, asutoshd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, david.griego-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, stummala-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, venkatg-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, bjorn.andersson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, pramod.gurav-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

Hi Adrian,

On 10/10/2016 6:19 PM, Adrian Hunter wrote:
> On 05/10/16 17:40, Ritesh Harjani wrote:
>> From: Venkat Gopalakrishnan <venkatg-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
>>
>> In HS400 mode a new RCLK is introduced on the interface for read data
>> transfers. The eMMC5.0 device transmits the read data to the host with
>> respect to rising and falling edges of RCLK. In order to ensure correct
>> operation of read data transfers in HS400 mode, the incoming RX data
>> needs to be sampled by delayed version of RCLK.
>>
>> The CDCLP533 delay circuit shifts the RCLK by T/4. It needs to be
>> initialized, configured and enabled once during HS400 mode switch and
>> when operational voltage/clock is changed.
>>
>> Signed-off-by: Venkat Gopalakrishnan <venkatg-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
>> Signed-off-by: Ritesh Harjani <riteshh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
>> ---
>>  drivers/mmc/host/sdhci-msm.c | 178 +++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 178 insertions(+)
>>
>> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
>> index 612fa82..dbf80a9c 100644
>> --- a/drivers/mmc/host/sdhci-msm.c
>> +++ b/drivers/mmc/host/sdhci-msm.c
>> @@ -57,6 +57,7 @@
>>  #define CORE_DLL_PDN		BIT(29)
>>  #define CORE_DLL_RST		BIT(30)
>>  #define CORE_DLL_CONFIG		0x100
>> +#define CORE_CMD_DAT_TRACK_SEL	BIT(0)
>>  #define CORE_DLL_STATUS		0x108
>>
>>  #define CORE_DLL_CONFIG_2	0x1b4
>> @@ -72,8 +73,36 @@
>>  #define CORE_HC_SELECT_IN_HS400	(6 << 19)
>>  #define CORE_HC_SELECT_IN_MASK	(7 << 19)
>>
>> +#define CORE_CSR_CDC_CTLR_CFG0		0x130
>> +#define CORE_SW_TRIG_FULL_CALIB		BIT(16)
>> +#define CORE_HW_AUTOCAL_ENA		BIT(17)
>> +
>> +#define CORE_CSR_CDC_CTLR_CFG1		0x134
>> +#define CORE_CSR_CDC_CAL_TIMER_CFG0	0x138
>> +#define CORE_TIMER_ENA			BIT(16)
>> +
>> +#define CORE_CSR_CDC_CAL_TIMER_CFG1	0x13C
>> +#define CORE_CSR_CDC_REFCOUNT_CFG	0x140
>> +#define CORE_CSR_CDC_COARSE_CAL_CFG	0x144
>> +#define CORE_CDC_OFFSET_CFG		0x14C
>> +#define CORE_CSR_CDC_DELAY_CFG		0x150
>> +#define CORE_CDC_SLAVE_DDA_CFG		0x160
>> +#define CORE_CSR_CDC_STATUS0		0x164
>> +#define CORE_CALIBRATION_DONE		BIT(0)
>> +
>> +#define CORE_CDC_ERROR_CODE_MASK	0x7000000
>> +
>> +#define CORE_CSR_CDC_GEN_CFG		0x178
>> +#define CORE_CDC_SWITCH_BYPASS_OFF	BIT(0)
>> +#define CORE_CDC_SWITCH_RC_EN		BIT(1)
>> +
>> +#define CORE_DDR_200_CFG		0x184
>> +#define CORE_CDC_T4_DLY_SEL		BIT(0)
>> +#define CORE_START_CDC_TRAFFIC		BIT(6)
>> +
>>  #define CORE_VENDOR_SPEC_CAPABILITIES0	0x11c
>>
>> +#define INVALID_TUNING_PHASE	-1
>>  #define TCXO_FREQ		19200000
>>  #define SDHCI_MSM_MIN_CLOCK	400000
>>  #define CORE_FREQ_100MHZ	(100 * 1000 * 1000)
>> @@ -97,6 +126,7 @@ struct sdhci_msm_host {
>>  	bool use_14lpp_dll_reset;
>>  	bool tuning_done;
>>  	bool calibration_done;
>> +	u8 saved_tuning_phase;
>>  };
>>
>>  /* Platform specific tuning */
>> @@ -426,6 +456,136 @@ static int msm_init_cm_dll(struct sdhci_host *host)
>>  	return 0;
>>  }
>>
>> +static int sdhci_msm_cdclp533_calibration(struct sdhci_host *host)
>> +{
>> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>> +	struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
>> +	u32 wait_cnt, config;
>> +	int ret;
>> +
>> +	pr_debug("%s: Enter %s\n", mmc_hostname(host->mmc), __func__);
>> +
>> +	/*
>> +	 * Retuning in HS400 (DDR mode) will fail, just reset the
>> +	 * tuning block and restore the saved tuning phase.
>> +	 */
>> +	ret = msm_init_cm_dll(host);
>> +	if (ret)
>> +		goto out;
>> +
>> +	/* Set the selected phase in delay line hw block */
>> +	ret = msm_config_cm_dll_phase(host, msm_host->saved_tuning_phase);
>> +	if (ret)
>> +		goto out;
>> +
>> +	/* Write 1 to CMD_DAT_TRACK_SEL field in DLL_CONFIG */
>> +	config = readl_relaxed(host->ioaddr + CORE_DLL_CONFIG);
>> +	config |= CORE_CMD_DAT_TRACK_SEL;
>> +	writel_relaxed(config, host->ioaddr + CORE_DLL_CONFIG);
>> +
>> +	/* Write 0 to CDC_T4_DLY_SEL field in VENDOR_SPEC_DDR200_CFG */
>> +	config = readl_relaxed(host->ioaddr + CORE_DDR_200_CFG);
>> +	config &= ~CORE_CDC_T4_DLY_SEL;
>> +	writel_relaxed(config, host->ioaddr + CORE_DDR_200_CFG);
>> +
>> +	/* Write 0 to CDC_SWITCH_BYPASS_OFF field in CORE_CSR_CDC_GEN_CFG */
>> +	config = readl_relaxed(host->ioaddr + CORE_CSR_CDC_GEN_CFG);
>> +	config &= ~CORE_CDC_SWITCH_BYPASS_OFF;
>> +	writel_relaxed(config, host->ioaddr + CORE_CSR_CDC_GEN_CFG);
>> +
>> +	/* Write 1 to CDC_SWITCH_RC_EN field in CORE_CSR_CDC_GEN_CFG */
>> +	config = readl_relaxed(host->ioaddr + CORE_CSR_CDC_GEN_CFG);
>> +	config |= CORE_CDC_SWITCH_RC_EN;
>> +	writel_relaxed(config, host->ioaddr + CORE_CSR_CDC_GEN_CFG);
>> +
>> +	/* Write 0 to START_CDC_TRAFFIC field in CORE_DDR200_CFG */
>> +	config = readl_relaxed(host->ioaddr + CORE_DDR_200_CFG);
>> +	config &= ~CORE_START_CDC_TRAFFIC;
>> +	writel_relaxed(config, host->ioaddr + CORE_DDR_200_CFG);
>> +
>> +	/*
>> +	 * Perform CDC Register Initialization Sequence
>> +	 *
>> +	 * CORE_CSR_CDC_CTLR_CFG0	0x11800EC
>> +	 * CORE_CSR_CDC_CTLR_CFG1	0x3011111
>> +	 * CORE_CSR_CDC_CAL_TIMER_CFG0	0x1201000
>> +	 * CORE_CSR_CDC_CAL_TIMER_CFG1	0x4
>> +	 * CORE_CSR_CDC_REFCOUNT_CFG	0xCB732020
>> +	 * CORE_CSR_CDC_COARSE_CAL_CFG	0xB19
>> +	 * CORE_CSR_CDC_DELAY_CFG	0x3AC
>> +	 * CORE_CDC_OFFSET_CFG		0x0
>> +	 * CORE_CDC_SLAVE_DDA_CFG	0x16334
>> +	 */
>> +
>> +	writel_relaxed(0x11800EC, host->ioaddr + CORE_CSR_CDC_CTLR_CFG0);
>> +	writel_relaxed(0x3011111, host->ioaddr + CORE_CSR_CDC_CTLR_CFG1);
>> +	writel_relaxed(0x1201000, host->ioaddr + CORE_CSR_CDC_CAL_TIMER_CFG0);
>> +	writel_relaxed(0x4, host->ioaddr + CORE_CSR_CDC_CAL_TIMER_CFG1);
>> +	writel_relaxed(0xCB732020, host->ioaddr + CORE_CSR_CDC_REFCOUNT_CFG);
>> +	writel_relaxed(0xB19, host->ioaddr + CORE_CSR_CDC_COARSE_CAL_CFG);
>> +	writel_relaxed(0x3AC, host->ioaddr + CORE_CSR_CDC_DELAY_CFG);
>> +	writel_relaxed(0x0, host->ioaddr + CORE_CDC_OFFSET_CFG);
>> +	writel_relaxed(0x16334, host->ioaddr + CORE_CDC_SLAVE_DDA_CFG);
>> +
>> +	/* CDC HW Calibration */
>> +
>> +	/* Write 1 to SW_TRIG_FULL_CALIB field in CORE_CSR_CDC_CTLR_CFG0 */
>> +	config = readl_relaxed(host->ioaddr + CORE_CSR_CDC_CTLR_CFG0);
>> +	config |= CORE_SW_TRIG_FULL_CALIB;
>> +	writel_relaxed(config, host->ioaddr + CORE_CSR_CDC_CTLR_CFG0);
>> +
>> +	/* Write 0 to SW_TRIG_FULL_CALIB field in CORE_CSR_CDC_CTLR_CFG0 */
>> +	config = readl_relaxed(host->ioaddr + CORE_CSR_CDC_CTLR_CFG0);
>> +	config &= ~CORE_SW_TRIG_FULL_CALIB;
>> +	writel_relaxed(config, host->ioaddr + CORE_CSR_CDC_CTLR_CFG0);
>> +
>> +	/* Write 1 to HW_AUTOCAL_ENA field in CORE_CSR_CDC_CTLR_CFG0 */
>> +	config = readl_relaxed(host->ioaddr + CORE_CSR_CDC_CTLR_CFG0);
>> +	config |= CORE_HW_AUTOCAL_ENA;
>> +	writel_relaxed(config, host->ioaddr + CORE_CSR_CDC_CTLR_CFG0);
>> +
>> +	/* Write 1 to TIMER_ENA field in CORE_CSR_CDC_CAL_TIMER_CFG0 */
>> +	config = readl_relaxed(host->ioaddr + CORE_CSR_CDC_CAL_TIMER_CFG0);
>> +	config |= CORE_TIMER_ENA;
>> +	writel_relaxed(config, host->ioaddr + CORE_CSR_CDC_CAL_TIMER_CFG0);
>> +
>> +	wmb(); /* drain writebuffer */
>> +
>> +	/* Poll on CALIBRATION_DONE field in CORE_CSR_CDC_STATUS0 to be 1 */
>> +	wait_cnt = 50;
>> +	while (!(readl_relaxed(host->ioaddr + CORE_CSR_CDC_STATUS0)
>> +			& CORE_CALIBRATION_DONE)) {
>> +		/* max. wait for 50us sec for CALIBRATION_DONE bit to be set */
>> +		if (--wait_cnt == 0) {
>> +			pr_err("%s: %s: CDC Calibration was not completed\n",
>> +				mmc_hostname(host->mmc), __func__);
>> +			ret = -ETIMEDOUT;
>> +			goto out;
>> +		}
>> +		/* wait for 1us before polling again */
>> +		udelay(1);
>> +	}
>> +
>> +	/* Verify CDC_ERROR_CODE field in CORE_CSR_CDC_STATUS0 is 0 */
>> +	ret = readl_relaxed(host->ioaddr + CORE_CSR_CDC_STATUS0)
>> +			& CORE_CDC_ERROR_CODE_MASK;
>> +	if (ret) {
>> +		pr_err("%s: %s: CDC Error Code %d\n",
>> +			mmc_hostname(host->mmc), __func__, ret);
>> +		ret = -EINVAL;
>> +		goto out;
>> +	}
>> +
>> +	/* Write 1 to START_CDC_TRAFFIC field in CORE_DDR200_CFG */
>> +	config = readl_relaxed(host->ioaddr + CORE_DDR_200_CFG);
>> +	config |= CORE_START_CDC_TRAFFIC;
>> +	writel_relaxed(config, host->ioaddr + CORE_DDR_200_CFG);
>> +out:
>> +	pr_debug("%s: Exit %s, ret:%d\n", mmc_hostname(host->mmc),
>> +			__func__, ret);
>> +	return ret;
>> +}
>> +
>>  static int sdhci_msm_execute_tuning(struct sdhci_host *host, u32 opcode)
>>  {
>>  	int tuning_seq_cnt = 3;
>> @@ -433,6 +593,8 @@ static int sdhci_msm_execute_tuning(struct sdhci_host *host, u32 opcode)
>>  	int rc;
>>  	struct mmc_host *mmc = host->mmc;
>>  	struct mmc_ios ios = host->mmc->ios;
>> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>> +	struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
>>
>>  	/*
>>  	 * Tuning is required for SDR104, HS200 and HS400 cards and
>> @@ -457,6 +619,7 @@ retry:
>>  		if (rc)
>>  			return rc;
>>
>> +		msm_host->saved_tuning_phase = phase;
>>  		rc = mmc_send_tuning(mmc, opcode, NULL);
>>  		if (!rc) {
>>  			/* Tuning is successful at this tuning point */
>> @@ -492,6 +655,8 @@ retry:
>>  		rc = -EIO;
>>  	}
>>
>> +	if (!rc)
>> +		msm_host->tuning_done = true;
>>  	return rc;
>>  }
>>
>> @@ -565,6 +730,17 @@ static void sdhci_msm_set_uhs_signaling(struct sdhci_host *host,
>>  	dev_dbg(mmc_dev(mmc), "%s: clock=%u uhs=%u ctrl_2=0x%x\n",
>>  		mmc_hostname(host->mmc), host->clock, uhs, ctrl_2);
>>  	sdhci_writew(host, ctrl_2, SDHCI_HOST_CONTROL2);
>> +
>> +	spin_unlock_irq(&host->lock);
>> +
>> +	/* CDCLP533 HW calibration is only required for HS400 mode*/
>> +	if (host->clock > CORE_FREQ_100MHZ &&
>> +	   msm_host->tuning_done && !msm_host->calibration_done &&
>> +	   (mmc->ios.timing == MMC_TIMING_MMC_HS400))
>> +		if (!sdhci_msm_cdclp533_calibration(host))
>> +			msm_host->calibration_done = true;
>> +
>> +	spin_lock_irq(&host->lock);
>>  }
>>
>>  static void sdhci_msm_voltage_switch(struct sdhci_host *host)
>> @@ -907,6 +1083,8 @@ static int sdhci_msm_probe(struct platform_device *pdev)
>>
>>  	sdhci_msm_populate_dt(&pdev->dev, msm_host);
>>
>> +	msm_host->saved_tuning_phase = INVALID_TUNING_PHASE;
>
> There is never a check for INVALID_TUNING_PHASE which begs the question: why
> have it?
phase value can be between 0x0 to 0xf. So during probe 
saved_tuning_phase is getting initialized with -1 value.

Let me know if any concern, we can remove it as well.
But wont it look incorrect if we initialize it with some valid phase 
value before even tuning is completed?

>
>> +
>>  	/* Setup SDCC bus voter clock. */
>>  	msm_host->bus_clk = devm_clk_get(&pdev->dev, "bus");
>>  	if (!IS_ERR(msm_host->bus_clk)) {
>>
>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
