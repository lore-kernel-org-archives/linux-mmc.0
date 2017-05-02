From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [RFC PATCH 2/6] mmc: tmio: refactor handling mrq
Date: Tue, 2 May 2017 12:18:47 +0200
Message-ID: <CAMuHMdWYfmauwb6QLgr168P7Mw9q6ADV-RxhZsrm5a0Actg8Ww@mail.gmail.com>
References: <20170501090346.10801-1-wsa+renesas@sang-engineering.com> <20170501090346.10801-3-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-it0-f67.google.com ([209.85.214.67]:35026 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750955AbdEBKSt (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 2 May 2017 06:18:49 -0400
In-Reply-To: <20170501090346.10801-3-wsa+renesas@sang-engineering.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Linux MMC List <linux-mmc@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>

On Mon, May 1, 2017 at 11:03 AM, Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> Split handling mrq into a seperate function. We need to call it from
> another place soon.
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
