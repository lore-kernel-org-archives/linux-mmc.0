Return-Path: <SRS0=xq36=CY=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B60A8C43461
	for <linux-mmc@archiver.kernel.org>; Tue, 15 Sep 2020 07:01:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DC1820897
	for <linux-mmc@archiver.kernel.org>; Tue, 15 Sep 2020 07:01:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LrfcW1Bg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726085AbgIOHA6 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 15 Sep 2020 03:00:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726035AbgIOHAx (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 15 Sep 2020 03:00:53 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00A4BC06174A
        for <linux-mmc@vger.kernel.org>; Tue, 15 Sep 2020 00:00:52 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id m15so842634pls.8
        for <linux-mmc@vger.kernel.org>; Tue, 15 Sep 2020 00:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=ASXbpbtM4ide7MBFfrVyN2tSkDikwXYphp0Hhp0Sqjc=;
        b=LrfcW1BgHeRsi6WxL2irULJnVwdJ+s+lf4OKOulnwddfPVe+O5nL/Sjw+8JdmJ49qd
         w5BZz0sv6WmcieDflKjmbRdI6qB3Nv3Erj9yF9Tb2++rnvxd4LnuhWAttZ+eu9EYa53v
         5lh99YX+WLViatKXZDgoBiqjP6ciYEPieEZtwRvL9yeO4aKU9Fi1ETSEafsZ5TI8N88s
         jcTrhAjjPfUGczZjgEZdOMi+QOqM91hRW/kebXwmXPzWD9sdmsKJlkiTVwMo2UOONPW9
         5brY10+j7KJqYZodt473lV/LMM40N4VxKAdg+dykzCV8BrYIiXVK4IMBv2b7xcj2qT12
         WHyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=ASXbpbtM4ide7MBFfrVyN2tSkDikwXYphp0Hhp0Sqjc=;
        b=UeBzkeAkEbDMyfH1XlTH9MCch1RZWnc9+DBg/ciuCbXjzC7fW4f4TEXK3IO0o3t0oL
         GyI4AnKr+KhJUDGRePT2AHb862i7rXuvBT9WHh8XBl3EK2vRbPA9jv1J0eLxoBl3SLg/
         dU3WREQBPS6K10eljvBSDLpt5l6fx/tjQ1ya03ZvNp0DPB5AlHcWencUqjnIO2pN/Fcr
         XzZ+bIpinftEjXPsH4Swnz5+wOstZqbG+KxVyLq9y4T7kEnbpSazf5gIS0/z2s+QR15w
         ixo+9aUZqRoXynGluF5qUAicEmKuyZhIervHcIdvv3PapO2J3kldkOrm5ykJAyJ0C4Kr
         4LPA==
X-Gm-Message-State: AOAM532nVHIMf4uORmQI+Rs5IQGSWZbDlTgPW/cWN9F2cPTzLRSyMIVN
        5XeA1Xc7iATXGWZJPtO5BOmpjg==
X-Google-Smtp-Source: ABdhPJwhtrLzR2xD32h6LvV/cKQl19xJmAxIoSanzHeGqgtsR7pD9xb7cpNYI37sST5dx016RSCGRQ==
X-Received: by 2002:a17:90a:c505:: with SMTP id k5mr2773552pjt.188.1600153252511;
        Tue, 15 Sep 2020 00:00:52 -0700 (PDT)
Received: from laputa (p784a66b9.tkyea130.ap.so-net.ne.jp. [120.74.102.185])
        by smtp.gmail.com with ESMTPSA id e13sm7529656pjy.38.2020.09.15.00.00.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 00:00:51 -0700 (PDT)
Date:   Tue, 15 Sep 2020 16:00:47 +0900
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Ben Chuang <benchuanggli@gmail.com>, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.chuang@genesyslogic.com.tw, greg.tu@genesyslogic.com.tw
Subject: Re: [RFC PATCH V3 14/21] mmc: sdhci: UHS-II support, handle vdd2 in
 case of power-off
Message-ID: <20200915070047.GF2860208@laputa>
Mail-Followup-To: AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ben Chuang <benchuanggli@gmail.com>, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.chuang@genesyslogic.com.tw, greg.tu@genesyslogic.com.tw
References: <20200710111121.29671-1-benchuanggli@gmail.com>
 <ef621382-b8b9-e8d2-cc54-3e6377050d5b@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef621382-b8b9-e8d2-cc54-3e6377050d5b@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, Aug 21, 2020 at 05:09:55PM +0300, Adrian Hunter wrote:
> On 10/07/20 2:11 pm, Ben Chuang wrote:
> > From: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > 
> > Configure a regulator for VDD2 in case of power-off.
> > 
> > Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> > Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > ---
> >  drivers/mmc/host/sdhci.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> > index 7f2537648a08..d38d734ec83f 100644
> > --- a/drivers/mmc/host/sdhci.c
> > +++ b/drivers/mmc/host/sdhci.c
> > @@ -2333,6 +2333,11 @@ void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
> >  		if (!IS_ERR(mmc->supply.vmmc) &&
> >  		    ios->power_mode == MMC_POWER_OFF)
> >  			mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, 0);
> > +		if (IS_ENABLED(CONFIG_MMC_SDHCI_UHS2) &&
> > +		    host->mmc->caps & MMC_CAP_UHS2 &&
> > +		    !IS_ERR(mmc->supply.vmmc2) &&
> > +		    ios->power_mode == MMC_POWER_OFF)
> 
> Probably this can be just:
> 
> 		if (!IS_ERR_OR_NULL(mmc->supply.vmmc2) &&
> 		    ios->power_mode == MMC_POWER_OFF)

Yeah, probably.

-Takahiro Akashi

> 
> > +			mmc_regulator_set_ocr(mmc, mmc->supply.vmmc2, 0);
> >  		return;
> >  	}
> >  
> > 
> 
