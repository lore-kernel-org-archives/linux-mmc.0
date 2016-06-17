From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH v2 0/11] Changes to support 150 MHz eMMC on rk3399
Date: Fri, 17 Jun 2016 08:37:15 -0700
Message-ID: <CAD=FV=XK=YTyj=yfZ2bXq-W2OeEFi+h3X0SypXmLqVaEmNf5bQ@mail.gmail.com>
References: <1465859076-4868-1-git-send-email-dianders@chromium.org> <5763EF68.1040307@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vk0-f47.google.com ([209.85.213.47]:33873 "EHLO
	mail-vk0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932628AbcFQPhR (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 17 Jun 2016 11:37:17 -0400
Received: by mail-vk0-f47.google.com with SMTP id t129so120719441vka.1
        for <linux-mmc@vger.kernel.org>; Fri, 17 Jun 2016 08:37:17 -0700 (PDT)
In-Reply-To: <5763EF68.1040307@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>, Shawn Lin <shawn.lin@rock-chips.com>, Ziyuan Xu <xzy.xu@rock-chips.com>, Brian Norris <briannorris@chromium.org>, Adrian Hunter <adrian.hunter@intel.com>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Xing Zheng <zhengxing@rock-chips.com>, Michal Simek <michal.simek@xilinx.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Xu Jianqun <jay.xu@rock-chips.com>, Caesar Wang <wxt@rock-chips.com>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, soren.brinkmann@xilinx.com, linux-kernel@vg

Kishon,

On Fri, Jun 17, 2016 at 5:39 AM, Kishon Vijay Abraham I <kishon@ti.com> wrote:
> Hi,
>
> On Tuesday 14 June 2016 04:34 AM, Douglas Anderson wrote:
>> The theme of this series of patches is to try to allow running the eMMC
>> at 150 MHz on the rk3399 SoC, though the changes should still be correct
>> and have merit on their own.  The motivation for running at 150 MHz is
>> that doing so improves signal integrity and (with some eMMC devices)
>> doesn't affect throughput.
>>
>> These patches have been structured to keep things as separate as
>> possible, but nevertheless there are still some dependencies between
>> patches.  It probably makes the most sense for all of the non-device
>> tree patches to go through a single tree.  If others agree, perhaps the
>> most sane would be to get Acks from PHY maintainers and then to land the
>> patches in the MMC tree.  Device tree patches should be able to be
>> landed separately and the worst what would happen is a warning in the
>> kernel log if you have the code without the device tree.
>>
>> The code patches are based on Ulf's mmc-next, then 4 patches that are
>> outstanding / ready to land.  Specifically:
>> - https://patchwork.kernel.org/patch/9086501/
>>   phy: rockchip-emmc: give DLL some extra time to be ready
>> - https://patchwork.kernel.org/patch/9093681/
>>   phy: rockchip-emmc: configure frequency range and drive impedance
>> - https://patchwork.kernel.org/patch/9086511/
>>   phy: rockchip-emmc: configure default output tap delay
>> - https://patchwork.kernel.org/patch/9086531/
>>   phy: rockchip-emmc: reindent the register definitions
>
> Do you want all these "phy: rockchip-emmc:" along with the patch in this series
> to go in MMC tree? Or I can take all the phy part in my linux-phy -next branch?

If Ulf is amenable, I was hoping that these could all go through the
MMC tree with your blessing.  ...then "dts" patches would go through
Heiko's tree.

-Doug
