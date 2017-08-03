From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: rk3288: mmcblk0: error -110 sending status command, retrying
Date: Thu, 3 Aug 2017 16:18:11 +0800
Message-ID: <18c3b93d-9db2-eb82-8232-7d141e00324e@rock-chips.com>
References: <CAD6G_RRgPB_FVTr0OUdtUXeViben6pSakEcskzwQXkqUeaT2kw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.134]:43570 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750945AbdHCISX (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 3 Aug 2017 04:18:23 -0400
In-Reply-To: <CAD6G_RRgPB_FVTr0OUdtUXeViben6pSakEcskzwQXkqUeaT2kw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jagan Teki <jagannadh.teki@gmail.com>, Heiko Stuebner <heiko@sntech.de>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>, shawn.lin@rock-chips.com, linux-mmc@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-rockchip@lists.infradead.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>


On 2017/8/2 19:09, Jagan Teki wrote:
> Hi,
> 
> Did anyone observing error -110 and -84 during boot on rk3288 target?
> full log here[1] and used dts node is[2].

-100 is -ETIMEDOUT and -84 is CRC error. So that seems much likely HW
relevant. Have you check the SI of SD slot?

You don't enable UHS mode so the tuning process won't help.
But rockchip platforms have a default setting for sample delay.
See rockchip,default-sample-phase and try add some sample delay.

FYI: Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.txt



> 
> Proper card detection is done, once we insert after console came-up
> # [   39.635614] mmc0: card 59b4 removed
> [   40.645537] mmc_host mmc0: Bus speed (slot 0) = 400000Hz (slot req
> 400000Hz, actual 400000HZ div = 0)
> [   41.004559] mmc_host mmc0: Bus speed (slot 0) = 50000000Hz (slot
> req 50000000Hz, actual 50000000HZ div = 0)
> [   41.015553] mmc0: new high speed SDXC card at address 59b4
> [   41.022015] mmcblk0: mmc0:59b4 MS    59.1 GiB
> [   41.028458]  mmcblk0: p1 p2
> 
> Any help?
> 
> [1] https://paste.ubuntu.com/25225486/
> [2] https://paste.ubuntu.com/25225915/
> 
> thanks!
> 

