From: Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH 0/4] mmc: meson-gx: smaller functional extensions
Date: Fri, 24 Mar 2017 16:21:05 -0700
Message-ID: <m2inmydzxa.fsf@baylibre.com>
References: <f6960395-370e-16b0-1a2a-2a1fce720d45@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pf0-f172.google.com ([209.85.192.172]:32960 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934479AbdCXXVI (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 24 Mar 2017 19:21:08 -0400
Received: by mail-pf0-f172.google.com with SMTP id o190so1839110pfo.0
        for <linux-mmc@vger.kernel.org>; Fri, 24 Mar 2017 16:21:07 -0700 (PDT)
In-Reply-To: <f6960395-370e-16b0-1a2a-2a1fce720d45@gmail.com> (Heiner
        Kallweit's message of "Fri, 24 Mar 2017 23:01:48 +0100")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-amlogic@lists.infradead.org

Heiner Kallweit <hkallweit1@gmail.com> writes:

> This series includes the switch to bitfield macros and a few smaller
> functional extensions.

Again, would be most helpful to to list in the cover letter the
platforms where this was tested, and in the case of perf improvments
like this, describing any changes in performance.

Thanks,

Kevin
