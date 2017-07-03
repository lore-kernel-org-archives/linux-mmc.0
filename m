From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v5 05/14] MIPS: ingenic: Enable pinctrl for all ingenic SoCs
Date: Mon, 3 Jul 2017 11:07:09 +0200
Message-ID: <CACRpkdb=Zti+C+2me_WP0=m6z12G5Kz+W_cPcZsw=CVzBO_wAg@mail.gmail.com>
References: <20170402204244.14216-2-paul@crapouillou.net> <20170428200824.10906-1-paul@crapouillou.net>
 <20170428200824.10906-6-paul@crapouillou.net> <CACRpkdauf5c2i4o5i8QY8YHPNjizkvTu6kAbnquWiP_=v2=KdQ@mail.gmail.com>
 <1499013301.1477.0@smtp.crapouillou.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-io0-f174.google.com ([209.85.223.174]:32989 "EHLO
        mail-io0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753370AbdGCJHL (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 3 Jul 2017 05:07:11 -0400
Received: by mail-io0-f174.google.com with SMTP id h64so53411627iod.0
        for <linux-mmc@vger.kernel.org>; Mon, 03 Jul 2017 02:07:10 -0700 (PDT)
In-Reply-To: <1499013301.1477.0@smtp.crapouillou.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Paul Cercueil <paul@crapouillou.net>
Cc: Ralf Baechle <ralf@linux-mips.org>, Alexandre Courbot <gnurou@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Boris Brezillon <boris.brezillon@free-electrons.com>, Thierry Reding <thierry.reding@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Maarten ter Huurne <maarten@treewalker.org>, Lars-Peter Clausen <lars@metafoo.de>, Paul Burton <paul.burton@imgtec.com>, James Hogan <james.hogan@imgtec.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux MIPS <linux-mips@linux-mips.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>"linux-mtd@lists.infradead.org" <li>

On Sun, Jul 2, 2017 at 6:35 PM, Paul Cercueil <paul@crapouillou.net> wrote:
> Hi Linus,
>
>> I applied all the patches to a branch in pinctrl and merged into my
>> devel branch for testing:
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git/
>> Branch: ingenic
>>
>> Ralf: are you OK with this? It would be nice to have your ACK on
>> all patches. If you want you can pull this branch into the MIPS
>> tree, or we can hope for it all to settle nicely because of low platform
>> activity in MIPS on this platform, so it only needs to come in
>> from my trees.
>
>
> There has been no word from Ralf, is this going into 4.13?

Yes.

Yours,
Linus Walleij
