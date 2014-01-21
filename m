From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 1/3] mmc: add support for power-on sequencing through DT
Date: Tue, 21 Jan 2014 19:19:49 +0000
Message-ID: <20140121191949.GW15937@n2100.arm.linux.org.uk>
References: <1390190215-22700-1-git-send-email-olof@lixom.net> <1390190215-22700-2-git-send-email-olof@lixom.net> <20140120164859.GF15937@n2100.arm.linux.org.uk> <CAOMZO5AfSe_c7gfee0BcZso8ZYg=PaTDwfsXwzpEcM1554VQ6Q@mail.gmail.com> <20140120171621.GG15937@n2100.arm.linux.org.uk> <CAOMZO5DP1axSmKcdp0e5yNakirG-_yQ1dHdoqzww3wp3CUt29w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:44129 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750827AbaAUTT5 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 21 Jan 2014 14:19:57 -0500
Content-Disposition: inline
In-Reply-To: <CAOMZO5DP1axSmKcdp0e5yNakirG-_yQ1dHdoqzww3wp3CUt29w@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Olof Johansson <olof@lixom.net>, linux-mmc@vger.kernel.org, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, robh+dt@kernel.org, Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>, ijc+devicetree@hellion.org.ok, Kumar Gala <galak@codeaurora.org>, chris@printf.net

On Mon, Jan 20, 2014 at 04:47:34PM -0200, Fabio Estevam wrote:
> On Mon, Jan 20, 2014 at 3:16 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> 
> > Not as far as I can see.  fixed-clock appears to have two properies:
> >
> >         clock-frequency
> >         clock-output-names
> >
> > and nothing else.  See of_fixed_clk_setup in drivers/clk/clk-fixed-rate.c.
> > You'll also find that the documentation in this file says this about it:
> 
> Looks like Documentation/devicetree/bindings/clock/fixed-clock.txt is
> misleading then:
> 
> "Optional properties:
> - gpios : From common gpio binding; gpio connection to clock enable pin."

It seems so.  It appears that the binding was added to clk-fixed-rate.c
here:

commit 015ba40246497ae02a5f644d4c8adfec76d9b75c
Date:   Sat Apr 7 21:39:39 2012 -0500

and the binding documentation separately:

commit 766e6a4ec602d0c107553b91b3434fe9c03474f4
Date:   Mon Apr 9 14:50:06 2012 -0500

>From what I can see, this "gpios" property has never been supported.

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
