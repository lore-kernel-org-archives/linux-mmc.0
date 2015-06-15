From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH v2 3/6] pinctrl: sh-pfc: r8a7790: Add separate functions for SDHI 1.8V operation
Date: Mon, 15 Jun 2015 05:02:50 +0300
Message-ID: <11872302.fE1vlhM93k@avalon>
References: <1433892104.12074.49.camel@codethink.co.uk> <34148355.aYdSK9R7Ck@avalon> <1434328840.25446.50.camel@codethink.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1434328840.25446.50.camel@codethink.co.uk>
Sender: linux-sh-owner@vger.kernel.org
To: Ben Hutchings <ben.hutchings@codethink.co.uk>
Cc: Ian Molton <ian@mnementh.co.uk>, linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kernel@lists.codethink.co.uk, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Simon Horman <horms@verge.net.au>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Linus Walleij <linus.walleij@linaro.org>
List-Id: linux-mmc@vger.kernel.org

Hi Ben,

On Monday 15 June 2015 01:40:40 Ben Hutchings wrote:
> On Fri, 2015-06-12 at 22:07 +0300, Laurent Pinchart wrote:
> > On Friday 12 June 2015 14:23:55 Ben Hutchings wrote:
> >> On Fri, 2015-06-12 at 10:18 +0300, Laurent Pinchart wrote:
> >>> On Wednesday 10 June 2015 00:23:31 Ben Hutchings wrote:
> >>>> All the SHDIs can operate with either 3.3V or 1.8V signals,
> >>>> depending on negotiation with the card.
> >>>> 
> >>>> Add separate functions for the 1.8V mode, and implement the set_mux
> >>>> operation on all SDHI functions to configure the voltage for each
> >>>> group of pins.
> >>> 
> >>> I don't think duplicating all functions for 1.8V and 3.3V is the right
> >>> way to go. Can't we use the pinconf API instead, and in particular the
> >>> PIN_CONFIG_POWER_SOURCE configuration ?
> >> 
> >> [...]
> >> 
> >> So far as I could see, you can't use the pinconf API with pinmux groups.
> > 
> > Can't you ? Both Documentation/devicetree/bindings/pinctrl/pinctrl-
> > bindings.txt and Documentation/devicetree/bindings/pinctrl/renesas,pfc-
> > pinctrl.txt document the usage of pinconf with groups (see for instance
> > example 3 in the latter).
> 
> Sorry, I should say you can't use them with pinmux *functions*.  You can
> either bind a group to a function *or* set the various pinconf
> properties for the group, but not both.  Unless I'm very much mistaken.

One of us probably is :-)

I'd have to recheck whether this is really a standard behaviour, but the PFC 
driver at least supports setting both functions and configuration as far as I 
can tell. The relevant example from the PFC bindings is

        mmcif_pins: mmcif {
                mux {
                        renesas,groups = "mmc0_data8_0", "mmc0_ctrl_0";
                        renesas,function = "mmc0";
                };
                cfg {
                        renesas,groups = "mmc0_data8_0";
                        renesas,pins = "PORT279";
                        bias-pull-up;
                };
        };

It's a bit more verbose than I'd like, but I think the following should work 
too.

        mmcif_pins: mmcif {
                renesas,groups = "mmc0_data8_0";
                renesas,function = "mmc0";
                bias-pull-up;
        };

(it requires all pins from the groups to use the same configuration though)

I believe the former is the intended way to set both function and config, 
while the latter is a PFC "extension".

On a side note, I have a patch to support the standard "groups", "functions" 
and "pins" properties instead of the Renesas-specific versions, I'll try to 
revive it.

-- 
Regards,

Laurent Pinchart

