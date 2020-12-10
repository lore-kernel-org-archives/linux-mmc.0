Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C67C6C4361B
	for <linux-mmc@archiver.kernel.org>; Thu, 10 Dec 2020 21:25:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9578F23E55
	for <linux-mmc@archiver.kernel.org>; Thu, 10 Dec 2020 21:25:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394035AbgLJVY6 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 10 Dec 2020 16:24:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394033AbgLJVYh (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 10 Dec 2020 16:24:37 -0500
Received: from mail-vk1-xa44.google.com (mail-vk1-xa44.google.com [IPv6:2607:f8b0:4864:20::a44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2ABAC0613D3
        for <linux-mmc@vger.kernel.org>; Thu, 10 Dec 2020 13:23:56 -0800 (PST)
Received: by mail-vk1-xa44.google.com with SMTP id w190so1578746vkg.13
        for <linux-mmc@vger.kernel.org>; Thu, 10 Dec 2020 13:23:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7mhjTRkoHG5wDB6hSuZ/aPIC7H/s0skSuoErD8uNBws=;
        b=Mk0qsv8nQsIb+74vLlttYyB+sauWfKgHNsogJv1aie+18w0M3Qt7pPiZtt3aTWwfau
         8SizigN8Zf9VFxFgSDbBcEAXw45HsRgJGbE6fmhqqt74pJM8FhSgNf3+hqNOw0DqMHiQ
         riKNI5bvy+Az1UUENpaPsMTQNH9v/HcbODbcs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7mhjTRkoHG5wDB6hSuZ/aPIC7H/s0skSuoErD8uNBws=;
        b=C63tR7gPReN76wSwt7/3VShjjolp/r5iPz+yBnMw49Ww8U9q44/iudfT57058cA4uV
         eVcFWnO4VEtC76rZGupM20wrbJ4mGkrYrzyxW+fylf24Zut72uKcQwHi+58kJKq1W0lE
         JjCESajVjOz4A7YJ92i57ZDIKuvlUzkEaDEH4ZVn78So92qg3OpnXvWCIRpBdNO805hM
         NAwgTWbpb4ub1KLgjMu5JdzH0u6UXnS5UOFbrKiFfFw4bhLjbGxkkANy8tzfe8688teo
         TAc4xCByfIloalK0m7uI1RQ5uTQkE60XQFis89QSCI+fscHugpe5HwXBK0Zfz3OercnL
         VnbA==
X-Gm-Message-State: AOAM531wWMwnmUpPllctKj/6McxD+vIGa6qEq+sMNtvYbCTDJIij6aLh
        PCgwv2uVTg/wJsm9oyMRf+L7hmr4JqStgQ==
X-Google-Smtp-Source: ABdhPJxQBansfxs5N2qqIjKwCTxjKnqru4cxhmRCbu6FE99o43TjDZB2y7MMD7TzT5v7CXgiSr1Sbg==
X-Received: by 2002:a1f:a2c2:: with SMTP id l185mr11503378vke.24.1607635435933;
        Thu, 10 Dec 2020 13:23:55 -0800 (PST)
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com. [209.85.217.42])
        by smtp.gmail.com with ESMTPSA id f1sm689584vkb.46.2020.12.10.13.23.55
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Dec 2020 13:23:55 -0800 (PST)
Received: by mail-vs1-f42.google.com with SMTP id x26so3685291vsq.1
        for <linux-mmc@vger.kernel.org>; Thu, 10 Dec 2020 13:23:55 -0800 (PST)
X-Received: by 2002:a67:70c6:: with SMTP id l189mr10697172vsc.34.1607635434758;
 Thu, 10 Dec 2020 13:23:54 -0800 (PST)
MIME-Version: 1.0
References: <20201210131913.v2.1.Iec3430c7d3c2a29262695edef7b82a14aaa567e5@changeid>
In-Reply-To: <20201210131913.v2.1.Iec3430c7d3c2a29262695edef7b82a14aaa567e5@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 10 Dec 2020 13:23:43 -0800
X-Gmail-Original-Message-ID: <CAD=FV=U5AvDR0mhaGH77QKTvPCAMH7fc5eCNFPcSqnSbrxKMhA@mail.gmail.com>
Message-ID: <CAD=FV=U5AvDR0mhaGH77QKTvPCAMH7fc5eCNFPcSqnSbrxKMhA@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: sdhci-msm: Warn about overclocking SD/MMC
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     Veerabhadrarao Badiganti <vbadigan@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Taniya Das <tdas@codeaurora.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MMC List <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi,

On Thu, Dec 10, 2020 at 1:19 PM Douglas Anderson <dianders@chromium.org> wrote:
>
> +               pr_warn("%s: Card appears overclocked; req %u Hz, actual %d Hz\n",
> +                       mmc_hostname(host->mmc), clock, achieved_rate);

Ugh, multitasking too heavily.  Clearly this is wrong format codes...
v3 coming shortly.  Sorry for the spam.
