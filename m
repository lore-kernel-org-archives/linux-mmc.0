From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [RFC PATCH v8 0/10] Add external dma support for Synopsys MSHC
Date: Mon, 5 Oct 2015 17:56:00 +0800
Message-ID: <56124930.7020604@rock-chips.com>
References: <1442385625-26775-1-git-send-email-shawn.lin@rock-chips.com>
 <560CF98B.7010609@samsung.com> <560E5320.6050003@rock-chips.com>
 <5611D420.5080708@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.132]:53498 "EHLO
	lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752106AbbJEJ4O (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 5 Oct 2015 05:56:14 -0400
In-Reply-To: <5611D420.5080708@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>, ulf.hansson@linaro.org
Cc: shawn.lin@rock-chips.com, Vineet.Gupta1@synopsys.com, Wei Xu <xuwei5@hisilicon.com>, Joachim Eastwood <manabian@gmail.com>, Alexey Brodkin <abrodkin@synopsys.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Russell King <linux@arm.linux.org.uk>, Jun Nie <jun.nie@linaro.org>, Ralf Baechle <ralf@linux-mips.org>, Govindraj Raja <govindraj.raja@imgtec.com>, Arnd Bergmann <arnd@arndb.de>, heiko@sntech.de, dianders@chromium.org, linux-samsung-soc@vger.kernel.org, linux-mips@linux-mips.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, CPGS <cpgs@samsung.com>

On 2015/10/5 9:36, Jaehoon Chung wrote:
> Hi, Shawn.
>
> On 10/02/2015 06:49 PM, Shawn Lin wrote:
>> On 2015/10/1 17:14, Jaehoon Chung wrote:
>>> Dear, All.
>>>
>>> I will apply patch 01-03 at my repository on today.
>>> But i don't know better how i do about other patches relevant to co=
nfig file.
>>>
>>
>> Thanks, Jaehoon. :)
>>
>> I guess it would be acceptable to pick the config changes, already t=
hey were acked by the soc maintainers, via dw_mmc tree when ulf merge d=
w_mmc tree into his mmc-tree.
>
> Some patches didn't get the maintainer's acked-by.
> I will wait for that..until this week. How about?
>

No problem, take your time. =EF=BC=9A=EF=BC=89

> Best Regards,
> Jaehoon Chung
>
>>
>>
>>> Best Regards,
>>> Jaehoon Chung
>>>
>>> On 09/16/2015 03:40 PM, Shawn Lin wrote:
>>>> Synopsys DesignWare mobile storage host controller supports three
>>>> types of transfer mode: pio, internal dma and external dma. Howeve=
r,
>>>> dw_mmc can only supports pio and internal dma now. Thus some platf=
orms
>>>> using dw-mshc integrated with generic dma can't work in dma mode. =
So we
>>>> submit this patch to achieve it.
>>>>
>>>> And the config option, CONFIG_MMC_DW_IDMAC, was added by Will Newt=
on
>>>> (commit:f95f3850) for the first version of dw_mmc and never be tou=
ched since
>>>> then. At that time dt-bindings hadn't been introduced into dw_mmc =
yet means
>>>> we should select CONFIG_MMC_DW_IDMAC to enable internal dma mode a=
t compile
>>>> time. Nowadays, device-tree helps us to support a variety of board=
s with one
>>>> kernel. That's why we need to remove it and decide the transfer mo=
de by reading
>>>> dw_mmc's HCON reg at runtime.
>>>>
>>>> This RFC patch needs lots of ACKs. I know it's hard, but it does n=
eed someone
>>>> to make the running.
>>>>
>>>> Patch does the following things:
>>>> - remove CONFIG_MMC_DW_IDMAC config option
>>>> - add bindings for edmac used by synopsys-dw-mshc
>>>>     at runtime
>>>> - add edmac support for synopsys-dw-mshc
>>>>
>>>> Patch is based on next of git://git.linaro.org/people/ulf.hansson/=
mmc
>>>>
>>>> Test emmc throughput on my platform with edmac support and without=
 edmac support(pio only)
>>>> iozone -L64 -S32 -azecwI -+n -r4k -r64k -r128k -s1g -i0 -i1 -i2 -f=
 datafile -Rb out.xls > /mnt/result.txt
>>>> (light cpu loading, Direct IO, fixed line size, all pattern recycl=
e, 1GB data in total)
>>>>    ___________________________________________________________
>>>> |                   external dma mode                       |
>>>> |-----------------------------------------------------------|
>>>> |blksz | Random Read | Random Write | Seq Read   | Seq Write|
>>>> |-----------------------------------------------------------|
>>>> |4kB   |  13953kB/s  |    8602kB/s  | 13672kB/s  |  9785kB/s|
>>>> |-----------------------------------------------------------|
>>>> |64kB  |  46058kB/s  |   24794kB/s  | 48058kB/s  | 25418kB/s|
>>>> |-----------------------------------------------------------|
>>>> |128kB |  57026kB/s  |   35117kB/s  | 57375kB/s  | 35183kB/s|
>>>> |-----------------------------------------------------------|
>>>>                              VS
>>>>    ___________________________________________________________
>>>> |                          pio mode                         |
>>>> |-----------------------------------------------------------|
>>>> |blksz | Random Read  | Random Write | Seq Read  | Seq Write|
>>>> |-----------------------------------------------------------|
>>>> |4kB   |  11720kB/s   |    8644kB/s  | 11549kB/s |  9624kB/s|
>>>> |-----------------------------------------------------------|
>>>> |64kB  |  21869kB/s   |   24414kB/s  | 22031kB/s | 27986kB/s|
>>>> |-----------------------------------------------------------|
>>>> |128kB |  23718kB/s   |   34495kB/s  | 24698kB/s | 34637kB/s|
>>>> |-----------------------------------------------------------|
>>>>
>>>>
>>>> Changes in v8:
>>>> - remove trans_mode variable
>>>> - remove unnecessary dma_ops check
>>>> - remove unnecessary comment
>>>> - fix coding style based on latest ulf's next
>>>> - add Acked-by: Jaehoon Chung <jh80.chung@samsung.com>
>>>>     for HCON's changes
>>>>
>>>> Changes in v7:
>>>> - rebased on Ulf's next
>>>> - combine condition state
>>>> - elaborate more about DMA_INTERFACE
>>>> - define some macro for DMA_INERFACE value
>>>> - spilt HCON ops' changes into another patch
>>>>
>>>> Changes in v6:
>>>> - add trans_mode condition for IDMAC initialization
>>>>     suggested by Heiko
>>>> - re-test my patch on rk3188 platform and update commit msg
>>>> - update performance of pio vs edmac in cover letter
>>>>
>>>> Changes in v5:
>>>> - add the title of cover letter
>>>> - fix typo of comment
>>>> - add macro for reading HCON register
>>>> - add "Acked-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>" fo=
r exynos_defconfig patch
>>>> - add "Acked-by: Vineet Gupta <vgupta@synopsys.com>" for axs10x_de=
fconfig patch
>>>> - add "Acked-by: Govindraj Raja <govindraj.raja@imgtec.com>" and
>>>>     "Acked-by: Ralf Baechle <ralf@linux-mips.org>" for pistachio_d=
efconfig patch
>>>> - add "Acked-by: Joachim Eastwood <manabian@gmail.com>" for lpc18x=
x_defconfig patch
>>>> - add "Acked-by: Wei Xu <xuwei5@hisilicon.com>" for hisi_defconfig=
 patch
>>>> - rebase on "https://github.com/jh80chung/dw-mmc.git tags/dw-mmc-f=
or-ulf-v4.2" for merging easily
>>>>
>>>> Changes in v4:
>>>> - remove "host->trans_mode" and use "host->use_dma" to indicate
>>>>     transfer mode.
>>>> - remove all bt-bindings' changes since we don't need new properit=
ies.
>>>> - check transfer mode at runtime by reading HCON reg
>>>> - spilt defconfig changes for each sub-architecture
>>>> - fix the title of cover letter
>>>> - reuse some code for reducing code size
>>>>
>>>> Changes in v3:
>>>> - choose transfer mode at runtime
>>>> - remove all CONFIG_MMC_DW_IDMAC config option
>>>> - add supports-idmac property for some platforms
>>>>
>>>> Changes in v2:
>>>> - Fix typo of dev_info msg
>>>> - remove unused dmach from declaration of dw_mci_dma_slave
>>>>
>>>> Shawn Lin (10):
>>>>     mmc: dw_mmc: Add external dma interface support
>>>>     mmc: dw_mmc: use macro for HCON register operations
>>>>     Documentation: synopsys-dw-mshc: add bindings for idmac and ed=
mac
>>>>     mips: pistachio_defconfig: remove CONFIG_MMC_DW_IDMAC
>>>>     arc: axs10x_defconfig: remove CONFIG_MMC_DW_IDMAC
>>>>     arm: exynos_defconfig: remove CONFIG_MMC_DW_IDMAC
>>>>     arm: hisi_defconfig: remove CONFIG_MMC_DW_IDMAC
>>>>     arm: lpc18xx_defconfig: remove CONFIG_MMC_DW_IDMAC
>>>>     arm: multi_v7_defconfig: remove CONFIG_MMC_DW_IDMAC
>>>>     arm: zx_defconfig: remove CONFIG_MMC_DW_IDMAC
>>>>
>>>>    .../devicetree/bindings/mmc/synopsys-dw-mshc.txt   |  25 ++
>>>>    arch/arc/configs/axs101_defconfig                  |   1 -
>>>>    arch/arc/configs/axs103_defconfig                  |   1 -
>>>>    arch/arc/configs/axs103_smp_defconfig              |   1 -
>>>>    arch/arm/configs/exynos_defconfig                  |   1 -
>>>>    arch/arm/configs/hisi_defconfig                    |   1 -
>>>>    arch/arm/configs/lpc18xx_defconfig                 |   1 -
>>>>    arch/arm/configs/multi_v7_defconfig                |   1 -
>>>>    arch/arm/configs/zx_defconfig                      |   1 -
>>>>    arch/mips/configs/pistachio_defconfig              |   1 -
>>>>    drivers/mmc/host/Kconfig                           |  11 +-
>>>>    drivers/mmc/host/dw_mmc-pltfm.c                    |   2 +
>>>>    drivers/mmc/host/dw_mmc.c                          | 272 ++++++=
+++++++++++----
>>>>    drivers/mmc/host/dw_mmc.h                          |   9 +
>>>>    include/linux/mmc/dw_mmc.h                         |  23 +-
>>>>    15 files changed, 276 insertions(+), 75 deletions(-)
>>>>
>>>
>>>
>>>
>>>
>>
>>
>
>
>
>


--=20
Best Regards
Shawn Lin

