From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH v4] mmc: dw_mmc: fix potential system abort
Date: Wed, 1 Nov 2017 09:42:46 +0800
Message-ID: <6b09efaf-0037-9244-fe80-e86b63a7c97f@rock-chips.com>
References: <1506415566-115405-1-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.130]:44455 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753486AbdKABmr (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 31 Oct 2017 21:42:47 -0400
In-Reply-To: <1506415566-115405-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: shawn.lin@rock-chips.com, linux-mmc@vger.kernel.org

Hi Jaehoon, Ulf

On 2017/9/26 16:46, Shawn Lin wrote:
> dw_mmc allows the variant drivers to register the interrupt

Any chance to pick up this for 4.15?

> Synopsys Designware Multimedia Card Interface Driver
> dwmmc_rockchip fe320000.dwmmc: IDMAC supports 32-bit address mode.
> dwmmc_rockchip fe320000.dwmmc: Using internal DMA controller.
> dwmmc_rockchip fe320000.dwmmc: Version ID is 270a
> CPU: 0 PID: 1 Comm: swapper/0 Not tainted
> 4.13.0-rc3-next-20170807-00004-g93d3644-dirty #5
> Hardware name: Firefly-RK3399 Board (DT)
> Call trace:

>   
> 

