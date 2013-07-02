From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: Oops on linux-next during reboot,
 possibly related to "mmc: core: Handle card shutdown from mmc_bus"
Date: Tue, 02 Jul 2013 15:59:52 +0900
Message-ID: <51D27A68.1050009@samsung.com>
References: <51D16AA9.3090003@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:50250 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932219Ab3GBG7u (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 2 Jul 2013 02:59:50 -0400
Received: from epcpsbgr3.samsung.com
 (u143.gpu120.samsung.co.kr [203.254.230.143])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MPA00HOTRE3DDQ0@mailout2.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 02 Jul 2013 15:59:49 +0900 (KST)
In-reply-to: <51D16AA9.3090003@nvidia.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Tuomas Tynkkynen <ttynkkynen@nvidia.com>
Cc: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>

Hi Tuomas,

It seems to produce this problem when wifi is enabled.
In case of WiFi, used the sdio_bus_register in sdio_bus.c.

Then i think right that "shutdown callback function" is existed in WiFi driver.
And need to use the sdio_bus_shutdown, not mmc_bus_shutdown.

sdio is used sdio_driver and mmc/sd is used mmc_driver.
I think that didnt consider this point.

Maybe need to check whether drv is NULL or not.
If i misunderstood something, let me know.

Best Regards,
Jaehoon Chung

On 07/01/2013 08:40 PM, Tuomas Tynkkynen wrote:
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
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

