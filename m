From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH 04/18] mmc: meson-gx: improve meson_mmc_start_cmd
Date: Wed, 15 Feb 2017 20:43:07 +0100
Message-ID: <2e7e1407-fcee-b760-8cd6-183d68cabc26@gmail.com>
References: <420b75a9-b8c2-b3d7-ae60-3ed8a5a18ead@gmail.com>
 <df8da322-6a42-642c-2c80-55fca0dab3ef@gmail.com>
 <m2h93vbd2b.fsf@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:35633 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750719AbdBOTqT (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 15 Feb 2017 14:46:19 -0500
Received: by mail-wr0-f196.google.com with SMTP id q39so1788816wrb.2
        for <linux-mmc@vger.kernel.org>; Wed, 15 Feb 2017 11:46:18 -0800 (PST)
In-Reply-To: <m2h93vbd2b.fsf@baylibre.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kevin Hilman <khilman@baylibre.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Carlo Caione <carlo@caione.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-amlogic@lists.infradead.org

Am 15.02.2017 um 18:04 schrieb Kevin Hilman:
> Heiner Kallweit <hkallweit1@gmail.com> writes:
> 
>> Remove use of unneeded members cmd_arg and cmd_resp.
>> Setting SD_EMMC_CMD_RSP is only needed if CMD_CFG_RESP_NUM is set,
>> so don't write this register in all other cases.
>>
>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> 
> I'm not sure I like this change.  This works now because there is only
> one descriptor used, but one of the next things to work on in this
> driver is taking advantage of the internal DMA capabilities, which means
> having a chain of descriptorsall filled out in memory.
> 
For testing purposes I temporarily changed the driver from passing the
descriptor in registers to passing the descriptor via DMA and it worked.

I'm not very familiar (yet) with descriptor chains and have to check
the MMC core code a little bit more ..
If we can actually benefit from it then I'd agree with you.


> Kevin
> 
>> ---
>>  drivers/mmc/host/meson-gx-mmc.c | 6 ++----
>>  1 file changed, 2 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
>> index ece38b44..630e0590 100644
>> --- a/drivers/mmc/host/meson-gx-mmc.c
>> +++ b/drivers/mmc/host/meson-gx-mmc.c
>> @@ -456,7 +456,6 @@ static void meson_mmc_start_cmd(struct mmc_host *mmc, struct mmc_command *cmd)
>>  	desc->cmd_cfg |= (cmd->opcode & CMD_CFG_CMD_INDEX_MASK)	<<
>>  		CMD_CFG_CMD_INDEX_SHIFT;
>>  	desc->cmd_cfg |= CMD_CFG_OWNER;  /* owned by CPU */
>> -	desc->cmd_arg = cmd->arg;
>>  
>>  	/* Response */
>>  	if (cmd->flags & MMC_RSP_PRESENT) {
>> @@ -464,7 +463,7 @@ static void meson_mmc_start_cmd(struct mmc_host *mmc, struct mmc_command *cmd)
>>  		if (cmd->flags & MMC_RSP_136)
>>  			desc->cmd_cfg |= CMD_CFG_RESP_128;
>>  		desc->cmd_cfg |= CMD_CFG_RESP_NUM;
>> -		desc->cmd_resp = 0;
>> +		writel(0, host->regs + SD_EMMC_CMD_RSP);
>>  
>>  		if (!(cmd->flags & MMC_RSP_CRC))
>>  			desc->cmd_cfg |= CMD_CFG_RESP_NOCRC;
>> @@ -540,9 +539,8 @@ static void meson_mmc_start_cmd(struct mmc_host *mmc, struct mmc_command *cmd)
>>  	desc->cmd_cfg |= CMD_CFG_END_OF_CHAIN;
>>  	writel(desc->cmd_cfg, host->regs + SD_EMMC_CMD_CFG);
>>  	writel(desc->cmd_data, host->regs + SD_EMMC_CMD_DAT);
>> -	writel(desc->cmd_resp, host->regs + SD_EMMC_CMD_RSP);
>>  	wmb(); /* ensure descriptor is written before kicked */
>> -	writel(desc->cmd_arg, host->regs + SD_EMMC_CMD_ARG);
>> +	writel(cmd->arg, host->regs + SD_EMMC_CMD_ARG);
>>  }
>>  
>>  static void meson_mmc_request(struct mmc_host *mmc, struct mmc_request *mrq)
> 

