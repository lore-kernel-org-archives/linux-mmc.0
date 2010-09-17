From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 5/5] sdhci-s3c: Add support no internal clock divider
	in host controller
Date: Fri, 17 Sep 2010 16:59:28 +0100
Message-ID: <20100917155928.GA7561@void.printf.net>
References: <1284626223-18944-1-git-send-email-jeongbae.seo@samsung.com> <1284626223-18944-6-git-send-email-jeongbae.seo@samsung.com> <AANLkTik23B23RW_kmjaL1PeXNiWtU01aNBwUOPrac6HF@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:51801 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753854Ab0IQP7f (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 17 Sep 2010 11:59:35 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTik23B23RW_kmjaL1PeXNiWtU01aNBwUOPrac6HF@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kyungmin Park <kmpark@infradead.org>
Cc: Jeongbae Seo <jeongbae.seo@samsung.com>, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-mmc@vger.kernel.org, ben-linux@fluff.org, kgene.kim@samsung.com, akpm@linux-foundation.org, Hyuk Lee <hyuk1.lee@samsung.com>, =?utf-8?B?7KCV7J6s7ZuI?= <jh80.chung@samsung.com>

Hi,

On Thu, Sep 16, 2010 at 06:08:28PM +0900, Kyungmin Park wrote:
> Well there are two implementations. and no conclusion yet.
> as s5pc210 don't support internal SDHCI clock, DMC overrides the
> function operation itself when s5pc210. System LSI use the quirks.
> 
> Choose any one from MMC maintainer.

Both approaches are generally acceptable for MMC, so I would want to
leave it up to the maintainer of the driver in question (which is Ben,
in this case?) to choose between them.

That said, I think my own mild preference is for Jaehoon's approach.

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
