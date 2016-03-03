From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [RFC PATCH 4/4] mmc: sdhci-of-arasan: overwrite enhanced strobe
 callback
Date: Thu, 3 Mar 2016 19:37:17 +0800
Message-ID: <56D821ED.9090203@rock-chips.com>
References: <1456972557-7994-1-git-send-email-shawn.lin@rock-chips.com>
 <1456972613-8159-1-git-send-email-shawn.lin@rock-chips.com>
 <56D819C4.9080703@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.131]:42326 "EHLO
	lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751386AbcCCLhm (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 3 Mar 2016 06:37:42 -0500
In-Reply-To: <56D819C4.9080703@xilinx.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Michal Simek <michal.simek@xilinx.com>, Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: shawn.lin@rock-chips.com, shawn.lin@kernel-upstream.org, soren.brinkmann@xilinx.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

On 2016/3/3 19:02, Michal Simek wrote:
> On 3.3.2016 03:36, Shawn Lin wrote:
>> Currently sdhci-arasan 5.1 can support enhanced strobe function,
>> but considering the potential requirement in the future for other
>> version IP, we don't limit it just for "arasan,sdhci-5.1". Add
>> cap-enhanced-strobe in DT to enable the function if we'r sure our
>> controller can support it.
>>
>> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
>> ---
>>
>>   drivers/mmc/host/sdhci-of-arasan.c | 20 ++++++++++++++++++++
>>   1 file changed, 20 insertions(+)
>>
>> diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
>> index 1e4b5e0..31f3494 100644
>> --- a/drivers/mmc/host/sdhci-of-arasan.c
>> +++ b/drivers/mmc/host/sdhci-of-arasan.c
>> @@ -24,7 +24,9 @@
>>   #include "sdhci-pltfm.h"
>>
>>   #define SDHCI_ARASAN_CLK_CTRL_OFFSET	0x2c
>> +#define SDHCI_ARASAN_VENDOR_REGISTER	0x78
>
> I was checking our register map and we even don't have this register
> listed as reserved.
> It looks like that this will be related to certain SoC and different SoC
> can use it different location.
> That's why I think this feature and setup should be related to certain
> SoC specific compatible string.

Hi Michal,

I think that is IP version specific because it's inside controller's
databook. But I only have a datasheet released by arasan for 5.1 
controller, so I didn't know if your databook has this register. And
I can't find sdhci spec has a reg to enable this feature either. Looks
strange, but maybe you are right: it also related to certain Soc for
other sdhci variant drivers. But for sdhci-of-arsan, it more likes to
use this register from now on for the future IP version to enable this
feature inside the controller register-range.

Thanks for checking that. Now, I'm more sure about that we should limit
it for 5.1 currently by checking the compatible string.

I expect more comments from ulf and adrian about the other part of code
until I respin the next version.

>
> Thanks,
> Michal
>
>
>
>


-- 
Best Regards
Shawn Lin

