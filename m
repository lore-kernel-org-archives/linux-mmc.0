From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v5 2/2] sdhci-s3c: Add support no internal clock
	divider in host controller
Date: Tue, 12 Oct 2010 03:59:46 +0100
Message-ID: <20101012025946.GA8534@void.printf.net>
References: <1286783400-7277-1-git-send-email-kgene.kim@samsung.com> <AANLkTinC850pde5Diuz5U40RCDGR1DeQzTAfLUHWm0rB@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <AANLkTinC850pde5Diuz5U40RCDGR1DeQzTAfLUHWm0rB@mail.gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Kyungmin Park <kmpark@infradead.org>
Cc: Kukjin Kim <kgene.kim@samsung.com>, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-mmc@vger.kernel.org, ben-linux@fluff.org, akpm@linux-foundation.org, cjb@laptop.org, Jeongbae Seo <jeongbae.seo@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>
List-Id: linux-mmc@vger.kernel.org

Hi Kyungmin,

On Tue, Oct 12, 2010 at 11:53:35AM +0900, Kyungmin Park wrote:
> Hi Chris,
> 
> we make a conclusion use this patch. Can you merge it for 2.6.37?
> 
> Acked-by: Kyungmin Park <kyungmin.park@samsung.com>

I don't feel that I can, because Ben Dooks is listed as the maintainer
for this driver and the patch does not have his ACK.

I don't know what to do about this; I've already tried asking Ben
whether he intends to continue maintaining sdhci-s3c, with no reply.

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
