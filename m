From: Roland Stigge <stigge@antcom.de>
Subject: Re: [PATCH 1/2] sound: tegra_wm8903: Adjust to of_get_named_gpio()
 change
Date: Mon, 18 Jun 2012 19:15:46 +0200
Message-ID: <4FDF6242.3040400@antcom.de>
References: <1340037743-12924-1-git-send-email-stigge@antcom.de> <20120618164659.GV3974@opensource.wolfsonmicro.com> <4FDF5E9E.6060803@antcom.de> <20120618170408.GW3974@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from antcom.de ([188.40.178.216]:36664 "EHLO chuck.antcom.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751877Ab2FRRPu (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 18 Jun 2012 13:15:50 -0400
In-Reply-To: <20120618170408.GW3974@opensource.wolfsonmicro.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: swarren@wwwdotorg.org, cjb@laptop.org, grant.likely@secretlab.ca, rob.herring@calxeda.com, rmk+kernel@arm.linux.org.uk, ulf.hansson@stericsson.com, linus.walleij@linaro.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, aletes.xgr@gmail.com, linux-arm-kernel@lists.infradead.org, lrg@ti.com, perex@perex.cz, tiwai@suse.de, alsa-devel@alsa-project.org

On 06/18/2012 07:04 PM, Mark Brown wrote:
> On Mon, Jun 18, 2012 at 07:00:14PM +0200, Roland Stigge wrote:
> 
>> Basically, yes. But this would mean that doing via gpio, we would
>> need to pull other stuff from the sound tree over to gpio to
>> build upon because "my" tegra_* sound patches won't apply to the
>> gpio branch currently.
> 
> Oh, yes.  Stephen's gone and reorganised all that code which means
> it's not a trivial merge.  Ho hum.  I'm happy to apply them if
> folks are comfortable with it, I guess ideally I'd be able to pull
> a branch with the gpio changes in and then apply on top of that.

Depending on what else changes will come via gpio for 3.6, maybe you
don't even need to merge gpio to sound?

Can you please coordinate between sound and gpio?

Thanks in advance!

Roland

PS: I'm posting a combined patch suitable for the sound subsystem.
Please tell me if you also need the gpiolib-of patch singled out.
