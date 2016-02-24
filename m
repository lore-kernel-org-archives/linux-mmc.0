From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] mmc: sh_mmcif, tmio: Use ARCH_RENESAS
Date: Wed, 24 Feb 2016 08:38:07 +0100
Message-ID: <CAMuHMdX=b9ezL8zd4XoPwYQkr9RwJ3j11Z2=Lmmx-qnL+L6tHw@mail.gmail.com>
References: <1456281573-16458-1-git-send-email-horms+renesas@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-io0-f182.google.com ([209.85.223.182]:34908 "EHLO
	mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755067AbcBXHiI (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 24 Feb 2016 02:38:08 -0500
In-Reply-To: <1456281573-16458-1-git-send-email-horms+renesas@verge.net.au>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Simon Horman <horms+renesas@verge.net.au>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Ian Molton <ian@mnementh.co.uk>, Magnus Damm <magnus.damm@gmail.com>, Linux MMC List <linux-mmc@vger.kernel.org>, linux-renesas-soc@vger.kernel.org

On Wed, Feb 24, 2016 at 3:39 AM, Simon Horman
<horms+renesas@verge.net.au> wrote:
> Make use of ARCH_RENESAS in place of ARCH_SHMOBILE.
>
> This is part of an ongoing process to migrate from ARCH_SHMOBILE to
> ARCH_RENESAS the motivation for which being that RENESAS seems to be a more
> appropriate name than SHMOBILE for the majority of Renesas ARM based SoCs.
>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
