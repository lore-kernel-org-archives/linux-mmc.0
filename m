From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v2 02/22] mmc: renesas_sdhi: remove wrong depends on to
 enable compile test
Date: Sun, 26 Nov 2017 10:02:59 +0100
Message-ID: <CAMuHMdV4q1n6tPe8Q_g6s3G+0P1_xCxvt6X4tW4FGyubM4WOjA@mail.gmail.com>
References: <1511540697-27387-1-git-send-email-yamada.masahiro@socionext.com> <1511540697-27387-3-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qt0-f195.google.com ([209.85.216.195]:40453 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752064AbdKZJDA (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 26 Nov 2017 04:03:00 -0500
In-Reply-To: <1511540697-27387-3-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Linux MMC List <linux-mmc@vger.kernel.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Simon Horman <simon.horman@netronome.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>

On Fri, Nov 24, 2017 at 5:24 PM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> ARCH_RENESAS is a stronger condition than (ARM || ARM64).
> If ARCH_RENESAS is enabled, (ARM || ARM64) is met as well.
>
> What is worse, the first depends on line prevents COMPILE_TEST from
> enabling this driver.  It should be removed.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> Acked-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
