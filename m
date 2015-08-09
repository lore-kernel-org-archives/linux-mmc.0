From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Subject: Re: [RFC PATCH] ARM: dts: rockchip: Add wifi support for firefly
Date: Sun, 09 Aug 2015 21:17:15 +0200
Message-ID: <4932422.vgAJTm4MIh@diego>
References: <1438956725-4188-1-git-send-email-michael@amarulasolutions.com> <5702275.SOOuh5NPWf@diego> <20150809082640.GA5459@panicking>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from gloria.sntech.de ([95.129.55.99]:60718 "EHLO gloria.sntech.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933165AbbHITRS (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sun, 9 Aug 2015 15:17:18 -0400
In-Reply-To: <20150809082640.GA5459@panicking>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Michael Trimarchi <michael@amarulasolutions.com>
Cc: linux-rockchip@lists.infradead.org, linux-mmc@vger.kernel.org, dianders@chromium.org, romain.perier@gmail.com, FUKAUMI Naoki <naobsd@gmail.com>

Hi Michael,

Am Sonntag, 9. August 2015, 10:26:44 schrieb Michael Trimarchi:

[...]

> > >  	num-slots = <1>;
> > >  	pinctrl-names = "default";
> > > 
> > > -	pinctrl-0 = <&sdio0_bus4>, <&sdio0_cmd>, <&sdio0_clk>;
> > > -	vmmc-supply = <&vcc_18>;
> > > +	pinctrl-0 = <&sdio0_bus4>, <&sdio0_cmd>, <&sdio0_clk>, <&sdio0_int>;
> > > +
> > > +	sd-uhs-sdr50;
> > > +	sd-uhs-sdr104;
> > > +	sd-uhs-ddr50;
> > 
> > we don't have mmc tuning capabilities yet, so please no sd-uhs-* stuff.
> > That way you should also be able to leave out the clock-freq-min-max
> > above, as regular "highspeed" does not venture above the 50MHz limit.
> 
> Ok, I have tested without it too and it works with a small hack on the code.
> Agree with you

what was this supposed to fix? And what "hack" do you use now?


> > > +	cap-sdio-irq;
> > > +
> > > +	vmmc-supply = <&vcc_wifi>;
> > 
> > the original supply is actually wrong in the dts. vcc_18 is the io voltage
> > used on the
> > pins _to_ the card, not to supply the card itself. So vcc_18 is actually
> > the so called vqmmc-supply.
> > vmmc-supply is done regularly from vcc_io. So your voltage hack above can
> > go away too.
> > 
> > Bringup should also use a mmc-power-sequency so you can make sure the
> > rtc_clock is running, which is also needed by the wifi module.
> 
> Hack is used to because when sdio subsystem compare the wifi voltage
> capability returned by a specific message on the bus with the possible
> voltage levels that hardware connection provides and take the minimal. The
> card return to support from 2V up and this is the reason to declare it at
> 2V. I will retest again

after the supplies are corrected (see vmmc and vqmmc in the patches) the 
supply for the modules should actually be read as the 3.3V that are supplying 
it (from vcc_io ... which is called vbat_wl in the schematics).


> > >  	status = "okay";
> > 
> > missing #address-cells and #size-cells values for the subnodes
> 
> Correct
> 
> > > +
> > > +	brcmf: bcrmf@0 {
> > > +		compatible = "brcm,bcm4329-fmac";
> > > +		interrupt-parent = <&gpio4>;
> > > +		reg = <0>;
> > > +		interrupts = <30 IRQ_TYPE_EDGE_FALLING>;
> > > +		interrupt-names = "host-wake";
> > > +		status = "okay";
> > > +	};
> > > 
> > >  };
> > >  
> > >  &sdmmc {
> > 
> > I took the liberty to move stuff around how it should look like, but did
> > not find the time to actually test this. So maybe you can take a look at
> > the attached patches.
> 
> Perfect, I will retest as soon as I can and go back to you. Right now
> I have two hardware design around firefly that use the wifi

great


Heiko
