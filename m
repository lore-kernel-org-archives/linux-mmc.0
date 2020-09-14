Return-Path: <SRS0=0j+4=CX=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADC66C433E2
	for <linux-mmc@archiver.kernel.org>; Mon, 14 Sep 2020 06:40:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69295217BA
	for <linux-mmc@archiver.kernel.org>; Mon, 14 Sep 2020 06:40:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QLXNb0ty"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726039AbgINGkJ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 14 Sep 2020 02:40:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726003AbgINGkH (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 14 Sep 2020 02:40:07 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AEA2C06174A
        for <linux-mmc@vger.kernel.org>; Sun, 13 Sep 2020 23:40:07 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id l126so11766696pfd.5
        for <linux-mmc@vger.kernel.org>; Sun, 13 Sep 2020 23:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=atcKwaBqus6vSm7n0jlynlMqX6QpwtKbWJLYE/P4Slk=;
        b=QLXNb0tyu4HvCi5kFeFA6ycmyXfT8WCCIYtFgRP37a46cKCWLtkX2jUddiaeNN9+VH
         PlcFhjNP9jIzpSb3Frb1nhXUx4qVcxpS4wBXrEjPPJbnYVa8CdlHbUoYQQZq+OfUyvOA
         jI1nu2mtx2kTSTbAmGh3OTu7e2r8C3SC9WC0X+zNr5/tNx/TYw61GIGBwEyFqZ7+yuJJ
         uoECNYrp6KqqJuI4V8qeQcgG2xQgcK+hRvRYuKVx6M23eE8dqvg27/hronWIa3ChQboG
         0ZkznpDRgaEPU1jtTE4MYbMKB3ncOvKmesTcziY+ql50++lZquqpVrlyI1QZeQfcJn2/
         4s6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=atcKwaBqus6vSm7n0jlynlMqX6QpwtKbWJLYE/P4Slk=;
        b=iPfiCiBxBy9jk7uRBxUcw6q2C7X/KkgdDcyZMFqCPHPrPWlbF6hu+iBSWExJAbMupk
         O8752OdlksZzvkP763zSjjghUiqNsQ/an8Jf7KyAfAeUhwk9z0DFchwBjK38LOW/P7gp
         Xr24wXWqJxQdmx02eFHp5ZYx40N3lySqL0zyz0K+nqAgx6gvMTcbWCgo4vdEgdzDUCG+
         oKqeNfHMYgBtn8wxVK4W6erU3tr6hq+7MmL3U6vP/4XCiQVv49ky/tVg+neODBYCSzVc
         Y4aRGQik2k9lC4euypYLYwfhqs5QZcDduJTCj0W+TavWBwePUz7vGkaboANLJlon+Zxg
         rkzA==
X-Gm-Message-State: AOAM530tfJ9NlHuMbQXyK79seD5Bf8qqU6Pg65WJSyymr9P2YbU/r5ln
        X/62h0RuWeEMQGVd8PaVIdXmNA==
X-Google-Smtp-Source: ABdhPJy6xbgNyg87XvKiSJMYp6N6eLYFOiCZuOK3cjTPo9Oi1sjiZdXJBKj5GIJSIVh8UMGLR+q8Cg==
X-Received: by 2002:a65:4984:: with SMTP id r4mr9624722pgs.261.1600065606631;
        Sun, 13 Sep 2020 23:40:06 -0700 (PDT)
Received: from laputa (p784a66b9.tkyea130.ap.so-net.ne.jp. [120.74.102.185])
        by smtp.gmail.com with ESMTPSA id f28sm9137653pfq.191.2020.09.13.23.40.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2020 23:40:05 -0700 (PDT)
Date:   Mon, 14 Sep 2020 15:40:01 +0900
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Ben Chuang <benchuanggli@gmail.com>, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.chuang@genesyslogic.com.tw, greg.tu@genesyslogic.com.tw
Subject: Re: [RFC PATCH V3 13/21] mmc: sdhci: UHS-II support, skip
 signal_voltage_switch()
Message-ID: <20200914064001.GA2743583@laputa>
Mail-Followup-To: AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ben Chuang <benchuanggli@gmail.com>, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.chuang@genesyslogic.com.tw, greg.tu@genesyslogic.com.tw
References: <20200710111104.29616-1-benchuanggli@gmail.com>
 <9ab64a9d-cd78-785c-b48f-561048cfe2ed@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ab64a9d-cd78-785c-b48f-561048cfe2ed@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Adrian,

On Fri, Aug 21, 2020 at 05:09:01PM +0300, Adrian Hunter wrote:
> On 10/07/20 2:11 pm, Ben Chuang wrote:
> > From: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > 
> > sdhci_start_signal_voltage_switch() should be called only in UHS-I mode,
> > and not for UHS-II mode.
> > 
> > Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> > Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > ---
> >  drivers/mmc/host/sdhci.c | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> > index 5511649946b9..7f2537648a08 100644
> > --- a/drivers/mmc/host/sdhci.c
> > +++ b/drivers/mmc/host/sdhci.c
> > @@ -2623,8 +2623,13 @@ int sdhci_start_signal_voltage_switch(struct mmc_host *mmc,
> >  	/*
> >  	 * Signal Voltage Switching is only applicable for Host Controllers
> >  	 * v3.00 and above.
> > +	 * But for UHS2, the signal voltage is supplied by vdd2 which is
> > +	 * already 1.8v so no voltage switch required.
> >  	 */
> > -	if (host->version < SDHCI_SPEC_300)
> > +	if (host->version < SDHCI_SPEC_300 ||
> > +	    (IS_ENABLED(CONFIG_MMC_SDHCI_UHS2) &&
> > +	     host->version >= SDHCI_SPEC_400 &&
> > +	     host->mmc->flags & MMC_UHS2_SUPPORT))
> 
> Please look at hooking ->start_signal_voltage_switch() instead

Do you mean that you want every platform driver who wants to support UHS-II
to set NULL to start_signal_voltage_switch hook even if this hack is
platform agnostic?
(Another option is that it would be put in sdhci_uhs2_add_host() which
is responsible to set MMC_UHS2_SUPPORT.)

-Takahiro Akashi

> 
> 
> >  		return 0;
> >  
> >  	ctrl = sdhci_readw(host, SDHCI_HOST_CONTROL2);
> > 
> 
