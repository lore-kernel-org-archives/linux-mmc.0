From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 1/5] mmc i.MX: remove individual SoC dependency
Date: Sun, 28 Aug 2011 13:51:28 -0400
Message-ID: <m21uw5zaov.fsf@bob.laptop.org>
References: <1314168072-13822-1-git-send-email-s.hauer@pengutronix.de>
	<1314168072-13822-2-git-send-email-s.hauer@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:58400 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750980Ab1H1Rvg (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sun, 28 Aug 2011 13:51:36 -0400
In-Reply-To: <1314168072-13822-2-git-send-email-s.hauer@pengutronix.de>
	(Sascha Hauer's message of "Wed, 24 Aug 2011 08:41:08 +0200")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org

Hi Sascha,

On Wed, Aug 24 2011, Sascha Hauer wrote:
> The individual SoC dependency in Kconfig hardly scales anymore.
> Instead of having such a fine grained dependency just depend
> on ARCH_MXC and risk that the uninformed user has to look in
> the help text to figure out which driver is the correct one.
>
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Chris Ball <cjb@laptop.org>
> Cc: linux-mmc@vger.kernel.org

Looks good, thanks -- applied to mmc-next for 3.2.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
