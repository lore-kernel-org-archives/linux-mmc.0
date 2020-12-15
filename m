Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0D53C4361B
	for <linux-mmc@archiver.kernel.org>; Tue, 15 Dec 2020 20:38:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A939522AAE
	for <linux-mmc@archiver.kernel.org>; Tue, 15 Dec 2020 20:38:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728233AbgLOUiH (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 15 Dec 2020 15:38:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726356AbgLOUhz (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 15 Dec 2020 15:37:55 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D15CC06179C
        for <linux-mmc@vger.kernel.org>; Tue, 15 Dec 2020 12:37:15 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id d2so15206748pfq.5
        for <linux-mmc@vger.kernel.org>; Tue, 15 Dec 2020 12:37:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lNcnCO+DxIilm3yznDYW+rmw4EGxoZ3x7gThBV5GQKU=;
        b=O5HFZ2q2LVS0n+J77C2bqh6+lY7S8rIaIcgGeaOKyssiAN0bIu5lKrvExf/CHa9oUn
         W3F1vBnkL+o1bai6sf3GuCJgfR0Ns4pWkyn41ch95+UvZH6FJ6EkF95KE5QK+Z9iG5Ey
         2NEUZjj2N5DZiHZqozc47bccwK1Ggkz/87/y0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lNcnCO+DxIilm3yznDYW+rmw4EGxoZ3x7gThBV5GQKU=;
        b=kz6v5/KnRsoRUKXeIZHSLVNg3wxpm7wc1dLJIeOzzhKN0YGa4khnrOTZKhWYkiv9PL
         g2B8zVF7Egu1V/k/qAFX5xvJBIPXQoyzKE4g4CVx9T9XDs7QrmIsMBDMF5ghqkqjuFZ1
         dWd1RwjVBry4HYARgTB5TVbO4Jtt0cydEYehgJg1Y/PY97aaSFMq+p0SXD75mlcgTkr3
         CYStdvDDPNWrj/b9WTI2QqQSSHespFfMregsAVJaqKifkyF4tvNrOWzh3/RU26erDE41
         0WpM4AYMqY+o1nY88sHuCe4MMCwCeE00Fcs0gQePNr1V3I2ILTfXMCte08e8H9fGMS9f
         ykHA==
X-Gm-Message-State: AOAM53019bPVO2nI49fr/UuiypUGbPKpIDFS6+CcmapZbH7SU7xM5gOt
        pnkiVxNUQMmQm2c4TZ+oqu2Jtw==
X-Google-Smtp-Source: ABdhPJxUdz4fVyUdjV01hTRGpWBC6iKKiKGko3KEQfhJtCzu47uzHPlJFX6Ohy6850ab3mytBTGbiA==
X-Received: by 2002:a63:784a:: with SMTP id t71mr29865460pgc.87.1608064635005;
        Tue, 15 Dec 2020 12:37:15 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b2sm17592646pfo.164.2020.12.15.12.37.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Dec 2020 12:37:13 -0800 (PST)
Date:   Tue, 15 Dec 2020 12:37:12 -0800
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
Message-ID: <202012151232.843EB2CB49@keescook>
References: <20201207115753.21728-1-bbudiredla@marvell.com>
 <20201207115753.21728-2-bbudiredla@marvell.com>
 <CAPDyKFqQwvG6vkwqPZutXjdV0hVrKp3MiqRRMZZ4C8Zr2Of9rg@mail.gmail.com>
 <CY4PR1801MB2070FD9FB1AB7166651198D1DEC60@CY4PR1801MB2070.namprd18.prod.outlook.com>
 <CAPDyKFqMsMdqw=Uwzby0tNNvPieRT2i6PAmHu_9XRRVy1MykuQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFqMsMdqw=Uwzby0tNNvPieRT2i6PAmHu_9XRRVy1MykuQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, Dec 15, 2020 at 12:42:58PM +0100, Ulf Hansson wrote:
> In principle, for non atomic path, I would rather see that the pstore
> file system should be able to be mounted on top of any generic block
> device partition - without requiring the block device driver to
> implement specific pstore ops.
> [...]
> Exactly. That's why I wonder if it's really worth it to support the
> panic writes at all.

pstore/blk already provides the generic hooking -- but it can't do
the panic write part (which that's very device/driver-specific). The
design was for individual backing devices to provide that directly
(which would needed read/write support too). And for those that don't
have panic/read/write support, they could still use the generic hooks
but they wouldn't be able to reliably (or at all?) catch panics (just
console writes, ftrace, pmsg, etc).

-- 
Kees Cook
