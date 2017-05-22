From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v5 05/14] MIPS: ingenic: Enable pinctrl for all ingenic SoCs
Date: Mon, 22 May 2017 17:31:20 +0200
Message-ID: <CACRpkdauf5c2i4o5i8QY8YHPNjizkvTu6kAbnquWiP_=v2=KdQ@mail.gmail.com>
References: <20170402204244.14216-2-paul@crapouillou.net> <20170428200824.10906-1-paul@crapouillou.net>
 <20170428200824.10906-6-paul@crapouillou.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-it0-f44.google.com ([209.85.214.44]:37204 "EHLO
        mail-it0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935385AbdEVPbW (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 22 May 2017 11:31:22 -0400
Received: by mail-it0-f44.google.com with SMTP id g126so81614421ith.0
        for <linux-mmc@vger.kernel.org>; Mon, 22 May 2017 08:31:22 -0700 (PDT)
In-Reply-To: <20170428200824.10906-6-paul@crapouillou.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Paul Cercueil <paul@crapouillou.net>, Ralf Baechle <ralf@linux-mips.org>
Cc: Alexandre Courbot <gnurou@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Boris Brezillon <boris.brezillon@free-electrons.com>, Thierry Reding <thierry.reding@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Maarten ter Huurne <maarten@treewalker.org>, Lars-Peter Clausen <lars@metafoo.de>, Paul Burton <paul.burton@imgtec.com>, James Hogan <james.hogan@imgtec.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux MIPS <linux-mips@linux-mips.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>linux

On Fri, Apr 28, 2017 at 10:08 PM, Paul Cercueil <paul@crapouillou.net> wrote:

> There is a pinctrl driver for each of the Ingenic SoCs supported by the
> upstream Linux kernel. In order to switch away from the old GPIO
> platform code, we now enable the pinctrl drivers by default for the
> Ingenic SoCs.
>
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>

I applied all the patches to a branch in pinctrl and merged into my
devel branch for testing:

https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git/
Branch: ingenic

Ralf: are you OK with this? It would be nice to have your ACK on
all patches. If you want you can pull this branch into the MIPS
tree, or we can hope for it all to settle nicely because of low platform
activity in MIPS on this platform, so it only needs to come in
from my trees.

Yours,
Linus Walleij
