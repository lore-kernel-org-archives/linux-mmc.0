Return-Path: <SRS0=q7gx=CZ=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ED69C43461
	for <linux-mmc@archiver.kernel.org>; Wed, 16 Sep 2020 06:24:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59A452067C
	for <linux-mmc@archiver.kernel.org>; Wed, 16 Sep 2020 06:24:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hvqULrDz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726155AbgIPGYY (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 16 Sep 2020 02:24:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbgIPGYS (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 16 Sep 2020 02:24:18 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04351C06174A
        for <linux-mmc@vger.kernel.org>; Tue, 15 Sep 2020 23:24:18 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id j34so3310486pgi.7
        for <linux-mmc@vger.kernel.org>; Tue, 15 Sep 2020 23:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=e/rie8zyej25CbUTYCdPK5j8vwc82yIBnMTMl6LA2cg=;
        b=hvqULrDzJgs3+S0aooJPntAUUTdb7qS0wXqh6JH/i3Q/oT+uxIkisvHUgEloogcuRS
         I8jOXjkVFy073MPIgmd78q1L01Oo08RwX8aiWtAnI99pN1o6dg8IcitHgZN7Fps4xh/Z
         nUpMkEEnQKnFxdqAPI9MMsCPuMf4ll/zFhhgIBGcc3SBLD453gGuWsRermU4Rsfh/qZo
         B63D1scuSqfycQPi08MY/syE65dzagDY9/zq4oVwAaaoftMWrdeF/MVm5pWjnXbCq2De
         HGd2WgvXTaJLJUfZtBdz1qh8+j5cGZArVW7vf/OG8/d+K9J03C1AUavVLDiJ+HNHriLI
         ExlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=e/rie8zyej25CbUTYCdPK5j8vwc82yIBnMTMl6LA2cg=;
        b=QZ/Dc7thDWrZR19A9Pc6YqfIF78E8wq0t6pb1n7gcCUwhKR3dHsGsHa8ThGR/0V26G
         84FWf/uhUyXNZvqi3FQo3Klf9KbVcdGa+b2LRx4f2aN/YzCZ04s0BURT52otpN2GLlmT
         yUX1GsjsA3otancmr4lwVkrU5Ej2uqxDPnWDFNFzWi/8fIqdUTLNpA5B+8z6WG5D6YmE
         C6kewgKFKp6Thhso+p4ekLffhBFKbNenZFAZKVzns6jv1DdQD7yPGqyYWMu4i3Xyrakw
         LvUOSLqoZ1dIwFM/kwBKD7mJFud0AhUS9XVi2UUoRJA8+HfNQLAPR+l/aWjntLdM7KT7
         U8zg==
X-Gm-Message-State: AOAM530XMfn7X2l7S27NOahi0slOHlvkXzt3mz/elDB2Sd+Q2kJHEdDF
        8MAOWoNo8pRPdXnDQ9t0ouER6g==
X-Google-Smtp-Source: ABdhPJx80lZ+ebjCtowHmPJHVbcebgd7ex72HmIYT0DYhenEKqlJMTnmKk39aYGv+3sTgnHhPlPZbg==
X-Received: by 2002:a63:d506:: with SMTP id c6mr17104277pgg.396.1600237457446;
        Tue, 15 Sep 2020 23:24:17 -0700 (PDT)
Received: from laputa (p784a66b9.tkyea130.ap.so-net.ne.jp. [120.74.102.185])
        by smtp.gmail.com with ESMTPSA id l5sm12885088pgm.80.2020.09.15.23.24.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 23:24:16 -0700 (PDT)
Date:   Wed, 16 Sep 2020 15:24:12 +0900
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Ben Chuang <benchuanggli@gmail.com>, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.chuang@genesyslogic.com.tw, greg.tu@genesyslogic.com.tw
Subject: Re: [RFC PATCH V3 13/21] mmc: sdhci: UHS-II support, skip
 signal_voltage_switch()
Message-ID: <20200916062412.GA2972302@laputa>
Mail-Followup-To: AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ben Chuang <benchuanggli@gmail.com>, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.chuang@genesyslogic.com.tw, greg.tu@genesyslogic.com.tw
References: <20200710111104.29616-1-benchuanggli@gmail.com>
 <9ab64a9d-cd78-785c-b48f-561048cfe2ed@intel.com>
 <20200914064001.GA2743583@laputa>
 <a0000661-a0e1-8813-0672-c0eb73184079@intel.com>
 <20200915060306.GA2860208@laputa>
 <bd394015-abb7-f134-c883-ec28b42f1fc5@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd394015-abb7-f134-c883-ec28b42f1fc5@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, Sep 16, 2020 at 09:01:20AM +0300, Adrian Hunter wrote:
> On 15/09/20 9:03 am, AKASHI Takahiro wrote:
> > Ben, Adrian,
> > 
> > On Mon, Sep 14, 2020 at 11:08:14AM +0300, Adrian Hunter wrote:
> >> On 14/09/20 9:40 am, AKASHI Takahiro wrote:
> >>> Adrian,
> >>>
> >>> On Fri, Aug 21, 2020 at 05:09:01PM +0300, Adrian Hunter wrote:
> >>>> On 10/07/20 2:11 pm, Ben Chuang wrote:
> >>>>> From: AKASHI Takahiro <takahiro.akashi@linaro.org>
> >>>>>
> >>>>> sdhci_start_signal_voltage_switch() should be called only in UHS-I mode,
> >>>>> and not for UHS-II mode.
> >>>>>
> >>>>> Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> >>>>> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> >>>>> ---
> >>>>>  drivers/mmc/host/sdhci.c | 7 ++++++-
> >>>>>  1 file changed, 6 insertions(+), 1 deletion(-)
> >>>>>
> >>>>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> >>>>> index 5511649946b9..7f2537648a08 100644
> >>>>> --- a/drivers/mmc/host/sdhci.c
> >>>>> +++ b/drivers/mmc/host/sdhci.c
> >>>>> @@ -2623,8 +2623,13 @@ int sdhci_start_signal_voltage_switch(struct mmc_host *mmc,
> >>>>>  	/*
> >>>>>  	 * Signal Voltage Switching is only applicable for Host Controllers
> >>>>>  	 * v3.00 and above.
> >>>>> +	 * But for UHS2, the signal voltage is supplied by vdd2 which is
> >>>>> +	 * already 1.8v so no voltage switch required.
> >>>>>  	 */
> >>>>> -	if (host->version < SDHCI_SPEC_300)
> >>>>> +	if (host->version < SDHCI_SPEC_300 ||
> >>>>> +	    (IS_ENABLED(CONFIG_MMC_SDHCI_UHS2) &&
> >>>>> +	     host->version >= SDHCI_SPEC_400 &&
> >>>>> +	     host->mmc->flags & MMC_UHS2_SUPPORT))
> >>>> Please look at hooking ->start_signal_voltage_switch() instead
> >>>
> >>> Do you mean that you want every platform driver who wants to support UHS-II
> >>> to set NULL to start_signal_voltage_switch hook even if this hack is
> >>> platform agnostic?
> >>
> >> No, I see UHS-II as a separate layer i.e.
> >>
> >>  UHS-II host controller driver
> >>   |   |
> >>   |   v
> >>   |   sdhci-uhs2 e.g. sdhci_uhs2_start_signal_voltage_switch
> >>   |   |
> >>   v   v
> >>   sdhci e.g. sdhci_start_signal_voltage_switch
> >>
> >> Most things should go through sdhci-uhs2 but not nessarily everything.
> > 
> > What I meant by my previous comment is that we don't have to
> > call any function, sdhci_uhs2_start_signal_voltage_switch in above example,
> > for UHS-II cards in any case since it is always simply empty.
> 
> Please treat the sdhci_uhs2_... host ops as functions for a UHS-II host
> controller in either UHS-II or legacy mode. i.e. it is up to sdhci-uhs2.c to
> call through to sdhci.c not the other way around.  e.g.
>
> int sdhci_uhs2_start_signal_voltage_switch(blah)
> {
> 	if (sdhci_uhs2_mode(host))
> 		return 0;
> 	return sdhci_start_signal_valtage_switch(blah);
> }

Okay, the remaining issue is to clarify the meaning of MMC_UHS2_SUPPORT.

-Takhiro Akashi
