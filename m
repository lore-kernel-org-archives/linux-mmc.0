From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH/RFC 5/5] mmc: renesas-sdhi: remove gen3 support from sysc
 dmac driver
Date: Fri, 9 Jun 2017 09:40:46 +0200
Message-ID: <CAMuHMdUUXnpXgoO7O8XtQcusTcHPffkKESVbWO54Yo54179u6A@mail.gmail.com>
References: <1496927368-18897-1-git-send-email-horms+renesas@verge.net.au> <1496927368-18897-8-git-send-email-horms+renesas@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-io0-f178.google.com ([209.85.223.178]:35927 "EHLO
        mail-io0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751515AbdFIHks (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 9 Jun 2017 03:40:48 -0400
In-Reply-To: <1496927368-18897-8-git-send-email-horms+renesas@verge.net.au>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Simon Horman <horms+renesas@verge.net.au>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulf.hansson@linaro.org>, Magnus Damm <magnus.damm@gmail.com>, Linux MMC List <linux-mmc@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>

Hi Simon,

On Thu, Jun 8, 2017 at 3:09 PM, Simon Horman <horms+renesas@verge.net.au> wrote:
> Gen3 SoCs are now supported by the internal dmac variant of the SDHI driver.
> Remove them from the sys dmac variant where only PIO mode is supported.
>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

Is it possible to fall back to PIO with the new DMAC driver?
If not, is this desirable?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
