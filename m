From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: timeout waiting for hardware interrupt CMD19
Date: Fri, 30 Jun 2017 10:56:48 +0200
Message-ID: <CAMuHMdU_8h1U1RSotxHJbjU1QWX+J=RTA59qSZ_fV0CA12eLpQ@mail.gmail.com>
References: <CAMuHMdWHJvKv_Kva0LWL_hekGgkZdR=FHcOdoShpMtzQuXhD2g@mail.gmail.com>
 <20170313111249.cslock3xcupvxmu7@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20170313111249.cslock3xcupvxmu7@ninjato>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Simon Horman <horms@verge.net.au>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Linux MMC List <linux-mmc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

Hi Wolfram,

On Mon, Mar 13, 2017 at 12:12 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
>> +sh_mobile_sdhi ee100000.sd: timeout waiting for hardware interrupt (CMD19)
>> +sh_mobile_sdhi ee100000.sd: timeout waiting for hardware interrupt (CMD19)
>> +sh_mobile_sdhi ee100000.sd: Tuning procedure failed
>> +mmc1: tuning execution failed: -110
>> +mmc1: error -110 whilst initialising SD card
>
> Thanks! We have some tuning fixes in the queue. Let's see if they help
> here...

With renesas-drivers-2017-06-27-v4.12-rc7 on ALT:

sh_mobile_sdhi ee100000.sd: timeout waiting for hardware interrupt (CMD19)
sh_mobile_sdhi ee100000.sd: timeout waiting for hardware interrupt (CMD19)
sh_mobile_sdhi ee100000.sd: Tuning procedure failed
mmc1: tuning execution failed: -110
mmc1: error -110 whilst initialising SD card
random: fast init done
sh_mobile_sdhi ee100000.sd: timeout waiting for hardware interrupt (CMD19)
sh_mobile_sdhi ee100000.sd: timeout waiting for hardware interrupt (CMD19)
sh_mobile_sdhi ee100000.sd: Tuning procedure failed
mmc1: tuning execution failed: -110
mmc1: error -110 whilst initialising SD card
sh_mobile_sdhi ee100000.sd: timeout waiting for hardware interrupt (CMD19)
sh_mobile_sdhi ee100000.sd: timeout waiting for hardware interrupt (CMD19)
sh_mobile_sdhi ee100000.sd: Tuning procedure failed
mmc1: tuning execution failed: -110
mmc1: error -110 whilst initialising SD card
sh_mobile_sdhi ee100000.sd: timeout waiting for hardware interrupt (CMD19)
sh_mobile_sdhi ee100000.sd: timeout waiting for hardware interrupt (CMD19)
sh_mobile_sdhi ee100000.sd: Tuning procedure failed
mmc1: tuning execution failed: -110
mmc1: error -110 whilst initialising SD card
------------[ cut here ]------------
WARNING: CPU: 0 PID: 19 at lib/dma-debug.c:519 add_dma_entry+0xfc/0x148
DMA-API: exceeded 7 overlapping mappings of cacheline 0x0000000001b97cca
Modules linked in:
CPU: 0 PID: 19 Comm: kworker/0:1 Not tainted 4.12.0-rc7-rcar2-initrd #37
Hardware name: Generic R-Car Gen2 (Flattened Device Tree)
Workqueue: events_freezable mmc_rescan
[<c020e4ac>] (unwind_backtrace) from [<c0209fa8>] (show_stack+0x10/0x14)
[<c0209fa8>] (show_stack) from [<c03ebab8>] (dump_stack+0x7c/0x9c)
[<c03ebab8>] (dump_stack) from [<c021ff74>] (__warn+0xcc/0xfc)
[<c021ff74>] (__warn) from [<c021ffd8>] (warn_slowpath_fmt+0x34/0x44)
[<c021ffd8>] (warn_slowpath_fmt) from [<c0409798>] (add_dma_entry+0xfc/0x148)
[<c0409798>] (add_dma_entry) from [<c0409a44>] (debug_dma_map_sg+0x140/0x168)
[<c0409a44>] (debug_dma_map_sg) from [<c0592704>]
(renesas_sdhi_sys_dmac_start_dma+0x194/0x550)
[<c0592704>] (renesas_sdhi_sys_dmac_start_dma) from [<c05909dc>]
(tmio_process_mrq+0x15c/0x3b8)
[<c05909dc>] (tmio_process_mrq) from [<c057ecb4>]
(mmc_start_request+0x11c/0x128)
[<c057ecb4>] (mmc_start_request) from [<c057ed38>] (mmc_wait_for_req+0x78/0xdc)
[<c057ed38>] (mmc_wait_for_req) from [<c0584a70>] (mmc_send_tuning+0xe0/0x148)
[<c0584a70>] (mmc_send_tuning) from [<c058fd30>]
(tmio_mmc_execute_tuning+0xcc/0x160)
[<c058fd30>] (tmio_mmc_execute_tuning) from [<c057fcec>]
(mmc_execute_tuning+0x30/0x68)
[<c057fcec>] (mmc_execute_tuning) from [<c0586b00>]
(mmc_sd_init_card+0x5c4/0x62c)
[<c0586b00>] (mmc_sd_init_card) from [<c0586cbc>] (mmc_attach_sd+0xa4/0x130)
[<c0586cbc>] (mmc_attach_sd) from [<c0580bf4>] (mmc_rescan+0x2fc/0x340)
[<c0580bf4>] (mmc_rescan) from [<c0234658>] (process_one_work+0x1cc/0x30c)
[<c0234658>] (process_one_work) from [<c02347c0>]
(process_scheduled_works+0x28/0x30)
[<c02347c0>] (process_scheduled_works) from [<c0234d9c>]
(worker_thread+0x2e0/0x3e0)
[<c0234d9c>] (worker_thread) from [<c0239088>] (kthread+0x134/0x150)
[<c0239088>] (kthread) from [<c0206ba8>] (ret_from_fork+0x14/0x2c)
---[ end trace e899ede79c440525 ]---

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
