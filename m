Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0BC8C64E7B
	for <linux-mmc@archiver.kernel.org>; Tue,  1 Dec 2020 20:29:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77D282151B
	for <linux-mmc@archiver.kernel.org>; Tue,  1 Dec 2020 20:29:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LBPU5BSD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729794AbgLAU3K (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 1 Dec 2020 15:29:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729347AbgLAU3J (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 1 Dec 2020 15:29:09 -0500
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C521C0613D4
        for <linux-mmc@vger.kernel.org>; Tue,  1 Dec 2020 12:28:29 -0800 (PST)
Received: by mail-pj1-x1044.google.com with SMTP id b12so2038091pjl.0
        for <linux-mmc@vger.kernel.org>; Tue, 01 Dec 2020 12:28:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ko75/Fr8d3GQsTIDa9DCUIlQClom7hRVgJtFr4EDnzY=;
        b=LBPU5BSDN0oDG6xd5T5rIAfXyh1S2b3z4horMexwrFdoZVeZL07exx80fudC45Hh3N
         mTroJtIjz3zOyniqGquKBzOLMqfDQ8r0k+i/vHSjXnexe4UcgfgGVNJAZragtVCeh8HD
         DjKQKEWIJwvboLsdEQhezvb0N//K3PSbJR6U0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ko75/Fr8d3GQsTIDa9DCUIlQClom7hRVgJtFr4EDnzY=;
        b=NLfGb8Qq8APRMVu1Vtbz938kkFwpBGhiLsMi6MWljeXSiOgy1Sn6kdf3zrBPgh47Av
         gIW4OGW+tNYieKsV4WeN1T4R6I7gqAE7En+LHxctFc+oA7wowqUyOnIruHGDMptYFPxl
         mije3ZVYUSq98CL8T6znrbMWGSZB+QFtVOyMpOYJ0lB8eSSnIb/aD0dOf7ds1BWMnSaD
         vnqTUtXgJeXKu/fOkl05Iu7I8/+iUO4h/SsVHe/ckijpLbpSrD7ZlwJjJHvm8wyVRDaM
         lB0Os6oEDk6xhk/FxW4voyFH9KpAXGaRIaZ3SIUP45//cR58Eb+6WEdGf/iMj4ypoJRa
         oTjw==
X-Gm-Message-State: AOAM533GbodNOf5buVXid78FF+6mcyhQyjVsDkr3NRMDGCod5V5CUyAo
        Ym9m1CJY1iRHj+osIaBTfBa2YQ==
X-Google-Smtp-Source: ABdhPJxk5B/5wh8+G1DWpNRfD5ZuGlXNVzdiMlkNVAZmHCpsZsmib6h50CiXAzeESoe16zt0B05Wvw==
X-Received: by 2002:a17:90a:f211:: with SMTP id bs17mr4583319pjb.144.1606854509121;
        Tue, 01 Dec 2020 12:28:29 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i3sm438891pgq.12.2020.12.01.12.28.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Dec 2020 12:28:27 -0800 (PST)
Date:   Tue, 1 Dec 2020 12:28:27 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Bhaskara Budiredla <bbudiredla@marvell.com>,
        ulf.hansson@linaro.org, ccross@android.com, tony.luck@intel.com,
        sgoutham@marvell.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] mmc: Support kmsg dumper based on pstore/blk
Message-ID: <202012011226.94027EB5E@keescook>
References: <20201123111925.28999-1-bbudiredla@marvell.com>
 <20201124113720.GA30440@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201124113720.GA30440@infradead.org>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, Nov 24, 2020 at 11:37:20AM +0000, Christoph Hellwig wrote:
> Please hold this off for now.  I have a major rewrite of the pstore/blk
> interface pending..

I'm fine with taking these patches -- they're using the pstore "device"
interface, not the pstore "blk" interface, and I don't expect to be
making big changes to the existing structures.

With feedback on patch 1 addressed, I'd be happy to Ack this going via
the mmc tree.

-- 
Kees Cook
