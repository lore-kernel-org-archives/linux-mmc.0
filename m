Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8F2AC4332D
	for <linux-mmc@archiver.kernel.org>; Mon, 15 Mar 2021 04:07:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B843464E69
	for <linux-mmc@archiver.kernel.org>; Mon, 15 Mar 2021 04:07:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbhCOEG4 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 15 Mar 2021 00:06:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbhCOEGp (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 15 Mar 2021 00:06:45 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C6DFC061574
        for <linux-mmc@vger.kernel.org>; Sun, 14 Mar 2021 21:06:45 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id a188so5764572pfb.4
        for <linux-mmc@vger.kernel.org>; Sun, 14 Mar 2021 21:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eI7ImkOM7sKEYOwpNZ2uQyL8ht6ELC4KAuDJxGH26WM=;
        b=TsLroBKaOE0Ndal3uYSavlIbCvocBVruTCmOQbtWNCTqZn34fuCTFqFvPlo8zLD9fM
         IO6v4CAcDC/jXHA7xn0roPtBnzHafVGRYUD8lfwBtTMxKxCleNiFo9fJ8rFHjAAcLLRG
         n0IBxgxySYh/5P9qNs36aern3PGV0Kb7uyoKAm7WyekwifeK1ct2o4JPyQ1IQo4HlwZ+
         40l1RBYIIqEDnveIIc7V/s/pxU7Eti6u2Sl5TecW4wLjWWQTpWhk9UCZrL8vgho1h49/
         F2BmsDsOvuWGdJf6nM5P+UwNGUZyT5QM3C9s++AMz77q/FQEl28vDvRZAA/JnZ/kvkbJ
         LAKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eI7ImkOM7sKEYOwpNZ2uQyL8ht6ELC4KAuDJxGH26WM=;
        b=pgCgBzSseMqKDUln/kZ7jeD0m1kZNE6h2BGJU38KPXqIPrHsTCLPKRRTlVJgxwnHjG
         QanYG1NRscJbm+8eFiufP0OMmg+FqcMgGsYqiga6ptIOz/qxJVeQHcmAqadG2R91sWTp
         9LHRstItg49jKVxEXbv8zfcFKgB8IdrfGowzMd+3wIPsMEZ6XumVWi50pzSrMOUec6Mg
         1AVKFFJfCULpQntl2IHpgASF6/t9ZUwSMfnNcXqqoASUpUjxvCxxv+fdVAQOzs04namv
         ziHswNgLp7lbfdmPmL1AxR/qcDeO11vW50QzgZ6/Z371EiOH9sGrO0UsWiLjU6smJmTN
         QYoQ==
X-Gm-Message-State: AOAM530zk8O4Kp7/MEIz+S4rYsAOzSutJSRp8GRUCKRfEcQjv6MbJeUg
        T1nEmerMieUjI+SOaQoXWfKWaw==
X-Google-Smtp-Source: ABdhPJzvcR9VDnxHyvgDVLMJYlxMP0Ms95A2JMyXTXyYfG5+umOTG/XVCk6roapJ92EyCnrv/2+ArQ==
X-Received: by 2002:a63:1957:: with SMTP id 23mr3255166pgz.196.1615781204730;
        Sun, 14 Mar 2021 21:06:44 -0700 (PDT)
Received: from localhost ([122.171.124.15])
        by smtp.gmail.com with ESMTPSA id l20sm12327033pfd.82.2021.03.14.21.06.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Mar 2021 21:06:44 -0700 (PDT)
Date:   Mon, 15 Mar 2021 09:36:42 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Qiang Yu <yuq825@gmail.com>, Rob Clark <robdclark@gmail.com>,
        Sean Paul <sean@poorly.run>, Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Yangtao Li <tiny.windzz@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, lima@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, linux-media@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v3 00/15] Introduce devm_pm_opp_* API
Message-ID: <20210315040642.mw6jz7nalhthbwlr@vireshk-i7>
References: <20210314163408.22292-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210314163408.22292-1-digetx@gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 14-03-21, 19:33, Dmitry Osipenko wrote:
> This series adds resource-managed OPP API helpers and makes drivers
> to use them.
> 
> Changelog:
> 
> v3: - Dropped dev_pm_opp_register_notifier().
> 
>     - Changed return type of the devm helpers from opp_table pointer
>       to errno.
> 
>     - Corrected drm/msm patch which missed to remove opp_put_supported_hw()
>       from a6xx_gpu. Note that the a5xx_gpu driver was missing the
>       opp_put_supported_hw() at all.
> 
>     - Corrected spelling of the ack from Mark Brown.

Applied all patches except 11/15.

Thanks.

-- 
viresh
