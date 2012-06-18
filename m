From: Roland Stigge <stigge@antcom.de>
Subject: Re: [PATCH 1/2] sound: tegra_wm8903: Adjust to of_get_named_gpio()
 change
Date: Mon, 18 Jun 2012 19:00:14 +0200
Message-ID: <4FDF5E9E.6060803@antcom.de>
References: <1340037743-12924-1-git-send-email-stigge@antcom.de> <20120618164659.GV3974@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from antcom.de ([188.40.178.216]:57022 "EHLO chuck.antcom.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753388Ab2FRRAR (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 18 Jun 2012 13:00:17 -0400
In-Reply-To: <20120618164659.GV3974@opensource.wolfsonmicro.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: swarren@wwwdotorg.org, cjb@laptop.org, grant.likely@secretlab.ca, rob.herring@calxeda.com, rmk+kernel@arm.linux.org.uk, ulf.hansson@stericsson.com, linus.walleij@linaro.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, aletes.xgr@gmail.com, linux-arm-kernel@lists.infradead.org, lrg@ti.com, perex@perex.cz, tiwai@suse.de, alsa-devel@alsa-project.org

On 06/18/2012 06:46 PM, Mark Brown wrote:
> On Mon, Jun 18, 2012 at 06:42:21PM +0200, Roland Stigge wrote:
>> of_get_named_gpio() was changed to return -EPROBE_DEFER in case of
>> gpios not probed yet. This patch adjusts tegra_wm8903 to this.
> 
> So, I saw from the other thread that this didn't actually happen yet - I
> guess the best thing is to merge this along with the changes for
> introducing -EPROBE_DEFER.

Basically, yes. But this would mean that doing via gpio, we would need
to pull other stuff from the sound tree over to gpio to build upon
because "my" tegra_* sound patches won't apply to the gpio branch currently.

Any hint welcome.

Thanks in advance,

Roland
