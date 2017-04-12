From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 0/2] mmc: meson-gx: add basic tuning
Date: Wed, 12 Apr 2017 16:11:38 +0200
Message-ID: <CAPDyKFo17FaKET6_irR7ybQDq3kKT1YProXnS=gouF+9Mk2FLw@mail.gmail.com>
References: <1d60ec2c-54c9-6b1c-7eaa-40e96fcd5be5@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ua0-f169.google.com ([209.85.217.169]:33476 "EHLO
        mail-ua0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751123AbdDLOLj (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 12 Apr 2017 10:11:39 -0400
Received: by mail-ua0-f169.google.com with SMTP id q26so16910816uaa.0
        for <linux-mmc@vger.kernel.org>; Wed, 12 Apr 2017 07:11:39 -0700 (PDT)
In-Reply-To: <1d60ec2c-54c9-6b1c-7eaa-40e96fcd5be5@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Kevin Hilman <khilman@baylibre.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-amlogic@lists.infradead.org

On 4 April 2017 at 20:58, Heiner Kallweit <hkallweit1@gmail.com> wrote:
> With a 128GB Hardkernel eMMC card my Odroid C2 boots up to 60MHz only
> (tons of CRC errors otherwise). I made some tests and with changed
> clock phase configuration it runs rock-solid with 200 MHz.
> Changing the clock phase configuration in general most likely wouldn't
> be a good idea as this might break other combinations of MMC device and
> speed.
> Therefore add basic tuning. So far it changes the rx clock phase only
> as default core and tx clock phase work fine.
>
> Heiner Kallweit (2):
>   mmc: meson-gx: introduce struct meson_tuning_params
>   mmc: meson-gx: add basic tuning for rx clock phase
>
>  drivers/mmc/host/meson-gx-mmc.c | 66 ++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 65 insertions(+), 1 deletion(-)
>
> --
> 2.12.1
>

Thanks, applied for next!

Kind regards
Uffe
