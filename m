From: Mark Jackson <mpfj-list@newflow.co.uk>
Subject: Re: ARM: AM335x: Kernel oops when using EDMA and MMC
Date: Wed, 17 Jul 2013 17:28:37 +0100
Message-ID: <51E6C635.5020506@newflow.co.uk>
References: <51E6BE84.6080905@newflow.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <51E6BE84.6080905@newflow.co.uk>
Sender: linux-omap-owner@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Cc: Matt Porter <mporter@ti.com>, Tony Lindgren <tony@atomide.com>, Joel Fernandes <joelf@ti.com>, Linux MMC List <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Balaji TK <balajitk@ti.com>
List-Id: linux-mmc@vger.kernel.org

On 17/07/13 16:55, Mark Jackson wrote:
> I'm trying to get the MMC port working on our custom AM3352 CPU board.
> 
> I have added MMC entries to out dts file (similar to [1]), and I've
> enabled CONFIG_TI_EDMA.
> 
> Our board boots fine without an SD card inserted ...
> 
> [    0.000000] Booting Linux on physical CPU 0x0
> [    0.000000] Linux version 3.11.0-rc1-00025-g95b9b72 (mpfj@mpfj-nanobone) (gcc version 4.6.3 (Buildroot 2013.02-dirty) ) #309 Wed Jul 17 16:37:28 BST 2013
> ...
> [    2.789028] VFS: Mounted root (ubifs filesystem) on device 0:12.
> [    2.797268] devtmpfs: mounted
> [    2.801032] Freeing unused kernel memory: 200K (c0551000 - c0583000)
> ...
> Welcome to Buildroot
> nanobone login:

I have just noticed the following in the boot log:-

...
[    1.225698] omap_hsmmc 48060000.mmc: unable to obtain RX DMA engine channel 3227000204
...
