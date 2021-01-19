Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB2CDC433E0
	for <linux-mmc@archiver.kernel.org>; Tue, 19 Jan 2021 19:31:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7945F2310B
	for <linux-mmc@archiver.kernel.org>; Tue, 19 Jan 2021 19:31:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728790AbhASTbv (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 19 Jan 2021 14:31:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391782AbhASTbX (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 19 Jan 2021 14:31:23 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DD41C061574
        for <linux-mmc@vger.kernel.org>; Tue, 19 Jan 2021 11:30:43 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id n7so13607587pgg.2
        for <linux-mmc@vger.kernel.org>; Tue, 19 Jan 2021 11:30:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2a+AJpXRCTfZyczQuEB9u8BkJxf/cNBjjXi4k4TlSWw=;
        b=e1M94iUqOKU+aAyCpeYRdv6GdAW8k4BKNsScVlx4Vdhw7LYfoIN7biO6tmrLfIIdvD
         0EGUqvCdo36mugVbNLgC8uuoCkz9bugEBDAC05tTf8br6QRIEOG00zQI1LHzQClGOJNl
         LBFd5gRfieCIjLr8Be6aMd6pRuGd8ont4Rhd4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2a+AJpXRCTfZyczQuEB9u8BkJxf/cNBjjXi4k4TlSWw=;
        b=chLHzvhcK45BMunxQ4KLTnzE0qpVXwuBIWPfvGkYk08CNXRWocaIX0aatzjdnntFNg
         SxUUrz5PCWEnb5BXvP11LJ7u8RO2vn9EfKO33oSheEnw7KfzRhXkFgwrr3EaBVH+r/DA
         oHLTKth8XBSGbbjo2DuzngOwUjCH6ks+AjqQuSv1CbH1JXPyi6JjJckHUlSrWBQ2Lfjt
         tv+stBGesw0TYZb4yWIZ9CDH5EuSTWloX7bQBcxnCWVvRlOR0HacHenszKCW1qzz2OB9
         nRC4guQeyN8V/gt+ZXOZ9KyOuitWla8uClfSXUAdyQ6ohpG6YkLCd3qvpiAkgd4Gs5+t
         pDTQ==
X-Gm-Message-State: AOAM532Nmrmxc0SRucxtbOY+p44TNAOLDLflwNNu9mRKUBxv0F3FXFNH
        1rnbTug59qczzZ7lB4+LL2V8MA==
X-Google-Smtp-Source: ABdhPJyUvkfLSXjqHOEq8OgTC+xZiHsy62DRudN423jP+qTtj/pWPVamzTtU3XbQzUKSYlRFrfZXew==
X-Received: by 2002:a62:65c7:0:b029:1b8:5c05:820b with SMTP id z190-20020a6265c70000b02901b85c05820bmr5673986pfb.48.1611084642828;
        Tue, 19 Jan 2021 11:30:42 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a18sm19634412pfg.107.2021.01.19.11.30.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jan 2021 11:30:42 -0800 (PST)
Date:   Tue, 19 Jan 2021 11:30:41 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Bhaskara Budiredla <bbudiredla@marvell.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Sunil Kovvuri Goutham <sgoutham@marvell.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [EXT] Re: [PATCH v4 1/2] mmc: Support kmsg dumper based on
 pstore/blk
Message-ID: <202101191130.4A8EC5F9@keescook>
References: <20201223144033.32571-1-bbudiredla@marvell.com>
 <20201223144033.32571-2-bbudiredla@marvell.com>
 <CAPDyKFq41CQ8JbyAS0+k26=Cyf=KcOpdeD+VmY1AZxbh4D6f9w@mail.gmail.com>
 <CY4PR1801MB207022E70C53D0DA87EB3F22DEA31@CY4PR1801MB2070.namprd18.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY4PR1801MB207022E70C53D0DA87EB3F22DEA31@CY4PR1801MB2070.namprd18.prod.outlook.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, Jan 19, 2021 at 04:11:31AM +0000, Bhaskara Budiredla wrote:
> Do you see any issues to ACK this if the mmc pstore
> registration is through register_pstore_blk()?
> As Uffe said, eMMC would need to go through
> psblk_generic_blk_read()/write() instead of
> mmcpstore_read()/write().

I would be fine with that; yes.

-- 
Kees Cook
