From: Joel Fernandes <joelf-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 7/9] ARM: edma: Don't clear EMR of channel in edma_stop
Date: Wed, 31 Jul 2013 20:59:27 -0500
Message-ID: <51F9C0FF.7030703@ti.com>
References: <1375104595-16018-1-git-send-email-joelf@ti.com>
	<1375104595-16018-8-git-send-email-joelf@ti.com>
	<51F77982.7030601@ti.com> <51F89B0B.4080803@ti.com>
	<51F8DA5C.9060503@ti.com>
Reply-To: <joelf-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <51F8DA5C.9060503-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
Cc: Mark Brown <broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Sricharan R <r.sricharan-l0cyMroinI0@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org>, Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Rajendra Nayak <rnayak-l0cyMroinI0@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Jason Kridner <jkridner-hcmAuCOw+vXj4SYmN/TMmA@public.gmane.org>, Linux OMAP List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux ARM Kernel List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Linux DaVinci Kernel List <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>, Balaji TK <balajitk-l0cyMroinI0@public.gmane.org>, Linux MMC List <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Santosh Shilimkar <santosh.shilim>
List-Id: linux-mmc@vger.kernel.org

On 07/31/2013 04:35 AM, Sekhar Nori wrote:
> On Wednesday 31 July 2013 10:35 AM, Joel Fernandes wrote:
>> On 07/30/2013 03:29 AM, Sekhar Nori wrote:
>>> On Monday 29 July 2013 06:59 PM, Joel Fernandes wrote:
>>>> We certainly don't want error conditions to be cleared anywhere
>>>
>>> 'anywhere' is a really loaded term.
>>>
>>>> as this will make us 'forget' about missed events. We depend on
>>>> knowing which events were missed in order to be able to reissue them.
>>>
>>>> This fixes a race condition where the EMR was being cleared
>>>> by the transfer completion interrupt handler.
>>>>
>>>> Basically, what was happening was:
>>>>
>>>>             Missed event
>>>>              |
>>>>              |
>>>>              V
>>>> SG1-SG2-SG3-Null
>>>>          \
>>>>           \__TC Interrupt (Almost same time as ARM is executing
>>>> TC interrupt handler, an event got missed and also forgotten
>>>> by clearing the EMR).
>>>
>>> Sorry, but I dont see how edma_stop() is coming into picture in the race
>>> you describe?
>>
>> In edma_callback function, for the case of DMA_COMPLETE (Transfer
>> completion interrupt), edma_stop() is called when all sets have been
>> processed. This had the effect of clearing the EMR.
> 
> Ah, thanks. I was missing the fact that the race comes into picture only
> when using the DMA engine driver. I guess that should be mentioned
> somewhere since it is not immediately obvious.
> 
> The patch looks good to me. So if you respin just this one with some
> updated explanation based on what you wrote below, I will take it.

Sure I'll do that. Also the trigger_channel patch, will you be taking
that one too? I can send these 2 in a series as they touch
arch/arm/common/edma.c

Thanks,

-Joel



> 
> Thanks,
> Sekhar
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
