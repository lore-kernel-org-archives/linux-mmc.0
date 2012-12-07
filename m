From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 0/3] mmc: add a card-event host call-back
Date: Fri, 07 Dec 2012 13:56:45 -0500
Message-ID: <87vccdbsia.fsf@octavius.laptop.org>
References: <Pine.LNX.4.64.1212041633470.26918@axis700.grange>
	<20121207134158.GA30468@S2100-06.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:37419 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752010Ab2LGS45 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 7 Dec 2012 13:56:57 -0500
In-Reply-To: <20121207134158.GA30468@S2100-06.ap.freescale.net> (Shawn Guo's
	message of "Fri, 7 Dec 2012 21:42:01 +0800")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>, linux-mmc@vger.kernel.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>, Mike Rapoport <mike@compulab.co.il>, linux-arm-kernel@lists.infradead.org

Hi,

On Fri, Dec 07 2012, Shawn Guo wrote:
> On Tue, Dec 04, 2012 at 04:51:28PM +0100, Guennadi Liakhovetski wrote:
>> In a recent thread [1] an extension to the slot-gpio MMC API, adding a 
>> host call-back for card detection events, has been proposed. This 
>> extension shall be used by the SDHCI driver to reset the host if the card 
>> is ejected during a running request. These patches add such a call-back.
>> 
> For the series,
>
> Reviewed-by: Shawn Guo <shawn.guo@linaro.org>

Thanks, pushed to mmc-next for 3.8.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
