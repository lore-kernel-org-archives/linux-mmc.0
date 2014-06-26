From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: RE: [PATCH 3/3] mmc: dw_mmc: Support voltage changes
Date: Thu, 26 Jun 2014 19:41:15 +0900
Message-ID: <005001cf912b$27fb8510$77f28f30$%jun@samsung.com>
References: <1403520321-2431-1-git-send-email-yuvaraj.cd@samsung.com>
 <1403520321-2431-4-git-send-email-yuvaraj.cd@samsung.com>
 <001501cf9076$9de45000$d9acf000$%jun@samsung.com>
 <CAD=FV=UE2LkXZb-UuR8t9kS2+odeVHU59K5fN=veMU8Y513w=A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <CAD=FV=UE2LkXZb-UuR8t9kS2+odeVHU59K5fN=veMU8Y513w=A@mail.gmail.com>
Content-language: ko
Sender: linux-samsung-soc-owner@vger.kernel.org
To: 'Doug Anderson' <dianders@chromium.org>
Cc: 'Yuvaraj Kumar C D' <yuvaraj.cd@gmail.com>, 'linux-samsung-soc' <linux-samsung-soc@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, 'Jaehoon Chung' <jh80.chung@samsung.com>, 'Chris Ball' <cjb@laptop.org>, linux-mmc@vger.kernel.org, 'Ulf Hansson' <ulf.hansson@linaro.org>, 'Sonny Rao' <sonnyrao@chromium.org>, 'Tomasz Figa' <t.figa@samsung.com>, 'Kukjin Kim' <kgene.kim@samsung.com>, 'sunil joshi' <joshi@samsung.com>, ks.giri@samsung.com, 'Prashanth G' <prashanth.g@samsung.com>, 'Alim Akhtar' <alim.akhtar@samsung.com>, 'Yuvaraj Kumar C D' <yuvaraj.cd@samsung.com>
List-Id: linux-mmc@vger.kernel.org

On Thu, June 26, 2014, Doug Anderson wrote:
> Seungwon,
> 
> On Wed, Jun 25, 2014 at 6:08 AM, Seungwon Jeon <tgih.jun@samsung.com> wrote:
> > On Mon, June 23, 2014, Yuvaraj Kumar C D wrote:
> >> Subject: [PATCH 3/3] mmc: dw_mmc: Support voltage changes
> >>
> >> From: Doug Anderson <dianders@chromium.org>
> >>
> >> For UHS cards we need the ability to switch voltages from 3.3V to
> >> 1.8V.  Add support to the dw_mmc driver to handle this.  Note that
> >> dw_mmc needs a little bit of extra code since the interface needs a
> >> special bit programmed to the CMD register while CMD11 is progressing.
> >> This means adding a few extra states to the state machine to track.
> >
> > Overall new additional states makes it complicated.
> > Can we do that in other way?
> 
> That was the best I was able to figure out when I thought this
> through.  If you have ideas for doing it another way I'd imagine that
> Yuvaraj would be happy to take your feedback.
Let's clean up SDMMC_CMD_VOLT_SWITCH.
In turn, we may remove state-handling simply.

> 
> 
> >> Signed-off-by: Doug Anderson <dianders@chromium.org>
> >> Signed-off-by: Yuvaraj Kumar C D <yuvaraj.cd@samsung.com>
> >>
> >> ---
> >>  drivers/mmc/host/dw_mmc.c  |  145 +++++++++++++++++++++++++++++++++++++++++---
> >>  drivers/mmc/host/dw_mmc.h  |    5 +-
> >>  include/linux/mmc/dw_mmc.h |    2 +
> >>  3 files changed, 142 insertions(+), 10 deletions(-)
> >>
> >> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> >> index e034bce..38eb548 100644
> >> --- a/drivers/mmc/host/dw_mmc.c
> >> +++ b/drivers/mmc/host/dw_mmc.c
> >> @@ -29,6 +29,7 @@
> >>  #include <linux/irq.h>
> >>  #include <linux/mmc/host.h>
> >>  #include <linux/mmc/mmc.h>
> >> +#include <linux/mmc/sd.h>
> >>  #include <linux/mmc/sdio.h>
> >>  #include <linux/mmc/dw_mmc.h>
> >>  #include <linux/bitops.h>
> >> @@ -235,10 +236,13 @@ err:
> >>  }
> >>  #endif /* defined(CONFIG_DEBUG_FS) */
> >>
> >> +static void mci_send_cmd(struct dw_mci_slot *slot, u32 cmd, u32 arg);
> >> +
> >>  static u32 dw_mci_prepare_command(struct mmc_host *mmc, struct mmc_command *cmd)
> >>  {
> >>       struct mmc_data *data;
> >>       struct dw_mci_slot *slot = mmc_priv(mmc);
> >> +     struct dw_mci *host = slot->host;
> >>       const struct dw_mci_drv_data *drv_data = slot->host->drv_data;
> >>       u32 cmdr;
> >>       cmd->error = -EINPROGRESS;
> >> @@ -254,6 +258,32 @@ static u32 dw_mci_prepare_command(struct mmc_host *mmc, struct mmc_command
> *cmd)
> >>       else if (cmd->opcode != MMC_SEND_STATUS && cmd->data)
> >>               cmdr |= SDMMC_CMD_PRV_DAT_WAIT;
> >>
> >> +     if (cmd->opcode == SD_SWITCH_VOLTAGE) {
> >> +             u32 clk_en_a;
> >> +
> >> +             /* Special bit makes CMD11 not die */
> >> +             cmdr |= SDMMC_CMD_VOLT_SWITCH;
> >> +
> >> +             /* Change state to continue to handle CMD11 weirdness */
> >> +             WARN_ON(slot->host->state != STATE_SENDING_CMD);
> >> +             slot->host->state = STATE_SENDING_CMD11;
> >> +
> >> +             /*
> >> +              * We need to disable clock stop while doing voltage switch
> >> +              * according to 7.4.1.2 Voltage Switch Normal Scenario.
> >> +              *
> >> +              * It's assumed that by the next time the CLKENA is updated
> >> +              * (when we set the clock next) that the voltage change will
> >> +              * be over, so we don't bother setting any bits to synchronize
> >> +              * with dw_mci_setup_bus().
> >> +              */
> >> +             clk_en_a = mci_readl(host, CLKENA);
> >> +             clk_en_a &= ~(SDMMC_CLKEN_LOW_PWR << slot->id);
> >> +             mci_writel(host, CLKENA, clk_en_a);
> >> +             mci_send_cmd(slot, SDMMC_CMD_UPD_CLK |
> >> +                          SDMMC_CMD_PRV_DAT_WAIT, 0);
> > dw_mci_disable_low_power() can be used here.
> 
> Ah.  I guess we don't have that locally anymore.  Locally we have variants on:
I'm checking on cjb/mmc branch.

> * https://patchwork.kernel.org/patch/3070311/
> * https://patchwork.kernel.org/patch/3070251/
> * https://patchwork.kernel.org/patch/3070221/
> 
> ...which removed that function.  ...but I guess upstream never picked
> up those patches, huh?  Looking back it looks like you had some
> feedback and it needed another spin but somehow fell off my plate.  :(
> 
> Maybe this is something Yuvaraj would like to pick up?
It's long ago. I remember that there is no progress since my last comment.
In case of patch "3070221", I want to pick up for next Kernel.

> 
> >
> >> +     }
> >> +
> >>       if (cmd->flags & MMC_RSP_PRESENT) {
> >>               /* We expect a response, so set this bit */
> >>               cmdr |= SDMMC_CMD_RESP_EXP;
> >> @@ -776,11 +806,15 @@ static void dw_mci_setup_bus(struct dw_mci_slot *slot, bool force_clkinit)
> >>       unsigned int clock = slot->clock;
> >>       u32 div;
> >>       u32 clk_en_a;
> >> +     u32 sdmmc_cmd_bits = SDMMC_CMD_UPD_CLK | SDMMC_CMD_PRV_DAT_WAIT;
> >> +
> >> +     /* We must continue to set bit 28 in CMD until the change is complete */
> >> +     if (host->state == STATE_WAITING_CMD11_DONE)
> >> +             sdmmc_cmd_bits |= SDMMC_CMD_VOLT_SWITCH;
> > I didn't get the reason SDMMC_CMD_VOLT_SWITCH is needed during clock update(enable/disable)
> > Can you explain it in details?
> 
> Simply put: if I didn't do this then the system hung during voltage
> switch.  It was not documented in the version of the IP manual that I
> had access to and it took me a bunch of digging / trial and error to
> figure this out.  Whatever this bit does internally it's important to
> set it while the voltage change is happening.  Note that this need was
> the whole reason for adding the extra state to the state machine.
> 
> Perhaps Yuvaraj can try without it and I'd assume he'll report the
> same freeze.
Clarify the necessity of SDMMC_CMD_VOLT_SWITCH.
As far as I experience, we didn't apply this bit for several projects.

> 
> 
> >>       if (!clock) {
> >>               mci_writel(host, CLKENA, 0);
> >> -             mci_send_cmd(slot,
> >> -                          SDMMC_CMD_UPD_CLK | SDMMC_CMD_PRV_DAT_WAIT, 0);
> >> +             mci_send_cmd(slot, sdmmc_cmd_bits, 0);
> >>       } else if (clock != host->current_speed || force_clkinit) {
> >>               div = host->bus_hz / clock;
> >>               if (host->bus_hz % clock && host->bus_hz > clock)
> >> @@ -804,15 +838,13 @@ static void dw_mci_setup_bus(struct dw_mci_slot *slot, bool force_clkinit)
> >>               mci_writel(host, CLKSRC, 0);
> >>
> >>               /* inform CIU */
> >> -             mci_send_cmd(slot,
> >> -                          SDMMC_CMD_UPD_CLK | SDMMC_CMD_PRV_DAT_WAIT, 0);
> >> +             mci_send_cmd(slot, sdmmc_cmd_bits, 0);
> >>
> >>               /* set clock to desired speed */
> >>               mci_writel(host, CLKDIV, div);
> >>
> >>               /* inform CIU */
> >> -             mci_send_cmd(slot,
> >> -                          SDMMC_CMD_UPD_CLK | SDMMC_CMD_PRV_DAT_WAIT, 0);
> >> +             mci_send_cmd(slot, sdmmc_cmd_bits, 0);
> >>
> >>               /* enable clock; only low power if no SDIO */
> >>               clk_en_a = SDMMC_CLKEN_ENABLE << slot->id;
> >> @@ -821,8 +853,7 @@ static void dw_mci_setup_bus(struct dw_mci_slot *slot, bool force_clkinit)
> >>               mci_writel(host, CLKENA, clk_en_a);
> >>
> >>               /* inform CIU */
> >> -             mci_send_cmd(slot,
> >> -                          SDMMC_CMD_UPD_CLK | SDMMC_CMD_PRV_DAT_WAIT, 0);
> >> +             mci_send_cmd(slot, sdmmc_cmd_bits, 0);
> >>
> >>               /* keep the clock with reflecting clock dividor */
> >>               slot->__clk_old = clock << div;
> >> @@ -898,6 +929,17 @@ static void dw_mci_queue_request(struct dw_mci *host, struct dw_mci_slot *slot,
> >>
> >>       slot->mrq = mrq;
> >>
> >> +     if (host->state == STATE_WAITING_CMD11_DONE) {
> >> +             dev_warn(&slot->mmc->class_dev,
> >> +                      "Voltage change didn't complete\n");
> >> +             /*
> >> +              * this case isn't expected to happen, so we can
> >> +              * either crash here or just try to continue on
> >> +              * in the closest possible state
> >> +              */
> >> +             host->state = STATE_IDLE;
> >> +     }
> >> +
> >>       if (host->state == STATE_IDLE) {
> >>               host->state = STATE_SENDING_CMD;
> >>               dw_mci_start_request(host, slot);
> >> @@ -993,6 +1035,9 @@ static void dw_mci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
> >>       /* Slot specific timing and width adjustment */
> >>       dw_mci_setup_bus(slot, false);
> >>
> >> +     if (slot->host->state == STATE_WAITING_CMD11_DONE && ios->clock != 0)
> >> +             slot->host->state = STATE_IDLE;
> >> +
> >>       switch (ios->power_mode) {
> >>       case MMC_POWER_UP:
> >>               if ((!IS_ERR(mmc->supply.vmmc)) &&
> >> @@ -1039,6 +1084,68 @@ static void dw_mci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
> >>       }
> >>  }
> >>
> >> +static int dw_mci_card_busy(struct mmc_host *mmc)
> >> +{
> >> +     struct dw_mci_slot *slot = mmc_priv(mmc);
> >> +     u32 status;
> >> +
> >> +     /*
> >> +      * Check the busy bit which is low when DAT[3:0]
> >> +      * (the data lines) are 0000
> >> +      */
> >> +     status = mci_readl(slot->host, STATUS);
> >> +
> >> +     return !!(status & SDMMC_STATUS_BUSY);
> >> +}
> >> +
> >> +static int dw_mci_switch_voltage(struct mmc_host *mmc, struct mmc_ios *ios)
> >> +{
> >> +     struct dw_mci_slot *slot = mmc_priv(mmc);
> >> +     struct dw_mci *host = slot->host;
> >> +     u32 uhs;
> >> +     u32 v18 = SDMMC_UHS_18V << slot->id;
> >> +     int min_uv, max_uv;
> >> +     int ret;
> >> +
> >> +     /*
> >> +      * Program the voltage.  Note that some instances of dw_mmc may use
> >> +      * the UHS_REG for this.  For other instances (like exynos) the UHS_REG
> >> +      * does no harm but you need to set the regulator directly.  Try both.
> >> +      */
> >> +     uhs = mci_readl(host, UHS_REG);
> >> +     if (ios->signal_voltage == MMC_SIGNAL_VOLTAGE_330) {
> >> +             min_uv = 2700000;
> >> +             max_uv = 3600000;
> >> +             uhs &= ~v18;
> >> +     } else {
> >> +             min_uv = 1700000;
> >> +             max_uv = 1950000;
> >> +             uhs |= v18;
> >> +     }
> >> +     if (!IS_ERR(mmc->supply.vqmmc)) {
> >> +             ret = regulator_set_voltage(mmc->supply.vqmmc, min_uv, max_uv);
> >> +
> >> +             /*
> >> +              * Only complain if regulator claims that it's not in the 1.8V
> >> +              * range.  This avoids a bunch of errors in the case that
> >> +              * we've got a fixed 1.8V regulator but the core SD code still
> >> +              * thinks it ought to try to switch to 3.3 and then back to 1.8
> >> +              */
> >> +             if (ret) {
> > I think if ret is error, printing message and returning error is good.
> > Currently, just returning '0' though it fails.
Any feedback?

> >
> >> +                     int cur_voltage = 0;
> >> +
> >> +                     cur_voltage = regulator_get_voltage(mmc->supply.vqmmc);
> >> +                     if (cur_voltage < 1700000 || cur_voltage > 1950000)
> >> +                             dev_warn(&mmc->class_dev,
> >> +                                      "Regulator set error %d: %d - %d\n",
> >> +                                      ret, min_uv, max_uv);
> >> +             }
> >> +     }
> >> +     mci_writel(host, UHS_REG, uhs);
> >> +
> >> +     return 0;
> >> +}
> >> +
> >>  static int dw_mci_get_ro(struct mmc_host *mmc)
> >>  {
> >>       int read_only;
> >> @@ -1180,6 +1287,9 @@ static const struct mmc_host_ops dw_mci_ops = {
> >>       .get_cd                 = dw_mci_get_cd,
> >>       .enable_sdio_irq        = dw_mci_enable_sdio_irq,
> >>       .execute_tuning         = dw_mci_execute_tuning,
> >> +     .card_busy              = dw_mci_card_busy,
> >> +     .start_signal_voltage_switch = dw_mci_switch_voltage,
> >> +
> >>  };
> >>
> >>  static void dw_mci_request_end(struct dw_mci *host, struct mmc_request *mrq)
> >> @@ -1203,7 +1313,11 @@ static void dw_mci_request_end(struct dw_mci *host, struct mmc_request *mrq)
> >>               dw_mci_start_request(host, slot);
> >>       } else {
> >>               dev_vdbg(host->dev, "list empty\n");
> >> -             host->state = STATE_IDLE;
> >> +
> >> +             if (host->state == STATE_SENDING_CMD11)
> >> +                     host->state = STATE_WAITING_CMD11_DONE;
> >> +             else
> >> +                     host->state = STATE_IDLE;
> >>       }
> >>
> >>       spin_unlock(&host->lock);
> >> @@ -1314,8 +1428,10 @@ static void dw_mci_tasklet_func(unsigned long priv)
> >>
> >>               switch (state) {
> >>               case STATE_IDLE:
> >> +             case STATE_WAITING_CMD11_DONE:
> >>                       break;
> >>
> >> +             case STATE_SENDING_CMD11:
> >>               case STATE_SENDING_CMD:
> >>                       if (!test_and_clear_bit(EVENT_CMD_COMPLETE,
> >>                                               &host->pending_events))
> >> @@ -1870,6 +1986,15 @@ static irqreturn_t dw_mci_interrupt(int irq, void *dev_id)
> >>       }
> >>
> >>       if (pending) {
> >> +             /* Check volt switch first, since it can look like an error */
> >> +             if ((host->state == STATE_SENDING_CMD11) &&
> >> +                 (pending & SDMMC_INT_VOLT_SWITCH)) {
> >> +                     mci_writel(host, RINTSTS, SDMMC_INT_VOLT_SWITCH);
> >> +                     pending &= ~SDMMC_INT_VOLT_SWITCH;
> >> +                     dw_mci_cmd_interrupt(host,
> >> +                                          pending | SDMMC_INT_CMD_DONE);
> > Artificially adding SDMMC_INT_CMD_DONE to pending is needed to complete cmd handling?
> > Is there any reason?
> 
> I don't remember this for sure since I wrote this a long time ago.
> Maybe it's not needed?  I may have just been modeling on other
> interrupts.
If there is no specific reason, please remove it.

Thanks,
Seungwon Jeon

> 
> -Doug
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
