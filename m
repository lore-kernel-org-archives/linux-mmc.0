From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH 5/5] mmc: dw-mmc: add the use_hold_reg in CMD register
Date: Fri, 24 Aug 2012 14:19:26 +0900
Message-ID: <50370EDE.3010202@samsung.com>
References: <503614A9.2020304@samsung.com>
 <00af01cd81af$66d7a1c0$3486e540$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:55590 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751436Ab2HXFTp (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 24 Aug 2012 01:19:45 -0400
Received: from epcpsbgm2.samsung.com (mailout3.samsung.com [203.254.224.33])
 by mailout3.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0M9800FQ5URMAOK0@mailout3.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 24 Aug 2012 14:19:43 +0900 (KST)
Received: from [10.90.51.55] by mmp1.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTPA id <0M9800GJ5USUAN10@mmp1.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 24 Aug 2012 14:19:43 +0900 (KST)
In-reply-to: <00af01cd81af$66d7a1c0$3486e540$%jun@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>
Cc: 'Jaehoon Chung' <jh80.chung@samsung.com>, 'linux-mmc' <linux-mmc@vger.kernel.org>, 'Chris Ball' <cjb@laptop.org>, 'Kyungmin Park' <kyungmin.park@samsung.com>, 'Will Newton' <will.newton@imgtec.com>, 'James Hogan' <james.hogan@imgtec.com>

On 08/24/2012 01:17 PM, Seungwon Jeon wrote:
> On Thursday, August 23, 2012, Jaehoon Chung <jh80.chung@samsung.com> wrote:
>> This patch is added the use_hold_reg bit in CMD register.
>>
>> In upper version than 2.40a, bit[29] of CMD register is used the use_hold_reg.
>> Some SoC is affected by this bit.
>> (This bit means whether use hold register when send data and cmd.
>>  And related with cclk_in_drv phase)
>>
>> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
>> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
>> ---
>>  drivers/mmc/host/dw_mmc.c  |   36 ++++++++++++++++++++++++++++++++++++
>>  drivers/mmc/host/dw_mmc.h  |    1 +
>>  include/linux/mmc/dw_mmc.h |    3 +++
>>  3 files changed, 40 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
>> index feafa2d..426171f 100644
>> --- a/drivers/mmc/host/dw_mmc.c
>> +++ b/drivers/mmc/host/dw_mmc.c
>> @@ -265,11 +265,45 @@ static u32 dw_mci_prepare_command(struct mmc_host *mmc, struct mmc_command *cmd)
>>  static void dw_mci_start_command(struct dw_mci *host,
>>  				 struct mmc_command *cmd, u32 cmd_flags)
>>  {
>> +	struct dw_mci_slot *slot = host->cur_slot;
>> +	struct mmc_ios *ios = &slot->mmc->ios;
>> +
>>  	host->cmd = cmd;
>>  	dev_vdbg(&host->dev,
>>  		 "start command: ARGR=0x%08x CMDR=0x%08x\n",
>>  		 cmd->arg, cmd_flags);
>>
>> +	if (host->quirks & DW_MCI_QUIRK_USE_CLKSEL_REG) {
>> +		/*
>> +		 * If use HOLD register and SDR12/SDSR25,
>> +		 * CMD and DATA sent to card through HOLD register by default.
>> +		 * But if mode is SDR50/DDR50/SDR104,
>> +		 * only use the hold register when cclk_in_drv value is upper than 0.
>> +		 */
>> +		switch (ios->timing) {
>> +		case MMC_TIMING_UHS_SDR50:
>> +		case MMC_TIMING_UHS_DDR50:
>> +			if (host->pdata->get_clk_drv)
>> +				if ((host->pdata->get_clk_drv(host) &&
>> +						host->use_hold_reg)) {
>> +					cmd_flags |= SDMMC_CMD_USE_HOLD_REG;
>> +					break;
>> +				}
>> +
>> +			cmd_flags &= ~SDMMC_CMD_USE_HOLD_REG;
>> +			break;
>> +		case MMC_TIMING_UHS_SDR104:
>> +		case MMC_TIMING_UHS_SDR12:
>> +		case MMC_TIMING_UHS_SDR25:
>> +			if (host->use_hold_reg) {
> Are there other conditions to be considered  as well?
MMC_TIMING_UHS_SDR104 need to consider the cclk_in_drv.
Below is right..i will fix this.
	case MMC_TIMING_UHS_SDR_50:
	case MMC_TIMING_UHS_DDR_50:
	case MMC_TIMING_UHS_SDR_140:
		code...
	case MMC_TIMING_UHS_SDR_12:
	case MMC_TIMING_UHS_SDR_25:
		code..
And we could consider the high-speed/non-DDR mode.
I will check the manual.
> 
>> +				cmd_flags |= SDMMC_CMD_USE_HOLD_REG;
>> +				break;
>> +			}
>> +		default:
>> +			cmd_flags &= ~SDMMC_CMD_USE_HOLD_REG;
>> +		}
>> +	}
> If routine as a whole is moved to dw_mci_set_ios, it would be better.
> There is no need to execute whenever command starts.
As you mentioned, I will try to test after modify.

Best Regards,
Jaehoon Chung
> 
> Thanks,
> Seungwon Jeon
> 
>> +
>>  	mci_writel(host, CMDARG, cmd->arg);
>>  	wmb();
>>
>> @@ -2018,6 +2052,8 @@ int dw_mci_probe(struct dw_mci *host)
>>  		host->data_shift = 2;
>>  	}
>>
>> +	host->use_hold_reg = (mci_readl(host, HCON) >> 22) & 0x1;
>> +
>>  	/* Reset all blocks */
>>  	if (!mci_wait_reset(&host->dev, host))
>>  		return -ENODEV;
>> diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
>> index b6a1a78..cc905ee 100644
>> --- a/drivers/mmc/host/dw_mmc.h
>> +++ b/drivers/mmc/host/dw_mmc.h
>> @@ -111,6 +111,7 @@
>>  #define SDMMC_INT_ERROR			0xbfc2
>>  /* Command register defines */
>>  #define SDMMC_CMD_START			BIT(31)
>> +#define SDMMC_CMD_USE_HOLD_REG		BIT(29)
>>  #define SDMMC_CMD_CCS_EXP		BIT(23)
>>  #define SDMMC_CMD_CEATA_RD		BIT(22)
>>  #define SDMMC_CMD_UPD_CLK		BIT(21)
>> diff --git a/include/linux/mmc/dw_mmc.h b/include/linux/mmc/dw_mmc.h
>> index f20979c..803a80d 100644
>> --- a/include/linux/mmc/dw_mmc.h
>> +++ b/include/linux/mmc/dw_mmc.h
>> @@ -156,6 +156,7 @@ struct dw_mci {
>>  	u32			fifoth_val;
>>  	u16			verid;
>>  	u16			data_offset;
>> +	bool			use_hold_reg;
>>  	struct device		dev;
>>  	struct dw_mci_board	*pdata;
>>  	struct dw_mci_slot	*slot[MAX_MCI_SLOTS];
>> @@ -201,6 +202,8 @@ struct dw_mci_dma_ops {
>>  #define DW_MCI_QUIRK_HIGHSPEED			BIT(2)
>>  /* Unreliable card detection */
>>  #define DW_MCI_QUIRK_BROKEN_CARD_DETECTION	BIT(3)
>> +/* To use the CLKSEL register for phase-shift */
>> +#define DW_MCI_QUIRK_USE_CLKSEL_REG		BIT(4)
>>
>>
>>  struct dma_pdata;
>> --
>> 1.7.4.1
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

