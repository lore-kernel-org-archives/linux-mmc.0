From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/2] mmc: core: Support all MMC capabilities when booting from Device Tree
Date: Wed, 17 Oct 2012 13:38:00 +0000
Message-ID: <201210171338.01011.arnd@arndb.de>
References: <1350306959-5843-1-git-send-email-lee.jones@linaro.org> <201210151420.29930.arnd@arndb.de> <20121015160740.GC7662@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:52885 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756156Ab2JQNiQ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 17 Oct 2012 09:38:16 -0400
In-Reply-To: <20121015160740.GC7662@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linus.walleij@stericsson.com, Chris Ball <cjb@laptop.org>, Russell King <linux@arm.linux.org.uk>, linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@stericsson.com>

On Monday 15 October 2012, Lee Jones wrote:
> > and so on. What are you actually missing in the properties that
> > are already there?
> 
> MMC_CAP_ERASE

This one seems to be set unconditionally on some controllers but
not on others. Why would it need to be configurable?

> MMC_CAP_UHS_SDR12
> MMC_CAP_UHS_SDR25
> MMC_CAP_UHS_DDR50

Could this be derived from max-frequency?

> MMC_CAP_1_8V_DDR

Right, I suppose we need this. Should we have a minimum and maximum
voltage added to the common properties for this?

> MMC_CAP2_DETECT_ON_ERR
> MMC_CAP2_NO_SLEEP_CMD

I don't see these ones being set anywhere, but they were both
added by Ulf. Maybe he can comment on if or why they are needed
in devicetree, rather than being set by the driver unconditionally
or for specific versions of the host controller.

	Arnd
