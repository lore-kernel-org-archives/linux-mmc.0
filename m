From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 0/2] mmc: rtsx_pci: Enable support for erase/discard/trim requests
Date: Wed, 27 Jul 2016 14:45:00 +0200
Message-ID: <CAPDyKFrfsB7ChroiJ_z1Rq5ohaidrg=veSa0fWNi50V6BBB0Hw@mail.gmail.com>
References: <1469622338-11158-1-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:38390 "EHLO
	mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755309AbcG0MpE (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 27 Jul 2016 08:45:04 -0400
Received: by mail-wm0-f41.google.com with SMTP id o80so60659266wme.1
        for <linux-mmc@vger.kernel.org>; Wed, 27 Jul 2016 05:45:03 -0700 (PDT)
In-Reply-To: <1469622338-11158-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Mauro Santos <registo.mailling@gmail.com>
Cc: Micky Ching <micky_ching@realsil.com.cn>, Ulf Hansson <ulf.hansson@linaro.org>, Wei WANG <wei_wang@realsil.com.cn>, linux-mmc <linux-mmc@vger.kernel.org>, Roger Tseng <rogerable@realtek.com>, Baolin Wang <baolin.wang@linaro.org>

On 27 July 2016 at 14:25, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> To enable the rtsx_pci driver to support erase/discard/trim, it needs to manage
> timeouts for R1B responses according to the expecations from the mmc core. Fix
> this and then enable MMC_CAP_ERASE.
>
> Ulf Hansson (2):
>   mmc: rtsx_pci: Use the provided busy timeout from the mmc core
>   mmc: rtsx_pci: Enable MMC_CAP_ERASE to allow erase/discard/trim
>     requests
>
>  drivers/mmc/host/rtsx_pci_sdmmc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> --
> 1.9.1
>

Mauro, I have applied this for my next branch (based on 4.7), to allow
it to be easily tested.

Just clone my tree below and build/replace your kernel.
git://git.linaro.org/people/ulf.hansson/mmc.git next

Running fstrim and checking blkdiscard should be sufficient as test cases.

Don't hesitate to ask if problems occurs!

Kind regards
Uffe
