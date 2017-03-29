From: Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH v2] mmc: sdio: fix alignment issue in struct sdio_func
Date: Wed, 29 Mar 2017 15:58:10 -0700
Message-ID: <m24lyb667x.fsf@baylibre.com>
References: <3a6258f3-35e3-e2f5-aa6b-e509f603fa45@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pg0-f54.google.com ([74.125.83.54]:35069 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752656AbdC2W6O (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 29 Mar 2017 18:58:14 -0400
Received: by mail-pg0-f54.google.com with SMTP id 81so20514011pgh.2
        for <linux-mmc@vger.kernel.org>; Wed, 29 Mar 2017 15:58:13 -0700 (PDT)
In-Reply-To: <3a6258f3-35e3-e2f5-aa6b-e509f603fa45@gmail.com> (Heiner
        Kallweit's message of "Wed, 29 Mar 2017 22:56:50 +0200")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-amlogic@lists.infradead.org, Helmut Klein <hgkr.klein@gmail.com>

Heiner Kallweit <hkallweit1@gmail.com> writes:

> Certain 64-bit systems (e.g. Amlogic Meson GX) require buffers to be
> used for DMA to be 8-byte-aligned. struct sdio_func has an embedded
> small DMA buffer not meeting this requirement.
> Testing an extension to meson-gx driver for switching to descriptor
> chain mode broke SDIO therefore. Aligning tmpbuf to a 8-byte
> boundary fixed the driver behavior.
>
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> Tested-by: Helmut Klein <hgkr.klein@gmail.com>

Reviewed-by: Kevin Hilman <khilman@baylibre.com>

Kevin
