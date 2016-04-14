From: Markus Reichl <m.reichl@fivetechno.de>
Subject: Re: [next] Failing Odroid XU3 boot due to missing MMC device
Date: Thu, 14 Apr 2016 10:31:12 +0200
Message-ID: <570F5550.5010708@fivetechno.de>
References: <570F5380.7010103@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <570F5380.7010103@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>, Kukjin Kim <kgene@kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, Javier Martinez Canillas <javier@osg.samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>
List-Id: linux-mmc@vger.kernel.org

Hi Krzysztof,

yes, observed this with linux-next from yesterday 13.

I boot from eMMC.
Device numbering of eMMC and SD are exchanged now.

I solved the boot problem by changing the rootdev in U-Boot env
from /dev/mmcblk0p2 to /dev/mmcblk1p2.

Changed /etc/fdisk, too, to mount /dev/mmcblk1p1 to /boot.     

Regards,
--
Markus Reichl

Am 14.04.2016 um 10:23 schrieb Krzysztof Kozlowski:
> Hi,
> 
> 
> Anyone also observed recent failures of linux-next (20160413, 20160414)
> on booting from SD card? On my Odroid XU3 exynos and multi_v7 configs
> fail with:
> 
> Apr 14 07:52:53 starting version 229
> Apr 14 07:52:53 :: running hook [udev]
> Apr 14 07:52:53 :: Triggering uevents...
> Apr 14 07:52:54 Waiting 10 seconds for device /dev/mmcblk0p1 ...
> Apr 14 07:53:05 ERROR: device '/dev/mmcblk0p1' not found. Skipping fsck.
> Apr 14 07:53:05 ERROR: Unable to find root device '/dev/mmcblk0p1'.
> Apr 14 07:53:05 You are being dropped to a recovery shell
> Apr 14 07:53:05     Type 'exit' to try and continue booting
> Apr 14 07:53:05 sh: can't access tty; job control turned off
> 
> I didn't start bisecting yet... maybe this is known?
> 
> Full logs:
> http://www.krzk.eu/builders/boot-odroid-xu3-exynos/builds/673/steps/Boot%20odroid/logs/serial
> 
> 
> Best regards,
> Krzysztof
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
