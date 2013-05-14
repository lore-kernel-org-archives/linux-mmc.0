From: Simon Baatz <gmbnomis@gmail.com>
Subject: Re: [PATCH V2 07/10] ARM: mvebu: Use standard MMC binding for all
 users of mvsdio
Date: Tue, 14 May 2013 07:37:06 +0200
Message-ID: <20130514053706.GA29922@schnuecks.de>
References: <1368479941-10084-1-git-send-email-gmbnomis@gmail.com>
 <1368479941-10084-8-git-send-email-gmbnomis@gmail.com>
 <20130513230918.GG31290@titan.lakedaemon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ea0-f170.google.com ([209.85.215.170]:48690 "EHLO
	mail-ea0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751263Ab3ENFhK (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 14 May 2013 01:37:10 -0400
Received: by mail-ea0-f170.google.com with SMTP id f15so59211eak.15
        for <linux-mmc@vger.kernel.org>; Mon, 13 May 2013 22:37:08 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20130513230918.GG31290@titan.lakedaemon.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jason Cooper <jason@lakedaemon.net>
Cc: linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, Andrew Lunn <andrew@lunn.ch>, Chris Ball <cjb@laptop.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Hi Jason,

On Mon, May 13, 2013 at 07:09:18PM -0400, Jason Cooper wrote:
> On Mon, May 13, 2013 at 11:18:58PM +0200, Simon Baatz wrote:
> > In order to prepare the switch to the standard MMC device tree parser
> > for mvsdio, adapt all current uses of mvsdio in the dts files to the
> > standard format.
> > 
> > Signed-off-by: Simon Baatz <gmbnomis@gmail.com>
> > ---
> ...
> > diff --git a/arch/arm/boot/dts/kirkwood-mplcec4.dts b/arch/arm/boot/dts/kirkwood-mplcec4.dts
> > index 7588241..bf3a58c 100644
> > --- a/arch/arm/boot/dts/kirkwood-mplcec4.dts
> > +++ b/arch/arm/boot/dts/kirkwood-mplcec4.dts
> > @@ -136,7 +136,7 @@
> >  			pinctrl-0 = <&pmx_sdio &pmx_sdio_cd>;
> >  			pinctrl-names = "default";
> >  			status = "okay";
> > -			cd-gpios = <&gpio1 15 0>;
> > +			cd-gpios = <&gpio1 15 1>;
> 
> Is this a bugfix that should be backported?

No, that should not be necessary. The old code implicitly used "1"
here regardless of the actual flag value.

- Simon
