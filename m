From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH v4 0/3] about data busy
Date: Mon, 16 Feb 2015 14:48:38 +0900
Message-ID: <54E184B6.90808@samsung.com>
References: <1423828368-18456-1-git-send-email-addy.ke@rock-chips.com>
 <1423894668-8886-1-git-send-email-addy.ke@rock-chips.com>
 <CABxcv==G_sKsvWHX6rJP7EUv8jE=01k-JeGGXgiwiCN53pxdmQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:38287 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751272AbbBPFsl (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 16 Feb 2015 00:48:41 -0500
In-reply-to: <CABxcv==G_sKsvWHX6rJP7EUv8jE=01k-JeGGXgiwiCN53pxdmQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Javier Martinez Canillas <javier@dowhile0.org>, Addy Ke <addy.ke@rock-chips.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Olof Johansson <olof@lixom.net>, Alim Akhtar <alim.akhtar@gmail.com>, Andrzej Hajda <a.hajda@samsung.com>, Douglas Anderson <dianders@chromium.org>, =?UTF-8?B?SGVpa28gU3TDvGJuZXI=?= <heiko@sntech.de>, cf@rock-chips.com, lintao@rock-chips.com, huangtao@rock-chips.com, Linux Kernel <linux-kernel@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-rockchip@lists.infradead.org

On 02/15/2015 08:41 PM, Javier Martinez Canillas wrote:
> Hello Addy,
> 
> On Sat, Feb 14, 2015 at 7:17 AM, Addy Ke <addy.ke@rock-chips.com> wrote:
>> patch 1: This patch can fix bug that controller is still data busy after
>>          reset all blocks. After this patch, I still get data busy in
>>          set_ios().
>>
>> patch 2: This patch fix bug 'Timeout sending command'. After patch1 and
>>          patch2, there is no mmc errors after:
>>          cd /sys/bus/platform/drivers/dwmmc_rockchip
>>          for i in $(seq 1 10000); do
>>                 echo "========================" $i
>>                 echo ff0c0000.dwmmc > unbind
>>                 sleep .5
>>                 echo ff0c0000.dwmmc > bind
>>                 sleep 2
>>         done
>>
>> patch3: This patch fix bug that there is data busy before sdio send CMD53.
>>         But This patch is necessary for sd and mmc too.
>>
> 
> I faced the same 'Timeout sending command' error when trying to enable
> support for the SDIO wifi chip attached to mmc@12210000 (mmc1) on an
> Exynos5420 Peach Pit Chromebook. On booting the kernel log shows:
> 
> mmc_host mmc1: Timeout sending command (cmd 0x202000 arg 0x0 status 0x80202000)
> 
> 0x202000 == SDMMC_CMD_UPD_CLK | SDMMC_CMD_PRV_DAT_WAIT so your patch
> #2 dw_mci_setup_bus() avoids the mmc comand to time out. However, it
> has a side effect since with your series the uSD that in mmc@12220000
> (mmc2) fails to be detected and the kernel log shows:
> 
> [    5.466432] Waiting for root device /dev/mmcblk1p4...
> [  240.169436] INFO: task kworker/u16:1:50 blocked for more than 120 seconds.
> [  240.174844]       Not tainted
> 3.19.0-next-20150211-00006-g045d4aba96ce-dirty #476
> [  240.182302] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
> disables this message.
> [  240.190109] kworker/u16:1   D c04c2710     0    50      2 0x00000000
> [  240.196446] Workqueue: kmmcd mmc_rescan
> [  240.200249] [<c04c2710>] (__schedule) from [<c04c2ac0>] (schedule+0x34/0x98)
> [  240.207290] [<c04c2ac0>] (schedule) from [<c04c6568>]
> (schedule_timeout+0x120/0x16c)
> [  240.215009] [<c04c6568>] (schedule_timeout) from [<c04c3584>]
> (wait_for_common+0xb0/0x154)
> [  240.223251] [<c04c3584>] (wait_for_common) from [<c038a5ac>]
> (mmc_wait_for_req+0xa0/0x140)
> [  240.231492] [<c038a5ac>] (mmc_wait_for_req) from [<c038a6d4>]
> (mmc_wait_for_cmd+0x88/0xa8)
> [  240.239735] [<c038a6d4>] (mmc_wait_for_cmd) from [<c03905b0>]
> (mmc_go_idle+0x78/0xf8)
> [  240.247540] [<c03905b0>] (mmc_go_idle) from [<c038c578>]
> (mmc_rescan+0x254/0x300)
> [  240.255003] [<c038c578>] (mmc_rescan) from [<c00346e8>]
> (process_one_work+0x120/0x324)
> [  240.262897] [<c00346e8>] (process_one_work) from [<c0034a58>]
> (worker_thread+0x138/0x464)
> [  240.271048] [<c0034a58>] (worker_thread) from [<c0039070>]
> (kthread+0xd8/0xf4)
> [  240.278254] [<c0039070>] (kthread) from [<c000e680>]
> (ret_from_fork+0x14/0x34)
> 
> 
> By enabling debug I see that the card is detected in dw_mci_get_cd() though.
> 
> Alim suggested [0] that dw_mci_wait_busy() should be called in
> mci_send_cmd() instead dw_mci_setup_bus() because the controller hangs
> when when sending update clock cmd in different cases.
> 
> I modified [1] your patch #2 to do what Alim suggested and only with
> that patch on top of linux-next I have neither the the "Timeout
> sending command" error nor the uSD not getting detected errors. Linux
> mounts the rootfs from the uSD and the wifi SDIO device is enumerated
> and listed in /sys/bus/sdio/devices/

it needs to check when clock value only update.
As Javier and Alim are mentioned, if check whether card is busy or not in setup_bus(),
should be processed unnecessary checking.
(According to TRM, before disabling clock, check whether card is busy or not.)
if my thinking is right, chekcing is located more exactly before mci_writel(host, CLKENA, 0).

And i recommend if CLK_GATE is enabled, clkgate_delay sets to the bigger value than 3.
I'm not sure Javier's issue is same thing..I will check more this.

Best Regards,
Jaehoon Chung

> 
> Does that also solve your issue?
> 
> Best regards,
> Javier
> 
> [0]: https://lkml.org/lkml/2015/2/10/353
> [1]: http://paste.debian.net/plain/148794
> 

