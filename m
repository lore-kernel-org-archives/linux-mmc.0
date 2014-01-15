From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] mmc: dw_mmc: fix dw_mci_get_cd
Date: Wed, 15 Jan 2014 17:07:49 +0100
Message-ID: <15344443.B6eHZOpkXH@wuerfel>
References: <1389770159-21125-1-git-send-email-zhangfei.gao@linaro.org> <3154671.7LPLgq8X4K@wuerfel> <20140115160146.GO15937@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:51940 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752167AbaAOQIA (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 15 Jan 2014 11:08:00 -0500
In-Reply-To: <20140115160146.GO15937@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: zhangfei <zhangfei.gao@linaro.org>, 'Kevin Hilman' <khilman@linaro.org>, 'Mike Turquette' <mturquette@linaro.org>, patches@linaro.org, Seungwon Jeon <tgih.jun@samsung.com>, linux-mmc@vger.kernel.org, 'Jaehoon Chung' <jh80.chung@samsung.com>, 'Sachin Kamat' <sachin.kamat@linaro.org>, 'Chris Ball' <cjb@laptop.org>, linux-arm-kernel@lists.infradead.org

On Wednesday 15 January 2014 16:01:46 Russell King - ARM Linux wrote:
> On Wed, Jan 15, 2014 at 02:59:59PM +0100, Arnd Bergmann wrote:
> > On Wednesday 15 January 2014 21:56:26 zhangfei wrote:
> > > However, in our board cd =0 when card is deteced while cd=1 when card is
> > > removed.
> > > In order to mmc_gpio_get_cd return 1, MMC_CAP2_CD_ACTIVE_HIGH has to be
> > > set, as well as new property "caps2-mmc-cd-active-low".
> > > 
> > > --- a/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt
> > > +++ b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt
> > > @@ -73,6 +73,8 @@ Optional properties:
> > > +* caps2-mmc-cd-active-low: cd pin is low when card active
> > > +
> > > 
> > > diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> > > +       if (of_find_property(np, "caps2-mmc-cd-active-low", NULL))
> > > +               pdata->caps2 |= MMC_CAP2_CD_ACTIVE_HIGH;
> > > +
> > 
> > The MMC_CAP2_CD_ACTIVE_HIGH flag should only be required for
> > legacy platforms. With DT parsing, you can normally specify
> > the polarity of the GPIO line in the GPIO specifier in DT.
> 
> Since when?

I just looked through the bindings and found that about half
of them allow passing polarity in the gpio specifier. I thought
it was more than that and IIRC the outcome of a previous discussion
was that when the gpio controller allows passing polarity, you
should use that rather than a separate flag.

Not a problem though, since we can use the cd-inverted and
wp-inverted properties.

	Arnd
