From: Yuvaraj Kumar <yuvaraj.cd@gmail.com>
Subject: Re: [PATCH 3/3] mmc: dw_mmc: Support voltage changes
Date: Tue, 1 Jul 2014 16:47:20 +0530
Message-ID: <CAKuRcOL=iQ8_67Bjhd+xpWUxnGmGfrSca1ZwnJm+zqRaapQgmg@mail.gmail.com>
References: <1403520321-2431-1-git-send-email-yuvaraj.cd@samsung.com>
	<1403520321-2431-4-git-send-email-yuvaraj.cd@samsung.com>
	<001501cf9076$9de45000$d9acf000$%jun@samsung.com>
	<CAD=FV=UE2LkXZb-UuR8t9kS2+odeVHU59K5fN=veMU8Y513w=A@mail.gmail.com>
	<005001cf912b$27fb8510$77f28f30$%jun@samsung.com>
	<CAD=FV=X7h75ktaLG1MYa9Rs0Repu0QNq-p0-4TU2cforgjCdtw@mail.gmail.com>
	<CAKuRcOJ0=GxmfBTu=Ax0yjLvbXJRjbVDJzHLR=f1nxkGZh9tAg@mail.gmail.com>
	<001101cf91f9$84111530$8c333f90$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=047d7bea31d059b1ee04fd1feb97
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <001101cf91f9$84111530$8c333f90$%jun@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>
Cc: Doug Anderson <dianders@chromium.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Jaehoon Chung <jh80.chung@samsung.com>, Chris Ball <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Sonny Rao <sonnyrao@chromium.org>, Tomasz Figa <t.figa@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>, sunil joshi <joshi@samsung.com>, ks.giri@samsung.com, Prashanth G <prashanth.g@samsung.com>, Alim Akhtar <alim.akhtar@samsung.com>, Yuvaraj Kumar C D <yuvaraj.cd@samsung.com>
List-Id: linux-mmc@vger.kernel.org

--047d7bea31d059b1ee04fd1feb97
Content-Type: text/plain; charset=UTF-8

On Fri, Jun 27, 2014 at 4:48 PM, Seungwon Jeon <tgih.jun@samsung.com> wrote:
> Hi Yuvaraj,
>
> On Fri, June 27, 2014, Yuvaraj Kumar wrote:
>> On Thu, Jun 26, 2014 at 10:20 PM, Doug Anderson <dianders@chromium.org> wrote:
>> > Seungwon,
>> >
>> > On Thu, Jun 26, 2014 at 3:41 AM, Seungwon Jeon <tgih.jun@samsung.com> wrote:
>> >> On Thu, June 26, 2014, Doug Anderson wrote:
>> >>> Seungwon,
>> >>>
>> >>> On Wed, Jun 25, 2014 at 6:08 AM, Seungwon Jeon <tgih.jun@samsung.com> wrote:
>> >>> > On Mon, June 23, 2014, Yuvaraj Kumar C D wrote:
>> >>> >> Subject: [PATCH 3/3] mmc: dw_mmc: Support voltage changes
>> >>> >>
>> >>> >> From: Doug Anderson <dianders@chromium.org>
>> >>> >>
>> >>> >> For UHS cards we need the ability to switch voltages from 3.3V to
>> >>> >> 1.8V.  Add support to the dw_mmc driver to handle this.  Note that
>> >>> >> dw_mmc needs a little bit of extra code since the interface needs a
>> >>> >> special bit programmed to the CMD register while CMD11 is progressing.
>> >>> >> This means adding a few extra states to the state machine to track.
>> >>> >
>> >>> > Overall new additional states makes it complicated.
>> >>> > Can we do that in other way?
>> >>>
>> >>> That was the best I was able to figure out when I thought this
>> >>> through.  If you have ideas for doing it another way I'd imagine that
>> >>> Yuvaraj would be happy to take your feedback.
>> >> Let's clean up SDMMC_CMD_VOLT_SWITCH.
>> >> In turn, we may remove state-handling simply.
>> >>
>> >>>
>> >>>
>> >>> >> Signed-off-by: Doug Anderson <dianders@chromium.org>
>> >>> >> Signed-off-by: Yuvaraj Kumar C D <yuvaraj.cd@samsung.com>
>> >>> >>
>> >>> >> ---
>> >>> >>  drivers/mmc/host/dw_mmc.c  |  145 +++++++++++++++++++++++++++++++++++++++++---
>> >>> >>  drivers/mmc/host/dw_mmc.h  |    5 +-
>> >>> >>  include/linux/mmc/dw_mmc.h |    2 +
>> >>> >>  3 files changed, 142 insertions(+), 10 deletions(-)
>> >>> >>
>> >>> >> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
>> >>> >> index e034bce..38eb548 100644
>> >>> >> --- a/drivers/mmc/host/dw_mmc.c
>> >>> >> +++ b/drivers/mmc/host/dw_mmc.c
>> >>> >> @@ -29,6 +29,7 @@
>> >>> >>  #include <linux/irq.h>
>> >>> >>  #include <linux/mmc/host.h>
>> >>> >>  #include <linux/mmc/mmc.h>
>> >>> >> +#include <linux/mmc/sd.h>
>> >>> >>  #include <linux/mmc/sdio.h>
>> >>> >>  #include <linux/mmc/dw_mmc.h>
>> >>> >>  #include <linux/bitops.h>
>> >>> >> @@ -235,10 +236,13 @@ err:
>> >>> >>  }
>> >>> >>  #endif /* defined(CONFIG_DEBUG_FS) */
>> >>> >>
>> >>> >> +static void mci_send_cmd(struct dw_mci_slot *slot, u32 cmd, u32 arg);
>> >>> >> +
>> >>> >>  static u32 dw_mci_prepare_command(struct mmc_host *mmc, struct mmc_command *cmd)
>> >>> >>  {
>> >>> >>       struct mmc_data *data;
>> >>> >>       struct dw_mci_slot *slot = mmc_priv(mmc);
>> >>> >> +     struct dw_mci *host = slot->host;
>> >>> >>       const struct dw_mci_drv_data *drv_data = slot->host->drv_data;
>> >>> >>       u32 cmdr;
>> >>> >>       cmd->error = -EINPROGRESS;
>> >>> >> @@ -254,6 +258,32 @@ static u32 dw_mci_prepare_command(struct mmc_host *mmc, struct mmc_command
>> >>> *cmd)
>> >>> >>       else if (cmd->opcode != MMC_SEND_STATUS && cmd->data)
>> >>> >>               cmdr |= SDMMC_CMD_PRV_DAT_WAIT;
>> >>> >>
>> >>> >> +     if (cmd->opcode == SD_SWITCH_VOLTAGE) {
>> >>> >> +             u32 clk_en_a;
>> >>> >> +
>> >>> >> +             /* Special bit makes CMD11 not die */
>> >>> >> +             cmdr |= SDMMC_CMD_VOLT_SWITCH;
>> >>> >> +
>> >>> >> +             /* Change state to continue to handle CMD11 weirdness */
>> >>> >> +             WARN_ON(slot->host->state != STATE_SENDING_CMD);
>> >>> >> +             slot->host->state = STATE_SENDING_CMD11;
>> >>> >> +
>> >>> >> +             /*
>> >>> >> +              * We need to disable clock stop while doing voltage switch
>> >>> >> +              * according to 7.4.1.2 Voltage Switch Normal Scenario.
>> >>> >> +              *
>> >>> >> +              * It's assumed that by the next time the CLKENA is updated
>> >>> >> +              * (when we set the clock next) that the voltage change will
>> >>> >> +              * be over, so we don't bother setting any bits to synchronize
>> >>> >> +              * with dw_mci_setup_bus().
>> >>> >> +              */
>> >>> >> +             clk_en_a = mci_readl(host, CLKENA);
>> >>> >> +             clk_en_a &= ~(SDMMC_CLKEN_LOW_PWR << slot->id);
>> >>> >> +             mci_writel(host, CLKENA, clk_en_a);
>> >>> >> +             mci_send_cmd(slot, SDMMC_CMD_UPD_CLK |
>> >>> >> +                          SDMMC_CMD_PRV_DAT_WAIT, 0);
>> >>> > dw_mci_disable_low_power() can be used here.
>> >>>
>> >>> Ah.  I guess we don't have that locally anymore.  Locally we have variants on:
>> >> I'm checking on cjb/mmc branch.
>> >>
>> >>> * https://patchwork.kernel.org/patch/3070311/
>> >>> * https://patchwork.kernel.org/patch/3070251/
>> >>> * https://patchwork.kernel.org/patch/3070221/
>> >>>
>> >>> ...which removed that function.  ...but I guess upstream never picked
>> >>> up those patches, huh?  Looking back it looks like you had some
>> >>> feedback and it needed another spin but somehow fell off my plate.  :(
>> >>>
>> >>> Maybe this is something Yuvaraj would like to pick up?
>> >> It's long ago. I remember that there is no progress since my last comment.
>> >> In case of patch "3070221", I want to pick up for next Kernel.
>> >
>> > Sounds like Yuvaraj has agreed to look at addressing your comments.  Thanks!
>> >
>> >
>> >>> >> +     }
>> >>> >> +
>> >>> >>       if (cmd->flags & MMC_RSP_PRESENT) {
>> >>> >>               /* We expect a response, so set this bit */
>> >>> >>               cmdr |= SDMMC_CMD_RESP_EXP;
>> >>> >> @@ -776,11 +806,15 @@ static void dw_mci_setup_bus(struct dw_mci_slot *slot, bool force_clkinit)
>> >>> >>       unsigned int clock = slot->clock;
>> >>> >>       u32 div;
>> >>> >>       u32 clk_en_a;
>> >>> >> +     u32 sdmmc_cmd_bits = SDMMC_CMD_UPD_CLK | SDMMC_CMD_PRV_DAT_WAIT;
>> >>> >> +
>> >>> >> +     /* We must continue to set bit 28 in CMD until the change is complete */
>> >>> >> +     if (host->state == STATE_WAITING_CMD11_DONE)
>> >>> >> +             sdmmc_cmd_bits |= SDMMC_CMD_VOLT_SWITCH;
>> >>> > I didn't get the reason SDMMC_CMD_VOLT_SWITCH is needed during clock update(enable/disable)
>> >>> > Can you explain it in details?
>> >>>
>> >>> Simply put: if I didn't do this then the system hung during voltage
>> >>> switch.  It was not documented in the version of the IP manual that I
>> >>> had access to and it took me a bunch of digging / trial and error to
>> >>> figure this out.  Whatever this bit does internally it's important to
>> >>> set it while the voltage change is happening.  Note that this need was
>> >>> the whole reason for adding the extra state to the state machine.
>> >>>
>> >>> Perhaps Yuvaraj can try without it and I'd assume he'll report the
>> >>> same freeze.
>> >> Clarify the necessity of SDMMC_CMD_VOLT_SWITCH.
>> >> As far as I experience, we didn't apply this bit for several projects.
>> >
>> > I just tried this locally on our ChromeOS 3.8 kernel (which has quite
>> > a few backports and matches dw_mmc upstream pretty closely).  When I
>> > take out "sdmmc_cmd_bits |= SDMMC_CMD_VOLT_SWITCH" and bootup it fails
>> > to bringup WiFi chip.  It prints messages like:
>> >
>> > [    4.400842] mmc_host mmc1: Timeout sending command (cmd 0x202000
>> > arg 0x0 status 0x80202000)
>> >
>> > I will let Yuvaraj comment about his testing too.
>> To make it simple and verify, i have just enabled eMMC and SD channels
>> on 3.16-rc1 and tested.
>> Without "sdmmc_cmd_bits |= SDMMC_CMD_VOLT_SWITCH" bootup fails.
>> [    3.015971] mmc_host mmc1: Timeout sending command (cmd 0x202000
>> arg 0x0 status 0x80202000)
>> [    3.530974] mmc_host mmc1: Timeout sending command (cmd 0x202000
>> arg 0x0 status 0x80202000)
> Thank you for test.
> Hmm, it failed during clock update, right?.
> Can you check HLE interrupt at this time?
> I'll investigate for this.
Yes, it failed during clock update.I am dumping the register contents
just before the dev_err statement.I can observe that 1st timeout does
not have HLE interrupt.But once we set bit 0 of UHS_REG subsequent
timeout's have HLE bit set.I am attaching the complete log.
>
>> >
>> >
>> >>> >> +static int dw_mci_switch_voltage(struct mmc_host *mmc, struct mmc_ios *ios)
>> >>> >> +{
>> >>> >> +     struct dw_mci_slot *slot = mmc_priv(mmc);
>> >>> >> +     struct dw_mci *host = slot->host;
>> >>> >> +     u32 uhs;
>> >>> >> +     u32 v18 = SDMMC_UHS_18V << slot->id;
>> >>> >> +     int min_uv, max_uv;
>> >>> >> +     int ret;
>> >>> >> +
>> >>> >> +     /*
>> >>> >> +      * Program the voltage.  Note that some instances of dw_mmc may use
>> >>> >> +      * the UHS_REG for this.  For other instances (like exynos) the UHS_REG
>> >>> >> +      * does no harm but you need to set the regulator directly.  Try both.
>> >>> >> +      */
>> >>> >> +     uhs = mci_readl(host, UHS_REG);
>> >>> >> +     if (ios->signal_voltage == MMC_SIGNAL_VOLTAGE_330) {
>> >>> >> +             min_uv = 2700000;
>> >>> >> +             max_uv = 3600000;
>> >>> >> +             uhs &= ~v18;
>> >>> >> +     } else {
>> >>> >> +             min_uv = 1700000;
>> >>> >> +             max_uv = 1950000;
>> >>> >> +             uhs |= v18;
>> >>> >> +     }
>> >>> >> +     if (!IS_ERR(mmc->supply.vqmmc)) {
>> >>> >> +             ret = regulator_set_voltage(mmc->supply.vqmmc, min_uv, max_uv);
>> >>> >> +
>> >>> >> +             /*
>> >>> >> +              * Only complain if regulator claims that it's not in the 1.8V
>> >>> >> +              * range.  This avoids a bunch of errors in the case that
>> >>> >> +              * we've got a fixed 1.8V regulator but the core SD code still
>> >>> >> +              * thinks it ought to try to switch to 3.3 and then back to 1.8
>> >>> >> +              */
>> >>> >> +             if (ret) {
>> >>> > I think if ret is error, printing message and returning error is good.
>> >>> > Currently, just returning '0' though it fails.
>> >> Any feedback?
>> >
>> > Whoops, right.  I think you're right that in the case it warns it
>> > should also return the error code.  In the case it doesn't warn it
>> > shouldn't.  Also: possibly we should use a trick like the mmc core
>> > does and use "regulator_count_voltages" to figure out if we're going
>> > to be able to switch voltages...
>> >
>> >>> > Artificially adding SDMMC_INT_CMD_DONE to pending is needed to complete cmd handling?
>> >>> > Is there any reason?
>> >>>
>> >>> I don't remember this for sure since I wrote this a long time ago.
>> >>> Maybe it's not needed?  I may have just been modeling on other
>> >>> interrupts.
>> >> If there is no specific reason, please remove it.
>> >
>> > OK, we'll see how Yuvaraj's testing goes without it.  My incredibly
>> > brief testing in our local Chrome OS 3.8 tree shows that the WiFi is
>> > not detected properly if I comment out the line:
>> >   dw_mci_cmd_interrupt(host,
>> >     pending | SDMMC_INT_CMD_DONE);
>> >
>> > It may be sufficient to simply schedule the tasklet or to do some
>> > other subset of dw_mci_cmd_interrupt().  Yuvaraj can confirm on the
>> > latest kernel and also investigate further.
> How about completing CMD without SDMMC_INT_CMD_DONE?
Without this tuning fails.
[    2.525284] mmc_host mmc0: Bus speed (slot 0) = 200000000Hz (slot
req 200000000Hz, actual 200000000HZ div = 0)
[  198.556573] random: nonblocking pool is initialized
[  240.226044] INFO: task kworker/u8:0:6 blocked for more than 120 seconds.
[  240.231276]       Not tainted 3.16.0-rc1-00010-g2f7a756-dirty #55
[  240.237359] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[  240.245150] kworker/u8:0    D c03a58a0     0     6      2 0x00000000
[  240.251487] Workqueue: kmmcd mmc_rescan
[  240.255297] [<c03a58a0>] (__schedule) from [<c03a5330>]
(schedule_timeout+0x130/0x170)
[  240.263201] [<c03a5330>] (schedule_timeout) from [<c03a6540>]
(wait_for_common+0xbc/0x14c)
[  240.271441] [<c03a6540>] (wait_for_common) from [<c02ca6e4>]
(mmc_wait_for_req_done+0x6c/0xf0)
[  240.280031] [<c02ca6e4>] (mmc_wait_for_req_done) from [<c02e3f10>]
(dw_mci_exynos_execute_tuning+0x1d4/0x2c4)
[  240.289919] [<c02e3f10>] (dw_mci_exynos_execute_tuning) from
[<c02e0198>] (dw_mci_execute_tuning+0x54/0xb4)
[  240.299635] [<c02e0198>] (dw_mci_execute_tuning) from [<c02cf47c>]
(mmc_init_card+0xeec/0x14ac)
[  240.308309] [<c02cf47c>] (mmc_init_card) from [<c02cfc34>]
(mmc_attach_mmc+0x8c/0x160)
[  240.316202] [<c02cfc34>] (mmc_attach_mmc) from [<c02cca0c>]
(mmc_rescan+0x2b0/0x308)
[  240.323924] [<c02cca0c>] (mmc_rescan) from [<c0032f60>]
(process_one_work+0xf8/0x364)
[  240.331732] [<c0032f60>] (process_one_work) from [<c0033800>]
(worker_thread+0x50/0x5a0)
[  240.339799] [<c0033800>] (worker_thread) from [<c0038e7c>]
(kthread+0xd8/0xf0)
[  240.346999] [<c0038e7c>] (kthread) from [<c000e438>]
(ret_from_fork+0x14/0x3c)

>
> Thanks,
> Seungwon Jeon
>

--047d7bea31d059b1ee04fd1feb97
Content-Type: text/plain; charset=US-ASCII; name="voltage_switch.txt"
Content-Disposition: attachment; filename="voltage_switch.txt"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_hx33uqhk0

WyAgMzYwLjIzMTE0MF0gSU5GTzogdGFzayBzd2FwcGVyLzA6MSBibG9ja2VkIGZvciBtb3JlIHRo
YW4gMTIwIHNlY29uZHMuClsgIDM2MC4yMzYxMTNdICAgICAgIE5vdCB0YWludGVkIDMuMTYuMC1y
YzEtMDAwMTAtZzJmN2E3NTYtZGlydHkgIzUyClsgIDM2MC4yNDIxODNdICJlY2hvIDAgPiAvcHJv
Yy9zeXMva2VybmVsL2h1bmdfdGFza190aW1lb3V0X3NlY3MiIGRpc2FibGVzIHRoaXMgbWVzc2Fn
ZS4KWyAgMzYwLjI0OTk5MV0gc3dhcHBlci8wICAgICAgIEQgYzAzYTU4NTggICAgIDAgICAgIDEg
ICAgICAwIDB4MDAwMDAwMDAKWyAgMzYwLjI1NjMyOV0gWzxjMDNhNTg1OD5dIChfX3NjaGVkdWxl
KSBmcm9tIFs8YzAzYTUyYzg+XSAoc2NoZWR1bGVfdGltZW91dCsweDExMC8weDE3MCkKWyAgMzYw
LjI2NDIyMl0gWzxjMDNhNTJjOD5dIChzY2hlZHVsZV90aW1lb3V0KSBmcm9tIFs8YzAwMjg1NDA+
XSAobXNsZWVwKzB4MmMvMHgzOCkKWyAgMzYwLjI3MTU5Nl0gWzxjMDAyODU0MD5dIChtc2xlZXAp
IGZyb20gWzxjMDUwMzM5ND5dIChwcmVwYXJlX25hbWVzcGFjZSsweDEzYy8weDFkNCkKWyAgMzYw
LjI3OTIyOV0gWzxjMDUwMzM5ND5dIChwcmVwYXJlX25hbWVzcGFjZSkgZnJvbSBbPGMwNTAyZDU0
Pl0gKGtlcm5lbF9pbml0X2ZyZWVhYmxlKzB4MWNjLzB4MWRjKQpbICAzNjAuMjg4MDc3XSBbPGMw
NTAyZDU0Pl0gKGtlcm5lbF9pbml0X2ZyZWVhYmxlKSBmcm9tIFs8YzAzYTBiY2M+XSAoa2VybmVs
X2luaXQrMHhjLzB4ZTgpClsgIDM2MC4yOTYxNDVdIFs8YzAzYTBiY2M+XSAoa2VybmVsX2luaXQp
IGZyb20gWzxjMDAwZTQzOD5dIChyZXRfZnJvbV9mb3JrKzB4MTQvMHgzYykKWyAgNDgwLjIzMTEw
MV0gSU5GTzogdGFzayBzd2FwcGVyLzA6MSBibG9ja2VkIGZvciBtb3JlIHRoYW4gMTIwIHNlY29u
ZHMuClsgIDQ4MC4yMzYwNjldICAgICAgIE5vdCB0YWludGVkIDMuMTYuMC1yYzEtMDAwMTAtZzJm
N2E3NTYtZGlydHkgIzUyClsgIDQ4MC4yNDIxMzhdICJlY2hvIDAgPiAvcHJvYy9zeXMva2VybmVs
L2h1bmdfdGFza190aW1lb3V0X3NlY3MiIGRpc2FibGVzIHRoaXMgbWVzc2FnZS4KWyAgNDgwLjI0
OTk0OV0gc3dhcHBlci8wICAgICAgIEQgYzAzYTU4NTggICAgIDAgICAgIDEgICAgICAwIDB4MDAw
MDAwMDAKWyAgNDgwLjI1NjI4NF0gWzxjMDNhNTg1OD5dIChfX3NjaGVkdWxlKSBmcm9tIFs8YzAz
YTUyYzg+XSAoc2NoZWR1bGVfdGltZW91dCsweDExMC8weDE3MCkKWyAgNDgwLjI2NDE3OF0gWzxj
MDNhNTJjOD5dIChzY2hlZHVsZV90aW1lb3V0KSBmcm9tIFs8YzAwMjg1NDA+XSAobXNsZWVwKzB4
MmMvMHgzOCkKWyAgNDgwLjI3MTU1MV0gWzxjMDAyODU0MD5dIChtc2xlZXApIGZyb20gWzxjMDUw
MzM5ND5dIChwcmVwYXJlX25hbWVzcGFjZSsweDEzYy8weDFkNCkKWyAgNDgwLjI3OTE4NV0gWzxj
MDUwMzM5ND5dIChwcmVwYXJlX25hbWVzcGFjZSkgZnJvbSBbPGMwNTAyZDU0Pl0gKGtlcm5lbF9p
bml0X2ZyZWVhYmxlKzB4MWNjLzB4MWRjKQpbICA0ODAuMjg4MDMzXSBbPGMwNTAyZDU0Pl0gKGtl
cm5lbF9pbml0X2ZyZWVhYmxlKSBmcm9tIFs8YzAzYTBiY2M+XSAoa2VybmVsX2luaXQrMHhjLzB4
ZTgpClsgIDQ4MC4yOTYxMDFdIFs8YzAzYTBiY2M+XSAoa2VybmVsX2luaXQpIGZyb20gWzxjMDAw
ZTQzOD5dIChyZXRfZnJvbV9mb3JrKzB4MTQvMHgzYykKWyAgNjAwLjIzMTEzNV0gSU5GTzogdGFz
ayBzd2FwcGVyLzA6MSBibG9ja2VkIGZvciBtb3JlIHRoYW4gMTIwIHNlY29uZHMuClsgIDYwMC4y
MzYxMDNdICAgICAgIE5vdCB0YWludGVkIDMuMTYuMC1yYzEtMDAwMTAtZzJmN2E3NTYtZGlydHkg
IzUyClsgIDYwMC4yNDIxNzNdICJlY2hvIDAgPiAvcHJvYy9zeXMva2VybmVsL2h1bmdfdGFza190
aW1lb3V0X3NlY3MiIGRpc2FibGVzIHRoaXMgbWVzc2FnZS4KWyAgNjAwLjI0OTk4MV0gc3dhcHBl
ci8wICAgICAgIEQgYzAzYTU4NTggICAgIDAgICAgIDEgICAgICAwIDB4MDAwMDAwMDAKWyAgNjAw
LjI1NjMxOV0gWzxjMDNhNTg1OD5dIChfX3NjaGVkdWxlKSBmcm9tIFs8YzAzYTUyYzg+XSAoc2No
ZWR1bGVfdGltZW91dCsweDExMC8weDE3MCkKWyAgNjAwLjI2NDIxMl0gWzxjMDNhNTJjOD5dIChz
Y2hlZHVsZV90aW1lb3V0KSBmcm9tIFs8YzAwMjg1NDA+XSAobXNsZWVwKzB4MmMvMHgzOCkKWyAg
NjAwLjI3MTU4NV0gWzxjMDAyODU0MD5dIChtc2xlZXApIGZyb20gWzxjMDUwMzM5ND5dIChwcmVw
YXJlX25hbWVzcGFjZSsweDEzYy8weDFkNCkKWyAgNjAwLjI3OTIxOV0gWzxjMDUwMzM5ND5dIChw
cmVwYXJlX25hbWVzcGFjZSkgZnJvbSBbPGMwNTAyZDU0Pl0gKGtlcm5lbF9pbml0X2ZyZWVhYmxl
KzB4MWNjLzB4MWRjKQpbICA2MDAuMjg4MDY4XSBbPGMwNTAyZDU0Pl0gKGtlcm5lbF9pbml0X2Zy
ZWVhYmxlKSBmcm9tIFs8YzAzYTBiY2M+XSAoa2VybmVsX2luaXQrMHhjLzB4ZTgpClsgIDYwMC4y
OTYxMzZdIFs8YzAzYTBiY2M+XSAoa2VybmVsX2luaXQpIGZyb20gWzxjMDAwZTQzOD5dIChyZXRf
ZnJvbV9mb3JrKzB4MTQvMHgzYykKCgpVLUJvb3QgMjAxMy4wNCAoRmViIDIxIDIwMTQgLSAxNToy
OToxMCkgZm9yIFBlYWNoCgpDUFU6CUV4eW5vczU0MjBAOTAwTUh6CgpCb2FyZDogR29vZ2xlIFBl
YWNoIFBpdCwgcmV2IDYuMApJMkM6ICAgcmVhZHkKRFJBTTogIDIgR2lCClBNSUMgbWF4Nzc4MDIt
cG1pYyBpbml0aWFsaXplZApDUFU6CUV4eW5vczU0MjBAMTgwME1IegpUUFM2NTA5MCBQTUlDIEVD
IGluaXQKTU1DOiAgIEVYWU5PUyBEV01NQzogMCwgRVhZTk9TIERXTU1DOiAxClNGOiBEZXRlY3Rl
ZCBXMjVRMzJEVyB3aXRoIHBhZ2Ugc2l6ZSA0IEtpQiwgdG90YWwgMzIgTWlCCkluOiAgICBjcm9z
LWVjLWtleWIKT3V0OiAgIGxjZApFcnI6ICAgbGNkClNGOiBEZXRlY3RlZCBXMjVRMzJEVyB3aXRo
IHBhZ2Ugc2l6ZSA0IEtpQiwgdG90YWwgMzIgTWlCCkVMT0c6IEV2ZW50KDE3KSBhZGRlZCB3aXRo
IHNpemUgMTMKTmV0OiAgIE5vIGV0aGVybmV0IGZvdW5kLgpIaXQgYW55IGtleSB0byBzdG9wIGF1
dG9ib290OiAgMyAICAggMiAICAggMSAICAggMCAKbW1jMSBpcyBjdXJyZW50IGRldmljZQoyOTM1
MTgzIGJ5dGVzIHJlYWQgaW4gMTU4IG1zICgxNy43IE1pQi9zKQojIyBMb2FkaW5nIGtlcm5lbCBm
cm9tIEZJVCBJbWFnZSBhdCAyMDAwODAwMCAuLi4KICAgVXNpbmcgJ2NvbmZAMScgY29uZmlndXJh
dGlvbgogICBUcnlpbmcgJ2tlcm5lbEAxJyBrZXJuZWwgc3ViaW1hZ2UKICAgICBEZXNjcmlwdGlv
bjogIHVuYXZhaWxhYmxlCiAgICAgVHlwZTogICAgICAgICBLZXJuZWwgSW1hZ2UgKG5vIGxvYWRp
bmcgZG9uZSkKICAgICBDb21wcmVzc2lvbjogIHVuY29tcHJlc3NlZAogICAgIERhdGEgU3RhcnQ6
ICAgMHgyMDAwODBhNAogICAgIERhdGEgU2l6ZTogICAgMjg5Mzk3NiBCeXRlcyA9IDIuOCBNaUIK
ICAgVmVyaWZ5aW5nIEhhc2ggSW50ZWdyaXR5IC4uLiBPSwojIyBMb2FkaW5nIGZkdCBmcm9tIEZJ
VCBJbWFnZSBhdCAyMDAwODAwMCAuLi4KICAgVXNpbmcgJ2NvbmZAMScgY29uZmlndXJhdGlvbgog
ICBUcnlpbmcgJ2ZkdEAxJyBmZHQgc3ViaW1hZ2UKICAgICBEZXNjcmlwdGlvbjogIGV4eW5vczU0
MjAtcGVhY2gtcGl0LmR0YgogICAgIFR5cGU6ICAgICAgICAgRmxhdCBEZXZpY2UgVHJlZQogICAg
IENvbXByZXNzaW9uOiAgdW5jb21wcmVzc2VkCiAgICAgRGF0YSBTdGFydDogICAweDIwMmNhOWY0
CiAgICAgRGF0YSBTaXplOiAgICA0MDA5OCBCeXRlcyA9IDM5LjIgS2lCCiAgICAgQXJjaGl0ZWN0
dXJlOiBBUk0KICAgVmVyaWZ5aW5nIEhhc2ggSW50ZWdyaXR5IC4uLiBPSwogICBCb290aW5nIHVz
aW5nIHRoZSBmZHQgYmxvYiBhdCAweDIwMmNhOWY0CiAgIFhJUCBLZXJuZWwgSW1hZ2UgKG5vIGxv
YWRpbmcgZG9uZSkgLi4uIE9LCiAgIExvYWRpbmcgRGV2aWNlIFRyZWUgdG8gM2ZmZTYwMDAsIGVu
ZCAzZmZmZjFkMSAuLi4gT0sKYm9vdF9rZXJuZWwuYzogZnRfYm9hcmRfc2V0dXA6IHdhcm5pbmc6
IGdfY3Jvc3N5c3RlbV9kYXRhIGlzIE5VTEwKClN0YXJ0aW5nIGtlcm5lbCAuLi4KClRpbWVyIHN1
bW1hcnkgaW4gbWljcm9zZWNvbmRzOgogICAgICAgTWFyayAgICBFbGFwc2VkICBTdGFnZQogICAg
ICAgICAgMCAgICAgICAgICAwICByZXNldAogICAgMTE0LDkzNSAgICAxMTQsOTM1ICBib2FyZF9p
bml0X2YKICAgIDE1OCw3NDMgICAgIDQzLDgwOCAgYm9hcmRfaW5pdF9yCiAgICAyNDUsMjQ3ICAg
ICA4Niw1MDQgIGlkPTY0CiAgICAyNDcsMjAxICAgICAgMSw5NTQgIG1haW5fbG9vcAogIDMsNzIw
LDc2OSAgMyw0NzMsNTY4ICBib290bV9zdGFydAogIDMsNzIwLDc3MCAgICAgICAgICAxICBpZD0x
CiAgMyw3MjUsNDE3ICAgICAgNCw2NDcgIGlkPTEwMAogIDMsNzI1LDQyMCAgICAgICAgICAzICBp
ZD0xMDEKICAzLDcyNSw0MjAgICAgICAgICAgMCAgaWQ9MTAyCiAgMyw3MjgsNzMxICAgICAgMywz
MTEgIGlkPTExMAogIDMsNzUzLDUwNyAgICAgMjQsNzc2ICBpZD0xMDUKICAzLDc1Myw1MDggICAg
ICAgICAgMSAgaWQ9MTA2CiAgMyw3NTMsNTEyICAgICAgICAgIDQgIGlkPTEwNwogIDMsNzUzLDUx
MyAgICAgICAgICAxICBpZD0xMDkKICAzLDc1Myw1MTMgICAgICAgICAgMCAgaWQ9MTA4CiAgMyw3
NTcsOTA1ICAgICAgNCwzOTIgIGlkPTkwCiAgMyw3NTcsOTA3ICAgICAgICAgIDIgIGlkPTkyCiAg
Myw3NTcsOTA3ICAgICAgICAgIDAgIGlkPTkxCiAgMyw3ODcsNTEyICAgICAyOSw2MDUgIGlkPTk1
CiAgMyw3ODcsNTE1ICAgICAgICAgIDMgIGlkPTk2CiAgMyw3ODcsNTE2ICAgICAgICAgIDEgIGlk
PTk3CiAgMyw3ODcsNTE4ICAgICAgICAgIDIgIGlkPTk4CiAgMyw3ODcsNTE5ICAgICAgICAgIDEg
IGlkPTk5CiAgMyw3OTYsNzQ3ICAgICAgOSwyMjggIGlkPTcKICAzLDgwOCw2NjEgICAgIDExLDkx
NCAgaWQ9MTUKICAzLDgxMSwzMjIgICAgICAyLDY2MSAgc3RhcnRfa2VybmVsCgpBY2N1bXVsYXRl
ZCB0aW1lOgogICAgICAgICAgICAgICAgIDYsOTIxICBTUEkgcmVhZApbICAgIDAuMDAwMDAwXSBC
b290aW5nIExpbnV4IG9uIHBoeXNpY2FsIENQVSAweDAKWyAgICAwLjAwMDAwMF0gTGludXggdmVy
c2lvbiAzLjE2LjAtcmMxLTAwMDEwLWcyZjdhNzU2LWRpcnR5IChjaHJvbWVvc0B5dXZhcmFqKSAo
Z2NjIHZlcnNpb24gNC44LjMgMjAxNDAxMDYgKHByZXJlbGVhc2UpIChjcm9zc3Rvb2wtTkcgbGlu
YXJvLTEuMTMuMS00LjgtMjAxNC4wMSAtIExpbmFybyBHQ0MgMjAxMy4xMSkgKSAjNTMgU01QIFBS
RUVNUFQgVHVlIEp1bCAxIDE0OjU1OjM0IElTVCAyMDE0ClsgICAgMC4wMDAwMDBdIENQVTogQVJN
djcgUHJvY2Vzc29yIFs0MTJmYzBmM10gcmV2aXNpb24gMyAoQVJNdjcpLCBjcj0xMGM1Mzg3ZApb
ICAgIDAuMDAwMDAwXSBDUFU6IFBJUFQgLyBWSVBUIG5vbmFsaWFzaW5nIGRhdGEgY2FjaGUsIFBJ
UFQgaW5zdHJ1Y3Rpb24gY2FjaGUKWyAgICAwLjAwMDAwMF0gTWFjaGluZSBtb2RlbDogR29vZ2xl
IFBlYWNoIFBpdCBSZXYgNisKWyAgICAwLjAwMDAwMF0gTWVtb3J5IHBvbGljeTogRGF0YSBjYWNo
ZSB3cml0ZWFsbG9jClsgICAgMC4wMDAwMDBdIE9uIG5vZGUgMCB0b3RhbHBhZ2VzOiA1MjQyODgK
WyAgICAwLjAwMDAwMF0gZnJlZV9hcmVhX2luaXRfbm9kZTogbm9kZSAwLCBwZ2RhdCBjMDU4MzMw
MCwgbm9kZV9tZW1fbWFwIGVlN2Y0MDAwClsgICAgMC4wMDAwMDBdICAgTm9ybWFsIHpvbmU6IDE1
MjAgcGFnZXMgdXNlZCBmb3IgbWVtbWFwClsgICAgMC4wMDAwMDBdICAgTm9ybWFsIHpvbmU6IDAg
cGFnZXMgcmVzZXJ2ZWQKWyAgICAwLjAwMDAwMF0gICBOb3JtYWwgem9uZTogMTk0NTYwIHBhZ2Vz
LCBMSUZPIGJhdGNoOjMxClsgICAgMC4wMDAwMDBdICAgSGlnaE1lbSB6b25lOiAyNTc2IHBhZ2Vz
IHVzZWQgZm9yIG1lbW1hcApbICAgIDAuMDAwMDAwXSAgIEhpZ2hNZW0gem9uZTogMzI5NzI4IHBh
Z2VzLCBMSUZPIGJhdGNoOjMxClsgICAgMC4wMDAwMDBdIFBFUkNQVTogRW1iZWRkZWQgNyBwYWdl
cy9jcHUgQGVlNzlmMDAwIHM3MTA0IHI4MTkyIGQxMzM3NiB1MzI3NjgKWyAgICAwLjAwMDAwMF0g
cGNwdS1hbGxvYzogczcxMDQgcjgxOTIgZDEzMzc2IHUzMjc2OCBhbGxvYz04KjQwOTYKWyAgICAw
LjAwMDAwMF0gcGNwdS1hbGxvYzogWzBdIDAgWzBdIDEgWzBdIDIgWzBdIDMgClsgICAgMC4wMDAw
MDBdIEJ1aWx0IDEgem9uZWxpc3RzIGluIFpvbmUgb3JkZXIsIG1vYmlsaXR5IGdyb3VwaW5nIG9u
LiAgVG90YWwgcGFnZXM6IDUyMjc2OApbICAgIDAuMDAwMDAwXSBLZXJuZWwgY29tbWFuZCBsaW5l
OiBjb25zb2xlPXR0eVNBQzMsMTE1MjAwIGRlYnVnIG5vX2NvbnNvbGVfc3VzcGVuZCByb290PS9k
ZXYvbW1jYmxrMXAzIHJvb3R3YWl0IHJ3IG5vX2NvbnNvbGVfc3VzcGVuZCBjbGtfaWdub3JlX3Vu
dXNlZApbICAgIDAuMDAwMDAwXSBQSUQgaGFzaCB0YWJsZSBlbnRyaWVzOiA0MDk2IChvcmRlcjog
MiwgMTYzODQgYnl0ZXMpClsgICAgMC4wMDAwMDBdIERlbnRyeSBjYWNoZSBoYXNoIHRhYmxlIGVu
dHJpZXM6IDEzMTA3MiAob3JkZXI6IDcsIDUyNDI4OCBieXRlcykKWyAgICAwLjAwMDAwMF0gSW5v
ZGUtY2FjaGUgaGFzaCB0YWJsZSBlbnRyaWVzOiA2NTUzNiAob3JkZXI6IDYsIDI2MjE0NCBieXRl
cykKWyAgICAwLjAwMDAwMF0gTWVtb3J5OiAyMDczNjEySy8yMDk3MTUySyBhdmFpbGFibGUgKDM4
NDlLIGtlcm5lbCBjb2RlLCAyNTVLIHJ3ZGF0YSwgMTI0NEsgcm9kYXRhLCAyNThLIGluaXQsIDI3
MUsgYnNzLCAyMzU0MEsgcmVzZXJ2ZWQsIDEzMTg5MTJLIGhpZ2htZW0pClsgICAgMC4wMDAwMDBd
IFZpcnR1YWwga2VybmVsIG1lbW9yeSBsYXlvdXQ6ClsgICAgMC4wMDAwMDBdICAgICB2ZWN0b3Ig
IDogMHhmZmZmMDAwMCAtIDB4ZmZmZjEwMDAgICAoICAgNCBrQikKWyAgICAwLjAwMDAwMF0gICAg
IGZpeG1hcCAgOiAweGZmYzAwMDAwIC0gMHhmZmUwMDAwMCAgICgyMDQ4IGtCKQpbICAgIDAuMDAw
MDAwXSAgICAgdm1hbGxvYyA6IDB4ZjAwMDAwMDAgLSAweGZmMDAwMDAwICAgKCAyNDAgTUIpClsg
ICAgMC4wMDAwMDBdICAgICBsb3dtZW0gIDogMHhjMDAwMDAwMCAtIDB4ZWY4MDAwMDAgICAoIDc2
MCBNQikKWyAgICAwLjAwMDAwMF0gICAgIHBrbWFwICAgOiAweGJmZTAwMDAwIC0gMHhjMDAwMDAw
MCAgICggICAyIE1CKQpbICAgIDAuMDAwMDAwXSAgICAgbW9kdWxlcyA6IDB4YmYwMDAwMDAgLSAw
eGJmZTAwMDAwICAgKCAgMTQgTUIpClsgICAgMC4wMDAwMDBdICAgICAgIC50ZXh0IDogMHhjMDAw
ODAwMCAtIDB4YzA1MDE3YmMgICAoNTA5NCBrQikKWyAgICAwLjAwMDAwMF0gICAgICAgLmluaXQg
OiAweGMwNTAyMDAwIC0gMHhjMDU0MmJjMCAgICggMjU5IGtCKQpbICAgIDAuMDAwMDAwXSAgICAg
ICAuZGF0YSA6IDB4YzA1NDQwMDAgLSAweGMwNTgzZWEwICAgKCAyNTYga0IpClsgICAgMC4wMDAw
MDBdICAgICAgICAuYnNzIDogMHhjMDU4M2VhYyAtIDB4YzA1YzdkNDAgICAoIDI3MiBrQikKWyAg
ICAwLjAwMDAwMF0gU0xVQjogSFdhbGlnbj02NCwgT3JkZXI9MC0zLCBNaW5PYmplY3RzPTAsIENQ
VXM9NCwgTm9kZXM9MQpbICAgIDAuMDAwMDAwXSBQcmVlbXB0aWJsZSBoaWVyYXJjaGljYWwgUkNV
IGltcGxlbWVudGF0aW9uLgpbICAgIDAuMDAwMDAwXSAJUkNVIHJlc3RyaWN0aW5nIENQVXMgZnJv
bSBOUl9DUFVTPTggdG8gbnJfY3B1X2lkcz00LgpbICAgIDAuMDAwMDAwXSBSQ1U6IEFkanVzdGlu
ZyBnZW9tZXRyeSBmb3IgcmN1X2Zhbm91dF9sZWFmPTE2LCBucl9jcHVfaWRzPTQKWyAgICAwLjAw
MDAwMF0gTlJfSVJRUzoxNiBucl9pcnFzOjE2IDE2ClsgICAgMC4wMDAwMDBdIEwyQzogZmFpbGVk
IHRvIGluaXQ6IC0xOQpbICAgIDAuMDAwMDA0XSBzY2hlZF9jbG9jazogNjQgYml0cyBhdCAyNE1I
eiwgcmVzb2x1dGlvbiA0MW5zLCB3cmFwcyBldmVyeSAyODYzMzExNTE5NzQ0bnMKWyAgICAwLjAw
MDE5Nl0gQ29uc29sZTogY29sb3VyIGR1bW15IGRldmljZSA4MHgzMApbICAgIDAuMDAwMjExXSBD
YWxpYnJhdGluZyBkZWxheSBsb29wLi4uIDM1OTQuNjQgQm9nb01JUFMgKGxwaj04OTg2NjI0KQpb
ICAgIDAuMDMwMDAzXSBwaWRfbWF4OiBkZWZhdWx0OiAzMjc2OCBtaW5pbXVtOiAzMDEKWyAgICAw
LjAzMDEwM10gTW91bnQtY2FjaGUgaGFzaCB0YWJsZSBlbnRyaWVzOiAyMDQ4IChvcmRlcjogMSwg
ODE5MiBieXRlcykKWyAgICAwLjAzMDExMV0gTW91bnRwb2ludC1jYWNoZSBoYXNoIHRhYmxlIGVu
dHJpZXM6IDIwNDggKG9yZGVyOiAxLCA4MTkyIGJ5dGVzKQpbICAgIDAuMDMwNDM0XSBDUFU6IFRl
c3Rpbmcgd3JpdGUgYnVmZmVyIGNvaGVyZW5jeTogb2sKWyAgICAwLjAzMDU3N10gQ1BVMDogdXBk
YXRlIGNwdV9jYXBhY2l0eSAxMDI0ClsgICAgMC4wMzA1ODRdIENQVTA6IHRocmVhZCAtMSwgY3B1
IDAsIHNvY2tldCAwLCBtcGlkciA4MDAwMDAwMApbICAgIDAuMDMwNjgxXSBTZXR0aW5nIHVwIHN0
YXRpYyBpZGVudGl0eSBtYXAgZm9yIDB4MjAzYWExMzAgLSAweDIwM2FhMTg4ClsgICAgMC4wMzA3
NzldIEFSTSBDQ0kgZHJpdmVyIHByb2JlZApbICAgIDAuMDMwODE0XSBFeHlub3MgTUNQTSBzdXBw
b3J0IGluc3RhbGxlZApbICAgIDAuMDYwMjM1XSBDUFUxOiBCb290ZWQgc2Vjb25kYXJ5IHByb2Nl
c3NvcgpbICAgIDAuMDkwMDA2XSBDUFUxOiB1cGRhdGUgY3B1X2NhcGFjaXR5IDEwMjQKWyAgICAw
LjA5MDAxMF0gQ1BVMTogdGhyZWFkIC0xLCBjcHUgMSwgc29ja2V0IDAsIG1waWRyIDgwMDAwMDAx
ClsgICAgMC4xMDAyMjhdIENQVTI6IEJvb3RlZCBzZWNvbmRhcnkgcHJvY2Vzc29yClsgICAgMC4x
MzAwMDddIENQVTI6IHVwZGF0ZSBjcHVfY2FwYWNpdHkgMTAyNApbICAgIDAuMTMwMDExXSBDUFUy
OiB0aHJlYWQgLTEsIGNwdSAyLCBzb2NrZXQgMCwgbXBpZHIgODAwMDAwMDIKWyAgICAwLjE0MDIz
N10gQ1BVMzogQm9vdGVkIHNlY29uZGFyeSBwcm9jZXNzb3IKWyAgICAwLjE3MDAwOF0gQ1BVMzog
dXBkYXRlIGNwdV9jYXBhY2l0eSAxMDI0ClsgICAgMC4xNzAwMTFdIENQVTM6IHRocmVhZCAtMSwg
Y3B1IDMsIHNvY2tldCAwLCBtcGlkciA4MDAwMDAwMwpbICAgIDAuMTcwMDcwXSBCcm91Z2h0IHVw
IDQgQ1BVcwpbICAgIDAuMTcwMDg4XSBTTVA6IFRvdGFsIG9mIDQgcHJvY2Vzc29ycyBhY3RpdmF0
ZWQuClsgICAgMC4xNzAwOTNdIENQVTogQWxsIENQVShzKSBzdGFydGVkIGluIFNWQyBtb2RlLgpb
ICAgIDAuMTcwNDQxXSBkZXZ0bXBmczogaW5pdGlhbGl6ZWQKWyAgICAwLjE3NTUyNV0gVkZQIHN1
cHBvcnQgdjAuMzogaW1wbGVtZW50b3IgNDEgYXJjaGl0ZWN0dXJlIDQgcGFydCAzMCB2YXJpYW50
IGYgcmV2IDAKWyAgICAwLjE3NTg0NF0gcGluY3RybCBjb3JlOiBpbml0aWFsaXplZCBwaW5jdHJs
IHN1YnN5c3RlbQpbICAgIDAuMTc2MTk2XSByZWd1bGF0b3ItZHVtbXk6IG5vIHBhcmFtZXRlcnMK
WyAgICAwLjE4ODIxOV0gTkVUOiBSZWdpc3RlcmVkIHByb3RvY29sIGZhbWlseSAxNgpbICAgIDAu
MTg4MzY3XSBETUE6IHByZWFsbG9jYXRlZCAyNTYgS2lCIHBvb2wgZm9yIGF0b21pYyBjb2hlcmVu
dCBhbGxvY2F0aW9ucwpbICAgIDAuMTkxNzY5XSBncGlvY2hpcF9hZGQ6IHJlZ2lzdGVyZWQgR1BJ
T3MgMCB0byA3IG9uIGRldmljZTogZ3B5NwpbICAgIDAuMTkxNzc4XSBncGlvY2hpcF9hZGQ6IHJl
Z2lzdGVyZWQgR1BJT3MgOCB0byAxNSBvbiBkZXZpY2U6IGdweDAKWyAgICAwLjE5MTc4N10gZ3Bp
b2NoaXBfYWRkOiByZWdpc3RlcmVkIEdQSU9zIDE2IHRvIDIzIG9uIGRldmljZTogZ3B4MQpbICAg
IDAuMTkxNzk0XSBncGlvY2hpcF9hZGQ6IHJlZ2lzdGVyZWQgR1BJT3MgMjQgdG8gMzEgb24gZGV2
aWNlOiBncHgyClsgICAgMC4xOTE4MDJdIGdwaW9jaGlwX2FkZDogcmVnaXN0ZXJlZCBHUElPcyAz
MiB0byAzOSBvbiBkZXZpY2U6IGdweDMKWyAgICAwLjE5MjQ3NV0gZ3Bpb2NoaXBfYWRkOiByZWdp
c3RlcmVkIEdQSU9zIDQwIHRvIDQ3IG9uIGRldmljZTogZ3BjMApbICAgIDAuMTkyNDg0XSBncGlv
Y2hpcF9hZGQ6IHJlZ2lzdGVyZWQgR1BJT3MgNDggdG8gNTUgb24gZGV2aWNlOiBncGMxClsgICAg
MC4xOTI0OTFdIGdwaW9jaGlwX2FkZDogcmVnaXN0ZXJlZCBHUElPcyA1NiB0byA2MiBvbiBkZXZp
Y2U6IGdwYzIKWyAgICAwLjE5MjQ5OF0gZ3Bpb2NoaXBfYWRkOiByZWdpc3RlcmVkIEdQSU9zIDYz
IHRvIDY2IG9uIGRldmljZTogZ3BjMwpbICAgIDAuMTkyNTA1XSBncGlvY2hpcF9hZGQ6IHJlZ2lz
dGVyZWQgR1BJT3MgNjcgdG8gNjggb24gZGV2aWNlOiBncGM0ClsgICAgMC4xOTI1MTNdIGdwaW9j
aGlwX2FkZDogcmVnaXN0ZXJlZCBHUElPcyA2OSB0byA3NiBvbiBkZXZpY2U6IGdwZDEKWyAgICAw
LjE5MjUyMF0gZ3Bpb2NoaXBfYWRkOiByZWdpc3RlcmVkIEdQSU9zIDc3IHRvIDgyIG9uIGRldmlj
ZTogZ3B5MApbICAgIDAuMTkyNTI2XSBncGlvY2hpcF9hZGQ6IHJlZ2lzdGVyZWQgR1BJT3MgODMg
dG8gODYgb24gZGV2aWNlOiBncHkxClsgICAgMC4xOTI1MzRdIGdwaW9jaGlwX2FkZDogcmVnaXN0
ZXJlZCBHUElPcyA4NyB0byA5MiBvbiBkZXZpY2U6IGdweTIKWyAgICAwLjE5MjU0MV0gZ3Bpb2No
aXBfYWRkOiByZWdpc3RlcmVkIEdQSU9zIDkzIHRvIDEwMCBvbiBkZXZpY2U6IGdweTMKWyAgICAw
LjE5MjU0OF0gZ3Bpb2NoaXBfYWRkOiByZWdpc3RlcmVkIEdQSU9zIDEwMSB0byAxMDggb24gZGV2
aWNlOiBncHk0ClsgICAgMC4xOTI1NTVdIGdwaW9jaGlwX2FkZDogcmVnaXN0ZXJlZCBHUElPcyAx
MDkgdG8gMTE2IG9uIGRldmljZTogZ3B5NQpbICAgIDAuMTkyNTYyXSBncGlvY2hpcF9hZGQ6IHJl
Z2lzdGVyZWQgR1BJT3MgMTE3IHRvIDEyNCBvbiBkZXZpY2U6IGdweTYKWyAgICAwLjE5MzA0NF0g
Z3Bpb2NoaXBfYWRkOiByZWdpc3RlcmVkIEdQSU9zIDEyNSB0byAxMzIgb24gZGV2aWNlOiBncGUw
ClsgICAgMC4xOTMwNTJdIGdwaW9jaGlwX2FkZDogcmVnaXN0ZXJlZCBHUElPcyAxMzMgdG8gMTM0
IG9uIGRldmljZTogZ3BlMQpbICAgIDAuMTkzMDYwXSBncGlvY2hpcF9hZGQ6IHJlZ2lzdGVyZWQg
R1BJT3MgMTM1IHRvIDE0MCBvbiBkZXZpY2U6IGdwZjAKWyAgICAwLjE5MzA2N10gZ3Bpb2NoaXBf
YWRkOiByZWdpc3RlcmVkIEdQSU9zIDE0MSB0byAxNDggb24gZGV2aWNlOiBncGYxClsgICAgMC4x
OTMwNzNdIGdwaW9jaGlwX2FkZDogcmVnaXN0ZXJlZCBHUElPcyAxNDkgdG8gMTU2IG9uIGRldmlj
ZTogZ3BnMApbICAgIDAuMTkzMDgwXSBncGlvY2hpcF9hZGQ6IHJlZ2lzdGVyZWQgR1BJT3MgMTU3
IHRvIDE2NCBvbiBkZXZpY2U6IGdwZzEKWyAgICAwLjE5MzA4N10gZ3Bpb2NoaXBfYWRkOiByZWdp
c3RlcmVkIEdQSU9zIDE2NSB0byAxNjYgb24gZGV2aWNlOiBncGcyClsgICAgMC4xOTMwOTVdIGdw
aW9jaGlwX2FkZDogcmVnaXN0ZXJlZCBHUElPcyAxNjcgdG8gMTcwIG9uIGRldmljZTogZ3BqNApb
ICAgIDAuMTkzNTMzXSBncGlvY2hpcF9hZGQ6IHJlZ2lzdGVyZWQgR1BJT3MgMTcxIHRvIDE3OCBv
biBkZXZpY2U6IGdwYTAKWyAgICAwLjE5MzU0Ml0gZ3Bpb2NoaXBfYWRkOiByZWdpc3RlcmVkIEdQ
SU9zIDE3OSB0byAxODQgb24gZGV2aWNlOiBncGExClsgICAgMC4xOTM1NDldIGdwaW9jaGlwX2Fk
ZDogcmVnaXN0ZXJlZCBHUElPcyAxODUgdG8gMTkyIG9uIGRldmljZTogZ3BhMgpbICAgIDAuMTkz
NTU2XSBncGlvY2hpcF9hZGQ6IHJlZ2lzdGVyZWQgR1BJT3MgMTkzIHRvIDE5NyBvbiBkZXZpY2U6
IGdwYjAKWyAgICAwLjE5MzU2M10gZ3Bpb2NoaXBfYWRkOiByZWdpc3RlcmVkIEdQSU9zIDE5OCB0
byAyMDIgb24gZGV2aWNlOiBncGIxClsgICAgMC4xOTM1NzBdIGdwaW9jaGlwX2FkZDogcmVnaXN0
ZXJlZCBHUElPcyAyMDMgdG8gMjA2IG9uIGRldmljZTogZ3BiMgpbICAgIDAuMTkzNTc4XSBncGlv
Y2hpcF9hZGQ6IHJlZ2lzdGVyZWQgR1BJT3MgMjA3IHRvIDIxNCBvbiBkZXZpY2U6IGdwYjMKWyAg
ICAwLjE5MzU4NF0gZ3Bpb2NoaXBfYWRkOiByZWdpc3RlcmVkIEdQSU9zIDIxNSB0byAyMTYgb24g
ZGV2aWNlOiBncGI0ClsgICAgMC4xOTM1OTJdIGdwaW9jaGlwX2FkZDogcmVnaXN0ZXJlZCBHUElP
cyAyMTcgdG8gMjI0IG9uIGRldmljZTogZ3BoMApbICAgIDAuMTk0MTY2XSBncGlvY2hpcF9hZGQ6
IHJlZ2lzdGVyZWQgR1BJT3MgMjI1IHRvIDIzMSBvbiBkZXZpY2U6IGdwegpbICAgIDAuMTk1MTgy
XSBleHlub3MtYXVkc3MtY2xrIDM4MTAwMDAuYXVkc3MtY2xvY2stY29udHJvbGxlcjogc2V0dXAg
Y29tcGxldGVkClsgICAgMC4yMDIyODBdIEVYWU5PUzU0MjAgUE1VIEluaXRpYWxpemVkClsgICAg
MC4yMjU4ODVdIG9mX2dldF9uYW1lZF9ncGlvZF9mbGFncyBleGl0ZWQgd2l0aCBzdGF0dXMgMApb
ICAgIDAuMjI1OTg5XSBQNS4wVl9VU0IzQ09OMDogNTAwMCBtViAKWyAgICAwLjIyNjEyMF0gb2Zf
Z2V0X25hbWVkX2dwaW9kX2ZsYWdzIGV4aXRlZCB3aXRoIHN0YXR1cyAwClsgICAgMC4yMjYyMThd
IFA1LjBWX1VTQjNDT04xOiA1MDAwIG1WIApbICAgIDAuMjI2MzM4XSBvZl9nZXRfbmFtZWRfZ3Bp
b2RfZmxhZ3MgZXhpdGVkIHdpdGggc3RhdHVzIDAKWyAgICAwLjIyNjQzNV0gbWFzay10cG0tcmVz
ZXQgOiBubyBwYXJhbWV0ZXJzClsgICAgMC4yMjY1MzRdIG9mX2dldF9uYW1lZF9ncGlvZF9mbGFn
czogY2FuJ3QgcGFyc2UgZ3Bpb3MgcHJvcGVydHkgb2Ygbm9kZSAnL2ZpeGVkLXJlZ3VsYXRvclsw
XScKWyAgICAwLjIyNjYxOV0gdmJhdC1zdXBwbHk6IG5vIHBhcmFtZXRlcnMKWyAgICAwLjIyNzg2
NV0gU0NTSSBzdWJzeXN0ZW0gaW5pdGlhbGl6ZWQKWyAgICAwLjIyODIwMV0gdXNiY29yZTogcmVn
aXN0ZXJlZCBuZXcgaW50ZXJmYWNlIGRyaXZlciB1c2JmcwpbICAgIDAuMjI4Mjc4XSB1c2Jjb3Jl
OiByZWdpc3RlcmVkIG5ldyBpbnRlcmZhY2UgZHJpdmVyIGh1YgpbICAgIDAuMjI4MzY1XSB1c2Jj
b3JlOiByZWdpc3RlcmVkIG5ldyBkZXZpY2UgZHJpdmVyIHVzYgpbICAgIDAuMjI4Njc5XSBzM2Mt
aTJjIDEyYzgwMDAwLmkyYzogc2xhdmUgYWRkcmVzcyAweDUwClsgICAgMC4yMjg2OTFdIHMzYy1p
MmMgMTJjODAwMDAuaTJjOiBidXMgZnJlcXVlbmN5IHNldCB0byA2NSBLSHoKWyAgICAwLjIyODgx
OV0gczNjLWkyYyAxMmM4MDAwMC5pMmM6IGkyYy0yOiBTM0MgSTJDIGFkYXB0ZXIKWyAgICAwLjIy
OTc4M10gU3dpdGNoZWQgdG8gY2xvY2tzb3VyY2UgbWN0LWZyYwpbICAgIDAuMjM5NDUyXSBORVQ6
IFJlZ2lzdGVyZWQgcHJvdG9jb2wgZmFtaWx5IDIKWyAgICAwLjIzOTg2MV0gVENQIGVzdGFibGlz
aGVkIGhhc2ggdGFibGUgZW50cmllczogODE5MiAob3JkZXI6IDMsIDMyNzY4IGJ5dGVzKQpbICAg
IDAuMjM5OTA5XSBUQ1AgYmluZCBoYXNoIHRhYmxlIGVudHJpZXM6IDgxOTIgKG9yZGVyOiA1LCAx
NjM4NDAgYnl0ZXMpClsgICAgMC4yNDAwMDBdIFRDUDogSGFzaCB0YWJsZXMgY29uZmlndXJlZCAo
ZXN0YWJsaXNoZWQgODE5MiBiaW5kIDgxOTIpClsgICAgMC4yNDAwNDJdIFRDUDogcmVubyByZWdp
c3RlcmVkClsgICAgMC4yNDAwNTFdIFVEUCBoYXNoIHRhYmxlIGVudHJpZXM6IDUxMiAob3JkZXI6
IDIsIDI0NTc2IGJ5dGVzKQpbICAgIDAuMjQwMDc0XSBVRFAtTGl0ZSBoYXNoIHRhYmxlIGVudHJp
ZXM6IDUxMiAob3JkZXI6IDIsIDI0NTc2IGJ5dGVzKQpbICAgIDAuMjQwMjAzXSBORVQ6IFJlZ2lz
dGVyZWQgcHJvdG9jb2wgZmFtaWx5IDEKWyAgICAwLjI0MTIzMF0gZnV0ZXggaGFzaCB0YWJsZSBl
bnRyaWVzOiAxMDI0IChvcmRlcjogNCwgNjU1MzYgYnl0ZXMpClsgICAgMC4yNTE0ODRdIFJPTUZT
IE1URCAoQykgMjAwNyBSZWQgSGF0LCBJbmMuClsgICAgMC4yNTE2NjRdIG1zZ21uaSBoYXMgYmVl
biBzZXQgdG8gMTQ3NApbICAgIDAuMjUyMDMwXSBib3VuY2U6IHBvb2wgc2l6ZTogNjQgcGFnZXMK
WyAgICAwLjI1MjAzOV0gaW8gc2NoZWR1bGVyIG5vb3AgcmVnaXN0ZXJlZApbICAgIDAuMjUyMDQ4
XSBpbyBzY2hlZHVsZXIgZGVhZGxpbmUgcmVnaXN0ZXJlZApbICAgIDAuMjUyMzk0XSBpbyBzY2hl
ZHVsZXIgY2ZxIHJlZ2lzdGVyZWQgKGRlZmF1bHQpClsgICAgMC4yNTQ1MjddIGRtYS1wbDMzMCAz
ODgwMDAwLmFkbWE6IExvYWRlZCBkcml2ZXIgZm9yIFBMMzMwIERNQUMtMjM2NDIwOApbICAgIDAu
MjU0NTM2XSBkbWEtcGwzMzAgMzg4MDAwMC5hZG1hOiAJREJVRkYtNHg4Ynl0ZXMgTnVtX0NoYW5z
LTYgTnVtX1BlcmktMTYgTnVtX0V2ZW50cy02ClsgICAgMC4yNTcyMzBdIGRtYS1wbDMzMCAxMjFh
MDAwMC5wZG1hOiBMb2FkZWQgZHJpdmVyIGZvciBQTDMzMCBETUFDLTIzNjQyMDgKWyAgICAwLjI1
NzIzOV0gZG1hLXBsMzMwIDEyMWEwMDAwLnBkbWE6IAlEQlVGRi0zMng0Ynl0ZXMgTnVtX0NoYW5z
LTggTnVtX1BlcmktMzIgTnVtX0V2ZW50cy0zMgpbICAgIDAuMjU5NzYxXSBkbWEtcGwzMzAgMTIx
YjAwMDAucGRtYTogTG9hZGVkIGRyaXZlciBmb3IgUEwzMzAgRE1BQy0yMzY0MjA4ClsgICAgMC4y
NTk3NzBdIGRtYS1wbDMzMCAxMjFiMDAwMC5wZG1hOiAJREJVRkYtMzJ4NGJ5dGVzIE51bV9DaGFu
cy04IE51bV9QZXJpLTMyIE51bV9FdmVudHMtMzIKWyAgICAwLjI2MDU3Nl0gZG1hLXBsMzMwIDEw
ODAwMDAwLm1kbWE6IExvYWRlZCBkcml2ZXIgZm9yIFBMMzMwIERNQUMtMjM2NDIwOApbICAgIDAu
MjYwNTg1XSBkbWEtcGwzMzAgMTA4MDAwMDAubWRtYTogCURCVUZGLTY0eDhieXRlcyBOdW1fQ2hh
bnMtOCBOdW1fUGVyaS0xIE51bV9FdmVudHMtMzIKWyAgICAwLjMyMzU1MV0gU2VyaWFsOiA4MjUw
LzE2NTUwIGRyaXZlciwgNCBwb3J0cywgSVJRIHNoYXJpbmcgZGlzYWJsZWQKWyAgICAwLjMyNDg2
N10gMTJjMDAwMDAuc2VyaWFsOiB0dHlTQUMwIGF0IE1NSU8gMHgxMmMwMDAwMCAoaXJxID0gODMs
IGJhc2VfYmF1ZCA9IDApIGlzIGEgUzNDNjQwMC8xMApbICAgIDAuMzI1MTgyXSAxMmMxMDAwMC5z
ZXJpYWw6IHR0eVNBQzEgYXQgTU1JTyAweDEyYzEwMDAwIChpcnEgPSA4NCwgYmFzZV9iYXVkID0g
MCkgaXMgYSBTM0M2NDAwLzEwClsgICAgMC4zMjU0ODldIDEyYzIwMDAwLnNlcmlhbDogdHR5U0FD
MiBhdCBNTUlPIDB4MTJjMjAwMDAgKGlycSA9IDg1LCBiYXNlX2JhdWQgPSAwKSBpcyBhIFMzQzY0
MDAvMTAKWyAgICAwLjMyNTgwMl0gMTJjMzAwMDAuc2VyaWFsOiB0dHlTQUMzIGF0IE1NSU8gMHgx
MmMzMDAwMCAoaXJxID0gODYsIGJhc2VfYmF1ZCA9IDApIGlzIGEgUzNDNjQwMC8xMApbICAgIDEu
MjE4NDI4XSBjb25zb2xlIFt0dHlTQUMzXSBlbmFibGVkClsgICAgMS4yMjkyNzJdIGJyZDogbW9k
dWxlIGxvYWRlZApbICAgIDEuMjMzOTU4XSBsb29wOiBtb2R1bGUgbG9hZGVkClsgICAgMS4yMzY1
NThdIG9mX2dldF9uYW1lZF9ncGlvZF9mbGFncyBleGl0ZWQgd2l0aCBzdGF0dXMgMApbICAgIDEu
MjQxNTA1XSBjcm9zLWVjLXNwaSBzcGkyLjA6IENocm9tZSBFQyAoU1BJKQpbICAgIDEuMjQ1ODkz
XSB1c2Jjb3JlOiByZWdpc3RlcmVkIG5ldyBpbnRlcmZhY2UgZHJpdmVyIGFzaXgKWyAgICAxLjI1
MDk2M10gdXNiY29yZTogcmVnaXN0ZXJlZCBuZXcgaW50ZXJmYWNlIGRyaXZlciBheDg4MTc5XzE3
OGEKWyAgICAxLjI1NzAyMl0gdXNiY29yZTogcmVnaXN0ZXJlZCBuZXcgaW50ZXJmYWNlIGRyaXZl
ciBjZGNfZXRoZXIKWyAgICAxLjI2Mjg1OF0gdXNiY29yZTogcmVnaXN0ZXJlZCBuZXcgaW50ZXJm
YWNlIGRyaXZlciBzbXNjNzV4eApbICAgIDEuMjY4NTc3XSB1c2Jjb3JlOiByZWdpc3RlcmVkIG5l
dyBpbnRlcmZhY2UgZHJpdmVyIHNtc2M5NXh4ClsgICAgMS4yNzQyOTJdIHVzYmNvcmU6IHJlZ2lz
dGVyZWQgbmV3IGludGVyZmFjZSBkcml2ZXIgbmV0MTA4MApbICAgIDEuMjc5OTI5XSB1c2Jjb3Jl
OiByZWdpc3RlcmVkIG5ldyBpbnRlcmZhY2UgZHJpdmVyIGNkY19zdWJzZXQKWyAgICAxLjI4NTgy
OF0gdXNiY29yZTogcmVnaXN0ZXJlZCBuZXcgaW50ZXJmYWNlIGRyaXZlciB6YXVydXMKWyAgICAx
LjI5MTQwMl0gdXNiY29yZTogcmVnaXN0ZXJlZCBuZXcgaW50ZXJmYWNlIGRyaXZlciBjZGNfbmNt
ClsgICAgMS4yOTc0MjFdIHVzYkAxMjAwMDAwMCBzdXBwbHkgdmRkMzMgbm90IGZvdW5kLCB1c2lu
ZyBkdW1teSByZWd1bGF0b3IKWyAgICAxLjMwMzUxN10gdXNiQDEyMDAwMDAwIHN1cHBseSB2ZGQx
MCBub3QgZm91bmQsIHVzaW5nIGR1bW15IHJlZ3VsYXRvcgpbICAgIDEuMzEwMjI4XSBwbGF0Zm9y
bSAxMjAwMDAwMC5kd2MzOiBEcml2ZXIgZHdjMyByZXF1ZXN0cyBwcm9iZSBkZWZlcnJhbApbICAg
IDEuMzE2NzkxXSB1c2JAMTI0MDAwMDAgc3VwcGx5IHZkZDMzIG5vdCBmb3VuZCwgdXNpbmcgZHVt
bXkgcmVndWxhdG9yClsgICAgMS4zMjMxMjldIHVzYkAxMjQwMDAwMCBzdXBwbHkgdmRkMTAgbm90
IGZvdW5kLCB1c2luZyBkdW1teSByZWd1bGF0b3IKWyAgICAxLjMyOTgzNl0gcGxhdGZvcm0gMTI0
MDAwMDAuZHdjMzogRHJpdmVyIGR3YzMgcmVxdWVzdHMgcHJvYmUgZGVmZXJyYWwKWyAgICAxLjMz
NjIzOV0gZWhjaV9oY2Q6IFVTQiAyLjAgJ0VuaGFuY2VkJyBIb3N0IENvbnRyb2xsZXIgKEVIQ0kp
IERyaXZlcgpbICAgIDEuMzQyNjkyXSBlaGNpLWV4eW5vczogRUhDSSBFWFlOT1MgZHJpdmVyClsg
ICAgMS4zNDY5NjddIG9mX2dldF9uYW1lZF9ncGlvZF9mbGFnczogY2FuJ3QgcGFyc2UgZ3Bpb3Mg
cHJvcGVydHkgb2Ygbm9kZSAnL3VzYkAxMjExMDAwMFswXScKWyAgICAxLjM1NTE5N10gZXh5bm9z
LWVoY2kgMTIxMTAwMDAudXNiOiBubyB1c2IyIHBoeSBjb25maWd1cmVkClsgICAgMS4zNjA4MjVd
IHBsYXRmb3JtIDEyMTEwMDAwLnVzYjogRHJpdmVyIGV4eW5vcy1laGNpIHJlcXVlc3RzIHByb2Jl
IGRlZmVycmFsClsgICAgMS4zNjgwNjddIHVzYmNvcmU6IHJlZ2lzdGVyZWQgbmV3IGludGVyZmFj
ZSBkcml2ZXIgdXNiLXN0b3JhZ2UKWyAgICAxLjM3NDQ5Ml0gbW91c2VkZXY6IFBTLzIgbW91c2Ug
ZGV2aWNlIGNvbW1vbiBmb3IgYWxsIG1pY2UKWyAgICAxLjM3OTg5NF0gaW5wdXQ6IGNyb3MtZWMt
c3BpIGFzIC9kZXZpY2VzLzEyZDQwMDAwLnNwaS9zcGlfbWFzdGVyL3NwaTIvc3BpMi4wL2Nyb3Mt
ZWMta2V5Yi4xL2lucHV0L2lucHV0MApbICAgIDEuMzg5NjI0XSBzM2MtcnRjIDEwMWUwMDAwLnJ0
YzogcnRjIGRpc2FibGVkLCByZS1lbmFibGluZwpbICAgIDEuMzk0ODkxXSBzM2MtcnRjIDEwMWUw
MDAwLnJ0YzogcnRjIGNvcmU6IHJlZ2lzdGVyZWQgczNjIGFzIHJ0YzAKWyAgICAxLjQwMDgyMV0g
czNjLXJ0YyAxMDFlMDAwMC5ydGM6IHdhcm5pbmc6IGludmFsaWQgUlRDIHZhbHVlIHNvIGluaXRp
YWxpemluZyBpdApbICAgIDEuNDA4OTg2XSBvZl9nZXRfbmFtZWRfZ3Bpb2RfZmxhZ3MgZXhpdGVk
IHdpdGggc3RhdHVzIDAKWyAgICAxLjQxMzQ4MF0gb2ZfZ2V0X25hbWVkX2dwaW9kX2ZsYWdzIGV4
aXRlZCB3aXRoIHN0YXR1cyAwClsgICAgMS40MTg4NjFdIG9mX2dldF9uYW1lZF9ncGlvZF9mbGFn
cyBleGl0ZWQgd2l0aCBzdGF0dXMgMApbICAgIDEuNDI0MjM0XSBvZl9nZXRfbmFtZWRfZ3Bpb2Rf
ZmxhZ3MgZXhpdGVkIHdpdGggc3RhdHVzIDAKWyAgICAxLjQyOTYxN10gb2ZfZ2V0X25hbWVkX2dw
aW9kX2ZsYWdzIGV4aXRlZCB3aXRoIHN0YXR1cyAwClsgICAgMS40MzQ5OTNdIG9mX2dldF9uYW1l
ZF9ncGlvZF9mbGFncyBleGl0ZWQgd2l0aCBzdGF0dXMgMApbICAgIDEuNDQwMzc3XSBvZl9nZXRf
bmFtZWRfZ3Bpb2RfZmxhZ3MgZXhpdGVkIHdpdGggc3RhdHVzIDAKWyAgICAxLjQ0NTc1MV0gb2Zf
Z2V0X25hbWVkX2dwaW9kX2ZsYWdzIGV4aXRlZCB3aXRoIHN0YXR1cyAwClsgICAgMS40NTEzNDNd
IG1heDc3eHh4IDQtMDAwOTogZGV2aWNlIGZvdW5kClsgICAgMS40NTU2MjRdIG1heDc3eHh4IDQt
MDAwOTogbm8gcmVndWxhdG9yLW9wLW1vZGUgcHJvcGVydHkgcHJvcGVydHkgYXQgTERPMgpbICAg
IDEuNDYyMTY1XSBtYXg3N3h4eCA0LTAwMDk6IG5vIHJlZ3VsYXRvci1vcC1tb2RlIHByb3BlcnR5
IHByb3BlcnR5IGF0IExETzQKWyAgICAxLjQ2OTE2MV0gbWF4Nzd4eHggNC0wMDA5OiBubyByZWd1
bGF0b3Itb3AtbW9kZSBwcm9wZXJ0eSBwcm9wZXJ0eSBhdCBMRE83ClsgICAgMS40NzY0NzRdIG1h
eDc3eHh4IDQtMDAwOTogbm8gcmVndWxhdG9yLW9wLW1vZGUgcHJvcGVydHkgcHJvcGVydHkgYXQg
TERPMTgKWyAgICAxLjQ4MzAyM10gbWF4Nzd4eHggNC0wMDA5OiBubyByZWd1bGF0b3Itb3AtbW9k
ZSBwcm9wZXJ0eSBwcm9wZXJ0eSBhdCBMRE8xOQpbICAgIDEuNDkwMDk0XSBtYXg3N3h4eCA0LTAw
MDk6IG5vIHJlZ3VsYXRvci1vcC1tb2RlIHByb3BlcnR5IHByb3BlcnR5IGF0IExETzIxClsgICAg
MS40OTcwNzNdIG1heDc3eHh4IDQtMDAwOTogbm8gcmVndWxhdG9yLW9wLW1vZGUgcHJvcGVydHkg
cHJvcGVydHkgYXQgTERPMjMKWyAgICAxLjUwNDA5M10gbWF4Nzd4eHggNC0wMDA5OiBubyByZWd1
bGF0b3Itb3AtbW9kZSBwcm9wZXJ0eSBwcm9wZXJ0eSBhdCBMRE8yNApbICAgIDEuNTExMTMwXSBt
YXg3N3h4eCA0LTAwMDk6IG5vIHJlZ3VsYXRvci1vcC1tb2RlIHByb3BlcnR5IHByb3BlcnR5IGF0
IExETzI1ClsgICAgMS41MTgxNDldIG1heDc3eHh4IDQtMDAwOTogbm8gcmVndWxhdG9yLW9wLW1v
ZGUgcHJvcGVydHkgcHJvcGVydHkgYXQgTERPMjYKWyAgICAxLjUyNTE5NF0gbWF4Nzd4eHggNC0w
MDA5OiBubyByZWd1bGF0b3Itb3AtbW9kZSBwcm9wZXJ0eSBwcm9wZXJ0eSBhdCBMRE8yNwpbICAg
IDEuNTMyMjAxXSBtYXg3N3h4eCA0LTAwMDk6IG5vIHJlZ3VsYXRvci1vcC1tb2RlIHByb3BlcnR5
IHByb3BlcnR5IGF0IExETzI4ClsgICAgMS41MzkyMjhdIG1heDc3eHh4IDQtMDAwOTogbm8gcmVn
dWxhdG9yLW9wLW1vZGUgcHJvcGVydHkgcHJvcGVydHkgYXQgTERPMjkKWyAgICAxLjU0NjMwOV0g
bWF4Nzd4eHggNC0wMDA5OiBubyByZWd1bGF0b3Itb3AtbW9kZSBwcm9wZXJ0eSBwcm9wZXJ0eSBh
dCBMRE8zMgpbICAgIDEuNTUzMjgxXSBtYXg3N3h4eCA0LTAwMDk6IG5vIHJlZ3VsYXRvci1vcC1t
b2RlIHByb3BlcnR5IHByb3BlcnR5IGF0IExETzMzClsgICAgMS41NjAzMDldIG1heDc3eHh4IDQt
MDAwOTogbm8gcmVndWxhdG9yLW9wLW1vZGUgcHJvcGVydHkgcHJvcGVydHkgYXQgTERPMzQKWyAg
ICAxLjU2NzMzNV0gbWF4Nzd4eHggNC0wMDA5OiBubyByZWd1bGF0b3Itb3AtbW9kZSBwcm9wZXJ0
eSBwcm9wZXJ0eSBhdCBMRE8zNQpbICAgIDEuNTc0OTI0XSBtYXg3N3h4eCA0LTAwMDk6IG5vIHJl
Z3VsYXRvci1vcC1tb2RlIHByb3BlcnR5IHByb3BlcnR5IGF0IEVOMzJLSFpfQVAKWyAgICAxLjU4
MTgyMl0gbWF4Nzd4eHggNC0wMDA5OiBubyByZWd1bGF0b3Itb3AtbW9kZSBwcm9wZXJ0eSBwcm9w
ZXJ0eSBhdCBFTjMyS0haX0NQClsgICAgMS41ODk1NDNdIHZkZF8xdjA6IDEwMDAgbVYgClsgICAg
MS41OTI0NzddIHZkZF8xdjJfMjogMTIwMCBtViAKWyAgICAxLjU5NTY4Nl0gdmRkXzF2OF8zOiAx
ODAwIG1WIApbICAgIDEuNTk4NjkzXSB2ZGRfc2Q6IDE4MDAgPC0tPiAyODAwIG1WIGF0IDI4MDAg
bVYgClsgICAgMS42MDM0ODFdIHZkZF8xdjhfNTogMTgwMCBtViAKWyAgICAxLjYwNjYwNl0gdmRk
XzF2OF82OiAxODAwIG1WIApbICAgIDEuNjA5NjMxXSB2ZGRfMXY4Xzc6IDE4MDAgbVYgClsgICAg
MS42MTI4NjNdIHZkZF9sZG84OiAxMDAwIG1WIApbICAgIDEuNjE1ODk1XSB2ZGRfbGRvOTogMTgw
MCBtViAKWyAgICAxLjYxODkwOV0gdmRkX2xkbzEwOiAxODAwIG1WIApbICAgIDEuNjIyMDU0XSB2
ZGRfbGRvMTE6IDE4MDAgbVYgClsgICAgMS42MjUxODFdIHZkZF9sZG8xMjogMzAwMCBtViAKWyAg
ICAxLjYyODI3Nl0gdmRkX2xkbzEzOiAxODAwIG1WIApbICAgIDEuNjMxNDI2XSB2ZGRfbGRvMTQ6
IDE4MDAgbVYgClsgICAgMS42MzQ1MjRdIHZkZF9sZG8xNTogMTAwMCBtViAKWyAgICAxLjYzNzY3
NF0gdmRkX2czZHM6IDkwMCA8LS0+IDE0MDAgbVYgYXQgMTAwMCBtViAKWyAgICAxLjY0MjM1NF0g
bGRvXzE4OiAxODAwIG1WIApbICAgIDEuNjQ1MjEyXSBsZG9fMTk6IDE4MDAgbVYgClsgICAgMS42
NDgwNjddIGxkb18yMDogMTgwMCBtViAKWyAgICAxLjY1MDkzNl0gbGRvXzIxOiAyODAwIG1WIApb
ICAgIDEuNjUzNzg2XSBsZDBfMjM6IDMzMDAgbVYgClsgICAgMS42NTY2NzNdIGxkb18yNDogMjgw
MCBtViAKWyAgICAxLjY1OTUxMF0gbGRvXzI1OiAzMzAwIG1WIApbICAgIDEuNjYyNDc3XSBsZG9f
MjY6IDEyMDAgbVYgClsgICAgMS42NjUyNTldIGxkb18yNzogMTIwMCBtViAKWyAgICAxLjY2ODEw
NF0gbGRvXzI4OiAxODAwIG1WIApbICAgIDEuNjcwOTg0XSBsZG9fMjk6IDE4MDAgbVYgClsgICAg
MS42NzM5MTBdIHZkZF9taWZzOiA5MDAgPC0tPiAxMzAwIG1WIGF0IDEwMDAgbVYgClsgICAgMS42
Nzg2MTVdIGxkb18zMjogMzAwMCBtViAKWyAgICAxLjY4MTQ3NV0gbGRvXzMzOiAyODAwIG1WIApb
ICAgIDEuNjg0MzIxXSBsZG9fMzQ6IDMwMDAgbVYgClsgICAgMS42ODcyMDldIGxkb18zNTogMTIw
MCBtViAKWyAgICAxLjY5MDQ4NV0gdmRkX21pZjogODAwIDwtLT4gMTMwMCBtViBhdCAxMDAwIG1W
IApbICAgIDEuNjk1MTU3XSB2ZGRfYXJtOiA4MDAgPC0tPiAxNTAwIG1WIGF0IDEyNjIgbVYgClsg
ICAgMS42OTk4MjZdIHZkZF9pbnQ6IDgwMCA8LS0+IDE0MDAgbVYgYXQgMTAwMCBtViAKWyAgICAx
LjcwNDQ4N10gdmRkX2czZDogNzAwIDwtLT4gMTQwMCBtViBhdCAxMDAwIG1WIApbICAgIDEuNzA5
MDEzXSB2ZGRfMXYyOiAxMjAwIG1WIApbICAgIDEuNzEyMTUwXSB2ZGRfa2ZjOiA4MDAgPC0tPiAx
NTAwIG1WIGF0IDEwMDAgbVYgClsgICAgMS43MTY1NTZdIHZkZF8xdjM1OiAxMzUwIG1WIApbICAg
IDEuNzE5NjczXSB2ZGRfZW1tYzogMjg1MCBtViAKWyAgICAxLjcyMjYzNF0gdmRkXzJ2OiAyMDAw
IG1WIApbICAgIDEuNzI1NTEwXSB2ZGRfMXY4OiAxODAwIG1WIApbICAgIDEuNzI4MjgzXSBlbjMy
a2h6X2FwOiBubyBwYXJhbWV0ZXJzClsgICAgMS43MzE3OTJdIGVuMzJraHpfY3A6IG5vIHBhcmFt
ZXRlcnMKWyAgICAxLjczNzkyM10gdHBtX2kyY19pbmZpbmVvbiA5LTAwMjA6IDEuMiBUUE0gKGRl
dmljZS1pZCAweDFBKQpbICAgIDEuNzY0MTc1XSB0cG1faTJjX2luZmluZW9uIDktMDAyMDogSXNz
dWluZyBUUE1fU1RBUlRVUApbICAgIDEuOTMwODUwXSB0cHM2NTA5MCAwLTAwNDg6IE5vIGNhY2hl
IGRlZmF1bHRzLCByZWFkaW5nIGJhY2sgZnJvbSBIVwpbICAgIDEuOTQyMDcwXSBvZl9nZXRfbmFt
ZWRfZ3Bpb2RfZmxhZ3M6IGNhbid0IHBhcnNlIGdwaW9zIHByb3BlcnR5IG9mIG5vZGUgJy9zcGlA
MTJkNDAwMDAvY3Jvcy1lY0AwL2kyYy10dW5uZWwvcG93ZXItcmVndWxhdG9yQDQ4WzBdJwpbICAg
IDEuOTUyNDE5XSBvZl9nZXRfbmFtZWRfZ3Bpb2RfZmxhZ3M6IGNhbid0IHBhcnNlIGdwaW9zIHBy
b3BlcnR5IG9mIG5vZGUgJy9zcGlAMTJkNDAwMDAvY3Jvcy1lY0AwL2kyYy10dW5uZWwvcG93ZXIt
cmVndWxhdG9yQDQ4WzBdJwpbICAgIDEuOTY0MjIxXSBvZl9nZXRfbmFtZWRfZ3Bpb2RfZmxhZ3M6
IGNhbid0IHBhcnNlIGdwaW9zIHByb3BlcnR5IG9mIG5vZGUgJy9zcGlAMTJkNDAwMDAvY3Jvcy1l
Y0AwL2kyYy10dW5uZWwvcG93ZXItcmVndWxhdG9yQDQ4WzBdJwpbICAgIDEuOTc2MTA4XSBUUFM2
NTA5MF9SQUlMU0RDREMxOiBubyBwYXJhbWV0ZXJzClsgICAgMS45ODA0NzFdIFRQUzY1MDkwX1JB
SUxTRENEQzE6IHN1cHBsaWVkIGJ5IHZiYXQtc3VwcGx5ClsgICAgMS45ODkyNzhdIFRQUzY1MDkw
X1JBSUxTRENEQzI6IG5vIHBhcmFtZXRlcnMKWyAgICAxLjk5MjI3Nl0gVFBTNjUwOTBfUkFJTFNE
Q0RDMjogc3VwcGxpZWQgYnkgdmJhdC1zdXBwbHkKWyAgICAyLjAwMTE1M10gVFBTNjUwOTBfUkFJ
TFNEQ0RDMzogbm8gcGFyYW1ldGVycwpbICAgIDIuMDA0MTM0XSBUUFM2NTA5MF9SQUlMU0RDREMz
OiBzdXBwbGllZCBieSB2YmF0LXN1cHBseQpbICAgIDIuMDEyOTQ0XSB2Y2RfbGVkOiBubyBwYXJh
bWV0ZXJzClsgICAgMi4wMTQ5MDRdIHZjZF9sZWQ6IHN1cHBsaWVkIGJ5IHZiYXQtc3VwcGx5Clsg
ICAgMi4wMzMxNjBdIHZpZGVvX21pZDogbm8gcGFyYW1ldGVycwpbICAgIDIuMDM1Mjk4XSB2aWRl
b19taWQ6IHN1cHBsaWVkIGJ5IHZiYXQtc3VwcGx5ClsgICAgMi4wNTM3MjddIHd3YW5fcjogbm8g
cGFyYW1ldGVycwpbICAgIDIuMDU1NTk3XSB3d2FuX3I6IHN1cHBsaWVkIGJ5IHZiYXQtc3VwcGx5
ClsgICAgMi4wNjMzMzJdIHNkY2FyZDogbm8gcGFyYW1ldGVycwpbICAgIDIuMDY1MjExXSBzZGNh
cmQ6IHN1cHBsaWVkIGJ5IHZiYXQtc3VwcGx5ClsgICAgMi4wNzI4NTNdIGNhbW91dDogbm8gcGFy
YW1ldGVycwpbICAgIDIuMDc0NzA5XSBjYW1vdXQ6IHN1cHBsaWVkIGJ5IHZiYXQtc3VwcGx5Clsg
ICAgMi4wODIzNzhdIGxjZF92ZGQ6IG5vIHBhcmFtZXRlcnMKWyAgICAyLjA4NDMyMV0gbGNkX3Zk
ZDogc3VwcGxpZWQgYnkgdmJhdC1zdXBwbHkKWyAgICAyLjEwMjU5Nl0gdmlkZW9fbWlkXzFhOiBu
byBwYXJhbWV0ZXJzClsgICAgMi4xMDQ5OTNdIHZpZGVvX21pZF8xYTogc3VwcGxpZWQgYnkgdmJh
dC1zdXBwbHkKWyAgICAyLjExMzE0NV0gVFBTNjUwOTBfUkFJTFNMRE8xOiBubyBwYXJhbWV0ZXJz
ClsgICAgMi4xMTYwNjFdIFRQUzY1MDkwX1JBSUxTTERPMTogc3VwcGxpZWQgYnkgdmJhdC1zdXBw
bHkKWyAgICAyLjEyMTM4NF0gVFBTNjUwOTBfUkFJTFNMRE8yOiBubyBwYXJhbWV0ZXJzClsgICAg
Mi4xMjU1OTldIFRQUzY1MDkwX1JBSUxTTERPMjogc3VwcGxpZWQgYnkgdmJhdC1zdXBwbHkKWyAg
ICAyLjEzMTcwN10gdHBzNjUwOTAtY2hhcmdlciB0cHM2NTA5MC1jaGFyZ2VyOiBVbmFibGUgdG8g
Z2V0IGNoYXJnZXIgaXJxID0gLTIyClsgICAgMi4xNDk5OTldIHRwczY1MDkwLWNoYXJnZXI6IHBy
b2JlIG9mIHRwczY1MDkwLWNoYXJnZXIgZmFpbGVkIHdpdGggZXJyb3IgLTIyClsgICAgMi4xNTYy
MzRdIGRldmljZS1tYXBwZXI6IGlvY3RsOiA0LjI3LjAtaW9jdGwgKDIwMTMtMTAtMzApIGluaXRp
YWxpc2VkOiBkbS1kZXZlbEByZWRoYXQuY29tClsgICAgMi4xNjQxMjFdIHNkaGNpOiBTZWN1cmUg
RGlnaXRhbCBIb3N0IENvbnRyb2xsZXIgSW50ZXJmYWNlIGRyaXZlcgpbICAgIDIuMTcwMjQwXSBz
ZGhjaTogQ29weXJpZ2h0KGMpIFBpZXJyZSBPc3NtYW4KWyAgICAyLjE3NDcxMl0gU3lub3BzeXMg
RGVzaWdud2FyZSBNdWx0aW1lZGlhIENhcmQgSW50ZXJmYWNlIERyaXZlcgpbICAgIDIuMTgwOTY3
XSBkd21tY19leHlub3MgMTIyMDAwMDAubW1jOiBVc2luZyBpbnRlcm5hbCBETUEgY29udHJvbGxl
ci4KWyAgICAyLjE4Njk4OV0gZHdtbWNfZXh5bm9zIDEyMjAwMDAwLm1tYzogVmVyc2lvbiBJRCBp
cyAyNTBhClsgICAgMi4xOTI0ODBdIGR3bW1jX2V4eW5vcyAxMjIwMDAwMC5tbWM6IERXIE1NQyBj
b250cm9sbGVyIGF0IGlycSAxMDcsIDY0IGJpdCBob3N0IGRhdGEgd2lkdGgsIDY0IGRlZXAgZmlm
bwpbICAgIDIuMjAxOTIyXSBkd21tY19leHlub3MgMTIyMDAwMDAubW1jOiBObyB2bW1jIHJlZ3Vs
YXRvciBmb3VuZApbICAgIDIuMjA3NzE4XSBkd21tY19leHlub3MgMTIyMDAwMDAubW1jOiBObyB2
cW1tYyByZWd1bGF0b3IgZm91bmQKWyAgICAyLjIxMzYxNl0gb2ZfZ2V0X25hbWVkX2dwaW9kX2Zs
YWdzOiBjYW4ndCBwYXJzZSBncGlvcyBwcm9wZXJ0eSBvZiBub2RlICcvbW1jQDEyMjAwMDAwWzBd
JwpbICAgIDIuMjQ5ODYzXSBkd21tY19leHlub3MgMTIyMDAwMDAubW1jOiAxIHNsb3RzIGluaXRp
YWxpemVkClsgICAgMi4yNTQwNDBdIGR3bW1jX2V4eW5vcyAxMjIyMDAwMC5tbWM6IFVzaW5nIGlu
dGVybmFsIERNQSBjb250cm9sbGVyLgpbICAgIDIuMjYwMzExXSBkd21tY19leHlub3MgMTIyMjAw
MDAubW1jOiBWZXJzaW9uIElEIGlzIDI1MGEKWyAgICAyLjI2NTgwM10gZHdtbWNfZXh5bm9zIDEy
MjIwMDAwLm1tYzogRFcgTU1DIGNvbnRyb2xsZXIgYXQgaXJxIDEwOSwgNjQgYml0IGhvc3QgZGF0
YSB3aWR0aCwgNjQgZGVlcCBmaWZvClsgICAgMi4yNzUzMTRdIGR3bW1jX2V4eW5vcyAxMjIyMDAw
MC5tbWM6IEZhaWxlZCBnZXR0aW5nIE9DUiBtYXNrOiAtMjIKWyAgICAyLjI4MTQ3Ml0gb2ZfZ2V0
X25hbWVkX2dwaW9kX2ZsYWdzOiBjYW4ndCBwYXJzZSBncGlvcyBwcm9wZXJ0eSBvZiBub2RlICcv
bW1jQDEyMjIwMDAwWzBdJwpbICAgIDIuMjg5Nzk3XSBvZl9nZXRfbmFtZWRfZ3Bpb2RfZmxhZ3M6
IGNhbid0IHBhcnNlIGdwaW9zIHByb3BlcnR5IG9mIG5vZGUgJy9tbWNAMTIyMjAwMDBbMF0nClsg
ICAgMi4yOTI3MjRdIG1tYzA6IEJLT1BTX0VOIGJpdCBpcyBub3Qgc2V0ClsgICAgMi4yOTQ4MThd
IG1tY19ob3N0IG1tYzA6IEJ1cyBzcGVlZCAoc2xvdCAwKSA9IDUwMDAwMDAwSHogKHNsb3QgcmVx
IDUyMDAwMDAwSHosIGFjdHVhbCA1MDAwMDAwMEhaIGRpdiA9IDApClsgICAgMi4yOTUyMDFdIG1t
Y19ob3N0IG1tYzA6IEJ1cyBzcGVlZCAoc2xvdCAwKSA9IDEwMDAwMDAwMEh6IChzbG90IHJlcSA1
MjAwMDAwMEh6LCBhY3R1YWwgNTAwMDAwMDBIWiBkaXYgPSAxKQpbICAgIDIuMjk1NDQyXSBtbWMw
OiBuZXcgRERSIE1NQyBjYXJkIGF0IGFkZHJlc3MgMDAwMQpbICAgIDIuMjk2NDU2XSBtbWNibGsw
OiBtbWMwOjAwMDEgTUFHMkdDIDE0LjUgR2lCIApbICAgIDIuMjk2NzI5XSBtbWNibGswYm9vdDA6
IG1tYzA6MDAwMSBNQUcyR0MgcGFydGl0aW9uIDEgNC4wMCBNaUIKWyAgICAyLjI5Njk2OF0gbW1j
YmxrMGJvb3QxOiBtbWMwOjAwMDEgTUFHMkdDIHBhcnRpdGlvbiAyIDQuMDAgTWlCClsgICAgMi4y
OTcyMDFdIG1tY2JsazBycG1iOiBtbWMwOjAwMDEgTUFHMkdDIHBhcnRpdGlvbiAzIDQuMDAgTWlC
ClsgICAgMi4zMDE3NzVdICBtbWNibGswOiBwMSBwMiBwMyBwNCBwNSBwNiBwNwpbICAgIDIuMzA5
MzI0XSAgbW1jYmxrMGJvb3QxOiB1bmtub3duIHBhcnRpdGlvbiB0YWJsZQpbICAgIDIuMzExNjQ5
XSAgbW1jYmxrMGJvb3QwOiB1bmtub3duIHBhcnRpdGlvbiB0YWJsZQpbICAgIDIuMzk0ODQ3XSBk
d21tY19leHlub3MgMTIyMjAwMDAubW1jOiAxIHNsb3RzIGluaXRpYWxpemVkClsgICAgMi4zOTk1
NTJdIHVzYmNvcmU6IHJlZ2lzdGVyZWQgbmV3IGludGVyZmFjZSBkcml2ZXIgdXNiaGlkClsgICAg
Mi40MDQ0MzldIHVzYmhpZDogVVNCIEhJRCBjb3JlIGRyaXZlcgpbICAgIDIuNDA4MzU0XSBUQ1A6
IGN1YmljIHJlZ2lzdGVyZWQKWyAgICAyLjQxMjU2MV0gTkVUOiBSZWdpc3RlcmVkIHByb3RvY29s
IGZhbWlseSAxNwpbICAgIDIuNDE4MDAwXSBORVQ6IFJlZ2lzdGVyZWQgcHJvdG9jb2wgZmFtaWx5
IDE1ClsgICAgMi40MjExNThdIFJlZ2lzdGVyaW5nIFNXUC9TV1BCIGVtdWxhdGlvbiBoYW5kbGVy
ClsgICAgMi40MjYzNTRdIHBsYXRmb3JtIDEyMDAwMDAwLmR3YzM6IERyaXZlciBkd2MzIHJlcXVl
c3RzIHByb2JlIGRlZmVycmFsClsgICAgMi40MzI0NDVdIHBsYXRmb3JtIDEyNDAwMDAwLmR3YzM6
IERyaXZlciBkd2MzIHJlcXVlc3RzIHByb2JlIGRlZmVycmFsClsgICAgMi40MzkwMzBdIG9mX2dl
dF9uYW1lZF9ncGlvZF9mbGFnczogY2FuJ3QgcGFyc2UgZ3Bpb3MgcHJvcGVydHkgb2Ygbm9kZSAn
L3VzYkAxMjExMDAwMFswXScKWyAgICAyLjQ0NzM1NF0gZXh5bm9zLWVoY2kgMTIxMTAwMDAudXNi
OiBubyB1c2IyIHBoeSBjb25maWd1cmVkClsgICAgMi40NTMwOTJdIHBsYXRmb3JtIDEyMTEwMDAw
LnVzYjogRHJpdmVyIGV4eW5vcy1laGNpIHJlcXVlc3RzIHByb2JlIGRlZmVycmFsClsgICAgMi40
NjAzNzVdIG9mX2dldF9uYW1lZF9ncGlvZF9mbGFncyBleGl0ZWQgd2l0aCBzdGF0dXMgMApbICAg
IDIuNDY1NDY4XSBncGlvLTE4IChQb3dlcik6IGdwaW9kX3NldF9kZWJvdW5jZTogbWlzc2luZyBz
ZXQoKSBvciBzZXRfZGVib3VuY2UoKSBvcGVyYXRpb25zClsgICAgMi40NzUyNzldIGlucHV0OiBn
cGlvLWtleXMgYXMgL2RldmljZXMvZ3Bpby1rZXlzL2lucHV0L2lucHV0MQpbICAgIDIuNDgwNjQ3
XSBzM2MtcnRjIDEwMWUwMDAwLnJ0Yzogc2V0dGluZyBzeXN0ZW0gY2xvY2sgdG8gMjAwMC0wMS0w
MSAwMDowMDowMSBVVEMgKDk0NjY4NDgwMSkKWyAgICAyLjQ4MDY1MF0gcGxhdGZvcm0gMTIwMDAw
MDAuZHdjMzogRHJpdmVyIGR3YzMgcmVxdWVzdHMgcHJvYmUgZGVmZXJyYWwKWyAgICAyLjQ4MDk3
OV0gcGxhdGZvcm0gMTI0MDAwMDAuZHdjMzogRHJpdmVyIGR3YzMgcmVxdWVzdHMgcHJvYmUgZGVm
ZXJyYWwKWyAgICAyLjQ4MTI4NV0gb2ZfZ2V0X25hbWVkX2dwaW9kX2ZsYWdzOiBjYW4ndCBwYXJz
ZSBncGlvcyBwcm9wZXJ0eSBvZiBub2RlICcvdXNiQDEyMTEwMDAwWzBdJwpbICAgIDIuNDgxMzIx
XSBleHlub3MtZWhjaSAxMjExMDAwMC51c2I6IG5vIHVzYjIgcGh5IGNvbmZpZ3VyZWQKWyAgICAy
LjQ4MTM2MV0gcGxhdGZvcm0gMTIxMTAwMDAudXNiOiBEcml2ZXIgZXh5bm9zLWVoY2kgcmVxdWVz
dHMgcHJvYmUgZGVmZXJyYWwKWyAgICAyLjY4NTQyN10gVFBTNjUwOTBfUkFJTFNMRE8yOiBkaXNh
YmxpbmcKWyAgICAyLjY4Nzk5MV0gVFBTNjUwOTBfUkFJTFNMRE8xOiBkaXNhYmxpbmcKWyAgICAy
LjcwNTUzMV0gVFBTNjUwOTBfUkFJTFNEQ0RDMzogZGlzYWJsaW5nClsgICAgMi43MDgxODddIFRQ
UzY1MDkwX1JBSUxTRENEQzI6IGRpc2FibGluZwpbICAgIDIuNzEyMzA1XSBUUFM2NTA5MF9SQUlM
U0RDREMxOiBkaXNhYmxpbmcKWyAgICAyLjcxNjY3NF0gdmRkXzF2Ml8yOiBkaXNhYmxpbmcKWyAg
ICAyLjcxOTg2MV0gUDUuMFZfVVNCM0NPTjE6IGRpc2FibGluZwpbICAgIDIuNzIzMjEwXSBQNS4w
Vl9VU0IzQ09OMDogZGlzYWJsaW5nClsgICAgMi43MjY4OThdIGNsazogTm90IGRpc2FibGluZyB1
bnVzZWQgY2xvY2tzClsgICAgMi43MzU0MTVdIFdhaXRpbmcgZm9yIHJvb3QgZGV2aWNlIC9kZXYv
bW1jYmxrMXAzLi4uClsgICAgMi45NDQ3OTNdIGR3bW1jX2V4eW5vcyAxMjIyMDAwMC5tbWM6IDog
PT09PT09PT09PT09PT0gUkVHSVNURVIgRFVNUCA9PT09PT09PT09PT09PQpbICAgIDIuOTUxMDY2
XSBkd21tY19leHlub3MgMTIyMjAwMDAubW1jOiA6IENUUkw6CTB4MDAwMDAwMTAKWyAgICAyLjk1
NjQ0NV0gZHdtbWNfZXh5bm9zIDEyMjIwMDAwLm1tYzogOiBQV1JFTjoJMHgwMDAwMDAwMQpbICAg
IDIuOTYxOTEwXSBkd21tY19leHlub3MgMTIyMjAwMDAubW1jOiA6IENMS0RJVjoJMHgwMDAwMDAz
ZgpbICAgIDIuOTY3NDYxXSBkd21tY19leHlub3MgMTIyMjAwMDAubW1jOiA6IENMS1NSQzoJMHgw
MDAwMDAwMApbICAgIDIuOTczMDEzXSBkd21tY19leHlub3MgMTIyMjAwMDAubW1jOiA6IENMS0VO
QToJMHgwMDAwMDAwMApbICAgIDIuOTc4NTY2XSBkd21tY19leHlub3MgMTIyMjAwMDAubW1jOiA6
IFRNT1VUOgkweGZmZmZmZmZmClsgICAgMi45ODQwMzFdIGR3bW1jX2V4eW5vcyAxMjIyMDAwMC5t
bWM6IDogQ1RZUEU6CTB4MDAwMDAwMDAKWyAgICAyLjk4OTQ5Nl0gZHdtbWNfZXh5bm9zIDEyMjIw
MDAwLm1tYzogOiBCTEtTSVo6CTB4MDAwMDAyMDAKWyAgICAyLjk5NTA0OF0gZHdtbWNfZXh5bm9z
IDEyMjIwMDAwLm1tYzogOiBCWVRDTlQ6CTB4MDAwMDAyMDAKWyAgICAzLjAwMDYwMF0gZHdtbWNf
ZXh5bm9zIDEyMjIwMDAwLm1tYzogOiBJTlRNU0s6CTB4MDAwMGI3ZmYKWyAgICAzLjAwNjE1Ml0g
ZHdtbWNfZXh5bm9zIDEyMjIwMDAwLm1tYzogOiBDTURBUkc6CTB4MDAwMDAwMDAKWyAgICAzLjAx
MTcwNF0gZHdtbWNfZXh5bm9zIDEyMjIwMDAwLm1tYzogOiBDTUQ6CTB4ODAyMDIwMDAKWyAgICAz
LjAxNjk5NV0gZHdtbWNfZXh5bm9zIDEyMjIwMDAwLm1tYzogOiBSRVNQMDoJMHgwMDAwMDMyMApb
ICAgIDMuMDIyNDYxXSBkd21tY19leHlub3MgMTIyMjAwMDAubW1jOiA6IFJFU1AxOgkweDNhYzU3
ZjgwClsgICAgMy4wMjc5MjZdIGR3bW1jX2V4eW5vcyAxMjIyMDAwMC5tbWM6IDogUkVTUDI6CTB4
NWI1OTAwMDAKWyAgICAzLjAzMzM5MV0gZHdtbWNfZXh5bm9zIDEyMjIwMDAwLm1tYzogOiBSRVNQ
MzoJMHg0MDBlMDAzMgpbICAgIDMuMDM4ODU3XSBkd21tY19leHlub3MgMTIyMjAwMDAubW1jOiA6
IE1JTlRTVFM6CTB4MDAwMDAwMDAKWyAgICAzLjA0NDQ5Nl0gZHdtbWNfZXh5bm9zIDEyMjIwMDAw
Lm1tYzogOiBSSU5UU1RTOgkweDAwMDEwMDAwClsgICAgMy4wNTAxMzVdIGR3bW1jX2V4eW5vcyAx
MjIyMDAwMC5tbWM6IDogU1RBVFVTOgkweDAwMDA1YTA2ClsgICAgMy4wNTU2ODZdIGR3bW1jX2V4
eW5vcyAxMjIyMDAwMC5tbWM6IDogRklGT1RIOgkweDIwMWYwMDIwClsgICAgMy4wNjEyMzhdIGR3
bW1jX2V4eW5vcyAxMjIyMDAwMC5tbWM6IDogQ0RFVEVDVDoJMHgwMDAwMDAwMApbICAgIDMuMDY2
ODc3XSBkd21tY19leHlub3MgMTIyMjAwMDAubW1jOiA6IFdSVFBSVDoJMHgwMDAwMDAwMApbICAg
IDMuMDcyNDI5XSBkd21tY19leHlub3MgMTIyMjAwMDAubW1jOiA6IEdQSU86CTB4MDAwMDAwMDAK
WyAgICAzLjA3NzgwOF0gZHdtbWNfZXh5bm9zIDEyMjIwMDAwLm1tYzogOiBUQ0JDTlQ6CTB4MDAw
MDAyMDAKWyAgICAzLjA4MzM1OV0gZHdtbWNfZXh5bm9zIDEyMjIwMDAwLm1tYzogOiBUQkJDTlQ6
CTB4MDAwMDAwMDAKWyAgICAzLjA4ODkxMV0gZHdtbWNfZXh5bm9zIDEyMjIwMDAwLm1tYzogOiBE
RUJOQ0U6CTB4MDBmZmZmZmYKWyAgICAzLjA5NDQ2M10gZHdtbWNfZXh5bm9zIDEyMjIwMDAwLm1t
YzogOiBVU1JJRDoJMHhmZmZmZmZmZgpbICAgIDMuMDk5OTMwXSBkd21tY19leHlub3MgMTIyMjAw
MDAubW1jOiA6IFZFUklEOgkweDUzNDIyNTBhClsgICAgMy4xMDUzOTRdIGR3bW1jX2V4eW5vcyAx
MjIyMDAwMC5tbWM6IDogSENPTjoJMHgwMGU0MjU0MQpbICAgIDMuMTEwNzcyXSBkd21tY19leHlu
b3MgMTIyMjAwMDAubW1jOiA6IFVIU19SRUc6CTB4MDAwMDAwMDAKWyAgICAzLjExNjQxM10gZHdt
bWNfZXh5bm9zIDEyMjIwMDAwLm1tYzogOiBCTU9EOgkweDAwMDAwMjAwClsgICAgMy4xMjE3OTBd
IGR3bW1jX2V4eW5vcyAxMjIyMDAwMC5tbWM6IDogUExETU5EOgkweDAwMDAwMDAwClsgICAgMy4x
MjczNDFdIGR3bW1jX2V4eW5vcyAxMjIyMDAwMC5tbWM6IDogREJBRERSOgkweDRkYmJiMDAwClsg
ICAgMy4xMzI4OTRdIGR3bW1jX2V4eW5vcyAxMjIyMDAwMC5tbWM6IDogSURTVFM6CTB4MDAwMDAw
MDAKWyAgICAzLjEzODM1OV0gZHdtbWNfZXh5bm9zIDEyMjIwMDAwLm1tYzogOiBJRElOVEVOOgkw
eDAwMDAwMTAzClsgICAgMy4xNDM5OThdIGR3bW1jX2V4eW5vcyAxMjIyMDAwMC5tbWM6IDogRFND
QUREUjoJMHgwMDAwMDAwMApbICAgIDMuMTQ5NjM2XSBkd21tY19leHlub3MgMTIyMjAwMDAubW1j
OiA6IEJVRkFERFI6CTB4MDAwMDAwMDAKWyAgICAzLjE1NTI3M10gZHdtbWNfZXh5bm9zIDEyMjIw
MDAwLm1tYzogOiBDTEtTRUw6CTB4MDMwMzAwMDIKWyAgICAzLjE2MDgyN10gZHdtbWNfZXh5bm9z
IDEyMjIwMDAwLm1tYzogOiA9PT09PT09PT09PT09PT09PSBDTUQgUkVHID09PT09PT09PT09PT09
PT09ClsgICAgMy4xNjg1NDddIGR3bW1jX2V4eW5vcyAxMjIyMDAwMC5tbWM6IDogcmVhZC93cml0
ZSAgICAgICAgOiByZWFkClsgICAgMy4xNzQ2MjBdIGR3bW1jX2V4eW5vcyAxMjIyMDAwMC5tbWM6
IDogZGF0YSBleHBlY3RlZCAgICAgOiAwClsgICAgMy4xODA0MzJdIGR3bW1jX2V4eW5vcyAxMjIy
MDAwMC5tbWM6IDogY21kIGluZGV4ICAgICAgICAgOiAwClsgICAgMy4xODYyNDVdIGR3bW1jX2V4
eW5vcyAxMjIyMDAwMC5tbWM6IDogPT09PT09PT09PT09PT09PSBTVEFUVVMgUkVHID09PT09PT09
PT09PT09PQpbICAgIDMuMTkzOTY1XSBkd21tY19leHlub3MgMTIyMjAwMDAubW1jOiA6IGZpZm9j
b3VudCAgICAgICAgIDogMApbICAgIDMuMTk5Nzg1XSBkd21tY19leHlub3MgMTIyMjAwMDAubW1j
OiA6IHJlc3BvbnNlIGluZGV4ICAgIDogMTEKWyAgICAzLjIwNTY3N10gZHdtbWNfZXh5bm9zIDEy
MjIwMDAwLm1tYzogOiBkYXRhIHN0YXRlIG1jIGJ1c3k6IDAKWyAgICAzLjIxMTQ4OF0gZHdtbWNf
ZXh5bm9zIDEyMjIwMDAwLm1tYzogOiBkYXRhIGJ1c3kgICAgICAgICA6IDEKWyAgICAzLjIxNzMw
MV0gZHdtbWNfZXh5bm9zIDEyMjIwMDAwLm1tYzogOiBkYXRhIDMgc3RhdGUgICAgICA6IDAKWyAg
ICAzLjIyMzExM10gZHdtbWNfZXh5bm9zIDEyMjIwMDAwLm1tYzogOiBjb21tYW5kIGZzbSBzdGF0
ZSA6IDAKWyAgICAzLjIyODkyNl0gZHdtbWNfZXh5bm9zIDEyMjIwMDAwLm1tYzogOiBmaWZvIGZ1
bGwgICAgICAgICA6IDAKWyAgICAzLjIzNDczOF0gZHdtbWNfZXh5bm9zIDEyMjIwMDAwLm1tYzog
OiBmaWZvIGVtcHR5ICAgICAgICA6IDEKWyAgICAzLjI0MDU1MF0gZHdtbWNfZXh5bm9zIDEyMjIw
MDAwLm1tYzogOiBmaWZvIHR4IHdhdGVybWFyayA6IDEKWyAgICAzLjI0NjM2Ml0gZHdtbWNfZXh5
bm9zIDEyMjIwMDAwLm1tYzogOiBmaWZvIHJ4IHdhdGVybWFyayA6IDAKWyAgICAzLjI1MjE3NF0g
ZHdtbWNfZXh5bm9zIDEyMjIwMDAwLm1tYzogOiA9PT09PT09PT09PT09PSBTVEFUVVMgRFVNUCA9
PT09PT09PT09PT09PT09ClsgICAgMy4yNTk4OTRdIGR3bW1jX2V4eW5vcyAxMjIyMDAwMC5tbWM6
IDogY21kX3N0YXR1czogICAgICAweDAwMDAwMDAwClsgICAgMy4yNjYyMjhdIGR3bW1jX2V4eW5v
cyAxMjIyMDAwMC5tbWM6IDogZGF0YV9zdGF0dXM6ICAgICAweDAwMDAwMDAwClsgICAgMy4yNzI1
NjFdIGR3bW1jX2V4eW5vcyAxMjIyMDAwMC5tbWM6IDogcGVuZGluZ19ldmVudHM6ICAweDAwMDAw
MDAwClsgICAgMy4yNzg4OTNdIGR3bW1jX2V4eW5vcyAxMjIyMDAwMC5tbWM6IDogY29tcGxldGVk
X2V2ZW50czoweDAwMDAwMDAxClsgICAgMy4yODUyMjZdIGR3bW1jX2V4eW5vcyAxMjIyMDAwMC5t
bWM6IDogc3RhdGU6ICAgICAgICAgICA3ClsgICAgMy4yOTA3NzhdIGR3bW1jX2V4eW5vcyAxMjIy
MDAwMC5tbWM6IDogPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQpb
ICAgIDMuMjk4NTAwXSBtbWNfaG9zdCBtbWMxOiBUaW1lb3V0IHNlbmRpbmcgY29tbWFuZCAoY21k
IDB4MjAyMDAwIGFyZyAweDAgc3RhdHVzIDB4ODAyMDIwMDApClsgICAgMy4zNDc2MDNdIHJhbmRv
bTogbm9uYmxvY2tpbmcgcG9vbCBpcyBpbml0aWFsaXplZApbICAgIDMuODE0NzkxXSBkd21tY19l
eHlub3MgMTIyMjAwMDAubW1jOiA6ID09PT09PT09PT09PT09IFJFR0lTVEVSIERVTVAgPT09PT09
PT09PT09PT0KWyAgICAzLjgyMTA2OF0gZHdtbWNfZXh5bm9zIDEyMjIwMDAwLm1tYzogOiBDVFJM
OgkweDAwMDAwMDEwClsgICAgMy44MjY0NDddIGR3bW1jX2V4eW5vcyAxMjIyMDAwMC5tbWM6IDog
UFdSRU46CTB4MDAwMDAwMDEKWyAgICAzLjgzMTkxM10gZHdtbWNfZXh5bm9zIDEyMjIwMDAwLm1t
YzogOiBDTEtESVY6CTB4MDAwMDAwM2YKWyAgICAzLjgzNzQ2NV0gZHdtbWNfZXh5bm9zIDEyMjIw
MDAwLm1tYzogOiBDTEtTUkM6CTB4MDAwMDAwMDAKWyAgICAzLjg0MzAxNV0gZHdtbWNfZXh5bm9z
IDEyMjIwMDAwLm1tYzogOiBDTEtFTkE6CTB4MDAwMDAwMDAKWyAgICAzLjg0ODU2OV0gZHdtbWNf
ZXh5bm9zIDEyMjIwMDAwLm1tYzogOiBUTU9VVDoJMHhmZmZmZmZmZgpbICAgIDMuODU0MDM0XSBk
d21tY19leHlub3MgMTIyMjAwMDAubW1jOiA6IENUWVBFOgkweDAwMDAwMDAwClsgICAgMy44NTk0
OTldIGR3bW1jX2V4eW5vcyAxMjIyMDAwMC5tbWM6IDogQkxLU0laOgkweDAwMDAwMjAwClsgICAg
My44NjUwNTBdIGR3bW1jX2V4eW5vcyAxMjIyMDAwMC5tbWM6IDogQllUQ05UOgkweDAwMDAwMjAw
ClsgICAgMy44NzA2MDFdIGR3bW1jX2V4eW5vcyAxMjIyMDAwMC5tbWM6IDogSU5UTVNLOgkweDAw
MDBiN2ZmClsgICAgMy44NzYxNTNdIGR3bW1jX2V4eW5vcyAxMjIyMDAwMC5tbWM6IDogQ01EQVJH
OgkweDAwMDAwMDAwClsgICAgMy44ODE3MDddIGR3bW1jX2V4eW5vcyAxMjIyMDAwMC5tbWM6IDog
Q01EOgkweDgwMjAyMDAwClsgICAgMy44ODY5OThdIGR3bW1jX2V4eW5vcyAxMjIyMDAwMC5tbWM6
IDogUkVTUDA6CTB4MDAwMDAzMjAKWyAgICAzLjg5MjQ2Ml0gZHdtbWNfZXh5bm9zIDEyMjIwMDAw
Lm1tYzogOiBSRVNQMToJMHgzYWM1N2Y4MApbICAgIDMuODk3OTI5XSBkd21tY19leHlub3MgMTIy
MjAwMDAubW1jOiA6IFJFU1AyOgkweDViNTkwMDAwClsgICAgMy45MDMzOTVdIGR3bW1jX2V4eW5v
cyAxMjIyMDAwMC5tbWM6IDogUkVTUDM6CTB4NDAwZTAwMzIKWyAgICAzLjkwODg1OF0gZHdtbWNf
ZXh5bm9zIDEyMjIwMDAwLm1tYzogOiBNSU5UU1RTOgkweDAwMDAxMDAwClsgICAgMy45MTQ0OThd
IGR3bW1jX2V4eW5vcyAxMjIyMDAwMC5tbWM6IDogUklOVFNUUzoJMHgwMDAxMTAwMApbICAgIDMu
OTIwMTM2XSBkd21tY19leHlub3MgMTIyMjAwMDAubW1jOiA6IFNUQVRVUzoJMHgwMDAwNWEwNgpb
ICAgIDMuOTI1Njg5XSBkd21tY19leHlub3MgMTIyMjAwMDAubW1jOiA6IEZJRk9USDoJMHgyMDFm
MDAyMApbICAgIDMuOTMxMjQwXSBkd21tY19leHlub3MgMTIyMjAwMDAubW1jOiA6IENERVRFQ1Q6
CTB4MDAwMDAwMDAKWyAgICAzLjkzNjg3OV0gZHdtbWNfZXh5bm9zIDEyMjIwMDAwLm1tYzogOiBX
UlRQUlQ6CTB4MDAwMDAwMDAKWyAgICAzLjk0MjQzMl0gZHdtbWNfZXh5bm9zIDEyMjIwMDAwLm1t
YzogOiBHUElPOgkweDAwMDAwMDAwClsgICAgMy45NDc4MTFdIGR3bW1jX2V4eW5vcyAxMjIyMDAw
MC5tbWM6IDogVENCQ05UOgkweDAwMDAwMjAwClsgICAgMy45NTMzNjJdIGR3bW1jX2V4eW5vcyAx
MjIyMDAwMC5tbWM6IDogVEJCQ05UOgkweDAwMDAwMDAwClsgICAgMy45NTg5MTNdIGR3bW1jX2V4
eW5vcyAxMjIyMDAwMC5tbWM6IDogREVCTkNFOgkweDAwZmZmZmZmClsgICAgMy45NjQ0NjZdIGR3
bW1jX2V4eW5vcyAxMjIyMDAwMC5tbWM6IDogVVNSSUQ6CTB4ZmZmZmZmZmYKWyAgICAzLjk2OTkz
MV0gZHdtbWNfZXh5bm9zIDEyMjIwMDAwLm1tYzogOiBWRVJJRDoJMHg1MzQyMjUwYQpbICAgIDMu
OTc1Mzk1XSBkd21tY19leHlub3MgMTIyMjAwMDAubW1jOiA6IEhDT046CTB4MDBlNDI1NDEKWyAg
ICAzLjk4MDc3NV0gZHdtbWNfZXh5bm9zIDEyMjIwMDAwLm1tYzogOiBVSFNfUkVHOgkweDAwMDAw
MDAxClsgICAgMy45ODY0MTRdIGR3bW1jX2V4eW5vcyAxMjIyMDAwMC5tbWM6IDogQk1PRDoJMHgw
MDAwMDIwMApbICAgIDMuOTkxNzkyXSBkd21tY19leHlub3MgMTIyMjAwMDAubW1jOiA6IFBMRE1O
RDoJMHgwMDAwMDAwMApbICAgIDMuOTk3MzQzXSBkd21tY19leHlub3MgMTIyMjAwMDAubW1jOiA6
IERCQUREUjoJMHg0ZGJiYjAwMApbICAgIDQuMDAyODk1XSBkd21tY19leHlub3MgMTIyMjAwMDAu
bW1jOiA6IElEU1RTOgkweDAwMDAwMDAwClsgICAgNC4wMDgzNjJdIGR3bW1jX2V4eW5vcyAxMjIy
MDAwMC5tbWM6IDogSURJTlRFTjoJMHgwMDAwMDEwMwpbICAgIDQuMDE0MDAwXSBkd21tY19leHlu
b3MgMTIyMjAwMDAubW1jOiA6IERTQ0FERFI6CTB4MDAwMDAwMDAKWyAgICA0LjAxOTYzOV0gZHdt
bWNfZXh5bm9zIDEyMjIwMDAwLm1tYzogOiBCVUZBRERSOgkweDAwMDAwMDAwClsgICAgNC4wMjUy
NzhdIGR3bW1jX2V4eW5vcyAxMjIyMDAwMC5tbWM6IDogQ0xLU0VMOgkweDAzMDMwMDAyClsgICAg
NC4wMzA4MzBdIGR3bW1jX2V4eW5vcyAxMjIyMDAwMC5tbWM6IDogPT09PT09PT09PT09PT09PT0g
Q01EIFJFRyA9PT09PT09PT09PT09PT09PQpbICAgIDQuMDM4NTQ5XSBkd21tY19leHlub3MgMTIy
MjAwMDAubW1jOiA6IHJlYWQvd3JpdGUgICAgICAgIDogcmVhZApbICAgIDQuMDQ0NjIyXSBkd21t
Y19leHlub3MgMTIyMjAwMDAubW1jOiA6IGRhdGEgZXhwZWN0ZWQgICAgIDogMApbICAgIDQuMDUw
NDM1XSBkd21tY19leHlub3MgMTIyMjAwMDAubW1jOiA6IGNtZCBpbmRleCAgICAgICAgIDogMApb
ICAgIDQuMDU2MjQ3XSBkd21tY19leHlub3MgMTIyMjAwMDAubW1jOiA6ID09PT09PT09PT09PT09
PT0gU1RBVFVTIFJFRyA9PT09PT09PT09PT09PT0KWyAgICA0LjA2Mzk2OF0gZHdtbWNfZXh5bm9z
IDEyMjIwMDAwLm1tYzogOiBmaWZvY291bnQgICAgICAgICA6IDAKWyAgICA0LjA2OTc4OV0gZHdt
bWNfZXh5bm9zIDEyMjIwMDAwLm1tYzogOiByZXNwb25zZSBpbmRleCAgICA6IDExClsgICAgNC4w
NzU2NzldIGR3bW1jX2V4eW5vcyAxMjIyMDAwMC5tbWM6IDogZGF0YSBzdGF0ZSBtYyBidXN5OiAw
ClsgICAgNC4wODE0OTFdIGR3bW1jX2V4eW5vcyAxMjIyMDAwMC5tbWM6IDogZGF0YSBidXN5ICAg
ICAgICAgOiAxClsgICAgNC4wODczMDNdIGR3bW1jX2V4eW5vcyAxMjIyMDAwMC5tbWM6IDogZGF0
YSAzIHN0YXRlICAgICAgOiAwClsgICAgNC4wOTMxMTZdIGR3bW1jX2V4eW5vcyAxMjIyMDAwMC5t
bWM6IDogY29tbWFuZCBmc20gc3RhdGUgOiAwClsgICAgNC4wOTg5MjldIGR3bW1jX2V4eW5vcyAx
MjIyMDAwMC5tbWM6IDogZmlmbyBmdWxsICAgICAgICAgOiAwClsgICAgNC4xMDQ3NDBdIGR3bW1j
X2V4eW5vcyAxMjIyMDAwMC5tbWM6IDogZmlmbyBlbXB0eSAgICAgICAgOiAxClsgICAgNC4xMTA1
NTNdIGR3bW1jX2V4eW5vcyAxMjIyMDAwMC5tbWM6IDogZmlmbyB0eCB3YXRlcm1hcmsgOiAxClsg
ICAgNC4xMTYzNjVdIGR3bW1jX2V4eW5vcyAxMjIyMDAwMC5tbWM6IDogZmlmbyByeCB3YXRlcm1h
cmsgOiAwClsgICAgNC4xMjIxNzZdIGR3bW1jX2V4eW5vcyAxMjIyMDAwMC5tbWM6IDogPT09PT09
PT09PT09PT0gU1RBVFVTIERVTVAgPT09PT09PT09PT09PT09PQpbICAgIDQuMTI5ODk4XSBkd21t
Y19leHlub3MgMTIyMjAwMDAubW1jOiA6IGNtZF9zdGF0dXM6ICAgICAgMHgwMDAwMDAwMApbICAg
IDQuMTM2MjMwXSBkd21tY19leHlub3MgMTIyMjAwMDAubW1jOiA6IGRhdGFfc3RhdHVzOiAgICAg
MHgwMDAwMDAwMApbICAgIDQuMTQyNTYzXSBkd21tY19leHlub3MgMTIyMjAwMDAubW1jOiA6IHBl
bmRpbmdfZXZlbnRzOiAgMHgwMDAwMDAwMApbICAgIDQuMTQ4ODk1XSBkd21tY19leHlub3MgMTIy
MjAwMDAubW1jOiA6IGNvbXBsZXRlZF9ldmVudHM6MHgwMDAwMDAwMQpbICAgIDQuMTU1MjI5XSBk
d21tY19leHlub3MgMTIyMjAwMDAubW1jOiA6IHN0YXRlOiAgICAgICAgICAgNwpbICAgIDQuMTYw
Nzc5XSBkd21tY19leHlub3MgMTIyMjAwMDAubW1jOiA6ID09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT0KWyAgICA0LjE2ODUwMl0gbW1jX2hvc3QgbW1jMTogVGltZW91
dCBzZW5kaW5nIGNvbW1hbmQgKGNtZCAweDIwMjAwMCBhcmcgMHgwIHN0YXR1cyAweDgwMjAyMDAw
KQpbICAgIDQuNjc0NzkxXSBkd21tY19leHlub3MgMTIyMjAwMDAubW1jOiA6ID09PT09PT09PT09
PT09IFJFR0lTVEVSIERVTVAgPT09PT09PT09PT09PT0KWyAgICA0LjY4MTA2NV0gZHdtbWNfZXh5
bm9zIDEyMjIwMDAwLm1tYzogOiBDVFJMOgkweDAwMDAwMDEwClsgICAgNC42ODY0NDJdIGR3bW1j
X2V4eW5vcyAxMjIyMDAwMC5tbWM6IDogUFdSRU46CTB4MDAwMDAwMDEKWyAgICA0LjY5MTkwN10g
ZHdtbWNfZXh5bm9zIDEyMjIwMDAwLm1tYzogOiBDTEtESVY6CTB4MDAwMDAwM2YKWyAgICA0LjY5
NzQ2MF0gZHdtbWNfZXh5bm9zIDEyMjIwMDAwLm1tYzogOiBDTEtTUkM6CTB4MDAwMDAwMDAKWyAg
ICA0LjcwMzAxMl0gZHdtbWNfZXh5bm9zIDEyMjIwMDAwLm1tYzogOiBDTEtFTkE6CTB4MDAwMDAw
MDAKWyAgICA0LjcwODU2M10gZHdtbWNfZXh5bm9zIDEyMjIwMDAwLm1tYzogOiBUTU9VVDoJMHhm
ZmZmZmZmZgpbICAgIDQuNzE0MDI5XSBkd21tY19leHlub3MgMTIyMjAwMDAubW1jOiA6IENUWVBF
OgkweDAwMDAwMDAwClsgICAgNC43MTk0OTNdIGR3bW1jX2V4eW5vcyAxMjIyMDAwMC5tbWM6IDog
QkxLU0laOgkweDAwMDAwMjAwClsgICAgNC43MjUwNDddIGR3bW1jX2V4eW5vcyAxMjIyMDAwMC5t
bWM6IDogQllUQ05UOgkweDAwMDAwMjAwClsgICAgNC43MzA1OThdIGR3bW1jX2V4eW5vcyAxMjIy
MDAwMC5tbWM6IDogSU5UTVNLOgkweDAwMDBiN2ZmClsgICAgNC43MzYxNTBdIGR3bW1jX2V4eW5v
cyAxMjIyMDAwMC5tbWM6IDogQ01EQVJHOgkweDAwMDAwMDAwClsgICAgNC43NDE3MDFdIGR3bW1j
X2V4eW5vcyAxMjIyMDAwMC5tbWM6IDogQ01EOgkweDgwMjAyMDAwClsgICAgNC43NDY5OTRdIGR3
bW1jX2V4eW5vcyAxMjIyMDAwMC5tbWM6IDogUkVTUDA6CTB4MDAwMDAzMjAKWyAgICA0Ljc1MjQ1
OV0gZHdtbWNfZXh5bm9zIDEyMjIwMDAwLm1tYzogOiBSRVNQMToJMHgzYWM1N2Y4MApbICAgIDQu
NzU3OTI1XSBkd21tY19leHlub3MgMTIyMjAwMDAubW1jOiA6IFJFU1AyOgkweDViNTkwMDAwClsg
ICAgNC43NjMzODldIGR3bW1jX2V4eW5vcyAxMjIyMDAwMC5tbWM6IDogUkVTUDM6CTB4NDAwZTAw
MzIKWyAgICA0Ljc2ODg1Nl0gZHdtbWNfZXh5bm9zIDEyMjIwMDAwLm1tYzogOiBNSU5UU1RTOgkw
eDAwMDAxMDAwClsgICAgNC43NzQ0OTRdIGR3bW1jX2V4eW5vcyAxMjIyMDAwMC5tbWM6IDogUklO
VFNUUzoJMHgwMDAxMTAwMApbICAgIDQuNzgwMTMzXSBkd21tY19leHlub3MgMTIyMjAwMDAubW1j
OiA6IFNUQVRVUzoJMHgwMDAwNWEwNgpbICAgIDQuNzg1Njg1XSBkd21tY19leHlub3MgMTIyMjAw
MDAubW1jOiA6IEZJRk9USDoJMHgyMDFmMDAyMApbICAgIDQuNzkxMjM2XSBkd21tY19leHlub3Mg
MTIyMjAwMDAubW1jOiA6IENERVRFQ1Q6CTB4MDAwMDAwMDAKWyAgICA0Ljc5Njg3Nl0gZHdtbWNf
ZXh5bm9zIDEyMjIwMDAwLm1tYzogOiBXUlRQUlQ6CTB4MDAwMDAwMDAKWyAgICA0LjgwMjQyOF0g
ZHdtbWNfZXh5bm9zIDEyMjIwMDAwLm1tYzogOiBHUElPOgkweDAwMDAwMDAwClsgICAgNC44MDc4
MDZdIGR3bW1jX2V4eW5vcyAxMjIyMDAwMC5tbWM6IDogVENCQ05UOgkweDAwMDAwMjAwClsgICAg
NC44MTMzNThdIGR3bW1jX2V4eW5vcyAxMjIyMDAwMC5tbWM6IDogVEJCQ05UOgkweDAwMDAwMDAw
ClsgICAgNC44MTg5MDldIGR3bW1jX2V4eW5vcyAxMjIyMDAwMC5tbWM6IDogREVCTkNFOgkweDAw
ZmZmZmZmClsgICAgNC44MjQ0NjJdIGR3bW1jX2V4eW5vcyAxMjIyMDAwMC5tbWM6IDogVVNSSUQ6
CTB4ZmZmZmZmZmYKWyAgICA0LjgyOTkyN10gZHdtbWNfZXh5bm9zIDEyMjIwMDAwLm1tYzogOiBW
RVJJRDoJMHg1MzQyMjUwYQpbICAgIDQuODM1MzkyXSBkd21tY19leHlub3MgMTIyMjAwMDAubW1j
OiA6IEhDT046CTB4MDBlNDI1NDEKWyAgICA0Ljg0MDc3MF0gZHdtbWNfZXh5bm9zIDEyMjIwMDAw
Lm1tYzogOiBVSFNfUkVHOgkweDAwMDAwMDAxClsgICAgNC44NDY0MTBdIGR3bW1jX2V4eW5vcyAx
MjIyMDAwMC5tbWM6IDogQk1PRDoJMHgwMDAwMDIwMApbICAgIDQuODUxNzg4XSBkd21tY19leHlu
b3MgMTIyMjAwMDAubW1jOiA6IFBMRE1ORDoJMHgwMDAwMDAwMApbICAgIDQuODU3MzQwXSBkd21t
Y19leHlub3MgMTIyMjAwMDAubW1jOiA6IERCQUREUjoJMHg0ZGJiYjAwMApbICAgIDQuODYyODkz
XSBkd21tY19leHlub3MgMTIyMjAwMDAubW1jOiA6IElEU1RTOgkweDAwMDAwMDAwClsgICAgNC44
NjgzNTddIGR3bW1jX2V4eW5vcyAxMjIyMDAwMC5tbWM6IDogSURJTlRFTjoJMHgwMDAwMDEwMwpb
ICAgIDQuODczOTk2XSBkd21tY19leHlub3MgMTIyMjAwMDAubW1jOiA6IERTQ0FERFI6CTB4MDAw
MDAwMDAKWyAgICA0Ljg3OTYzNl0gZHdtbWNfZXh5bm9zIDEyMjIwMDAwLm1tYzogOiBCVUZBRERS
OgkweDAwMDAwMDAwClsgICAgNC44ODUyNzRdIGR3bW1jX2V4eW5vcyAxMjIyMDAwMC5tbWM6IDog
Q0xLU0VMOgkweDAzMDMwMDAyClsgICAgNC44OTA4MjZdIGR3bW1jX2V4eW5vcyAxMjIyMDAwMC5t
bWM6IDogPT09PT09PT09PT09PT09PT0gQ01EIFJFRyA9PT09PT09PT09PT09PT09PQpbICAgIDQu
ODk4NTQ1XSBkd21tY19leHlub3MgMTIyMjAwMDAubW1jOiA6IHJlYWQvd3JpdGUgICAgICAgIDog
cmVhZApbICAgIDQuOTA0NjE5XSBkd21tY19leHlub3MgMTIyMjAwMDAubW1jOiA6IGRhdGEgZXhw
ZWN0ZWQgICAgIDogMApbICAgIDQuOTEwNDMwXSBkd21tY19leHlub3MgMTIyMjAwMDAubW1jOiA6
IGNtZCBpbmRleCAgICAgICAgIDogMApbICAgIDQuOTE2MjQzXSBkd21tY19leHlub3MgMTIyMjAw
MDAubW1jOiA6ID09PT09PT09PT09PT09PT0gU1RBVFVTIFJFRyA9PT09PT09PT09PT09PT0KWyAg
ICA0LjkyMzk2M10gZHdtbWNfZXh5bm9zIDEyMjIwMDAwLm1tYzogOiBmaWZvY291bnQgICAgICAg
ICA6IDAKWyAgICA0LjkyOTc5M10gZHdtbWNfZXh5bm9zIDEyMjIwMDAwLm1tYzogOiByZXNwb25z
ZSBpbmRleCAgICA6IDExClsgICAgNC45MzU2NzVdIGR3bW1jX2V4eW5vcyAxMjIyMDAwMC5tbWM6
IDogZGF0YSBzdGF0ZSBtYyBidXN5OiAwClsgICAgNC45NDE0ODddIGR3bW1jX2V4eW5vcyAxMjIy
MDAwMC5tbWM6IDogZGF0YSBidXN5ICAgICAgICAgOiAxClsgICAgNC45NDcyOThdIGR3bW1jX2V4
eW5vcyAxMjIyMDAwMC5tbWM6IDogZGF0YSAzIHN0YXRlICAgICAgOiAwClsgICAgNC45NTMxMTJd
IGR3bW1jX2V4eW5vcyAxMjIyMDAwMC5tbWM6IDogY29tbWFuZCBmc20gc3RhdGUgOiAwClsgICAg
NC45NTg5MjNdIGR3bW1jX2V4eW5vcyAxMjIyMDAwMC5tbWM6IDogZmlmbyBmdWxsICAgICAgICAg
OiAwClsgICAgNC45NjQ3MzZdIGR3bW1jX2V4eW5vcyAxMjIyMDAwMC5tbWM6IDogZmlmbyBlbXB0
eSAgICAgICAgOiAxClsgICAgNC45NzA1NDhdIGR3bW1jX2V4eW5vcyAxMjIyMDAwMC5tbWM6IDog
ZmlmbyB0eCB3YXRlcm1hcmsgOiAxClsgICAgNC45NzYzNjFdIGR3bW1jX2V4eW5vcyAxMjIyMDAw
MC5tbWM6IDogZmlmbyByeCB3YXRlcm1hcmsgOiAwClsgICAgNC45ODIxNzNdIGR3bW1jX2V4eW5v
cyAxMjIyMDAwMC5tbWM6IDogPT09PT09PT09PT09PT0gU1RBVFVTIERVTVAgPT09PT09PT09PT09
PT09PQpbICAgIDQuOTg5ODkzXSBkd21tY19leHlub3MgMTIyMjAwMDAubW1jOiA6IGNtZF9zdGF0
dXM6ICAgICAgMHgwMDAwMDAwMApbICAgIDQuOTk2MjI2XSBkd21tY19leHlub3MgMTIyMjAwMDAu
bW1jOiA6IGRhdGFfc3RhdHVzOiAgICAgMHgwMDAwMDAwMApbICAgIDUuMDAyNTU5XSBkd21tY19l
eHlub3MgMTIyMjAwMDAubW1jOiA6IHBlbmRpbmdfZXZlbnRzOiAgMHgwMDAwMDAwMApbICAgIDUu
MDA4ODkxXSBkd21tY19leHlub3MgMTIyMjAwMDAubW1jOiA6IGNvbXBsZXRlZF9ldmVudHM6MHgw
MDAwMDAwMQpbICAgIDUuMDE1MjI1XSBkd21tY19leHlub3MgMTIyMjAwMDAubW1jOiA6IHN0YXRl
OiAgICAgICAgICAgNwpbICAgIDUuMDIwNzc3XSBkd21tY19leHlub3MgMTIyMjAwMDAubW1jOiA6
ID09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KWyAgICA1LjAyODQ5
OF0gbW1jX2hvc3QgbW1jMTogVGltZW91dCBzZW5kaW5nIGNvbW1hbmQgKGNtZCAweDIwMjAwMCBh
cmcgMHgwIHN0YXR1cyAweDgwMjAyMDAwKQpbICAgIDUuNTM0NzkxXSBkd21tY19leHlub3MgMTIy
MjAwMDAubW1jOiA6ID09PT09PT09PT09PT09IFJFR0lTVEVSIERVTVAgPT09PT09PT09PT09PT0K
WyAgICA1LjU0MTA2OV0gZHdtbWNfZXh5bm9zIDEyMjIwMDAwLm1tYzogOiBDVFJMOgkweDAwMDAw
MDEwClsgICAgNS41NDY0NDddIGR3bW1jX2V4eW5vcyAxMjIyMDAwMC5tbWM6IDogUFdSRU46CTB4
MDAwMDAwMDEKWyAgICA1LjU1MTkxM10gZHdtbWNfZXh5bm9zIDEyMjIwMDAwLm1tYzogOiBDTEtE
SVY6CTB4MDAwMDAwM2YKWyAgICA1LjU1NzQ2NV0gZHdtbWNfZXh5bm9zIDEyMjIwMDAwLm1tYzog
OiBDTEtTUkM6CTB4MDAwMDAwMDAKWyAgICA1LjU2MzAxN10gZHdtbWNfZXh5bm9zIDEyMjIwMDAw
Lm1tYzogOiBDTEtFTkE6CTB4MDAwMDAwMDAKWyAgICA1LjU2ODU2OV0gZHdtbWNfZXh5bm9zIDEy
MjIwMDAwLm1tYzogOiBUTU9VVDoJMHhmZmZmZmZmZgpbICAgIDUuNTc0MDM0XSBkd21tY19leHlu
b3MgMTIyMjAwMDAubW1jOiA6IENUWVBFOgkweDAwMDAwMDAwClsgICAgNS41Nzk0OTldIGR3bW1j
X2V4eW5vcyAxMjIyMDAwMC5tbWM6IDogQkxLU0laOgkweDAwMDAwMjAwClsgICAgNS41ODUwNTFd
IGR3bW1jX2V4eW5vcyAxMjIyMDAwMC5tbWM6IDogQllUQ05UOgkweDAwMDAwMjAwClsgICAgNS41
OTA2MDNdIGR3bW1jX2V4eW5vcyAxMjIyMDAwMC5tbWM6IDogSU5UTVNLOgkweDAwMDBiN2ZmClsg
ICAgNS41OTYxNTVdIGR3bW1jX2V4eW5vcyAxMjIyMDAwMC5tbWM6IDogQ01EQVJHOgkweDAwMDAw
MDAwClsgICAgNS42MDE3MDddIGR3bW1jX2V4eW5vcyAxMjIyMDAwMC5tbWM6IDogQ01EOgkweDgw
MjAyMDAwClsgICAgNS42MDcwMDBdIGR3bW1jX2V4eW5vcyAxMjIyMDAwMC5tbWM6IDogUkVTUDA6
CTB4MDAwMDAzMjAKWyAgICA1LjYxMjQ2NF0gZHdtbWNfZXh5bm9zIDEyMjIwMDAwLm1tYzogOiBS
RVNQMToJMHgzYWM1N2Y4MApbICAgIDUuNjE3OTI5XSBkd21tY19leHlub3MgMTIyMjAwMDAubW1j
OiA6IFJFU1AyOgkweDViNTkwMDAwClsgICAgNS42MjMzOTVdIGR3bW1jX2V4eW5vcyAxMjIyMDAw
MC5tbWM6IDogUkVTUDM6CTB4NDAwZTAwMzIKWyAgICA1LjYyODg2MV0gZHdtbWNfZXh5bm9zIDEy
MjIwMDAwLm1tYzogOiBNSU5UU1RTOgkweDAwMDAxMDAwClsgICAgNS42MzQ0OThdIGR3bW1jX2V4
eW5vcyAxMjIyMDAwMC5tbWM6IDogUklOVFNUUzoJMHgwMDAxMTAwMApbICAgIDUuNjQwMTM4XSBk
d21tY19leHlub3MgMTIyMjAwMDAubW1jOiA6IFNUQVRVUzoJMHgwMDAwNWEwNgpbICAgIDUuNjQ1
Njg4XSBkd21tY19leHlub3MgMTIyMjAwMDAubW1jOiA6IEZJRk9USDoJMHgyMDFmMDAyMApbICAg
IDUuNjUxMjQyXSBkd21tY19leHlub3MgMTIyMjAwMDAubW1jOiA6IENERVRFQ1Q6CTB4MDAwMDAw
MDAKWyAgICA1LjY1Njg4MV0gZHdtbWNfZXh5bm9zIDEyMjIwMDAwLm1tYzogOiBXUlRQUlQ6CTB4
MDAwMDAwMDAKWyAgICA1LjY2MjQzMl0gZHdtbWNfZXh5bm9zIDEyMjIwMDAwLm1tYzogOiBHUElP
OgkweDAwMDAwMDAwClsgICAgNS42Njc4MTBdIGR3bW1jX2V4eW5vcyAxMjIyMDAwMC5tbWM6IDog
VENCQ05UOgkweDAwMDAwMjAwClsgICAgNS42NzMzNjJdIGR3bW1jX2V4eW5vcyAxMjIyMDAwMC5t
bWM6IDogVEJCQ05UOgkweDAwMDAwMDAwClsgICAgNS42Nzg5MTRdIGR3bW1jX2V4eW5vcyAxMjIy
MDAwMC5tbWM6IDogREVCTkNFOgkweDAwZmZmZmZmClsgICAgNS42ODQ0NjddIGR3bW1jX2V4eW5v
cyAxMjIyMDAwMC5tbWM6IDogVVNSSUQ6CTB4ZmZmZmZmZmYKWyAgICA1LjY4OTkzMl0gZHdtbWNf
ZXh5bm9zIDEyMjIwMDAwLm1tYzogOiBWRVJJRDoJMHg1MzQyMjUwYQpbICAgIDUuNjk1Mzk2XSBk
d21tY19leHlub3MgMTIyMjAwMDAubW1jOiA6IEhDT046CTB4MDBlNDI1NDEKWyAgICA1LjcwMDc3
NV0gZHdtbWNfZXh5bm9zIDEyMjIwMDAwLm1tYzogOiBVSFNfUkVHOgkweDAwMDAwMDAxClsgICAg
NS43MDY0MTVdIGR3bW1jX2V4eW5vcyAxMjIyMDAwMC5tbWM6IDogQk1PRDoJMHgwMDAwMDIwMApb
ICAgIDUuNzExNzkzXSBkd21tY19leHlub3MgMTIyMjAwMDAubW1jOiA6IFBMRE1ORDoJMHgwMDAw
MDAwMApbICAgIDUuNzE3MzQ1XSBkd21tY19leHlub3MgMTIyMjAwMDAubW1jOiA6IERCQUREUjoJ
MHg0ZGJiYjAwMApbICAgIDUuNzIyODk3XSBkd21tY19leHlub3MgMTIyMjAwMDAubW1jOiA6IElE
U1RTOgkweDAwMDAwMDAwClsgICAgNS43MjgzNjNdIGR3bW1jX2V4eW5vcyAxMjIyMDAwMC5tbWM6
IDogSURJTlRFTjoJMHgwMDAwMDEwMwpbICAgIDUuNzM0MDAxXSBkd21tY19leHlub3MgMTIyMjAw
MDAubW1jOiA6IERTQ0FERFI6CTB4MDAwMDAwMDAKWyAgICA1LjczOTY0MF0gZHdtbWNfZXh5bm9z
IDEyMjIwMDAwLm1tYzogOiBCVUZBRERSOgkweDAwMDAwMDAwClsgICAgNS43NDUyNzldIGR3bW1j
X2V4eW5vcyAxMjIyMDAwMC5tbWM6IDogQ0xLU0VMOgkweDAzMDMwMDAyClsgICAgNS43NTA4MzBd
IGR3bW1jX2V4eW5vcyAxMjIyMDAwMC5tbWM6IDogPT09PT09PT09PT09PT09PT0gQ01EIFJFRyA9
PT09PT09PT09PT09PT09PQpbICAgIDUuNzU4NTUwXSBkd21tY19leHlub3MgMTIyMjAwMDAubW1j
OiA6IHJlYWQvd3JpdGUgICAgICAgIDogcmVhZApbICAgIDUuNzY0NjIzXSBkd21tY19leHlub3Mg
MTIyMjAwMDAubW1jOiA6IGRhdGEgZXhwZWN0ZWQgICAgIDogMApbICAgIDUuNzcwNDM2XSBkd21t
Y19leHlub3MgMTIyMjAwMDAubW1jOiA6IGNtZCBpbmRleCAgICAgICAgIDogMApbICAgIDUuNzc2
MjQ4XSBkd21tY19leHlub3MgMTIyMjAwMDAubW1jOiA6ID09PT09PT09PT09PT09PT0gU1RBVFVT
IFJFRyA9PT09PT09PT09PT09PT0KWyAgICA1Ljc4Mzk2OV0gZHdtbWNfZXh5bm9zIDEyMjIwMDAw
Lm1tYzogOiBmaWZvY291bnQgICAgICAgICA6IDAKWyAgICA1Ljc4OTc5MV0gZHdtbWNfZXh5bm9z
IDEyMjIwMDAwLm1tYzogOiByZXNwb25zZSBpbmRleCAgICA6IDExClsgICAgNS43OTU2ODBdIGR3
bW1jX2V4eW5vcyAxMjIyMDAwMC5tbWM6IDogZGF0YSBzdGF0ZSBtYyBidXN5OiAwClsgICAgNS44
MDE0OTJdIGR3bW1jX2V4eW5vcyAxMjIyMDAwMC5tbWM6IDogZGF0YSBidXN5ICAgICAgICAgOiAx
ClsgICAgNS44MDczMDNdIGR3bW1jX2V4eW5vcyAxMjIyMDAwMC5tbWM6IDogZGF0YSAzIHN0YXRl
ICAgICAgOiAwClsgICAgNS44MTMxMTZdIGR3bW1jX2V4eW5vcyAxMjIyMDAwMC5tbWM6IDogY29t
bWFuZCBmc20gc3RhdGUgOiAwClsgICAgNS44MTg5MjldIGR3bW1jX2V4eW5vcyAxMjIyMDAwMC5t
bWM6IDogZmlmbyBmdWxsICAgICAgICAgOiAwClsgICAgNS44MjQ3NDBdIGR3bW1jX2V4eW5vcyAx
MjIyMDAwMC5tbWM6IDogZmlmbyBlbXB0eSAgICAgICAgOiAxClsgICAgNS44MzA1NTNdIGR3bW1j
X2V4eW5vcyAxMjIyMDAwMC5tbWM6IDogZmlmbyB0eCB3YXRlcm1hcmsgOiAxClsgICAgNS44MzYz
NjVdIGR3bW1jX2V4eW5vcyAxMjIyMDAwMC5tbWM6IDogZmlmbyByeCB3YXRlcm1hcmsgOiAwClsg
ICAgNS44NDIxODJdIGR3bW1jX2V4eW5vcyAxMjIyMDAwMC5tbWM6IDogPT09PT09PT09PT09PT0g
U1RBVFVTIERVTVAgPT09PT09PT09PT09PT09PQpbICAgIDUuODQyMTg3XSBkd21tY19leHlub3Mg
MTIyMjAwMDAubW1jOiA6IGNtZF9zdGF0dXM6ICAgICAgMHgwMDAwMDAwMApbICAgIDUuODQyMTkz
XSBkd21tY19leHlub3MgMTIyMjAwMDAubW1jOiA6IGRhdGFfc3RhdHVzOiAgICAgMHgwMDAwMDAw
MApbICAgIDUuODQyMTk3XSBkd21tY19leHlub3MgMTIyMjAwMDAubW1jOiA6IHBlbmRpbmdfZXZl
bnRzOiAgMHgwMDAwMDAwMApbICAgIDUuODQyMjAyXSBkd21tY19leHlub3MgMTIyMjAwMDAubW1j
OiA6IGNvbXBsZXRlZF9ldmVudHM6MHgwMDAwMDAwMQpbICAgIDUuODQyMjExXSBkd21tY19leHlu
b3MgMTIyMjAwMDAubW1jOiA6IHN0YXRlOiAgICAgICAgICAgNwpbICAgIDUuODQyMjIwXSBkd21t
Y19leHlub3MgMTIyMjAwMDAubW1jOiA6ID09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT0KWyAgICA1Ljg0MjIzMF0gbW1jX2hvc3QgbW1jMTogVGltZW91dCBzZW5kaW5n
IGNvbW1hbmQgKGNtZCAweDIwMjAwMCBhcmcgMHgwIHN0YXR1cyAweDgwMjAyMDAwKQoKClUtQm9v
dCAyMDEzLjA0IChGZWIgMjEgMjAxNCAtIDE1OjI5OjEwKSBmb3IgUGVhY2gKCkNQVToJRXh5bm9z
NTQyMEA5MDBNSHoKCkJvYXJkOiBHb29nbGUgUGVhY2ggUGl0LCByZXYgNi4wCkkyQzogICByZWFk
eQpEUkFNOiAgMiBHaUIKUE1JQyBtYXg3NzgwMi1wbWljIGluaXRpYWxpemVkCkNQVToJRXh5bm9z
NTQyMEAxODAwTUh6ClRQUzY1MDkwIFBNSUMgRUMgaW5pdApNTUM6ICAgRVhZTk9TIERXTU1DOiAw
LCBFWFlOT1MgRFdNTUM6IDEKU0Y6IERldGVjdGVkIFcyNVEzMkRXIHdpdGggcGFnZSBzaXplIDQg
S2lCLCB0b3RhbCAzMiBNaUIKSW46ICAgIGNyb3MtZWMta2V5YgpPdXQ6ICAgbGNkCkVycjogICBs
Y2QKU0Y6IERldGVjdGVkIFcyNVEzMkRXIHdpdGggcGFnZSBzaXplIDQgS2lCLCB0b3RhbCAzMiBN
aUIKRUxPRzogRXZlbnQoMTcpIGFkZGVkIHdpdGggc2l6ZSAxMwpOZXQ6ICAgTm8gZXRoZXJuZXQg
Zm91bmQuCkhpdCBhbnkga2V5IHRvIHN0b3AgYXV0b2Jvb3Q6ICAzIAgICCAwIApFeHlub3MgRFAg
aW5pdCBkb25lClBlYWNoICMgClBlYWNoICMg
--047d7bea31d059b1ee04fd1feb97--
