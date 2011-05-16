From: David Strobach <lalochcz@gmail.com>
Subject: Re: kernel 2.6.38.6 MMC controller problem (fwd)
Date: Mon, 16 May 2011 18:07:41 +0200
Message-ID: <BANLkTik7KWdOw_dbxUYQMFo5oujUFtnayA@mail.gmail.com>
References: <Pine.LNX.4.64.1105160830420.4131@axis700.grange>
	<BANLkTinbJfDLp5nfkq-VTYLJvihT1thXvA@mail.gmail.com>
	<Pine.LNX.4.64.1105161044260.4131@axis700.grange>
	<m3d3jik88n.fsf@pullcord.laptop.org>
	<BANLkTin-wiP9ukmPJPo3n5SWqsd=j9rjBg@mail.gmail.com>
	<m38vu6k5b0.fsf@pullcord.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:60860 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756547Ab1EPQHm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 16 May 2011 12:07:42 -0400
Received: by iwn34 with SMTP id 34so4043409iwn.19
        for <linux-mmc@vger.kernel.org>; Mon, 16 May 2011 09:07:41 -0700 (PDT)
In-Reply-To: <m38vu6k5b0.fsf@pullcord.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>, linux-mmc@vger.kernel.org, Greg KH <greg@kroah.com>, horms@verge.net.au, damm@opensource.se, Andrei Warkentin <andreiw@motorola.com>, Linus Walleij <linus.walleij@linaro.org>

On Mon, May 16, 2011 at 17:56, Chris Ball <cjb@laptop.org> wrote:
> Oh, that's interesting -- https://bugs.archlinux.org/task/23778 was
> opened on April 15th with the divide error crash, but I didn't send
> Guennadi's patch to Linus until May 9th. =A0So this patch can't be th=
e
> whole story.

I don't think the Arch issue 23778 is related to this problem. This
crash happens as soon as the card is inserted.

> David, are you very confident in the bisection being correct?

Well, I'm quite sure. I was only searching in patches between 2.6.38.5
and 2.6.38.6 and the problem is 100% reproducible.

> Also, perhaps you could confirm that setting CONFIG_MMC_CLKGATE=3Dn
> makes all of the problems go away, even with the bad patch applied?

OK, I'll try.

David
