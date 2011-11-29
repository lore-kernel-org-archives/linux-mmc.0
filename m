From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: mmc: sdio: runtime PM and 8686 problems
Date: Tue, 29 Nov 2011 14:43:08 +0200
Message-ID: <CAK=Wgbb6s_BGfJYAoH3V77QvWoAXVAchg0ojBx4Mbmgq8bgvWw@mail.gmail.com>
References: <WC20111118085327.010279@terrafix.co.uk> <CAK=WgbZvcTqmpT0jWT1b-GN1e5091AikAfL88Q8Z66dsOXx6Og@mail.gmail.com>
 <WC20111118100011.2902A2@terrafix.co.uk> <CAK=WgbaJ-q4TqgV5tdPQPm6CT9roceqn6QMxEJgA=Prd52jVEQ@mail.gmail.com>
 <WC20111129111750.470087@terrafix.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:41073 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754760Ab1K2Mn3 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 29 Nov 2011 07:43:29 -0500
Received: by ghrr1 with SMTP id r1so6327118ghr.19
        for <linux-mmc@vger.kernel.org>; Tue, 29 Nov 2011 04:43:29 -0800 (PST)
In-Reply-To: <WC20111129111750.470087@terrafix.co.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Joe Woodward <jw@terrafix.co.uk>, Daniel Drake <dsd@laptop.org>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>

On Tue, Nov 29, 2011 at 1:17 PM, Joe Woodward <jw@terrafix.co.uk> wrote:
> Any more feedback on this?

Daniel, can you please take a look ?

Joe, Daniel's patch is long term the right thing to do, so I hope we
could understand and solve the issue you have and still go on with
Daniel's long term plan.

At the same time, though, we're very much determined not to compromise
any existing functionality. So IMHO it's either fixing your regression
or reverting the change (and then possibly introducing white/black
listing as Daniel suggested), but we definitely aren't going to have
you maintain the fix for this out-of-tree.

Ohad.
