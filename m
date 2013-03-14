From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: RE: Trouble suspending with
 "mmc: queue: exclude asynchronous transfer for special request"
Date: Thu, 14 Mar 2013 13:22:40 +0900
Message-ID: <000c01ce206b$9150bc60$b3f23520$%jun@samsung.com>
References: <CA+20K0Bzbg3m0TvgRgk8Fsuqdc1keqyGuY6y1-M8mp7chPR2+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=Windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:42122 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751844Ab3CNEWo (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 14 Mar 2013 00:22:44 -0400
Received: from epcpsbgr3.samsung.com
 (u143.gpu120.samsung.co.kr [203.254.230.143])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MJM00JAHUTT9V70@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Thu, 14 Mar 2013 13:22:42 +0900 (KST)
In-reply-to: <CA+20K0Bzbg3m0TvgRgk8Fsuqdc1keqyGuY6y1-M8mp7chPR2+A@mail.gmail.com>
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Johan Rudholm' <jrudholm@gmail.com>
Cc: linux-mmc@vger.kernel.org, 'Konstantin Dorfman' <kdorfman@codeaurora.org>, 'Chris Ball' <cjb@laptop.org>

Hi Johan,

Thursday, March 14, 2013, Johan Rudholm wrote:
> Hi Seungwon,
> 
> we've just backported mmc-related patches from 3.9rc1 to our internal
> tree, and I'm seeing an issue with:
> 
> 369d321 mmc: queue: exclude asynchronous transfer for special request
> 
> When the device is going into suspend, it seems that mmcqd still has
> claimed the host and so the 20s DPM device timeout happens, and we get
> a kernel BUG:
> 
> [   42.049865] PM: Syncing filesystems ... done.
> [   42.058044] Freezing user space processes ... (elapsed 0.03 seconds) done.
> [   42.098937] Freezing remaining freezable tasks ... (elapsed 0.01
> seconds) done.
> [   42.118988] Suspending console(s) (use no_console_suspend to debug)
> [   42.129455] alarmtimer alarmtimer: Next rtc wakeup 2000.01.04 - 19:48:10
> [   42.155517] regulator regulator.24: VEXTSUPPLY3-disable (bank, reg,
> mask, value): 0x04, 0x08, 0x30, 0x00
> [   54.185241] **** DPM device timeout: sdi2 (mmci-pl18x)
> [   54.185241] dpm suspend stack:
> [   54.185302] [<c071276c>] (__schedule+0x310/0x624) from [<c0712bd0>]
> (schedule+0x40/0x80)
> [   54.185302] [<c0712bd0>] (schedule+0x40/0x80) from [<c0488774>]
> (__mmc_claim_host+0xa4/0x1a8)
> [   54.185333] [<c0488774>] (__mmc_claim_host+0xa4/0x1a8) from
> [<c048dd68>] (mmc_suspend+0x34/0x134)
> [   54.185363] [<c048dd68>] (mmc_suspend+0x34/0x134) from [<c048b688>]
> (mmc_suspend_host.part.20+0x98/0x1b0)
> [   54.185363] [<c048b688>] (mmc_suspend_host.part.20+0x98/0x1b0) from
> [<c048b7fc>] (mmc_suspend_host+0x5c/0x70)
> [   54.185394] [<c048b7fc>] (mmc_suspend_host+0x5c/0x70) from
> [<c049cce8>] (mmci_suspend+0x28/0x64)
> [   54.185424] [<c049cce8>] (mmci_suspend+0x28/0x64) from [<c0315d54>]
> (amba_pm_suspend+0x3c/0x68)
> [   54.185455] [<c0315d54>] (amba_pm_suspend+0x3c/0x68) from
> [<c0022b2c>] (ux500_pd_amba_pm_suspend+0x3c/0x50)
> [   54.185455] [<c0022b2c>] (ux500_pd_amba_pm_suspend+0x3c/0x50) from
> [<c0374a8c>] (dpm_run_callback+0x54/0x8c)
> [   54.185485] [<c0374a8c>] (dpm_run_callback+0x54/0x8c) from
> [<c0375c54>] (__device_suspend+0x174/0x3f0)
> [   54.185516] [<c0375c54>] (__device_suspend+0x174/0x3f0) from
> [<c03768a4>] (dpm_suspend+0x60/0x21c)
> [   54.185516] [<c03768a4>] (dpm_suspend+0x60/0x21c) from [<c0376bd4>]
> (dpm_suspend_start+0x68/0x70)
> [   54.185546] [<c0376bd4>] (dpm_suspend_start+0x68/0x70) from
> [<c007d424>] (suspend_devices_and_enter+0x70/0x20c)
> [   54.185546] [<c007d424>] (suspend_devices_and_enter+0x70/0x20c)
> from [<c007d66c>] (enter_state+0xac/0x184)
> [   54.185577] [<c007d66c>] (enter_state+0xac/0x184) from [<c007d768>]
> (pm_suspend+0x24/0x80)
> [   54.185607] [<c007d768>] (pm_suspend+0x24/0x80) from [<c007e774>]
> (suspend.part.2+0x44/0x174)
> [   54.185607] [<c007e774>] (suspend.part.2+0x44/0x174) from
> [<c007ea04>] (suspend+0x44/0x50)
> [   54.185638] [<c007ea04>] (suspend+0x44/0x50) from [<c0058280>]
> (process_one_work+0x138/0x4b0)
> [   54.185638] [<c0058280>] (process_one_work+0x138/0x4b0) from
> [<c0058748>] (worker_thread+0x150/0x37c)
> [   54.185668] [<c0058748>] (worker_thread+0x150/0x37c) from
> [<c005d768>] (kthread+0x98/0xa4)
> [   54.185699] [<c005d768>] (kthread+0x98/0xa4) from [<c00106a8>]
> (kernel_thread_exit+0x0/0x8)
> 
> Do you have any idea what causes this? Please disregard the
> amba-stuff, this is our power domain.
I reproduced this problem. Let me send the fix soon.
Thank you for the report.

Thanks,
Seungwon Jeon
> 
> Kind regards, Johan

