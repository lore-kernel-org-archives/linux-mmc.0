Return-Path: <SRS0=5xTW=4I=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 176F4C11D0C
	for <linux-mmc@archiver.kernel.org>; Thu, 20 Feb 2020 15:52:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E108520659
	for <linux-mmc@archiver.kernel.org>; Thu, 20 Feb 2020 15:52:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i4puWcdv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728602AbgBTPwX (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 20 Feb 2020 10:52:23 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:52790 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728552AbgBTPwX (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 20 Feb 2020 10:52:23 -0500
Received: by mail-pj1-f68.google.com with SMTP id ep11so1045737pjb.2
        for <linux-mmc@vger.kernel.org>; Thu, 20 Feb 2020 07:52:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+/WxyvwzefS6yg5iKEGluqHuzG/pj5Si1hZf4+0mRQQ=;
        b=i4puWcdvj1CWZtYIbzpGUOtJ5pIC79iIjAxMWCCZXdxq6G24+mGBTIIpnPCBHn0GNK
         WAdSvxkSCdvSQdp9mPapKBWY/kV3xMOpF+OhcGriTMhwNaieg2/upGs/gMBYJU7jUkYL
         EJM8Zl2RHkroltyGpXo2njZr5wkKWBHs4jsNOJTjSwWhKOSrn4hK033+7URfqA6fASVo
         VRqv1xhTq9t5LCC/tsHJlJc136PxLRUc2xF/eNLZvdLHA0mnMVcXzkvNAfTV7LBAAVVo
         KsWWXFx7m/oM5aks9F1su6hIUUJ6k2wPyhaPNDTQQq0U2jSlzth3PkhHSVgDK9vsxiaY
         bOtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+/WxyvwzefS6yg5iKEGluqHuzG/pj5Si1hZf4+0mRQQ=;
        b=eqDnT2vJUVUw56D/tAaLWcCsLQ/jq3hbMzmADFq6xL0ZITuwjdBNmNqY+O9atRsEqS
         aZFeyKdcsJrQgWJ4fXrHPoyeZiHmzs3Euf8ThCDrrXej8Os5S5A3wcugLcDx9vAyppOz
         2ujR9z8RvynPGWIw7NjT/umXvnAC+T4zwj3yyRknx0R//d5qom2r3GByw9LO9Wu6L89B
         /MCehFmlJjqnmAwjKdhMsay9/I8eM/c9cO6bd1sbWHFpQSLHCTcpY1bsHyd8hhVO1BGd
         Ir1BPHH0fckkHPVvB5n8o4HXgD2DQIypLILCviCsgJQ4nFnVspzbAILSez/DWXPIiL1m
         IALg==
X-Gm-Message-State: APjAAAUS1Y0RWtRl6B5NWmOLQiRVq5JhRidewi+xHuVUy0qMxH32I1rm
        iORI5KM3kWiKTqkFZtSM2sWvAQ==
X-Google-Smtp-Source: APXvYqxJJRxwW5yt25an2UYEwvvA6N2u9Fzw+67nN1An6ph5EUR36LLQWDArLfHBLz9LPNR1QNd6LQ==
X-Received: by 2002:a17:902:9b8b:: with SMTP id y11mr32790865plp.189.1582213942056;
        Thu, 20 Feb 2020 07:52:22 -0800 (PST)
Received: from ripper (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id s23sm3774686pjq.17.2020.02.20.07.52.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2020 07:52:21 -0800 (PST)
Date:   Thu, 20 Feb 2020 07:51:26 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Sayali Lokhande <sayalil@codeaurora.org>
Cc:     adrian.hunter@intel.com, robh+dt@kernel.org,
        ulf.hansson@linaro.org, asutoshd@codeaurora.org,
        stummala@codeaurora.org, ppvk@codeaurora.org,
        rampraka@codeaurora.org, vbadigan@codeaurora.org, sboyd@kernel.org,
        georgi.djakov@linaro.org, mka@chromium.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        agross@kernel.org, linux-mmc-owner@vger.kernel.org
Subject: Re: [PATCH RFC] Toggle fifo write clk after ungating sdcc clk
Message-ID: <20200220155126.GC955802@ripper>
References: <1582190446-4778-1-git-send-email-sayalil@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1582190446-4778-1-git-send-email-sayalil@codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu 20 Feb 01:20 PST 2020, Sayali Lokhande wrote:

> During GCC level clock gating of MCLK, the async FIFO
> gets into some hang condition, such that for the next
> transfer after MCLK ungating, first bit of CMD response
> doesn't get written in to the FIFO. This cause the CPSM
> to hang eventually leading to SW timeout.
> 
> To fix the issue, toggle the FIFO write clock after
> MCLK ungated to get the FIFO pointers and flags to
> valid states.
> 

Please don't provide cover letters for a single patch.

Regards,
Bjorn

> Ram Prakash Gupta (1):
>   mmc: sdhci-msm: Toggle fifo write clk after ungating sdcc clk
> 
>  drivers/mmc/host/sdhci-msm.c | 43 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 43 insertions(+)
> 
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
