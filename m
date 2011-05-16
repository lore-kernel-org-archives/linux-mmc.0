From: David Strobach <lalochcz@gmail.com>
Subject: Re: kernel 2.6.38.6 MMC controller problem (fwd)
Date: Mon, 16 May 2011 18:29:31 +0200
Message-ID: <BANLkTincFDejwEv1zs1V9-kxA-xwUxpbVw@mail.gmail.com>
References: <Pine.LNX.4.64.1105160830420.4131@axis700.grange>
	<BANLkTinbJfDLp5nfkq-VTYLJvihT1thXvA@mail.gmail.com>
	<Pine.LNX.4.64.1105161044260.4131@axis700.grange>
	<m3d3jik88n.fsf@pullcord.laptop.org>
	<BANLkTin-wiP9ukmPJPo3n5SWqsd=j9rjBg@mail.gmail.com>
	<m38vu6k5b0.fsf@pullcord.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:54990 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752803Ab1EPQ3c (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 16 May 2011 12:29:32 -0400
Received: by iyb14 with SMTP id 14so3872872iyb.19
        for <linux-mmc@vger.kernel.org>; Mon, 16 May 2011 09:29:31 -0700 (PDT)
In-Reply-To: <m38vu6k5b0.fsf@pullcord.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>, linux-mmc@vger.kernel.org, Greg KH <greg@kroah.com>, horms@verge.net.au, damm@opensource.se, Andrei Warkentin <andreiw@motorola.com>, Linus Walleij <linus.walleij@linaro.org>

On Mon, May 16, 2011 at 17:56, Chris Ball <cjb@laptop.org> wrote:
> Also, perhaps you could confirm that setting CONFIG_MMC_CLKGATE=n
> makes all of the problems go away, even with the bad patch applied?

Confirmed. No problem with CONFIG_MMC_CLKGATE=n

David
