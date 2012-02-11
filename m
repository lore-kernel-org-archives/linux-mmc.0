From: Chris Ball <cjb@laptop.org>
Subject: Re: [RFC] MMC-4.5 Context ID
Date: Sat, 11 Feb 2012 15:57:13 -0500
Message-ID: <m2vcndks0m.fsf@bob.laptop.org>
References: <1328110021-15199-1-git-send-email-saugata.das@stericsson.com>
	<m2mx8y6ls1.fsf@bob.laptop.org>
	<CAKLKtzeRHVeMemTytmaon0GsZ2GqXwz_M_CX6aTj+xDDgN7HVg@mail.gmail.com>
	<4F2F649E.2010106@samsung.com>
	<CAKLKtzcAqJVDTZFYpijicWStr7m76Quv2ic8hRZp+X_Wmd-bFQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:58527 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751696Ab2BKU5Z (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 11 Feb 2012 15:57:25 -0500
In-Reply-To: <CAKLKtzcAqJVDTZFYpijicWStr7m76Quv2ic8hRZp+X_Wmd-bFQ@mail.gmail.com>
	(Saugata Das's message of "Mon, 6 Feb 2012 11:04:10 +0530")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Saugata Das <saugata.das@linaro.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Saugata Das <saugata.das@stericsson.com>, linux-mmc@vger.kernel.org

Hi,

On Mon, Feb 06 2012, Saugata Das wrote:
> Thanks for the info. Perhaps the initial MMC-4.5 device samples do not
> implement this command well. Yes, this feature is good to have in the
> kernel. I shall wait for some more comments on the proposed
> implementation before submitting the patch.

I'm not very excited about merging features that offer no concrete
benefit, because it just grows the kernel (and list of places where bugs
can occur) for no benefit.  So, it would be great if we could find a
device that actually implements these contexts in a way that provides
a performance benefit, to prove that adding the code is worthwhile.

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
