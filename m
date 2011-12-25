From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: sdhci-s3c: Remove old and misprototyped suspend operations
Date: Sat, 24 Dec 2011 21:29:39 -0500
Message-ID: <m239c9z8mk.fsf@bob.laptop.org>
References: <1321898451-5347-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<4ED4F4C4.2020805@samsung.com> <87zkfckvve.fsf@laptop.org>
	<loom.20111219T110819-762@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:55668 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754186Ab1LYC3u (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 24 Dec 2011 21:29:50 -0500
In-Reply-To: <loom.20111219T110819-762@post.gmane.org> (Tushar Behera's
	message of "Mon, 19 Dec 2011 10:15:27 +0000 (UTC)")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Tushar Behera <tushar.behera@linaro.org>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Kukjin Kim <kgene.kim@samsung.com>, linux-mmc@vger.kernel.org

Hi,

On Mon, Dec 19 2011, Tushar Behera wrote:
>> >> Now that the driver is using dev_pm_ops the suspend operations in the
>> >> platform_driver structure won't get called so don't need to be there,
>> >> and certainly shouldn't be the same function as dev_pm_ops since the
>> >> signatures are different.
>> >> 
>> >> Signed-off-by: Mark Brown <broonie <at> opensource.wolfsonmicro.com>
>
> On Origen board (based on EXYNOS4210), the primary filesystem is on a
> SD/MMC card. When tested with v3.2-rc6 kernel, the system doesn't resume
> properly.
>
> After resume, it keeps printing following message and the filesystem never
> comes up.
>
> mmc0: Timeout waiting for hardware interrupt.
>
> If this patch is reverted, the system is able to mount the filesystem 
> successfully.    
>
> Am I missing something?

Mark/Jaehoon?  This looks very bad.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
