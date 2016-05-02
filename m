From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 1/2] ARM: OMAP2+: n900 needs MMC slot names for legacy
 user space
Date: Mon, 2 May 2016 09:05:55 +0200
Message-ID: <20160502070555.GA13215@amd>
References: <1461714383-9956-1-git-send-email-tony@atomide.com>
 <1461714383-9956-2-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:34577 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751187AbcEBHF6 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 2 May 2016 03:05:58 -0400
Content-Disposition: inline
In-Reply-To: <1461714383-9956-2-git-send-email-tony@atomide.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Aaro Koskinen <aaro.koskinen@iki.fi>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Sebastian Reichel <sre@kernel.org>, Timo Kokkonen <timo.t.kokkonen@iki.fi>, Kishon Vijay Abraham I <kishon@ti.com>, linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>

On Tue 2016-04-26 16:46:22, Tony Lindgren wrote:
> Let's pass the slot names in pdata like the legacy code does.
> Once we have a generic DT binding for the slot names we can
> switch to that.
> 
> Signed-off-by: Tony Lindgren <tony@atomide.com>

Acked-by: Pavel Machek <pavel@ucw.cz>

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
