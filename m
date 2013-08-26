From: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v2] ARM: EDMA: Fix clearing of unused list for DT DMA
	resources
Date: Tue, 27 Aug 2013 01:04:25 +0530
Message-ID: <521BADC1.7000003@ti.com>
References: <1377287613-16491-1-git-send-email-joelf@ti.com>
	<521B3212.3050405@ti.com> <521B87C0.1090507@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <521B87C0.1090507-l0cyMroinI0@public.gmane.org>
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
Cc: Linux DaVinci Kernel List <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Pantel Antoniou <panto-wVdstyuyKrO8r51toPun2/C9HSW9iNxf@public.gmane.org>, Linux MMC List <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Dan Williams <djbw-b10kYP2dOMg@public.gmane.org>, Linux OMAP List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux ARM Kernel List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org


On 8/26/2013 10:22 PM, Joel Fernandes wrote:
> On 08/26/2013 05:46 AM, Sekhar Nori wrote:
>> On Saturday 24 August 2013 01:23 AM, Joel Fernandes wrote:
>>> HWMOD removal for MMC and Crypto is breaking edma_start as the events are
>>> being manually triggered due to unused channel list not being clear. Atleast
>>> breakage has been seen on these peripherals, but it is expected Audio (McASP)
>>> maybe breaking too.
>>>
>>> This patch fixes the issue, by reading the "dmas" property from the DT node if
>>> it exists and clearing the bits in the unused channel list so that these channels
>>> are not manually triggered.
>>>
>>> v2 changes:
>>> Reduced indendation by returning from if block.
>>
>> Is this a v2 or v3 since you already sent a v2 about a month back?
> 
> No, there aren't any changes since v2, I just resubmitted the same patch.

Heh, it does seem to contain some indentation changes per your
documentation :)

> 
>>>
>>> Reviewed-by: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
>>> Reported-by: Balaji T K <balajitk-l0cyMroinI0@public.gmane.org>
>>> Cc: Pantel Antoniou <panto-wVdstyuyKrO8r51toPun2/C9HSW9iNxf@public.gmane.org>
>>> Signed-off-by: Joel Fernandes <joelf-l0cyMroinI0@public.gmane.org>
>>> ---
>>> Note:
>>> Patch should go in for -rc cycle as it fixes existing crypto drivers.
>>
>> We agreed the patch is not needed in -rc cycle since there are no
>> current EDMA users in DT-boot?
> 
> There is now, crypto and EDMA DT patches are being merged in.

They are being merged in v3.12, right? So you meant the -rc cycle of
v3.12? If yes, no need to wait for a broken v3.12-rc1 to come out. It is
possible to queue fixes during merge window too.

Thanks,
Sekhar
