Return-Path: <SRS0=/V3P=7B=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A078EC433DF
	for <linux-mmc@archiver.kernel.org>; Tue, 19 May 2020 03:12:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B19C207D4
	for <linux-mmc@archiver.kernel.org>; Tue, 19 May 2020 03:12:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NtoxywpP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbgESDM4 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 18 May 2020 23:12:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726492AbgESDMz (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 18 May 2020 23:12:55 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85EDDC05BD09
        for <linux-mmc@vger.kernel.org>; Mon, 18 May 2020 20:12:55 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id t16so5043852plo.7
        for <linux-mmc@vger.kernel.org>; Mon, 18 May 2020 20:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3v3MiZlo1XQ0uF7dScBuWcXQ31132PApMmyTjCRh1s4=;
        b=NtoxywpPq7v7prXF2XTo8wUph0rWq/S0lIXWZeyoP43Lz4+yRabPduDEKiiiKnCLIl
         WuYV0IIA0xz1CZogBvWda/rdWNdn5TK70Ldx5aemk+SAUvI2x4S7MBGg1FUZAfwHoeYx
         PE+kexXeLDnU+6qmmyohuEHNOea0C4k+sgy9zedhCcpGswf+MAgbVB4E8xroKBr5qy16
         dTJJVZVcge8ZmyQ1AauEHTUYMrSibW0FPixF9PVjII96J1KPiPfuH48rwNS1xyJ6gmkZ
         IMIfLYJuG7Fzc8LSWiP4JIx/AOEo56JjY+XMRwOOCaYTXuHmidNHMvw/9WL0/Yy/ttpk
         N7lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3v3MiZlo1XQ0uF7dScBuWcXQ31132PApMmyTjCRh1s4=;
        b=JTrseEmtpkG/hQPsqHkZk1xkTNKrqXS7g3vCtsdbbXosgsdXaDoznDDU5P1blYEzYE
         vSdMthF1VEsWOk0lSIBr2WPQhAzaNseXwnv4jksQiaxcfrVDJGWUtd3s48EK6KA81AcP
         nXwCEF1IPOMZYPoTHgld1iy6AJfpcO+39oo1t5equw0nRlZFihIBj/5AY6vFr/qMx2Pn
         JhfkljICaaPC9IzQ2I2nOZ2fxblknbOMJXNFXSF+tdxDFu5O00DkjDVWbwwhC69OgKTy
         +kYVLsAglRB0dif6XkEvjPu665lS2Xi2pk4B00JhX8HU1QTgeQDhabO37QuOc4ZUB5CH
         UBhg==
X-Gm-Message-State: AOAM531X5zxn5+9Vmg1B6LOAwV8c6J5lLbGfju2zJx9QYQMY26OHLyGP
        GhlTMivKja5VI8yJfC6s71zs+Q==
X-Google-Smtp-Source: ABdhPJwKax2oSjJnW36S7DMBKX2GCg1zj4Ul3O3ZQYqwsX5LcqUGPqt0MaNI/w1mWD7R19zaWEGFsg==
X-Received: by 2002:a17:902:8e8c:: with SMTP id bg12mr19656340plb.279.1589857974810;
        Mon, 18 May 2020 20:12:54 -0700 (PDT)
Received: from builder.lan (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id t20sm746677pjo.13.2020.05.18.20.12.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2020 20:12:53 -0700 (PDT)
Date:   Mon, 18 May 2020 20:11:31 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
Cc:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        robh+dt@kernel.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org,
        Vijay Viswanath <vviswana@codeaurora.org>,
        Asutosh Das <asutoshd@codeaurora.org>,
        Andy Gross <agross@kernel.org>
Subject: Re: [PATCH V1 2/3] mmc: sdhci-msm: Use internal voltage control
Message-ID: <20200519031131.GH279327@builder.lan>
References: <1589541535-8523-1-git-send-email-vbadigan@codeaurora.org>
 <1589541535-8523-3-git-send-email-vbadigan@codeaurora.org>
 <20200518195711.GH2165@builder.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200518195711.GH2165@builder.lan>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon 18 May 12:57 PDT 2020, Bjorn Andersson wrote:
> On Fri 15 May 04:18 PDT 2020, Veerabhadrarao Badiganti wrote:
> > diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
[..]
> > +static int sdhci_msm_register_vreg(struct sdhci_msm_host *msm_host)
> > +{
> > +	int ret = 0;
> 
> No need to initialize ret, first use is an assignment.
> 
> > +	struct mmc_host *mmc = msm_host->mmc;
> > +
> > +	ret = mmc_regulator_get_supply(msm_host->mmc);
> > +	if (ret)
> > +		return ret;
> > +	device_property_read_u32(&msm_host->pdev->dev,
> > +			"vmmc-max-load-microamp",
> > +			&msm_host->vmmc_load);
> > +	device_property_read_u32(&msm_host->pdev->dev,
> > +			"vqmmc-max-load-microamp",
> > +			&msm_host->vqmmc_load);
> 
> These properties are not documented. Do they vary enough to mandate
> being read from DT or could they simply be approximated by a define
> instead?
> 

Disregard my comment about them not being documented, I wasn't Cc'ed on
the binding patch and missed it.

My question about just defining them statically still stands.

Thanks,
Bjorn
