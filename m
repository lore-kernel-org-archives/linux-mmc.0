From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 8/9] mmc: sh_mobile_sdhi: remove .init/.cleanup
Date: Mon, 5 Jan 2015 10:02:02 +0100
Message-ID: <CAMuHMdVTQ1nsZYb7U07MaAt0OcmxKEBoD35NbP9TM7SE97tcQQ@mail.gmail.com>
References: <87zj9xogln.wl%kuninori.morimoto.gx@renesas.com>
	<87oaqdoghr.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-la0-f42.google.com ([209.85.215.42]:46609 "EHLO
	mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753539AbbAEJCE (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 5 Jan 2015 04:02:04 -0500
In-Reply-To: <87oaqdoghr.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <cjb@laptop.org>, Simon <horms@verge.net.au>, Linux-SH <linux-sh@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>

Hi Morimoto-san,

On Mon, Jan 5, 2015 at 8:03 AM, Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>
> No one is using .init/.cleanup callback function.
> Let's remove these.
>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>  drivers/mmc/host/sh_mobile_sdhi.c  |   26 +-------------------------
>  include/linux/mmc/sh_mobile_sdhi.h |   15 ---------------
>  2 files changed, 1 insertion(+), 40 deletions(-)
>
> diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mobile_sdhi.c
> index f8268b7..eae229f 100644
> --- a/drivers/mmc/host/sh_mobile_sdhi.c
> +++ b/drivers/mmc/host/sh_mobile_sdhi.c
> @@ -156,15 +156,6 @@ static int sh_mobile_sdhi_multi_io_quirk(struct mmc_card *card,
>         return blk_size;
>  }
>
> -static void sh_mobile_sdhi_cd_wakeup(const struct platform_device *pdev)
> -{
> -       mmc_detect_change(platform_get_drvdata(pdev), msecs_to_jiffies(100));
> -}
> -
> -static const struct sh_mobile_sdhi_ops sdhi_ops = {
> -       .cd_wakeup = sh_mobile_sdhi_cd_wakeup,
> -};
> -

Is this intentional?

While .cd_wakeup looks indeed unused, you forgot to mention its removal in
the patch description.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
