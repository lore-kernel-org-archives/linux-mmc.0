From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 00/13] mmc: bcm2835: more cleanups
Date: Fri, 27 Jan 2017 09:25:43 +0100
Message-ID: <CAPDyKFoOShjQC8MbaxEuPG9m5FiSEfEd55qph3UDRHXH7C6VWA@mail.gmail.com>
References: <1485473846-24537-1-git-send-email-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-rpi-kernel-bounces+glkr-linux-rpi-kernel=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <1485473846-24537-1-git-send-email-kraxel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rpi-kernel>,
 <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rpi-kernel/>
List-Post: <mailto:linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rpi-kernel>,
 <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "linux-rpi-kernel" <linux-rpi-kernel-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rpi-kernel-bounces+glkr-linux-rpi-kernel=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Gerd Hoffmann <kraxel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

On 27 January 2017 at 00:37, Gerd Hoffmann <kraxel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
>   Hi folks,
>
> Continuing bcm283x mmc driver cleanup.  Changes:
>
>  * switch to threaded irq handler.
>  * handle timeouts using delayed work instead of timers.
>
> With these changes most of the driver code runs in
> thread context, which in turn allows to remove the
> work queue and the tasklet.  Also some wait loops can
> be simplified because almost all driver code is allowed
> to sleep now.
>
> Code is also available here:
>   git://git.kraxel.org/linux bcm2837-sdhost-cleanup
>
> Baseline for the patch series is this:
>   git://git.kraxel.org/linux bcm2837-wifi
>
> Tested on raspberry pi 2b only so far.
> PIO mode only, didn't try to enable DMA.
>
> Lots of baby patches for now, to make review
> and (if needed) bisecting easier.  Will all be
> squashed into the bcm283x mmc driver patch later.
>
> cheers,
>   Gerd
>
> Gerd Hoffmann (13):
>   mmc: bcm2835: add bcm2835_read_wait_sdcmd
>   mmc: bcm2835: use bcm2835_read_wait_sdcmd in bcm2835_send_command
>   mmc: bcm2835: add bcm2835_threaded_irq
>   mmc: bcm2835: add bcm2835_check_data_error
>   mmc: bcm2835: call bcm2835_block_irq from irqthread
>   mmc: bcm2835: add bcm2835_check_cmd_error
>   mmc: bcm2835: call bcm2835_busy_irq from irqthread
>   mmc: bcm2835: split bcm2835_data_irq
>   mmc: bcm2835: switch locking to mutex
>   mmc: bcm2835: work queue is dead code now, zap
>   mmc: bcm2835: kill tasklet
>   mmc: bcm2835: move timeout to thread context
>   mmc: bcm2835: use bcm2835_read_wait_sdcmd in bcm2835_finish_command
>
>  drivers/mmc/host/bcm2835.c | 448 ++++++++++++++++++++-------------------------
>  1 file changed, 197 insertions(+), 251 deletions(-)
>
> --
> 1.8.3.1
>

So, I think these kind of incremental changes on top of an old posted
series are just confusing. Please just create a new version of the
original series - and add a nice history of what changes have been
made for each step.

Moreover, I know I have asked before why sdhci-iproc can be extended
for this controller. However, from the responses to some of the
changes in this series it sounds like the controllers are related? Or
are the controllers completely independent designed HW? Please clarify
this once more.

Kind regards
Uffe
