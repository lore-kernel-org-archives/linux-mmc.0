From: Dong Aisheng <b29396@freescale.com>
Subject: Re: [PATCH 5/8] sdhci: sdhci-esdhc-imx: change pinctrl state
 according to uhs mode
Date: Wed, 11 Sep 2013 17:26:06 +0800
Message-ID: <20130911092605.GA2891@b29396-Latitude-E6410>
References: <1378299257-2980-1-git-send-email-b29396@freescale.com>
 <1378299257-2980-6-git-send-email-b29396@freescale.com>
 <CAHCPf3tYXsT6kTbJcqJx1gN_G9G2iqi1-f+jRcpw95CEPkW8NQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-db9lp0252.outbound.messaging.microsoft.com ([213.199.154.252]:26688
	"EHLO db9outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752572Ab3IKJ1U (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 11 Sep 2013 05:27:20 -0400
Content-Disposition: inline
In-Reply-To: <CAHCPf3tYXsT6kTbJcqJx1gN_G9G2iqi1-f+jRcpw95CEPkW8NQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Matt Sealey <neko@bakuhatsu.net>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <s.hauer@pengutronix.de>, "anton@enomsg.org" <anton@enomsg.org>, "cjb@laptop.org" <cjb@laptop.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Matt,

Sorry for the late reply.

On Fri, Sep 06, 2013 at 02:40:06AM +0800, Matt Sealey wrote:
> > +       if (of_find_property(np, "no-1-8-v", NULL))
> > +               boarddata->support_vsel = false;
> > +       else
> > +               boarddata->support_vsel = true;
> > +
> >         return 0;
> 
> No, no, no, no, no :(
> 
> Please do not just strip the prefix from a definition in code, or just
> convert the underscores into hyphens to make a device tree property.
> SDHCI_QUIRK2_NO_1_8_V should never, ever, EVER become no-1-8-v and NO
> DEFINITION FROM SOURCE CODE should EVER make it into a device tree.
> This is how we ended up with manure like "dr_mode" in the USB
> bindings. Please follow good common sense as well as the bindings.
> 
> In this case a suitable standard for describing a voltage would be
> no-1v8 (replacing the decimal point with the v) which is how 99.9% of
> schematics are written in the world where a period is not a desirable
> character in a net name or component/signal description. But even that
> is stupid and not expandable.
> 

I somehow agree with your idea on the naming.
But currently i'm just using the standard property defined in:
Documentation/devicetree/bindings/mmc/mmc.txt
- no-1-8-v: when present, denotes that 1.8v card voltage is not supported on
  this system, even if the controller claims it is.

> This property should probably be called "voltage-selects" or something
> and you should put in a list of supported voltages (in uV units just
> like cpufreq operating points and regulators, please, for consistency,
> and update the binding).
> 
> Then you can parse the list and find out precisely what voltages you
> can switch to - there are more possibilities than an implied 3-ish
> volts and a switch to 1.8V for MMC. The standard for the OCR register
> is a bunch of ranges - so specify which voltages you HAVE available,
> if you can switch. The driver (as per standard) can determine if this
> is in one range or another.
> 
> Lack of this property would imply that whatever the chip is driving
> right now for logic is what it should stay at (support_vsel = false in
> the code).
> 

Here the no-1-8-v is for indicating no 1.8v signal voltage switch support,
not the host supply voltage.
The spec only defines 1.8v/3.3v switch, so no-1-8-v seems ok for me currently.

And for host supply voltage, it's usually provided by host controller and
can be retrieved from host capability register.
And even if it's using an external regulator, this capability can still be
retrieved from the standard regulator API regulator_is_supported_voltage.
That's how sdhci driver used currently.
So i'm not sure if we really need add the voltage-selects on device tree
for mmc since that's regulator's work.

Anyway, above is just my initial thoughts on your question.
Since this issue actually is not related to this series,
maybe you could create a new mail thread about this if you want
or patching is welcome for the further discussion more specific.

Regards
Dong Aisheng

> --
> Matt Sealey <neko@bakuhatsu.net>

