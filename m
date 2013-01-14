From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: sdhci: disable interrupt before free_irq
Date: Mon, 14 Jan 2013 14:41:13 -0500
Message-ID: <87sj63sgbq.fsf@laptop.org>
References: <1357377508-12043-1-git-send-email-kliu5@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:34591 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756500Ab3ANTlp (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 14 Jan 2013 14:41:45 -0500
In-Reply-To: <1357377508-12043-1-git-send-email-kliu5@marvell.com> (Kevin
	Liu's message of "Sat, 5 Jan 2013 17:18:28 +0800")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kevin Liu <kliu5@marvell.com>
Cc: linux-mmc@vger.kernel.org, Philip Rakity <prakity@nvidia.com>, Aaron Lu <aaron.lu@intel.com>, Shawn Guo <shawn.guo@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>, Johan Rudholm <johan.rudholm@stericsson.com>, Daniel Drake <dsd@laptop.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Adrian Hunter <adrian.hunter@intel.com>, Jerry Huang <Chang-Ming.Huang@freescale.com>, Alexander Stein <alexander.stein@systec-electronic.com>, Girish K S <girish.shivananjappa@linaro.org>, Haijun Zhang <Haijun.Zhang@freescale.com>, Viresh Kumar <viresh.kumar@linaro.org>, Heiko Stuebner <heiko@sntech.de>, Thomas Abraham <thomas.abraham@linaro.org>, Chander Kashyap <chander.kashyap@linaro.com>, Jaehoon Chung <jh80.chung@samsung.com>, Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>, Zhangfei Gao <zhangfei.gao@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Chao

Hi,

On Sat, Jan 05 2013, Kevin Liu wrote:
> Current code missed disabling interrupts before free irq which is shared.
>
> Notice below comments for function free_irq (kernel/irq/manage.c):
> On a shared IRQ the caller must ensure the interrupt is disabled
> on the card it drives before calling this function.
>
> Original code has below issue during suspend/resume when multiple SD hosts
> share the same IRQ:
> 1. Assume there are two hosts (host1 for emmc while host2 for sd) share
> the same mmc irq.
> 2. When system suspend, host2 will be suspended before host1.
> So the sequence is below:
> 	step1: irq handler for host2 removed ->
> 	step2: irq handler for host1 removed and irq disabled ->
> 	... system suspended ...
> 	... system resumed ...
> 	step3: irq enabled and the irq handler for host1 restored ->
> 	step4: irq handler for host2 restored
> 3. So there is the buggy time slot that the irq is enabled but the irq handler
> for host2 is removed. Then host2 interrupt can be triggered but can't be handled
> at that moment.
>
> Signed-off-by: Jialing Fu <jlfu@marvell.com>
> Signed-off-by: Kevin Liu <kliu5@marvell.com>

Thanks, pushed to mmc-next for 3.9.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
