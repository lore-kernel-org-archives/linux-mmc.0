From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [next] Failing Odroid XU3 boot due to missing MMC device
Date: Thu, 14 Apr 2016 17:28:34 +0900
Message-ID: <570F54B2.2070704@samsung.com>
References: <570F5380.7010103@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:54409 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750738AbcDNI2i (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 14 Apr 2016 04:28:38 -0400
In-reply-to: <570F5380.7010103@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>, Kukjin Kim <kgene@kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, Javier Martinez Canillas <javier@osg.samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>

Hi,

On 04/14/2016 05:23 PM, Krzysztof Kozlowski wrote:
> Hi,> 
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

Refer to the below thread.

https://patchwork.kernel.org/patch/8769361/

Best Regards,
Jaehoon Chung

> 
> Full logs:
> http://www.krzk.eu/builders/boot-odroid-xu3-exynos/builds/673/steps/Boot%20odroid/logs/serial
> 
> 
> Best regards,
> Krzysztof
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 

