From: Paul Mansfield <paul@mansfield.co.uk>
Subject: Re: mmc driver read/write detect problem with Baytrail tablet
Date: Wed, 1 Jul 2015 23:07:42 +0100
Message-ID: <CAGwpYodfH6JZbgaWrt_K14At5-ZMK=4eMZ4RNmuQxxMMYLsodg@mail.gmail.com>
References: <CAGwpYodzn4TGiCp7L1+KQgb+JreMx2y07wgRmUsDHG-3fwetLg@mail.gmail.com>
 <CAOyx1Loar=hRrqgbuQqWuy4XswoLcNP6Wr5X+jdapt9PxA3P9Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f175.google.com ([209.85.212.175]:35610 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752321AbbGAWID (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 1 Jul 2015 18:08:03 -0400
Received: by wiga1 with SMTP id a1so137291208wig.0
        for <linux-mmc@vger.kernel.org>; Wed, 01 Jul 2015 15:08:02 -0700 (PDT)
In-Reply-To: <CAOyx1Loar=hRrqgbuQqWuy4XswoLcNP6Wr5X+jdapt9PxA3P9Q@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On 30 June 2015 at 17:06, Venkatraman S <svenkatr@gmail.com> wrote:
>> Is there some way to override the mmc driver read-only/write-protect
>> function to force the driver to allow writing?
>>
> Are the reads working properly ?
> Can you enable MMC_DEBUG in the kernel config to collect more information ?

reading works perfectly

I rebuilt the kernel with mmc debug and this is what I see when card
inserted and removed and reinserted into the internal slot

[  318.037007] mmc2: new high speed SD card at address d750
[  318.038705] mmcblk2: mmc2:d750 SD02G 1.87 GiB (ro)
[  318.041391]  mmcblk2: p1
[  318.042616] byt-rt5640 byt-rt5640: ASoC: CPU DAI baytrail-pcm-audio
not registered
[  336.411190] mmc2: card d750 removed
[  345.169863] mmc2: new high speed SD card at address d750
[  345.171302] mmcblk2: mmc2:d750 SD02G 1.87 GiB (ro)
[  345.173070]  mmcblk2: p1
