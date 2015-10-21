From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [GIT PULL] Update dw-mmc controller
Date: Wed, 21 Oct 2015 17:52:32 +0900
Message-ID: <56275250.1020104@samsung.com>
References: <5626FCB0.5040708@samsung.com> <562712E1.3020107@samsung.com>
 <CAPDyKFoGxEL_8KWbN-50EGMJB7MyiHxcvBCDJKcOW_ObLNcyHg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:42339 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932106AbbJUIwj (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 21 Oct 2015 04:52:39 -0400
Received: from epcpsbgr2.samsung.com
 (u142.gpu120.samsung.co.kr [203.254.230.142])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTP id <0NWK002WPBBK3J20@mailout3.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 21 Oct 2015 17:52:32 +0900 (KST)
In-reply-to: <CAPDyKFoGxEL_8KWbN-50EGMJB7MyiHxcvBCDJKcOW_ObLNcyHg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Shawn Lin <shawn.lin@rock-chips.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Govindraj Raja <govindraj.raja@imgtec.com>, Ralf Baechle <ralf@linux-mips.org>, Vineet Gupta <vgupta@synopsys.com>, Wei Xu <xuwei5@hisilicon.com>, Joachim Eastwood <manabian@gmail.com>

Hi,

On 10/21/2015 05:38 PM, Ulf Hansson wrote:
> On 21 October 2015 at 06:21, Jaehoon Chung <jh80.chung@samsung.com> wrote:
>> Dear Ulf.
>>
>> Sorry..previously request-pull is wrong.
>> Could you pull the below..?
>>
>> The following changes since commit 10e2cf053bbbaa76fcd919c0f59ae5bf8463a19c:
>>
>>   mmc: sdhci-of-esdhc: avoid writing power control register (2015-10-16 15:04:58 +0200)
>>
>> are available in the git repository at:
>>
>>   https://github.com/jh80chung/dw-mmc.git for-ulf
>>
>> for you to fetch changes up to 13ae9dff2fe12409197fbd3620d2308888badbac:
>>
>>   arm: zx_defconfig: remove CONFIG_MMC_DW_IDMAC (2015-10-20 23:59:31 +0900)
>>
>> ----------------------------------------------------------------
>> Shawn Lin (10):
>>       mmc: dw_mmc: Add external dma interface support
>>       mmc: dw_mmc: use macro for HCON register operations
>>       Documentation: synopsys-dw-mshc: add bindings for idmac and edmac
>>       mips: pistachio_defconfig: remove CONFIG_MMC_DW_IDMAC
>>       arc: axs10x_defconfig: remove CONFIG_MMC_DW_IDMAC
>>       arm: exynos_defconfig: remove CONFIG_MMC_DW_IDMAC
>>       arm: hisi_defconfig: remove CONFIG_MMC_DW_IDMAC
>>       arm: lpc18xx_defconfig: remove CONFIG_MMC_DW_IDMAC
>>       arm: multi_v7_defconfig: remove CONFIG_MMC_DW_IDMAC
>>       arm: zx_defconfig: remove CONFIG_MMC_DW_IDMAC
> 
> Jaehoon,
> 
> The last two arm patches doesn't have acks. I realize that these
> changes are trivial, but I can't pull these in without acks. All the
> other patches I have picked up.

Ok, I also wondered that point..Thanks for point out.
I will also request the acks to each SoC maintainters.
And I will rebase on your tree, on today.

Thanks a lot!

Best Regards,
Jaehoon Chung

> 
>>
>>  Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt |  25 +++++++++++++
>>  arch/arc/configs/axs101_defconfig                          |   1 -
>>  arch/arc/configs/axs103_defconfig                          |   1 -
>>  arch/arc/configs/axs103_smp_defconfig                      |   1 -
>>  arch/arm/configs/exynos_defconfig                          |   1 -
>>  arch/arm/configs/hisi_defconfig                            |   1 -
>>  arch/arm/configs/lpc18xx_defconfig                         |   1 -
>>  arch/arm/configs/multi_v7_defconfig                        |   1 -
>>  arch/arm/configs/zx_defconfig                              |   1 -
>>  arch/mips/configs/pistachio_defconfig                      |   1 -
>>  drivers/mmc/host/Kconfig                                   |  11 +-----
>>  drivers/mmc/host/dw_mmc-pltfm.c                            |   2 +
>>  drivers/mmc/host/dw_mmc.c                                  | 272 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++---------------------------
>>  drivers/mmc/host/dw_mmc.h                                  |   9 +++++
>>  include/linux/mmc/dw_mmc.h                                 |  23 +++++++++++-
>>  15 files changed, 276 insertions(+), 75 deletions(-)
>>
>> Best Regards,
>> Jaehoon Chung
> 
> [...]
> 
> Thanks!
> 
> Kind regards
> Uffe
> 

