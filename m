From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 0/2] mmc: sdhci-s3c: remove s3c specific header file
Date: Thu, 26 Jan 2017 09:07:14 +0100
Message-ID: <CAPDyKFq4tUe9=yOrn9eax9h=SM4dXb+0AB+7d_0fDV5TiQDrNg@mail.gmail.com>
References: <CGME20170124092731epcas5p2b0a67832a61f7debbd65ca1d3dab36aa@epcas5p2.samsung.com>
 <20170124092728.19874-1-jh80.chung@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f53.google.com ([74.125.82.53]:34933 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752829AbdAZIHQ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 26 Jan 2017 03:07:16 -0500
Received: by mail-wm0-f53.google.com with SMTP id r126so60507943wmr.0
        for <linux-mmc@vger.kernel.org>; Thu, 26 Jan 2017 00:07:16 -0800 (PST)
In-Reply-To: <20170124092728.19874-1-jh80.chung@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On 24 January 2017 at 10:27, Jaehoon Chung <jh80.chung@samsung.com> wrote:
> Remove the s3c specific header file.
> Ther is no reason to keep the s3c-sdhci-reg header file.
> It can be located into sdhci-s3c.c.
>
> It's more easier to maintain the sdhci-s3c file.
>
> Changelog on V2:
> - Remove "PATCH[2/3] mmc: sdhci-s3c: remove unnecessary defined value"
> - Keep the unused defined value
>
> Jaehoon Chung (2):
>   mmc: sdhci-s3c: remove the sdhci-s3c-regs header file
>   mmc: sdhci-s3c: use the bitops API for bit operation
>
>  drivers/mmc/host/sdhci-s3c-regs.h | 87 ---------------------------------------
>  drivers/mmc/host/sdhci-s3c.c      | 71 +++++++++++++++++++++++++++++++-
>  2 files changed, 70 insertions(+), 88 deletions(-)
>  delete mode 100644 drivers/mmc/host/sdhci-s3c-regs.h
>
> --
> 2.10.2
>

Thanks, applied for next!

Kind regards
Uffe
