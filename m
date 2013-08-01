From: Joel Fernandes <joelf-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 4/9] dma: edma: Find missed events and issue them
Date: Wed, 31 Jul 2013 22:43:09 -0500
Message-ID: <51F9D94D.5060702@ti.com>
References: <1375104595-16018-1-git-send-email-joelf@ti.com>
	<1375104595-16018-5-git-send-email-joelf@ti.com>
	<51F7659E.3040302@ti.com> <51F89763.1010102@ti.com>
	<51F8D667.2040406@ti.com> <51F9C793.2000001@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <51F9C793.2000001-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: joelf-l0cyMroinI0@public.gmane.org
Cc: Mark Brown <broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Sricharan R <r.sricharan-l0cyMroinI0@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org>, Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Rajendra Nayak <rnayak-l0cyMroinI0@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Jason Kridner <jkridner-hcmAuCOw+vXj4SYmN/TMmA@public.gmane.org>, Linux OMAP List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux ARM Kernel List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Linux DaVinci Kernel List <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>, Balaji TK <balajitk-l0cyMroinI0@public.gmane.org>, Linux MMC List <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Santosh Shilimkar <santosh.shilim>
List-Id: linux-mmc@vger.kernel.org

On 07/31/2013 09:27 PM, Joel Fernandes wrote:
> On 07/31/2013 04:18 AM, Sekhar Nori wrote:
>> On Wednesday 31 July 2013 10:19 AM, Joel Fernandes wrote:
>>> Hi Sekhar,
>>>
>>> On 07/30/2013 02:05 AM, Sekhar Nori wrote:
>>>> On Monday 29 July 2013 06:59 PM, Joel Fernandes wrote:
>>>>> In an effort to move to using Scatter gather lists of any size with
>>>>> EDMA as discussed at [1] instead of placing limitations on the driver,
>>>>> we work through the limitations of the EDMAC hardware to find missed
>>>>> events and issue them.
>>>>>
>>>>> The sequence of events that require this are:
>>>>>
>>>>> For the scenario where MAX slots for an EDMA channel is 3:
>>>>>
>>>>> SG1 -> SG2 -> SG3 -> SG4 -> SG5 -> SG6 -> Null
>>>>>
>>>>> The above SG list will have to be DMA'd in 2 sets:
>>>>>
>>>>> (1) SG1 -> SG2 -> SG3 -> Null
>>>>> (2) SG4 -> SG5 -> SG6 -> Null
>>>>>
>>>>> After (1) is succesfully transferred, the events from the MMC controller
>>>>> donot stop coming and are missed by the time we have setup the transfer
>>>>> for (2). So here, we catch the events missed as an error condition and
>>>>> issue them manually.
>>>>
>>>> Are you sure there wont be any effect of these missed events on the
>>>> peripheral side. For example, wont McASP get into an underrun condition
>>>> when it encounters a null PaRAM set? Even UART has to transmit to a
>>>
>>> But it will not encounter null PaRAM set because McASP uses contiguous
>>> buffers for transfer which are not scattered across physical memory.
>>> This can be accomplished with an SG of size 1. For such SGs, this patch
>>> series leaves it linked Dummy and does not link to Null set. Null set is
>>> only used for SG lists that are > MAX_NR_SG in size such as those
>>> created for example by MMC and Crypto.
>>>
>>>> particular baud so I guess it cannot wait like the way MMC/SD can.
>>>
>>> Existing driver have to wait anyway if they hit MAX SG limit today. If
>>> they don't want to wait, they would have allocated a contiguous block of
>>> memory and DMA that in one stretch so they don't lose any events, and in
>>> such cases we are not linking to Null.
>>
>> As long as DMA driver can advertize its MAX SG limit, peripherals can
>> always work around that by limiting the number of sync events they
>> generate so as to not having any of the events getting missed. With this
>> series, I am worried that EDMA drivers is advertizing that it can handle
>> any length SG list while not taking care of missing any events while
>> doing so. This will break the assumptions that driver writers make.

Sorry, just forgot to respond to "not taking care of missing any events
while doing so". Can you clarify this? DMA engine driver is taking care
of missed events.

Also- missing of events doesn't result in feedback to the peripheral.
Peripheral sends even to DMA controller, event is missed. Peripheral
doesn't know anything about what happened and is waiting for transfer
from the DMA controller.

Thanks,

-Joel
