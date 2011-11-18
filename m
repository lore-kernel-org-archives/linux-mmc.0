From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: mmc: sdio: runtime PM and 8686 problems
Date: Fri, 18 Nov 2011 14:15:03 +0200
Message-ID: <CAK=WgbaJ-q4TqgV5tdPQPm6CT9roceqn6QMxEJgA=Prd52jVEQ@mail.gmail.com>
References: <WC20111118085327.010279@terrafix.co.uk> <CAK=WgbZvcTqmpT0jWT1b-GN1e5091AikAfL88Q8Z66dsOXx6Og@mail.gmail.com>
 <WC20111118100011.2902A2@terrafix.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:51040 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754283Ab1KRMPY (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 18 Nov 2011 07:15:24 -0500
Received: by yenq3 with SMTP id q3so2371688yen.19
        for <linux-mmc@vger.kernel.org>; Fri, 18 Nov 2011 04:15:24 -0800 (PST)
In-Reply-To: <WC20111118100011.2902A2@terrafix.co.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Joe Woodward <jw@terrafix.co.uk>
Cc: Daniel Drake <dsd@laptop.org>, linux-mmc@vger.kernel.org

On Fri, Nov 18, 2011 at 12:00 PM, Joe Woodward <jw@terrafix.co.uk> wrote:
> I'm assuming these changes have already made it to the mainline, and therefore are in the 3.2rc2 build I was testing...

Most probably, yeah.

> Is there anything I can do to debug further the problems I'm seeing?

Let's wait for Daniel to take a look, as he got libertas and sd8686
working with SDIO runtime PM.
