From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH v2 3/6] pinctrl: sh-pfc: r8a7790: Add separate functions for SDHI 1.8V operation
Date: Tue, 30 Jun 2015 11:30:14 +0300
Message-ID: <35893480.E0l0AdJZnQ@avalon>
References: <1433892104.12074.49.camel@codethink.co.uk> <11872302.fE1vlhM93k@avalon> <CACRpkdbcrW-AQxpBd-w-FrBKZ8tDTtkeAG_mutYOqk8mNV1LJQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <CACRpkdbcrW-AQxpBd-w-FrBKZ8tDTtkeAG_mutYOqk8mNV1LJQ@mail.gmail.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Ben Hutchings <ben.hutchings@codethink.co.uk>, Ian Molton <ian@mnementh.co.uk>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, linux-kernel@lists.codethink.co.uk, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Simon Horman <horms@verge.net.au>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: linux-mmc@vger.kernel.org

On Tuesday 30 June 2015 08:05:34 Linus Walleij wrote:
> On Mon, Jun 15, 2015 at 4:02 AM, Laurent Pinchart
> 
> <laurent.pinchart@ideasonboard.com> wrote:
> > On a side note, I have a patch to support the standard "groups",
> > "functions" and "pins" properties instead of the Renesas-specific
> > versions, I'll try to revive it.
> 
> Yes please :)

Done :-)

> Makes things a little less confusing in this confusing boundary between
> electronics and code...

-- 
Regards,

Laurent Pinchart

