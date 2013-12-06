From: Dinh Nguyen <dinh.linux@gmail.com>
Subject: Re: [PATCH 0/2] mmc: dw_mmc: Make the use of the hold reg generic
Date: Fri, 06 Dec 2013 15:09:51 -0600
Message-ID: <52A23D1F.7080707@gmail.com>
References: <1386346223-18464-1-git-send-email-dinguyen@altera.com> <201312061836.26251.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ob0-f171.google.com ([209.85.214.171]:39888 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758534Ab3LFVKC (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 6 Dec 2013 16:10:02 -0500
Received: by mail-ob0-f171.google.com with SMTP id wp18so1364800obc.30
        for <linux-mmc@vger.kernel.org>; Fri, 06 Dec 2013 13:10:01 -0800 (PST)
In-Reply-To: <201312061836.26251.arnd@arndb.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, dinguyen@altera.com
Cc: cjb@laptop.org, jh80.chung@samsung.com, tgih.jun@samsung.com, heiko@sntech.de, dianders@chromium.org, alim.akhtar@samsung.com, bzhao@marvell.com, linux-mmc@vger.kernel.org


On 12/6/13 11:36 AM, Arnd Bergmann wrote:
> On Friday 06 December 2013, dinguyen@altera.com wrote:
>> From: Dinh Nguyen <dinguyen@altera.com>
>>
>> Hi,
>>
>> This patch series makes the setting of the SDMMC_CMD_USE_HOLD_REG bit generic
>> for all platforms that requires it. According the Synopsys spec on the dw_mmc,
>> setting the SDMMC_CMD_USE_HOLD_REG should be done for all speeds except for the
>> following higher speed modes: SDR104, SDR50, DDR50. I am also include MMC_HS200
>> speed as not needing the SDMMC_CMD_USE_HOLD_REG bit set as well.
>>
>> Currently, Rockchip and SOCFPGA's variant of the dw_mmc requires that the
>> SDMMC_CMD_USE_HOLD_REG be set. For SOCFPGA, the dw_mmc is operating at 
>> MMC_TIMING_SD_HS mode. I don't know Rockchip's variant is operating at.
>>
>
> Very nice, thanks for implementing this!
>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
>
> Obviously this needs to be tested on at least the rockchips variant, but
> ideally on most others too.
Thanks Arnd! But I think I will have to send out a v2 shortly. I missed
a subtle
line in the databook that the hold_reg should be cleared if there is no
clock phase
selected. I think the patch as it stands will break dw_mmc-exynos.

Dinh
>
> 	Arnd

