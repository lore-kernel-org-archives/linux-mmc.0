From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [RFC PATCH 1/6] mmc: tmio: make tmio_mmc_request function more readable
Date: Tue, 2 May 2017 12:18:02 +0200
Message-ID: <CAMuHMdVwaF7ia3jGyiWr_yqM4qqXvBtNsWy9fzWBF1jdgUCZow@mail.gmail.com>
References: <20170501090346.10801-1-wsa+renesas@sang-engineering.com> <20170501090346.10801-2-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-it0-f65.google.com ([209.85.214.65]:33096 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750789AbdEBKSE (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 2 May 2017 06:18:04 -0400
In-Reply-To: <20170501090346.10801-2-wsa+renesas@sang-engineering.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Linux MMC List <linux-mmc@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>

On Mon, May 1, 2017 at 11:03 AM, Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> This part confused me and I had to read it twice until I got it. Let's
> follow the standard pattern to bail out if something is wrong and keep
> in the body of the function when everything is as expected.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
