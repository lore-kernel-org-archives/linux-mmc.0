From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Subject: Re: [PATCH 0/6] mmc: sdhci-s3c: Fix base clock source management
Date: Sun, 12 Jan 2014 22:18 +0100
Message-ID: <1704043.sYrCOYas4N@phil>
References: <1389476346-20396-1-git-send-email-tomasz.figa@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1389476346-20396-1-git-send-email-tomasz.figa@gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Tomasz Figa <tomasz.figa@gmail.com>
Cc: linux-mmc@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Ben Dooks <ben-linux@fluff.org>, Chris Ball <chris@printf.net>, Jaehoon Chung <jh80.chung@samsung.com>, Seungwon Jeon <tgih.jun@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>
List-Id: linux-mmc@vger.kernel.org

Am Samstag, 11. Januar 2014, 22:39:00 schrieb Tomasz Figa:
> Tested on S3C6410-based Mini6410 board, with following performance
> figures:
> 
> * Before this series (133 MHz HCLK always selected, leading to at most
>   33 MHz card clock):
>
> root@tiny6410:~# hdparm -t /dev/mmcblk0
> 
> /dev/mmcblk0:
>  Timing buffered disk reads:  42 MB in  3.10 seconds =  13.54 MB/sec

# hdparm -t /dev/mmcblk0

/dev/mmcblk0:
 Timing buffered disk reads: 44 MB in  3.12 seconds =  14.11 MB/sec


> * After this series (48 MHz EPLL clock selected, leading to 48 MHz card
>   clock):
>
> root@tiny6410:~# hdparm -t /dev/mmcblk0
> 
> /dev/mmcblk0:
>  Timing buffered disk reads:  56 MB in  3.04 seconds =  18.41 MB/sec

# hdparm -t /dev/mmcblk0

/dev/mmcblk0:
 Timing buffered disk reads: 48 MB in  3.01 seconds =  15.94 MB/sec


So on a s3c2416:
Tested-by: Heiko Stuebner <heiko@sntech.de>
Acked-by: Heiko Stuebner <heiko@sntech.de>


Thanks for the added bandwidth :-)
Heiko
