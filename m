From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH] mmc: sdhci-of-arasan: Get quirks from device tree
Date: Tue, 28 Jul 2015 09:07:14 +0800
Message-ID: <55B6D5C2.4080907@rock-chips.com>
References: <1437984249-18332-1-git-send-email-shawn.lin@rock-chips.com>
 <55B5EA96.6020604@monstr.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from regular1.263xmail.com ([211.150.99.134]:53685 "EHLO
	regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753316AbbG1BHZ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 27 Jul 2015 21:07:25 -0400
In-Reply-To: <55B5EA96.6020604@monstr.eu>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: monstr@monstr.eu, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, Michal Simek <michal.simek@xilinx.com>, linux-kernel@vger.kernel.org, =?UTF-8?Q?S=c3=b6ren_Brinkmann?= <soren.brinkmann@xilinx.com>, linux-arm-kernel@lists.infradead.org

On 2015/7/27 16:23, Michal Simek wrote:
> On 07/27/2015 10:04 AM, Shawn Lin wrote:
>> This patch adds the interface to get quirks from dts, and
>> there is no need to assign different quirks by condition statement
>> of arasan IP version.
>>
>> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
>> ---
>>
>>   drivers/mmc/host/sdhci-of-arasan.c | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/s=
dhci-of-arasan.c
>> index ef5a7d2..db07788 100644
>> --- a/drivers/mmc/host/sdhci-of-arasan.c
>> +++ b/drivers/mmc/host/sdhci-of-arasan.c
>> @@ -132,6 +132,7 @@ static SIMPLE_DEV_PM_OPS(sdhci_arasan_dev_pm_ops=
, sdhci_arasan_suspend,
>>   static int sdhci_arasan_probe(struct platform_device *pdev)
>>   {
>>   	int ret;
>> +	u32 quirktab[2];
>>   	struct clk *clk_xin;
>>   	struct sdhci_host *host;
>>   	struct sdhci_pltfm_host *pltfm_host;
>> @@ -172,6 +173,12 @@ static int sdhci_arasan_probe(struct platform_d=
evice *pdev)
>>   		goto clk_disable_all;
>>   	}
>>  =20
>> +	if (of_property_read_u32_array(pdev->dev.of_node,
>> +				       "arasan,quirks", &quirktab[0], 2)) {
> This is not documented anywhere that's why you should send binding to=
 DT
> mailing list and get ACK for it.
Thanks, Michal. You'r right, and  forgive me, a green hand, for my=20
inappropriate patch.
>> +		host->quirks |=3D quirktab[0];
>> +		host->quirks2 |=3D quirktab[1];
>> +	}
>> +
>>   	if (of_device_is_compatible(pdev->dev.of_node, "arasan,sdhci-4.9a=
")) {
>>   		host->quirks |=3D SDHCI_QUIRK_NO_HISPD_BIT;
>>   		host->quirks2 |=3D SDHCI_QUIRK2_HOST_NO_CMD23;
>>
> Also is there any binding which is done in this way?
Thanks.
BTW:
I got a FPGA board w/ a sdhci-arasn emmc controller & PHY IP which can=20
support emmc version 5.1.
But I cannot find any documented details from  IP databook for the=20
vendor version, such as "sdhci-4.9a".
The only one is "ACS eMMC5.1 PHY IP uses TSMC ESD I/O protection=20
structures TMSC  product name
tphn28hpcgv2od3 Version 120a". Is "sdhci-120a" the version if  I add a=20
compatib node?
Kindly hope you can elaborate more =EF=BC=9A)
> Thanks,
> Michal
>


