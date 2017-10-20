From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH 0/9] Enable dw-mmc multi-card support
Date: Fri, 20 Oct 2017 23:06:07 +0900
Message-ID: <f71d94dc-7277-8675-c21e-9c2ec77174e7@samsung.com>
References: <cover.1507315433.git.lsun@mellanox.com>
        <8e433531-8f67-d575-635e-c6ced29f6804@rock-chips.com>
        <CGME20171017155217epcas3p4de2f27b921ce77234a2d3e46e4b17473@epcas3p4.samsung.com>
        <AM2PR05MB07533A822C7CCBA7111FD58FA14C0@AM2PR05MB0753.eurprd05.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <AM2PR05MB07533A822C7CCBA7111FD58FA14C0@AM2PR05MB0753.eurprd05.prod.outlook.com>
Content-language: en-US
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Liming Sun <lsun@mellanox.com>, Shawn Lin <shawn.lin@rock-chips.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Chris Metcalf <cmetcalf@mellanox.com>
List-Id: linux-mmc@vger.kernel.org

Sorry for late this..

On 10/18/2017 12:52 AM, Liming Sun wrote:
>>> Hrm.... it's so unlucky that your patchset comes a little late. As your patch 8 and 9 said, you need them to fix problem for multi-card support, so definitely there was no such use case, and even the code was buggy to support it right? That makes the code hard to read and maintain, so we decide to remove it.
> 
> Thanks for the feedback. Yes, earlier the multi-card support was buggy indeed. We spent some time to debug it and got it working.
> 
>>> Havn'e check the databook for details yet, but I think it's ok to re-introduce multi-slot support if a real user benefits from it. But you need a new patch to silent the log "num-slots property not found, assuming 1 slot is available" as we removed all the num-slots from DT at that time.
> 
> The " num-slots property not found..." log message has already been removed by 8a629d26f back in 2016. Looks like we're good on this one. In dw_mci_probe (), it has code to check pdata->num_slots. If 0, the host->num_slots will be set to 1. So the logic of setting default num_slots seems already there. But correct me if I am wrong.
> 
> Thanks,
> Liming
> 
> -----Original Message-----
> From: Shawn Lin [mailto:shawn.lin@rock-chips.com] 
> Sent: Monday, October 16, 2017 9:36 PM
> To: Liming Sun <lsun@mellanox.com>; Jaehoon Chung <jh80.chung@samsung.com>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>; Rob Herring <robh+dt@kernel.org>; Mark Rutland <mark.rutland@arm.com>; Kukjin Kim <kgene@kernel.org>; Krzysztof Kozlowski <krzk@kernel.org>; shawn.lin@rock-chips.com; linux-mmc@vger.kernel.org; devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-samsung-soc@vger.kernel.org
> Subject: Re: [PATCH 0/9] Enable dw-mmc multi-card support
> 
> 
> On 2017/10/7 3:21, Liming Sun wrote:
>> This series of commits enables the multi-card support for the dw-mmc 
>> controller. It includes two parts as below.
>>
>> The first part (patches 1-7) reverts the series of recent commits that 
>> removed the multi-card support with comments saying there was no such 
>> use case in the real world. Actually this feature is being used in 
>> Mellanox Bluefield SoC and has been requested by customers.
> 
> Hrm.... it's so unlucky that your patchset comes a little late. As your patch 8 and 9 said, you need them to fix problem for multi-card support, so definitely there was no such use case, and even the code was buggy to support it right? That makes the code hard to read and maintain, so we decide to remove it.

Hmm..
Well, if i missed your reply for my removing patch, it's my fault..but i didn't see any reply..
At that time, we didn't see any usage and also now...

Are there any patches for using multi slot? 
e,g) device-tree file or your own driver

If there are big benefits to revert them,  i don't want to back them..during almost 6 years, never use it..

> 
>>
>> The second part (patches 8-9) fixes the DesignWare multi-card support 
>> according to the dw-mmc databook (synnopsys: DesignWare Cores Mobile 
>> Storage Host Databook, 2.70a). It has changes to set the card number 
>> into the CMD register to multiplex requests to different cards when 
>> working in SD_MMC_CEATA mode, set the CTYPE / CLKENA / CDTHRCTL 
>> registers properly according to the spec, and parse the per-card 
>> configuration to match the Linux Documentation 
>> (bindings/mmc/synopsys-dw-mshc.txt).

the second part seems that it's only support since v2.70a..?

> 
> Havn'e check the databook for details yet, but I think it's ok to re-introduce multi-slot support if a real user benefits from it. But you need a new patch to silent the log "num-slots property not found, assuming 1 slot is available" as we removed all the num-slots from DT at that time.
> 
> 
>>
>> Liming Sun (9):
>>    Revert "Documentation: dw-mshc: deprecate num-slots"
>>    Revert "mmc: dw_mmc: remove the unnecessary slot variable"
>>    Revert "mmc: dw_mmc: use the 'slot' instead of 'cur_slot'"
>>    Revert "mmc: dw_mmc: remove the 'id' arguments about functions
>>      relevant to slot"
>>    Revert "mmc: dw_mmc: change the array of slots"
>>    Revert "mmc: dw_mmc: remove the loop about finding slots"
>>    Revert "mmc: dw_mmc: deprecated the "num-slots" property"
>>    mmc: dw_mmc: Support two SD_MMC_CE-ATA cards
>>    mmc: dw_mmc: Parse slot-specific configuration
>>
>>   .../devicetree/bindings/mmc/synopsys-dw-mshc.txt   |  16 +-
>>   drivers/mmc/host/dw_mmc-exynos.c                   |   4 +-
>>   drivers/mmc/host/dw_mmc.c                          | 277 ++++++++++++++++-----
>>   drivers/mmc/host/dw_mmc.h                          |  17 +-
>>   4 files changed, 236 insertions(+), 78 deletions(-)
>>
> 
> 
> 
> 
