From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 0/5] mmc: meson-gx: add cmd23 and descriptor chain mode
Date: Fri, 24 Mar 2017 08:27:59 +0100
Message-ID: <CAPDyKFrE97s3LohQDspy+9qDRfxC+ybcY_3FdLqpXupitqN2jw@mail.gmail.com>
References: <f1f8dae2-e976-4d42-99dc-34d08cb3d628@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vk0-f46.google.com ([209.85.213.46]:36332 "EHLO
        mail-vk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751511AbdCXH2B (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 24 Mar 2017 03:28:01 -0400
Received: by mail-vk0-f46.google.com with SMTP id s68so6508189vke.3
        for <linux-mmc@vger.kernel.org>; Fri, 24 Mar 2017 00:28:00 -0700 (PDT)
In-Reply-To: <f1f8dae2-e976-4d42-99dc-34d08cb3d628@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Kevin Hilman <khilman@baylibre.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-amlogic@lists.infradead.org

On 15 March 2017 at 20:16, Heiner Kallweit <hkallweit1@gmail.com> wrote:
> Apart from three minor improvements this patch series adds support
> for CMD23 mode and switches the driver to descriptor chain mode.
>
> On my system with a 128GB eMMC card this increased the read
> performance from 10 - 15 MB/s to 140 MB/s.
>
> Successfully tested on a Odroid C2 with custom uboot based on recent
> mainline uboot. Behavior might be different with vendor uboot.
>
> Heiner Kallweit (5):
>   mmc: meson-gx: switch irq name to DT node name
>   mmc: meson-gx: improve response reading
>   mmc: meson-gx: use block mode also for just one block
>   mmc: meson-gx: add support for CMD23 mode
>   mmc: meson-gx: switch to descriptor chain mode
>
>  drivers/mmc/host/meson-gx-mmc.c | 258 ++++++++++++++++++++++------------------
>  1 file changed, 142 insertions(+), 116 deletions(-)
>
> --
> 2.12.0
>

Heiner,

As I just applied the series for the "small refactoring", how do you
want me to handle this one. Is it safe to apply on top or do you need
to re-base it?

Kind regards
Uffe
