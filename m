From: Joel Fernandes <joelf-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 4/9] dma: edma: Find missed events and issue them
Date: Thu, 1 Aug 2013 15:48:57 -0500
Message-ID: <51FAC9B9.3050903@ti.com>
References: <1375104595-16018-1-git-send-email-joelf@ti.com>
	<1375104595-16018-5-git-send-email-joelf@ti.com>
	<51F7659E.3040302@ti.com> <51F89763.1010102@ti.com>
	<51F8D667.2040406@ti.com> <51F9C793.2000001@ti.com>
	<51F9FC87.3020706@ti.com> <51FAC50A.2020507@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <51FAC50A.2020507-l0cyMroinI0@public.gmane.org>
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

Just some corrections here..

On 08/01/2013 03:28 PM, Joel Fernandes wrote:

>>> 2. If the interrupt handler for some reason doesn't complete or get
>>> service in time, we will end up DMA'ing incorrect data as events
>>> wouldn't stop coming in even if interrupt is not yet handled (in your
>>> example linked sets P1 or P2 would be old ones being repeated). Where as
>>> with my method, we are not doing any DMA once we finish the current
>>> MAX_NR_SG set even if events continue to come.
>>
>> Where is repetition and possibility of wrong data being transferred? We
>> have a linear list of PaRAM sets - not a loop. You would link the end to
>> PaRAM set chain to dummy PaRAM set which BTW will not cause missed
>> events. The more number of PaRAM sets you add to the chain, the more
> 
> There would have to be a loop, how else would you ensure continuity and
> uninterrupted DMA?
> 
> Consider if you have 2 sets of linked sets:
> L1 is the first set of Linked sets and L2 is the second.
> 
> When L1 is done, EDMA continues with L2 (due to the link) while
> interrupt handler prepares L1. The continuity depends on L1 being linked
> to L2. Only the absolute last break up of the MAX_NR_SG linked set will
> be linked to Dummy.
> 
> So consider MAX_NR_SG=10, and sg_len = 35
> 
> L1 - L2 - L1 - L1 - Dummy

Should be,
L1 - L2 - L1 - L2 - Dummy

> 
> The split would be in number of slots,
> 10 - 10 - 10 -  5 - Dummy
> 
>> time CPU gets to intervene before DMA eventually stalls. This is a
>> tradeoff system designers can manage.
> 
> Consider what happens in the case where MAX_SG_NR=1 or 2. In that case,
> there's a change we might not get enough time for the interrupt handler
> to setup next series of linked set.
> 
> Some how this limitation has to be overcome by advising in comments than
> MAX_SG_NR should always be greater than a certain number to ensure
> proper operation.

s/than/that/


Thanks,

-Joel
