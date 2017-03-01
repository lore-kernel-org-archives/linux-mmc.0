From: Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH 0/4] mmc: add pwrseq-based hw_reset
Date: Wed, 01 Mar 2017 10:01:55 -0800
Message-ID: <m2lgsozxik.fsf@baylibre.com>
References: <db739bb8-2ad1-75bb-0b65-8246f84da7e8@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pf0-f178.google.com ([209.85.192.178]:33574 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750940AbdCATv0 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 1 Mar 2017 14:51:26 -0500
Received: by mail-pf0-f178.google.com with SMTP id w189so13815766pfb.0
        for <linux-mmc@vger.kernel.org>; Wed, 01 Mar 2017 11:50:32 -0800 (PST)
In-Reply-To: <db739bb8-2ad1-75bb-0b65-8246f84da7e8@gmail.com> (Heiner
        Kallweit's message of "Wed, 8 Feb 2017 22:45:52 +0100")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-amlogic@lists.infradead.org

Ulf,

Heiner Kallweit <hkallweit1@gmail.com> writes:

> For implementing ops hw_reset in struct meson_host_ops often we can
> use what is available in pwrseq already, just with a small extension.
> For example all existing pwrseq drivers parse DT for a reset GPIO.

Do you have any thoughts on this series?

Kevin

> Meson GX is the first user of this extension.
>
> Heiner Kallweit (4):
>   mmc: pwrseq: add op reset to struct mmc_pwrseq_ops
>   mmc: pwrseq: implement reset operation in pwrseq_emmc
>   mmc: meson-gx: add pwrseq-based hw_reset
>   ARM64: dts: meson-gxbb-odroidc2: add hw-reset capability flag for emmc port
>
>  arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts | 1 +
>  drivers/mmc/core/core.c                             | 6 ++++++
>  drivers/mmc/core/pwrseq.c                           | 8 ++++++++
>  drivers/mmc/core/pwrseq.h                           | 3 +++
>  drivers/mmc/core/pwrseq_emmc.c                      | 1 +
>  drivers/mmc/host/meson-gx-mmc.c                     | 1 +
>  include/linux/mmc/core.h                            | 1 +
>  7 files changed, 21 insertions(+)
