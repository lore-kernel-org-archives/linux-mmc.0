From: "Liu, Changcheng" <changcheng.liu@intel.com>
Subject: Re: [PATCH v2] mmc: block: fix logical error to avoid memory leak
Date: Mon, 18 Dec 2017 21:16:10 +0800
Message-ID: <20171218131610.GA91929@sofia>
References: <20171214050305.GA135779@sofia>
 <f9294d5a-bd24-8b95-3666-fa75d681bec1@intel.com>
 <20171216151545.GA138678@sofia>
 <CAPDyKFojyPB5QULubDVar1kqnHQ0SUeZn7kr=HWKfDiWmujQ6Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:11280 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1758188AbdLRNRR (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 18 Dec 2017 08:17:17 -0500
Content-Disposition: inline
In-Reply-To: <CAPDyKFojyPB5QULubDVar1kqnHQ0SUeZn7kr=HWKfDiWmujQ6Q@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, adrian.hunter@intel.com
Cc: linus.walleij@linaro.org, linux-mmc@vger.kernel.org, akpm@linux-foundation.org

Hi Uffe,
    Thx for your guide. I'm on the way to work with community. I'll
	follow your suggestion next time.

B.R.
Changcheng

On 21:05 Mon 18 Dec, Ulf Hansson wrote:
> On 16 December 2017 at 16:15, Liu, Changcheng <changcheng.liu@intel.com> wrote:
> > If the MMC_DRV_OP_GET_EXT_CSD request completes successfully, then
> > ext_csd must be freed, but in one case it was not. Fix that.
> >
> > Signed-off-by: Liu Changcheng <changcheng.liu@intel.com>
> 
> Thanks, applied for next!
> 
> Next time, you may please preserve acks from previous versions,
> especially if the reviewer (Adrian in this case) says so.
> 
> Kind regards
> Uffe
> 
> >
> > diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> > index ccfa98a..b737a95 100644
> > --- a/drivers/mmc/core/block.c
> > +++ b/drivers/mmc/core/block.c
> > @@ -2623,6 +2623,7 @@ static int mmc_ext_csd_open(struct inode *inode, struct file *filp)
> >
> >         if (n != EXT_CSD_STR_LEN) {
> >                 err = -EINVAL;
> > +               kfree(ext_csd);
> >                 goto out_free;
> >         }
> >
> > --
> > 2.7.4
