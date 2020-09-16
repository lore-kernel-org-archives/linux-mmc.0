Return-Path: <SRS0=q7gx=CZ=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16F23C433E2
	for <linux-mmc@archiver.kernel.org>; Wed, 16 Sep 2020 08:07:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0E0021D90
	for <linux-mmc@archiver.kernel.org>; Wed, 16 Sep 2020 08:07:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zzWy5FpN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726438AbgIPIHj (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 16 Sep 2020 04:07:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726243AbgIPIHh (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 16 Sep 2020 04:07:37 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 424A3C06178A
        for <linux-mmc@vger.kernel.org>; Wed, 16 Sep 2020 01:07:37 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id x18so2772728pll.6
        for <linux-mmc@vger.kernel.org>; Wed, 16 Sep 2020 01:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=al9Aj6fs6m+1M4OkCEo9LbifP4jLsy69rCvFZh8tgSo=;
        b=zzWy5FpNemcfGLEGQwn9nDnjgZhz9mWvEAhdUPA/Ylhu/AmfNsEo2+rh/3jna6Geck
         OP0RAVDF/RnzkFm8PSMVyDhbRcHqk+QknIGlSRD54RXMfRCxEwko2D/ST0dfUyzR/apl
         HG1dj8NhxvhQFs9NSzqlFxxslPCgdisM32diLBgmaAcmyFyb7WCI8i0TFY3/vUJMRTMf
         XvXWRMQTf+4bsLJ7BaiBMzd0R4mpg2yX42QTpafRpoUvsLZJddNWbdvtDBa7tuT4OND6
         h6CrlRIrk7qLDtPaodHamGUU9EKRuKol4PujdZjFkyUbywJKuQp50Ew/JrmLBwbwwEub
         JCYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=al9Aj6fs6m+1M4OkCEo9LbifP4jLsy69rCvFZh8tgSo=;
        b=pkhpOhvCv7eIBXs3G0GierSwMJ0zedmrlJg+fSu/7b6a9gxLxEW1W4K36YbhKpV/JO
         hPF0sS78GBa7SYaxgmozDTnZQ1nmHzw31gAD8IgPIPBFP/RLYSRJtCtZpPOeUVsIL45Y
         qk6/MdknR26VLdEcG3si8gE7F9Zt4A3b5RRKBhjKzF6xXcdpIbn1uW/Akl2FZrGMXJdp
         nkIH1rG0rHj9Z2KD8Z6wPMisdhlO7ISKsx8znCeqBXK7zePGegpTuWKzkABUCaLtQp01
         xWbk6iI5LPgCntTPgfkEeI/Rw/GYcChcKQihGextThEeN1VTrpS2f6DjV9w6HgyV25pV
         pJ8g==
X-Gm-Message-State: AOAM530ppzrZG4HhSumNvFsQnpETV3hSbE2vfl3eupwZ2g4Z6fhebGzx
        uKdiFX8ca1wHemWr6NcjLhHUJg==
X-Google-Smtp-Source: ABdhPJwrXgqKRavyqwV2JZf/7NkYcdOZiJpy8XXK8VuazY2kkP30NBcE/tCboIIeuERfnF+hGcTHvA==
X-Received: by 2002:a17:90a:aa94:: with SMTP id l20mr2813436pjq.95.1600243654933;
        Wed, 16 Sep 2020 01:07:34 -0700 (PDT)
Received: from localhost ([122.181.54.133])
        by smtp.gmail.com with ESMTPSA id f28sm16163363pfq.191.2020.09.16.01.07.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Sep 2020 01:07:33 -0700 (PDT)
Date:   Wed, 16 Sep 2020 13:37:28 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        lkft-triage@lists.linaro.org,
        linux-clk <linux-clk@vger.kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        John Stultz <john.stultz@linaro.org>
Subject: Re: Unable to handle kernel paging request at virtual address dead -
 __clk_put
Message-ID: <20200916080728.ajqzw75spcmbbwsc@vireshk-i7>
References: <CA+G9fYvYEsxjU_cnm6oWFgOrU4x0T1CMoN-L2SHLGeJC6MF54Q@mail.gmail.com>
 <CAPDyKFqVB_hgDghaYU1B1BbWUuL6GHhWMbZEYM-cXDQ8T8ThfQ@mail.gmail.com>
 <20200916052239.7c5z4wqqrdpauti4@vireshk-i7>
 <CAPDyKFrxrKRuJec0pDLooovV3BJBVvmDizoL6N4eb+hv1D0NgA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFrxrKRuJec0pDLooovV3BJBVvmDizoL6N4eb+hv1D0NgA@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 16-09-20, 09:37, Ulf Hansson wrote:
> I have the board as well. If you need some help with testing, just let me know.
> 
> In any case, I will try the revert and see how that changes things.

I am testing this with help of Naresh currently, will try to update
back today itself.

-- 
viresh
