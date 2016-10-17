From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 7/10] mmc: sdhci-xenon: Add support to PHYs of Marvell
 Xenon SDHC
Date: Mon, 17 Oct 2016 10:55:26 +0300
Message-ID: <63e2bacf-6ad9-5e20-2c49-e77eb362ccfc@intel.com>
References: <cover.990e3503c30c18ecf50dd48bce3d52811f03ca22.1475853198.git-series.gregory.clement@free-electrons.com>
 <e08ffb085d02a784b28456ac47fa4dc6540a9139.1475853198.git-series.gregory.clement@free-electrons.com>
 <bfe30317-bb3b-b3dc-e9df-87b6ba100307@intel.com>
 <bcf4abca-9f2e-6d1b-6690-d672766e18cb@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <bcf4abca-9f2e-6d1b-6690-d672766e18cb@marvell.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ziji Hu <huziji@marvell.com>, Gregory CLEMENT <gregory.clement@free-electrons.com>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Cc: Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, linux-arm-kernel@lists.infradead.org, "Jack(SH) Zhu" <jmzhu@marvell.com>, Jimmy Xu <zmxu@marvell.com>, Jisheng Zhang <jszhang@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Ryan Gao <ygao@marvell.com>, Doug Jones <dougj@marvell.com>, Shiwu Zhang <zhangshw@marvell.com>, Victor Gu <xigu@marvell.com>, "Wei(SOCP) Liu" <liuw@marvell.com>, Wilson Ding <dingwei@marvell.com>, Xueping Liu <xpliu@marvell.com>, Hilbert Zhang <zzhang@marvell.com>, Liuliu Zhao <zhaoliul@marvell.com>, Peng Zhu <zhupeng@marvell.com>, Yu Cao <yucao@ma>
List-Id: linux-mmc@vger.kernel.org

On 12/10/16 15:17, Ziji Hu wrote:
> Hi Adrian,
> 
> On 2016/10/11 20:39, Adrian Hunter wrote:
>> On 07/10/16 18:22, Gregory CLEMENT wrote:
>>> From: Ziji Hu <huziji@marvell.com>
>>>
>>> Marvell Xenon eMMC/SD/SDIO Host Controller contains PHY.
>>> Three types of PHYs are supported.
>>>
>>> Add support to multiple types of PHYs init and configuration.
>>> Add register definitions of PHYs.
>>>
>>> Signed-off-by: Hu Ziji <huziji@marvell.com>
>>> Reviewed-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
>>> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
>>> ---
>>>  MAINTAINERS                        |    1 +-
>>>  drivers/mmc/host/Makefile          |    2 +-
>>>  drivers/mmc/host/sdhci-xenon-phy.c | 1141 +++++++++++++++++++++++++++++-
>>>  drivers/mmc/host/sdhci-xenon-phy.h |  157 ++++-
>>>  drivers/mmc/host/sdhci-xenon.c     |    4 +-
>>>  drivers/mmc/host/sdhci-xenon.h     |   17 +-
>>>  6 files changed, 1321 insertions(+), 1 deletion(-)
>>>  create mode 100644 drivers/mmc/host/sdhci-xenon-phy.c
>>>  create mode 100644 drivers/mmc/host/sdhci-xenon-phy.h
>>>
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index 859420e5dfd3..b5673c2ee5f2 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -7583,6 +7583,7 @@ M:	Ziji Hu <huziji@marvell.com>
>>>  L:	linux-mmc@vger.kernel.org
>>>  S:	Supported
>>>  F:	drivers/mmc/host/sdhci-xenon.*
>>> +F:	drivers/mmc/host/sdhci-xenon-phy.*
>>>  F:	Documentation/devicetree/bindings/mmc/marvell,sdhci-xenon.txt
>>>  
>>>  MATROX FRAMEBUFFER DRIVER
>>> diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
>>> index 75eaf743486c..4f2854556ff7 100644
>>> --- a/drivers/mmc/host/Makefile
>>> +++ b/drivers/mmc/host/Makefile
>>> @@ -82,4 +82,4 @@ ifeq ($(CONFIG_CB710_DEBUG),y)
>>>  endif
>>>  
>>>  obj-$(CONFIG_MMC_SDHCI_XENON)	+= sdhci-xenon-driver.o
>>> -sdhci-xenon-driver-y		+= sdhci-xenon.o
>>> +sdhci-xenon-driver-y		+= sdhci-xenon.o sdhci-xenon-phy.o
>>> diff --git a/drivers/mmc/host/sdhci-xenon-phy.c b/drivers/mmc/host/sdhci-xenon-phy.c
>>> new file mode 100644
>>> index 000000000000..4eb8fea1bec9
>>> --- /dev/null
>>> +++ b/drivers/mmc/host/sdhci-xenon-phy.c
>>
>> <SNIP>
>>
>>> +static int __xenon_emmc_delay_adj_test(struct mmc_card *card)
>>> +{
>>> +	int err;
>>> +	u8 *ext_csd = NULL;
>>> +
>>> +	err = mmc_get_ext_csd(card, &ext_csd);
>>> +	kfree(ext_csd);
>>> +
>>> +	return err;
>>> +}
>>> +
>>> +static int __xenon_sdio_delay_adj_test(struct mmc_card *card)
>>> +{
>>> +	struct mmc_command cmd = {0};
>>> +	int err;
>>> +
>>> +	cmd.opcode = SD_IO_RW_DIRECT;
>>> +	cmd.flags = MMC_RSP_R5 | MMC_CMD_AC;
>>> +
>>> +	err = mmc_wait_for_cmd(card->host, &cmd, 0);
>>> +	if (err)
>>> +		return err;
>>> +
>>> +	if (cmd.resp[0] & R5_ERROR)
>>> +		return -EIO;
>>> +	if (cmd.resp[0] & R5_FUNCTION_NUMBER)
>>> +		return -EINVAL;
>>> +	if (cmd.resp[0] & R5_OUT_OF_RANGE)
>>> +		return -ERANGE;
>>> +	return 0;
>>> +}
>>> +
>>> +static int __xenon_sd_delay_adj_test(struct mmc_card *card)
>>> +{
>>> +	struct mmc_command cmd = {0};
>>> +	int err;
>>> +
>>> +	cmd.opcode = MMC_SEND_STATUS;
>>> +	cmd.arg = card->rca << 16;
>>> +	cmd.flags = MMC_RSP_R1 | MMC_CMD_AC;
>>> +
>>> +	err = mmc_wait_for_cmd(card->host, &cmd, 0);
>>> +	return err;
>>> +}
>>> +
>>> +static int xenon_delay_adj_test(struct mmc_card *card)
>>> +{
>>> +	WARN_ON(!card);
>>> +	WARN_ON(!card->host);
>>> +
>>> +	if (mmc_card_mmc(card))
>>> +		return __xenon_emmc_delay_adj_test(card);
>>> +	else if (mmc_card_sd(card))
>>> +		return __xenon_sd_delay_adj_test(card);
>>> +	else if (mmc_card_sdio(card))
>>> +		return __xenon_sdio_delay_adj_test(card);
>>> +	else
>>> +		return -EINVAL;
>>> +}
>>
>> So you are issuing commands from the ->set_ios() callback.  I would want to
>> get Ulf's OK for that before going further.
>>
> 	Yes, you are correct.
> 	In some speed mode, Xenon SDHC has to send a series of transfers to search for a perfect sampling point in PHY delay line.
> 	It is like tuning process.
> 
>> One thing: you will need to ensure you don't trigger get HS400 re-tuning
>> because it will call back into ->set_ios().
>>
> 	Could you please make the term "HS400 re-tuning" more detailed?
> 	In current MMC driver, "HS400 re-tuning" will go back to HS200, execute HS200 tuning and come back to HS400.
> 	I'm sure our Xenon SDHC will not execute it.

Currently, re-tuning is automatically enabled whenever tuning is executed,
and then re-tuning will be done periodically or after CRC errors.  The
function to disable re-tuning mmc_retune_disable() is not exported, however
if you have you are determining the sampling point your own way, you could
simply not implement ->execute_tuning() and then there would be no tuning
and no re-tuning.

> 
> 	However, in coming eMMC 5.2, there is a real HS400 re-tuning, in which tuning can be directly executed in HS400 mode.
> 	Our Xenon SDHC will neither trigger this HS400 re-tuning.
> 	But since so far there is no such feature in MMC driver, I cannot give you a 100% guarantee now.
> 
>> And you have the problem that you need to get a reference to the card before
>> the card device has been added.  As I wrote in response to the previous
>> patch, you should get Ulf's help with that too.
>>
> 	Sure.
> 	I will get card_candidate solved at first.
> 	Thank you again for your review and help.
> 
> 	Thank you.
> 
> Best regards,
> Hu Ziji
>>
> 
