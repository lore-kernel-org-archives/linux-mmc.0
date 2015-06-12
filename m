From: Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: Re: [PATCH v2 3/6] pinctrl: sh-pfc: r8a7790: Add separate functions
 for SDHI 1.8V operation
Date: Fri, 12 Jun 2015 14:23:55 +0100
Message-ID: <1434115435.25446.1.camel@codethink.co.uk>
References: <1433892104.12074.49.camel@codethink.co.uk>
	 <1433892211.12074.52.camel@codethink.co.uk> <2554026.6LTcTIWBdF@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <2554026.6LTcTIWBdF@avalon>
Sender: linux-gpio-owner@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Ian Molton <ian@mnementh.co.uk>, linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kernel@lists.codethink.co.uk, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Simon Horman <horms@verge.net.au>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Linus Walleij <linus.walleij@linaro.org>
List-Id: linux-mmc@vger.kernel.org

On Fri, 2015-06-12 at 10:18 +0300, Laurent Pinchart wrote:
> Hi Ben,
> 
> (CC'ing Linus Walleij)
> 
> Thank you for the patch.
> 
> On Wednesday 10 June 2015 00:23:31 Ben Hutchings wrote:
> > All the SHDIs can operate with either 3.3V or 1.8V signals, depending
> > on negotiation with the card.
> > 
> > Add separate functions for the 1.8V mode, and implement the set_mux
> > operation on all SDHI functions to configure the voltage for each
> > group of pins.
> 
> I don't think duplicating all functions for 1.8V and 3.3V is the right way to 
> go. Can't we use the pinconf API instead, and in particular the 
> PIN_CONFIG_POWER_SOURCE configuration ?
[...]

So far as I could see, you can't use the pinconf API with pinmux groups.

Ben.


