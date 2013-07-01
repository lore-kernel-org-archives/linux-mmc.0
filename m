From: Tuomas Tynkkynen <ttynkkynen@nvidia.com>
Subject: Oops on linux-next during reboot, possibly related to "mmc: core:
 Handle card shutdown from mmc_bus"
Date: Mon, 1 Jul 2013 14:40:25 +0300
Message-ID: <51D16AA9.3090003@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from hqemgate04.nvidia.com ([216.228.121.35]:15266 "EHLO
	hqemgate04.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752862Ab3GALk2 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 1 Jul 2013 07:40:28 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>

Hi,

On next-20130628 I get the following Oops during reboot:
[   89.814921] Unable to handle kernel NULL pointer dereference at virtual address 0000004c
[   89.824208] pgd = ecd54000
[   89.827276] [0000004c] *pgd=00000000
[   89.831340] Internal error: Oops: 5 [#1] PREEMPT SMP ARM

[<c040b244>] (mmc_bus_shutdown+0x24/0x70) from [<c032aa6c>] (device_shutdown+0x44/0x19c)
[<c032aa6c>] (device_shutdown+0x44/0x19c) from [<c0054508>] (kernel_restart_prepare+0x44/0x48)
[<c0054508>] (kernel_restart_prepare+0x44/0x48) from [<c0054528>] (kernel_restart+0x1c/0x70)
[<c0054528>] (kernel_restart+0x1c/0x70) from [<c0054704>] (SyS_reboot+0x168/0x1f0)
[<c0054704>] (SyS_reboot+0x168/0x1f0) from [<c000ed00>] (ret_fast_syscall+0x0/0x30)

The corresponding line in mmc_bus_shutdown is "drv->shutdown(card);"
and 'drv' seems indeed to be NULL.
