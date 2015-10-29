From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [GIT PULL] Update dw-mmc controller
Date: Thu, 29 Oct 2015 11:03:29 +0100
Message-ID: <CAPDyKFr19Az9L0rgKZo4uX-cQXw=S0sYTkOu2=M2z_uJy1Yf8A@mail.gmail.com>
References: <56317A61.9050709@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yk0-f173.google.com ([209.85.160.173]:35320 "EHLO
	mail-yk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751845AbbJ2KDa (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 29 Oct 2015 06:03:30 -0400
Received: by ykek133 with SMTP id k133so36924683yke.2
        for <linux-mmc@vger.kernel.org>; Thu, 29 Oct 2015 03:03:29 -0700 (PDT)
In-Reply-To: <56317A61.9050709@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Dan Carpenter <dan.carpenter@oracle.com>

On 29 October 2015 at 02:46, Jaehoon Chung <jh80.chung@samsung.com> wrote:
> Dear, Ulf.
>
> Here are dw-mmc patches.
> Could you pull these patches into your repository?
> If there is any problem, let me know, plz. Thanks!
>
> Best Regards,
> Jaehoon Chung
>
> The following changes since commit 1c6e58d83615678875bf52747f8841c49291dfcf:
>
>   mmc: pwrseq: Use highest priority for eMMC restart handler (2015-10-27 11:11:06 +0100)
>
> are available in the git repository at:
>
>   https://github.com/jh80chung/dw-mmc.git for-ulf
>
> for you to fetch changes up to 1505969f5972b0c2827a6ab83e5424ff3a465c08:
>
>   mmc: dw_mmc: fix the wrong setting for UHS-DDR50 mode (2015-10-28 22:51:13 +0900)
>
> ----------------------------------------------------------------
> Dan Carpenter (1):
>       mmc: dw_mmc: NULL dereference in error message
>
> Jaehoon Chung (2):
>       mmc: dw_mmc: fix the CardThreshold boundary at CardThrCtl register
>       mmc: dw_mmc: fix the wrong setting for UHS-DDR50 mode
>
>  drivers/mmc/host/dw_mmc.c | 5 ++---
>  drivers/mmc/host/dw_mmc.h | 2 +-
>  2 files changed, 3 insertions(+), 4 deletions(-)

Thanks Jaehoon, pulled into my next branch!

Kind regards
Uffe
