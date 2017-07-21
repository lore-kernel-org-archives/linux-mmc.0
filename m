From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH V3 00/11] mmc: Add Command Queue support
Date: Fri, 21 Jul 2017 12:57:55 +0300
Message-ID: <b0800873-a53e-51ce-d916-487a5b8c686a@intel.com>
References: <1497524799-18165-1-git-send-email-adrian.hunter@intel.com>
 <f2428951-3cf3-273f-33a3-c0b3147be2be@rock-chips.com>
 <AM4PR0401MB2324236198EFAB4D89190AD890A60@AM4PR0401MB2324.eurprd04.prod.outlook.com>
 <9168c429-125e-e810-b3b1-1c0500f3b822@rock-chips.com>
 <21a4c300-0323-ddef-7b5c-3821e701f256@rock-chips.com>
 <AM4PR0401MB2324BEA5561C080B697B714590A60@AM4PR0401MB2324.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:34437 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753989AbdGUKEP (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 21 Jul 2017 06:04:15 -0400
In-Reply-To: <AM4PR0401MB2324BEA5561C080B697B714590A60@AM4PR0401MB2324.eurprd04.prod.outlook.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Bough Chen <haibo.chen@nxp.com>, Shawn Lin <shawn.lin@rock-chips.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Dorfman Konstantin <kdorfman@codeaurora.or>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>, Venu Byravarasu <vbyravarasu@nvidia.com>, Linus Walleij <linus.walleij@linaro.org>

On 19/07/17 14:29, Bough Chen wrote:
>> -----Original Message-----
>> From: linux-mmc-owner@vger.kernel.org [mailto:linux-mmc-
>> owner@vger.kernel.org] On Behalf Of Shawn Lin
>> Sent: Wednesday, July 19, 2017 4:43 PM
>> To: Bough Chen <haibo.chen@nxp.com>; Adrian Hunter
>> <adrian.hunter@intel.com>; Ulf Hansson <ulf.hansson@linaro.org>
>> Cc: shawn.lin@rock-chips.com; linux-mmc <linux-mmc@vger.kernel.org>; Alex
>> Lemberg <alex.lemberg@sandisk.com>; Mateusz Nowak
>> <mateusz.nowak@intel.com>; Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>;
>> Jaehoon Chung <jh80.chung@samsung.com>; Dong Aisheng
>> <dongas86@gmail.com>; Das Asutosh <asutoshd@codeaurora.org>; Zhangfei
>> Gao <zhangfei.gao@gmail.com>; Dorfman Konstantin
>> <kdorfman@codeaurora.or>; Sahitya Tummala <stummala@codeaurora.org>;
>> Harjani Ritesh <riteshh@codeaurora.org>; Venu Byravarasu
>> <vbyravarasu@nvidia.com>; Linus Walleij <linus.walleij@linaro.org>
>> Subject: Re: [PATCH V3 00/11] mmc: Add Command Queue support
>>
>> Hi Bough,
>>
>> On 2017/7/19 15:44, Shawn Lin wrote:
>>> Hi Bough,
>>>
>>> On 2017/7/19 13:48, Bough Chen wrote:
>>>>
>>>>> -----Original Message-----
>>>>> From: Shawn Lin [mailto:shawn.lin@rock-chips.com]
>>>>> Sent: Wednesday, July 19, 2017 11:42 AM
>>>>> To: Adrian Hunter <adrian.hunter@intel.com>; Ulf Hansson
>>>>> <ulf.hansson@linaro.org>
>>>>> Cc: shawn.lin@rock-chips.com; linux-mmc <linux-mmc@vger.kernel.org>;
>>>>> Bough Chen <haibo.chen@nxp.com>; Alex Lemberg
>>>>> <alex.lemberg@sandisk.com>; Mateusz Nowak
>> <mateusz.nowak@intel.com>;
>>>>> Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>; Jaehoon Chung
>>>>> <jh80.chung@samsung.com>; Dong Aisheng <dongas86@gmail.com>; Das
>>>>> Asutosh <asutoshd@codeaurora.org>; Zhangfei Gao
>>>>> <zhangfei.gao@gmail.com>; Dorfman Konstantin
>>>>> <kdorfman@codeaurora.org>; David Griego <david.griego@linaro.org>;
>>>>> Sahitya Tummala <stummala@codeaurora.org>; Harjani Ritesh
>>>>> <riteshh@codeaurora.org>; Venu Byravarasu <vbyravarasu@nvidia.com>;
>>>>> Linus Walleij <linus.walleij@linaro.org>
>>>>> Subject: Re: [PATCH V3 00/11] mmc: Add Command Queue support
>>>>>
>>>>> Hi Adrian,
>>>>>
>>>>> On 2017/6/15 19:06, Adrian Hunter wrote:
>>>>>> Hi
>>>>>>
>>>>>> Here is V3 of the hardware command queue patches without the
>>>>>> software command queue patches.
>>>>>>
>>>>>
>>>>> I can now boot my board with v4.13 finally this morning[1] and apply
>>>>> this patchset and add my private patch for supporting CQE for
>>>>> sdhci-of-arasan.
>>>>> Great to see it works and I don't see any regression until now. I
>>>>> need more test but I would appreciate it if Ulf can pick all these
>>>>> up into linux-next that folks can help to test and not need to
>>>>> manually apply them. And it will be easy for me to submit patch for
>>>>> sdhci-of-arasan to support CQE later.
>>>>>
>>>>> I haven't have time to review all these, but I will do it next week.
>>>>> And I will also try to run more iozone/fio to see how much it gains
>>>>> when enabling CQE, comparing to non-CQE support.
>>>>>
>>>>> But at least currently feels free to add:
>>>>>
>>>>> Tested-by: Shawn Lin <shawn.lin@rock-chip.com>
>>>>>
>>>> Hi Shawn,
>>>>
>>>> Do you enable Runtime PM for cqhci? On my side, once enable cqhci
>>>> runtime PM, always get timeout issue, I'm debug this issue these days.
>>>> If not add runtime PM support for cqhci, everything work fine
>>>> including DCMD.
>>>>
>>>
>>> Aha, no!
>>>
>>> I said "I need more test" which should include runtime PM. As you
>>> could see sdhci-of-arsan still lacks proper runtime PM support, so I
>>> will try to hack it locally and re-test cqe then.
>>>
>>
>> Well, I add runtime PM  support for sdhci-of-arasan locally and re-test CQE
>> again. All thing work well as expected for two hours!
>>
>>
> 
> Hi Adrian,
> 
> After debug, I find the root cause of the runtime PM issue for imx8, it is our IC limitation, when we do 
> __cqhci_disable(),  clear CQHCI_ENABLE of register CQHCI_CFG, it will impact the sdhci register 0x48, disable DMA and disable block count.  When I restore these bits, cqhci runtime suspend/resume works well. 
> 
> So now I'd like to add:
> 
> Tested-by: Haibo Chen <haibo.chen@nxp.com>
> 
> [    1.311132] sdhci: Secure Digital Host Controller Interface driver
> [    1.317324] sdhci: Copyright(c) Pierre Ossman
> [    1.322082] sdhci-pltfm: SDHCI platform and OF driver helper
> [    1.328626] mmc0: CQHCI version 5.10
> [    1.375351] mmc0: SDHCI controller on 5b010000.usdhc [5b010000.usdhc] using ADMA
> [    1.391558] galcore 80000000.imx8_gpu_ss: bound 53100000.gpu (ops gpu_ops)
> [    1.398450] Galcore version 6.2.2.93313
> [    1.477485] ledtrig-cpu: registered to indicate activity on CPUs
>  [    1.477984] mmc0: Command Queue Engine enabled
> [    1.478008] mmc0: new HS400 Enhanced strobe MMC card at address 0001
> [    1.478585] mmcblk0: mmc0:0001 032G34 29.1 GiB
> [    1.478741] mmcblk0boot0: mmc0:0001 032G34 partition 1 8.00 MiB
> [    1.478892] mmcblk0boot1: mmc0:0001 032G34 partition 2 8.00 MiB
> [    1.479039] mmcblk0rpmb: mmc0:0001 032G34 partition 3 4.00 MiB
> 
> 

I had to send V4 with 2 small changes:
	Adjusted ...blk_end_request...() for new block status codes
	Fixed CQHCI transaction descriptor for "no DCMD" case

