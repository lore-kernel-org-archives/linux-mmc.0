From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH 1/3] mmc: add support for power-on sequencing through DT
Date: Mon, 20 Jan 2014 16:47:34 -0200
Message-ID: <CAOMZO5DP1axSmKcdp0e5yNakirG-_yQ1dHdoqzww3wp3CUt29w@mail.gmail.com>
References: <1390190215-22700-1-git-send-email-olof@lixom.net>
	<1390190215-22700-2-git-send-email-olof@lixom.net>
	<20140120164859.GF15937@n2100.arm.linux.org.uk>
	<CAOMZO5AfSe_c7gfee0BcZso8ZYg=PaTDwfsXwzpEcM1554VQ6Q@mail.gmail.com>
	<20140120171621.GG15937@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vb0-f44.google.com ([209.85.212.44]:43290 "EHLO
	mail-vb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750824AbaATSrf (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 20 Jan 2014 13:47:35 -0500
In-Reply-To: <20140120171621.GG15937@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Olof Johansson <olof@lixom.net>, linux-mmc@vger.kernel.org, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, robh+dt@kernel.org, Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>, ijc+devicetree@hellion.org.ok, Kumar Gala <galak@codeaurora.org>, chris@printf.net

On Mon, Jan 20, 2014 at 3:16 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:

> Not as far as I can see.  fixed-clock appears to have two properies:
>
>         clock-frequency
>         clock-output-names
>
> and nothing else.  See of_fixed_clk_setup in drivers/clk/clk-fixed-rate.c.
> You'll also find that the documentation in this file says this about it:

Looks like Documentation/devicetree/bindings/clock/fixed-clock.txt is
misleading then:

"Optional properties:
- gpios : From common gpio binding; gpio connection to clock enable pin."

Regards,

Fabio Estevam
