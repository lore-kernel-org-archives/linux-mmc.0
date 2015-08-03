From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH v2] mmc: dw_mmc: Add external dma interface support
Date: Mon, 3 Aug 2015 21:23:15 +0800
Message-ID: <55BF6B43.1050105@rock-chips.com>
References: <1438572439-654-1-git-send-email-shawn.lin@rock-chips.com>
 <2599339.pPeKCdCNNQ@diego>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from regular1.263xmail.com ([211.150.99.131]:47932 "EHLO
	regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751288AbbHCNXh (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 3 Aug 2015 09:23:37 -0400
In-Reply-To: <2599339.pPeKCdCNNQ@diego>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>, linux-rockchip@lists.infradead.org
Cc: shawn.lin@rock-chips.com, Ulf Hansson <ulf.hansson@linaro.org>, Jaehoon Chung <jh80.chung@samsung.com>, Seungwon Jeon <tgih.jun@samsung.com>, addy ke <addy.ke@rock-chips.com>, Weijun Yang <Weijun.Yang@csr.com>, Kevin Hao <haokexin@gmail.com>, Scott Branden <sbranden@broadcom.com>, Andrew Bresticker <abrestic@chromium.org>, Vincent Yang <vincent.yang.fujitsu@gmail.com>, Stephen Boyd <sboyd@codeaurora.org>, dianders@chromium.org, linux-kernel@vger.kernel.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Alim Akhtar <alim.akhtar@samsung.com>, linux-mmc@vger.kernel.org, Jean Delvare <jdelvare@suse.de>

On 2015/8/3 19:17, Heiko St=FCbner wrote:
> Hi Shawn,
>
> Am Montag, 3. August 2015, 11:27:19 schrieb Shawn Lin:
>> DesignWare MMC Controller can support two types of DMA
>> mode: external dma and internal dma. We get a RK312x platform
>> integrated dw_mmc and ARM pl330 dma controller. This patch add
>> edmac ops to suuport these platforms. I've tested it on RK312x
>> platform with edmac mode and RK3288 platform with idmac mode.
>>
>> Patch is based on next of git://git.linaro.org/people/ulf.hansson/mm=
c
>>
>> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
>>
>> ---
>>
>> Changes in v2:
>> - Fix typo of dev_info msg
>> - remove unused dmach from declaration of dw_mci_dma_slave
>>
>>   drivers/mmc/host/Kconfig        |  24 +++++-
>>   drivers/mmc/host/dw_mmc-pltfm.c |   4 +
>>   drivers/mmc/host/dw_mmc.c       | 169
>> ++++++++++++++++++++++++++++++++++++++-- include/linux/mmc/dw_mmc.h =
     |
>> 18 ++++-
>>   4 files changed, 205 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
>> index 6a0f9c7..2a66b08 100644
>> --- a/drivers/mmc/host/Kconfig
>> +++ b/drivers/mmc/host/Kconfig
>> @@ -607,16 +607,36 @@ config MMC_DW
>>   	help
>>   	  This selects support for the Synopsys DesignWare Mobile Storage=
 IP
>>   	  block, this provides host support for SD and MMC interfaces, in=
 both
>> -	  PIO and external DMA modes.
>> +	  PIO, internal DMA mode and external DMA modes.
>> +
>> +choice
>> +	prompt "DesignWare MMC transfer mode"
>> +	depends on MMC_DW
>> +
>> +config MMC_DW_PIO
>> +	bool "Use PIO transfers only"
>> +	help
>> +	  Use PIO to transfer data between memory and the hardware.
>> +	  PIO is slower than DMA as it requires CPU instructions to
>> +	  move the data. This has been the traditional default for
>> +	  the DW MCI driver.
>>
>>   config MMC_DW_IDMAC
>>   	bool "Internal DMAC interface"
>> -	depends on MMC_DW
>>   	help
>>   	  This selects support for the internal DMAC block within the Syn=
opsys
>>   	  Designware Mobile Storage IP block. This disables the external =
DMA
>>   	  interface.
>>
>> +config MMC_DW_EDMAC
>> +	bool "External DMAC interface"
>> +	help
>> +	  This selects support for the external DMAC block outside the Syn=
opsys
>> +	  Designware Mobile Storage IP block. This disables the internal D=
MA
>> +	  interface.
>> +
>> +endchoice
>> +
> more a drive-by comment:
>
> This should definitly not be a "choice". We're in multiplatform times=
, where
> you can have support for a multitude of socs using dw_mmc in one kern=
el. And
> one might want to use pio, one might want to use the internal dma whi=
le
> another one might want to use the external dma.
>
> So which dma to use should definitly be decided at runtime and not at=
 compile-
> time.

Thanks for comment, Heiko.
Definitly it should be decided at runtime. So more DT-bindings' patches=
=20
should be
ACKed as well if we want to remove all the compile-time transfer mode.

Hi, Jaehoon Chung
Any suggestion?

>
> Heiko
>
>
>
>


--=20
Shawn Lin


