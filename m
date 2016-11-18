From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 0/2] MMC: davinci: fix card detect and write protect
Date: Fri, 18 Nov 2016 15:29:49 +0100
Message-ID: <CAPDyKFp=tVkY_2t7ZEPzgK=mQ-Ce3JvWcebuch2=Mvh3RSn7aw@mail.gmail.com>
References: <20161115162822.25791-1-ahaslam@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f51.google.com ([74.125.82.51]:33631 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753860AbcKRO3w (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 18 Nov 2016 09:29:52 -0500
Received: by mail-wm0-f51.google.com with SMTP id c184so6185562wmd.0
        for <linux-mmc@vger.kernel.org>; Fri, 18 Nov 2016 06:29:51 -0800 (PST)
In-Reply-To: <20161115162822.25791-1-ahaslam@baylibre.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Axel Haslam <ahaslam@baylibre.com>
Cc: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@baylibre.com>, David Lechner <david@lechnology.com>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 15 November 2016 at 17:28, Axel Haslam <ahaslam@baylibre.com> wrote:
> This series fixes the card detect and write protect parsing for
> the davinci_mmc driver, and takes care of a technical debt to
> remove card polling when a card detect gpio is available.
>
> In the case of a platform based boot we register the gpios
> using the APIs provided by slot-gpio.
>
> In the case of a DT based boot we use the mmc_of_parse API to parse
> all DT properties and register the gpios.
>
> If this series is accepted, the next series will convert all users
> to use gpio descriptors and we could then remove the platform
> callbacks.
>
> This was tested on the omap138-lcdk, and the da850-evm, with
> additional patches to platform data and dts files.
>
> Axel Haslam (2):
>   MMC: davinci: use mmc_of_parse to parse common mmc configuration
>   MMC: davinci: request gpios using gpio descriptors
>
>  drivers/mmc/host/davinci_mmc.c | 130 +++++++++++++++++++++--------------------
>  1 file changed, 66 insertions(+), 64 deletions(-)
>
> --
> 2.10.1
>

Thanks, applied for next!

Kind regards
Uffe
