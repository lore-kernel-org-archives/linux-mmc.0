From: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 7/9] ARM: edma: Don't clear EMR of channel in edma_stop
Date: Tue, 30 Jul 2013 13:59:54 +0530
Message-ID: <51F77982.7030601@ti.com>
References: <1375104595-16018-1-git-send-email-joelf@ti.com>
	<1375104595-16018-8-git-send-email-joelf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <1375104595-16018-8-git-send-email-joelf-l0cyMroinI0@public.gmane.org>
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
Cc: Mark Brown <broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Sricharan R <r.sricharan-l0cyMroinI0@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org>, Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Rajendra Nayak <rnayak-l0cyMroinI0@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Jason Kridner <jkridner-hcmAuCOw+vXj4SYmN/TMmA@public.gmane.org>, Linux OMAP List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux ARM Kernel List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Linux DaVinci Kernel List <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>, Balaji TK <balajitk-l0cyMroinI0@public.gmane.org>, Linux MMC List <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Santosh Shilimkar <santosh.shilim>
List-Id: linux-mmc@vger.kernel.org

On Monday 29 July 2013 06:59 PM, Joel Fernandes wrote:
> We certainly don't want error conditions to be cleared anywhere

'anywhere' is a really loaded term.

> as this will make us 'forget' about missed events. We depend on
> knowing which events were missed in order to be able to reissue them.

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

Sorry, but I dont see how edma_stop() is coming into picture in the race
you describe?

> The EMR is ultimately being cleared by the Error interrupt
> handler once it is handled so we don't have to do it in edma_stop.

This, I agree with. edma_clean_channel() also there to re-initialize the
channel so doing it in edma_stop() certainly seems superfluous.

Thanks,
Sekhar

> 
> Signed-off-by: Joel Fernandes <joelf-l0cyMroinI0@public.gmane.org>
> ---
>  arch/arm/common/edma.c |    1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm/common/edma.c b/arch/arm/common/edma.c
> index 10995b2..dec772e 100644
> --- a/arch/arm/common/edma.c
> +++ b/arch/arm/common/edma.c
> @@ -1328,7 +1328,6 @@ void edma_stop(unsigned channel)
>  		edma_shadow0_write_array(ctlr, SH_EECR, j, mask);
>  		edma_shadow0_write_array(ctlr, SH_ECR, j, mask);
>  		edma_shadow0_write_array(ctlr, SH_SECR, j, mask);
> -		edma_write_array(ctlr, EDMA_EMCR, j, mask);
>  
>  		pr_debug("EDMA: EER%d %08x\n", j,
>  				edma_shadow0_read_array(ctlr, SH_EER, j));
> 
