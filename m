From: "Joe Woodward" <jw@terrafix.co.uk>
Subject: Re: mmc: sdio: runtime PM and 8686 problems
Date: Tue, 29 Nov 2011 11:17:50 +0000
Message-ID: <WC20111129111750.470087@terrafix.co.uk>
References: <WC20111118085327.010279@terrafix.co.uk> <CAK=WgbZvcTqmpT0jWT1b-GN1e5091AikAfL88Q8Z66dsOXx6Og@mail.gmail.com> <WC20111118100011.2902A2@terrafix.co.uk> <CAK=WgbaJ-q4TqgV5tdPQPm6CT9roceqn6QMxEJgA=Prd52jVEQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp3.keele.netcentral.co.uk ([212.57.235.197]:47409 "EHLO
	smtp3.keele.netcentral.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751663Ab1K2LSH (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 29 Nov 2011 06:18:07 -0500
In-Reply-To: <CAK=WgbaJ-q4TqgV5tdPQPm6CT9roceqn6QMxEJgA=Prd52jVEQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: Daniel Drake <dsd@laptop.org>, linux-mmc@vger.kernel.org

Any more feedback on this?

I don't mind having to maintain my own patch to revert the change to core/host.c to disable runtime PM, but I'm a bit concerned by the commit comment:

"... Enable this trivially for a release or two. If no problems are reported,
we will follow up with a more extensive patch to remove this flag
altogether. If problems are reported, we can look at whitelist/blacklist
possibilities as before."

Certainly for my use case I'd appreciate keeping this flag around!

Cheers,
Joe


-----Original Message-----
From: Ohad Ben-Cohen <ohad@wizery.com>
To: Joe Woodward <jw@terrafix.co.uk>
Cc: Daniel Drake <dsd@laptop.org>, linux-mmc@vger.kernel.org
Date: Fri, 18 Nov 2011 14:15:03 +0200
Subject: Re: mmc: sdio: runtime PM and 8686 problems

> On Fri, Nov 18, 2011 at 12:00 PM, Joe Woodward <jw@terrafix.co.uk>
> wrote:
> > I'm assuming these changes have already made it to the mainline, and
> therefore are in the 3.2rc2 build I was testing...
> 
> Most probably, yeah.
> 
> > Is there anything I can do to debug further the problems I'm seeing?
> 
> Let's wait for Daniel to take a look, as he got libertas and sd8686
> working with SDIO runtime PM.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


