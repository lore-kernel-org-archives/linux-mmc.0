From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: RE: [PATCH] mmc: trivial: fix the compiling warning
Date: Wed, 06 Nov 2013 18:42:25 +0900
Message-ID: <001401cedad4$80599700$810cc500$%jun@samsung.com>
References: <1383653403-10049-1-git-send-email-ulf.hansson@linaro.org>
 <003201ceda2a$a1546f70$e3fd4e50$%jun@samsung.com>
 <5279B58E.8040002@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:11785 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756068Ab3KFJm1 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 6 Nov 2013 04:42:27 -0500
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MVU0059A5MKEH00@mailout3.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 06 Nov 2013 18:42:26 +0900 (KST)
In-reply-to: <5279B58E.8040002@samsung.com>
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Jaehoon Chung' <jh80.chung@samsung.com>, 'Chris Ball' <cjb@laptop.org>, 'Ulf Hansson' <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org

On Wed, November 06, 2013, Jaehoon Chung wrote:
> I known this patch is already included into Ulf's patchset.
> 
> mmc: core: Silence compiler warning in __mmc_switch

Oh, good!

Thanks,
Seungwon Jeon
> 
> Best regards,
> Jaehoon Chung
> 
> On 11/05/2013 10:26 PM, Seungwon Jeon wrote:
> > Fixed the following warning.
> >
> > drivers/mmc/core/mmc_ops.c:484:11: warning: 'status' may be used
> > uninitialized in this function [-Wmaybe-uninitialized]
> >
> > Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
> > ---
> >  drivers/mmc/core/mmc_ops.c |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> >
> > diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
> > index aae8d8b..e5b5eeb 100644
> > --- a/drivers/mmc/core/mmc_ops.c
> > +++ b/drivers/mmc/core/mmc_ops.c
> > @@ -414,7 +414,7 @@ int __mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
> >  	int err;
> >  	struct mmc_command cmd = {0};
> >  	unsigned long timeout;
> > -	u32 status;
> > +	u32 status = 0;
> >  	bool ignore_crc = false;
> >
> >  	BUG_ON(!card);
> >
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

