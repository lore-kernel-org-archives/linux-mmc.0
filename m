From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 06/12] power: pwrseq: simple: Add support for
 regulator and generic property
Date: Wed, 8 Jun 2016 14:03:33 -0500
Message-ID: <20160608190333.GA5126@rob-hp-laptop>
References: <1464768141-25420-1-git-send-email-k.kozlowski@samsung.com>
 <1464768141-25420-7-git-send-email-k.kozlowski@samsung.com>
 <20160603020218.GA19436@rob-hp-laptop>
 <575693DE.2010603@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <575693DE.2010603@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: hzpeterchen@gmail.com, Ulf Hansson <ulf.hansson@linaro.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Javier Martinez Canillas <javier@osg.samsung.com>, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, linux-pm@vger.kernel.or, Alan Stern <stern@rowland.harvard.edu>, linux-usb@vger.kernel.org, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Kukjin Kim <kgene@kernel.org>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-Id: linux-mmc@vger.kernel.org

On Tue, Jun 07, 2016 at 11:29:02AM +0200, Krzysztof Kozlowski wrote:
> On 06/03/2016 04:02 AM, Rob Herring wrote:
> >>  Optional properties:
> >>  - reset-gpios : contains a list of GPIO specifiers. The reset GPIOs are asserted
> >> @@ -16,6 +22,7 @@ Optional properties:
> >>    See ../clocks/clock-bindings.txt for details.
> >>  - clock-names : Must include the following entry:
> >>    "ext_clock" (External clock provided to the card).
> >> +- ext-supply : External regulator supply
> > 
> > What happens when there are 2 supplies?
> > 
> > I'd prefer the name not be genericish and use the real supply names. 
> > Then the power seq code should just turn on all supplies it finds. If 
> > the order or timing to turn on matters, then sorry, no generic sequence.
> 
> I think the generic part for regulators might be a problem. Regulator
> API requires a name for the supply... it cannot get "something" or
> "everything".

That's the downside of variable property names...

> The driver could attach itself to any kind of node (where power-sequence
> property exists) so the supply name depends on the bindings of device
> (not bindings of power sequence driver).
> 
> The power sequence driver could however iterate over child properties
> and get the names of all supplies. It is a little bit ugly...

Yes. Like this, right?

for_each_property_of_node(np, pp) {
	if (!strstr(pp->name, "-supply"))
		continue;
	// found supply
}

The uglyness can always be improved with a function to do this parsing.

Rob
