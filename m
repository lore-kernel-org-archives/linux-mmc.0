From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 2/2] mmc: sd: Fix sd current limit setting
Date: Thu, 19 Jul 2012 01:03:25 -0400
Message-ID: <87txx49wbm.fsf@octavius.laptop.org>
References: <1341296172-10645-1-git-send-email-aaron.lu@amd.com>
	<1341296172-10645-3-git-send-email-aaron.lu@amd.com>
	<CAGxe1ZF=T7GL6ZcyV-=MEd5WVWexNrUbrEZDsYGdFD+KPH4XfA@mail.gmail.com>
	<20120717134325.GA2567@localhost.localdomain>
	<87fw8qieap.fsf@octavius.laptop.org>
	<20120718050939.GA30490@srdclcs1.amd.com>
	<87liihocxj.fsf@octavius.laptop.org>
	<20120718062223.GA2711@aarontestpc.amd.com>
	<CAGxe1ZGoLWr-m6OAriOC4noXGz6SMBGMdMYrk1+wJQw7nwud3g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:33251 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751779Ab2GSFDa (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 19 Jul 2012 01:03:30 -0400
In-Reply-To: <CAGxe1ZGoLWr-m6OAriOC4noXGz6SMBGMdMYrk1+wJQw7nwud3g@mail.gmail.com>
	(Girish K. S.'s message of "Thu, 19 Jul 2012 10:17:27 +0530")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Girish K S <girish.shivananjappa@linaro.org>
Cc: Aaron Lu <aaron.lu@amd.com>, Philip Rakity <prakity@marvell.com>, linux-mmc@vger.kernel.org, Aaron Lu <aaron.lwe@gmail.com>

Hi,

On Thu, Jul 19 2012, Girish K S wrote:
> Looks like a better solution than earlier one.
> Reviewed By: Girish K S <girish.shivananjappa@linaro.org>

Thanks.

> Chris,
> How about the holes created by removal of caps2 macros. Will they be
> adjusted to follow the sequence or left as it is for future use.

There actually isn't a hole in caps2, since yesterday I told Seungwon
and Maya that I think the packed-write patches are not ready for 3.6 and
probably should wait another cycle:

http://marc.info/?l=linux-mmc&m=134259666416161&w=2

I'll be removing them from mmc-next, unless something changes.
There aren't any other caps creating a hole in caps2.

There's a hole in caps1, though.  I think we'll just wait for the next
patches that want caps to take the place of the hole in caps1 without
renumbering any extant caps.  Let me know if you disagree.

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
