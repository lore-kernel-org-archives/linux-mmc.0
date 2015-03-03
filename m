From: Maxime Coquelin <maxime.coquelin@st.com>
Subject: Re: [PATCH v2 1/8] mmc: sdhci-st: Add macros for register offsets
 and bitfields for mmcss glue regs
Date: Tue, 3 Mar 2015 11:24:45 +0100
Message-ID: <54F58BED.4020900@st.com>
References: <1424956227-18258-1-git-send-email-peter.griffin@linaro.org> <1424956227-18258-2-git-send-email-peter.griffin@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:43714 "EHLO
	mx08-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751468AbbCCKZV (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 3 Mar 2015 05:25:21 -0500
In-Reply-To: <1424956227-18258-2-git-send-email-peter.griffin@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Peter Griffin <peter.griffin@linaro.org>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, patrice.chotard@st.com, srinivas.kandagatla@gmail.com, chris@printf.net, ulf.hansson@linaro.org
Cc: lee.jones@linaro.org, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, peppe.cavallaro@st.com

Hi Peter,

On 02/26/2015 02:10 PM, Peter Griffin wrote:
> The stih407 family SoC's have additional glue registers in the flashSS which
> are used to configure the Arasan controller.
>
> This patch adds macros for the register offsets and bitfields which will be used by
> subsequent patches to support stih407 family SoC's.
>
> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> Signed-off-by: Giuseppe Cavallaro <peppe.cavallaro@st.com>
> ---
>   drivers/mmc/host/sdhci-st.c | 91 +++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 91 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-st.c b/drivers/mmc/host/sdhci-st.c
> index 882b07e..a3bc3c3 100644
> --- a/drivers/mmc/host/sdhci-st.c
> +++ b/drivers/mmc/host/sdhci-st.c
> @@ -26,6 +26,97 @@
>   
>   #include "sdhci-pltfm.h"
>   
> +/* MMCSS glue logic to setup the HC on some ST SoCs (e.g. STiH407 family) */
> +
> +#define	ST_MMC_CCONFIG_REG_1		0x400
Maybe my mail client, but I see a tab instead of a space after #define.
> +#define ST_MMC_CCONFIG_TIMEOUT_CLK_UNIT	BIT(24)
> +#define ST_MMC_CCONFIG_TIMEOUT_CLK_FREQ	BIT(12)
> +#define ST_MMC_CCONFIG_TUNING_COUNT_DEFAULT	BIT(8)
> +#define ST_MMC_CCONFIG_ASYNC_WAKEUP	BIT(0)
> +#define ST_MMC_CCONFIG_1_DEFAULT	\
> +				((ST_MMC_CCONFIG_TIMEOUT_CLK_UNIT) | \
> +				 (ST_MMC_CCONFIG_TIMEOUT_CLK_FREQ) | \
> +				 (ST_MMC_CCONFIG_TUNING_COUNT_DEFAULT))
> +
> +#define ST_MMC_CCONFIG_REG_2		0x404
> +#define ST_MMC_CCONFIG_HIGH_SPEED	BIT(28)
> +#define ST_MMC_CCONFIG_ADMA2		BIT(24)
> +#define ST_MMC_CCONFIG_8BIT		BIT(20)
> +#define ST_MMC_CCONFIG_MAX_BLK_LEN	16
> +#define  MAX_BLK_LEN_1024		1
> +#define  MAX_BLK_LEN_2048		2
> +#define BASE_CLK_FREQ_200		0xc8
> +#define BASE_CLK_FREQ_100		0x64
> +#define BASE_CLK_FREQ_50		0x32
> +#define ST_MMC_CCONFIG_2_DEFAULT \
> +	(ST_MMC_CCONFIG_HIGH_SPEED | ST_MMC_CCONFIG_ADMA2 | \
> +	 ST_MMC_CCONFIG_8BIT | \
> +	 (MAX_BLK_LEN_1024 << ST_MMC_CCONFIG_MAX_BLK_LEN))
> +
> +#define ST_MMC_CCONFIG_REG_3			0x408
> +#define ST_MMC_CCONFIG_EMMC_SLOT_TYPE		BIT(28)
> +#define ST_MMC_CCONFIG_64BIT			BIT(24)
> +#define ST_MMC_CCONFIG_ASYNCH_INTR_SUPPORT	BIT(20)
> +#define ST_MMC_CCONFIG_1P8_VOLT			BIT(16)
> +#define ST_MMC_CCONFIG_3P0_VOLT			BIT(12)
> +#define ST_MMC_CCONFIG_3P3_VOLT			BIT(8)
> +#define ST_MMC_CCONFIG_SUSP_RES_SUPPORT		BIT(4)
> +#define ST_MMC_CCONFIG_SDMA			BIT(0)
> +#define ST_MMC_CCONFIG_3_DEFAULT	\
> +			 (ST_MMC_CCONFIG_ASYNCH_INTR_SUPPORT	| \
> +			  ST_MMC_CCONFIG_3P3_VOLT		| \
> +			  ST_MMC_CCONFIG_SUSP_RES_SUPPORT	| \
> +			  ST_MMC_CCONFIG_SDMA)
> +
> +#define ST_MMC_CCONFIG_REG_4	0x40c
> +#define ST_MMC_CCONFIG_D_DRIVER	BIT(20)
> +#define ST_MMC_CCONFIG_C_DRIVER	BIT(16)
> +#define ST_MMC_CCONFIG_A_DRIVER	BIT(12)
> +#define ST_MMC_CCONFIG_DDR50	BIT(8)
> +#define ST_MMC_CCONFIG_SDR104	BIT(4)
> +#define ST_MMC_CCONFIG_SDR50	BIT(0)
> +#define ST_MMC_CCONFIG_4_DEFAULT	0
> +
> +#define ST_MMC_CCONFIG_REG_5		0x410
> +#define ST_MMC_CCONFIG_TUNING_FOR_SDR50	BIT(8)
> +#define RETUNING_TIMER_CNT_MAX		0xf
> +#define ST_MMC_CCONFIG_5_DEFAULT	0
> +
> +/* I/O configuration for Arasan IP */
> +#define	ST_MMC_GP_OUTPUT	0x450
Same Here.

Best regards,
Maxime
