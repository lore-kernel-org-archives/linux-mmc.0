From: David Strobach <lalochcz@gmail.com>
Subject: Re: kernel 2.6.38.6 MMC controller problem (fwd)
Date: Wed, 18 May 2011 15:29:28 +0200
Message-ID: <BANLkTinRiQkYcc5zAbtiYochv9KEVAF4OQ@mail.gmail.com>
References: <Pine.LNX.4.64.1105160830420.4131@axis700.grange>
	<BANLkTinbJfDLp5nfkq-VTYLJvihT1thXvA@mail.gmail.com>
	<Pine.LNX.4.64.1105161044260.4131@axis700.grange>
	<m3d3jik88n.fsf@pullcord.laptop.org>
	<BANLkTin-wiP9ukmPJPo3n5SWqsd=j9rjBg@mail.gmail.com>
	<m38vu6k5b0.fsf@pullcord.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:58757 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756255Ab1ERN33 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 18 May 2011 09:29:29 -0400
Received: by iwn34 with SMTP id 34so1290262iwn.19
        for <linux-mmc@vger.kernel.org>; Wed, 18 May 2011 06:29:29 -0700 (PDT)
In-Reply-To: <m38vu6k5b0.fsf@pullcord.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>, linux-mmc@vger.kernel.org, Greg KH <greg@kroah.com>, horms@verge.net.au, damm@opensource.se, Andrei Warkentin <andreiw@motorola.com>, Linus Walleij <linus.walleij@linaro.org>

Hi,

On Mon, May 16, 2011 at 17:56, Chris Ball <cjb@laptop.org> wrote:
> David, are you very confident in the bisection being correct?

I've built packages for Archlinux with the suspected commit dropped.
So far there are three confirmations in the forum. Also there are new
symptoms described.
https://bbs.archlinux.org/viewtopic.php?id=118751

David
