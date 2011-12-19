From: Tushar Behera <tushar.behera@linaro.org>
Subject: Re: [PATCH] mmc: sdhci-s3c: Remove old and misprototyped suspend operations
Date: Mon, 19 Dec 2011 10:15:27 +0000 (UTC)
Message-ID: <loom.20111219T110819-762@post.gmane.org>
References: <1321898451-5347-1-git-send-email-broonie@opensource.wolfsonmicro.com> <4ED4F4C4.2020805@samsung.com> <87zkfckvve.fsf@laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:45626 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751840Ab1LSKUM (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 19 Dec 2011 05:20:12 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glkm-linux-mmc@m.gmane.org>)
	id 1RcaKI-0004FL-H6
	for linux-mmc@vger.kernel.org; Mon, 19 Dec 2011 11:20:10 +0100
Received: from 115.113.119.130.static-bangalore.vsnl.net.in ([115.113.119.130.static-bangalore.vsnl.net.in])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mmc@vger.kernel.org>; Mon, 19 Dec 2011 11:20:10 +0100
Received: from tushar.behera by 115.113.119.130.static-bangalore.vsnl.net.in with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mmc@vger.kernel.org>; Mon, 19 Dec 2011 11:20:10 +0100
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Hi,

Chris Ball <cjb <at> laptop.org> writes:

> 
> Hi,
> 
> On Tue, Nov 29 2011, Jaehoon Chung wrote:
> > Acked-by: Jaehoon Chung <jh80.chung <at> samsung.com>
> >
> > On 11/22/2011 03:00 AM, Mark Brown wrote:
> >
> >> Now that the driver is using dev_pm_ops the suspend operations in the
> >> platform_driver structure won't get called so don't need to be there,
> >> and certainly shouldn't be the same function as dev_pm_ops since the
> >> signatures are different.
> >> 
> >> Signed-off-by: Mark Brown <broonie <at> opensource.wolfsonmicro.com>

On Origen board (based on EXYNOS4210), the primary filesystem is on a
SD/MMC card. When tested with v3.2-rc6 kernel, the system doesn't resume
properly.

After resume, it keeps printing following message and the filesystem never
comes up.

mmc0: Timeout waiting for hardware interrupt.

If this patch is reverted, the system is able to mount the filesystem 
successfully.    

Am I missing something?




