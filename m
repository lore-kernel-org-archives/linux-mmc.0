From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 3/3] mmc: core: support hs speed mode if hs200 mode fails
Date: Mon, 16 May 2016 11:32:41 +0200
Message-ID: <CAPDyKFqyZRYbSoRMcJuMks+GMWAH9wDpusY+cvcH=GfVCNwSeg@mail.gmail.com>
References: <1461171092-30631-1-git-send-email-aisheng.dong@nxp.com>
	<1461171092-30631-3-git-send-email-aisheng.dong@nxp.com>
	<1463130397.3151.13.camel@toradex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:34184 "EHLO
	mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753575AbcEPJcn (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 16 May 2016 05:32:43 -0400
Received: by mail-wm0-f46.google.com with SMTP id v200so14007022wmv.1
        for <linux-mmc@vger.kernel.org>; Mon, 16 May 2016 02:32:42 -0700 (PDT)
In-Reply-To: <1463130397.3151.13.camel@toradex.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Marcel Ziswiler <marcel.ziswiler@toradex.com>, "aisheng.dong@nxp.com" <aisheng.dong@nxp.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "jonathanh@nvidia.com" <jonathanh@nvidia.com>, "dev@lynxeye.de" <dev@lynxeye.de>, "chris@printf.net" <chris@printf.net>, "shawnguo@kernel.org" <shawnguo@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "haibo.chen@nxp.com" <haibo.chen@nxp.com>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "adrian.hunter@intel.com" <adrian.hunter@intel.com>, "dongas86@gmail.com" <dongas86@gmail.com>

On 13 May 2016 at 11:06, Marcel Ziswiler <marcel.ziswiler@toradex.com> wrote:
> On Thu, 2016-04-21 at 00:51 +0800, Dong Aisheng wrote:
>> Currently if mmc_select_hs200 mode switch fails, MMC core
>> can only use legacy mode to run the card.
>> Let's retry HS speed mode if HS200 fails.
>>
>> Before the fix:
>> mmc0: mmc_select_hs200 failed, error -74
>> : switch to mmc0 failed
>> mmc0: new MMC card at address 0001
>> mmcblk0: mmc0:0001 Q2J55L 7.12 GiB
>> mmcblk0boot0: mmc0:0001 Q2J55L partition 1 2.00 MiB
>> mmcblk0boot1: mmc0:0001 Q2J55L partition 2 2.00 MiB
>> mmcblk0rpmb: mmc0:0001 Q2J55L partition 3 4.00 MiB
>>  mmcblk0: p1 p2
>>
>> After the fix:
>> mmc0: mmc_select_hs200 failed, error -74
>> mmc0: new DDR MMC card at address 0001
>> mmcblk0: mmc0:0001 Q2J55L 7.12 GiB
>> mmcblk0boot0: mmc0:0001 Q2J55L partition 1 2.00 MiB
>> mmcblk0boot1: mmc0:0001 Q2J55L partition 2 2.00 MiB
>> mmcblk0rpmb: mmc0:0001 Q2J55L partition 3 4.00 MiB
>>  mmcblk0: p1 p2
>>
>> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
>> ---
>>  drivers/mmc/core/mmc.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
>> index 55c8201..b573dc7 100644
>> --- a/drivers/mmc/core/mmc.c
>> +++ b/drivers/mmc/core/mmc.c
>> @@ -1315,7 +1315,8 @@ static int mmc_select_timing(struct mmc_card
>> *card)
>>
>>       if (card->mmc_avail_type & EXT_CSD_CARD_TYPE_HS200)
>>               err = mmc_select_hs200(card);
>> -     else if (card->mmc_avail_type & EXT_CSD_CARD_TYPE_HS)
>> +
>> +     if (err && (card->mmc_avail_type & EXT_CSD_CARD_TYPE_HS))
>>               err = mmc_select_hs(card);
>>
>>       if (err && err != -EBADMSG)
>
>
> This seems to break on TK1 where eMMC so far was detected as an 8-bit
> high speed MMC card. With this patch it reverts to detecting a 1-bit only
> MMC card! This has been observed both on a NVIDIA's Jetson TK1 as well as
> our new Toradex Apalis TK1 (CC Tegra mailing list, Jon Hunter and Lucas
> Stach as well). So far T30 is not affected as there we are still doing
> full HS200 with whatever issues that has.
>
> Before:
> [    3.726894] sdhci: Secure Digital Host Controller Interface driver
> [    3.733081] sdhci: Copyright(c) Pierre Ossman
> [    3.737462] sdhci-pltfm: SDHCI platform and OF driver helper
> [    3.753411] mmc0: Unknown controller version (3). You may experience
>  problems.
> [    3.768345] mmc0: Invalid maximum block size, assuming 512 bytes
> [    3.814896] mmc0: SDHCI controller on 700b0600.sdhci [700b0600.sdhci]
>  using ADMA 64-bit
> [    3.892088] mmc0: new high speed MMC card at address 0001
> [    3.899194] mmcblk0: mmc0:0001 SEM16G 14.7 GiB
> [    3.904217] mmcblk0boot0: mmc0:0001 SEM16G partition 1 4.00 MiB
> [    3.910645] mmcblk0boot1: mmc0:0001 SEM16G partition 2 4.00 MiB
> [    3.917119] mmcblk0rpmb: mmc0:0001 SEM16G partition 3 4.00 MiB
> [    3.926006]  mmcblk0: p1 p2 p3 p4 p5 p6 p7 p8 p9
> root@jetson_tk1:~# cat /sys/kernel/debug/mmc0/ios
> clock:          52000000 Hz
> actual clock:   51000000 Hz
> vdd:            21 (3.3 ~ 3.4 V)
> bus mode:       2 (push-pull)
> chip select:    0 (don't care)
> power mode:     2 (on)
> bus width:      3 (8 bits)
> timing spec:    1 (mmc high-speed)
> signal voltage: 0 (3.30 V)
> driver type:    0 (driver type B)
>
> After:
> [    3.899918] mmc0: new MMC card at address 0001
> root@jetson_tk1:~# cat /sys/kernel/debug/mmc0/ios
> clock:          25000000 Hz
> actual clock:   24727273 Hz
> vdd:            21 (3.3 ~ 3.4 V)
> bus mode:       2 (push-pull)
> chip select:    0 (don't care)
> power mode:     2 (on)
> bus width:      0 (1 bits)
> timing spec:    0 (legacy)
> signal voltage: 0 (3.30 V)
> driver type:    0 (driver type B)
>

Thanks for testing and reporting. I have dropped this patch from my
next branch for now.

Kind regards
Uffe
