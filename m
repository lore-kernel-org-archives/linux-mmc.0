From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] mmc: host: tmio: disable clocks when unbinding
Date: Wed, 18 Jan 2017 09:29:18 +0100
Message-ID: <CAMuHMdVU5jARZSC_EMaqPo9BAz+PG_OPevuF9VTzAVJPoF2UsQ@mail.gmail.com>
References: <20170117202601.3742-1-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-io0-f193.google.com ([209.85.223.193]:36473 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751510AbdARIgk (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 18 Jan 2017 03:36:40 -0500
In-Reply-To: <20170117202601.3742-1-wsa@the-dreams.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Linux MMC List <linux-mmc@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Simon Horman <horms@verge.net.au>, Chris Brandt <chris.brandt@renesas.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>

On Tue, Jan 17, 2017 at 9:26 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
>
> Create a helper function to disable clocks and use it in remove(), too.
> Now, clk_summary in debugfs reports the clocks as disabled and
> unprepared after unbinding.
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
