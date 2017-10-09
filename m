From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: SDIO "SD2" vs. SD-card "SD3" interface on BayTrail
Date: Mon, 9 Oct 2017 11:07:39 +0300
Message-ID: <00e1d3fa-87b1-6247-7894-806ba0fa7fbd@intel.com>
References: <d7249bf2-b057-0535-334e-71cdc957e9b5@denx.de>
 <1499176431.22624.255.camel@linux.intel.com>
 <8a909116-5fec-e7d0-5d30-de8de42612df@denx.de>
 <dc49d8be-dd15-167b-2ab4-d09d1b6ea83d@intel.com>
 <849da4e5-4333-39c4-d546-8e87ae794954@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:57676 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750795AbdJIIPQ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 9 Oct 2017 04:15:16 -0400
In-Reply-To: <849da4e5-4333-39c4-d546-8e87ae794954@denx.de>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Stefan Roese <sr@denx.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-mmc@vger.kernel.org

On 07/10/17 11:25, Stefan Roese wrote:
> Hi,
> 
> On 31.08.2017 14:41, Adrian Hunter wrote:
>> On 31/08/17 12:38, Stefan Roese wrote:
>>> Hi Andy, Hi Adrian,
>>>
>>> On 04.07.2017 15:53, Andy Shevchenko wrote:
>>>> On Tue, 2017-07-04 at 14:53 +0200, Stefan Roese wrote:
>>>>> Hi,
>>>>>
>>>>> we are currently investigating, if its possible to connect a SDIO
>>>>> device (WLAN module) to the SD-card interface "SD3" of the BayTrail
>>>>> SoC instead of the SDIO interface "SD2". The BayTrail manual states,
>>>>> that the SDIO interface is capable of connecting SDIO devices. Is
>>>>> this also possible for the SD-card interface "SD3", even if its not
>>>>> explicitly mentioned in the manual? If not, why is this not possible?
>>>>>
>>>>> Any insight on this would be really helpful.
>>>>
>>>> Hmm... I have no documentation for SD/SDIO/eMMC for BayTrail except the
>>>> public one. Internally I found some charts that shows similarities
>>>> between two. So, taking that into consideration I would suggest to try
>>>> it out on real hardware (MinnowBoard MAX, for example), only impediment
>>>> I can see is the absence of support in the drivers in Linux OS. If you
>>>> need it only in U-Boot, you perhaps may fix it easily.
>>>>
>>>> P.S. Adrian on vacation.
>>>
>>> I hope your vacation was great!
>>>
>>> Sorry for getting back to this, but I would really like to get some
>>> more feedback on this. Perhaps Adrian has some additional comments
>>> about the SDIO usage of the SD interface (SD3 - PCI Device ID 0x0f16)
>>> on BayTrail.
>>>
>>> I'm now running latest mainline Linux on this board and am trying to
>>> get the Linux MMC / SDIO subsystem to just detect a device on this
>>> SD PCI interface. For this I have added quite a bit of debug code to
>>> the MMC / SDIO code to see, if any device is detected on the SDIO
>>> port. But all command queries return timeout as far as I can tell.
>>
>> I would usually interpret that to mean the SDIO card is not turned on.
>>
>>> Adrian, do you have some additional information, if this mode of
>>> operation is possible at all on this SD-card interface, even if
>>> its not explicitly mentioned in the BayTrail datasheet?
>>
>> I have used removable SDIO cards in SD slots before.  It should work.
> 
> A quick update with another question below:
> 
> After getting back to this issue, I now have the SD-card detection
> working, if I boot into Linux using U-Boot as bootloader on this
> BayTrail based board. But when I boot via original BIOS, the card
> detection fails. While debugging, I found that one register differs
> in both setups:
> 
> U-Boot:
> [    2.374751] mmc0: sdhci: ============ SDHCI REGISTER DUMP ===========
> [    2.374761] mmc0: sdhci: Sys addr:  0x00000000 | Version:  0x0000b502
> [    2.374768] mmc0: sdhci: Blk size:  0x00000000 | Blk cnt:  0x00000000
> [    2.374774] mmc0: sdhci: Argument:  0x00000000 | Trn mode: 0x00000000
> [    2.374781] mmc0: sdhci: Present:   0x1fff0000 | Host ctl: 0x00000000
> [    2.374787] mmc0: sdhci: Power:     0x00000000 | Blk gap:  0x00000000
> [    2.374793] mmc0: sdhci: Wake-up:   0x00000000 | Clock:    0x00000000
> [    2.374799] mmc0: sdhci: Timeout:   0x00000000 | Int stat: 0x00000000
> [    2.374806] mmc0: sdhci: Int enab:  0x00ff0003 | Sig enab: 0x00ff0003
> [    2.374812] mmc0: sdhci: AC12 err:  0x00000000 | Slot int: 0x00000000
> [    2.374819] mmc0: sdhci: Caps:      0x076864b2 | Caps_1:   0x00000000
> [    2.374825] mmc0: sdhci: Cmd:       0x00000000 | Max curr: 0x00000000
> [    2.374831] mmc0: sdhci: Resp[0]:   0x00000000 | Resp[1]:  0x00000000
> [    2.374837] mmc0: sdhci: Resp[2]:   0x00000000 | Resp[3]:  0x00000000
> [    2.374842] mmc0: sdhci: Host ctl2: 0x00000000
> [    2.374849] mmc0: sdhci: ADMA Err:  0x00000000 | ADMA Ptr: 0x00000000
> [    2.374853] mmc0: sdhci: ============================================
> 
> BIOS:
> [    3.435179] mmc0: sdhci: ============ SDHCI REGISTER DUMP ===========
> [    3.435485] mmc0: sdhci: Sys addr:  0x00000000 | Version:  0x0000b502
> [    3.435756] mmc0: sdhci: Blk size:  0x00000000 | Blk cnt:  0x00000000
> [    3.436066] mmc0: sdhci: Argument:  0x00000000 | Trn mode: 0x00000000
> [    3.436338] mmc0: sdhci: Present:   0x01ff0000 | Host ctl: 0x00000000
> [    3.436603] mmc0: sdhci: Power:     0x00000000 | Blk gap:  0x00000000
> [    3.436868] mmc0: sdhci: Wake-up:   0x00000000 | Clock:    0x00000000
> [    3.437166] mmc0: sdhci: Timeout:   0x00000000 | Int stat: 0x00000000
> [    3.437437] mmc0: sdhci: Int enab:  0x00ff0003 | Sig enab: 0x00ff0003
> [    3.437704] mmc0: sdhci: AC12 err:  0x00000000 | Slot int: 0x00000000
> [    3.437969] mmc0: sdhci: Caps:      0x076864b2 | Caps_1:   0x00000000
> [    3.438266] mmc0: sdhci: Cmd:       0x00000000 | Max curr: 0x00000000
> [    3.438537] mmc0: sdhci: Resp[0]:   0x00000000 | Resp[1]:  0x00000000
> [    3.438802] mmc0: sdhci: Resp[2]:   0x00000000 | Resp[3]:  0x00000000
> [    3.439135] mmc0: sdhci: Host ctl2: 0x00000000
> [    3.439334] mmc0: sdhci: ADMA Err:  0x00000000 | ADMA Ptr: 0x00000000
> [    3.439598] mmc0: sdhci: ============================================
> 
> As you can see, the "present" register (SDHCI_PRESENT_STATE at 0x24) is
> different. Its read-only - do you have any idea, why this register is
> set to the non-default value of 0x01ff0000 in the BIOS case?
> 
> BTW: Its set to the default value of 0x1fff0000 for the eMMC controller
> in the BIOS case as well. So only the SD controller has this different

Those pins are DAT[7:4] line signal level.  SD has only 4 lines so the
values perhaps change depending on what the setup has been done for the pin
controller.
