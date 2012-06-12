From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] mmc: dt: Deduplicate binding docs by referencing mmc.txt
Date: Tue, 12 Jun 2012 14:50:20 +0000
Message-ID: <201206121450.21092.arnd@arndb.de>
References: <87bokp5lv2.fsf@octavius.laptop.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:61212 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752145Ab2FLOu0 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 12 Jun 2012 10:50:26 -0400
In-Reply-To: <87bokp5lv2.fsf@octavius.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, Arnd Bergmann <arndb@arndb.de>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Stephen Warren <swarren@wwwdotorg.org>, Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <kernel@pengutronix.de>, Wolfram Sang <w.sang@pengutronix.de>

On Tuesday 12 June 2012, Chris Ball wrote:
> 
> Now that we have common bindings for MMC, rewrite the individual
> bindings to inherit from mmc.txt and describe their differences.
> 
> Signed-off-by: Chris Ball <cjb@laptop.org>

Acked-by: Arnd Bergmann <arnd@arndb.de>
