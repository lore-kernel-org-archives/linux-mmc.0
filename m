From: Dinh Nguyen <dinguyen@altera.com>
Subject: Re: [PATCH 2/2] mmc: dw_mmc: add dw_mmc-k3 for k3 platform
Date: Wed, 11 Dec 2013 12:48:10 -0600
Message-ID: <1386787690.20516.10.camel@linux-builds1>
References: <1383889128-12540-1-git-send-email-zhangfei.gao@linaro.org>
	 <201312060239.14832.arnd@arndb.de>
	 <CAMj5BkhyiJ7Uc-GiRZP3TNMq3NvHW-MVuPT6t+7FN8KBWAJR5A@mail.gmail.com>
	 <201312110445.54336.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from co1ehsobe001.messaging.microsoft.com ([216.32.180.184]:26079
	"EHLO co1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750800Ab3LKStv (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 11 Dec 2013 13:49:51 -0500
In-Reply-To: <201312110445.54336.arnd@arndb.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Zhangfei Gao <zhangfei.gao@gmail.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, devicetree@vger.kernel.org, Seungwon Jeon <tgih.jun@samsung.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Jaehoon Chung <jh80.chung@samsung.com>, Kumar Gala <galak@codeaurora.org>, Zhangfei Gao <zhangfei.gao@linaro.org>, Chris Ball <cjb@laptop.org>, heiko@sntech.de

On Wed, 2013-12-11 at 04:45 +0100, Arnd Bergmann wrote:
> On Wednesday 11 December 2013, Zhangfei Gao wrote:
> > Thanks for the good suggestion, it can be abstracted to clock.
> > 
> > The issue for this version's ip is there are some registers need to be
> > set, including fixed factor and phase, which may be required to be
> > tuned, however it can be hide in clock.
> > 
> > Double checked next version's ip, it is more intelligent and only
> > fixed factor is required, more like a clock, and all these register
> > accessing are NOT required.
> > 
> > Will update new version to abstract these chip depended registers to clock.
> 
> Ok, please stay in contact with Dinh Nguyen over this, since his side
> is work-in-progress and we are still evaluating how to best encode
> the phase setting in DT in a generic form.

Will the bindings "samsung,dw-mshc-sdr-timing" and
"samsung,dw-mshc-ddr-timing" also work for the k3 platform as well? I
think they should work, but just wanted to verify.

Heiko, on the rockchip platform, can you check to see if you have these
cclk_in_drv and cclk_sample settings for the phase shift of the clocks?
The SD/MMC IP version(2.40a) on Rockchip is the same version that is on
SOCFPGA, so I think these settings are there. They can be located in
some other "system" register block like SOCFPGA. The possible reason
that you have not need to set them in the Rockchip code could be that
the bootloader/firmware has already set them if you are booting from the
SD/MMC source. You may need to set the clock phase settings if you boot
from a non-SD source.

I think the reading of the "samsung,dw-mshc-ddr-timing" and
"samsung,dw-msh-sdr-timing" bindings can also be moved into the generic
dw_mmc driver if the above 2 conditions are correct.

Thanks,
Din
> 
> 	Arnd
> 



