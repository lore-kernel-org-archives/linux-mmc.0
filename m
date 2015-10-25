From: Robert Nelson <robertcnelson@gmail.com>
Subject: Re: [PATCH V2 06/11] mmc: sdhci-esdhc-imx: fix cd regression for dt platform
Date: Sun, 25 Oct 2015 15:52:22 -0500
Message-ID: <CAOCHtYgayRZoHxJ2d8f1mO0QW_=N4Mx2_RSCrADKERHdP9TGYQ@mail.gmail.com>
References: <1437569590-5228-1-git-send-email-aisheng.dong@freescale.com>
 <1437569590-5228-7-git-send-email-aisheng.dong@freescale.com>
 <2333b5f060a8e45bd8adcdab55365fab@agner.ch> <CAOMZO5BUKmqczyVgz_WgYmBMeuGugDS4uVjw+LXebxf-nPDTyw@mail.gmail.com>
 <CAOMZO5Dz0KijjryoPihoXsP4b5Wy_5rock++oY=i-9gESThUbg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ig0-f169.google.com ([209.85.213.169]:37653 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751698AbbJYUww (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 25 Oct 2015 16:52:52 -0400
In-Reply-To: <CAOMZO5Dz0KijjryoPihoXsP4b5Wy_5rock++oY=i-9gESThUbg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Stefan Agner <stefan@agner.ch>, Dong Aisheng <aisheng.dong@freescale.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Fabio Estevam <fabio.estevam@freescale.com>, =?UTF-8?B?TWFyZWsgVmHFoXV0?= <marex@denx.de>, Ulf Hansson <ulf.hansson@linaro.org>, Steffen Trumtrar <s.trumtrar@pengutronix.de>, Soeren Moch <smoch@web.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Sascha Hauer <s.hauer@pengutronix.de>, Chris Ball <chris@printf.net>, Rabeeh Khoury <rabeeh@solid-run.com>, Troy Kisky <troy.kisky@boundarydevices.com>, =?UTF-8?Q?Rostislav_Lisov=C3=BD?= <lisovy@gmail.com>, Heiko Schocher <hs@denx.de>, Gwenhael Goavec-Merou <gwenhael.goavec-merou@armadeus.com>, Philipp Zabel <p.zabel@pengutronix.de>, Russell King <rmk+kernel@arm.linux.org.uk>, Shawn Guo <shawn.guo@linaro.org>, Dong Aisheng <b29396@freescale.com>, Tim

On Sat, Oct 24, 2015 at 8:06 AM, Fabio Estevam <festevam@gmail.com> wrote:
> On Tue, Oct 6, 2015 at 7:21 PM, Fabio Estevam <festevam@gmail.com> wrote:
>> Hi Stefan,
>>
>> On Tue, Oct 6, 2015 at 7:15 PM, Stefan Agner <stefan@agner.ch> wrote:
>>> Hi Dong,
>>>
>>> Just hit that issue in 4.1, could we add that patch also to stable?
>>
>> I sent the series to stable, but Greg has not applied it yet.
>
> Greg applied the series and it appears now in 4.1.11.

I need to finish a full bisect run, but one of these sdhci-esdhci-imx
fixes broke the wandboard..

v4.1.10:

voodoo@a3-imx6q-wandboard-2gb:~$ dmesg | grep mmc2
[    4.844563] mmc2: SDHCI controller on 2198000.usdhc [2198000.usdhc]
using ADMA
[    5.132859] mmc2: host does not support reading read-only switch,
assuming write-enable
[    5.147150] mmc2: new high speed SDHC card at address 0007
[    5.153245] mmcblk0: mmc2:0007 SD8GB 7.42 GiB
voodoo@a3-imx6q-wandboard-2gb:~$ dmesg | grep 2198000.usdhc
[    4.779415] sdhci-esdhc-imx 2198000.usdhc: could not get ultra high
speed state, work on normal mode
[    4.788589] sdhci-esdhc-imx 2198000.usdhc: Got CD GPIO
[    4.793910] sdhci-esdhc-imx 2198000.usdhc: No vmmc regulator found
[    4.800133] sdhci-esdhc-imx 2198000.usdhc: No vqmmc regulator found
[    4.844563] mmc2: SDHCI controller on 2198000.usdhc [2198000.usdhc]
using ADMA

v4.1.11:

root@a4-imx6q-wandboard-2gb:~# dmesg | grep mmc2
[    4.854721] mmc2: SDHCI controller on 2198000.usdhc [2198000.usdhc]
using ADMA
root@a4-imx6q-wandboard-2gb:~# dmesg | grep 2198000.usdhc
[    4.781491] sdhci-esdhc-imx 2198000.usdhc: Got CD GPIO
[    4.786689] sdhci-esdhc-imx 2198000.usdhc: could not get ultra high
speed state, work on normal mode
[    4.796023] sdhci-esdhc-imx 2198000.usdhc: No vmmc regulator found
[    4.802229] sdhci-esdhc-imx 2198000.usdhc: No vqmmc regulator found
[    4.854721] mmc2: SDHCI controller on 2198000.usdhc [2198000.usdhc]
using ADMA

Regards,

-- 
Robert Nelson
https://rcn-ee.com/
