From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH 0/4] mmc: Convert host drivers to mmc_send_tuning()
Date: Thu, 04 Dec 2014 12:50:02 -0800
Message-ID: <5480C8FA.3090702@codeaurora.org>
References: <1417449730-5880-1-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.11.231]:50947 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753743AbaLDUuE (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 4 Dec 2014 15:50:04 -0500
In-Reply-To: <1417449730-5880-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, Chris Ball <chris@printf.net>
Cc: Seungwon Jeon <tgih.jun@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <kernel@pengutronix.de>, Aisheng Dong <b29396@freescale.com>, Minda Chen <Minda.Chen@csr.com>, Barry Song <Baohua.Song@csr.com>

On 12/01/2014 08:02 AM, Ulf Hansson wrote:
> Due to commit "mmc: core: add core-level function for sending tuning commands",
> the mmc core provides an API to send the tuning command and as well compare the
> response pattern.
>
> Convert those host drivers which implemented their own version for how to deal
> with this, into using the new API.
>
> Note, this patchset has currently only been compile tested. Any help in testing
> on HW is higly appreciated.

I get a crash on boot with these patches. I think it's because
host->card is not assigned until after we do the tuning in
mmc_init_card(). I took these patches and applied them on top of the
patch you mentioned above. I wonder why the mmc_send_tuning() function
doesn't take the mmc_host structure instead? The card structure is only
used to get the host anyway.

[    1.199844] Unable to handle kernel NULL pointer dereference at virtual address 00000000
[    1.199870] pgd = c0204000
[    1.207008] [00000000] *pgd=00000000
[    1.212909] Internal error: Oops: 5 [#1] PREEMPT SMP ARM
[    1.213153] Modules linked in:
[    1.221397] CPU: 0 PID: 53 Comm: kworker/u8:1 Not tainted 3.18.0-rc4-00116-g5d5e4adeefc9 #114
[    1.221500] Workqueue: kmmcd mmc_rescan
[    1.233632] task: ee368e40 ti: ee3d2000 task.ti: ee3d2000
[    1.233819] PC is at mmc_send_tuning+0x90/0x1b4
[    1.239201] LR is at sdhci_msm_execute_tuning+0x1ec/0x3c8
[    1.243536] pc : [<c059f900>]    lr : [<c05b2c04>]    psr: 60000113
[    1.243536] sp : ee3d3c90  ip : 00000000  fp : 082a7440
[    1.249099] r10: ee3cb280  r9 : 07735940  r8 : c0a03d40
[    1.260375] r7 : ee3cb000  r6 : 00000000  r5 : 00000000  r4 : 00000000
[    1.265585] r3 : 00000000  r2 : 00000000  r1 : 60000113  r0 : 00000000
[    1.272183] Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
[    1.278695] Control: 10c5787d  Table: 0020406a  DAC: 00000015
[    1.285898] Process kworker/u8:1 (pid: 53, stack limit = 0xee3d2240)
[    1.291800] Stack: (0xee3d3c90 to 0xee3d4000)
[    1.298223] 3c80:                                     00000000 c09a4a00 2de1c000 c0a28300
[    1.302482] 3ca0: 00000000 c0241668 c09a25d0 00000000 00000000 00000000 00000000 00000000
[    1.310642] 3cc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[    1.318802] 3ce0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 c06eb3e8
[    1.326962] 3d00: 00000001 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[    1.335120] 3d20: 00000000 00000000 00000000 00000000 00000000 00000000 f00bc900 00000000
[    1.343286] 3d40: 00000000 00000000 ee3cb000 c0a03d40 07735940 ee3cb280 082a7440 c05b2c04
[    1.351443] 3d60: 00000000 c09a8100 ee3cb2a8 00000003 08f0d180 09a7ec80 0a6e49c0 0b2564c0
[    1.359603] 3d80: 0bebc200 00020007 01090302 00000000 ee3cb000 c0599c60 00000001 ee3d2000
[    1.367761] 3da0: ee3d3db4 ee3cb000 a0000113 ee3cb2a8 00000015 ee3cb000 00000001 ee3cb000
[    1.375919] 3dc0: ee3cb000 c05af5a0 ffff8b60 c059fca8 00000000 ee3cb280 00000001 000000fa
[    1.384079] 3de0: 00000006 03b90201 00000800 00000000 00000001 ee3d2000 ee3d3e0c c0241544
[    1.392238] 3e00: ee3cb280 ee3cb16c ee3cb2a8 c09ae444 60000113 00000080 00000003 c05b0e1c
[    1.400408] 3e20: ee3cb000 ee3cb16c 0bebc200 ee29dc00 00000024 c06ed9e4 00008008 c059a3a8
[    1.400415] 3e40: 00008008 c059b1a0 c05ae3e8 ee3cb000 00000000 00000000 ee29dc00 ee3cb000
[    1.400422] 3e60: 00000001 ee3cb000 00000024 c059e438 000000fa 00000001 00000001 00000001
[    1.400428] 3e80: 0000fa03 3d640fff 00000000 00000020 c0ff8080 ed83a000 45010053 454d3136
[    1.400435] 3ea0: 4706309b d1d35000 00000000 ee3cb000 00000000 ee3cb000 00061a80 c075e2ec
[    1.400442] 3ec0: 00000000 ee223900 00000000 c059f354 00061a80 40ff8080 00000000 ee3cb1a4
[    1.400449] 3ee0: c075e2e0 c059c1ec ee3cb1a4 ee2ff500 ee00e400 c09fb8f8 ee3d2000 c0235800
[    1.400455] 3f00: 00000001 ee089ed8 00000000 00000000 00000001 ee00e414 ee3d2000 ee3d2000
[    1.400462] 3f20: ee2ff518 ee2ff500 ee00e400 00000088 ee00e400 c0235b20 ee3d2000 00000000
[    1.400468] 3f40: 00000000 ee3a2840 00000000 ee2ff500 c0235ae4 00000000 00000000 00000000
[    1.400475] 3f60: 00000000 c023a30c a8a2aaaa 00000000 aaaaaaaa ee2ff500 00000000 00000000
[    1.400481] 3f80: ee3d3f80 ee3d3f80 00000000 00000000 ee3d3f90 ee3d3f90 ee3d3fac ee3a2840
[    1.400488] 3fa0: c023a240 00000000 00000000 c020f198 00000000 00000000 00000000 00000000
[    1.400494] 3fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[    1.400500] 3fe0: 00000000 00000000 00000000 00000000 00000013 00000000 aa8a2aa8 80aaaaa0
[    1.400529] [<c059f900>] (mmc_send_tuning) from [<c05b2c04>] (sdhci_msm_execute_tuning+0x1ec/0x3c8)
[    1.400543] [<c05b2c04>] (sdhci_msm_execute_tuning) from [<c05af5a0>] (sdhci_execute_tuning+0x90/0x5b4)
[    1.400555] [<c05af5a0>] (sdhci_execute_tuning) from [<c059e438>] (mmc_init_card+0x8e0/0x15fc)
[    1.400567] [<c059e438>] (mmc_init_card) from [<c059f354>] (mmc_attach_mmc+0x90/0x15c)
[    1.400578] [<c059f354>] (mmc_attach_mmc) from [<c059c1ec>] (mmc_rescan+0x29c/0x2e4)
[    1.400593] [<c059c1ec>] (mmc_rescan) from [<c0235800>] (process_one_work+0x140/0x3f0)
[    1.400605] [<c0235800>] (process_one_work) from [<c0235b20>] (worker_thread+0x3c/0x4b0)
[    1.400615] [<c0235b20>] (worker_thread) from [<c023a30c>] (kthread+0xcc/0xe8)
[    1.400629] [<c023a30c>] (kthread) from [<c020f198>] (ret_from_fork+0x14/0x3c)
[    1.400637] Code: e58d305c e58d3060 e58d3064 e58d3068 (e5905000)


-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

