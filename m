From: Tushar Behera <tushar.behera@linaro.org>
Subject: Re: [PATCH] mmc: sdhci-s3c: Remove old and misprototyped suspend
 operations
Date: Mon, 26 Dec 2011 11:30:54 +0530
Message-ID: <4EF80D96.1010503@linaro.org>
References: <1321898451-5347-1-git-send-email-broonie@opensource.wolfsonmicro.com> <4ED4F4C4.2020805@samsung.com> <87zkfckvve.fsf@laptop.org> <loom.20111219T110819-762@post.gmane.org> <m239c9z8mk.fsf@bob.laptop.org> <4EF7D3DE.5060907@samsung.com> <4EF8008D.5060502@linaro.org> <4EF804D6.3000609@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:32947 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750720Ab1LZGA7 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 26 Dec 2011 01:00:59 -0500
Received: by iaeh11 with SMTP id h11so18392699iae.19
        for <linux-mmc@vger.kernel.org>; Sun, 25 Dec 2011 22:00:59 -0800 (PST)
In-Reply-To: <4EF804D6.3000609@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Chris Ball <cjb@laptop.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Kukjin Kim <kgene.kim@samsung.com>, linux-mmc@vger.kernel.org

Hi Jaehoon,

On 12/26/2011 10:53 AM, Jaehoon Chung wrote:
> Hi Tushar.
>
> Did you test with linux-3.2-rc6?
> I checked the linux-3.2-rc6..that version may be missed the dev_pm_ops patch..
> (Manuel's patch [PATCH v4] mmc: sdhci: remove "state" argument from sdhci_suspend_host)
>
> I didn't understand this condition.
>
> That patch is include in linux-3.2-rc7.
>

Thanks for the information. I ran the tests with linux-3.2-rc7 and 
everything seems great.

> To Chris.
> If adopt "sdhci-s3c: remove Old and misprototyped suspend operation"
> I think that Manuel's patch must be include in liux-3.2-rc6
>
> Thanks,
> Jaehoon Chung
>

-- 
Tushar Behera
