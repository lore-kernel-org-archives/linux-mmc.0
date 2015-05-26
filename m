From: Alim Akhtar <alim.akhtar@gmail.com>
Subject: Re: [PATCH] mmc: dw_mmc: Wait for data transfer after response errors
Date: Tue, 26 May 2015 23:32:52 +0530
Message-ID: <CAGOxZ53WfNbaMe0_AM0qBqU47kAfgmPBVZC8K8Y-_J3mDMqW4A@mail.gmail.com>
References: <1431964402-27457-1-git-send-email-dianders@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qg0-f49.google.com ([209.85.192.49]:34741 "EHLO
	mail-qg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751043AbbEZSDd (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 26 May 2015 14:03:33 -0400
In-Reply-To: <1431964402-27457-1-git-send-email-dianders@chromium.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Doug Anderson <dianders@chromium.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Seungwon Jeon <tgih.jun@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>, Alim Akhtar <alim.akhtar@samsung.com>, Sonny Rao <sonnyrao@chromium.org>, Andrew Bresticker <abrestic@chromium.org>, Heiko Stuebner <heiko@sntech.de>, Addy Ke <addy.ke@rock-chips.com>, Alexandru Stan <amstan@chromium.org>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, Chris Zhong <zyw@rock-chips.com>, Caesar Wang <wxt@rock-chips.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hi Doug,
On peach-pi, I got a hung task once in 4 cold boot as [1].
And every time got a hung task [2] on suspend/resume, triggered
exactly from this change. I have a debug print at $SUBJECT change.
[1]:
----------------
on boot:
[  240.197190] INFO: task kworker/u16:1:50 blocked for more than 120 seconds.
[  240.202602]       Not tainted 4.1.0-rc5-00001-g862e58a-dirty #6
[  240.208505] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[  240.216307] kworker/u16:1   D c0505528     0    50      2 0x00000000
[  240.222650] Workqueue: kmmcd mmc_rescan
[  240.226448] [<c0505528>] (__schedule) from [<c0505924>] (schedule+0x34/0x98)
[  240.233496] [<c0505924>] (schedule) from [<c0509274>]
(schedule_timeout+0x110/0x164)
[  240.241207] [<c0509274>] (schedule_timeout) from [<c0506258>]
(wait_for_common+0xb8/0x14c)
[  240.249454] [<c0506258>] (wait_for_common) from [<c03b2b5c>]
(mmc_wait_for_req+0xb0/0x13c)
[  240.257691] [<c03b2b5c>] (mmc_wait_for_req) from [<c03b8684>]
(mmc_send_tuning+0x140/0x1b0)
[  240.266026] [<c03b8684>] (mmc_send_tuning) from [<c03cd45c>]
(dw_mci_exynos_execute_tuning+0x70/0x174)
[  240.275299] [<c03cd45c>] (dw_mci_exynos_execute_tuning) from
[<c03c97f0>] (dw_mci_execute_tuning+0x2c/0x38)
[  240.285021] [<c03c97f0>] (dw_mci_execute_tuning) from [<c03b3e90>]
(mmc_execute_tuning+0x30/0x60)
[  240.293864] [<c03b3e90>] (mmc_execute_tuning) from [<c03b6fe4>]
(mmc_init_card+0x8e0/0x1648)
[  240.302283] [<c03b6fe4>] (mmc_init_card) from [<c03b801c>]
(mmc_attach_mmc+0x90/0x15c)
[  240.310172] [<c03b801c>] (mmc_attach_mmc) from [<c03b4cf4>]
(mmc_rescan+0x29c/0x2e4)
[  240.317903] [<c03b4cf4>] (mmc_rescan) from [<c00342a0>]
(process_one_work+0x120/0x324)
[  240.325788] [<c00342a0>] (process_one_work) from [<c0034500>]
(worker_thread+0x28/0x490)
[  240.333861] [<c0034500>] (worker_thread) from [<c0039324>]
(kthread+0xd8/0xf4)
[  240.341058] [<c0039324>] (kthread) from [<c000f5a0>]
(ret_from_fork+0x14/0x34)
-----------


[2]: On s2r cycle:
========
[   71.107181] mmc_host mmc0: Bus speed (slot 0) = 50000000Hz (slot
req 400000Hz, actual 396825HZ div = 63)
[   71.147363] mmc_host mmc0: Bus speed (slot 0) = 200000000Hz (slot
req 200000000Hz, actual 200000000HZ div = 0)


[   71.155946] dwmmc_exynos 12200000.mmc: [ALIM] :
dw_mci_tasklet_func: 1593: cmd->data and err


[  240.197177] INFO: task sh:1645 blocked for more than 120 seconds.
[  240.201802]       Not tainted 4.1.0-rc5-00001-g862e58a-dirty #6
[  240.207713] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[  240.215518] sh              D c0505528     0  1645      1 0x00000000
[  240.221857] [<c0505528>] (__schedule) from [<c0505924>] (schedule+0x34/0x98)
[  240.228887] [<c0505924>] (schedule) from [<c0509274>]
(schedule_timeout+0x110/0x164)
[  240.236606] [<c0509274>] (schedule_timeout) from [<c0506258>]
(wait_for_common+0xb8/0x14c)
[  240.244851] [<c0506258>] (wait_for_common) from [<c03b2b5c>]
(mmc_wait_for_req+0xb0/0x13c)
[  240.253090] [<c03b2b5c>] (mmc_wait_for_req) from [<c03b8684>]
(mmc_send_tuning+0x140/0x1b0)
[  240.261417] [<c03b8684>] (mmc_send_tuning) from [<c03cd45c>]
(dw_mci_exynos_execute_tuning+0x70/0x174)
[  240.270699] [<c03cd45c>] (dw_mci_exynos_execute_tuning) from
[<c03c97f0>] (dw_mci_execute_tuning+0x2c/0x38)
[  240.280415] [<c03c97f0>] (dw_mci_execute_tuning) from [<c03b3e90>]
(mmc_execute_tuning+0x30/0x60)
[  240.289263] [<c03b3e90>] (mmc_execute_tuning) from [<c03b6fe4>]
(mmc_init_card+0x8e0/0x1648)
[  240.297675] [<c03b6fe4>] (mmc_init_card) from [<c03b7d98>]
(_mmc_resume+0x4c/0x78)
[  240.305222] [<c03b7d98>] (_mmc_resume) from [<c03b7e8c>]
(mmc_resume+0x1c/0x58)
[  240.312508] [<c03b7e8c>] (mmc_resume) from [<c03b5128>]
(mmc_bus_resume+0x1c/0x50)
[  240.320060] [<c03b5128>] (mmc_bus_resume) from [<c02c0008>]
(dpm_run_callback.isra.8+0x1c/0x48)
[  240.328736] [<c02c0008>] (dpm_run_callback.isra.8) from
[<c02c00e0>] (device_resume+0xac/0x180)
[  240.337436] [<c02c00e0>] (device_resume) from [<c02c1358>]
(dpm_resume+0xe8/0x210)
[  240.344957] [<c02c1358>] (dpm_resume) from [<c02c161c>]
(dpm_resume_end+0xc/0x18)
[  240.352419] [<c02c161c>] (dpm_resume_end) from [<c00577f8>]
(suspend_devices_and_enter+0x10c/0x3e4)
[  240.361437] [<c00577f8>] (suspend_devices_and_enter) from
[<c0057c38>] (pm_suspend+0x168/0x208)
[  240.370110] [<c0057c38>] (pm_suspend) from [<c00568e0>]
(state_store+0x6c/0xbc)
[  240.377400] [<c00568e0>] (state_store) from [<c01f6ac8>]
(kobj_attr_store+0x14/0x20)
[  240.385123] [<c01f6ac8>] (kobj_attr_store) from [<c012215c>]
(sysfs_kf_write+0x44/0x48)
[  240.393103] [<c012215c>] (sysfs_kf_write) from [<c01217d0>]
(kernfs_fop_write+0xb8/0x194)
[  240.401257] [<c01217d0>] (kernfs_fop_write) from [<c00c91a4>]
(__vfs_write+0x2c/0xd8)
[  240.409064] [<c00c91a4>] (__vfs_write) from [<c00ca05c>]
(vfs_write+0x90/0x14c)
[  240.416350] [<c00ca05c>] (vfs_write) from [<c00ca2e4>] (SyS_write+0x40/0x8c)
[  240.423378] [<c00ca2e4>] (SyS_write) from [<c000f500>]
(ret_fast_syscall+0x0/0x34)
====

I was checking on v4.1-rc5, git hash as below:

862e58a mmc: dw_mmc: Wait for data transfer after response errors
ba155e2 Linux 4.1-rc5
5b13966

Not sure if I missed any dependent patch??
Have not checked the dw TRM for this change, will do that as soon as I
get access to it.

Regards,
Alim


On Mon, May 18, 2015 at 9:23 PM, Doug Anderson <dianders@chromium.org> wrote:
> According to the DesignWare state machine description, after we get a
> "response error" or "response CRC error" we move into data transfer
> mode.  That means that we don't necessarily need to special case
> trying to deal with the failure right away.  We can wait until we are
> notified that the data transfer is complete (with or without errors)
> and then we can deal with the failure.
>
> It may sound strange to defer dealing with a command that we know will
> fail anyway, but this appears to fix a bug.  During tuning (CMD19) on
> a specific card on an rk3288-based system, we found that we could get
> a "response CRC error".  Sending the stop command after the "response
> CRC error" would then throw the system into a confused state causing
> all future tuning phases to report failure.
>
> When in the confused state, the controller would show these (hex codes
> are interrupt status register):
>  CMD ERR: 0x00000046 (cmd=19)
>  CMD ERR: 0x0000004e (cmd=12)
>  DATA ERR: 0x00000208
>  DATA ERR: 0x0000020c
>  CMD ERR: 0x00000104 (cmd=19)
>  CMD ERR: 0x00000104 (cmd=12)
>  DATA ERR: 0x00000208
>  DATA ERR: 0x0000020c
>  ...
>  ...
>
> It is inherently difficult to deal with the complexity of trying to
> correctly send a stop command while a data transfer is taking place
> since you need to deal with different corner cases caused by the fact
> that the data transfer could complete (with errors or without errors)
> during various places in sending the stop command (dw_mci_stop_dma,
> send_stop_abort, etc)
>
> Instead of adding a bunch of extra complexity to deal with this, it
> seems much simpler to just use the more straightforward (and less
> error-prone) path of letting the data transfer finish.  There
> shouldn't be any huge benefit to sending the stop command slightly
> earlier, anyway.
>
> Signed-off-by: Doug Anderson <dianders@chromium.org>
> ---
>  drivers/mmc/host/dw_mmc.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 5f5adaf..c081ce2 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -1574,6 +1574,26 @@ static void dw_mci_tasklet_func(unsigned long priv)
>                         }
>
>                         if (cmd->data && err) {
> +                               /*
> +                                * Controller will move into a data transfer
> +                                * state after a response error or response CRC
> +                                * error.  Let's let that finish before trying
> +                                * to send a stop, so we'll go to
> +                                * STATE_SENDING_DATA.
> +                                *
> +                                * Although letting the data transfer take place
> +                                * will waste a bit of time (we already know
> +                                * the command was bad), it can't cause any
> +                                * errors since it's possible it would have
> +                                * taken place anyway if this tasklet got
> +                                * delayed.  Allowing the transfer to take place
> +                                * avoids races and keeps things simple.
> +                                */
> +                               if (err != -ETIMEDOUT) {
> +                                       state = STATE_SENDING_DATA;
> +                                       continue;
> +                               }
> +
>                                 dw_mci_stop_dma(host);
>                                 send_stop_abort(host, data);
>                                 state = STATE_SENDING_STOP;
> --
> 2.2.0.rc0.207.ga3a616c
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Regards,
Alim
