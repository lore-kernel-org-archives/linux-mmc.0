From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 0/2] mmc: renesas_sdhi and tmio: bugfixes for v4.14
Date: Fri, 20 Oct 2017 12:03:48 +0200
Message-ID: <CAPDyKFp5rtmNiQgkpiaBfnLP4ERePY8ckvF+MTPajbG6G+Rorg@mail.gmail.com>
References: <1508469162-12322-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-it0-f68.google.com ([209.85.214.68]:54343 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752649AbdJTKDt (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 20 Oct 2017 06:03:49 -0400
Received: by mail-it0-f68.google.com with SMTP id 72so12858703itk.3
        for <linux-mmc@vger.kernel.org>; Fri, 20 Oct 2017 03:03:49 -0700 (PDT)
In-Reply-To: <1508469162-12322-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>

On 20 October 2017 at 05:12, Yoshihiro Shimoda
<yoshihiro.shimoda.uh@renesas.com> wrote:
> This patch set is based on mainline v4.14-rc5.
>
> Changes from v1:
>  - Calculate the max size of swiotlb memory instead of hardcoded value
>    in patch 1.
>  - Add Reviewed-by from Geert-san in patch 2. (Geert-san, thanks!)
>
> Yoshihiro Shimoda (2):
>   mmc: tmio: fix swiotlb buffer is full
>   mmc: renesas_sdhi: fix kernel panic in _internal_dmac.c
>
>  drivers/mmc/host/renesas_sdhi_internal_dmac.c | 17 ++++++++++-------
>  drivers/mmc/host/tmio_mmc_core.c              | 13 +++++++++++++
>  2 files changed, 23 insertions(+), 7 deletions(-)
>
> --
> 1.9.1
>

Thanks, applied for fixes!

Kind regards
Uffe
