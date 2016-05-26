From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 09/23] mmc: sdhci: fix incorrect get data interrupt during
 no data transfer
Date: Thu, 26 May 2016 14:59:34 +0300
Message-ID: <5746E526.8020001@intel.com>
References: <1460741387-23815-1-git-send-email-aisheng.dong@nxp.com>
 <1460741387-23815-10-git-send-email-aisheng.dong@nxp.com>
 <573184F3.50201@intel.com> <20160526114128.GA23988@shlinux2>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:55483 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753665AbcEZMDh (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 26 May 2016 08:03:37 -0400
In-Reply-To: <20160526114128.GA23988@shlinux2>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Dong Aisheng <dongas86@gmail.com>
Cc: Dong Aisheng <aisheng.dong@nxp.com>, linux-mmc@vger.kernel.org, ulf.hansson@linaro.org, chris@printf.net, shawnguo@kernel.org, linux-arm-kernel@lists.infradead.org, haibo.chen@nxp.com

On 26/05/16 14:41, Dong Aisheng wrote:
> On Tue, May 10, 2016 at 09:51:31AM +0300, Adrian Hunter wrote:
>> On 15/04/16 20:29, Dong Aisheng wrote:
>>> Current code will report the wrong data interrupt got when no
>>> data operation in progress assumed by getting !host->data in
>>> sdhci_data_irq().
>>>
>>> For a data command handling process, the driver will call
>>> sdhci_finish_data() and clear host->data in case any data error,
>>> then card finish_tasklet will do the rest controller reset work.
>>>
>>> Before the tasklet got run, however, controllers may report the
>>> TC(Transfer Complete) interrupt (SDHCI_INT_DATA_END) a bit later
>>> than data CRC error and data end bit error interrupts for single
>>> block transfer or the last block of multiblock transfer.
>>>
>>> Controller usually detects and generates data CRC/end bit error
>>> interrupts once one block on the bus is transferred completely.
>>> For single block transfer, since there's only one bock to transfer,
>>> the controller will report transfer complete interrupt as well,
>>> but until the data in controller FIFO has been successfully
>>> transferred to memory. The time gap of TC and CRC interrupt depends on
>>> the system busy state at that point and memory bus access speed.
>>>
>>> So it is possible when TC interrupt generated, host->data is already
>>> equal to NULL due to cleared by former CRC/Data End Bit error which
>>> is reasonable.
>>>
>>> Thus we DO NOT report the weird data interrupt event for this case.
>>>
>>> Else we may easily see warning below during SD3.0 card manually tuning
>>> process (calling mmc_send_tuning() which is a single block transfer)
>>> mmc0: Got data interrupt 0x00000002 even though no data operation was in progress
>>>
>>> The detailed command log is as follows:
>>> [ 1657.920983] mmc0: starting CMD19 arg 00000000 flags 00000035
>>> [ 1657.921009] mmc0:     blksz 64 blocks 1 flags 00000200 tsac 150 ms nsac 0
>>> [ 1657.921085] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00200001
>>> [ 1657.921112] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000002
>>> [ 1657.921131] mmc0: Got data interrupt 0x00000002 even though no data operation was in progress.
>>> [ 1657.929761] sdhci: =========== REGISTER DUMP (mmc0)===========
>>> [ 1657.929780] sdhci: Sys addr: 0x3d5d6380 | Version:  0x00000002
>>> [ 1657.929796] sdhci: Blk size: 0x00000040 | Blk cnt:  0x00000001
>>> [ 1657.929814] sdhci: Argument: 0x00000000 | Trn mode: 0x00000013
>>> [ 1657.929831] sdhci: Present:  0x01fd8008 | Host ctl: 0x00000023
>>> [ 1657.929847] sdhci: Power:    0x00000002 | Blk gap:  0x00000080
>>> [ 1657.929863] sdhci: Wake-up:  0x00000008 | Clock:    0x0000000f
>>> [ 1657.929879] sdhci: Timeout:  0x0000000f | Int stat: 0x00000000
>>> [ 1657.929896] sdhci: Int enab: 0x107f008b | Sig enab: 0x107f008b
>>> [ 1657.929914] sdhci: AC12 err: 0x00000000 | Slot int: 0x00000003
>>> [ 1657.929932] sdhci: Caps:     0x07eb0000 | Caps_1:   0x00002007
>>> [ 1657.929949] sdhci: Cmd:      0x0000133a | Max curr: 0x00ffffff
>>> [ 1657.929965] sdhci: Host ctl2: 0x000000c8
>>> [ 1657.929981] sdhci: ADMA Err: 0x00000000 | ADMA Ptr: 0x8f042208
>>> [ 1657.929995] sdhci: ===========================================
>>> [ 1657.930156] mmc0: req done (CMD19): 0: 00000900 00000000 00000000 00000000
>>> [ 1657.930179] mmc0:     0 bytes transferred: -84
>>>
>>> It shows we first have a data CRC error interrupt then a data transfer
>>> complete interrupt.
>>> Then we got the !host->data case in sdhci_data_irq().
>>>
>>> CC: stable <stable@vger.kernel.org>
>>> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
>>> ---
>>>  drivers/mmc/host/sdhci.c | 11 +++++++++++
>>>  1 file changed, 11 insertions(+)
>>>
>>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>>> index 40e3551..2eb0e34 100644
>>> --- a/drivers/mmc/host/sdhci.c
>>> +++ b/drivers/mmc/host/sdhci.c
>>> @@ -2325,6 +2325,17 @@ static void sdhci_data_irq(struct sdhci_host *host, u32 intmask)
>>>  			}
>>>  		}
>>>  
>>> +		/*
>>> +		 * The "data complete" interrupt is possible to happen a bit
>>> +		 * later than CRC error and data end bit error interrupts
>>> +		 * separately for single block transfer or the last block of
>>> +		 * multiblock transfer. For this case, we DO NOT report the
>>> +		 * weird data interrupt event.
>>> +		 */
>>> +		if ((intmask & SDHCI_INT_DATA_END) &&
>>> +		    (host->mrq && host->mrq->data && host->mrq->data->error))
>>> +			return;
>>
>> This could be generalized a bit more i.e. what about:
>>
>> 		/*
>> 		 * After an error and before the the data circuit is reset in
>> 		 * sdhci_tasklet_finish, we could get more interrupts, but we
>> 		 * already have an error, so ignore them.
>> 		 */
>> 		if (host->mrq && host->mrq->data && host->mrq->data->error)
>> 			return;
>>
> 
> Sounds good to me.
> If you wouldn't mind, i'd like to add a bit more:
> 		/*
> 		 * After an error and before the data circuit is reset in
> 		 * sdhci_tasklet_finish, we could get more interrupts
> 		 * e.g. "data complete" interrupt, but we already have
> 		 * an error, so ignore them.
> 		 */
> 

Fine by me


