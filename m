From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] mmc: dw_mmc: fix dw_mci_get_cd
Date: Wed, 15 Jan 2014 16:22:10 +0000
Message-ID: <20140115162210.GP15937@n2100.arm.linux.org.uk>
References: <1389770159-21125-1-git-send-email-zhangfei.gao@linaro.org> <3154671.7LPLgq8X4K@wuerfel> <20140115160146.GO15937@n2100.arm.linux.org.uk> <15344443.B6eHZOpkXH@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:37713 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752076AbaAOQWU (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 15 Jan 2014 11:22:20 -0500
Content-Disposition: inline
In-Reply-To: <15344443.B6eHZOpkXH@wuerfel>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: zhangfei <zhangfei.gao@linaro.org>, 'Kevin Hilman' <khilman@linaro.org>, 'Mike Turquette' <mturquette@linaro.org>, patches@linaro.org, Seungwon Jeon <tgih.jun@samsung.com>, linux-mmc@vger.kernel.org, 'Jaehoon Chung' <jh80.chung@samsung.com>, 'Sachin Kamat' <sachin.kamat@linaro.org>, 'Chris Ball' <cjb@laptop.org>, linux-arm-kernel@lists.infradead.org

On Wed, Jan 15, 2014 at 05:07:49PM +0100, Arnd Bergmann wrote:
> On Wednesday 15 January 2014 16:01:46 Russell King - ARM Linux wrote:
> > On Wed, Jan 15, 2014 at 02:59:59PM +0100, Arnd Bergmann wrote:
> > > On Wednesday 15 January 2014 21:56:26 zhangfei wrote:
> > > > However, in our board cd =0 when card is deteced while cd=1 when card is
> > > > removed.
> > > > In order to mmc_gpio_get_cd return 1, MMC_CAP2_CD_ACTIVE_HIGH has to be
> > > > set, as well as new property "caps2-mmc-cd-active-low".
> > > > 
> > > > --- a/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt
> > > > +++ b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt
> > > > @@ -73,6 +73,8 @@ Optional properties:
> > > > +* caps2-mmc-cd-active-low: cd pin is low when card active
> > > > +
> > > > 
> > > > diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> > > > +       if (of_find_property(np, "caps2-mmc-cd-active-low", NULL))
> > > > +               pdata->caps2 |= MMC_CAP2_CD_ACTIVE_HIGH;
> > > > +
> > > 
> > > The MMC_CAP2_CD_ACTIVE_HIGH flag should only be required for
> > > legacy platforms. With DT parsing, you can normally specify
> > > the polarity of the GPIO line in the GPIO specifier in DT.
> > 
> > Since when?
> 
> I just looked through the bindings and found that about half
> of them allow passing polarity in the gpio specifier. I thought
> it was more than that and IIRC the outcome of a previous discussion
> was that when the gpio controller allows passing polarity, you
> should use that rather than a separate flag.
> 
> Not a problem though, since we can use the cd-inverted and
> wp-inverted properties.

Well, having this in the gpio level as well as in subsystems like MMC
is going to create confusion - and from the results of this patch _IS_
causing confusion.  You've just encouraged one implementation to have
things setup such that mmc_gpio_get_cd() returns false when a card is
inserted, rather than it correctly returning true.

The issue here is that we'll potentially now end up with _three_
inversions.  One in the GPIO layers.  One in mmc_gpio_get_cd(), and
another in every driver which uses the GPIO layer inversion.  This
is hardly the right approach as it leads to multiple points where
confusion about the inverted status can occur.

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
