From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v5 0/10] mmc: meson-gx: series with smaller improvements
Date: Tue, 14 Mar 2017 17:21:02 +0100
Message-ID: <CAPDyKFpZw7oK-WeSqPyYqTLU5GE+ZrrA7rL-FNn1+Um7h+E+4Q@mail.gmail.com>
References: <a76c3483-2c86-85c1-446e-f2522bd28aa8@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ua0-f181.google.com ([209.85.217.181]:34701 "EHLO
        mail-ua0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752946AbdCNQVE (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 14 Mar 2017 12:21:04 -0400
Received: by mail-ua0-f181.google.com with SMTP id f54so168119067uaa.1
        for <linux-mmc@vger.kernel.org>; Tue, 14 Mar 2017 09:21:03 -0700 (PDT)
In-Reply-To: <a76c3483-2c86-85c1-446e-f2522bd28aa8@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Kevin Hilman <khilman@baylibre.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-amlogic@lists.infradead.org

On 4 March 2017 at 13:17, Heiner Kallweit <hkallweit1@gmail.com> wrote:
> New series is limited to smaller refactorings w/o functional changes.
>
> v5:
> - fix a hang caused by patch "improve initial configuration"
>
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
>  drivers/mmc/host/meson-gx-mmc.c | 120 ++++++++++++++++------------------------
>  1 file changed, 47 insertions(+), 73 deletions(-)
>
> --
> 2.12.0
>
>

Thanks, applied for next!

Kind regards
Uffe
