Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1668C4361B
	for <linux-mmc@archiver.kernel.org>; Fri, 18 Dec 2020 18:51:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69F2823B84
	for <linux-mmc@archiver.kernel.org>; Fri, 18 Dec 2020 18:51:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbgLRSvI (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 18 Dec 2020 13:51:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726652AbgLRSvH (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 18 Dec 2020 13:51:07 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99F2FC0617B0
        for <linux-mmc@vger.kernel.org>; Fri, 18 Dec 2020 10:50:27 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id r4so1849785pls.11
        for <linux-mmc@vger.kernel.org>; Fri, 18 Dec 2020 10:50:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=aV2MC/7DJ97wJPGYRClkcJ8CaAh6ktn5YU+LrCJaZoE=;
        b=lbwxU9LwTsIKYUS4hy5LPDGKFymptBbuBe53KnM83Wq/YslIQoQ7ZIZkF2Pw2fiQD2
         08XcJke5mrOJAuUHgid5o9SuORXnfgXxHtBA9Uqg6acIrQ1FW95r3Gn6tY6/XGDx83be
         4zmVCuY3xN5HdgdKsn5pZ1Kv6t1PPcrvy79Zw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aV2MC/7DJ97wJPGYRClkcJ8CaAh6ktn5YU+LrCJaZoE=;
        b=b93tNgqbNAECT4Xv1N6b5ACKKEvrTCBQ8R8MfwnRAZbckdApVCCUhZ7u/5n5LMb1zs
         tKF9+IlGx2mdRcYjw/+cS5LSYs2duvMBmuWnPiL29JKcA0XxliBn2W3D3QHXJniIcQ/r
         KXb7I/SvEv/8nKGSJj4jDj50NeT7h65aqSSvstW/g1IGGEjClRbDSvxv+0PIZmaA2LNz
         Mm6QVH1GbtZsavRLJh7iBZAuKh0TvF/xvC/90QdIgFS27DAGGHacOipGUfPx/MaTZMFy
         ZpZ3wFzmFcZKWGFzDw/r1ecJHBcGzI7PtEJ57j+gQmQ/r3CNkNpmJimqcjfamKLCBdXw
         t6Yg==
X-Gm-Message-State: AOAM530u8kdFrw1K67sVGeKunp5OTTRzus6j63VI6ASKW0VrYOKemOuR
        NRbwAuRXLrpQIBjJvM0yqkLXFQ==
X-Google-Smtp-Source: ABdhPJz5MIaRdOmBLXaCQYiPuegrM0xZhG5U2A9JsyDhMfwlY/KrnNLKCIAHuHpJD9GptLhFz78/iQ==
X-Received: by 2002:a17:90a:a394:: with SMTP id x20mr5429746pjp.24.1608317427139;
        Fri, 18 Dec 2020 10:50:27 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z23sm9189336pfn.202.2020.12.18.10.50.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Dec 2020 10:50:26 -0800 (PST)
Date:   Fri, 18 Dec 2020 10:50:25 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Bhaskara Budiredla <bbudiredla@marvell.com>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Sunil Kovvuri Goutham <sgoutham@marvell.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [EXT] Re: [PATCH 1/2] mmc: Support kmsg dumper based on
 pstore/blk
Message-ID: <202012181047.99F11364@keescook>
References: <20201207115753.21728-1-bbudiredla@marvell.com>
 <20201207115753.21728-2-bbudiredla@marvell.com>
 <CAPDyKFqQwvG6vkwqPZutXjdV0hVrKp3MiqRRMZZ4C8Zr2Of9rg@mail.gmail.com>
 <CY4PR1801MB2070FD9FB1AB7166651198D1DEC60@CY4PR1801MB2070.namprd18.prod.outlook.com>
 <CAPDyKFqMsMdqw=Uwzby0tNNvPieRT2i6PAmHu_9XRRVy1MykuQ@mail.gmail.com>
 <202012151232.843EB2CB49@keescook>
 <CAPDyKFp=T2uqWsSTij_K=yXSffpPOKcWTqNrVxfatkncCZzaMQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFp=T2uqWsSTij_K=yXSffpPOKcWTqNrVxfatkncCZzaMQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, Dec 16, 2020 at 11:44:26AM +0100, Ulf Hansson wrote:
> In any case, I didn't catch *why* pstore needs to force block device
> drivers to implement specific pstore hooks to support the pstore file
> system. I don't think this is the way it should work, for many

For panic, pstore must avoid any path that might sleep. In a perfect
world, it should also use as little code as possible, to avoid
potentially tripping over areas of the kernel that might be broken.

-- 
Kees Cook
