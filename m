Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64162C47082
	for <linux-mmc@archiver.kernel.org>; Tue,  8 Jun 2021 17:33:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 464FC61378
	for <linux-mmc@archiver.kernel.org>; Tue,  8 Jun 2021 17:33:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232773AbhFHRex (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 8 Jun 2021 13:34:53 -0400
Received: from mail-pf1-f179.google.com ([209.85.210.179]:46844 "EHLO
        mail-pf1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231347AbhFHRex (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 8 Jun 2021 13:34:53 -0400
Received: by mail-pf1-f179.google.com with SMTP id u126so12269053pfu.13
        for <linux-mmc@vger.kernel.org>; Tue, 08 Jun 2021 10:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AHQbohLdOv212XWCgNAIki+QiBE294go+E+AnYbJF9M=;
        b=biLwqIL1ECQDpYXkKAkiuZYqmbzWdb0jGyciw3wmlN1bVkaAqUDBkQKGemUGGKPL9U
         Tuk/hQkeIOll0FNN/hDB8AaeP1VGf7Qh6LzsEwg0eZ8SWEGsKMvfxztXJlKPzFBPfqAq
         9CB7AN3O47sSHxkKxthkxvZ0/1sBjuSWXLyAw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AHQbohLdOv212XWCgNAIki+QiBE294go+E+AnYbJF9M=;
        b=nDkL0MnQMH0P1pXanhxdBiuety5qIA+lCRVBOXhYleBTBS8fpjwx4zFWkuk1TLZY6z
         u6ln5lcRcbRCuh2+/86OBJPAvqHMQO0r9WWmpjCwY8wSNyreB+Z9DTNOazNSYb/xkz34
         5aBUTAXX+DTiYZw4idqZbq4FcgVxzKGtMFBxQw40diw2Ab4e1xDc/aZM52iGQ2LRWTkU
         3Ud5WeG0cYZRtjJffBA8UTMoT+M1IrbDb5FD+vA1vc6LCOf02UCm3vO/B3LPdXGohAeq
         in8mi1JjRDkAg2yOgHx+sqzR/xHPpDUZhg8AxmL18gy24idjLp70qEqnmYB0gQrYV893
         kQnA==
X-Gm-Message-State: AOAM532H7QzZwwAlsPzR8Tm8KvEMCaLKzNsHv2F47QwqJcdmpJgZcuJO
        0Nj09faeyw5S1/52udy4BsYBdA==
X-Google-Smtp-Source: ABdhPJzIuNZXhKV1ztPY/+fg/0E6Sqq1LW/i6wIG6EXJPGFBpvO72K9KL365GXBSM6yBmu+VJToBZA==
X-Received: by 2002:a62:1481:0:b029:2c1:1e90:c54 with SMTP id 123-20020a6214810000b02902c11e900c54mr982446pfu.55.1623173520075;
        Tue, 08 Jun 2021 10:32:00 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id o7sm12557362pgs.45.2021.06.08.10.31.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 10:31:59 -0700 (PDT)
Date:   Tue, 8 Jun 2021 10:31:58 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Bhaskara Budiredla <bbudiredla@marvell.com>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Sunil Kovvuri Goutham <sgoutham@marvell.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>
Subject: Re: [EXT] Re: [PATCH v5 1/2] mmc: Support kmsg dumper based on
 pstore/blk
Message-ID: <202106081024.09E42DA400@keescook>
References: <20210120121047.2601-1-bbudiredla@marvell.com>
 <20210120121047.2601-2-bbudiredla@marvell.com>
 <CAPDyKFoF7jz-mbsY8kPUGca5civFKRRyPpHbRkj9P=xevRRfbA@mail.gmail.com>
 <CY4PR1801MB2070F43EFCB9139D8168164FDE3A9@CY4PR1801MB2070.namprd18.prod.outlook.com>
 <CAPDyKFrVQbALjSeFBckaZQgkgwcBVuwHy563pdBxHQNA7bxRnQ@mail.gmail.com>
 <CY4PR1801MB2070B09D27404F8B7A84D446DE389@CY4PR1801MB2070.namprd18.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY4PR1801MB2070B09D27404F8B7A84D446DE389@CY4PR1801MB2070.namprd18.prod.outlook.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, Jun 07, 2021 at 12:37:07PM +0000, Bhaskara Budiredla wrote:
> [...]
> >What patches are you referring to?
> 
> I was referring to this patch.
> http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/pstore

I applied the first three:
https://lore.kernel.org/lkml/160685706687.2724892.9289969466453217944.b4-ty@chromium.org/

and explained my aversion to the others. Christoph never replied to my
notes on patch 8/9:
https://lore.kernel.org/lkml/202012011149.5650B9796@keescook/

-Kees

-- 
Kees Cook
