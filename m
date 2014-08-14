From: Andrew Bresticker <abrestic@chromium.org>
Subject: Re: [PATCH] mmc: dw_mmc: Remove architecture dependency
Date: Wed, 13 Aug 2014 17:13:23 -0700
Message-ID: <CAL1qeaFgySoDs_PWA5FtDK0JQMVoFFfgLbOBz6-dshEg7NCdhQ@mail.gmail.com>
References: <1407951153-918-1-git-send-email-abrestic@chromium.org>
	<CAGOxZ51_cr_j5vWrNO_ZnfAQsvt8zfEjQZC2f-nWv4w9b5R1kQ@mail.gmail.com>
	<1786859.jGWg0DZRp1@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vc0-f179.google.com ([209.85.220.179]:54773 "EHLO
	mail-vc0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751405AbaHNANY (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 13 Aug 2014 20:13:24 -0400
Received: by mail-vc0-f179.google.com with SMTP id hq11so605098vcb.38
        for <linux-mmc@vger.kernel.org>; Wed, 13 Aug 2014 17:13:23 -0700 (PDT)
In-Reply-To: <1786859.jGWg0DZRp1@wuerfel>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Alim Akhtar <alim.akhtar@gmail.com>, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, Seungwon Jeon <tgih.jun@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, Doug Anderson <dianders@chromium.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

> In general, it's best to have specific dependencies on the subsystem
> a driver uses. You probably need something like
>
>         depends on HAS_IOMEM && COMMON_CLK && REGULATOR
>         depends on COMPILE_TEST || ARC || ARM || MIPS
>
> to cover all the possible cases. The specific options are probably
> not the ones I listed above, but you should get the idea. Most importantly,
> you don't want to allow building the driver on architectures on which
> it can't compile.

The only compile-time dependencies I see are HAS_IOMEM (which MMC
already depends on) and HAS_DMA.  There isn't any compile-time
dependency on COMMON_CLK, REGULATOR, GPIOLIB, OF, etc.  I've compiled
it successfully for a few non-ARM/ARC architectures, though that
certainly isn't an exhaustive test.  To be safe though, perhaps I'll
just update the architecture dependency to include MIPS ||
COMPILE_TEST as you suggested.
