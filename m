From: Yuvaraj Kumar <yuvaraj.cd@gmail.com>
Subject: Re: [PATCH 3/3] mmc: dw_mmc: Support voltage changes
Date: Fri, 27 Jun 2014 12:05:06 +0530
Message-ID: <CAKuRcOJ0=GxmfBTu=Ax0yjLvbXJRjbVDJzHLR=f1nxkGZh9tAg@mail.gmail.com>
References: <1403520321-2431-1-git-send-email-yuvaraj.cd@samsung.com>
	<1403520321-2431-4-git-send-email-yuvaraj.cd@samsung.com>
	<001501cf9076$9de45000$d9acf000$%jun@samsung.com>
	<CAD=FV=UE2LkXZb-UuR8t9kS2+odeVHU59K5fN=veMU8Y513w=A@mail.gmail.com>
	<005001cf912b$27fb8510$77f28f30$%jun@samsung.com>
	<CAD=FV=X7h75ktaLG1MYa9Rs0Repu0QNq-p0-4TU2cforgjCdtw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <CAD=FV=X7h75ktaLG1MYa9Rs0Repu0QNq-p0-4TU2cforgjCdtw@mail.gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Doug Anderson <dianders@chromium.org>
Cc: Seungwon Jeon <tgih.jun@samsung.com>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Jaehoon Chung <jh80.chung@samsung.com>, Chris Ball <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Sonny Rao <sonnyrao@chromium.org>, Tomasz Figa <t.figa@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>, sunil joshi <joshi@samsung.com>, ks.giri@samsung.com, Prashanth G <prashanth.g@samsung.com>, Alim Akhtar <alim.akhtar@samsung.com>, Yuvaraj Kumar C D <yuvaraj.cd@samsung.com>
List-Id: linux-mmc@vger.kernel.org

On Thu, Jun 26, 2014 at 10:20 PM, Doug Anderson <dianders@chromium.org> wrote:
> Seungwon,
>
> On Thu, Jun 26, 2014 at 3:41 AM, Seungwon Jeon <tgih.jun@samsung.com> wrote:
>> On Thu, June 26, 2014, Doug Anderson wrote:
>>> Seungwon,
>>>
>>> On Wed, Jun 25, 2014 at 6:08 AM, Seungwon Jeon <tgih.jun@samsung.com> wrote:
>>> > On Mon, June 23, 2014, Yuvaraj Kumar C D wrote:
>>> >> Subject: [PATCH 3/3] mmc: dw_mmc: Support voltage changes
>>> >>
>>> >> From: Doug Anderson <dianders@chromium.org>
>>> >>
>>> >> For UHS cards we need the ability to switch voltages from 3.3V to
>>> >> 1.8V.  Add support to the dw_mmc driver to handle this.  Note that
>>> >> dw_mmc needs a little bit of extra code since the interface needs a
>>> >> special bit programmed to the CMD register while CMD11 is progressing.
>>> >> This means adding a few extra states to the state machine to track.
>>> >
>>> > Overall new additional states makes it complicated.
>>> > Can we do that in other way?
>>>
>>> That was the best I was able to figure out when I thought this
>>> through.  If you have ideas for doing it another way I'd imagine that
>>> Yuvaraj would be happy to take your feedback.
>> Let's clean up SDMMC_CMD_VOLT_SWITCH.
>> In turn, we may remove state-handling simply.
>>
>>>
>>>
>>> >> Signed-off-by: Doug Anderson <dianders@chromium.org>
>>> >> Signed-off-by: Yuvaraj Kumar C D <yuvaraj.cd@samsung.com>
>>> >>
>>> >> ---
>>> >>  drivers/mmc/host/dw_mmc.c  |  145 +++++++++++++++++++++++++++++++++++++++++---
>>> >>  drivers/mmc/host/dw_mmc.h  |    5 +-
>>> >>  include/linux/mmc/dw_mmc.h |    2 +
>>> >>  3 files changed, 142 insertions(+), 10 deletions(-)
>>> >>
>>> >> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
>>> >> index e034bce..38eb548 100644
>>> >> --- a/drivers/mmc/host/dw_mmc.c
>>> >> +++ b/drivers/mmc/host/dw_mmc.c
>>> >> @@ -29,6 +29,7 @@
>>> >>  #include <linux/irq.h>
>>> >>  #include <linux/mmc/host.h>
>>> >>  #include <linux/mmc/mmc.h>
>>> >> +#include <linux/mmc/sd.h>
>>> >>  #include <linux/mmc/sdio.h>
>>> >>  #include <linux/mmc/dw_mmc.h>
>>> >>  #include <linux/bitops.h>
>>> >> @@ -235,10 +236,13 @@ err:
>>> >>  }
>>> >>  #endif /* defined(CONFIG_DEBUG_FS) */
>>> >>
>>> >> +static void mci_send_cmd(struct dw_mci_slot *slot, u32 cmd, u32 arg);
>>> >> +
>>> >>  static u32 dw_mci_prepare_command(struct mmc_host *mmc, struct mmc_command *cmd)
>>> >>  {
>>> >>       struct mmc_data *data;
>>> >>       struct dw_mci_slot *slot = mmc_priv(mmc);
>>> >> +     struct dw_mci *host = slot->host;
>>> >>       const struct dw_mci_drv_data *drv_data = slot->host->drv_data;
>>> >>       u32 cmdr;
>>> >>       cmd->error = -EINPROGRESS;
>>> >> @@ -254,6 +258,32 @@ static u32 dw_mci_prepare_command(struct mmc_host *mmc, struct mmc_command
>>> *cmd)
>>> >>       else if (cmd->opcode != MMC_SEND_STATUS && cmd->data)
>>> >>               cmdr |= SDMMC_CMD_PRV_DAT_WAIT;
>>> >>
>>> >> +     if (cmd->opcode == SD_SWITCH_VOLTAGE) {
>>> >> +             u32 clk_en_a;
>>> >> +
>>> >> +             /* Special bit makes CMD11 not die */
>>> >> +             cmdr |= SDMMC_CMD_VOLT_SWITCH;
>>> >> +
>>> >> +             /* Change state to continue to handle CMD11 weirdness */
>>> >> +             WARN_ON(slot->host->state != STATE_SENDING_CMD);
>>> >> +             slot->host->state = STATE_SENDING_CMD11;
>>> >> +
>>> >> +             /*
>>> >> +              * We need to disable clock stop while doing voltage switch
>>> >> +              * according to 7.4.1.2 Voltage Switch Normal Scenario.
>>> >> +              *
>>> >> +              * It's assumed that by the next time the CLKENA is updated
>>> >> +              * (when we set the clock next) that the voltage change will
>>> >> +              * be over, so we don't bother setting any bits to synchronize
>>> >> +              * with dw_mci_setup_bus().
>>> >> +              */
>>> >> +             clk_en_a = mci_readl(host, CLKENA);
>>> >> +             clk_en_a &= ~(SDMMC_CLKEN_LOW_PWR << slot->id);
>>> >> +             mci_writel(host, CLKENA, clk_en_a);
>>> >> +             mci_send_cmd(slot, SDMMC_CMD_UPD_CLK |
>>> >> +                          SDMMC_CMD_PRV_DAT_WAIT, 0);
>>> > dw_mci_disable_low_power() can be used here.
>>>
>>> Ah.  I guess we don't have that locally anymore.  Locally we have variants on:
>> I'm checking on cjb/mmc branch.
>>
>>> * https://patchwork.kernel.org/patch/3070311/
>>> * https://patchwork.kernel.org/patch/3070251/
>>> * https://patchwork.kernel.org/patch/3070221/
>>>
>>> ...which removed that function.  ...but I guess upstream never picked
>>> up those patches, huh?  Looking back it looks like you had some
>>> feedback and it needed another spin but somehow fell off my plate.  :(
>>>
>>> Maybe this is something Yuvaraj would like to pick up?
>> It's long ago. I remember that there is no progress since my last comment.
>> In case of patch "3070221", I want to pick up for next Kernel.
>
> Sounds like Yuvaraj has agreed to look at addressing your comments.  Thanks!
>
>
>>> >> +     }
>>> >> +
>>> >>       if (cmd->flags & MMC_RSP_PRESENT) {
>>> >>               /* We expect a response, so set this bit */
>>> >>               cmdr |= SDMMC_CMD_RESP_EXP;
>>> >> @@ -776,11 +806,15 @@ static void dw_mci_setup_bus(struct dw_mci_slot *slot, bool force_clkinit)
>>> >>       unsigned int clock = slot->clock;
>>> >>       u32 div;
>>> >>       u32 clk_en_a;
>>> >> +     u32 sdmmc_cmd_bits = SDMMC_CMD_UPD_CLK | SDMMC_CMD_PRV_DAT_WAIT;
>>> >> +
>>> >> +     /* We must continue to set bit 28 in CMD until the change is complete */
>>> >> +     if (host->state == STATE_WAITING_CMD11_DONE)
>>> >> +             sdmmc_cmd_bits |= SDMMC_CMD_VOLT_SWITCH;
>>> > I didn't get the reason SDMMC_CMD_VOLT_SWITCH is needed during clock update(enable/disable)
>>> > Can you explain it in details?
>>>
>>> Simply put: if I didn't do this then the system hung during voltage
>>> switch.  It was not documented in the version of the IP manual that I
>>> had access to and it took me a bunch of digging / trial and error to
>>> figure this out.  Whatever this bit does internally it's important to
>>> set it while the voltage change is happening.  Note that this need was
>>> the whole reason for adding the extra state to the state machine.
>>>
>>> Perhaps Yuvaraj can try without it and I'd assume he'll report the
>>> same freeze.
>> Clarify the necessity of SDMMC_CMD_VOLT_SWITCH.
>> As far as I experience, we didn't apply this bit for several projects.
>
> I just tried this locally on our ChromeOS 3.8 kernel (which has quite
> a few backports and matches dw_mmc upstream pretty closely).  When I
> take out "sdmmc_cmd_bits |= SDMMC_CMD_VOLT_SWITCH" and bootup it fails
> to bringup WiFi chip.  It prints messages like:
>
> [    4.400842] mmc_host mmc1: Timeout sending command (cmd 0x202000
> arg 0x0 status 0x80202000)
>
> I will let Yuvaraj comment about his testing too.
To make it simple and verify, i have just enabled eMMC and SD channels
on 3.16-rc1 and tested.
Without "sdmmc_cmd_bits |= SDMMC_CMD_VOLT_SWITCH" bootup fails.
[    3.015971] mmc_host mmc1: Timeout sending command (cmd 0x202000
arg 0x0 status 0x80202000)
[    3.530974] mmc_host mmc1: Timeout sending command (cmd 0x202000
arg 0x0 status 0x80202000)
>
>
>>> >> +static int dw_mci_switch_voltage(struct mmc_host *mmc, struct mmc_ios *ios)
>>> >> +{
>>> >> +     struct dw_mci_slot *slot = mmc_priv(mmc);
>>> >> +     struct dw_mci *host = slot->host;
>>> >> +     u32 uhs;
>>> >> +     u32 v18 = SDMMC_UHS_18V << slot->id;
>>> >> +     int min_uv, max_uv;
>>> >> +     int ret;
>>> >> +
>>> >> +     /*
>>> >> +      * Program the voltage.  Note that some instances of dw_mmc may use
>>> >> +      * the UHS_REG for this.  For other instances (like exynos) the UHS_REG
>>> >> +      * does no harm but you need to set the regulator directly.  Try both.
>>> >> +      */
>>> >> +     uhs = mci_readl(host, UHS_REG);
>>> >> +     if (ios->signal_voltage == MMC_SIGNAL_VOLTAGE_330) {
>>> >> +             min_uv = 2700000;
>>> >> +             max_uv = 3600000;
>>> >> +             uhs &= ~v18;
>>> >> +     } else {
>>> >> +             min_uv = 1700000;
>>> >> +             max_uv = 1950000;
>>> >> +             uhs |= v18;
>>> >> +     }
>>> >> +     if (!IS_ERR(mmc->supply.vqmmc)) {
>>> >> +             ret = regulator_set_voltage(mmc->supply.vqmmc, min_uv, max_uv);
>>> >> +
>>> >> +             /*
>>> >> +              * Only complain if regulator claims that it's not in the 1.8V
>>> >> +              * range.  This avoids a bunch of errors in the case that
>>> >> +              * we've got a fixed 1.8V regulator but the core SD code still
>>> >> +              * thinks it ought to try to switch to 3.3 and then back to 1.8
>>> >> +              */
>>> >> +             if (ret) {
>>> > I think if ret is error, printing message and returning error is good.
>>> > Currently, just returning '0' though it fails.
>> Any feedback?
>
> Whoops, right.  I think you're right that in the case it warns it
> should also return the error code.  In the case it doesn't warn it
> shouldn't.  Also: possibly we should use a trick like the mmc core
> does and use "regulator_count_voltages" to figure out if we're going
> to be able to switch voltages...
>
>>> > Artificially adding SDMMC_INT_CMD_DONE to pending is needed to complete cmd handling?
>>> > Is there any reason?
>>>
>>> I don't remember this for sure since I wrote this a long time ago.
>>> Maybe it's not needed?  I may have just been modeling on other
>>> interrupts.
>> If there is no specific reason, please remove it.
>
> OK, we'll see how Yuvaraj's testing goes without it.  My incredibly
> brief testing in our local Chrome OS 3.8 tree shows that the WiFi is
> not detected properly if I comment out the line:
>   dw_mci_cmd_interrupt(host,
>     pending | SDMMC_INT_CMD_DONE);
>
> It may be sufficient to simply schedule the tasklet or to do some
> other subset of dw_mci_cmd_interrupt().  Yuvaraj can confirm on the
> latest kernel and also investigate further.
>
>
> -Doug
