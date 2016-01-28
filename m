From: Scott Branden <sbranden@broadcom.com>
Subject: Re: [PATCH 0/3] mmc: sdhci-iproc: add bcm2835 support
Date: Wed, 27 Jan 2016 16:36:51 -0800
Message-ID: <56A962A3.2090205@broadcom.com>
References: <1453933542-30287-1-git-send-email-stefan.wahren@i2se.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-gw3-out.broadcom.com ([216.31.210.64]:63127 "EHLO
	mail-gw3-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965780AbcA1AhA (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 27 Jan 2016 19:37:00 -0500
In-Reply-To: <1453933542-30287-1-git-send-email-stefan.wahren@i2se.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Stefan Wahren <stefan.wahren@i2se.com>, Ray Jui <rjui@broadcom.com>, Jon Mason <jonmason@broadcom.com>, Stephen Warren <swarren@wwwdotorg.org>, Lee Jones <lee@kernel.org>, Eric Anholt <eric@anholt.net>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>, Ulf Hansson <ulf.hansson@linaro.org>, kernel@martin.sperl.org, devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, jszhang@marvell.com, shawn.lin@rock-chips.com, bcm-kernel-feedback-list@broadcom.com

Looks clean Stefan.  I'll try and revisit the caps setting in the future 
and may be able to provide additional settings in a later patch.

This patch series:
Acked-by: Scott Branden <sbranden@broadcom.com>


On 16-01-27 02:25 PM, Stefan Wahren wrote:
> This patch series based on the suggestion of Scott Branden to implement
> bcm2835 support into sdhci-iproc [1].
>
> These changes provide the following advantages:
>    * no need to maintain a separate driver for bcm2835
>    * improve support and test coverage of bcm2835 mmc support
>    * get the rid of SDHCI_CAPABILITIES hack in bcm2835_sdhci_readl
>    * increase write performance by avoiding delays in write ops
>
> Patch 1 prepare sdhci-iproc for another platform. Patch 2 and 3
> are the actually changes for bcm2835 support.
>
> These series has been tested on Raspberry Pi B with dd (direct I/O):
>
> sdhci-bcm2835
>
> 378 kB/s WRITE
> 10,6 MB/s READ
>
> sdhci-iproc (after applying patch series)
>
> 881 kB/s WRITE
> 10,8 MB/s READ
>
> Changes since RFC:
>    * drop patch which tries to add quirks for bcm2835 in DT and define all
>      quirks in driver instead to keep old DTs working with sdhci-iproc
>      (suggestion by Stephen Warren)
>    * define MMC caps in shdci-iproc platform data to make adding new
>      platforms more easily (suggestion by Stephen Warren)
>
> [1] - https://lkml.org/lkml/2015/12/22/525
>
> Stefan Wahren (3):
>    mmc: sdhci-iproc: define MMC caps in platform data
>    mmc: sdhci-iproc: add bcm2835 support
>    DT: sdhci-iproc: add bcm2835 compatible
>
>   .../devicetree/bindings/mmc/brcm,sdhci-iproc.txt   |    5 ++++-
>   drivers/mmc/host/Kconfig                           |    6 +++---
>   drivers/mmc/host/sdhci-iproc.c                     |   20 ++++++++++++++++++--
>   3 files changed, 25 insertions(+), 6 deletions(-)
>

