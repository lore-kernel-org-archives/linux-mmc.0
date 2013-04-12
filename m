From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v3 1/3] mmc: mxs-mmc: add cd-inverted, non-removable and broken-cd
Date: Fri, 12 Apr 2013 14:18:12 -0400
Message-ID: <8738uvfw9n.fsf@octavius.laptop.org>
References: <1365585225-11360-1-git-send-email-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:35776 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755947Ab3DLSSQ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 12 Apr 2013 14:18:16 -0400
In-Reply-To: <1365585225-11360-1-git-send-email-mkl@pengutronix.de> (Marc
	Kleine-Budde's message of "Wed, 10 Apr 2013 11:13:42 +0200")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-mmc@vger.kernel.org, kernel@pengutronix.de

Hi,

On Wed, Apr 10 2013, Marc Kleine-Budde wrote:
> Hello,
>
> this patch add support for the cd-inverted, non-removeable and broken-cd
> property (as defined in devicetree/bindings/mmc/mmc.txt) to the mxs-mmc driver.
> Tested on a custom imx28 board.
>
> This series applies to Chris Ball's cjb/mmc-next branch.
>
> Changes since v2:
> - add Hector Palacios's patch "[PATCH 3/3] mmc: mxs-mmc: add broken-cd property"

Thanks, pushed to mmc-next for 3.10.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
