From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: mmci: Fixup handling of MCI_STARTBITERR
Date: Tue, 13 Dec 2011 12:16:19 -0500
Message-ID: <m2mxawl7do.fsf@bob.laptop.org>
References: <1320939199-30363-1-git-send-email-ulf.hansson@stericsson.com>
	<CACRpkdazenok0RHQL0kXLKk2i3bcrWZ9aWDmoCGfjF6JpEoySA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:57066 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754098Ab1LMRQl (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 13 Dec 2011 12:16:41 -0500
In-Reply-To: <CACRpkdazenok0RHQL0kXLKk2i3bcrWZ9aWDmoCGfjF6JpEoySA@mail.gmail.com>
	(Linus Walleij's message of "Fri, 11 Nov 2011 16:17:17 +0100")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Ulf Hansson <ulf.hansson@stericsson.com>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Russell King <linux@arm.linux.org.uk>

Hi,

On Fri, Nov 11 2011, Linus Walleij wrote:
>> The interrupt was previously enabled and then correctly cleared.
>> Now we also handle it correctly.
>>
>> Signed-off-by: Ulf Hansson <ulf.hansson@stericsson.com>
>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
>
> This should also go to -stable I think?

Just to check:  should I be leaving MMCI patches for Russell to take
care of?  I don't have hardware, so this suits me fine, but MAINTAINERS
currently lists it as Orphan.

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
