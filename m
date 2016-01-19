From: "Wodkowski, PawelX" <pawelx.wodkowski@intel.com>
Subject: RE: [PATCH] mmc: Add a restriction to mmc debugfs clock setting.
Date: Tue, 19 Jan 2016 06:44:47 +0000
Message-ID: <F6F2A6264E145F47A18AB6DF8E87425D249C45CB@IRSMSX102.ger.corp.intel.com>
References: <1453183995-46099-1-git-send-email-pawelx.wodkowski@intel.com>
 <569DD931.6050001@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:46810 "EHLO mga04.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751146AbcASGpw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 19 Jan 2016 01:45:52 -0500
In-Reply-To: <569DD931.6050001@rock-chips.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: "Dong, Chuanxiao" <chuanxiao.dong@intel.com>, "Yuan, Juntao" <juntao.yuan@intel.com>

> -----Original Message-----
> From: linux-mmc-owner@vger.kernel.org [mailto:linux-mmc-
> owner@vger.kernel.org] On Behalf Of Shawn Lin
> Sent: Tuesday, January 19, 2016 7:35 AM
> To: Wodkowski, PawelX <pawelx.wodkowski@intel.com>; linux-
> mmc@vger.kernel.org
> Cc: shawn.lin@rock-chips.com; Dong, Chuanxiao
> <chuanxiao.dong@intel.com>; Yuan, Juntao <juntao.yuan@intel.com>
> Subject: Re: [PATCH] mmc: Add a restriction to mmc debugfs clock setting.
> 
> On 2016/1/19 14:13, Pawel Wodkowski wrote:
> > From: Chuanxiao Dong <chuanxiao.dong@intel.com>
> >
> > Clock frequency values written to an mmc host should not be less than
> > the minimum clock frequency which the mmc host supports.
> >
> > Signed-off-by: Yuan Juntao <juntaox.yuan@intel.com>
> > Signed-off-by: Pawel Wodkowski <pawelx.wodkowski@intel.com>
> > ---
> >   drivers/mmc/core/debugfs.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/mmc/core/debugfs.c b/drivers/mmc/core/debugfs.c
> > index 154aced0b91b..bdfce774d848 100644
> > --- a/drivers/mmc/core/debugfs.c
> > +++ b/drivers/mmc/core/debugfs.c
> > @@ -220,7 +220,7 @@ static int mmc_clock_opt_set(void *data, u64
> val)
> >   	struct mmc_host *host = data;
> >
> >   	/* We need this check due to input value is u64 */
> > -	if (val > host->f_max)
> > +	if (val > host->f_max || val < host->f_min)
> 
> Hmm... how about if I want to disable clk from sysfs and pass ZERO to
> mmc_clock_opt_set, doesn't that case make sense? :)
> 

So maybe something like this?
if (val != 0 && (val > host->f_max || val < host->f_min))

-- 
Pawel


> >   		return -EINVAL;
> >
> >   	mmc_claim_host(host);
> >
> 
> 
> --
> Best Regards
> Shawn Lin
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
