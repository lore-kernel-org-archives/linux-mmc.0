From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: Oops on linux-next during reboot, possibly related to "mmc: core:
 Handle card shutdown from mmc_bus"
Date: Tue, 2 Jul 2013 12:56:02 +0200
Message-ID: <CAPDyKFosC0jP2G73M5ddSsHFOyw8LdvGgp9WuZ3ABAXF0WK0cg@mail.gmail.com>
References: <51D16AA9.3090003@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vb0-f49.google.com ([209.85.212.49]:59717 "EHLO
	mail-vb0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751665Ab3GBK4E (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 2 Jul 2013 06:56:04 -0400
Received: by mail-vb0-f49.google.com with SMTP id 12so4465794vbf.36
        for <linux-mmc@vger.kernel.org>; Tue, 02 Jul 2013 03:56:03 -0700 (PDT)
In-Reply-To: <51D16AA9.3090003@nvidia.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Tuomas Tynkkynen <ttynkkynen@nvidia.com>
Cc: linux-mmc@vger.kernel.org

On 1 July 2013 13:40, Tuomas Tynkkynen <ttynkkynen@nvidia.com> wrote:
> Hi,
>
> On next-20130628 I get the following Oops during reboot:
> [   89.814921] Unable to handle kernel NULL pointer dereference at virtual address 0000004c
> [   89.824208] pgd = ecd54000
> [   89.827276] [0000004c] *pgd=00000000
> [   89.831340] Internal error: Oops: 5 [#1] PREEMPT SMP ARM
>
> [<c040b244>] (mmc_bus_shutdown+0x24/0x70) from [<c032aa6c>] (device_shutdown+0x44/0x19c)
> [<c032aa6c>] (device_shutdown+0x44/0x19c) from [<c0054508>] (kernel_restart_prepare+0x44/0x48)
> [<c0054508>] (kernel_restart_prepare+0x44/0x48) from [<c0054528>] (kernel_restart+0x1c/0x70)
> [<c0054528>] (kernel_restart+0x1c/0x70) from [<c0054704>] (SyS_reboot+0x168/0x1f0)
> [<c0054704>] (SyS_reboot+0x168/0x1f0) from [<c000ed00>] (ret_fast_syscall+0x0/0x30)
>
> The corresponding line in mmc_bus_shutdown is "drv->shutdown(card);"
> and 'drv' seems indeed to be NULL.

Hi Tuomas,

Your observations is correct, thanks for reporting and testing.

I have just sent a fixup patch that will solve the issue.

Kind regards
Ulf Hansson
