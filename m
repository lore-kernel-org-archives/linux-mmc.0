From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 2/3 v3] mmc: sh_mmcif: cleanup to use dev instead of &pdev->dev
Date: Tue, 21 Apr 2015 12:07:58 +0200
Message-ID: <CAMuHMdXike0vh5bTmyALN08hDOU7M4kfN3oSPJgX4n_42QZQ6w@mail.gmail.com>
References: <873840a4ch.wl%kuninori.morimoto.gx@renesas.com>
	<87vbgpubvr.wl%kuninori.morimoto.gx@renesas.com>
	<87sibtubtg.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ob0-f177.google.com ([209.85.214.177]:33400 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752266AbbDUKH7 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 21 Apr 2015 06:07:59 -0400
In-Reply-To: <87sibtubtg.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, Simon <horms@verge.net.au>, Magnus <magnus.damm@gmail.com>, Linux-SH <linux-sh@vger.kernel.org>, Laurent <laurent.pinchart@ideasonboard.com>, kobayashi <keita.kobayashi.ym@renesas.com>

On Tue, Apr 21, 2015 at 10:27 AM, Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> Tested-by: Keita Kobayashi <keita.kobayashi.ym@renesas.com>

Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
