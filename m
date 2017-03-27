From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 0/4] mmc: meson-gx: smaller functional extensions
Date: Mon, 27 Mar 2017 10:22:28 +0200
Message-ID: <CAPDyKFo0QFh104AM5Q=60_89Owjm+nnt1b5yPiB9koJnsdaRKQ@mail.gmail.com>
References: <aae9e7c7-d8a2-72b1-22f7-f0ad513d4667@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vk0-f43.google.com ([209.85.213.43]:35799 "EHLO
        mail-vk0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751406AbdC0IWa (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 27 Mar 2017 04:22:30 -0400
Received: by mail-vk0-f43.google.com with SMTP id r69so42944024vke.2
        for <linux-mmc@vger.kernel.org>; Mon, 27 Mar 2017 01:22:29 -0700 (PDT)
In-Reply-To: <aae9e7c7-d8a2-72b1-22f7-f0ad513d4667@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Kevin Hilman <khilman@baylibre.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-amlogic@lists.infradead.org

On 25 March 2017 at 11:20, Heiner Kallweit <hkallweit1@gmail.com> wrote:
> This series includes the switch to bitfield macros and a few smaller
> functional extensions.
>
> Successfully tested on a Odroid C2 (S905GXBB) with a 128GB eMMC.
>
> Measured with a simple
> dd if=/dev/mmcblk0 of=/dev/null iflag=direct bs=100M count=1
> read performance increases from 13.5 MB/s to 16.8 MB/s by
> switching to CMD23 mode.
>
> v2:
> - removed few unused defines
> - improved name of function to get timeout value
>
> Heiner Kallweit (4):
>   mmc: meson-gx: use bitfield macros
>   mmc: meson-gx: use per port interrupt names
>   mmc: meson-gx: switch to dynamic timeout values
>   mmc: meson-gx: add CMD23 mode
>
>  drivers/mmc/host/meson-gx-mmc.c | 129 ++++++++++++++++++++++------------------
>  1 file changed, 70 insertions(+), 59 deletions(-)
>
> --
> 2.12.0
>

Thanks, applied for next! I amended the changelog for patch 1,
according to comment from Chris.

Kind regards
Uffe
