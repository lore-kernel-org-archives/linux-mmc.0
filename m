From: "Joe Woodward" <jw@terrafix.co.uk>
Subject: Re: mmc: sdio: runtime PM and 8686 problems
Date: Fri, 18 Nov 2011 10:00:11 +0000
Message-ID: <WC20111118100011.2902A2@terrafix.co.uk>
References: <WC20111118085327.010279@terrafix.co.uk> <CAK=WgbZvcTqmpT0jWT1b-GN1e5091AikAfL88Q8Z66dsOXx6Og@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp1.keele.netcentral.co.uk ([212.57.235.197]:38461 "EHLO
	smtp3.keele.netcentral.co.uk" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1752611Ab1KRKAb (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 18 Nov 2011 05:00:31 -0500
In-Reply-To: <CAK=WgbZvcTqmpT0jWT1b-GN1e5091AikAfL88Q8Z66dsOXx6Og@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>, Daniel Drake <dsd@laptop.org>
Cc: linux-mmc@vger.kernel.org

Ohad,

I'm assuming these changes have already made it to the mainline, and therefore are in the 3.2rc2 build I was testing...

If not do you have links to the patches?

Is there anything I can do to debug further the problems I'm seeing?

Cheers,
Joe

-----Original Message-----
From: Ohad Ben-Cohen <ohad@wizery.com>
To: Joe Woodward <jw@terrafix.co.uk>, Daniel Drake <dsd@laptop.org>
Cc: linux-mmc@vger.kernel.org
Date: Fri, 18 Nov 2011 11:06:44 +0200
Subject: Re: mmc: sdio: runtime PM and 8686 problems

> Hi Joe,
> 
> On Fri, Nov 18, 2011 at 10:53 AM, Joe Woodward <jw@terrafix.co.uk>
> wrote:
> > Are these workarounds expected to be enough for runtime PM to just
> "work"?
> 
> It definitely works for 12xx, and with Daniel's recent work merged I
> think it also works fine for the sd8686 (Daniel, PCMIIW).
> 
> Ohad.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


