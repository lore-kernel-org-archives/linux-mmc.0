From: Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH 0/6] mmc: meson-gx: further smaller refactorings
Date: Fri, 24 Mar 2017 11:58:17 -0700
Message-ID: <m2lgruijsm.fsf@baylibre.com>
References: <8bf58a83-d8d7-615c-c89b-87a62a3c9c40@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pf0-f174.google.com ([209.85.192.174]:34550 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965753AbdCXS6U (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 24 Mar 2017 14:58:20 -0400
Received: by mail-pf0-f174.google.com with SMTP id p189so4636922pfp.1
        for <linux-mmc@vger.kernel.org>; Fri, 24 Mar 2017 11:58:19 -0700 (PDT)
In-Reply-To: <8bf58a83-d8d7-615c-c89b-87a62a3c9c40@gmail.com> (Heiner
        Kallweit's message of "Wed, 22 Mar 2017 22:16:40 +0100")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-amlogic@lists.infradead.org

Heiner Kallweit <hkallweit1@gmail.com> writes:

> Before we come to the functional changes here one more series with
> smaller refactorings.

Indeed, in looking at the DMA support series, my suggestion was going to
be to separate out the minor cleanups into a separate series.  Thanks
for anticipating that.

In the future, please also describe in the cover letter what platforms
this series was tested on.

Otherwise, this series looks good to me.  Thanks again for your
continued work in improving this driver.  It's greatly appreciated!

For the series:

Reviewed-by: Kevin Hilman <khilman@baylibre.com>

Kevin
