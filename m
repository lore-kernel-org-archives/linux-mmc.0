Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFD06C56202
	for <linux-mmc@archiver.kernel.org>; Thu, 26 Nov 2020 00:07:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7471E206C0
	for <linux-mmc@archiver.kernel.org>; Thu, 26 Nov 2020 00:07:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="usNarmQP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728502AbgKZAGw (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 25 Nov 2020 19:06:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728829AbgKZAGw (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 25 Nov 2020 19:06:52 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F262AC0613D4
        for <linux-mmc@vger.kernel.org>; Wed, 25 Nov 2020 16:06:50 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id b63so3847673pfg.12
        for <linux-mmc@vger.kernel.org>; Wed, 25 Nov 2020 16:06:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=3NQ3wtA4MBw7H9ENpDbNl6UnCj99yYqE7sfkNlQV7eE=;
        b=usNarmQPin3VDizPkcmlfmbwneHIL3EeRbi4gk1ze61Z/zBAlQVhJ6v58duGy+V7DB
         Dt/AjB1GTXegac5tPWOdxulgpKgXIgt0roT7mCInCkzTOs/Ht3qpLNjtne4hgE2Nnye7
         tlaCBD4653nADezPOJa0x6ysKPcXiv9RsMg07afG2cM8L8pEcJTiTWXZvId9G8eXblX1
         zXnMzl9NouOKtPA4dlBIXhyrfrltIRJTqkpX5+IZG/SsakXjmC+8pEmQ/n0CnRV6/VBV
         kVjrvQ4PARiLW9bwEcNqw72jI1KTwso+OWo4SGIHFZ9x5H53h4wQJWE88DW7jleWidkl
         vK2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=3NQ3wtA4MBw7H9ENpDbNl6UnCj99yYqE7sfkNlQV7eE=;
        b=OmGVjtYK3yUVS/hD3/8CBzMiftovEmIk2dA15QAy/ePo1uoGSo/xFQnmMHD8616+DQ
         jTk5Q+pa0RXr87pV6JmNUOphPWtNKFr62V42go6NQL/7UOSkPCEryaVak+bM2+tkgk7v
         wU9ZiHnnDmY6PkKGde5uzTd+vJlhCLeKas5IEO5cjHmE5f3f/X6Wrv7wKv11HlEw0k/e
         FhYqvksWG+TW0iv+9VAhTv5pACbYQfbbbbSfYLS5tK64WccIwKtgLPTScImtz4HHzZy1
         il7XorBoEdafMjCpMfgzEEXsRlpqDyAOfGp2VDo7GnnFW/s45vQjbVzLULBSKgNCXsWc
         Jt1A==
X-Gm-Message-State: AOAM5319XvY2UKCpGXV3qBsdsDVz7Jo8V8BT8el4xx/xyB8WxIAnmh/g
        hfgRR/qrVgnW/aqjJiPw10lZcQ==
X-Google-Smtp-Source: ABdhPJyz+8WuEITK2opyP1MAyT8G9kd0dpqAPhmXCCXyHAVL6gpKEOwgXzg3KPv93QJdGlwevBtt0A==
X-Received: by 2002:a63:b05:: with SMTP id 5mr311632pgl.267.1606349210325;
        Wed, 25 Nov 2020 16:06:50 -0800 (PST)
Received: from laputa (p784a5642.tkyea130.ap.so-net.ne.jp. [120.74.86.66])
        by smtp.gmail.com with ESMTPSA id n68sm2872706pfn.161.2020.11.25.16.06.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2020 16:06:49 -0800 (PST)
Date:   Thu, 26 Nov 2020 09:06:45 +0900
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        greg.tu@genesyslogic.com.tw
Subject: Re: [RFC PATCH v3.1 00/27] Add support UHS-II for GL9755
Message-ID: <20201126000645.GA14078@laputa>
Mail-Followup-To: AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        greg.tu@genesyslogic.com.tw
References: <20201106022726.19831-1-takahiro.akashi@linaro.org>
 <20201125074125.GC62993@laputa>
 <CAPDyKFo_DjqTzaPhhBCKEj7axDU-4hMBnd1sw_hwP8nmp8xmTg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFo_DjqTzaPhhBCKEj7axDU-4hMBnd1sw_hwP8nmp8xmTg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, Nov 25, 2020 at 11:43:18AM +0100, Ulf Hansson wrote:
> On Wed, 25 Nov 2020 at 08:41, AKASHI Takahiro
> <takahiro.akashi@linaro.org> wrote:
> >
> > Gentle ping;
> >
> > On Fri, Nov 06, 2020 at 11:26:59AM +0900, AKASHI Takahiro wrote:
> > > This is an interim snapshot of our next version, v4, for enabling
> > > UHS-II on MMC/SD.
> > >
> > > It is focused on 'sdhci' side to address Adrian's comments regarding
> > > "modularising" sdhci-uhs2.c.
> > > The whole aim of this version is to get early feedback from Adrian (and
> > > others) on this issue. Without any consensus about the code structure,
> >
> > Any comments so far?
> 
> I haven't been able to look at sdhci parts (I will try to), but as you
> know, I am relying on Adrian's help with this.

Yeah, I understand.

> When it comes to the core part, I am planning to help to put some of
> the foundation in place for the mmc core changes. Although,
> unfortunately I haven't been able to post patches, yet. I will keep
> you in the loop, when I get to it.

I think Ben has some idea on the topic.

-Takahiro Akashi


> [...]
> 
> Kind regards
> Uffe
