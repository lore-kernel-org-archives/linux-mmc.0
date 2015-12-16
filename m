From: Alex Ballas <alex@ballas.org>
Subject: Re: 1217:8520 [Dell Latitude E7450] O2 Micro, SD/MMC Card Reader
 doesn't work
Date: Wed, 16 Dec 2015 11:48:40 +0200
Message-ID: <CAONpWduF6iH4Rr5Y610KP1RE342nWAajR27KFbu1N2iet4R0ZA@mail.gmail.com>
References: <CAONpWdsteBnqTcFbKpcOQFueyeJJWEmn9DJitD43f59xV8sDyg@mail.gmail.com>
	<BY2PR04MB184372CAAC1FA0C5373D73238FEF0@BY2PR04MB1843.namprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ob0-f172.google.com ([209.85.214.172]:35032 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934117AbbLPJsk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 16 Dec 2015 04:48:40 -0500
Received: by mail-ob0-f172.google.com with SMTP id 18so28725194obc.2
        for <linux-mmc@vger.kernel.org>; Wed, 16 Dec 2015 01:48:40 -0800 (PST)
In-Reply-To: <BY2PR04MB184372CAAC1FA0C5373D73238FEF0@BY2PR04MB1843.namprd04.prod.outlook.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Peter Guo <peter.guo@bayhubtech.com>, adam8157@gmail.com
Cc: "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, "linux-mmc@VGER.KERNEL.ORG" <linux-mmc@vger.kernel.org>

Re-adding Adam as the initial mail address is bouncing.

Kind Regards,
Alex


On Wed, Dec 16, 2015 at 5:42 AM, Peter Guo <peter.guo@bayhubtech.com> wrote:
> Hi Alex,
>
> Thanks for your Test, According to your info.
> I find the root cause of this issue is quirks SDHCI_QUIRK2_CLEAR_TRANSFERMODE_REG_BEFORE_CMD is not suitable for our host for
> all cases.  Our host just want to clear SDHCI_TRANS_DMA bit only.
>
> to Adam,
>
> I will commit new patch this week, please check it.
>
>
> BR
> Peter.Guo
>
> -----Original Message-----
> From: Alex Ballas [mailto:alex@ballas.org]
> Sent: Saturday, December 12, 2015 10:04 PM
> To: Peter Guo; adam.lee@canonical.com; ulf.hansson@linaro.org
> Cc: linux-mmc@VGER.KERNEL.ORG
> Subject: 1217:8520 [Dell Latitude E7450] O2 Micro, SD/MMC Card Reader doesn't work
>
> Hello,
>
> I have a Dell Latitude E7450 with a O2 Micro, SD/MMC Card Reader [1217:8520] card reader. When I insert my Sandisk ultra 64GB microSD (with a SD card adapter) I get the following errors.
>
> Dmesg output after I insert the SD card:
>
> [  306.054203] sdhci: Timeout waiting for Buffer Read Ready interrupt during tuning procedure, falling back to fixed sampling clock [  306.055982] mmc0: tuning execution failed [  306.055987] mmc0: error -5 whilst initialising SD card [  306.466185] sdhci: Timeout waiting for Buffer Read Ready interrupt during tuning procedure, falling back to fixed sampling clock [  306.467964] mmc0: tuning execution failed [  306.467970] mmc0: error -5 whilst initialising SD card [  306.890205] sdhci: Timeout waiting for Buffer Read Ready interrupt during tuning procedure, falling back to fixed sampling clock [  306.891993] mmc0: tuning execution failed [  306.892005] mmc0: error -5 whilst initialising SD card [  307.330197] sdhci: Timeout waiting for Buffer Read Ready interrupt during tuning procedure
 , falling back to fixed sampling clock [  307.331980] mmc0: tuning execution failed [  307.331990] mmc0: error -5 whilst initialising SD card
>
> I used the latest mainline kernel available to me [1] $ uname -a Linux cosmo 4.4.0-040400rc4-generic #201512061930 SMP Mon Dec 7
> 00:32:31 UTC 2015 x86_64 x86_64 x86_64 GNU/Linux
>
> It was working fine for kernel versions older than 4.1.8.
>
> I did a bisection and here is the first bad commit
>
>> e6c69099f63c84e1825c0f742a76ff4a8afeaa9b is the first bad commit
>> commit e6c69099f63c84e1825c0f742a76ff4a8afeaa9b
>> Author: Adam Lee <adam.lee@canonical.com>
>> Date:   Mon Aug 3 14:33:28 2015 +0800
>>
>>     mmc: sdhci-pci: set the clear transfer mode register quirk for
>> O2Micro
>>
>>     commit 143b648ddf1583905fa15d32be27a31442fc7933 upstream.
>>
>>     This patch fixes MMC not working issue on O2Micro/BayHub Host, which
>>     requires transfer mode register to be cleared when sending no DMA
>>     command.
>>
>>     Signed-off-by: Peter Guo <peter.guo@bayhubtech.com>
>>     Signed-off-by: Adam Lee <adam.lee@canonical.com>
>>     Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>>     Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>
> I originally logged this issue to the Ubuntu bug tracker[2], but it appears to be an upstream issue and so I was instructed to report here.
> Please note that I use the latest Bios version for the model.
>
> $ sudo dmidecode -s bios-version;sudo dmidecode -s bios-release-date
> A08
> 10/28/2015
>
> [1] http://kernel.ubuntu.com/~kernel-ppa/mainline/v4.4-rc4-wily/
> [2] https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1523178
>
> Thanks,
> Alex
