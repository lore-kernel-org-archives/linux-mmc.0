From: Manoj Iyer <manoj.iyer@canonical.com>
Subject: Re: [PATCH] mmc: Added quirks for Ricoh 1180:e823 lower base clock
 frequency
Date: Mon, 18 Jul 2011 16:12:48 -0500 (CDT)
Message-ID: <alpine.DEB.2.02.1107181606290.1677@lazy>
References: <1310419715-13254-1-git-send-email-manoj.iyer@canonical.com> <m2sjqa2q93.fsf@bob.laptop.org> <alpine.DEB.2.02.1107131031360.3174@lazy> <201107131835.25217.arnd@arndb.de> <alpine.DEB.2.02.1107131144250.3174@lazy> <m21uxu2k96.fsf@bob.laptop.org>
 <alpine.DEB.2.02.1107131157440.3174@lazy> <m2wrfm1537.fsf@bob.laptop.org> <alpine.DEB.2.02.1107181535250.1677@lazy> <m2zkkbb9vn.fsf@bob.laptop.org> <alpine.DEB.2.02.1107181546100.1677@lazy> <m2d3h7b8pv.fsf@bob.laptop.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from adelie.canonical.com ([91.189.90.139]:50751 "EHLO
	adelie.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751281Ab1GRVMz (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 18 Jul 2011 17:12:55 -0400
In-Reply-To: <m2d3h7b8pv.fsf@bob.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Manoj Iyer <manoj.iyer@canonical.com>, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, jbarnes@virtuousgeek.org, matsumur@nts.ricoh.co.jp, linux-pci@vger.kernel.org, linux-mmc@vger.kernel.org



> I see, thanks.  So we're lacking any data on what speed the card would
> normally provide.  Perhaps you could try that card on a different
> controller, just so we're able to see whether it's usually possible
> to get closer to 45M/sec with it?

Sure, let me generate some data on based on Ricoh R5C822.


>
> I think I'll take your patch as-is for 3.1 -- since if there is a
> performance degradation, it's on cards that simply don't work at all
> right now -- and if you're able to work on a followup patch that only
> performs the clock-lowering after the first error, I think that'd be a
> handy patch to have around.  Does that sound good?
>

That sounds good to me, that way we limit degradation in performance only 
to previously non-working cards. I will send the V2 soon.

> Thanks!
>
> - Chris.
> -- 
> Chris Ball   <cjb@laptop.org>   <http://printf.net/>
> One Laptop Per Child
>
>
Thanks a ton.
--
====================
Manoj Iyer
Ubuntu/Canonical
Hardware Enablement
====================
