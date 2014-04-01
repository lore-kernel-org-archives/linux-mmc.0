From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 2/6] mmc: sh-mmcif: use devm_ for ioremap
Date: Tue, 1 Apr 2014 12:55:11 +0200
Message-ID: <CAMuHMdVB6ZB0rnH5ekRd=NCy3zbFSTf0BSH3J48yDhF2YbNoCA@mail.gmail.com>
References: <1396347954-13740-1-git-send-email-ben.dooks@codethink.co.uk>
	<1396347954-13740-3-git-send-email-ben.dooks@codethink.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1396347954-13740-3-git-send-email-ben.dooks@codethink.co.uk>
Sender: linux-sh-owner@vger.kernel.org
To: Ben Dooks <ben.dooks@codethink.co.uk>
Cc: Linux MMC List <linux-mmc@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, magnus.damm@opensource.se, linux-kernel@lists.codethink.co.uk
List-Id: linux-mmc@vger.kernel.org

On Tue, Apr 1, 2014 at 12:25 PM, Ben Dooks <ben.dooks@codethink.co.uk> wrote:
> +       reg = devm_ioremap_resource(&pdev->dev, res);
> +       if (IS_ERR(reg)) {
>                 dev_err(&pdev->dev, "ioremap error.\n");

devm_ioremap_resource() already calls dev_err() for the various error
cases, so you can drop this line.

>                 return -ENOMEM;

return PTR_ERR(reg);

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
