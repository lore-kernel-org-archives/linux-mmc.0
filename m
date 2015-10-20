From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH v3 2/3] mmc: sdhci-of-arasan: add phy support for
 sdhci-of-arasan
Date: Tue, 20 Oct 2015 16:25:18 +0800
Message-ID: <5625FA6E.8070000@rock-chips.com>
References: <1445324718-31407-1-git-send-email-shawn.lin@rock-chips.com>
 <5625EDAB.70707@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.132]:33186 "EHLO
	lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753425AbbJTIkS (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 20 Oct 2015 04:40:18 -0400
In-Reply-To: <5625EDAB.70707@xilinx.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Michal Simek <michal.simek@xilinx.com>, Ulf Hansson <ulf.hansson@linaro.org>, soren.brinkmann@xilinx.com
Cc: shawn.lin@rock-chips.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

On 2015/10/20 15:30, Michal Simek wrote:
> Hi,
>
> On 10/20/2015 09:05 AM, Shawn Lin wrote:
>> This patch adds Generic PHY access for sdhci-of-arasan. Driver
>> can get PHY handler from dt-binding, and power-on/init the PHY.
>> Also we add pm ops for PHY here if CONFIG_PM_SLEEP is enabled.
>> Currently, it's just mandatory for arasan,sdhci-5.1.
>>
>> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
>>
>> Serise-changes: 3
>> - remove phy_init/exit for suspend/resume
>> - adjust phy_int/power_on seq to make code more reasonable
>> - simplify suspend/resume_phy
>>
>> Serise-changes: 2
>> - Keep phy as a mandatory requirement for arasan,sdhci-5.1
>>
>> ---
>>
>> Changes in v2: None
>>
>>   drivers/mmc/host/sdhci-of-arasan.c | 87 ++++++++++++++++++++++++++=
++++++++++++
>>   1 file changed, 87 insertions(+)
>>
>> diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/s=
dhci-of-arasan.c
>> index 75379cb..85bd0f9d 100644
>> --- a/drivers/mmc/host/sdhci-of-arasan.c
>> +++ b/drivers/mmc/host/sdhci-of-arasan.c
>> @@ -21,6 +21,7 @@
>>
>>   #include <linux/module.h>
>>   #include <linux/of_device.h>
>> +#include <linux/phy/phy.h>
>>   #include "sdhci-pltfm.h"
>>
>>   #define SDHCI_ARASAN_CLK_CTRL_OFFSET	0x2c
>> @@ -35,6 +36,7 @@
>>    */
>>   struct sdhci_arasan_data {
>>   	struct clk	*clk_ahb;
>> +	struct phy	*phy;
>>   };
>>
>>   static unsigned int sdhci_arasan_get_timeout_clock(struct sdhci_ho=
st *host)
>> @@ -70,6 +72,42 @@ static struct sdhci_pltfm_data sdhci_arasan_pdata=
 =3D {
>>
>>   #ifdef CONFIG_PM_SLEEP
>>   /**
>> +  * sdhci_arasan_suspend_phy - Suspend phy method for the driver
>> +  * @phy:        Handler of phy structure
>> +  * Returns 0 on success and error value on error
>> +  *
>> +  * Put the phy in a deactive state.
>> +  */
>
> This is not kernel-doc format.
> Try this and fix it.
>
> ./scripts/kernel-doc -man -v drivers/mmc/host/sdhci-of-arasan.c > /de=
v/null
>

okay, I will try to fix it.

>> +static int sdhci_arasan_suspend_phy(struct phy *phy)
>> +{
>> +	int ret =3D 0;
>> +
>> +	ret =3D phy_power_off(phy);
>> +	if (ret)
>> +		phy_power_on(phy);
>
> I am curious about this logic. If power_off fails I would expect that
> phy could still have power_on. Or not?
>

That depends. From "ret", I cannot tell the failure type, whether it's=20
caused by *real power off fail* or by other generic phy stuff.

So, I think it's better to power_on it again if we can't guarantee phy'=
s=20
state. =EF=BC=9A=EF=BC=89

> Thanks,
> Michal
>
>
>


--=20
Best Regards
Shawn Lin

