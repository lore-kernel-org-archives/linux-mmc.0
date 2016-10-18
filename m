From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 7/10] mmc: sdhci-xenon: Add support to PHYs of Marvell
 Xenon SDHC
Date: Tue, 18 Oct 2016 16:09:14 +0300
Message-ID: <d63c5272-9085-d54f-e827-ca6b9b324aab@intel.com>
References: <cover.990e3503c30c18ecf50dd48bce3d52811f03ca22.1475853198.git-series.gregory.clement@free-electrons.com>
 <e08ffb085d02a784b28456ac47fa4dc6540a9139.1475853198.git-series.gregory.clement@free-electrons.com>
 <bfe30317-bb3b-b3dc-e9df-87b6ba100307@intel.com>
 <bcf4abca-9f2e-6d1b-6690-d672766e18cb@marvell.com>
 <63e2bacf-6ad9-5e20-2c49-e77eb362ccfc@intel.com>
 <d6e1c702-1dfe-3993-da28-01cf01f24b4a@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:32604 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755097AbcJRNOL (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 18 Oct 2016 09:14:11 -0400
In-Reply-To: <d6e1c702-1dfe-3993-da28-01cf01f24b4a@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ziji Hu <huziji@marvell.com>, Gregory CLEMENT <gregory.clement@free-electrons.com>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Cc: Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, linux-arm-kernel@lists.infradead.org, "Jack(SH) Zhu" <jmzhu@marvell.com>, Jimmy Xu <zmxu@marvell.com>, Jisheng Zhang <jszhang@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Ryan Gao <ygao@marvell.com>, Doug Jones <dougj@marvell.com>, Shiwu Zhang <zhangshw@marvell.com>, Victor Gu <xigu@marvell.com>, "Wei(SOCP) Liu" <liuw@marvell.com>, Wilson Ding <dingwei@marvell.com>, Xueping Liu <xpliu@marvell.com>, Hilbert Zhang <zzhang@marvell.com>, Liuliu Zhao <zhaoliul@marvell.com>, Peng Zhu <zhupeng@marvell.com>, Yu Cao <yucao@ma>

On 18/10/16 15:04, Ziji Hu wrote:
> Hi Adrian,
> 
> On 2016/10/17 15:55, Adrian Hunter wrote:
>> On 12/10/16 15:17, Ziji Hu wrote:
>>> Hi Adrian,
>>>
>>> On 2016/10/11 20:39, Adrian Hunter wrote:
> <snip>
>>>>> +static int __xenon_emmc_delay_adj_test(struct mmc_card *card)
>>>>> +{
>>>>> +	int err;
>>>>> +	u8 *ext_csd = NULL;
>>>>> +
>>>>> +	err = mmc_get_ext_csd(card, &ext_csd);
>>>>> +	kfree(ext_csd);
>>>>> +
>>>>> +	return err;
>>>>> +}
>>>>> +
>>>>> +static int __xenon_sdio_delay_adj_test(struct mmc_card *card)
>>>>> +{
>>>>> +	struct mmc_command cmd = {0};
>>>>> +	int err;
>>>>> +
>>>>> +	cmd.opcode = SD_IO_RW_DIRECT;
>>>>> +	cmd.flags = MMC_RSP_R5 | MMC_CMD_AC;
>>>>> +
>>>>> +	err = mmc_wait_for_cmd(card->host, &cmd, 0);
>>>>> +	if (err)
>>>>> +		return err;
>>>>> +
>>>>> +	if (cmd.resp[0] & R5_ERROR)
>>>>> +		return -EIO;
>>>>> +	if (cmd.resp[0] & R5_FUNCTION_NUMBER)
>>>>> +		return -EINVAL;
>>>>> +	if (cmd.resp[0] & R5_OUT_OF_RANGE)
>>>>> +		return -ERANGE;
>>>>> +	return 0;
>>>>> +}
>>>>> +
>>>>> +static int __xenon_sd_delay_adj_test(struct mmc_card *card)
>>>>> +{
>>>>> +	struct mmc_command cmd = {0};
>>>>> +	int err;
>>>>> +
>>>>> +	cmd.opcode = MMC_SEND_STATUS;
>>>>> +	cmd.arg = card->rca << 16;
>>>>> +	cmd.flags = MMC_RSP_R1 | MMC_CMD_AC;
>>>>> +
>>>>> +	err = mmc_wait_for_cmd(card->host, &cmd, 0);
>>>>> +	return err;
>>>>> +}
>>>>> +
>>>>> +static int xenon_delay_adj_test(struct mmc_card *card)
>>>>> +{
>>>>> +	WARN_ON(!card);
>>>>> +	WARN_ON(!card->host);
>>>>> +
>>>>> +	if (mmc_card_mmc(card))
>>>>> +		return __xenon_emmc_delay_adj_test(card);
>>>>> +	else if (mmc_card_sd(card))
>>>>> +		return __xenon_sd_delay_adj_test(card);
>>>>> +	else if (mmc_card_sdio(card))
>>>>> +		return __xenon_sdio_delay_adj_test(card);
>>>>> +	else
>>>>> +		return -EINVAL;
>>>>> +}
>>>>
>>>> So you are issuing commands from the ->set_ios() callback.  I would want to
>>>> get Ulf's OK for that before going further.
>>>>
>>> 	Yes, you are correct.
>>> 	In some speed mode, Xenon SDHC has to send a series of transfers to search for a perfect sampling point in PHY delay line.
>>> 	It is like tuning process.
>>>
>>>> One thing: you will need to ensure you don't trigger get HS400 re-tuning
>>>> because it will call back into ->set_ios().
>>>>
>>> 	Could you please make the term "HS400 re-tuning" more detailed?
>>> 	In current MMC driver, "HS400 re-tuning" will go back to HS200, execute HS200 tuning and come back to HS400.
>>> 	I'm sure our Xenon SDHC will not execute it.
>>
>> Currently, re-tuning is automatically enabled whenever tuning is executed,
>> and then re-tuning will be done periodically or after CRC errors.  The
>> function to disable re-tuning mmc_retune_disable() is not exported, however
>> if you have you are determining the sampling point your own way, you could
>> simply not implement ->execute_tuning() and then there would be no tuning
>> and no re-tuning.
>>
> 
> 	It is a little complex in our Xenon SDHC.
> 	For the speed mode which requests tuning, such as SDR104 and HS200, our driver will execute standard tuning as spec requires.
> 	However, for those speed mode in which tuning is not requested in spec, our driver has to issues commands to search for the best sampling point.
> 	
> 	It seems that HS400 re-tuning/tuning is disabled by default. Is it correct?

No, it is enabled by default - there is currently no periodic re-tuning  for
HS400 but CRC errors or runtime suspend / resume will cause re-tuning.

> 
>>>
>>> 	However, in coming eMMC 5.2, there is a real HS400 re-tuning, in which tuning can be directly executed in HS400 mode.
>>> 	Our Xenon SDHC will neither trigger this HS400 re-tuning.
>>> 	But since so far there is no such feature in MMC driver, I cannot give you a 100% guarantee now.
>>>
>>>> And you have the problem that you need to get a reference to the card before
>>>> the card device has been added.  As I wrote in response to the previous
>>>> patch, you should get Ulf's help with that too.
>>>>
>>> 	Sure.
>>> 	I will get card_candidate solved at first.
>>> 	Thank you again for your review and help.
>>>
>>> 	Thank you.
>>>
>>> Best regards,
>>> Hu Ziji
>>>>
>>>
>>
> 

