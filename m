From: Joel Fernandes <joelf-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v3] ARM: EDMA: Fix clearing of unused list for DT DMA
	resources
Date: Thu, 26 Sep 2013 19:28:50 -0500
Message-ID: <5244D142.1090307@ti.com>
References: <1380232546-821-1-git-send-email-joelf@ti.com>
	<CAOesGMgELbnuu8PM7Ah2xKo2H5rzgAN3w0g6wA7aVFsjuds-8g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <davinci-linux-open-source-bounces+gld-davinci-linux-open-source=gmane.org-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <CAOesGMgELbnuu8PM7Ah2xKo2H5rzgAN3w0g6wA7aVFsjuds-8g-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: <davinci-linux-open-source-bounces+gld-davinci-linux-open-source=gmane.org-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
Errors-To: davinci-linux-open-source-bounces+gld-davinci-linux-open-source=gmane.org-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>
Cc: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Linux DaVinci Kernel List <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>, "arm-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <arm-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Linux MMC List <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Koen Kooi <koen-QLwJDigV5abLmq1fohREcCpxlwaOVQ5f@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Jason Kridner <jkridner-hcmAuCOw+vXj4SYmN/TMmA@public.gmane.org>, Pantel Antoniou <panto-wVdstyuyKrO8r51toPun2/C9HSW9iNxf@public.gmane.org>, Dan Williams <djbw-b10kYP2dOMg@public.gmane.org>, Linux OMAP List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux ARM Kernel List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On 09/26/2013 06:13 PM, Olof Johansson wrote:
> On Thu, Sep 26, 2013 at 2:55 PM, Joel Fernandes <joelf-l0cyMroinI0@public.gmane.org> wrote:
>> HWMOD removal for MMC is breaking edma_start as the events are being manually
>> triggered due to unused channel list not being clear.
>>
>> The above issue is fixed by reading the "dmas" property from the DT node if it
>> exists and clearing the bits in the unused channel list if the dma controller
>> used by any device is EDMA. For this purpose we use the of_* helpers to parse
>> the arguments in the dmas phandle list.
>>
>> Also introduced is a minor clean up of a checkpatch error in old code.
>>
>> Reviewed-by: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
>> Reported-by: Balaji T K <balajitk-l0cyMroinI0@public.gmane.org>
>> Cc: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
>> Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
>> Cc: Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>
>> Cc: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
>> Cc: Pantel Antoniou <panto-wVdstyuyKrO8r51toPun2/C9HSW9iNxf@public.gmane.org>
>> Cc: Jason Kridner <jkridner-hcmAuCOw+vXj4SYmN/TMmA@public.gmane.org>
>> Cc: Koen Kooi <koen-QLwJDigV5abLmq1fohREcCpxlwaOVQ5f@public.gmane.org>
>> Signed-off-by: Joel Fernandes <joelf-l0cyMroinI0@public.gmane.org>
>> ---
>> Just resending this patch after discussing with Sekhar and Olof.
> 
> Actually, the patch you talked to me about was v3 of this. It seems
> that you have reposted v6 but labelled it v3. This is very confusing.

Sorry about this. :-( This is indeed v6.

>> AM335x is being booted by many users such as the beaglebone community. DT is
>> the only boot method available for all these users.  EDMA is required for the
>> operation for many common peripherals in AM335x SoC such as McASP, MMC and
>> Crypto.
>>
>> Although EDMA DT nodes are going in only for 3.13, in reality the kernel has
>> been used for more than a year with EDMA code and out of tree EDMA DTS patches.
>> Hence though the DT nodes are still not in mainline, this patch can be still be
>> considered a critical fix as such and it would be great if it could be included
>> in 3.12-rc release. Thanks.
> 
> This is really the root of this problem. If you sit on code out of
> tree for a year, and something breaks that we couldn't even have
> detected since we didn't have the out-of-tree pieces. We'll help you
> the first few times (such as now) but we will eventually stop caring.

When I started looking at EDMA in June, I noticed that a lot had already been
merged. EDMA DMA Engine driver itself was merged last year, no worries there.
but the long pending list of fixes to be made to the driver had to written and
rewritten multiple times which took a long time.

Due to this, the EDMA device tree entries could not be merged in fear that doing
so would cause problems such as MMC/SD corruption etc.

> If I was in a worse mood, then I'd just say that since your users
> already has to have out-of-tree code to even use this functionality,
> they could just add this fix on top of that stack of patches. But I'm
> in a slightly better mood than that and I'll pick it up this time. :)

Thank you! :)

>> More details about why this broke an existing feature folks were using:
>> Previously the DMA resources for platform devices were being populated through
>> HWMOD, however with the recent clean ups with HWMOD, this data has been moved
>> to Device tree. The EDMA code though is not aware of this so it fails to fetch
>> the DMA resources correctly which it needs to prepare the unused channel list
>> (basically doesn't properly clear the channels that are in use, in the unused
>> list).
> 
> So that we can learn for next time: What should we (as in us
> maintainers and you TI) have done differently to avoid this?

I think a little on both sides can be improved.

For TI, a bit more work toward explaining patches better in change logs so that
maintainers understand and are willing to help to get the code upstream would
help. A lot of improvement to internal policies have been made for developing on
upstream, and that's certainly a good thing but there's still more room for
improvement.

For maintainers,  EDMA code would have been kept breathing all these months
(atleast 8 months) if those temporary fixes mentioned above would have been
merged into the kernel instead of not applied. With those fixes in place, dts
could have been enabled and EDMA would be fully working all these months. This
would have certainly made things a lot easier. Rewriting stuff the right way is
OK but if it is a _lot_ of effort, then to keep things alive, merging stuff "for
now" specially if they are one-liners could be made acceptable.

EDMA fixes have now been written the "right way", so those temporary fixes are
no longer needed :) but it certainly took a long time to do it the right way
during which things were dead. Only thing pending for working EDMA now is the
dts patches which are already in Benoit's for-3.13 tree and this patch that
you're picking up.

Thanks Olof for your help! :)

regards,

-Joel
