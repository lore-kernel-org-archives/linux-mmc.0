From: Alan Cooper <alcooperx@gmail.com>
Subject: Re: [PATCH] mmc: core: Optimize boot time by detecting cards simultaneously
Date: Thu, 17 Dec 2015 14:47:21 -0500
Message-ID: <CAOGqxeWw-qcRNV=4GDbh6znvd6Wh4yOtFcZtua3QuX8ZExGCBw@mail.gmail.com>
References: <1448982916-21485-1-git-send-email-ulf.hansson@linaro.org>
	<CAPDyKFq3iuDkJgUGFV7Y4jLB37T=6Nkzf56bJ-a2RxHjy4fE=A@mail.gmail.com>
	<5670A0BA.8090402@samsung.com>
	<CAPDyKFpF+rqv1WQ0Hu-YdAM1pdNwKyKjFsAg1BfeEj=kDfH0Ag@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qg0-f50.google.com ([209.85.192.50]:35686 "EHLO
	mail-qg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754981AbbLQTrW (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 17 Dec 2015 14:47:22 -0500
Received: by mail-qg0-f50.google.com with SMTP id v36so16049232qgd.2
        for <linux-mmc@vger.kernel.org>; Thu, 17 Dec 2015 11:47:22 -0800 (PST)
In-Reply-To: <CAPDyKFpF+rqv1WQ0Hu-YdAM1pdNwKyKjFsAg1BfeEj=kDfH0Ag@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc <linux-mmc@vger.kernel.org>

On Wed, Dec 16, 2015 at 4:07 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> To find the improved card detection times, I just used the kernel boot
> log and checked the time stamps for when the cards get detected. I ran
> the tests ~10 times and picked up some average values.
>
> To notice the improvement you need at least two cards to be inserted
> during boot. Perhaps you have a platform with one eMMC and one SD card
> slot, you can test.

I tested the patch on one of our ARM bases SoC's. The SoC has an SD
card slot on the first controller and an eMMC device on the second
controller. I found ~100ms improvement on the time it took for the
rootfs on the eMMC device to be ready for use. Interestingly, I did
see the SD/eMMC order swap once in 20 tries. This is not an issue for
us as we already have to use UUID for the eMMC rootfs in case an SD
card is installed.

Al
