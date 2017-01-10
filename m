From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 0/2] mmc: sdhci-iproc: Improve bcm2835 performance
Date: Tue, 10 Jan 2017 16:38:56 +0100
Message-ID: <CAPDyKFpWw_MppWqqmVSYCE6AcECq_BLV8GT419o77_8qysagjQ@mail.gmail.com>
References: <1483111474-29907-1-git-send-email-stefan.wahren@i2se.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f51.google.com ([74.125.82.51]:36481 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932135AbdAJPi6 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 10 Jan 2017 10:38:58 -0500
Received: by mail-wm0-f51.google.com with SMTP id c85so131561048wmi.1
        for <linux-mmc@vger.kernel.org>; Tue, 10 Jan 2017 07:38:58 -0800 (PST)
In-Reply-To: <1483111474-29907-1-git-send-email-stefan.wahren@i2se.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Stefan Wahren <stefan.wahren@i2se.com>
Cc: Eric Anholt <eric@anholt.net>, Gerd Hoffmann <kraxel@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, Jon Mason <jonmason@broadcom.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>, linux-rpi-kernel@lists.infradead.org

On 30 December 2016 at 16:24, Stefan Wahren <stefan.wahren@i2se.com> wrote:
> The sdhci-iproc waste a lot performance potential on bcm2835 because of
> missing capabilities in the platform data. This patch series tries to fix
> this.
>
> Raspberry Pi Zero with a class 10 sdhc card
>
> Before:
> dd if=/dev/zero conv=fdatasync of=test bs=8k count=10000
> 81920000 Bytes (82 MB), 11,0044 s, 7,4 MB/s
>
> sudo dd if=/dev/mmcblk0p1 of=/dev/null
> 62914560 Bytes (63 MB), 5,83784 s, 10,8 MB/s
>
> After:
> dd if=/dev/zero conv=fdatasync of=test bs=8k count=10000
> 81920000 Bytes (82 MB), 9,76938 s, 8,4 MB/s
>
> sudo dd if=/dev/mmcblk0p1 of=/dev/null
> 62914560 Bytes (63 MB), 4,73651 s, 13,3 MB/s
>
> Raspberry Pi Compute Module
>
> Before:
> dd if=/dev/zero conv=fdatasync of=test bs=8k count=10000
> 81920000 Bytes (82 MB), 27,4257 s, 3,0 MB/s
>
> sudo dd if=/dev/mmcblk0p1 of=/dev/null
> 66060288 Bytes (66 MB), 21,4365 s, 3,1 MB/s
>
> After:
> dd if=/dev/zero conv=fdatasync of=test bs=8k count=10000
> 81920000 Bytes (82 MB), 7,19661 s, 11,4 MB/s
>
> sudo dd if=/dev/mmcblk0p1 of=/dev/null
> 66060288 Bytes (66 MB), 4,76453 s, 13,9 MB/s
>
> Any tests with a Raspberry Pi 3 (SD and Wifi over SDIO) are welcome.
>
> Stefan Wahren (2):
>   mmc: sdhci-iproc: Apply caps from bcm2835-mmc driver
>   mmc: sdhci-iproc: Increase max_blk_size for bcm2835
>
>  drivers/mmc/host/sdhci-iproc.c |   11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>
> --
> 1.7.9.5
>

Thanks, applied for next!

Kind regards
Uffe
