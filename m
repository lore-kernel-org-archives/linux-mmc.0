Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C723566A;
	Fri, 23 Aug 2024 12:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724416964; cv=none; b=LxzMqVyxebR7Gs1KFL48wPuJvK33v82OHqGMnu+GvA+DqEZpyVrAdL6AgtKHuUotE22Gz8gaDI7Pt5uQ/1jbFD1gU2XBoo3htqsrS/x0E9RIStrkKXHi4pZwI1BsNpgi/h4HaatCA5YLjPWf+N3DItM+nqB/FBkDNV1tpxOaL+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724416964; c=relaxed/simple;
	bh=xOG2bvaY5N8d4G9cXBSVlYqBrc/1TUlVowOVDT4kDxk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b3SRAkdGHkaDcGeoT7VM/fy+rr4BGFsh11O5VG+daB7m8/2jm1gwFRfoG6/RuPVFyFh5lG79EZNMNhVTs4+6Kg8B7lr/XwhsBM/jPidwjA29HFvTWTl2iR53KZcXZPCUBN3E17CAUTyjs6ODnEfZZw3oYlAxEAutLIUiEZMx6fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZRA4ebUv; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZRA4ebUv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724416962; x=1755952962;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=xOG2bvaY5N8d4G9cXBSVlYqBrc/1TUlVowOVDT4kDxk=;
  b=ZRA4ebUv2tB4COlctP2u3D1t6D20TIbOtxKRGkMgVnDipBJcqSEvVIzr
   WPAu/DDhz0jP7/lVaakaI9DAZdyA0cB10/PT9Qbr2z1EIgREguzKE8abm
   EsqXsiOsZeP8sl4xJpVlUvVDgN9Xtfe67hjGnsGprI7TMZEdNeASX2izo
   G+6C8BAP6CH2C7ruZgjWZMu4SCurxpxTsJ7F2CsljxzTKS6XiB9Ctll9M
   v83OtaJj2Ffey2Tk9ocRu84y59xYi0Cj4B3ke5p1SC3BOvSZUDcxe6RZi
   5vvcBuuikqh6gcrdcfc079IBt+DBH/simrsiADHl70pfLWxNlz4qkr2ed
   g==;
X-CSE-ConnectionGUID: 4KzTZje0QTO2l7bQikMPuQ==
X-CSE-MsgGUID: X/cJZGGIS8SGdLP7bP4OMw==
X-IronPort-AV: E=McAfee;i="6700,10204,11172"; a="23052781"
X-IronPort-AV: E=Sophos;i="6.10,170,1719903600"; 
   d="scan'208";a="23052781"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2024 05:42:41 -0700
X-CSE-ConnectionGUID: 7W6hK233SdCSa85m9/5RPw==
X-CSE-MsgGUID: sWlyvFv6Tre1y+543qrKvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,170,1719903600"; 
   d="scan'208";a="84969915"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.245.96.163])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2024 05:42:37 -0700
Message-ID: <9c72bb79-0b10-4560-a312-971e47550412@intel.com>
Date: Fri, 23 Aug 2024 15:42:31 +0300
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V18 16/22] mmc: sdhci-uhs2: add request() and others
To: Victor Shih <victorshihgli@gmail.com>, ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
 benchuanggli@gmail.com, Lucas.Lai@genesyslogic.com.tw,
 HL.Liu@genesyslogic.com.tw, Greg.tu@genesyslogic.com.tw,
 takahiro.akashi@linaro.org, dlunev@chromium.org,
 Ben Chuang <ben.chuang@genesyslogic.com.tw>,
 Victor Shih <victor.shih@genesyslogic.com.tw>
References: <20240802102229.10204-1-victorshihgli@gmail.com>
 <20240802102229.10204-17-victorshihgli@gmail.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20240802102229.10204-17-victorshihgli@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/08/24 13:22, Victor Shih wrote:
> From: Victor Shih <victor.shih@genesyslogic.com.tw>
> 
> This is a sdhci version of mmc's request operation.
> It covers both UHS-I and UHS-II.
> 
> Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
> ---
> 
> Updates in V17:
>  - Add new parameter to __sdhci_finish_data_common().
> 
> Updates in V16:
>  - Remove irrelevant definition in the sdhci_calc_timeout_uhs2().
> 
> Updates in V15:
>  - Adjust the parameters used in the __sdhci_uhs2_finish_command()
>    to match changes in the Patch#7.
> 
> Updates in V14:
>  - Use mmc_card_uhs2() to stead sdhci_uhs2_mode() in the
>    sdhci_uhs2_request().
> 
> Updates in V13:
>  - Re-order function to avoid declaration.
>  - Remove unnecessary function.
> 
> Updates in V11:
>  - Drop the check mmc_card_uhs2_hd_mode(host->mmc)
>    in sdhci_uhs2_set_transfer_mode().
> 
> Updates in V10:
>  - Use tmode_half_duplex to instead of uhs2_tmode0_flag
>    in sdhci_uhs2_set_transfer_mode().
> 
> Updates in V9:
>  - Modify the annotations in __sdhci_uhs2_send_command().
> 
> Updates in V8:
>  - Adjust the position of matching brackets in
>    sdhci_uhs2_send_command_retry().
>  - Modify CameCase definition in __sdhci_uhs2_finish_command().
>  - Modify error message in __sdhci_uhs2_finish_command().
>  - sdhci_uhs2_send_command_retry() to instead of sdhci_uhs2_send_command()
>    in sdhci_uhs2_request().
>  - Use sdhci_uhs2_mode() to simplify code in sdhci_uhs2_request_atomic().
>  - Add forward declaration for sdhci_send_command().
> 
> Updates in V7:
>  - Cancel export state of some functions.
>  - Remove unnecessary whitespace changes.
> 
> Updates in V6:
>  - Add uhs2_dev_cmd() to simplify code.
>  - Remove unnecessary functions.
>  - Cancel export state of some functions.
>  - Drop use CONFIG_MMC_DEBUG().
>  - Wrap at 100 columns in some functions.
> 
> ---
> 
>  drivers/mmc/host/sdhci-uhs2.c | 377 ++++++++++++++++++++++++++++++++++
>  drivers/mmc/host/sdhci.c      |  53 +++--
>  drivers/mmc/host/sdhci.h      |   8 +
>  3 files changed, 422 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
> index a521e3dbfca7..31486e28496d 100644
> --- a/drivers/mmc/host/sdhci-uhs2.c
> +++ b/drivers/mmc/host/sdhci-uhs2.c
> @@ -14,6 +14,8 @@
>  #include <linux/module.h>
>  #include <linux/iopoll.h>
>  #include <linux/bitfield.h>
> +#include <linux/mmc/mmc.h>
> +#include <linux/mmc/host.h>
>  
>  #include "sdhci.h"
>  #include "sdhci-uhs2.h"
> @@ -29,6 +31,8 @@
>  #define UHS2_INTERFACE_DETECT_TIMEOUT_100MS	100000
>  #define UHS2_LANE_SYNC_TIMEOUT_150MS		150000
>  
> +#define UHS2_ARG_IOADR_MASK 0xfff
> +
>  void sdhci_uhs2_dump_regs(struct sdhci_host *host)
>  {
>  	if (!(mmc_card_uhs2(host->mmc)))
> @@ -63,6 +67,11 @@ EXPORT_SYMBOL_GPL(sdhci_uhs2_dump_regs);
>   *                                                                           *
>  \*****************************************************************************/
>  
> +static inline u16 uhs2_dev_cmd(struct mmc_command *cmd)
> +{
> +	return be16_to_cpu((__be16)cmd->uhs2_cmd->arg) & UHS2_ARG_IOADR_MASK;
> +}
> +
>  static inline int mmc_opt_regulator_set_ocr(struct mmc_host *mmc,
>  					    struct regulator *supply,
>  					    unsigned short vdd_bit)
> @@ -528,6 +537,373 @@ static int sdhci_uhs2_control(struct mmc_host *mmc, enum sd_uhs2_operation op)
>  	return err;
>  }
>  
> +/*****************************************************************************\
> + *                                                                           *
> + * Core functions                                                            *
> + *                                                                           *
> +\*****************************************************************************/
> +
> +static void sdhci_uhs2_prepare_data(struct sdhci_host *host, struct mmc_command *cmd)
> +{
> +	struct mmc_data *data = cmd->data;
> +
> +	sdhci_initialize_data(host, data);
> +
> +	sdhci_prepare_dma(host, data);
> +
> +	sdhci_writew(host, data->blksz, SDHCI_UHS2_BLOCK_SIZE);
> +	sdhci_writew(host, data->blocks, SDHCI_UHS2_BLOCK_COUNT);
> +}
> +
> +static void sdhci_uhs2_finish_data(struct sdhci_host *host)
> +{
> +	struct mmc_data *data = host->data;
> +
> +	__sdhci_finish_data_common(host, true);
> +
> +	__sdhci_finish_mrq(host, data->mrq);
> +}
> +
> +static void sdhci_uhs2_set_transfer_mode(struct sdhci_host *host, struct mmc_command *cmd)
> +{
> +	u16 mode;
> +	struct mmc_data *data = cmd->data;
> +
> +	if (!data) {
> +		/* clear Auto CMD settings for no data CMDs */
> +		if (uhs2_dev_cmd(cmd) == UHS2_DEV_CMD_TRANS_ABORT) {
> +			mode =  0;
> +		} else {
> +			mode = sdhci_readw(host, SDHCI_UHS2_TRANS_MODE);
> +			if (cmd->opcode == MMC_STOP_TRANSMISSION || cmd->opcode == MMC_ERASE)
> +				mode |= SDHCI_UHS2_TRNS_WAIT_EBSY;
> +			else
> +				/* send status mode */
> +				if (cmd->opcode == MMC_SEND_STATUS)
> +					mode = 0;
> +		}
> +
> +		DBG("UHS2 no data trans mode is 0x%x.\n", mode);
> +
> +		sdhci_writew(host, mode, SDHCI_UHS2_TRANS_MODE);
> +		return;
> +	}
> +
> +	WARN_ON(!host->data);
> +
> +	mode = SDHCI_UHS2_TRNS_BLK_CNT_EN | SDHCI_UHS2_TRNS_WAIT_EBSY;
> +	if (data->flags & MMC_DATA_WRITE)
> +		mode |= SDHCI_UHS2_TRNS_DATA_TRNS_WRT;
> +
> +	if (data->blocks == 1 &&
> +	    data->blksz != 512 &&
> +	    cmd->opcode != MMC_READ_SINGLE_BLOCK &&
> +	    cmd->opcode != MMC_WRITE_BLOCK) {
> +		mode &= ~SDHCI_UHS2_TRNS_BLK_CNT_EN;
> +		mode |= SDHCI_UHS2_TRNS_BLK_BYTE_MODE;
> +	}
> +
> +	if (host->flags & SDHCI_REQ_USE_DMA)
> +		mode |= SDHCI_UHS2_TRNS_DMA;
> +
> +	if (cmd->uhs2_cmd->tmode_half_duplex)
> +		mode |= SDHCI_UHS2_TRNS_2L_HD;
> +
> +	sdhci_writew(host, mode, SDHCI_UHS2_TRANS_MODE);
> +
> +	DBG("UHS2 trans mode is 0x%x.\n", mode);
> +}
> +
> +static void __sdhci_uhs2_send_command(struct sdhci_host *host, struct mmc_command *cmd)
> +{
> +	int i, j;
> +	int cmd_reg;
> +
> +	i = 0;
> +	sdhci_writel(host,
> +		     ((u32)cmd->uhs2_cmd->arg << 16) |
> +				(u32)cmd->uhs2_cmd->header,
> +		     SDHCI_UHS2_CMD_PACKET + i);
> +	i += 4;
> +
> +	/*
> +	 * Per spec, payload (config) should be MSB before sending out.
> +	 * But we don't need convert here because had set payload as
> +	 * MSB when preparing config read/write commands.
> +	 */
> +	for (j = 0; j < cmd->uhs2_cmd->payload_len / sizeof(u32); j++) {
> +		sdhci_writel(host, *(cmd->uhs2_cmd->payload + j), SDHCI_UHS2_CMD_PACKET + i);
> +		i += 4;
> +	}
> +
> +	for ( ; i < SDHCI_UHS2_CMD_PACK_MAX_LEN; i += 4)
> +		sdhci_writel(host, 0, SDHCI_UHS2_CMD_PACKET + i);
> +
> +	DBG("UHS2 CMD packet_len = %d.\n", cmd->uhs2_cmd->packet_len);
> +	for (i = 0; i < cmd->uhs2_cmd->packet_len; i++)
> +		DBG("UHS2 CMD_PACKET[%d] = 0x%x.\n", i,
> +		    sdhci_readb(host, SDHCI_UHS2_CMD_PACKET + i));
> +
> +	cmd_reg = FIELD_PREP(SDHCI_UHS2_CMD_PACK_LEN_MASK, cmd->uhs2_cmd->packet_len);
> +	if ((cmd->flags & MMC_CMD_MASK) == MMC_CMD_ADTC)
> +		cmd_reg |= SDHCI_UHS2_CMD_DATA;
> +	if (cmd->opcode == MMC_STOP_TRANSMISSION)
> +		cmd_reg |= SDHCI_UHS2_CMD_CMD12;
> +
> +	/* UHS2 Native ABORT */
> +	if ((cmd->uhs2_cmd->header & UHS2_NATIVE_PACKET) &&
> +	    (uhs2_dev_cmd(cmd) == UHS2_DEV_CMD_TRANS_ABORT))
> +		cmd_reg |= SDHCI_UHS2_CMD_TRNS_ABORT;
> +
> +	/* UHS2 Native DORMANT */
> +	if ((cmd->uhs2_cmd->header & UHS2_NATIVE_PACKET) &&
> +	    (uhs2_dev_cmd(cmd) == UHS2_DEV_CMD_GO_DORMANT_STATE))
> +		cmd_reg |= SDHCI_UHS2_CMD_DORMANT;
> +
> +	DBG("0x%x is set to UHS2 CMD register.\n", cmd_reg);
> +
> +	sdhci_writew(host, cmd_reg, SDHCI_UHS2_CMD);
> +}
> +
> +static bool sdhci_uhs2_send_command(struct sdhci_host *host, struct mmc_command *cmd)
> +{
> +	int flags;
> +	u32 mask;
> +	unsigned long timeout;
> +
> +	WARN_ON(host->cmd);
> +
> +	/* Initially, a command has no error */
> +	cmd->error = 0;
> +
> +	if (cmd->opcode == MMC_STOP_TRANSMISSION)
> +		cmd->flags |= MMC_RSP_BUSY;
> +
> +	mask = SDHCI_CMD_INHIBIT;
> +
> +	if (sdhci_readl(host, SDHCI_PRESENT_STATE) & mask)
> +		return false;
> +
> +	host->cmd = cmd;
> +	host->data_timeout = 0;
> +	if (sdhci_data_line_cmd(cmd)) {
> +		WARN_ON(host->data_cmd);
> +		host->data_cmd = cmd;
> +		__sdhci_uhs2_set_timeout(host);
> +	}
> +
> +	if (cmd->data)
> +		sdhci_uhs2_prepare_data(host, cmd);
> +
> +	sdhci_uhs2_set_transfer_mode(host, cmd);
> +
> +	if ((cmd->flags & MMC_RSP_136) && (cmd->flags & MMC_RSP_BUSY)) {
> +		WARN_ONCE(1, "Unsupported response type!\n");
> +		/*
> +		 * This does not happen in practice because 136-bit response
> +		 * commands never have busy waiting, so rather than complicate
> +		 * the error path, just remove busy waiting and continue.
> +		 */
> +		cmd->flags &= ~MMC_RSP_BUSY;
> +	}
> +
> +	if (!(cmd->flags & MMC_RSP_PRESENT))
> +		flags = SDHCI_CMD_RESP_NONE;
> +	else if (cmd->flags & MMC_RSP_136)
> +		flags = SDHCI_CMD_RESP_LONG;
> +	else if (cmd->flags & MMC_RSP_BUSY)
> +		flags = SDHCI_CMD_RESP_SHORT_BUSY;
> +	else
> +		flags = SDHCI_CMD_RESP_SHORT;
> +
> +	if (cmd->flags & MMC_RSP_CRC)
> +		flags |= SDHCI_CMD_CRC;
> +	if (cmd->flags & MMC_RSP_OPCODE)
> +		flags |= SDHCI_CMD_INDEX;
> +
> +	timeout = jiffies;
> +	if (host->data_timeout)
> +		timeout += nsecs_to_jiffies(host->data_timeout);
> +	else if (!cmd->data && cmd->busy_timeout > 9000)
> +		timeout += DIV_ROUND_UP(cmd->busy_timeout, 1000) * HZ + HZ;
> +	else
> +		timeout += 10 * HZ;
> +	sdhci_mod_timer(host, cmd->mrq, timeout);
> +
> +	__sdhci_uhs2_send_command(host, cmd);
> +
> +	return true;
> +}
> +
> +static bool sdhci_uhs2_send_command_retry(struct sdhci_host *host,
> +					  struct mmc_command *cmd,
> +					  unsigned long flags)
> +	__releases(host->lock)
> +	__acquires(host->lock)
> +{
> +	struct mmc_command *deferred_cmd = host->deferred_cmd;
> +	int timeout = 10; /* Approx. 10 ms */
> +	bool present;
> +
> +	while (!sdhci_uhs2_send_command(host, cmd)) {
> +		if (!timeout--) {
> +			pr_err("%s: Controller never released inhibit bit(s).\n",
> +			       mmc_hostname(host->mmc));
> +			sdhci_dumpregs(host);
> +			cmd->error = -EIO;
> +			return false;
> +		}
> +
> +		spin_unlock_irqrestore(&host->lock, flags);
> +
> +		usleep_range(1000, 1250);
> +
> +		present = host->mmc->ops->get_cd(host->mmc);
> +
> +		spin_lock_irqsave(&host->lock, flags);
> +
> +		/* A deferred command might disappear, handle that */
> +		if (cmd == deferred_cmd && cmd != host->deferred_cmd)
> +			return true;
> +
> +		if (sdhci_present_error(host, cmd, present))
> +			return false;
> +	}
> +
> +	if (cmd == host->deferred_cmd)
> +		host->deferred_cmd = NULL;
> +
> +	return true;
> +}
> +
> +static void __sdhci_uhs2_finish_command(struct sdhci_host *host)
> +{
> +	struct mmc_command *cmd = host->cmd;
> +	u8 resp;
> +	u8 error_code;
> +	bool breada0 = 0;
> +	int i;
> +
> +	if (host->mmc->uhs2_sd_tran) {
> +		resp = sdhci_readb(host, SDHCI_UHS2_RESPONSE + 2);
> +		if (resp & UHS2_RES_NACK_MASK) {
> +			error_code = (resp >> UHS2_RES_ECODE_POS) & UHS2_RES_ECODE_MASK;
> +			pr_err("%s: NACK response, ECODE=0x%x.\n",
> +			       mmc_hostname(host->mmc), error_code);
> +		}
> +		breada0 = 1;
> +	}
> +
> +	if (cmd->uhs2_cmd->uhs2_resp &&
> +	    cmd->uhs2_cmd->uhs2_resp_len && cmd->uhs2_cmd->uhs2_resp_len <= 20) {

As Ben wrote for V17, cmd->uhs2_cmd->uhs2_resp is alway true.  Probably
better to separate out the uhs2_resp_len safety check also e.g.

	if (cmd->uhs2_cmd->uhs2_resp_len) {
		int len = min_t(int, cmd->uhs2_cmd->uhs2_resp_len, UHS2_MAX_RESP_LEN);

> +		/* Get whole response of some native CCMD, like
> +		 * DEVICE_INIT, ENUMERATE.
> +		 */
> +		for (i = 0; i < cmd->uhs2_cmd->uhs2_resp_len; i++)

		for (i = 0; i < len; i++)

> +			cmd->uhs2_cmd->uhs2_resp[i] = sdhci_readb(host, SDHCI_UHS2_RESPONSE + i);
> +	} else {
> +		/* Get SD CMD response and Payload for some read
> +		 * CCMD, like INQUIRY_CFG.
> +		 */
> +		/* Per spec (p136), payload field is divided into
> +		 * a unit of DWORD and transmission order within
> +		 * a DWORD is big endian.
> +		 */
> +		if (!breada0)
> +			sdhci_readl(host, SDHCI_UHS2_RESPONSE);
> +		for (i = 4; i < 20; i += 4) {
> +			cmd->resp[i / 4 - 1] =
> +				(sdhci_readb(host,
> +					     SDHCI_UHS2_RESPONSE + i) << 24) |
> +				(sdhci_readb(host,
> +					     SDHCI_UHS2_RESPONSE + i + 1)
> +					<< 16) |
> +				(sdhci_readb(host,
> +					     SDHCI_UHS2_RESPONSE + i + 2)
> +					<< 8) |
> +				sdhci_readb(host, SDHCI_UHS2_RESPONSE + i + 3);
> +		}
> +	}
> +}
> +
> +static void sdhci_uhs2_finish_command(struct sdhci_host *host)
> +{
> +	struct mmc_command *cmd = host->cmd;
> +
> +	__sdhci_uhs2_finish_command(host);
> +
> +	host->cmd = NULL;
> +
> +	if (cmd->mrq->cap_cmd_during_tfr && cmd == cmd->mrq->cmd)
> +		mmc_command_done(host->mmc, cmd->mrq);
> +
> +	/*
> +	 * The host can send and interrupt when the busy state has
> +	 * ended, allowing us to wait without wasting CPU cycles.
> +	 * The busy signal uses DAT0 so this is similar to waiting
> +	 * for data to complete.
> +	 *
> +	 * Note: The 1.0 specification is a bit ambiguous about this
> +	 *       feature so there might be some problems with older
> +	 *       controllers.
> +	 */
> +	if (cmd->flags & MMC_RSP_BUSY) {
> +		if (cmd->data) {
> +			DBG("Cannot wait for busy signal when also doing a data transfer");
> +		} else if (!(host->quirks & SDHCI_QUIRK_NO_BUSY_IRQ) &&
> +			   cmd == host->data_cmd) {
> +			/* Command complete before busy is ended */
> +			return;
> +		}
> +	}
> +
> +	/* Processed actual command. */
> +	if (host->data && host->data_early)
> +		sdhci_uhs2_finish_data(host);
> +
> +	if (!cmd->data)
> +		__sdhci_finish_mrq(host, cmd->mrq);
> +}
> +
> +static void sdhci_uhs2_request(struct mmc_host *mmc, struct mmc_request *mrq)
> +{
> +	struct sdhci_host *host = mmc_priv(mmc);
> +	struct mmc_command *cmd;
> +	unsigned long flags;
> +	bool present;
> +
> +	if (!(mmc_card_uhs2(mmc))) {
> +		sdhci_request(mmc, mrq);
> +		return;
> +	}
> +
> +	mrq->stop = NULL;
> +	mrq->sbc = NULL;
> +	if (mrq->data)
> +		mrq->data->stop = NULL;
> +
> +	/* Firstly check card presence */
> +	present = mmc->ops->get_cd(mmc);
> +
> +	spin_lock_irqsave(&host->lock, flags);
> +
> +	if (sdhci_present_error(host, mrq->cmd, present))
> +		goto out_finish;
> +
> +	cmd = mrq->cmd;
> +
> +	if (!sdhci_uhs2_send_command_retry(host, cmd, flags))
> +		goto out_finish;
> +
> +	spin_unlock_irqrestore(&host->lock, flags);
> +
> +	return;
> +
> +out_finish:
> +	sdhci_finish_mrq(host, mrq);
> +	spin_unlock_irqrestore(&host->lock, flags);
> +}
> +
>  /*****************************************************************************\
>   *                                                                           *
>   * Driver init/exit                                                          *
> @@ -537,6 +913,7 @@ static int sdhci_uhs2_control(struct mmc_host *mmc, enum sd_uhs2_operation op)
>  static int sdhci_uhs2_host_ops_init(struct sdhci_host *host)
>  {
>  	host->mmc_host_ops.uhs2_control = sdhci_uhs2_control;
> +	host->mmc_host_ops.request = sdhci_uhs2_request;
>  
>  	return 0;
>  }
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 63fa1714930a..a43a3b8d7b8b 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -147,10 +147,11 @@ void sdhci_enable_v4_mode(struct sdhci_host *host)
>  }
>  EXPORT_SYMBOL_GPL(sdhci_enable_v4_mode);
>  
> -static inline bool sdhci_data_line_cmd(struct mmc_command *cmd)
> +bool sdhci_data_line_cmd(struct mmc_command *cmd)
>  {
>  	return cmd->data || cmd->flags & MMC_RSP_BUSY;
>  }
> +EXPORT_SYMBOL_GPL(sdhci_data_line_cmd);
>  
>  static void sdhci_set_card_detection(struct sdhci_host *host, bool enable)
>  {
> @@ -502,14 +503,15 @@ static inline void sdhci_led_deactivate(struct sdhci_host *host)
>  
>  #endif
>  
> -static void sdhci_mod_timer(struct sdhci_host *host, struct mmc_request *mrq,
> -			    unsigned long timeout)
> +void sdhci_mod_timer(struct sdhci_host *host, struct mmc_request *mrq,
> +		     unsigned long timeout)
>  {
>  	if (sdhci_data_line_cmd(mrq->cmd))
>  		mod_timer(&host->data_timer, timeout);
>  	else
>  		mod_timer(&host->timer, timeout);
>  }
> +EXPORT_SYMBOL_GPL(sdhci_mod_timer);
>  
>  static void sdhci_del_timer(struct sdhci_host *host, struct mmc_request *mrq)
>  {
> @@ -1076,8 +1078,7 @@ static void sdhci_set_timeout(struct sdhci_host *host, struct mmc_command *cmd)
>  		__sdhci_set_timeout(host, cmd);
>  }
>  
> -static void sdhci_initialize_data(struct sdhci_host *host,
> -				  struct mmc_data *data)
> +void sdhci_initialize_data(struct sdhci_host *host, struct mmc_data *data)
>  {
>  	WARN_ON(host->data);
>  
> @@ -1090,6 +1091,7 @@ static void sdhci_initialize_data(struct sdhci_host *host,
>  	host->data_early = 0;
>  	host->data->bytes_xfered = 0;
>  }
> +EXPORT_SYMBOL_GPL(sdhci_initialize_data);
>  
>  static inline void sdhci_set_block_info(struct sdhci_host *host,
>  					struct mmc_data *data)
> @@ -1112,12 +1114,8 @@ static inline void sdhci_set_block_info(struct sdhci_host *host,
>  	}
>  }
>  
> -static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_command *cmd)
> +void sdhci_prepare_dma(struct sdhci_host *host, struct mmc_data *data)
>  {
> -	struct mmc_data *data = cmd->data;
> -
> -	sdhci_initialize_data(host, data);
> -
>  	if (host->flags & (SDHCI_USE_SDMA | SDHCI_USE_ADMA)) {
>  		struct scatterlist *sg;
>  		unsigned int length_mask, offset_mask;
> @@ -1202,6 +1200,16 @@ static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_command *cmd)
>  	}
>  
>  	sdhci_set_transfer_irqs(host);
> +}
> +EXPORT_SYMBOL_GPL(sdhci_prepare_dma);
> +
> +static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_command *cmd)
> +{
> +	struct mmc_data *data = cmd->data;
> +
> +	sdhci_initialize_data(host, data);
> +
> +	sdhci_prepare_dma(host, data);
>  
>  	sdhci_set_block_info(host, data);
>  }
> @@ -1519,7 +1527,7 @@ static void sdhci_set_mrq_done(struct sdhci_host *host, struct mmc_request *mrq)
>  	WARN_ON(i >= SDHCI_MAX_MRQS);
>  }
>  
> -static void __sdhci_finish_mrq(struct sdhci_host *host, struct mmc_request *mrq)
> +void __sdhci_finish_mrq(struct sdhci_host *host, struct mmc_request *mrq)
>  {
>  	if (host->cmd && host->cmd->mrq == mrq)
>  		host->cmd = NULL;
> @@ -1543,15 +1551,17 @@ static void __sdhci_finish_mrq(struct sdhci_host *host, struct mmc_request *mrq)
>  	if (!sdhci_has_requests(host))
>  		sdhci_led_deactivate(host);
>  }
> +EXPORT_SYMBOL_GPL(__sdhci_finish_mrq);
>  
> -static void sdhci_finish_mrq(struct sdhci_host *host, struct mmc_request *mrq)
> +void sdhci_finish_mrq(struct sdhci_host *host, struct mmc_request *mrq)
>  {
>  	__sdhci_finish_mrq(host, mrq);
>  
>  	queue_work(host->complete_wq, &host->complete_work);
>  }
> +EXPORT_SYMBOL_GPL(sdhci_finish_mrq);
>  
> -static void __sdhci_finish_data(struct sdhci_host *host, bool sw_data_timeout)
> +void __sdhci_finish_data_common(struct sdhci_host *host, bool defer_reset)
>  {
>  	struct mmc_command *data_cmd = host->data_cmd;
>  	struct mmc_data *data = host->data;
> @@ -1564,7 +1574,9 @@ static void __sdhci_finish_data(struct sdhci_host *host, bool sw_data_timeout)
>  	 * conditions.
>  	 */
>  	if (data->error) {
> -		if (!host->cmd || host->cmd == data_cmd)
> +		if (defer_reset)
> +			host->pending_reset = true;
> +		else if (!host->cmd || host->cmd == data_cmd)
>  			sdhci_reset_for(host, REQUEST_ERROR);
>  		else
>  			sdhci_reset_for(host, REQUEST_ERROR_DATA_ONLY);
> @@ -1585,6 +1597,14 @@ static void __sdhci_finish_data(struct sdhci_host *host, bool sw_data_timeout)
>  		data->bytes_xfered = 0;
>  	else
>  		data->bytes_xfered = data->blksz * data->blocks;
> +}
> +EXPORT_SYMBOL_GPL(__sdhci_finish_data_common);
> +
> +static void __sdhci_finish_data(struct sdhci_host *host, bool sw_data_timeout)
> +{
> +	struct mmc_data *data = host->data;
> +
> +	__sdhci_finish_data_common(host, false);
>  
>  	/*
>  	 * Need to send CMD12 if -
> @@ -1719,8 +1739,8 @@ static bool sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
>  	return true;
>  }
>  
> -static bool sdhci_present_error(struct sdhci_host *host,
> -				struct mmc_command *cmd, bool present)
> +bool sdhci_present_error(struct sdhci_host *host,
> +			 struct mmc_command *cmd, bool present)
>  {
>  	if (!present || host->flags & SDHCI_DEVICE_DEAD) {
>  		cmd->error = -ENOMEDIUM;
> @@ -1729,6 +1749,7 @@ static bool sdhci_present_error(struct sdhci_host *host,
>  
>  	return false;
>  }
> +EXPORT_SYMBOL_GPL(sdhci_present_error);
>  
>  static bool sdhci_send_command_retry(struct sdhci_host *host,
>  				     struct mmc_command *cmd,
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index 5c66927210bd..ff53ad592d85 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -827,6 +827,14 @@ static inline void sdhci_read_caps(struct sdhci_host *host)
>  	__sdhci_read_caps(host, NULL, NULL, NULL);
>  }
>  
> +bool sdhci_data_line_cmd(struct mmc_command *cmd);
> +void sdhci_mod_timer(struct sdhci_host *host, struct mmc_request *mrq, unsigned long timeout);
> +void sdhci_initialize_data(struct sdhci_host *host, struct mmc_data *data);
> +void sdhci_prepare_dma(struct sdhci_host *host, struct mmc_data *data);
> +void __sdhci_finish_mrq(struct sdhci_host *host, struct mmc_request *mrq);
> +void sdhci_finish_mrq(struct sdhci_host *host, struct mmc_request *mrq);
> +void __sdhci_finish_data_common(struct sdhci_host *host, bool defer_reset);
> +bool sdhci_present_error(struct sdhci_host *host, struct mmc_command *cmd, bool present);
>  u16 sdhci_calc_clk(struct sdhci_host *host, unsigned int clock,
>  		   unsigned int *actual_clock);
>  void sdhci_set_clock(struct sdhci_host *host, unsigned int clock);

