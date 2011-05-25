From: Andrei Warkentin <andreiw@motorola.com>
Subject: Re: [v6 5/5] MMC: SDHCI AutoCMD23 support.
Date: Tue, 24 May 2011 19:37:34 -0500
Message-ID: <BANLkTinPfqAJ_QqimSipUGvs87sdodL5ZQ@mail.gmail.com>
References: <1305841590-26963-1-git-send-email-andreiw@motorola.com>
	<1306181199-13915-6-git-send-email-andreiw@motorola.com>
	<m3oc2ry90h.fsf@pullcord.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og116.obsmtp.com ([64.18.0.147]:34526 "EHLO
	exprod5og116.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757124Ab1EYAhi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 24 May 2011 20:37:38 -0400
Received: from DE01MGRG01.AM.MOT-MOBILITY.COM ([10.176.130.20])
	by DE01MGRG01.AM.MOT-MOBILITY.COM (8.14.3/8.14.3) with ESMTP id p4P0c7IF000253
	for <linux-mmc@vger.kernel.org>; Tue, 24 May 2011 20:38:07 -0400 (EDT)
Received: from mail-wy0-f170.google.com (mail-wy0-f170.google.com [74.125.82.170])
	by DE01MGRG01.AM.MOT-MOBILITY.COM (8.14.3/8.14.3) with ESMTP id p4P0c6YC000234
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=OK)
	for <linux-mmc@vger.kernel.org>; Tue, 24 May 2011 20:38:07 -0400 (EDT)
Received: by wyb34 with SMTP id 34so6710883wyb.15
        for <linux-mmc@vger.kernel.org>; Tue, 24 May 2011 17:37:34 -0700 (PDT)
In-Reply-To: <m3oc2ry90h.fsf@pullcord.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, arindam.nath@amd.com, arnd@arndb.de, subhashj@codeaurora.org, malchev@google.com, Philip Rakity <prakity@marvell.com>, zhangfei.gao@gmail.com

Hi Chris,

On Tue, May 24, 2011 at 6:27 PM, Chris Ball <cjb@laptop.org> wrote:
> Hi Andrei,
>
> On Mon, May 23 2011, Andrei Warkentin wrote:
>> Enables Auto-CMD23 support where available (SDHCI 3.0 controllers)
>>
>> Cc: arindam.nath@amd.com
>> Cc: cjb@laptop.org
>> Cc: arnd@arndb.de
>> Cc: subhashj@codeaurora.org
>> Cc: malchev@google.com
>> Tested-by: Arindam Nath <arindam.nath@amd.com>
>> Signed-off-by: Andrei Warkentin <andreiw@motorola.com>
>
> Looks like this patch is breaking boot on my XO-1.75/Marvell MMP2 A2
> with SD 3.0 controller. =A0:/
>
> [ =A0 =A01.217156] sdhci: Secure Digital Host Controller Interface dr=
iver
> [ =A0 =A01.223361] sdhci: Copyright(c) Pierre Ossman
> [ =A0 =A01.227793] mmc0: Auto-CMD23 available
> [ =A0 =A01.227793] mmc0: no vmmc regulator found
> [ =A0 =A01.242557] mmc0: SDHCI controller on MMC [sdhci-pxa.0] using =
DMA
> [ =A0 =A01.248748] mmc1: Auto-CMD23 available
> [ =A0 =A01.252479] mmc1: no vmmc regulator found
> [ =A0 =A01.256599] mmc1: SDHCI controller on MMC [sdhci-pxa.1] using =
DMA
> [ =A0 =A01.262694] mmc2: Auto-CMD23 available
> [ =A0 =A01.266571] mmc2: no vmmc regulator found
> [ =A0 =A01.270655] mmc2: SDHCI controller on MMC [sdhci-pxa.2] using =
DMA
> [ =A0 =A01.656280] mmc1: new SDIO card at address 0001
> [ =A0 =A02.423849] libertas: 20:7c:8f:4a:79:c5, fw 9.70.7p0, cap 0x00=
0003a3
> [ =A0 =A02.432951] libertas: wlan0: Marvell WLAN 802.11 adapter
> [ =A0 =A02.438262] Waiting for root device /dev/mmcblk0p2...
> [ =A0 =A02.528607] mmc2: new high speed DDR MMC card at address 0001
> [ =A0 =A02.534597] mmcblk0: mmc2:0001 SEM04G 3.68 GiB
> [ =A0 =A02.539198] mmcblk0boot0: mmc2:0001 SEM04G partition 1 1.00 Mi=
B
> [ =A0 =A02.545166] mmcblk0boot1: mmc2:0001 SEM04G partition 2 1.00 Mi=
B
> [ =A0 =A02.555985] =A0mmcblk0: unknown partition table
> ^^^^^
> [ =A0 =A02.562610] =A0mmcblk0boot1: unknown partition table
> [ =A0 =A02.569715] =A0mmcblk0boot0: unknown partition table
> [ =A0 =A02.663264] VFS: Cannot open root device "mmcblk0p2" or unknow=
n-block(179,2)
>
> With the patch reverted, mmcblk0 comes up with partitions 1 and 2 and
> mmcblk0p2 is mounted. =A0In this log, we fail to find a partition tab=
le
> and panic.
>
> Any ideas/suggestions? =A0I'm surprised that we enabled Auto-CMD23 on=
 this
> hardware; it is a v3 controller, but it has SDHCI_QUIRK_BROKEN_ADMA s=
et..
>

Looks like I am not honoring the broken ADMA flag :(. I was under the
impression that it would have resulted in clearing the ADMA flag
earlier, but looks like I was wrong.

Will resend tomorrow.

A
