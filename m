Return-Path: <SRS0=xq36=CY=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4265BC43461
	for <linux-mmc@archiver.kernel.org>; Tue, 15 Sep 2020 06:03:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F33C620897
	for <linux-mmc@archiver.kernel.org>; Tue, 15 Sep 2020 06:03:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UNJ05fV3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726114AbgIOGDS (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 15 Sep 2020 02:03:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbgIOGDN (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 15 Sep 2020 02:03:13 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C267C06174A
        for <linux-mmc@vger.kernel.org>; Mon, 14 Sep 2020 23:03:13 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id y1so1400038pgk.8
        for <linux-mmc@vger.kernel.org>; Mon, 14 Sep 2020 23:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=3G5dlwEHz8jxcNOlP2TgQ186ZfBjrtWHsDBlUo1Hw3k=;
        b=UNJ05fV3weupF0D6iKfIwcdiVpGv8MrSL1c2rbJac6Nt3f7+6UmbMwr6VccZU+Vh9h
         AD+0IBaFkmnxgbF9oOUg8vvmGsRjCMwAaaX+PPKkemeayxnx6hBxt+JNOCPCRzM92jt+
         YRPhbghLpirWL9FN3q0y4bgjLoH2IZChBoER0jGDBTMxmu3Z7ijaTffUkQR9+qK4+IGu
         kRlI9Q0/TzSbkiPiwf7qmnPyv3wX5dCOqouNP4/IWouUhWFEAwmIW4QWnomDiT3Vz2iT
         Nx4RlvpfTmYZ7OYIS/xDvYnWu3xNBKClmom1tBeO8itYf88E5lYr1v2ScFzDtxCx6CoX
         ibjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=3G5dlwEHz8jxcNOlP2TgQ186ZfBjrtWHsDBlUo1Hw3k=;
        b=t+Dyc50RinynV6fSBb1xIZlSlXlDXkZsGQlZ17BRt9RjJc9Az0VtqCWg7qfNEi/KUG
         8e4e1ag9JrCUoYsK682d/nMxAoemkVBB8ekzMobAxSSICWdExvuE3PMNV3E61pFW+Fre
         7PfigMJ3KHh/qlIjT7eWnzosb4/q+xDOA3rPg7EYqpJ6PfpIxa8VxwTiSDAbmOXOAX8h
         bje2wYCbMlcYVcDbksKd9G4E+uEHlhlR3z3vMv2pJjCxSCvzkCPx/K2/XJwtKaaoVau+
         R7ss1WYW3mwQcEsSy4ioRDcTxFXggYv/5ucVIfVudGqfLCmxJ/aeycPZbj1Brx38aFtJ
         RRmg==
X-Gm-Message-State: AOAM530sjeNZit1Zf13DD4dzDTCYkvfnayQYB4tYJibU169Tf1wJS9j5
        4fvqu9qQ4jwUpysYPyq3MRoyrA==
X-Google-Smtp-Source: ABdhPJyaOMcm82+iXie+wWOE/fBUNdwkbcGyxAoeUArZbMTZm/dI5uEKB+t6+nK/tTzzHIWGWOC94w==
X-Received: by 2002:a63:e015:: with SMTP id e21mr13839304pgh.264.1600149791083;
        Mon, 14 Sep 2020 23:03:11 -0700 (PDT)
Received: from laputa (p784a66b9.tkyea130.ap.so-net.ne.jp. [120.74.102.185])
        by smtp.gmail.com with ESMTPSA id k2sm12230516pfi.169.2020.09.14.23.03.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 23:03:10 -0700 (PDT)
Date:   Tue, 15 Sep 2020 15:03:06 +0900
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Ben Chuang <benchuanggli@gmail.com>, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.chuang@genesyslogic.com.tw, greg.tu@genesyslogic.com.tw
Subject: Re: [RFC PATCH V3 13/21] mmc: sdhci: UHS-II support, skip
 signal_voltage_switch()
Message-ID: <20200915060306.GA2860208@laputa>
Mail-Followup-To: AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ben Chuang <benchuanggli@gmail.com>, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.chuang@genesyslogic.com.tw, greg.tu@genesyslogic.com.tw
References: <20200710111104.29616-1-benchuanggli@gmail.com>
 <9ab64a9d-cd78-785c-b48f-561048cfe2ed@intel.com>
 <20200914064001.GA2743583@laputa>
 <a0000661-a0e1-8813-0672-c0eb73184079@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a0000661-a0e1-8813-0672-c0eb73184079@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Ben, Adrian,

On Mon, Sep 14, 2020 at 11:08:14AM +0300, Adrian Hunter wrote:
> On 14/09/20 9:40 am, AKASHI Takahiro wrote:
> > Adrian,
> > 
> > On Fri, Aug 21, 2020 at 05:09:01PM +0300, Adrian Hunter wrote:
> >> On 10/07/20 2:11 pm, Ben Chuang wrote:
> >>> From: AKASHI Takahiro <takahiro.akashi@linaro.org>
> >>>
> >>> sdhci_start_signal_voltage_switch() should be called only in UHS-I mode,
> >>> and not for UHS-II mode.
> >>>
> >>> Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> >>> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> >>> ---
> >>>  drivers/mmc/host/sdhci.c | 7 ++++++-
> >>>  1 file changed, 6 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> >>> index 5511649946b9..7f2537648a08 100644
> >>> --- a/drivers/mmc/host/sdhci.c
> >>> +++ b/drivers/mmc/host/sdhci.c
> >>> @@ -2623,8 +2623,13 @@ int sdhci_start_signal_voltage_switch(struct mmc_host *mmc,
> >>>  	/*
> >>>  	 * Signal Voltage Switching is only applicable for Host Controllers
> >>>  	 * v3.00 and above.
> >>> +	 * But for UHS2, the signal voltage is supplied by vdd2 which is
> >>> +	 * already 1.8v so no voltage switch required.

I have been confused with this comment.
(I know it came from the original Intel code, not from Ben.)

If this comment is true,

> >>>  	 */
> >>> -	if (host->version < SDHCI_SPEC_300)
> >>> +	if (host->version < SDHCI_SPEC_300 ||
> >>> +	    (IS_ENABLED(CONFIG_MMC_SDHCI_UHS2) &&
> >>> +	     host->version >= SDHCI_SPEC_400 &&
> >>> +	     host->mmc->flags & MMC_UHS2_SUPPORT))

the condition above must be wrong since 'flags & MMC_UHS2_SUPPORT'
is one of capabilities for a host controller, not a card
while the selection of voltage depends on a card type.

So I wonder why this code still works.
I guess that it is because set_signal_voltage(), or other variant functions,
will never be called for UHS-II cards under the current implementation.

Looking at mmc_sd_init_card(), we have added some hack:
mmc_sd_init_card()
{
        ...
        /* For UHS2, skip the UHS-I initialization. */
        if ((host->flags & MMC_UHS2_SUPPORT) &&
            (host->flags & MMC_UHS2_INITIALIZED))
                goto done;
        ...
                if (mmc_sd_card_using_v18(card)) {
                        if (mmc_host_set_uhs_voltage(host) ||
                            mmc_sd_init_uhs_card(card)) {
                ...
}

Ben, can you confirm this?
(There is another callsite of mmc_host_set_uhs_voltage() though.)

> >> Please look at hooking ->start_signal_voltage_switch() instead
> > 
> > Do you mean that you want every platform driver who wants to support UHS-II
> > to set NULL to start_signal_voltage_switch hook even if this hack is
> > platform agnostic?
> 
> No, I see UHS-II as a separate layer i.e.
> 
>  UHS-II host controller driver
>   |   |
>   |   v
>   |   sdhci-uhs2 e.g. sdhci_uhs2_start_signal_voltage_switch
>   |   |
>   v   v
>   sdhci e.g. sdhci_start_signal_voltage_switch
> 
> Most things should go through sdhci-uhs2 but not nessarily everything.

What I meant by my previous comment is that we don't have to
call any function, sdhci_uhs2_start_signal_voltage_switch in above example,
for UHS-II cards in any case since it is always simply empty.

-Takahiro Akashi
