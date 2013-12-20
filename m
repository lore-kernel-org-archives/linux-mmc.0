From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v6 3/7] regulator: add pbias regulator support
Date: Fri, 20 Dec 2013 07:57:21 -0800
Message-ID: <20131220155721.GX27438@atomide.com>
References: <1386670577-3530-1-git-send-email-balajitk@ti.com>
 <1387456720-7202-1-git-send-email-balajitk@ti.com>
 <1387456720-7202-4-git-send-email-balajitk@ti.com>
 <20131219163300.GK27438@atomide.com>
 <52B4124F.8010903@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:48806 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754079Ab3LTP51 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 20 Dec 2013 10:57:27 -0500
Content-Disposition: inline
In-Reply-To: <52B4124F.8010903@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Balaji T K <balajitk@ti.com>
Cc: linux-omap@vger.kernel.org, bcousson@baylibre.com, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, cjb@laptop.org, broonie@kernel.org

* Balaji T K <balajitk@ti.com> [131220 01:49]:
> On Thursday 19 December 2013 10:03 PM, Tony Lindgren wrote:
> >>+static int pbias_regulator_enable(struct regulator_dev *rdev)
> >>+{
> >>+	struct pbias_regulator_data *data = rdev_get_drvdata(rdev);
> >>+	const struct pbias_reg_info *info = data->info;
> >>+	int ret;
> >>+
> >>+	ret = regmap_update_bits(data->syscon, data->pbias_reg,
> >>+					info->enable_mask, info->enable);
> >>+
> >>+	return ret;
> >>+}
> >
> >Do we need need to check the values after enable here? AFAIK setting
> >the PBIAS voltage change can also fail and that's probably why it has
> 
> failure due to mismatch in input voltage, should to be avoided and should
> be taken care in s/w by the caller before pbias regulator set voltage/enable.
> 
> >also the interrupt available.
> >
> 
> But interrupt was never used/tested AFAIK, there is some settling time
> before the generated interrupt status is truely valid, so pbias interrupt is not
> reliable.

OK. Do we need the standard regulator property startup-delay-us for the
PBIAS regulator then? Or if it's always fixed, I guess it could be done
in the pbias_regulator_enable()?
 
> >We probably need also pbias_mmc_omap2430 as that regiter mapping is
> >separate from omap3?
> >
> 
> between omap2430 and omap3430, 3460 pbias register address are different,
> other than that enable,enable_mask and vmode are
> one and the same, so re-used "pbias_mmc_omap3" name and struct pbias_reg_info pbias_mmc_omap3
> for omap2430 too, save one entry in of_regulator_match!
> 
> If separate name is needed for omap2430, I can add one for 2430,
> and reuse the "const struct pbias_reg_info pbias_mmc_omap3" of omap3
> since the bit map for enable/disable and voltage configuration will be same.
> Then pbias_matches will look like.

If they truly are compatible, then usually the earliest revision name is
used. So I guess we should use the omap2430 naming instead of omap3 naming.
 
> >> +static struct of_regulator_match pbias_matches[] = {
> >> +	{ .name = "pbias_mmc_omap2430", .driver_data = (void *)&pbias_mmc_omap3},
> >> +	{ .name = "pbias_mmc_omap3", .driver_data = (void *)&pbias_mmc_omap3},
> >> +	{ .name = "pbias_sim_omap3", .driver_data = (void *)&pbias_sim_omap3},
> >> +	{ .name = "pbias_mmc_omap4", .driver_data = (void *)&pbias_mmc_omap4},
> >> +	{ .name = "pbias_mmc_omap5", .driver_data = (void *)&pbias_mmc_omap5},
> >> +};
> 
> Let me know if you still think that separate regulator name is needed for 2430,
> I can respin this series.

Sounds like using the omap2430 naming would solve that.

Regards,

Tony 
