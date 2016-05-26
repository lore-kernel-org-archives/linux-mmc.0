From: Ritesh Harjani <ritesh.list@gmail.com>
Subject: Re: [PATCH 09/23] mmc: sdhci: fix incorrect get data interrupt during
 no data transfer
Date: Thu, 26 May 2016 20:29:05 +0530
Message-ID: <CALk7dXq=Yv-a8UEbBqgxSEnDEOD1fuAkZhFnP8oyEmoPsrVCrw@mail.gmail.com>
References: <1460741387-23815-1-git-send-email-aisheng.dong@nxp.com>
	<1460741387-23815-10-git-send-email-aisheng.dong@nxp.com>
	<573184F3.50201@intel.com>
	<CALk7dXpDXS2R0RJ9KNTaMFxBC+VVvrJ+U1X5Z_kZJNxwxrC6iQ@mail.gmail.com>
	<573AB323.1080207@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-io0-f193.google.com ([209.85.223.193]:36345 "EHLO
	mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754095AbcEZO7H (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 26 May 2016 10:59:07 -0400
Received: by mail-io0-f193.google.com with SMTP id m17so2200244ioi.3
        for <linux-mmc@vger.kernel.org>; Thu, 26 May 2016 07:59:06 -0700 (PDT)
In-Reply-To: <573AB323.1080207@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Dong Aisheng <aisheng.dong@nxp.com>, linux-mmc <linux-mmc@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, chris@printf.net, shawnguo@kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, haibo.chen@nxp.com, Dong Aisheng <dongas86@gmail.com>

Hi Adrian,


On Tue, May 17, 2016 at 11:28 AM, Adrian Hunter <adrian.hunter@intel.com> wrote:
> On 17/05/16 07:31, Ritesh Harjani wrote:
>> On Tue, May 10, 2016 at 12:21 PM, Adrian Hunter <adrian.hunter@intel.com> wrote:
>>> On 15/04/16 20:29, Dong Aisheng wrote:
>>>> Current code will report the wrong data interrupt got when no
>>>> data operation in progress assumed by getting !host->data in
>>>> sdhci_data_irq().
>>>>
>>>> For a data command handling process, the driver will call
>>>> sdhci_finish_data() and clear host->data in case any data error,
>>>> then card finish_tasklet will do the rest controller reset work.
>>>>
>>>> Before the tasklet got run, however, controllers may report the
>>>> TC(Transfer Complete) interrupt (SDHCI_INT_DATA_END) a bit later
>>>> than data CRC error and data end bit error interrupts for single
>>>> block transfer or the last block of multiblock transfer.
>>
>> What if the controller generates Transfer complete interrupt bit more slower
>> and the tasklet do get a chance to run. In that case even host->mrq
>> will become NULL.
>> Actually if that happens it's even more worse since the driver may
>> start issuing other commands to controller.
>>
>> Are we covering that case here? Do you think that this case is possible?
>
> After data error, the host driver resets the controller so there will be no
> more interrupts relating to that mrq.
Resetting will happen in sdhci_tasklet_finish.
My case was -
1. Controller raised a Data CRC error.
2. sdhci_irq made host->data = NULL in sdhci_finish_data and scheduled
the finish_tasklet.
3. while the tasklet is running and before resetting CMD and Data
machine, TC interrupt is raised by controller.
4. sdhci_irq will call for sdhci_data_irq.

But I get it that the second interrupt will end up printing the same
error since host->data will be found as NULL in sdhci_data_irq and
will return.
So below patch should do the job :)

>
> This patch is avoiding unnecessary warnings until that happens.
Yes.



>
>>
>>
>>>>
>>>> Controller usually detects and generates data CRC/end bit error
>>>> interrupts once one block on the bus is transferred completely.
>>>> For single block transfer, since there's only one bock to transfer,
>>>> the controller will report transfer complete interrupt as well,
>>>> but until the data in controller FIFO has been successfully
>>>> transferred to memory. The time gap of TC and CRC interrupt depends on
>>>> the system busy state at that point and memory bus access speed.
>>>>
>>>> So it is possible when TC interrupt generated, host->data is already
>>>> equal to NULL due to cleared by former CRC/Data End Bit error which
>>>> is reasonable.
>>>>
>>>> Thus we DO NOT report the weird data interrupt event for this case.
>>>>
>>>> Else we may easily see warning below during SD3.0 card manually tuning
>>>> process (calling mmc_send_tuning() which is a single block transfer)
>>>> mmc0: Got data interrupt 0x00000002 even though no data operation was in progress
>>>>
>>>> The detailed command log is as follows:
>>>> [ 1657.920983] mmc0: starting CMD19 arg 00000000 flags 00000035
>>>> [ 1657.921009] mmc0:     blksz 64 blocks 1 flags 00000200 tsac 150 ms nsac 0
>>>> [ 1657.921085] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00200001
>>>> [ 1657.921112] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000002
>>>> [ 1657.921131] mmc0: Got data interrupt 0x00000002 even though no data operation was in progress.
>>>> [ 1657.929761] sdhci: =========== REGISTER DUMP (mmc0)===========
>>>> [ 1657.929780] sdhci: Sys addr: 0x3d5d6380 | Version:  0x00000002
>>>> [ 1657.929796] sdhci: Blk size: 0x00000040 | Blk cnt:  0x00000001
>>>> [ 1657.929814] sdhci: Argument: 0x00000000 | Trn mode: 0x00000013
>>>> [ 1657.929831] sdhci: Present:  0x01fd8008 | Host ctl: 0x00000023
>>>> [ 1657.929847] sdhci: Power:    0x00000002 | Blk gap:  0x00000080
>>>> [ 1657.929863] sdhci: Wake-up:  0x00000008 | Clock:    0x0000000f
>>>> [ 1657.929879] sdhci: Timeout:  0x0000000f | Int stat: 0x00000000
>>>> [ 1657.929896] sdhci: Int enab: 0x107f008b | Sig enab: 0x107f008b
>>>> [ 1657.929914] sdhci: AC12 err: 0x00000000 | Slot int: 0x00000003
>>>> [ 1657.929932] sdhci: Caps:     0x07eb0000 | Caps_1:   0x00002007
>>>> [ 1657.929949] sdhci: Cmd:      0x0000133a | Max curr: 0x00ffffff
>>>> [ 1657.929965] sdhci: Host ctl2: 0x000000c8
>>>> [ 1657.929981] sdhci: ADMA Err: 0x00000000 | ADMA Ptr: 0x8f042208
>>>> [ 1657.929995] sdhci: ===========================================
>>>> [ 1657.930156] mmc0: req done (CMD19): 0: 00000900 00000000 00000000 00000000
>>>> [ 1657.930179] mmc0:     0 bytes transferred: -84
>>>>
>>>> It shows we first have a data CRC error interrupt then a data transfer
>>>> complete interrupt.
>>>> Then we got the !host->data case in sdhci_data_irq().
>>>>
>>>> CC: stable <stable@vger.kernel.org>
>>>> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
>>>> ---
>>>>  drivers/mmc/host/sdhci.c | 11 +++++++++++
>>>>  1 file changed, 11 insertions(+)
>>>>
>>>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>>>> index 40e3551..2eb0e34 100644
>>>> --- a/drivers/mmc/host/sdhci.c
>>>> +++ b/drivers/mmc/host/sdhci.c
>>>> @@ -2325,6 +2325,17 @@ static void sdhci_data_irq(struct sdhci_host *host, u32 intmask)
>>>>                       }
>>>>               }
>>>>
>>>> +             /*
>>>> +              * The "data complete" interrupt is possible to happen a bit
>>>> +              * later than CRC error and data end bit error interrupts
>>>> +              * separately for single block transfer or the last block of
>>>> +              * multiblock transfer. For this case, we DO NOT report the
>>>> +              * weird data interrupt event.
>>>> +              */
>>>> +             if ((intmask & SDHCI_INT_DATA_END) &&
>>>> +                 (host->mrq && host->mrq->data && host->mrq->data->error))
>>>> +                     return;
>>>
>>> This could be generalized a bit more i.e. what about:
>>>
>>>                 /*
>>>                  * After an error and before the the data circuit is reset in
>>>                  * sdhci_tasklet_finish, we could get more interrupts, but we
>>>                  * already have an error, so ignore them.
>>>                  */
>>>                 if (host->mrq && host->mrq->data && host->mrq->data->error)
>>>                         return;
>>>
>>>> +
>>>>               pr_err("%s: Got data interrupt 0x%08x even though no data operation was in progress.\n",
>>>>                      mmc_hostname(host->mmc), (unsigned)intmask);
>>>>               sdhci_dumpregs(host);
>>>>
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
