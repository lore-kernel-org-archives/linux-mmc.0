From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Rebasing mmc/next
Date: Tue, 20 Jun 2017 09:17:51 +0200
Message-ID: <CAMuHMdW=aasYmZz-z+BgT0Qoco6DTyQxN3G1wiWVPETsbkRZTQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-io0-f170.google.com ([209.85.223.170]:36715 "EHLO
        mail-io0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751007AbdFTHRw (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 20 Jun 2017 03:17:52 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Linux MMC List <linux-mmc@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>

Hi Ulf,

It looks like you rebase mmc/next almost daily. Is there any specific reason
for that?

I'm asking because I create a "renesas-drivers" tree on a regular basis
(cfr. e.g. https://www.spinics.net/lists/linux-renesas-soc/msg15111.html).
This tree is meant to ease development of platform support and drivers
for Renesas ARM SoCs. It is created by merging (a) the for-next branches
of various subsystem trees and (b) branches with driver code submitted
or planned for submission to maintainers into the development branch of
Simon Horman's renesas.git tree.

If for (b), people submit driver code based on mmc/next, it may start
to conflict
with subsequent mmc/next releases soon, requiring the submitter or me to
rebase the code before including it in renesas-drivers.

Most subsystem maintainers don't rebase their for-next branch, unless there's
a very good reason for it (e.g. a serious breakage hindering bisection).

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
