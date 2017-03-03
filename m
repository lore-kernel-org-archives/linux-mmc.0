From: Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH v4 0/10] mmc: meson-gx: series with smaller improvements
Date: Fri, 03 Mar 2017 13:19:47 -0800
Message-ID: <m2innq12j0.fsf@baylibre.com>
References: <62912f3d-2307-cfff-3c69-c8b8ffaeb474@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pf0-f179.google.com ([209.85.192.179]:33481 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751869AbdCCWSj (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 3 Mar 2017 17:18:39 -0500
Received: by mail-pf0-f179.google.com with SMTP id w189so37098350pfb.0
        for <linux-mmc@vger.kernel.org>; Fri, 03 Mar 2017 14:18:21 -0800 (PST)
In-Reply-To: <62912f3d-2307-cfff-3c69-c8b8ffaeb474@gmail.com> (Heiner
        Kallweit's message of "Fri, 3 Mar 2017 20:49:33 +0100")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-amlogic@lists.infradead.org

Heiner Kallweit <hkallweit1@gmail.com> writes:

> New series is limited to smaller refactorings w/o functional changes.

I'd reviewed this series before, but hadn't actually tested it until
today.  I applied this series onto today's linux-next, and tested on
meson-gxbb-odroidc2 and the kernel hangs up right after:

       meson-gx-mmc d0072000.mmc: Got CD GPIO

with no error message or oops/backtrace etc.

Could you clarify how you are testing this, on what tree/branch, on what
hardware etc.?

Also, in the cover letter, it's customary to include a summary of what
changed since the previous version(s)

Kevin

> Heiner Kallweit (10):
>   mmc: meson-gx: simplify bounce buffer setting in meson_mmc_start_cmd
>   mmc: meson-gx: make two functions return void
>   mmc: meson-gx: remove unused members irq, ocr_mask from struct meson_host
>   mmc: meson-gx: remove unneeded variable in meson_mmc_clk_init
>   mmc: meson-gx: remove member parent_mux from struct meson_host
>   mmc: meson-gx: remove unneeded meson_mmc_clk_set in meson_mmc_clk_init
>   mmc: meson-gx: remove unneeded devm_kstrdup in meson_mmc_clk_init
>   mmc: meson-gx: improve initial configuration
>   mmc: meson-gx: remove member mrq from struct meson_host
>   mmc: meson-gx: replace magic timeout numbers with constants
>
>  drivers/mmc/host/meson-gx-mmc.c | 126 ++++++++++++++++------------------------
>  1 file changed, 50 insertions(+), 76 deletions(-)
