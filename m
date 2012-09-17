From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: sdhci: Test cd-gpio instead of SDHCI presence when probing
Date: Mon, 17 Sep 2012 06:08:13 -0400
Message-ID: <m31ui1ynaq.fsf@pullcord.laptop.org>
References: <m3y5k9yxfz.fsf@pullcord.laptop.org>
	<Pine.LNX.4.64.1209170834170.1689@axis700.grange>
	<m3a9wpyqnc.fsf_-_@pullcord.laptop.org>
	<Pine.LNX.4.64.1209171107130.1689@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:51082 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752797Ab2IQKH7 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 17 Sep 2012 06:07:59 -0400
In-Reply-To: <Pine.LNX.4.64.1209171107130.1689@axis700.grange> (Guennadi
	Liakhovetski's message of "Mon, 17 Sep 2012 11:09:38 +0200 (CEST)")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-mmc@vger.kernel.org

Hi,

On Mon, Sep 17 2012, Guennadi Liakhovetski wrote:
> On Mon, 17 Sep 2012, Chris Ball wrote:
>
>> From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
>> 
>> Previously to this patch, an SDHCI platform that uses a GPIO for
>> card detection instead of the internal SDHCI_CARD_PRESENT bit on
>> the presence register would fail to bring up a new card because
>> logic in sdhci_request() fails the request if that bit is 0.
>> 
>> Some drivers worked around this in various ways: esdhc-imx defines
>> an IO accessor to fake the presence bit being true, s3c turns on
>> polling (which stops the SDHCI driver from checking the bit) after
>> a card's inserted.  But none of this should be necessary; the real
>> fix is to check whether we're using a GPIO and avoid relying on
>> the presence bit if so, as this patch implements.
>> 
>
> Well, ok, thanks for attributing this patch to me:-) I guess then my Sob 
> should go in the first, as you'll be forwarding the patch upstream? But 
> feel free to swap them if you disagree
>
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

Yes, I'll put yours in first.  Pushed to mmc-next for 3.7; thanks!

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
