From: Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH 04/18] mmc: meson-gx: improve meson_mmc_start_cmd
Date: Wed, 15 Feb 2017 15:58:09 -0800
Message-ID: <m2zihn57n2.fsf@baylibre.com>
References: <420b75a9-b8c2-b3d7-ae60-3ed8a5a18ead@gmail.com>
        <df8da322-6a42-642c-2c80-55fca0dab3ef@gmail.com>
        <m2h93vbd2b.fsf@baylibre.com>
        <2e7e1407-fcee-b760-8cd6-183d68cabc26@gmail.com>
        <a29bf3be-143a-1ed1-9076-d07f8013c2b4@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pf0-f179.google.com ([209.85.192.179]:35652 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754921AbdBOX6L (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 15 Feb 2017 18:58:11 -0500
Received: by mail-pf0-f179.google.com with SMTP id 202so555947pfx.2
        for <linux-mmc@vger.kernel.org>; Wed, 15 Feb 2017 15:58:11 -0800 (PST)
In-Reply-To: <a29bf3be-143a-1ed1-9076-d07f8013c2b4@gmail.com> (Heiner
        Kallweit's message of "Wed, 15 Feb 2017 22:10:20 +0100")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Carlo Caione <carlo@caione.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-amlogic@lists.infradead.org

Heiner Kallweit <hkallweit1@gmail.com> writes:

> Am 15.02.2017 um 20:43 schrieb Heiner Kallweit:
>> Am 15.02.2017 um 18:04 schrieb Kevin Hilman:
>>> Heiner Kallweit <hkallweit1@gmail.com> writes:
>>>
>>>> Remove use of unneeded members cmd_arg and cmd_resp.
>>>> Setting SD_EMMC_CMD_RSP is only needed if CMD_CFG_RESP_NUM is set,
>>>> so don't write this register in all other cases.
>>>>
>>>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
>>>
>>> I'm not sure I like this change.  This works now because there is only
>>> one descriptor used, but one of the next things to work on in this
>>> driver is taking advantage of the internal DMA capabilities, which means
>>> having a chain of descriptorsall filled out in memory.
>>>
>> For testing purposes I temporarily changed the driver from passing the
>> descriptor in registers to passing the descriptor via DMA and it worked.
>> 
>> I'm not very familiar (yet) with descriptor chains and have to check
>> the MMC core code a little bit more ..
>> If we can actually benefit from it then I'd agree with you.
>> 
> After having had a little bit closer look at the MMC core and descriptor
> chains in general:
> I'm not really sure where descriptor chains would help us. SG lists in
> read / write commands are linearized by the driver via
> sg_copy_[to,from]_buffer already.

Copying to the bounce buffer would be replaced by creating a descriptor
for each SG entry, and creating a descriptor chain.

> Beyond that I don't see any command chaining support in the core
> (prerequisite for command chaining most likely would be that a
> subsequent command must not depend on the response of a previous one).
>
> Maybe somebody with more knowledge about the MMC core and MMC in general
> can shed some light on this ..

I don't know if it's a feature of the core, but the Amlogic vendor
driver does the chained descriptor handling in the driver itself.

Kevin

>>> Kevin
>>>
>>>> ---
>>>>  drivers/mmc/host/meson-gx-mmc.c | 6 ++----
>>>>  1 file changed, 2 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
>>>> index ece38b44..630e0590 100644
>>>> --- a/drivers/mmc/host/meson-gx-mmc.c
>>>> +++ b/drivers/mmc/host/meson-gx-mmc.c
>>>> @@ -456,7 +456,6 @@ static void meson_mmc_start_cmd(struct mmc_host *mmc, struct mmc_command *cmd)
>>>>  	desc->cmd_cfg |= (cmd->opcode & CMD_CFG_CMD_INDEX_MASK)	<<
>>>>  		CMD_CFG_CMD_INDEX_SHIFT;
>>>>  	desc->cmd_cfg |= CMD_CFG_OWNER;  /* owned by CPU */
>>>> -	desc->cmd_arg = cmd->arg;
>>>>  
>>>>  	/* Response */
>>>>  	if (cmd->flags & MMC_RSP_PRESENT) {
>>>> @@ -464,7 +463,7 @@ static void meson_mmc_start_cmd(struct mmc_host *mmc, struct mmc_command *cmd)
>>>>  		if (cmd->flags & MMC_RSP_136)
>>>>  			desc->cmd_cfg |= CMD_CFG_RESP_128;
>>>>  		desc->cmd_cfg |= CMD_CFG_RESP_NUM;
>>>> -		desc->cmd_resp = 0;
>>>> +		writel(0, host->regs + SD_EMMC_CMD_RSP);
>>>>  
>>>>  		if (!(cmd->flags & MMC_RSP_CRC))
>>>>  			desc->cmd_cfg |= CMD_CFG_RESP_NOCRC;
>>>> @@ -540,9 +539,8 @@ static void meson_mmc_start_cmd(struct mmc_host *mmc, struct mmc_command *cmd)
>>>>  	desc->cmd_cfg |= CMD_CFG_END_OF_CHAIN;
>>>>  	writel(desc->cmd_cfg, host->regs + SD_EMMC_CMD_CFG);
>>>>  	writel(desc->cmd_data, host->regs + SD_EMMC_CMD_DAT);
>>>> -	writel(desc->cmd_resp, host->regs + SD_EMMC_CMD_RSP);
>>>>  	wmb(); /* ensure descriptor is written before kicked */
>>>> -	writel(desc->cmd_arg, host->regs + SD_EMMC_CMD_ARG);
>>>> +	writel(cmd->arg, host->regs + SD_EMMC_CMD_ARG);
>>>>  }
>>>>  
>>>>  static void meson_mmc_request(struct mmc_host *mmc, struct mmc_request *mrq)
>>>
>> 
