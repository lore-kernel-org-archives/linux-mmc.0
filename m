From: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v3] ARM: EDMA: Fix clearing of unused list for DT DMA
	resources
Date: Fri, 27 Sep 2013 14:34:18 +0530
Message-ID: <52454A12.5010108@ti.com>
References: <1380232546-821-1-git-send-email-joelf@ti.com>
	<CAOesGMgELbnuu8PM7Ah2xKo2H5rzgAN3w0g6wA7aVFsjuds-8g@mail.gmail.com>
	<5244D142.1090307@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <5244D142.1090307-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: Joel Fernandes <joelf-l0cyMroinI0@public.gmane.org>
Cc: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Linux DaVinci Kernel List <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>, "arm-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <arm-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Pantel Antoniou <panto-wVdstyuyKrO8r51toPun2/C9HSW9iNxf@public.gmane.org>, Koen Kooi <koen-QLwJDigV5abLmq1fohREcCpxlwaOVQ5f@public.gmane.org>, Linux MMC List <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Jason Kridner <jkridner-hcmAuCOw+vXj4SYmN/TMmA@public.gmane.org>, Dan Williams <djbw-b10kYP2dOMg@public.gmane.org>, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, Linux OMAP List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux ARM Kernel List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On 9/27/2013 5:58 AM, Joel Fernandes wrote:
> On 09/26/2013 06:13 PM, Olof Johansson wrote:
>> On Thu, Sep 26, 2013 at 2:55 PM, Joel Fernandes <joelf-l0cyMroinI0@public.gmane.org> wrote:
>>> HWMOD removal for MMC is breaking edma_start as the events are being manually
>>> triggered due to unused channel list not being clear.
>>>
>>> The above issue is fixed by reading the "dmas" property from the DT node if it
>>> exists and clearing the bits in the unused channel list if the dma controller
>>> used by any device is EDMA. For this purpose we use the of_* helpers to parse
>>> the arguments in the dmas phandle list.
>>>
>>> Also introduced is a minor clean up of a checkpatch error in old code.
>>>
>>> Reviewed-by: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
>>> Reported-by: Balaji T K <balajitk-l0cyMroinI0@public.gmane.org>
>>> Cc: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
>>> Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
>>> Cc: Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>
>>> Cc: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
>>> Cc: Pantel Antoniou <panto-wVdstyuyKrO8r51toPun2/C9HSW9iNxf@public.gmane.org>
>>> Cc: Jason Kridner <jkridner-hcmAuCOw+vXj4SYmN/TMmA@public.gmane.org>
>>> Cc: Koen Kooi <koen-QLwJDigV5abLmq1fohREcCpxlwaOVQ5f@public.gmane.org>
>>> Signed-off-by: Joel Fernandes <joelf-l0cyMroinI0@public.gmane.org>
>>> ---
>>> Just resending this patch after discussing with Sekhar and Olof.
>>
>> Actually, the patch you talked to me about was v3 of this. It seems
>> that you have reposted v6 but labelled it v3. This is very confusing.
> 
> Sorry about this. :-( This is indeed v6.
> 
>>> AM335x is being booted by many users such as the beaglebone community. DT is
>>> the only boot method available for all these users.  EDMA is required for the
>>> operation for many common peripherals in AM335x SoC such as McASP, MMC and
>>> Crypto.
>>>
>>> Although EDMA DT nodes are going in only for 3.13, in reality the kernel has
>>> been used for more than a year with EDMA code and out of tree EDMA DTS patches.
>>> Hence though the DT nodes are still not in mainline, this patch can be still be
>>> considered a critical fix as such and it would be great if it could be included
>>> in 3.12-rc release. Thanks.
>>
>> This is really the root of this problem. If you sit on code out of
>> tree for a year, and something breaks that we couldn't even have
>> detected since we didn't have the out-of-tree pieces. We'll help you
>> the first few times (such as now) but we will eventually stop caring.
> 
> When I started looking at EDMA in June, I noticed that a lot had already been
> merged. EDMA DMA Engine driver itself was merged last year, no worries there.
> but the long pending list of fixes to be made to the driver had to written and
> rewritten multiple times which took a long time.
> 
> Due to this, the EDMA device tree entries could not be merged in fear that doing
> so would cause problems such as MMC/SD corruption etc.
> 
>> If I was in a worse mood, then I'd just say that since your users
>> already has to have out-of-tree code to even use this functionality,
>> they could just add this fix on top of that stack of patches. But I'm
>> in a slightly better mood than that and I'll pick it up this time. :)
> 
> Thank you! :)
> 
>>> More details about why this broke an existing feature folks were using:
>>> Previously the DMA resources for platform devices were being populated through
>>> HWMOD, however with the recent clean ups with HWMOD, this data has been moved
>>> to Device tree. The EDMA code though is not aware of this so it fails to fetch
>>> the DMA resources correctly which it needs to prepare the unused channel list
>>> (basically doesn't properly clear the channels that are in use, in the unused
>>> list).
>>
>> So that we can learn for next time: What should we (as in us
>> maintainers and you TI) have done differently to avoid this?
> 
> I think a little on both sides can be improved.

Since we are in lessons learnt mode, I think as developers we need to
learn to prioritize fixes over other features we are working on. I went
back to the chronology of this patch series.

22nd July 2013: v2 posted
29th July 2013: Discussion on whether the patch can wait till *v3.12*
		merge window.
29th July 2013: comments given on v2
22nd Aug 2013: 	Pull request's sent by Sekhar for v3.12
24th Aug 2013: 	another v2 posted (all comments given earlier not
		addressed, received some comments on build warnings)
27th Aug 2013:	another v3 posted (all comments given on 29th July not
		addressed)
10th Sept 2013: another v3 posted (all comments given on 29th July not
		addressed)
[some discussion on comments and why this cannot wait until v3.13]
17th Sept 2013:	Final version ready for merge posted.
26th Sept 2013: Another v3 posted, this time for Olof to send into
		v3.12-rc

See, early on, the patch was actually in consideration for v3.12 merge.
The barrier of entry into -rc cycle is pretty high. So if you have an
opportunity to hit a merge window, utilize that by prioritizing this
work over anything else you may be doing.

I know you got busy with adding support for SG lists and all, but
clearly this patch is critical in your mind. Plus the comments were not
tough to fix. There is a need to keep looking at what provides the best
return on time invested.

Thanks,
Sekhar
