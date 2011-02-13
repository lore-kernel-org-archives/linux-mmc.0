From: Pierre Tardy <tardyp@gmail.com>
Subject: Re: [RFC} sdhci.c set_ios -- disable global interrupts and Question
 on Power Management
Date: Sun, 13 Feb 2011 11:25:18 +0100
Message-ID: <AANLkTimh2cZbtnoSLQ7ddq9hFxx7ddfM-NJmaS1f=pXh@mail.gmail.com>
References: <7953F5A4-7BFA-4E40-8202-C682C0314F49@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:47487 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754448Ab1BMKZT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 13 Feb 2011 05:25:19 -0500
Received: by qyj19 with SMTP id 19so719371qyj.19
        for <linux-mmc@vger.kernel.org>; Sun, 13 Feb 2011 02:25:18 -0800 (PST)
In-Reply-To: <7953F5A4-7BFA-4E40-8202-C682C0314F49@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Philip Rakity <prakity@marvell.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On Sun, Feb 13, 2011 at 6:39 AM, Philip Rakity <prakity@marvell.com> wr=
ote:
>
> Pierre,
>
> I am preparing a patch to just diable to interrupt line to the SD con=
troller so global interrupts are not locked out.
I think I already have seen previous version of that patch earlier. It
does not sound like a bad idea. However, disabling all interrupt is
really cheap, and disabling only one is a bit more expensive. AFAIK,
spin_lock and co are really meant for very short time locks.

> =A0This
> will allow mdelay to work correctly in the routines the set_ios() cal=
ls.
This sounds a little bit worse. mdelay is never good, as this is
active wait, that is loosing tons of good cpu cycles.
Do we really need those? Can we do the same thing asynchronous?

>
> The pm_ calls =A0remove the lock before being called and restore it a=
fterwards. =A0Is this just to ensure interrupts are globally
> enabled ?
At least on my platform, pm_ calls cannot be done in atomic context,
and sdhci runtime_pm flow will call set_ios() back, so you will
re-enter the function.

>=A0If so, I can simplify my patch deleting the original spin_lock call=
s that surround the pm_ calls.
No, you cannot safely remove the spin_lock calls here.
