From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] sdhci-s3c: add platform_8bit_width()
Date: Wed, 12 Jan 2011 03:58:14 +0000
Message-ID: <20110112035814.GA28479@void.printf.net>
References: <4D2CF631.4080402@samsung.com> <20110112022030.GA27414@void.printf.net> <4D2D1900.1020200@samsung.com> <20110112032700.GA28143@void.printf.net> <AANLkTi=oh004OUBQSSBQU634SuwKhRHNzriUu4DZv9dD@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:43896 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932798Ab1ALD6S (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 11 Jan 2011 22:58:18 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTi=oh004OUBQSSBQU634SuwKhRHNzriUu4DZv9dD@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kyungmin Park <kmpark@infradead.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Ben Dooks <ben-linux@fluff.org>

On Wed, Jan 12, 2011 at 12:54:07PM +0900, Kyungmin Park wrote:
> Umm I think it's kind of bug fix since we used 8-bit buswidth previous
> code but recent change don't make it working
> So re-support the 8-bit buswidth. Can you merge it at 38.rc period?

Okay, that should be fine.  As always, though, it would be nice to see
an ACK from Ben before pushing it through quickly.

Thanks,

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
