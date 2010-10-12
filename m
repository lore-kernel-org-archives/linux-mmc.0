From: Kukjin Kim <kgene.kim@samsung.com>
Subject: RE: [PATCH v5 2/2] sdhci-s3c: Add support no internal clock	divider in
 host controller
Date: Tue, 12 Oct 2010 12:37:30 +0900
Message-ID: <011101cb69be$ceda5930$6c8f0b90$%kim@samsung.com>
References: <1286783400-7277-1-git-send-email-kgene.kim@samsung.com>
 <AANLkTinC850pde5Diuz5U40RCDGR1DeQzTAfLUHWm0rB@mail.gmail.com>
 <20101012025946.GA8534@void.printf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <20101012025946.GA8534@void.printf.net>
Content-language: ko
Sender: linux-samsung-soc-owner@vger.kernel.org
To: 'Chris Ball' <cjb@laptop.org>, 'Kyungmin Park' <kmpark@infradead.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-mmc@vger.kernel.org, ben-linux@fluff.org, akpm@linux-foundation.org, 'Jeongbae Seo' <jeongbae.seo@samsung.com>, 'Jaehoon Chung' <jh80.chung@samsung.com>
List-Id: linux-mmc@vger.kernel.org

Chris Ball wrote:
> 
> Hi Kyungmin,
> 
> On Tue, Oct 12, 2010 at 11:53:35AM +0900, Kyungmin Park wrote:
> > Hi Chris,
> >
> > we make a conclusion use this patch. Can you merge it for 2.6.37?
> >
> > Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
> 
> I don't feel that I can, because Ben Dooks is listed as the maintainer
> for this driver and the patch does not have his ACK.
> 
> I don't know what to do about this; I've already tried asking Ben
> whether he intends to continue maintaining sdhci-s3c, with no reply.
> 

Hi Chris,

Yeah, you're right. The sdhci-s3c's maintainer is Ben Dooks. So if get a his
ack, it's best. But if you're ok this, in my opinion, you can merge this.
And as I'm a maintainer of Samsung stuff with Ben Dooks, I already merged
regarding patches, such as sdhci-s3c platform handling into my tree for 37
merge window.
...

Ben, could you please check this patch?...this is ok to me for Samsung
HSMMC...if any opinions, please kindly let us know.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
