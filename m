Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4A69C8300F
	for <linux-mmc@archiver.kernel.org>; Tue,  1 Dec 2020 03:10:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F14720796
	for <linux-mmc@archiver.kernel.org>; Tue,  1 Dec 2020 03:10:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ohJBXdTd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727466AbgLADKX (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 30 Nov 2020 22:10:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727418AbgLADKW (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 30 Nov 2020 22:10:22 -0500
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 683FFC0613D4
        for <linux-mmc@vger.kernel.org>; Mon, 30 Nov 2020 19:09:42 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id k5so303303plt.6
        for <linux-mmc@vger.kernel.org>; Mon, 30 Nov 2020 19:09:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=zhX8ZUA3tjghvwSj2KIWCxYRVWbQSGeyUdB541HY0aA=;
        b=ohJBXdTdX2IhHGEQBW+8LK0HXwSwL1wm506TQrolqLjZ8p0h5KAXUxvt69uGuE5N/Y
         MXP8Ab61Ekys0XeG8525JHRtYyvyDiEjz+rXkEGcuoqnbslLMJrgw7tunum7vs4CNmUr
         NX7FgKfpO+8EZfhW4H525XRwF+WqxuCukaWBxdy6ivpzVhBhyLGLbXNnXR4iXrbfIF2c
         f3mRHBDp2XTtQqSaU07q6m6sRJS0HYDbJ0zI4H8+6NwcvKG69JRoSWUA+ely+Kzq1KQ6
         QYqAuXVpkL7gjYAmFHDKtKVZFwJmntX/T2nCwNnVxfKECjrA/VuxFWHzHhJwYJzrHs5p
         mgng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=zhX8ZUA3tjghvwSj2KIWCxYRVWbQSGeyUdB541HY0aA=;
        b=AYxif5NkUSGXxeU/cCZhABV0sPtpv8vC1BcCwClb5K49r+beyhC3Iwrg5LxECwrlPz
         Pi3KvQLAci4HHTZW1loolsqRwsVDZIMmxihl/sdJRaeJ9ukB+BmKwk5UtsOx6YcXSIc3
         OJBkcvyTlt7aXS9B00eCa/3A8VXtQb87KncKiqSQLc1YNKVSFqRHs/cHaxkugXRApeAu
         8PnMbPZ8mdRMMPXFKCglPLvAUg+lKTZAFUh4GncH9MzpXNvf+cLFNirpFYDZRDbZYKUB
         i5rHeCbbALtgrZsZTq4E5Vl8ULKJhwMpj2BPitWz2tCvEgdmbeVQhvuIGTFy7BpTXuEP
         rQCg==
X-Gm-Message-State: AOAM5311DuYOIp0gIWAmOxea9Wi84kda4pX7hTzPnLtmVZ9c78vKDEkl
        9htKBHP28jW/G6vwsXYVimV5Ug==
X-Google-Smtp-Source: ABdhPJzmUMmdEX7Wvhacd4QcDGhCGQmHkd+bRKgRAvyCyL3Kdk3VhJJYAKagEIUo7bYrlVbjqGNmbA==
X-Received: by 2002:a17:902:b209:b029:d8:e821:efc6 with SMTP id t9-20020a170902b209b02900d8e821efc6mr820567plr.5.1606792181785;
        Mon, 30 Nov 2020 19:09:41 -0800 (PST)
Received: from laputa (p784a5642.tkyea130.ap.so-net.ne.jp. [120.74.86.66])
        by smtp.gmail.com with ESMTPSA id z20sm350034pjq.16.2020.11.30.19.09.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 19:09:41 -0800 (PST)
Date:   Tue, 1 Dec 2020 12:09:37 +0900
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, ben.chuang@genesyslogic.com.tw,
        greg.tu@genesyslogic.com.tw
Subject: Re: [RFC PATCH v3.1 00/27] Add support UHS-II for GL9755
Message-ID: <20201201030937.GE43403@laputa>
Mail-Followup-To: AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.chuang@genesyslogic.com.tw, greg.tu@genesyslogic.com.tw
References: <20201106022726.19831-1-takahiro.akashi@linaro.org>
 <20201125074125.GC62993@laputa>
 <c8f7e9ad-3e8d-01cc-edeb-5be364bfcc36@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c8f7e9ad-3e8d-01cc-edeb-5be364bfcc36@intel.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Adrian,

Thank you for your review comments.

On Thu, Nov 26, 2020 at 10:18:55AM +0200, Adrian Hunter wrote:
> On 25/11/20 9:41 am, AKASHI Takahiro wrote:
> > Gentle ping;
> > 
> > On Fri, Nov 06, 2020 at 11:26:59AM +0900, AKASHI Takahiro wrote:
> >> This is an interim snapshot of our next version, v4, for enabling
> >> UHS-II on MMC/SD.
> >>
> >> It is focused on 'sdhci' side to address Adrian's comments regarding
> >> "modularising" sdhci-uhs2.c.
> >> The whole aim of this version is to get early feedback from Adrian (and
> >> others) on this issue. Without any consensus about the code structure,
> > 
> > Any comments so far?
> > 
> 
> Overall, I like this approach of separating UHS2 from legacy sdhci as much
> as possible.  The only major change, is to drop support for legacy quirks
> and features that you do not need.  The reason for that, is that there may
> be few drivers that end up with UHS-II support (opting instead for SD
> Express), so there is no point going to a lot of trouble to support things
> that never get used.
> 
> From what I have seen that looks like it includes:
> 	- any quirks

GLI driver (gl9755) needs
  * SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC
  * SDHCI_QUIRK2_BROKEN_DDR50
but they are managed in sdhci code.

> 	- SDHCI LED support
> 	- external DMA support

Should we add 'depends on !SDHCI_UHS2' to MMC_SDHCI_EXTERNAL_DMA?

> In this regard, the important thing is to have a comment somewhere that
> lists what is not supported.
> 
> I have only looked at SDHCI patches so far, and only up to about patch 20,
> but maybe that gives you enough to go on for a while.

Well, I have almost done.
Can I expect your comments on the patches #21-#27 as well soon?

-Takahiro Akashi
