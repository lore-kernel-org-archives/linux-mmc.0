From: Chris Ball <cjb@laptop.org>
Subject: Re: [RESEND PATCH V3 0/8] mmc_of_parse() adaptations, switch mvsdio to mmc_of_parse()
Date: Thu, 27 Jun 2013 10:26:17 -0400
Message-ID: <87sj03sk8m.fsf@octavius.laptop.org>
References: <1370808858-32241-1-git-send-email-gmbnomis@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:47027 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753694Ab3F0O02 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 27 Jun 2013 10:26:28 -0400
In-Reply-To: <1370808858-32241-1-git-send-email-gmbnomis@gmail.com> (Simon
	Baatz's message of "Sun, 9 Jun 2013 22:14:10 +0200")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Simon Baatz <gmbnomis@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Ulf Hansson <ulf.hansson@linaro.org>

Hi Simon,

Simon Baatz <gmbnomis@gmail.com> writes:
> 	RESEND V3:
> 	- Dropped patches 9 and 10, they are part of linux-next already
> 	NB: patch 7 as well, but I did not want to change the numbering

I've pushed all patches except 7 to mmc-next for 3.11 now, and I made
Stephen Warren's nit change to patch 6.  Thanks!

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
