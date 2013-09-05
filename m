From: Prasanna NAVARATNA <prasanna.navaratna@gmail.com>
Subject: Re: [PATCH] mmc: enable BKOPS for supported eMMC(4.41)
Date: Thu, 5 Sep 2013 14:12:22 +0000 (UTC)
Message-ID: <loom.20130905T160711-554@post.gmane.org>
References: <loom.20130830T140917-496@post.gmane.org> <52242F31.4030103@samsung.com> <loom.20130903T105514-341@post.gmane.org> <CAOprVPLx1NR37YJOYzXSkQ7w70o5kWp0dbKdn0OzCr_0B7TkUQ@mail.gmail.com> <52269C2A.2030105@samsung.com> <loom.20130905T110125-516@post.gmane.org> <5228812A.2040301@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:37067 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751968Ab3IEOMp (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 5 Sep 2013 10:12:45 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glkm-linux-mmc@m.gmane.org>)
	id 1VHaId-0006Xi-E3
	for linux-mmc@vger.kernel.org; Thu, 05 Sep 2013 16:12:43 +0200
Received: from 202.122.18.226 ([202.122.18.226])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mmc@vger.kernel.org>; Thu, 05 Sep 2013 16:12:43 +0200
Received: from prasanna.navaratna by 202.122.18.226 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mmc@vger.kernel.org>; Thu, 05 Sep 2013 16:12:43 +0200
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Hello Jaehoon,

> R/W bit is one-time programmable and readable. what do you mean?
Yes, right. Sorry, I was confused with word one-time programmable as W bit.

> If you want to enable the bkops, then you can use your patch at your local
repo, not mainline.
OK. Thanks for the information.

Regards,
Prasanna NAVARATNA

