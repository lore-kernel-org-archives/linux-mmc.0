From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 0/6] mmc: meson-gx: further smaller refactorings
Date: Fri, 24 Mar 2017 08:21:37 +0100
Message-ID: <CAPDyKFppy2ujL3Oeyfjp=gnLGtBVLmw1YrXzZ-pRque6D-iTfA@mail.gmail.com>
References: <8bf58a83-d8d7-615c-c89b-87a62a3c9c40@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vk0-f53.google.com ([209.85.213.53]:34457 "EHLO
        mail-vk0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751406AbdCXHVj (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 24 Mar 2017 03:21:39 -0400
Received: by mail-vk0-f53.google.com with SMTP id z204so6432683vkd.1
        for <linux-mmc@vger.kernel.org>; Fri, 24 Mar 2017 00:21:38 -0700 (PDT)
In-Reply-To: <8bf58a83-d8d7-615c-c89b-87a62a3c9c40@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Kevin Hilman <khilman@baylibre.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-amlogic@lists.infradead.org

On 22 March 2017 at 22:16, Heiner Kallweit <hkallweit1@gmail.com> wrote:
> Before we come to the functional changes here one more series with
> smaller refactorings.
>
> Heiner Kallweit (6):
>   mmc: meson-gx: remove unneeded configuration bit resets
>   mmc: meson-gx: replace cmd->data in meson_mmc_start_cmd
>   mmc: meson-gx: improve variable usage in meson_mmc_start_cmd
>   mmc: meson-gx: improve response reading
>   mmc: meson-gx: improve setting data->bytes_xfered
>   mmc: meson-gx: simplify setting timeout configuration parameters
>
>  drivers/mmc/host/meson-gx-mmc.c | 104 ++++++++++++++++++----------------------
>  1 file changed, 47 insertions(+), 57 deletions(-)
>
> --
> 2.12.0
>

Thanks, applied for next!

Kind regards
Uffe
