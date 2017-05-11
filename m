From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v5 04/14] GPIO: Add gpio-ingenic driver
Date: Thu, 11 May 2017 13:06:47 +0200
Message-ID: <CACRpkdb+uQpdOfCFTKaMvp=nUxksA0=FWCDbY+JbB_=jDDcXfA@mail.gmail.com>
References: <20170402204244.14216-2-paul@crapouillou.net> <20170428200824.10906-1-paul@crapouillou.net>
 <20170428200824.10906-5-paul@crapouillou.net> <3a779fca-5a56-44e5-2acf-12b8abdaf906@crapouillou.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-io0-f171.google.com ([209.85.223.171]:35850 "EHLO
        mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751920AbdEKLGt (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 11 May 2017 07:06:49 -0400
Received: by mail-io0-f171.google.com with SMTP id o12so18919645iod.3
        for <linux-mmc@vger.kernel.org>; Thu, 11 May 2017 04:06:48 -0700 (PDT)
In-Reply-To: <3a779fca-5a56-44e5-2acf-12b8abdaf906@crapouillou.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Paul Cercueil <paul@crapouillou.net>
Cc: Alexandre Courbot <gnurou@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Ralf Baechle <ralf@linux-mips.org>, Boris Brezillon <boris.brezillon@free-electrons.com>, Thierry Reding <thierry.reding@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Maarten ter Huurne <maarten@treewalker.org>, Lars-Peter Clausen <lars@metafoo.de>, Paul Burton <paul.burton@imgtec.com>, James Hogan <james.hogan@imgtec.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux MIPS <linux-mips@linux-mips.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>"linux-mtd@lists.infradead.org" <li>

On Mon, May 8, 2017 at 12:05 AM, Paul Cercueil <paul@crapouillou.net> wrote:

> It looks like the gpio_get_value() is broken on jz4740.
>
> I'll send a v6.

OK I don't apply this series then, waiting for v6.

The series looks good so as soon you think it is finished
I can apply it I think.

Yours,
Linus Walleij
