Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B464146430
	for <linux-mmc@vger.kernel.org>; Wed, 13 Mar 2024 14:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710339509; cv=none; b=cjIqAiXrP1xa2F+s2w8CFGIvmpIR654jdCaBj2Ma4PlzDi7uPypfWWhyIG4YIW9nennAZ2fOkSsmsunVuqi2ob4zdmANGadBvONvcPMdfx0jLciSubsQWHS4ZXvM8/qv2zJPf/MCQR1KtyybzbRBiX9gFCEHSSypYhE9hvOoIDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710339509; c=relaxed/simple;
	bh=2hiW7UejmntAhTwD1FrO9EX0nOLwNicgwWPoPV4G+YY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cSIkio9phPo0qrx+QsD/lNRINGmfbAttFvqXCBoCYsaBNCiZ04QOALRbpWRGcMZ1/hr+mDQQDOqos1pEZAQlVzdAp7GbCiiBRL1MsXbdDd6Z0SvSaMPGETKVw9UXkIqWbfoKlxyMKAZ8EBh8okhzGivxlK+Sy35bm4LBLO7PC84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=D54Z9eTU; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D54Z9eTU"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2d27fef509eso107695371fa.3
        for <linux-mmc@vger.kernel.org>; Wed, 13 Mar 2024 07:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710339506; x=1710944306; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IeDwxYvjfkvgeFIXSg83hWZ3tZP/41eseEYoNKtI4SQ=;
        b=D54Z9eTUBH85V7xAPFXhecQ2hWYfzKZmlGNISmTZHH7zAVKydLajsTngA+WnfcN6fF
         x5VE+XHzQw+do6WaCx2ESxggxIQs9urGQg8kBvnTNt+qOaUK0FeaHh8jWUY8UXF3LYd6
         KwSQ2+DAMokLPn/tLKRxRc7RK8wnBlU9SakBBQ1xVt4L6TTR5aEZmJvnO+B6T6Fl9pdp
         lE3BFBTJdbZSigB/9zPXp1zGBigUd2NyZuCBggUIcmgdCBHU/oHCq2QBH9TAHzVs87Zj
         nzhgb/kxagaNUs/HyUHqj3Y7+2mLwLZII3r6ZKK+0mFvbTckCQ5Xqn1Ipm/mbRxmoeHr
         L+jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710339506; x=1710944306;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IeDwxYvjfkvgeFIXSg83hWZ3tZP/41eseEYoNKtI4SQ=;
        b=AJ2brkymTVw1t08fp7zk3JzwqbJdbrWE2hYiqg+cDMfBsCZrQoST41lCkb64C/WAm3
         rYZhs8Qi2t3WcpoIhw9nTZcs8o6LaO9KRgX1EIvdpWftc6teojiueEdgENX9CACmsoeG
         yo/4M5l+K+B5qELgYjz9CISL0lMVw+c7EYTACW2KQOMLEaRSrqNUQHACiGpWQZi7tVtY
         C74avImJ6kTOG6C22F56PEBu5Wj42QbRV7O1RsXQIcAT+j3XAUyPxoD+SSyQtdOS7jlZ
         BqWYBmwjqGClM7HlsTBiHhNE4CvDfgw3r0tBe+eZoPFtcYJMpoLVC8SzAH4UwjcaUOhw
         YbvQ==
X-Gm-Message-State: AOJu0YyZb63qboKZ5vbs481WN4w3R3yXoqtd7Tx7lNZ4AddDBy8If78k
	I4IOzSqZ1XrJK6KtYHwzh9up+ZoptXkW6LntpRD5LAammGclgYDzO6FEMGy87YY=
X-Google-Smtp-Source: AGHT+IFxYZ22sQeidD5OMC8xvZmyLc66GyP3hseqwyxathYO0rZ1BeQ/wFIVCO12WnvV1mzKA+MbsA==
X-Received: by 2002:a2e:9e01:0:b0:2d3:f0e7:6bcd with SMTP id e1-20020a2e9e01000000b002d3f0e76bcdmr8206734ljk.40.1710339505940;
        Wed, 13 Mar 2024 07:18:25 -0700 (PDT)
Received: from nuoska (drt4d6yywjht56pm8q3st-3.rev.dnainternet.fi. [2001:14ba:7430:3d00:1239:a19d:315c:6ddf])
        by smtp.gmail.com with ESMTPSA id o11-20020a2e90cb000000b002d10de4733esm2123721ljg.95.2024.03.13.07.18.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 07:18:25 -0700 (PDT)
Date: Wed, 13 Mar 2024 16:18:23 +0200
From: Mikko Rapeli <mikko.rapeli@linaro.org>
To: Avri Altman <Avri.Altman@wdc.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH 2/2] mmc core block.c: avoid negative index with array
 access
Message-ID: <ZfG1r9jmxBKPkmcd@nuoska>
References: <20240313133744.2405325-1-mikko.rapeli@linaro.org>
 <20240313133744.2405325-2-mikko.rapeli@linaro.org>
 <DM6PR04MB65753CE63956185656CB7580FC2A2@DM6PR04MB6575.namprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR04MB65753CE63956185656CB7580FC2A2@DM6PR04MB6575.namprd04.prod.outlook.com>

On Wed, Mar 13, 2024 at 02:12:52PM +0000, Avri Altman wrote:
> > -----Original Message-----
> > From: mikko.rapeli@linaro.org <mikko.rapeli@linaro.org>
> > Sent: Wednesday, March 13, 2024 3:38 PM
> > To: linux-mmc@vger.kernel.org
> > Cc: Mikko Rapeli <mikko.rapeli@linaro.org>; Avri Altman
> > <Avri.Altman@wdc.com>; Ulf Hansson <ulf.hansson@linaro.org>; Adrian Hunter
> > <adrian.hunter@intel.com>; stable@vger.kernel.org
> > Subject: [PATCH 2/2] mmc core block.c: avoid negative index with array access
> > 
> > CAUTION: This email originated from outside of Western Digital. Do not click
> > on links or open attachments unless you recognize the sender and know that the
> > content is safe.
> > 
> > 
> > From: Mikko Rapeli <mikko.rapeli@linaro.org>
> > 
> > Commit "mmc: core: Use mrq.sbc in close-ended ffu" assigns prev_idata =
> > idatas[i - 1] but doesn't check that int iterator i is greater than zero. Add the
> > check.
> I don't think this is even possible given 1/2.

With RPMB ioctl:

        case MMC_DRV_OP_IOCTL_RPMB:
                idata = mq_rq->drv_op_data;
                for (i = 0, ret = 0; i < mq_rq->ioc_count; i++) {
                        ret = __mmc_blk_ioctl_cmd(card, md, idata, i);
                        if (ret)
                                break;
                }

First call is with i = 0?

Cheers,

-Mikko

> Thanks,
> Avri
> 
> > 
> > Fixes: 4d0c8d0aef63 ("mmc: core: Use mrq.sbc in close-ended ffu")
> > 
> > Link: https://lore.kernel.org/all/20231129092535.3278-1-
> > avri.altman@wdc.com/
> > 
> > Cc: Avri Altman <avri.altman@wdc.com>
> > Cc: Ulf Hansson <ulf.hansson@linaro.org>
> > Cc: Adrian Hunter <adrian.hunter@intel.com>
> > Cc: linux-mmc@vger.kernel.org
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Mikko Rapeli <mikko.rapeli@linaro.org>
> > ---
> >  drivers/mmc/core/block.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c index
> > 0df627de9cee..7f275b4ca9fa 100644
> > --- a/drivers/mmc/core/block.c
> > +++ b/drivers/mmc/core/block.c
> > @@ -488,7 +488,7 @@ static int __mmc_blk_ioctl_cmd(struct mmc_card
> > *card, struct mmc_blk_data *md,
> >         if (idata->flags & MMC_BLK_IOC_DROP)
> >                 return 0;
> > 
> > -       if (idata->flags & MMC_BLK_IOC_SBC)
> > +       if (idata->flags & MMC_BLK_IOC_SBC && i > 0)
> >                 prev_idata = idatas[i - 1];
> > 
> >         /*
> > --
> > 2.34.1
> 
