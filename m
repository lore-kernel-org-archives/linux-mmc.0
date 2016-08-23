From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH v4 2/4] mmc: tmio: Add tuning support
Date: Tue, 23 Aug 2016 15:52:52 +0200
Message-ID: <20160823135251.GA25665@verge.net.au>
References: <1469592803-13842-1-git-send-email-horms+renesas@verge.net.au>
 <1469592803-13842-3-git-send-email-horms+renesas@verge.net.au>
 <CAPDyKFq_Fs_bNx7LP-J+nC3iaNgB7gvZAvhCp--qVOh1iAh0vg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAPDyKFq_Fs_bNx7LP-J+nC3iaNgB7gvZAvhCp--qVOh1iAh0vg@mail.gmail.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Magnus Damm <magnus.damm@gmail.com>, linux-mmc <linux-mmc@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

Hi Ulf,

thanks for your review.
I have tried to address it as best I can below.

On Mon, Aug 22, 2016 at 03:39:03PM +0200, Ulf Hansson wrote:
> On 27 July 2016 at 06:13, Simon Horman <horms+renesas@verge.net.au> wrote:
> > From: Ai Kyuse <ai.kyuse.uw@renesas.com>
> >
> > Add tuning support for use with SDR104 mode
> >
> > Signed-off-by: Ai Kyuse <ai.kyuse.uw@renesas.com>
> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> > ---
> > v4 [Simon Horman]
> > As suggested by Wolfram Sang:
> >   - Do not perform tuning if host->select_tuning is not set:
> >     it seems to make little sense to do so and moreover there is currently
> >     no such use-case
> >   - Do not add mrc->sbc handling from tmio_mmc_request,
> >     this is a hang-over from earlier versions of this patchset which
> >     did not use core infrastructure for retuning
> >   - Tidy up local variable usage
> > * Correct index passed to prepare_tuning(): this seems to have
> >   been the last piece of resolving the timeouts during tuning puzzle
> > * Further cleanups to tmio_mmc_execute_tuning():
> >   - Ensure tap is sized proportionally to its members
> >   - Remove stray '*' in comment
> >   - Use mmc rather than host->mmc, these are equivalent but
> >     the former seems tidier
> >   - Correct inverted logic in setting tap values
> > * Re-introduce retuning support. This was removed in v3.
> >
> > v3 [Simon Horman]
> > * As suggested by Kuninori Morimoto:
> >   - Do not add unused retuning callback to struct tmio_mmc_host
> >   - Change return type of prepare_tuning callback to void
> >   - Add tap_size parameter to select_tuning callback
> >
> > v2 [Simon Horman]
> > * As suggested by Kuninori Morimoto:
> >   - Actually remove unnecessary TMIO_MMC_HAS_UHS_SCC define
> > * As suggested by Wolfram Sang:
> >   - Rely on core to call tuning. This simplifies things somewhat.
> >   - Use mmc_send_tuning()
> >     - A side affect of this appears to be that we now see some recoverable
> >       errors logged during tuning. These are typically corrected by
> >       subsequent tuning. It is the logging that is the apparent side effect
> >       of this change.
> >       e.g.
> >       sh_mobile_sdhi ee100000.sd: timeout waiting for hardware interrupt (CMD19)
> >       sh_mobile_sdhi ee100000.sd: Tuning procedure failed
> > * Use bool rather than unsigned long to pass test status
> >   to select_tuning() callback
> > * Do not retune if init_tuning callback is not present or
> >   indicates that there are no taps present
> > * Retune on hardware reset
> >
> > v1 [Simon Horman]
> > * Omit start_signal_voltage_switch and tmio_mmc_card_busy changes which are
> >   already present in mainline in a different form
> > * Return num from init_tuning rather than passing an extra parameter
> >   to hold the return value
> > * Only call host->init_tuning if it is non-NULL
> > * Place tmio_mmc_execute_tuning() such that no new forward declarations are
> >   required
> > * Remove unused TMIO_MMC_HAS_UHS_SCC define
> >
> > v0 [Ai Kyuse]
> >
> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> > ---
> >  drivers/mmc/host/tmio_mmc.h     |  7 ++++
> >  drivers/mmc/host/tmio_mmc_pio.c | 77 +++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 84 insertions(+)
> >
> > diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
> > index 7f63ec05bdf4..316b0c3fe745 100644
> > --- a/drivers/mmc/host/tmio_mmc.h
> > +++ b/drivers/mmc/host/tmio_mmc.h
> > @@ -150,6 +150,7 @@ struct tmio_mmc_host {
> >         struct mutex            ios_lock;       /* protect set_ios() context */
> >         bool                    native_hotplug;
> >         bool                    sdio_irq_enabled;
> > +       u32                     scc_tappos;
> >
> >         int (*write16_hook)(struct tmio_mmc_host *host, int addr);
> >         int (*clk_enable)(struct tmio_mmc_host *host);
> > @@ -160,6 +161,12 @@ struct tmio_mmc_host {
> >                               unsigned int direction, int blk_size);
> >         int (*start_signal_voltage_switch)(struct mmc_host *mmc,
> >                                            struct mmc_ios *ios);
> > +       unsigned int (*init_tuning)(struct tmio_mmc_host *host);
> > +       void (*prepare_tuning)(struct tmio_mmc_host *host, unsigned long tap);
> > +       int (*select_tuning)(struct tmio_mmc_host *host, bool *tap,
> > +                            int tap_size);
> > +       bool (*retuning)(struct tmio_mmc_host *host);
> > +       void (*hw_reset)(struct tmio_mmc_host *host);
> 
> Please add the HW reset support in separate patch. I guess you need it
> to go in before the tuning support.

Sure, will do.
And yes, I think it needs go go in before tuning support.

> >  };
> >
> >  struct tmio_mmc_host *tmio_mmc_host_alloc(struct platform_device *pdev);
> > diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
> > index a9d07b5f3c63..83b5148a2684 100644
> > --- a/drivers/mmc/host/tmio_mmc_pio.c
> > +++ b/drivers/mmc/host/tmio_mmc_pio.c
> > @@ -36,6 +36,7 @@
> >  #include <linux/io.h>
> >  #include <linux/irq.h>
> >  #include <linux/mfd/tmio.h>
> > +#include <linux/mmc/card.h>
> >  #include <linux/mmc/host.h>
> >  #include <linux/mmc/mmc.h>
> >  #include <linux/mmc/slot-gpio.h>
> > @@ -298,6 +299,15 @@ static void tmio_mmc_finish_request(struct tmio_mmc_host *host)
> >         if (mrq->cmd->error || (mrq->data && mrq->data->error))
> >                 tmio_mmc_abort_dma(host);
> >
> > +       if (host->retuning) {
> > +               int result = host->retuning(host);
> 
> This looks like you need to re-tune between each an every request. :-)
> 
> Although I guess what really are doing here is that you check if the
> auto-retuning has failed, correct?
> 
> Perhaps one could update the naming of the new tmio callbacks for
> tuning as to make those more self-explained.

Perhaps calling it check_scc_error would be better,
that is what the callback actually does

> 
> > +
> > +               if (result || (mrq->cmd->error == -EILSEQ)) {
> > +                       mmc_retune_timer_stop(host->mmc);
> > +                       mmc_retune_needed(host->mmc);
> 
> The mmc core already deals with re-tuning when it get an -EILSEQ error
> from a request, so you shouldn't need to manage that here as well.

Thanks, I'll clean that up.

> 
> > +               }
> > +       }
> > +
> >         mmc_request_done(host->mmc, mrq);
> >  }
> >
> > @@ -756,6 +766,68 @@ static int tmio_mmc_start_data(struct tmio_mmc_host *host,
> >         return 0;
> >  }
> >
> > +static void tmio_mmc_hw_reset(struct mmc_host *mmc)
> 
> As stated earlier, please add the HW reset in a separate patch.
> 
> > +{
> > +       struct tmio_mmc_host *host = mmc_priv(mmc);
> > +
> > +       if (host->hw_reset)
> > +               host->hw_reset(host);
> > +
> > +       mmc_retune_timer_stop(host->mmc);
> > +       mmc_retune_needed(host->mmc);
> 
> This looks like it belongs in the mmc core when it invokes a HW reset
> sequence. Please try to move it into there (unless it already covers
> this).

I think it is already handled by the core and I propose updating this patch as
follows:

@@ -772,9 +772,6 @@ static void tmio_mmc_hw_reset(struct mmc_host *mmc)
 
 	if (host->hw_reset)
 		host->hw_reset(host);
-
-	mmc_retune_timer_stop(host->mmc);
-	mmc_retune_needed(host->mmc);
 }
 
 static int tmio_mmc_execute_tuning(struct mmc_host *mmc, u32 opcode)
@@ -819,7 +816,7 @@ err_free:
 out:
 	if (ret < 0) {
 		dev_warn(&host->pdev->dev, "Tuning procedure failed\n");
-		tmio_mmc_hw_reset(mmc);
+		mmc_hw_reset(mmc);
 	} else {
 		host->mmc->retune_period = 0;
 	}

> > +}
> > +
> > +static int tmio_mmc_execute_tuning(struct mmc_host *mmc, u32 opcode)
> > +{
> > +       struct tmio_mmc_host *host = mmc_priv(mmc);
> > +       unsigned int num;
> > +       int i, ret = 0;
> > +       bool *tap;
> > +
> > +       if (!host->init_tuning || !host->select_tuning)
> 
> When defining these callbacks, it would be nice to know which ones are
> optional and which ones are required.

Would some comments in struct tmio_mmc_host be an appropriate way
to achieve that?

> > +               /* Tuning is not supported */
> > +               goto out;
> > +
> > +       num = host->init_tuning(host);
> > +       if (!num)
> > +               /* Tuning is not supported */
> > +               goto out;
> > +
> > +       tap = kmalloc(num * 2 * sizeof(*tap), GFP_KERNEL);
> > +       if (!tap) {
> > +               ret = -ENOMEM;
> > +               goto out;
> > +       }
> > +
> > +       /* Issue CMD19 twice for each tap */
> > +       for (i = 0; i < 2 * num; i++) {
> > +               if (host->prepare_tuning)
> > +                       host->prepare_tuning(host, i % num);
> > +
> > +               ret = mmc_send_tuning(mmc, opcode, NULL);
> > +               if (ret && ret != -EILSEQ)
> > +                       goto err_free;
> > +               tap[i] = (ret != 0);
> > +
> > +               mdelay(1);
> > +       }
> > +
> > +       ret = host->select_tuning(host, tap, num * 2);
> > +
> > +err_free:
> > +       kfree(tap);
> > +out:
> > +       if (ret < 0) {
> > +               dev_warn(&host->pdev->dev, "Tuning procedure failed\n");
> > +               tmio_mmc_hw_reset(mmc);
> > +       } else {
> > +               host->mmc->retune_period = 0;
> > +       }
> > +
> > +       return ret;
> > +
> > +}
> > +
> >  /* Process requests from the MMC layer */
> >  static void tmio_mmc_request(struct mmc_host *mmc, struct mmc_request *mrq)
> >  {
> > @@ -978,6 +1050,8 @@ static struct mmc_host_ops tmio_mmc_ops = {
> >         .enable_sdio_irq = tmio_mmc_enable_sdio_irq,
> >         .card_busy      = tmio_mmc_card_busy,
> >         .multi_io_quirk = tmio_multi_io_quirk,
> > +       .execute_tuning = tmio_mmc_execute_tuning,
> > +       .hw_reset       = tmio_mmc_hw_reset,
> >  };
> >
> >  static int tmio_mmc_init_ocr(struct tmio_mmc_host *host)
> > @@ -1202,6 +1276,9 @@ int tmio_mmc_host_runtime_suspend(struct device *dev)
> >         struct mmc_host *mmc = dev_get_drvdata(dev);
> >         struct tmio_mmc_host *host = mmc_priv(mmc);
> >
> > +       mmc_retune_timer_stop(host->mmc);
> > +       mmc_retune_needed(host->mmc);
> 
> I am wondering whether it would it be possible to keep a cache of the
> currently used tuning values and then restore these values at
> runtime_resume?
> 
> In that way you wouldn't need to force new re-tuning cycle here.

I will check with the hardware people to see if it is practical from
that POV.

>From a software POV that ought to be simple enough: a small bitmap ought
to be sufficient to save the values for the hardware covered by this
series.

> > +
> >         tmio_mmc_disable_mmc_irqs(host, TMIO_MASK_ALL);
> >
> >         if (host->clk_cache)
> > --
> > 2.7.0.rc3.207.g0ac5344
