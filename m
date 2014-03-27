From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH] mmc: core: Use maximum timeout values in case TACC field
 is zero
Date: Thu, 27 Mar 2014 12:41:32 -0300
Message-ID: <CAOMZO5C=Oo2CiAGf8YWJ5T8uV_5M+35_tumZQvKzccGjGeejhg@mail.gmail.com>
References: <1395934368-29207-1-git-send-email-stefan.wahren@i2se.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ve0-f181.google.com ([209.85.128.181]:47997 "EHLO
	mail-ve0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754638AbaC0Plc (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 27 Mar 2014 11:41:32 -0400
Received: by mail-ve0-f181.google.com with SMTP id oy12so4245447veb.26
        for <linux-mmc@vger.kernel.org>; Thu, 27 Mar 2014 08:41:32 -0700 (PDT)
In-Reply-To: <1395934368-29207-1-git-send-email-stefan.wahren@i2se.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Stefan Wahren <stefan.wahren@i2se.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, Chris Ball <chris@printf.net>, Otavio Salvador <otavio@ossystems.com.br>, Peter Chen <Peter.Chen@freescale.com>, Sascha Hauer <Kernel@pengutronix.de>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On Thu, Mar 27, 2014 at 12:32 PM, Stefan Wahren <stefan.wahren@i2se.com> wrote:
> When plugging a specific micro SD card at MMC socket of a custom i.MX28 board,
> we get the following kernel warning:
>
> WARNING: CPU: 0 PID: 30 at drivers/mmc/host/mxs-mmc.c:342 mxs_mmc_start_cmd+0x34c/0x378()
> Modules linked in:
> CPU: 0 PID: 30 Comm: kworker/u2:1 Not tainted 3.14.0-rc5 #8
> Workqueue: kmmcd mmc_rescan
> [<c0015420>] (unwind_backtrace) from [<c0012cb0>] (show_stack+0x10/0x14)
> [<c0012cb0>] (show_stack) from [<c001daf8>] (warn_slowpath_common+0x6c/0x8c)
> [<c001daf8>] (warn_slowpath_common) from [<c001db34>] (warn_slowpath_null+0x1c/0x24)
> [<c001db34>] (warn_slowpath_null) from [<c0349478>] (mxs_mmc_start_cmd+0x34c/0x378)
> [<c0349478>] (mxs_mmc_start_cmd) from [<c0338fa0>] (mmc_start_request+0xc4/0xf4)
> [<c0338fa0>] (mmc_start_request) from [<c03390b4>] (mmc_wait_for_req+0x50/0x164)
> [<c03390b4>] (mmc_wait_for_req) from [<c03405b8>] (mmc_app_send_scr+0x158/0x1c8)
> [<c03405b8>] (mmc_app_send_scr) from [<c033ee1c>] (mmc_sd_setup_card+0x80/0x3c8)
> [<c033ee1c>] (mmc_sd_setup_card) from [<c033f788>] (mmc_sd_init_card+0x124/0x66c)
> [<c033f788>] (mmc_sd_init_card) from [<c033fd7c>] (mmc_attach_sd+0xac/0x174)
> [<c033fd7c>] (mmc_attach_sd) from [<c033a658>] (mmc_rescan+0x25c/0x2d8)
> [<c033a658>] (mmc_rescan) from [<c003597c>] (process_one_work+0x1b4/0x4ec)
> [<c003597c>] (process_one_work) from [<c0035de4>] (worker_thread+0x130/0x464)
> [<c0035de4>] (worker_thread) from [<c003c824>] (kthread+0xb4/0xd0)
> [<c003c824>] (kthread) from [<c000f420>] (ret_from_fork+0x14/0x34)
>
> The error is due to an invalid value in CSD register of a specific 2GB micro
> SD card. The CSD version of this card is 1.0 but the TACC field has the invalid
> value 0. Since the kernel is making use of this TACC field to calculate the
> SD card timeout, an invalid value 0 leads to a warning at mxs_ns_to_ssp_ticks()
> and later the following misleading error messages appears in a loop:
>
> mxs-mmc 80010000.ssp: card claims to support voltages below defined range
> mxs-mmc 80010000.ssp: no support for card's volts
> mmc0: error -22 whilst initialising MMC card
>
> This error is only found on this 2GB SD card on mxs platform.
> On x86 this card works without any problems.

Thanks for the patch, Stefan.

>
> The following patch based on the work of Peter Chen and Otavio Salvador. It

It was Peter Chan, not Peter Chen.

Regards,

Fabio Estevam
