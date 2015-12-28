From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 0/5] Tegra SDHCI UHS-I support
Date: Mon, 28 Dec 2015 14:18:02 +0100
Message-ID: <CAPDyKFrS=uM7aiC5gOBHw1LWKz=tTatV8DLbMc8xGzGJcRTe5Q@mail.gmail.com>
References: <1450809664-11360-1-git-send-email-dev@lynxeye.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yk0-f175.google.com ([209.85.160.175]:34091 "EHLO
	mail-yk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751999AbbL1NSD (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 28 Dec 2015 08:18:03 -0500
Received: by mail-yk0-f175.google.com with SMTP id a85so25916724ykb.1
        for <linux-mmc@vger.kernel.org>; Mon, 28 Dec 2015 05:18:02 -0800 (PST)
In-Reply-To: <1450809664-11360-1-git-send-email-dev@lynxeye.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Lucas Stach <dev@lynxeye.de>
Cc: Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Alexandre Courbot <gnurou@gmail.com>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>

On 22 December 2015 at 19:40, Lucas Stach <dev@lynxeye.de> wrote:
> Hi all,
>
> this series implements UHS-I signaling for the Tegra SDHCI host,
> which mainly means putting a proper tuning sequence in place.
>
> I've tested this on Jetson TK1 and got the following speed results,
> where mmcblk0 is the on-board eMMC and mmcblk1 is a micro SDXC card:
>
> Without series applied:
> hdparm -t /dev/mmcblk0
>  Timing buffered disk reads:  110 MB in  3.05 seconds =  36.02 MB/sec
> hdparm -t /dev/mmcblk1
>  Timing buffered disk reads:   56 MB in  3.01 seconds =  18.63 MB/sec
>
> With series applied:
> hdparm -t /dev/mmcblk0
>  Timing buffered disk reads:  236 MB in  3.00 seconds =  78.58 MB/sec
> hdparm -t /dev/mmcblk1
>  Timing buffered disk reads:  102 MB in  3.04 seconds =  33.51 MB/sec
>
> Tegra 30 does support UHS-I speeds too, but currently has problems
> when lowering the card voltage, which is needed in order to switch
> to UHS-I signaling. I have some more patches to fix this, but they
> need a bit more cleanup, with them applied the gains on Tegra30 are
> similar to the results above.
>
> For now the gains are limited to Tegra124+, with no regressions on
> Tegra30 and Tegra20.
>
> V2 fixes some minor style problems and is rebased on top of mmc/next.
> This means it enables the same tuning logic on Tegra210 also. I
> don't have a way to test this myself, so any testing on Tegra210 much
> appreciated.
>
> Regards,
> Lucas
>
> Lucas Stach (5):
>   mmc: tegra: implement module external clock change
>   mmc: tegra: disable SPI_MODE_CLKEN
>   mmc: tegra: implement UHS tuning
>   mmc: tegra: enable UHS-I modes
>   mmc: tegra: use correct accessor for misc ctrl register
>
>  drivers/mmc/host/sdhci-tegra.c | 166 ++++++++++++++++++++++++++++++++++-------
>  1 file changed, 138 insertions(+), 28 deletions(-)
>

Thanks, applied for next!

Kind regards
Uffe
