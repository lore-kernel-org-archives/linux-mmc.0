From: Alexandre Pereira da Silva <aletes.xgr@gmail.com>
Subject: Re: [PATCH 1/2] sound: tegra_wm8903: Adjust to of_get_named_gpio() change
Date: Mon, 18 Jun 2012 14:28:00 -0300
Message-ID: <CAAAP30EQkS5XLqi1gt5mOKcMLTRtg5yAEvvSLr7oQGOBJvw+TA@mail.gmail.com>
References: <1340037743-12924-1-git-send-email-stigge@antcom.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:58575 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752373Ab2FRR2B (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 18 Jun 2012 13:28:01 -0400
In-Reply-To: <1340037743-12924-1-git-send-email-stigge@antcom.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Roland Stigge <stigge@antcom.de>
Cc: swarren@wwwdotorg.org, cjb@laptop.org, grant.likely@secretlab.ca, rob.herring@calxeda.com, rmk+kernel@arm.linux.org.uk, ulf.hansson@stericsson.com, linus.walleij@linaro.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, broonie@opensource.wolfsonmicro.com, lrg@ti.com, perex@perex.cz, tiwai@suse.de, alsa-devel@alsa-project.org

On Mon, Jun 18, 2012 at 1:42 PM, Roland Stigge <stigge@antcom.de> wrote:
> of_get_named_gpio() was changed to return -EPROBE_DEFER in case of
> gpios not probed yet. This patch adjusts tegra_wm8903 to this.
>
> Signed-off-by: Roland Stigge <stigge@antcom.de>
Acked-by: Alexandre Pereira da Silva <aletes.xgr@gmail.com>
