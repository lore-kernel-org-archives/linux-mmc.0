From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: core: resolve divded by zero panic
Date: Fri, 29 Aug 2014 13:26:46 +0200
Message-ID: <CAPDyKFrSZhA=77ECWEgmHiYn2gQZjLVzUxF9aWU=8o8=rVk3nQ@mail.gmail.com>
References: <1408012164-29790-1-git-send-email-yunpeng.gao@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-la0-f44.google.com ([209.85.215.44]:62326 "EHLO
	mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751461AbaH2L0s (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 29 Aug 2014 07:26:48 -0400
Received: by mail-la0-f44.google.com with SMTP id hz20so2541542lab.17
        for <linux-mmc@vger.kernel.org>; Fri, 29 Aug 2014 04:26:46 -0700 (PDT)
In-Reply-To: <1408012164-29790-1-git-send-email-yunpeng.gao@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Yunpeng Gao <yunpeng.gao@intel.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chuanxiao Dong <chuanxiao.dong@intel.com>

On 14 August 2014 12:29, Yunpeng Gao <yunpeng.gao@intel.com> wrote:
> From: Chuanxiao Dong <chuanxiao.dong@intel.com>
>
> With one special SD card, below divide by zero error observed:
> ...
> [    2.144300] divide error: 0000 [#1] PREEMPT SMP
> [    2.148860] Modules linked in:
> [    2.151898]
> [    2.152685] Set up 4031 stolen pages starting at 0x0001f000, GTT offset 0K
> [    2.157330] Set up 0 CI stolen pages starting at 0x00000000, GTT offset 131072K
> [    2.167581] Pid: 5, comm: kworker/u:0 Not tainted 3.0.8-138216-g974a2ab #1
> [    2.169506] [drm] PSB GTT mem manager ready, tt_start 4031, tt_size 28737 pages
> [    2.169906] [drm] SGX core id = 0x00000000
> [    2.169920] [drm] SGX core rev major = 0x00, minor = 0x00
> [    2.169934] [drm] SGX core rev maintenance = 0x00, designer = 0x00
> [    2.197370]  Intel Corporation Medfield/iCDKB
> [    2.201716] EIP: 0060:[<c1697ca6>] EFLAGS: 00010246 CPU: 1
> [    2.207198] EIP is at mmc_init_erase+0x76/0x150
> [    2.211704] EAX: 00002000 EBX: dcd1b400 ECX: 00002000 EDX: 00000000
> [    2.217957] ESI: 00000000 EDI: dcd5c800 EBP: dd867e84 ESP: dd867e7c
> [    2.224214]  DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068
> [    2.229605] Process kworker/u:0 (pid: 5, ti=dd866000 task=dd868000 task.ti=dd866000)
> [    2.237325] Stack:
> [    2.239322]  dcd1b400 00000000 dd867eb0 c16a06da c1ab7c44 dd995aa8 00000003 00000000
> [    2.247054]  00000000 00000000 dcd5c800 00000000 dcd1b400 dd867ef8 c16a1012 c1698b00
> [    2.254785]  00000029 00000001 c194eb80 dcd5c9ec dd867e00 c1239b00 00000000 00000000
> [    2.262519] Call Trace:
> [    2.264975]  [<c16a06da>] mmc_sd_setup_card+0x1da/0x4f0
> [    2.270183]  [<c16a1012>] mmc_sd_init_card+0x192/0xc40
> [    2.275304]  [<c1698b00>] ? __mmc_claim_host+0x160/0x160
> [    2.280610]  [<c1239b00>] ? __schedule_bug+0x50/0x80
> [    2.285556]  [<c16a1b89>] mmc_attach_sd+0xc9/0x230
> [    2.290333]  [<c169b6ef>] mmc_rescan+0x25f/0x2c0
> [    2.294943]  [<c1274223>] process_one_work+0x103/0x400
> [    2.300065]  [<c12670fd>] ? mod_timer+0x1ad/0x3c0
> [    2.304756]  [<c169b490>] ? mmc_suspend_host+0x1a0/0x1a0
> [    2.310056]  [<c127502d>] worker_thread+0x12d/0x4a0
> [    2.314921]  [<c18fcfbd>] ? preempt_schedule+0x2d/0x50
> [    2.320047]  [<c1274f00[    2.323976] ---[ end trace 5398ec2720494438 ]---
> ...
>
> So, seems this bad SD card does not set valid value in related SSR / CSD register fields.
> And then the driver will set card->erase_size to 0.
> Then it triggered this divided by zero error when calculate card->pref_erase.
>
> Submit this patch to fix the issue.
>
> Signed-off-by: Yunpeng Gao <yunpeng.gao@intel.com>
> Signed-off-by: Chuanxiao Dong <chuanxiao.dong@intel.com>

Thanks! Applied for next.

Kind regards
Uffe

> ---
>  drivers/mmc/core/core.c |    5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 7dc0c85..385373db 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -1761,7 +1761,7 @@ void mmc_init_erase(struct mmc_card *card)
>                 card->erase_shift = ffs(card->ssr.au) - 1;
>         } else if (card->ext_csd.hc_erase_size) {
>                 card->pref_erase = card->ext_csd.hc_erase_size;
> -       } else {
> +       } else if (card->erase_size) {
>                 sz = (card->csd.capacity << (card->csd.read_blkbits - 9)) >> 11;
>                 if (sz < 128)
>                         card->pref_erase = 512 * 1024 / 512;
> @@ -1778,7 +1778,8 @@ void mmc_init_erase(struct mmc_card *card)
>                         if (sz)
>                                 card->pref_erase += card->erase_size - sz;
>                 }
> -       }
> +       } else
> +               card->pref_erase = 0;
>  }
>
>  static unsigned int mmc_mmc_erase_timeout(struct mmc_card *card,
> --
> 1.7.9.5
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
