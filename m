From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v2 1/2] mmc: tmio: fix swiotlb buffer is full
Date: Fri, 20 Oct 2017 09:29:43 +0200
Message-ID: <CAMuHMdUTty4-ogi=cFL51Gz7eaDC5QW2Tm+xQzXENQTs8re4rg@mail.gmail.com>
References: <1508469162-12322-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <1508469162-12322-2-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:51754 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752581AbdJTH3p (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 20 Oct 2017 03:29:45 -0400
In-Reply-To: <1508469162-12322-2-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulf.hansson@linaro.org>, Linux MMC List <linux-mmc@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>

On Fri, Oct 20, 2017 at 5:12 AM, Yoshihiro Shimoda
<yoshihiro.shimoda.uh@renesas.com> wrote:
> Since the commit de3ee99b097d ("mmc: Delete bounce buffer handling")
> deletes the bounce buffer handling, a request data size will be referred
> to max_{req,seg}_size instead of MMC_QUEUE_BOUNCESZ (64k bytes).
>
> In other hand, renesas_sdhi_internal_dmac.c will set very big value of
> max_{req,seg}_size because the max_blk_count is set to 0xffffffff.
> And then, "swiotlb buffer is full" happens because swiotlb can handle
> a memory size up to 256k bytes only (IO_TLB_SEGSIZE = 128 and
> IO_TLB_SHIFT = 11).
>
> So, as a workaround, this patch avoids the issue by setting
> the max_{req,seg}_size up to 256k bytes if swiotlb is running.
>
> Reported-by: Dirk Behme <dirk.behme@de.bosch.com>
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
