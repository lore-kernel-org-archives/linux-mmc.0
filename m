From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] dw_mmc: modify quirks bit-shift control
Date: Thu, 17 Feb 2011 15:39:14 +0000
Message-ID: <20110217153914.GA30505@void.printf.net>
References: <4D5B6C70.2030809@samsung.com> <20110216194232.GA17634@void.printf.net> <4D5C9F60.9020306@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:57788 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753688Ab1BQPjQ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 17 Feb 2011 10:39:16 -0500
Content-Disposition: inline
In-Reply-To: <4D5C9F60.9020306@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Will Newton <will.newton@gmail.com>, Kyungmin Park <kyungmin.park@samsung.com>

On Thu, Feb 17, 2011 at 01:09:04PM +0900, Jaehoon Chung wrote:
> Hi..
> 
> > Why skip (1 << 1)?  (There's also BIT(0) -> BIT(2) if you prefer.)
> 
> My mistake..sorry..and thanks for your comment..
> I resend the patch applied BIT(0)-BIT(2)

Thanks, pushed to mmc-next with Will's ACK for .39.

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
