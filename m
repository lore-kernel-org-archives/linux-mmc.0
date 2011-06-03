From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: irq flood with mmc boot partitions on s3c2416 with 3.0rc1
Date: Fri, 03 Jun 2011 11:01:35 +0530
Message-ID: <4DE871B7.1080007@ti.com>
References: <201106022149.47936.heiko@sntech.de> <BANLkTi=xVzdLDq5wbzLtQFu+nz=8G9SbKQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:41396 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752700Ab1FCFbl (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 3 Jun 2011 01:31:41 -0400
Received: by mail-gy0-f180.google.com with SMTP id 2so881785gyf.39
        for <linux-mmc@vger.kernel.org>; Thu, 02 Jun 2011 22:31:40 -0700 (PDT)
In-Reply-To: <BANLkTi=xVzdLDq5wbzLtQFu+nz=8G9SbKQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kyungmin Park <kmpark@infradead.org>
Cc: =?ISO-8859-1?Q?Heiko_St=FCbner?= <heiko@sntech.de>, linux-mmc@vger.kernel.org, andreiw@motorola.com, linux-arm-kernel@lists.infradead.org

On 6/3/2011 5:18 AM, Kyungmin Park wrote:
> Hi,
>
> Interesting, I also use the latest kernel and boot well.
> As I don't have the s3c2416 user manaul, I'm not sure it's support
> AUTO CMD12 or not. but at least it's support at s3c6410 and later.
>
> [    1.355000] sdhci: Secure Digital Host Controller Interface driver
> [    1.360000] sdhci: Copyright(c) Pierre Ossman
> [    1.365000] s3c-sdhci s3c-sdhci.0: clock source 2: sclk_mmc (50000000 Hz)
> [    1.375000] mmc0: SDHCI controller on samsung-hsmmc [s3c-sdhci.0] using ADMA
> [    1.380000] s3c-sdhci s3c-sdhci.2: clock source 2: sclk_mmc (50000000 Hz)
> [    1.385000] mmc1: no vmmc regulator found
> [    1.390000] mmc1: SDHCI controller on samsung-hsmmc [s3c-sdhci.2] using ADMA
> [    1.400000] s3c-sdhci s3c-sdhci.3: clock source 2: sclk_mmc (50000000 Hz)
> [    1.405000] mmc2: no vmmc regulator found
> [    1.410000] mmc2: SDHCI controller on samsung-hsmmc [s3c-sdhci.3] using ADMA
> ...
> [    1.435000] Waiting for root device /dev/mmcblk0p3...
> [    1.650000] mmc0: new high speed MMC card at address 0001
> [    1.655000] mmcblk0: mmc0:0001 SEM08G 7.39 GiB
> [    1.660000] mmcblk0boot0: mmc0:0001 SEM08G partition 1 1.00 MiB
> [    1.665000] mmcblk0boot1: mmc0:0001 SEM08G partition 2 1.00 MiB
> [    1.675000]  mmcblk0: p1 p2 p3 p4<  p5 p6>
> [    1.680000]  mmcblk0boot1: unknown partition table
> [    1.685000]  mmcblk0boot0: unknown partition table
>
> I also check the external SD card.
>
There seems to some regression in MMC statck. I too observed
lot of interrupts from MMC and I2C with V3.0-rc1 on OMAP.

Regards
Santosh
