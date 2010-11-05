From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH] mmc: agressive clocking framework v9
Date: Fri, 5 Nov 2010 06:03:08 -0400
Message-ID: <AANLkTikOcCHCpG6CfxazadDSeL4GLkXdEngR0Kw5sYx0@mail.gmail.com>
References: <1288869390-20465-1-git-send-email-linus.walleij@stericsson.com>
 <4CD2B1FF.6030708@csr.com> <4CD2C240.8030400@stericsson.com>
 <alpine.LFD.2.00.1011041257270.18581@xanadu.home> <4CD3C1C5.1030301@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:60874 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752580Ab0KEKDa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 5 Nov 2010 06:03:30 -0400
Received: by iwn41 with SMTP id 41so713113iwn.19
        for <linux-mmc@vger.kernel.org>; Fri, 05 Nov 2010 03:03:29 -0700 (PDT)
In-Reply-To: <4CD3C1C5.1030301@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.walleij@stericsson.com>
Cc: Nicolas Pitre <nico@fluxnic.net>, David Vrabel <david.vrabel@csr.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Ghorai Sukumar <s-ghorai@ti.com>, Chris Ball <cjb@laptop.org>, Adrian Hunter <adrian.hunter@nokia.com>, Kyungmin Park <kmpark@infradead.org>, "jh80.chung@samsung.com" <jh80.chung@samsung.com>

On Fri, Nov 5, 2010 at 4:35 AM, Linus Walleij
<linus.walleij@stericsson.com> wrote:
> Nicolas Pitre wrote:
>
>> Maybe the runtime PM stuff is not the right abstraction for this?
>
> Hm, yeah the bad thing is that I can't reuse the delay code
> from runtime PM.

Why not ?

>  But all the hazzle of creating dummy devices
> nodes just to reuse runtime PM is even more disturbing.

Yeah creating dummy devices is not a good approach.

> Can I take this as your Acked-by: for the v7 patch using the old
> host-local approach?

=46WIW, I don't mind helping out with the runtime PM migration, so if
you prefer to push v7 I could take it from there (when I get to
it...).

>
> Linus Walleij
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
