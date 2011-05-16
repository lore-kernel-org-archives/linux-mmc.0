From: Chris Ball <cjb@laptop.org>
Subject: Re: kernel 2.6.38.6 MMC controller problem (fwd)
Date: Mon, 16 May 2011 10:52:56 -0400
Message-ID: <m3d3jik88n.fsf@pullcord.laptop.org>
References: <Pine.LNX.4.64.1105160830420.4131@axis700.grange>
	<BANLkTinbJfDLp5nfkq-VTYLJvihT1thXvA@mail.gmail.com>
	<Pine.LNX.4.64.1105161044260.4131@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:54252 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756107Ab1EPOvV (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 16 May 2011 10:51:21 -0400
In-Reply-To: <Pine.LNX.4.64.1105161044260.4131@axis700.grange> (Guennadi
	Liakhovetski's message of "Mon, 16 May 2011 10:45:28 +0200 (CEST)")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: David Strobach <lalochcz@gmail.com>, linux-mmc@vger.kernel.org, Greg KH <greg@kroah.com>, horms@verge.net.au, damm@opensource.se, Andrei Warkentin <andreiw@motorola.com>, Linus Walleij <linus.walleij@linaro.org>

Hi,

On Mon, May 16 2011, Guennadi Liakhovetski wrote:
> "divide error"???... hmmm, maybe one of SDHCI maintainers has to look at 
> it?:)

Just tried to reproduce this, and can't.  David, could you share your
.config please?

I can't see any obvious candidates for a divide error.  Guennadi, do you
think we should back out your patch while investigating?  Is anyone else
able to reproduce the bug?

(Jaehoon's report looks to me like it could be unrelated, since there's
no divide error there..)

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
