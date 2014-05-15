From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: How to fix SDIO Operating Frequency in iMX6 device tree
Date: Thu, 15 May 2014 14:32:28 +0200
Message-ID: <20140515123228.GI5858@pengutronix.de>
References: <CA+dawz2qxiVBzKkJVvMMU9wtfLajzN-z=ApmnZ3g8h42AncERQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:47033 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753579AbaEOMcl (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 15 May 2014 08:32:41 -0400
Content-Disposition: inline
In-Reply-To: <CA+dawz2qxiVBzKkJVvMMU9wtfLajzN-z=ApmnZ3g8h42AncERQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ashutosh Singh <embedded.ashu@gmail.com>
Cc: chris@printf.net, linux-mmc@vger.kernel.org, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, shawn.guo@linaro.org, linux-arm-kernel@lists.infradead.org, devicetree <devicetree@vger.kernel.org>

Hi Ashutosh,

On Thu, May 15, 2014 at 11:19:01AM +0530, Ashutosh Singh wrote:
> I want to fixed the SDIO Operating Frequency to 25MHz for one of the
> SDIO based Wifi module connected to Card slot.
> How can i fixed it in my dtsi file. I am using iMX6 quard based custom board.

Set the max-frequency property in the usdhc device node.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
