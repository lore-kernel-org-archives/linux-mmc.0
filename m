From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 3/3] mmc: renesas_sdhi: implement R-Car Gen[123] fallback
 compatibility strings
Date: Fri, 13 Oct 2017 13:24:09 +0200
Message-ID: <CAMuHMdVtObaF6w1OVzo6XeX1oKb0WxzWomPCpGm5sx4PuSZiNQ@mail.gmail.com>
References: <20171013103812.30826-1-horms+renesas@verge.net.au> <20171013103812.30826-4-horms+renesas@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34139 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751564AbdJMLYL (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 13 Oct 2017 07:24:11 -0400
In-Reply-To: <20171013103812.30826-4-horms+renesas@verge.net.au>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Simon Horman <horms+renesas@verge.net.au>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulf.hansson@linaro.org>, Magnus Damm <magnus.damm@gmail.com>, Linux MMC List <linux-mmc@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>

On Fri, Oct 13, 2017 at 12:38 PM, Simon Horman
<horms+renesas@verge.net.au> wrote:
> Implement fallback compatibility strings for R-Car Gen 1, 2 and 3.
>
> In the case of Renesas R-Car hardware we know that there are generations of
> SoCs, f.e. Gen 1 and 2. But beyond that its not clear what the relationship
> between IP blocks might be. For example, I believe that r8a7790 is older
> than r8a7791 but that doesn't imply that the latter is a descendant of the
> former or vice versa.
>
> We can, however, by examining the documentation and behaviour of the
> hardware at run-time observe that the current driver implementation appears
> to be compatible with the IP blocks on SoCs within a given generation.
>
> For the above reasons and convenience when enabling new SoCs a
> per-generation fallback compatibility string scheme being adopted for
> drivers for Renesas SoCs.
>
> Also, improve readability by listing the shmobile fallback compatibility
> string after the more-specific compatibility strings they provide a
> fallback for.
>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
