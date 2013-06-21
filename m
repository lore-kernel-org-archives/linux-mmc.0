From: Grant Grundler <grundler@chromium.org>
Subject: Re: mmc_rescan/sdio_reset timeout missing?
Date: Thu, 20 Jun 2013 17:39:22 -0700
Message-ID: <CANEJEGvMjqSj26C2c_rWdG+oqQMnqjASSsWZwZz1+O732kpU3w@mail.gmail.com>
References: <CANEJEGsPrkGwZVpK8bfYUyVYN2gfk2fbqs7D4DFaz5GhRaZRcw@mail.gmail.com>
	<51C261AE.5020507@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ve0-f176.google.com ([209.85.128.176]:44067 "EHLO
	mail-ve0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758204Ab3FUAjX (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 20 Jun 2013 20:39:23 -0400
Received: by mail-ve0-f176.google.com with SMTP id c13so5628756vea.21
        for <linux-mmc@vger.kernel.org>; Thu, 20 Jun 2013 17:39:22 -0700 (PDT)
In-Reply-To: <51C261AE.5020507@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Grant Grundler <grundler@chromium.org>, linux-mmc <linux-mmc@vger.kernel.org>, Seungwon Jeon <tgih.jun@samsung.com>

Hi Jaehoon!

Thanks for responding...apologies for not answering sooner.


On Wed, Jun 19, 2013 at 6:58 PM, Jaehoon Chung <jh80.chung@samsung.com> wrote:
> Hi Grant,
>
> Which kernel-version do you use?

ChromeOS R29 - based on 3.4 kernel.  Current code (linus 3.10-rc6)
seems to have the same issues (patches for RFC below):

1) change log comments for sh_mmcif driver say "CMD52 should be
ignored by SD/eMMC cards"
 Then why send CMD52 to non-SDIO devices?

2) mmc_wait_for_cmd() is passed "retries" parameter of 0 which means
infinite retries. That's not robust.

3) Every command sent should have a timeout. Stuff fails. Especially
cheap, common IO devices.


> And i want to know the controller IP version.

I'm not sure what you are asking for here.
This is for Exynos 5250 part used in Samsung Chromebook (aka "SNOW").

Here is the boot output and maybe that contains what you are looking for.
[    1.445377] Synopsys Designware Multimedia Card Interface Driver
[    1.445481] dw_mmc dw_mmc.0: Using internal DMA controller.
[    1.445493] dw_mmc dw_mmc.0: Version ID is 241a
[    1.445614] dw_mmc dw_mmc.0: DW MMC controller at irq 107, 32 bit
host data width, 128 deep fifo
[    1.445741] dw_mmc dw_mmc.0: wp gpio not available
[    1.445762] mmc0: no vmmc regulator found
[    1.446940] dw_mmc dw_mmc.2: Using internal DMA controller.
[    1.446952] dw_mmc dw_mmc.2: Version ID is 241a
[    1.447047] dw_mmc dw_mmc.2: DW MMC controller at irq 109, 32 bit
host data width, 128 deep fifo
[    1.447131] mmc1: no vmmc regulator found
[    1.448277] dw_mmc dw_mmc.3: Using internal DMA controller.
[    1.448288] dw_mmc dw_mmc.3: Version ID is 241a
[    1.448383] dw_mmc dw_mmc.3: DW MMC controller at irq 110, 32 bit
host data width, 128 deep fifo
[    1.448450] dw_mmc dw_mmc.3: wp gpio not available
[    1.448458] dw_mmc dw_mmc.3: cd gpio not available
[    1.448468] mmc2: no vmmc regulator found
[    1.449727] usbcore: registered new interface driver usbhid
[    1.449734] usbhid: USB HID core driver
[    1.475549] mmc_host mmc0: Bus speed (slot 0) = 100000000Hz (slot
req 784314Hz, actual 781250HZ div = 64)
[    1.485010] sdio_reset: Abort1 0 Abort2 0

>
> CC'd to Seungwon.

thanks!

RFC - please let me know if I should submit any of these formally:

1) don't send CMD52 to non-SDIO cards (Cut/pasted this...sorry about
white spaces):
--- a/drivers/mmc/core/sdio_ops.c
+++ b/drivers/mmc/core/sdio_ops.c
@@ -209,6 +209,10 @@ int sdio_reset(struct mmc_host *host)
        int ret;
        u8 abort;

+       /* SD and MMC cards will ignore this reset. So don't bother. */
+       if (host->card && !mmc_card_sdio(host->card))
+               return 0;
+
        /* SDIO Simplified Specification V2.0, 4.4 Reset for SDIO */

        ret = mmc_io_rw_direct_host(host, 0, 0, SDIO_CCCR_ABORT, 0, &abort);


2) Don't retry any command forever.

+++ b/drivers/mmc/core/sdio_ops.c
@@ -86,7 +86,7 @@ static int mmc_io_rw_direct_host(struct mmc_host *host, int wr
        cmd.arg |= in;
        cmd.flags = MMC_RSP_SPI_R5 | MMC_RSP_R5 | MMC_CMD_AC;

-       err = mmc_wait_for_cmd(host, &cmd, 0);
+       err = mmc_wait_for_cmd(host, &cmd, 3);
        if (err)
                return err;

3) Use a timeout if one is provided for cmd (or preferably, don't make
it optional):
+++ b/drivers/mmc/core/sdio_ops.c
@@ -85,8 +85,9 @@ static int mmc_io_rw_direct_host(struct mmc_host
*host, int write, unsigned fn,
        cmd.arg |= addr << 9;
        cmd.arg |= in;
        cmd.flags = MMC_RSP_SPI_R5 | MMC_RSP_R5 | MMC_CMD_AC;
+       cmd.cmd_timeout_ms = 100;   /* no direct cmd should take this long */

(The caller should be passing the timeout as a parameter)

+++ b/drivers/mmc/core/core.c
@@ -268,9 +268,12 @@ static void mmc_wait_for_req_done(struct mmc_host *host,
        struct mmc_command *cmd;

        while (1) {
-               wait_for_completion(&mrq->completion);
-
                cmd = mrq->cmd;
+               if (cmd->cmd_timeout_ms)
+                       wait_for_completion_timeout(&mrq->completion,
+                                       (HZ * cmd->cmd_timeout_ms) / 1000;
+               else
+                       wait_for_completion(&mrq->completion);
                if (!cmd->error || !cmd->retries ||
                    mmc_card_removed(host->card))
                        break;


Thanks!
grant


>
> On 06/19/2013 10:44 PM, Grant Grundler wrote:
>> I've looking through the code to understand this bug that caused this
>> stack trace (and ended up panicing below):
>>
>> <3>[ 1680.501338] INFO: task kworker/u:22:9101 blocked for more than
>> 120 seconds.
>> <3>[ 1680.501348] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
>> disables this message.
>> <6>[ 1680.501357] kworker/u:22    D 8050644c     0  9101      2 0x00000000
>> <5>[ 1680.501385] [<8050644c>] (__schedule+0x608/0x758) from
>> [<80506938>] (schedule+0x94/0x98)
>> <5>[ 1680.501399] [<80506938>] (schedule+0x94/0x98) from [<80504830>]
>> (schedule_timeout+0x38/0x2d0)
>> <5>[ 1680.501413] [<80504830>] (schedule_timeout+0x38/0x2d0) from
>> [<80506788>] (wait_for_common+0x138/0x178)
>> <5>[ 1680.501427] [<80506788>] (wait_for_common+0x138/0x178) from
>> [<805068a0>] (wait_for_completion+0x20/0x24)
>> <5>[ 1680.501442] [<805068a0>] (wait_for_completion+0x20/0x24) from
>> [<803bc424>] (mmc_wait_for_req_done+0x2c/0x84)
>> <5>[ 1680.501455] [<803bc424>] (mmc_wait_for_req_done+0x2c/0x84) from
>> [<803bc8e8>] (mmc_wait_for_req+0x2c/0x30)
>> <5>[ 1680.501468] [<803bc8e8>] (mmc_wait_for_req+0x2c/0x30) from
>> [<803bc968>] (mmc_wait_for_cmd+0x7c/0x8c)
>> <5>[ 1680.501481] [<803bc968>] (mmc_wait_for_cmd+0x7c/0x8c) from
>> [<803c4fe4>] (mmc_io_rw_direct_host+0xc8/0x138)
>> <5>[ 1680.501496] [<803c4fe4>] (mmc_io_rw_direct_host+0xc8/0x138) from
>> [<803c5440>] (sdio_reset+0x38/0x74)
>> <5>[ 1680.501508] [<803c5440>] (sdio_reset+0x38/0x74) from
>> [<803be330>] (mmc_rescan+0x214/0x2c0)
>> <5>[ 1680.501523] [<803be330>] (mmc_rescan+0x214/0x2c0) from
>> [<80045b04>] (process_one_work+0x210/0x424)
>> <5>[ 1680.501536] [<80045b04>] (process_one_work+0x210/0x424) from
>> [<80046128>] (worker_thread+0x1f0/0x39c)
>> <5>[ 1680.501549] [<80046128>] (worker_thread+0x1f0/0x39c) from
>> [<8004acc0>] (kthread+0x9c/0xac)
>> <5>[ 1680.501563] [<8004acc0>] (kthread+0x9c/0xac) from [<8000ee48>]
>> (kernel_thread_exit+0x0/0x8)
>> <0>[ 1680.501573] Kernel panic - not syncing: hung_task: blocked tasks
>> <5>[ 1680.501586] [<80014890>] (unwind_backtrace+0x0/0xec) from
>> [<80500018>] (dump_stack+0x20/0x24)
>> <5>[ 1680.501597] [<80500018>] (dump_stack+0x20/0x24) from
>> [<80500178>] (panic+0x98/0x1e0)
>> <5>[ 1680.501610] [<80500178>] (panic+0x98/0x1e0) from [<80082658>]
>> (watchdog+0x1e8/0x24c)
>> <5>[ 1680.501621] [<80082658>] (watchdog+0x1e8/0x24c) from
>> [<8004acc0>] (kthread+0x9c/0xac)
>> <5>[ 1680.501633] [<8004acc0>] (kthread+0x9c/0xac) from [<8000ee48>]
>> (kernel_thread_exit+0x0/0x8)
>>
>> I don't see any timers being set in any code path for the calls to
>> mmc_io_rw_direct_host(host,... SDIO_CCCR_ABORT...) in sdio_reset()
>> doesn't complete. I was thinking cmd_timeout_ms could be used but eMMC
>> (dw_mmc driver) only appears to support data_timeout and
>> response_timeout, not a cmd timeout. And even if dw_mmc did support
>> that timeout in HW, cmd_timeout_ms isn't getting set in this code
>> path.
>>
>> Any advice on how that should be fixed?
>>
>> I'm assuming the eMMC device (Sandisk SEM16G - eMMC 4.41) has buggy FW
>> and just wedges after a suspend/resume.
>>
>> cheers,
>> grant
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
