From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: Re: [PATCH v2] mmc: sdhci-xenon: add set_power callback
Date: Mon, 28 Aug 2017 17:54:59 +0200
Message-ID: <87val76624.fsf@free-electrons.com>
References: <1503338529-21102-1-git-send-email-zjwu@marvell.com>
        <e37d8951-7e1b-8431-5593-5e693295987f@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:57615 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751184AbdH1PzB (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 28 Aug 2017 11:55:01 -0400
In-Reply-To: <e37d8951-7e1b-8431-5593-5e693295987f@intel.com> (Adrian Hunter's
        message of "Mon, 28 Aug 2017 12:57:43 +0300")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Zhoujie Wu <zjwu@marvell.com>, ulf.hansson@linaro.org, Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc@vger.kernel.org, zmxu@marvell.com, jszhang@marvell.com, nadavh@marvell.com, xigu@marvell.com, dingwei@marvell.com, kostap@marvell.com, hannah@marvell.com, hongd@marvell.com, dougj@marvell.com, ygao@marvell.com, liuw@marvell.com, thomas.petazzoni@free-electrons.com

Hi,
 
 On lun., août 28 2017, Adrian Hunter <adrian.hunter@intel.com> wrote:

> On 21/08/17 21:02, Zhoujie Wu wrote:
>> Xenon sdh controller requests proper SD bus voltage select
>> bits programmed even with vmmc power supply. Any reserved
>> value(100b-000b) programmed in this field will lead to controller
>> ignore SD bus power bit and keep its value at zero.
>> Add set_power callback to handle this.
>> 
>> Signed-off-by: Zhoujie Wu <zjwu@marvell.com>
>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>

I tested this patch on the Armada 3720 DB board. And thanks to this patch
and by adding a vmmc regulator in the device tree I did not have anymore
the issue UHS card not detected on warm reset.

Tested-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

Actually for me this should be a fix. Indeed if I try to use a vmmc
regulator without this patch then the SD card does not work at all I
only have the following messages:

"mmc1: Timeout waiting for hardware cmd interrupt."

Thanks,

Gregory


>
>> ---
>> Updated according to Jisheng Zhang's comment.
>>  drivers/mmc/host/sdhci-xenon.c | 19 +++++++++++++++++++
>>  1 file changed, 19 insertions(+)
>> 
>> diff --git a/drivers/mmc/host/sdhci-xenon.c b/drivers/mmc/host/sdhci-xenon.c
>> index edd4d915..a4be2fd 100644
>> --- a/drivers/mmc/host/sdhci-xenon.c
>> +++ b/drivers/mmc/host/sdhci-xenon.c
>> @@ -210,8 +210,27 @@ static void xenon_set_uhs_signaling(struct sdhci_host *host,
>>  	sdhci_writew(host, ctrl_2, SDHCI_HOST_CONTROL2);
>>  }
>>  
>> +static void xenon_set_power(struct sdhci_host *host, unsigned char mode,
>> +		unsigned short vdd)
>> +{
>> +	struct mmc_host *mmc = host->mmc;
>> +	u8 pwr = host->pwr;
>> +
>> +	sdhci_set_power_noreg(host, mode, vdd);
>> +
>> +	if (host->pwr == pwr)
>> +		return;
>> +
>> +	if (host->pwr == 0)
>> +		vdd = 0;
>> +
>> +	if (!IS_ERR(mmc->supply.vmmc))
>> +		mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, vdd);
>> +}
>> +
>>  static const struct sdhci_ops sdhci_xenon_ops = {
>>  	.set_clock		= sdhci_set_clock,
>> +	.set_power		= xenon_set_power,
>>  	.set_bus_width		= sdhci_set_bus_width,
>>  	.reset			= xenon_reset,
>>  	.set_uhs_signaling	= xenon_set_uhs_signaling,
>> 
>

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
