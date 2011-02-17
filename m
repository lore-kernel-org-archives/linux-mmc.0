From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] dw_mmc: support 8-bit buswidth
Date: Thu, 17 Feb 2011 15:39:42 +0000
Message-ID: <20110217153942.GB30505@void.printf.net>
References: <4D5CCA66.9080008@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:57793 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754560Ab1BQPjn (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 17 Feb 2011 10:39:43 -0500
Content-Disposition: inline
In-Reply-To: <4D5CCA66.9080008@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Will Newton <will.newton@gmail.com>, Kyungmin Park <kyungmin.park@samsung.com>

On Thu, Feb 17, 2011 at 04:12:38PM +0900, Jaehoon Chung wrote:
> This patch is supported 8-bit buswidth
> 
> dw_mmc can also 8-bit buswidth and set to CTYPE_8BIT in card-type register.

Thanks, pushed to mmc-next with Will's ACK for .39.

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
