From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH 2/5] mmc: bcm2835-sdhost: Add new driver for the
 internal SD controller.
Date: Thu, 08 Sep 2016 17:08:35 +0200
Message-ID: <1473347315.6698.53.camel@redhat.com>
References: <1466595738-2229-1-git-send-email-kraxel@redhat.com>
         <1466595738-2229-3-git-send-email-kraxel@redhat.com>
         <CAPDyKFryfGpA+8tZhtkzUVMFhomOevFz8k9R1b2O0oUn8giT1w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFryfGpA+8tZhtkzUVMFhomOevFz8k9R1b2O0oUn8giT1w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-rpi-kernel@lists.infradead.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-mmc <linux-mmc@vger.kernel.org>, Eric Anholt <eric@anholt.net>, Stephen Warren <swarren@wwwdotorg.org>, Lee Jones <lee@kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Mi, 2016-08-31 at 14:58 +0200, Ulf Hansson wrote:
> On 22 June 2016 at 13:42, Gerd Hoffmann <kraxel@redhat.com> wrote:
> > From: Eric Anholt <eric@anholt.net>
> >
> > The 2835 has two SD controllers: The Arasan SDHCI controller that we
> > currently use, and a custom SD controller.  The custom one runs faster
> >
> > The code was originally written by Phil Elwell in the downstream
> > Rasbperry Pi tree, and I did a major cleanup on it (+319, -707 lines
> > out of the original 2055) for inclusion.
> >
> > Signed-off-by: Eric Anholt <eric@anholt.net>
> 
> Apologize for the delay!

No problem, I was on summer vacation anyway ...

> Could you start by providing some more information about the driver
> and the controller in change in the change log please.

Eric?  I don't know much more than what the commit message above says.

Beside the speedup mentioned above driving the sdcard with the custom sd
controller allows to use the sdhci (handled by sdhci-iproc) to be used
for the wifi on the rpi3.

> drivers/mmc/host/bcm2835.c is better.

Done.

> > +       /* cached registers */
> > +       u32                     hcfg;
> > +       u32                     cdiv;
> 
> Perhaps remove some newlines and white-spaces above. Also decide
> whether align in columns or not.

Done.

> > +
> > +       /* Current request */
> > +       struct mmc_request              *mrq;
> > +       /* Current command */
> > +       struct mmc_command              *cmd;
> > +       /* Current data request */
> > +       struct mmc_data                 *data;
> > +       /* Data finished before cmd */
> > +       bool                            data_complete:1;
> > +       /* Drain the fifo when finishing */
> > +       bool                            flush_fifo:1;
> > +       /* Wait for busy interrupt */
> > +       bool                            use_busy:1;
> > +       /* Send CMD23 */
> > +       bool                            use_sbc:1;
> > +
> 
> Please be consistent when you add the comments, earlier you added it
> to the right of the variable - now on top...

Done.

> > +static inline void bcm2835_sdhost_write(struct bcm2835_host *host,
> > +static inline u32 bcm2835_sdhost_read(struct bcm2835_host *host, int reg)
> > +static inline u32 bcm2835_sdhost_read_relaxed(struct bcm2835_host *host,

> These three wrapper functions are superflous, please just use the
> writel and readl*() directly instead.

Done.  read_relaxed wasn't used at all.

> > +       pr_err("%s:%c%s op %d arg 0x%x flags 0x%x - resp %08x %08x %08x %08x, err %d\n",
> 
> dev_dbg() is probably better!?

Yep.  Switched the driver to drv_*() everywhere.

> > +static void bcm2835_sdhost_set_power(struct bcm2835_host *host, bool on)
> > +{
> > +       bcm2835_sdhost_write(host, on ? 1 : 0, SDVDD);
> 
> What exactly does this power on/off?

Dunno.  Eric?

I'm not an expert with this hardware, just trying to help a bit with
getting the rpi3 bits upstream.

> > +static void bcm2835_sdhost_set_ios(struct mmc_host *mmc, struct mmc_ios *ios);
> 
> Please avoid these kind of declarations (there are more that this
> one). You can probably re-structure and move the code around to avoid
> this!?

This one is easy, just had to move around some code.

The other one isn't as there actually is a circular call chain.
Maybe also something which should be cleaned up.

> > +               timediff++;
> > +               if (timediff == 100000) {
> 
> Perhaps better to loop for certain amount of time instead of just a
> fixed number of loop cycles!?

Will check.

> > +static void bcm2835_sdhost_transfer_block_pio(struct bcm2835_host *host,
> > +                                             bool is_read)
> > +{
> 
> A rather big function, perhaps split it up?

Hmm, doesn't look too bad to me, but maybe splitting out the inner loop
makes sense.

> > +       while (bcm2835_sdhost_read(host, SDCMD) & SDCMD_NEW_FLAG) {
> > +               if (timeout == 0) {
> > +                       pr_err("%s: previous command never completed.\n",
> > +                              mmc_hostname(host->mmc));
> > +                       bcm2835_sdhost_dumpregs(host);
> > +                       cmd->error = -EILSEQ;
> > +                       tasklet_schedule(&host->finish_tasklet);
> 
> No tasklets please. Instead use a threaded IRQ handler.

Ok.

> > +       host->use_busy = false;
> > +       if (!(cmd->flags & MMC_RSP_PRESENT)) {
> > +               sdcmd |= SDCMD_NO_RESPONSE;
> > +       } else {
> > +               if (cmd->flags & MMC_RSP_136)
> > +                       sdcmd |= SDCMD_LONG_RESPONSE;
> > +               if (cmd->flags & MMC_RSP_BUSY) {
> > +                       sdcmd |= SDCMD_BUSYWAIT;
> > +                       host->use_busy = true;
> 
> If your controller support HW busy detection, you should enable
> MMC_CAP_WAIT_WHILE_BUSY and assign a value to the host's
> max_busy_timeout.

Ok.

> > +       /* Need to send CMD12 if -
> > +        * a) open-ended multiblock transfer (no CMD23)
> > +        * b) error in multiblock transfer
> > +        */
> > +       if (host->mrq->stop && (data->error || !host->use_sbc)) {
> > +               if (bcm2835_sdhost_send_command(host, host->mrq->stop)) {
> > +                       /* No busy, so poll for completion */
> > +                       if (!host->use_busy)
> 
> This looks a bit weird. Can you explain why this is needed?

Eric, any clue?  Some hardware bug workaround?
Have a pointer to hardware specs?

> > +/* If irq_flags is valid, the caller is in a thread context and is
> > + * allowed to sleep
> > + */
> > +static void bcm2835_sdhost_finish_command(struct bcm2835_host *host,
> > +                                         unsigned long *irq_flags)
> > +{
> 
> Another big function. Split it up!

> > +                       do_gettimeofday(&start);
> 
> This looks really odd.
> 
> If there is a small timeout you would like to wait, let's do that by
> looping and using jiffies. If the delay is longer, why not use
> timer/work instead?

> > +               /* Wait max 100 ms */
> > +               wait_max = jiffies + msecs_to_jiffies(100);
> 
> ...and here you use jiffies...
> 
> You need to walk through all the loops dealing with timeouts and try
> to modernise that code, but also try to be more consistent when
> dealing with timeouts.

I'll give it a try.

> > +       /* Reset the error statuses in case this is a retry */
> > +       if (mrq->sbc)
> > +               mrq->sbc->error = 0;
> > +       if (mrq->cmd)
> > +               mrq->cmd->error = 0;
> > +       if (mrq->data)
> > +               mrq->data->error = 0;
> > +       if (mrq->stop)
> > +               mrq->stop->error = 0;
> 
> Perhaps the mmc core is a bit lazy and don't reset all fields above in
> the retry path. Although, please fix this in the mmc core instead of
> in this host driver.

Ok.

> > +static void bcm2835_sdhost_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
> > +{
> 
> I don't find any place where you control power to the card here. Don't
> you need to do that?

Eric?

> > +       pio_limit_string[0] = '\0';
> 
> What's this?
> 
> > +       if (host->use_dma && (host->pio_limit > 0))
> > +               sprintf(pio_limit_string, " (>%d)", host->pio_limit);
> > +       pr_info("%s: loaded - DMA %s%s\n",
> > +               mmc_hostname(mmc),
> > +               host->use_dma ? "enabled" : "disabled",
> > +               pio_limit_string);

Used to log host->pio_limit (if dma is enabled).

> > +       mmc_of_parse(mmc);
> 
> Error handling please.

Ok.

> Please don't take the comment too hard, but I really think this needs
> another round of modernisation and cleanups.

sneak preview at:
https://www.kraxel.org/cgit/linux/log/?h=bcm2837-wifi

low hanging fruit only for now, going over all the timeout / tasklet /
irq stuff will need some more care and time and testing and should
follow ...

cheers,
  Gerd
