From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: kernel 2.6.38.6 MMC controller problem (fwd)
Date: Mon, 16 May 2011 19:56:08 +0200
Message-ID: <BANLkTiky5W=AW=TPe_rQ9QZw=6c5hjexag@mail.gmail.com>
References: <Pine.LNX.4.64.1105160830420.4131@axis700.grange>
	<BANLkTinbJfDLp5nfkq-VTYLJvihT1thXvA@mail.gmail.com>
	<Pine.LNX.4.64.1105161044260.4131@axis700.grange>
	<m3d3jik88n.fsf@pullcord.laptop.org>
	<BANLkTin-wiP9ukmPJPo3n5SWqsd=j9rjBg@mail.gmail.com>
	<m38vu6k5b0.fsf@pullcord.laptop.org>
	<Pine.LNX.4.64.1105161801100.28668@axis700.grange>
	<m34o4uk3f5.fsf@pullcord.laptop.org>
	<Pine.LNX.4.64.1105161841420.28668@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:64573 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753664Ab1EPR4J (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 16 May 2011 13:56:09 -0400
Received: by iwn34 with SMTP id 34so4129162iwn.19
        for <linux-mmc@vger.kernel.org>; Mon, 16 May 2011 10:56:09 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1105161841420.28668@axis700.grange>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Chris Ball <cjb@laptop.org>, David Strobach <lalochcz@gmail.com>, linux-mmc@vger.kernel.org, Greg KH <greg@kroah.com>, horms@verge.net.au, damm@opensource.se, Andrei Warkentin <andreiw@motorola.com>

2011/5/16 Guennadi Liakhovetski <g.liakhovetski@gmx.de>:
> On Mon, 16 May 2011, Chris Ball wrote:
>> My intuition is that we should revert it now -- it's been a week since
>> the final -rc, so you'd expect .39 to be released today, and we can
>> always add your patch back into stable via .40-rc1 if it's not related
>> to the crashes.
>
> Ok, let's revert it then. Just we have to not forget to work on this
> problem and find a proper fix.

I'm still baffled by the whole thing, the solution seems so intuitively
correct. :-(

Is there something strange in the semantics of mmc_claim_host()?

Linus Walleij
