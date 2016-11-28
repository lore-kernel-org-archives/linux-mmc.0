From: Ritesh Harjani <riteshh@codeaurora.org>
Subject: Re: [PATCH V7 09/25] mmc: mmc: Add Command Queue definitions
Date: Mon, 28 Nov 2016 09:59:29 +0530
Message-ID: <6e1120e4-f13e-354c-9a5e-9dfc9239c9f3@codeaurora.org>
References: <1480068442-5169-1-git-send-email-adrian.hunter@intel.com>
 <1480068442-5169-10-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:37526 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752302AbcK1E3i (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 27 Nov 2016 23:29:38 -0500
In-Reply-To: <1480068442-5169-10-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Dorfman Konstantin <kdorfman@codeaurora.org>, David Griego <david.griego@linaro.org>, Sahitya Tummala <stummala@codeaurora.org>, Venu Byravarasu <vbyravarasu@nvidia.com>, Linus Walleij <linus.walleij@linaro.org>



On 11/25/2016 3:37 PM, Adrian Hunter wrote:
> Add definitions relating to Command Queuing.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/mmc/core/mmc.c   | 17 +++++++++++++++++
>  include/linux/mmc/card.h |  2 ++
>  include/linux/mmc/mmc.h  | 17 +++++++++++++++++
>  3 files changed, 36 insertions(+)
>
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 3268fcd3378d..6e9830997eef 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -618,6 +618,23 @@ static int mmc_decode_ext_csd(struct mmc_card *card, u8 *ext_csd)
>  			(ext_csd[EXT_CSD_SUPPORTED_MODE] & 0x1) &&
>  			!(ext_csd[EXT_CSD_FW_CONFIG] & 0x1);
>  	}
> +
> +	/* eMMC v5.1 or later */
> +	if (card->ext_csd.rev >= 8) {
> +		card->ext_csd.cmdq_support = ext_csd[EXT_CSD_CMDQ_SUPPORT] &
> +					     EXT_CSD_CMDQ_SUPPORTED;
> +		card->ext_csd.cmdq_depth = (ext_csd[EXT_CSD_CMDQ_DEPTH] &
> +					    EXT_CSD_CMDQ_DEPTH_MASK) + 1;
> +		if (card->ext_csd.cmdq_depth <= 2) {
> +			card->ext_csd.cmdq_support = false;
> +			card->ext_csd.cmdq_depth = 0;
> +		}
Could you please explain, why for cmdq_depth <=2, we are disabling
cmdq_support ? Maybe we can add a comment there.


> +		if (card->ext_csd.cmdq_support) {
> +			pr_debug("%s: Command Queue supported depth %u\n",
> +				 mmc_hostname(card->host),
> +				 card->ext_csd.cmdq_depth);
> +		}
> +	}
>  out:
>  	return err;
>  }
> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
> index e49a3ff9d0e0..95d69d498296 100644
> --- a/include/linux/mmc/card.h
> +++ b/include/linux/mmc/card.h
> @@ -89,6 +89,8 @@ struct mmc_ext_csd {
>  	unsigned int		boot_ro_lock;		/* ro lock support */
>  	bool			boot_ro_lockable;
>  	bool			ffu_capable;	/* Firmware upgrade support */
> +	bool			cmdq_support;	/* Command Queue supported */
> +	unsigned int		cmdq_depth;	/* Command Queue depth */
>  #define MMC_FIRMWARE_LEN 8
>  	u8			fwrev[MMC_FIRMWARE_LEN];  /* FW version */
>  	u8			raw_exception_status;	/* 54 */
> diff --git a/include/linux/mmc/mmc.h b/include/linux/mmc/mmc.h
> index c376209c70ef..672730acc705 100644
> --- a/include/linux/mmc/mmc.h
> +++ b/include/linux/mmc/mmc.h
> @@ -84,6 +84,13 @@
>  #define MMC_APP_CMD              55   /* ac   [31:16] RCA        R1  */
>  #define MMC_GEN_CMD              56   /* adtc [0] RD/WR          R1  */
>
> +  /* class 11 */
> +#define MMC_QUE_TASK_PARAMS      44   /* ac   [20:16] task id    R1  */
> +#define MMC_QUE_TASK_ADDR        45   /* ac   [31:0] data addr   R1  */
> +#define MMC_EXECUTE_READ_TASK    46   /* adtc [20:16] task id    R1  */
> +#define MMC_EXECUTE_WRITE_TASK   47   /* adtc [20:16] task id    R1  */
> +#define MMC_CMDQ_TASK_MGMT       48   /* ac   [20:16] task id    R1b */
> +
>  static inline bool mmc_op_multi(u32 opcode)
>  {
>  	return opcode == MMC_WRITE_MULTIPLE_BLOCK ||
> @@ -272,6 +279,7 @@ struct _mmc_csd {
>   * EXT_CSD fields
>   */
>
> +#define EXT_CSD_CMDQ_MODE_EN		15	/* R/W */
>  #define EXT_CSD_FLUSH_CACHE		32      /* W */
>  #define EXT_CSD_CACHE_CTRL		33      /* R/W */
>  #define EXT_CSD_POWER_OFF_NOTIFICATION	34	/* R/W */
> @@ -331,6 +339,8 @@ struct _mmc_csd {
>  #define EXT_CSD_CACHE_SIZE		249	/* RO, 4 bytes */
>  #define EXT_CSD_PWR_CL_DDR_200_360	253	/* RO */
>  #define EXT_CSD_FIRMWARE_VERSION	254	/* RO, 8 bytes */
> +#define EXT_CSD_CMDQ_DEPTH		307	/* RO */
> +#define EXT_CSD_CMDQ_SUPPORT		308	/* RO */
>  #define EXT_CSD_SUPPORTED_MODE		493	/* RO */
>  #define EXT_CSD_TAG_UNIT_SIZE		498	/* RO */
>  #define EXT_CSD_DATA_TAG_SUPPORT	499	/* RO */
> @@ -438,6 +448,13 @@ struct _mmc_csd {
>  #define EXT_CSD_MANUAL_BKOPS_MASK	0x01
>
>  /*
> + * Command Queue
> + */
> +#define EXT_CSD_CMDQ_MODE_ENABLED	BIT(0)

Is there a need for both EXT_CSD_CMDQ_MODE_ENABLED and 
EXT_CSD_CMDQ_MODE_SUPPORTED. Arent they doing same thing?


> +#define EXT_CSD_CMDQ_DEPTH_MASK		GENMASK(4, 0)
> +#define EXT_CSD_CMDQ_SUPPORTED		BIT(0)
Ditto

> +
> +/*
>   * MMC_SWITCH access modes
>   */
>
>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
