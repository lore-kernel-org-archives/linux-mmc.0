Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C368C4361B
	for <linux-mmc@archiver.kernel.org>; Wed,  9 Dec 2020 00:02:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63CE723B55
	for <linux-mmc@archiver.kernel.org>; Wed,  9 Dec 2020 00:02:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730499AbgLIACU (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 8 Dec 2020 19:02:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729665AbgLIACU (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 8 Dec 2020 19:02:20 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95F2FC0613CF
        for <linux-mmc@vger.kernel.org>; Tue,  8 Dec 2020 16:01:40 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id m9so34536pgb.4
        for <linux-mmc@vger.kernel.org>; Tue, 08 Dec 2020 16:01:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IlcbnJ0w3R+raMjtafxvAzYGmc8w8Z5llSlkQt901bM=;
        b=nyk6eQgHhGSw071rTSS7MzO4THWk1VUrsRI/LHpf87JsjEQzsqgPeJlpnG+Hi4W6Br
         85UL+4mXvVvl37wJWbCgGKcTIN3sAzcxlsczb1vzy/GdWovHnnDqyygu1x/iLbrEvB9i
         1lkfhmEYOJ+4MR3l8WWlliON1fsd0GJ7eDhp+wIXNBNm9/kxSrHgnaQ1ISfUkZkF/rUm
         Bb0KCIR+NQj96+8B8tj5PoLbmCTDB7XO9BtH819J7b0E8WXSjUV4uDYyI6owO7RlLLY5
         WOaOKFe4QHDUE/oaEmMpY5vqRXqx8E1P7XAgCv7DqMWsAs9aoW/v0NSLfPX7WFkAkHMF
         wqMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IlcbnJ0w3R+raMjtafxvAzYGmc8w8Z5llSlkQt901bM=;
        b=Xwk3jEsaPdqNMYoGby9kI2YMkk+a7op+oRn5vwvxrdz9EhAuIfYk9+av8wbyO8h2s/
         cGDZer4BXiGNnT+K33cnU2PkjG6UJonUM3qGbLUhASWcOwhGi/dobo3V9AH+o1QesvoU
         cTANoCXKGKoDClOuip2Z9kVk4TWxXmPGUrVo6bt87hcx1lynvl/LQzUYyZiKR2wJkkhM
         MmqwBRF6lSnSX5EZtVDEPRTEs3RQpqcq14IypLRHhxkmVCmff3KextLHPlwG8ccuG/Mj
         okkPdhl06YFvUjVssV/mz17pw+aKWSMqKAeGVb/FA1qq4CF25SEECBbDC29VmUXnuPCQ
         Axbw==
X-Gm-Message-State: AOAM530mz4g0yPUzW+JcRn4y+6+QHtCrspmQrgTR8VXiBDhBlLjG/yZy
        dwZDO+16DnYRMoXahRhuTb6D2R7jNxKT2my6
X-Google-Smtp-Source: ABdhPJwCARYoRL9G+IP7htAPzDlrlYCs3aFvtjKiyWGKHZBF8E3q9b6+koRUn49SD/YXs0ZaalRNOg==
X-Received: by 2002:a17:90a:a393:: with SMTP id x19mr13184pjp.68.1607472100086;
        Tue, 08 Dec 2020 16:01:40 -0800 (PST)
Received: from google.com (154.137.233.35.bc.googleusercontent.com. [35.233.137.154])
        by smtp.gmail.com with ESMTPSA id y189sm302341pfb.155.2020.12.08.16.01.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 16:01:39 -0800 (PST)
Date:   Wed, 9 Dec 2020 00:01:35 +0000
From:   Satya Tangirala <satyat@google.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-mmc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Asutosh Das <asutoshd@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>,
        Neeraj Soni <neersoni@codeaurora.org>,
        Barani Muthukumaran <bmuthuku@codeaurora.org>,
        Peng Zhou <peng.zhou@mediatek.com>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Konrad Dybcio <konradybcio@gmail.com>
Subject: Re: [PATCH v2 4/9] mmc: cqhci: add support for inline encryption
Message-ID: <X9AT3zULeDB+edNj@google.com>
References: <20201203020516.225701-1-ebiggers@kernel.org>
 <20201203020516.225701-5-ebiggers@kernel.org>
 <X8t82HijJtbHVyLM@google.com>
 <X8vMZBSP0hQSOqlA@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <X8vMZBSP0hQSOqlA@sol.localdomain>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Sat, Dec 05, 2020 at 10:07:32AM -0800, Eric Biggers wrote:
> (Please quote just the part that you're actually replying to -- thanks!)
> 
Sorry about that. Will do so in future :)
> The comment gives the typical value that is stored in data_unit_size,
> but yeah it's a bad comment.  I'll just remove it.
> 
Cool. Please feel free to add
Reviewed-by: Satya Tangirala <satyat@google.com>
> - Eric
