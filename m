From: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v3 02/12] ARM: edma: Don't clear EMR of channel in
	edma_stop
Date: Thu, 8 Aug 2013 17:19:39 +0530
Message-ID: <520385D3.1060408@ti.com>
References: <1375719297-12871-1-git-send-email-joelf@ti.com>
	<1375719297-12871-3-git-send-email-joelf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <davinci-linux-open-source-bounces+gld-davinci-linux-open-source=gmane.org-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <1375719297-12871-3-git-send-email-joelf-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: <davinci-linux-open-source-bounces+gld-davinci-linux-open-source=gmane.org-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
Errors-To: davinci-linux-open-source-bounces+gld-davinci-linux-open-source=gmane.org-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: Joel Fernandes <joelf-l0cyMroinI0@public.gmane.org>
Cc: Mark Brown <broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Sricharan R <r.sricharan-l0cyMroinI0@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org>, Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Rajendra Nayak <rnayak-l0cyMroinI0@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Jason Kridner <jkridner-hcmAuCOw+vXj4SYmN/TMmA@public.gmane.org>, Linux OMAP List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux ARM Kernel List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Linux DaVinci Kernel List <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>, Balaji TK <balajitk-l0cyMroinI0@public.gmane.org>, Linux MMC List <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Santosh Shilimkar <santosh.shilim>
List-Id: linux-mmc@vger.kernel.org

On Monday 05 August 2013 09:44 PM, Joel Fernandes wrote:
> We certainly don't want error conditions to be cleared any other
> place but the EDMA error handler, as this will make us 'forget'
> about missed events we might need to know errors have occurred.
> 
> This fixes a race condition where the EMR was being cleared
> by the transfer completion interrupt handler.
> 
> Basically, what was happening was:
> 
>             Missed event
>              |
>              |
>              V
> SG1-SG2-SG3-Null
>          \
>           \__TC Interrupt (Almost same time as ARM is executing
> TC interrupt handler, an event got missed and also forgotten
> by clearing the EMR).
> 
> This causes the following  problems:
> 
> 1.
> If error interrupt is also pending and TC interrupt clears the EMR
> by calling edma_stop as has been observed in the edma_callback function,
> the ARM will execute the error interrupt even though the EMR is clear.
> As a result, the  dma_ccerr_handler returns IRQ_NONE. If this happens
> enough number of times, IRQ subsystem disables the interrupt thinking
> its spurious which makes error handler never execute again.
> 
> 2.
> Also even if error handler doesn't return IRQ_NONE, the removing of EMR
> removes the knowledge about which channel had a missed event, and thus
> a manual trigger on such channels cannot be performed.
> 
> The EMR is ultimately being cleared by the Error interrupt handler
> once it is handled so we remove code that does it in edma_stop and
> allow it to happen there.
> 
> Signed-off-by: Joel Fernandes <joelf-l0cyMroinI0@public.gmane.org>

Queuing this for v3.11 fixes. While committing, I changed the headline
to remove capitalization and made it more readable by removing register
level details. The new headline is:

ARM: edma: don't clear missed events in edma_stop()

Thanks,
Sekhar
