Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF850C71155
	for <linux-mmc@archiver.kernel.org>; Wed,  2 Dec 2020 19:33:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BD5D22201
	for <linux-mmc@archiver.kernel.org>; Wed,  2 Dec 2020 19:33:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728969AbgLBTcz (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 2 Dec 2020 14:32:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727925AbgLBTcy (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 2 Dec 2020 14:32:54 -0500
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE0A7C0617A6
        for <linux-mmc@vger.kernel.org>; Wed,  2 Dec 2020 11:32:14 -0800 (PST)
Received: by mail-pl1-x644.google.com with SMTP id p6so1681170plr.7
        for <linux-mmc@vger.kernel.org>; Wed, 02 Dec 2020 11:32:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vbmUce51n0krhiz6IFENVF9pgBvxYw5qYTmdokIFBx0=;
        b=OB8tdF7XPPRvLbxT/HXse2cshrzol0nnx/yT4ZkqLQVLlE+61uDznkIYtRwOdu+Amf
         E8VOkgBUBS5QTKmNRPZdJs7ly7DcgNsV65BkQ3+puafMCrzr0EKTN4NbaqzIDBhxoIZI
         rNwt6GigZQSOoupZa4d6lCm4hHPIV4BhMI8m0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vbmUce51n0krhiz6IFENVF9pgBvxYw5qYTmdokIFBx0=;
        b=XYHS33U6+nykvEupTAbZVac+LvXHP8k7sVaRkgHo+qC+2bVREwixcclLMwNZTu5EjO
         98f8JH75bMDVHkc+R/y/TpVhZGsh6ZiNl36Wr1pZFy4rd/A+GyyX+ILkb+XX3JoOEKFv
         5sHzNVZyNGDfakhxkO8CsThXz2nwz7V/iOdWvdXN3jY6hPtuHzSgxFAsdmtCfqSEtkkN
         isWI0IY/oxBAcXvSFGVkHcNJHtXMkCp/IA3pTEqdDXQ3AToYSslllnumQn+2d62bKtgz
         cbb2+ysRYpJqCqmmWmP8+4NYqsHFI41YdU4M5rzCM6NO4BkRVW6vUwlt2qwwb1F2Sftl
         ZXhA==
X-Gm-Message-State: AOAM5336jg+Dwk2l5kAk4p8rqL3RwYl6R2vMx2c08LHW7FK99RlMqTiO
        pGpWuYzVpD6uhwJBUIiLXFwuGQ==
X-Google-Smtp-Source: ABdhPJytpYwxiUYLTOB6lkAHyir5C1sXgAEZpkqx9VFbqEwkCcZ4Tf5Qqh08BnlIYViekoyeFZ64+g==
X-Received: by 2002:a17:90a:4593:: with SMTP id v19mr1292857pjg.217.1606937534288;
        Wed, 02 Dec 2020 11:32:14 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x207sm573335pfc.171.2020.12.02.11.32.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 11:32:13 -0800 (PST)
Date:   Wed, 2 Dec 2020 11:32:12 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Bhaskara Budiredla <bbudiredla@marvell.com>
Cc:     "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "ccross@android.com" <ccross@android.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        Sunil Kovvuri Goutham <sgoutham@marvell.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "outgoing2/0000-cover-letter.patch@mx0b-0016f401.pphosted.com" 
        <outgoing2/0000-cover-letter.patch@mx0b-0016f401.pphosted.com>
Subject: Re: [EXT] Re: [PATCH v2 1/2] mmc: Support kmsg dumper based on
 pstore/blk
Message-ID: <202012021126.20ACBBD@keescook>
References: <20201123111925.28999-1-bbudiredla@marvell.com>
 <202012011218.3B6566C5@keescook>
 <CY4PR1801MB207097391BD8DE37A0F49102DEF30@CY4PR1801MB2070.namprd18.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY4PR1801MB207097391BD8DE37A0F49102DEF30@CY4PR1801MB2070.namprd18.prod.outlook.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, Dec 02, 2020 at 06:36:21AM +0000, Bhaskara Budiredla wrote:
> >From: Kees Cook <keescook@chromium.org>
> >On Mon, Nov 23, 2020 at 04:49:24PM +0530, Bhaskara Budiredla wrote:
> >Why isn't this just written as:
> >
> >config MMC_PSTORE
> >	bool "Log panic/oops to a MMC buffer"
> >	depends on MMC_BLOCK
> >	select PSTORE_BLK
> >	help
> >	  This option will let you create platform backend to store kmsg
> >	  crash dumps to a user specified MMC device. This is primarily
> >	  based on pstore/blk.
> >
> 
> The idea was to compile MMC_PSTORE as part of MMC_BLOCK driver,
> provided it is optionally enabled.
> The above arrangement compiles MMC_PSTORE 
> as module: if (CONFIG_MMC_PSTORE_BACKEND == y && CONFIG_MMC_BLOCK == m)
> as static:     if (CONFIG_MMC_PSTORE_BACKEND == y && CONFIG_MMC_BLOCK == y)

Ah, okay. If it's a tri-state, wouldn't it track CONFIG_MMC_BLOCK's
state? As in, does this work:

config MMC_PSTORE
	tristate "Log panic/oops to a MMC buffer"
	depends on MMC_BLOCK
	select PSTORE_BLK
	help
	  This option will let you create platform backend to store kmsg
	  crash dumps to a user specified MMC device. This is primarily
	  based on pstore/blk.

> >> +	if (strncmp(cxt->dev_name, disk_name, strlen(disk_name)))
> >> +		return;
> >
> >Why isn't this just strcmp()?
> 
> The mmc disk name (disk_name) doesn't include the partition number. 
> strncmp is restricted to something like /dev/mmcblk0, it doesn't cover full /dev/mmcblk0pn.
> The partition number check is carried out in the next statement.

Okay, gotcha; thanks!

> >> +	dev->flags = PSTORE_FLAGS_DMESG;
> >
> >Can't this support more than just DMESG? I don't see anything specific to that.
> >This is using pstore/zone ultimately, which can support whatever frontends it
> >needs to.
> 
> Yes, as of now the support is only for DMESG. We will extend this to other frontends
> on need basis.

Okay -- I assume this has mostly to do with not having erasure (below).

> >> +	dev->erase = NULL;
> >
> >No way to remove the records?
> 
> Yes, at this time, no removal of records.

Okay. (I think this might be worth mentioning in docs somewhere.)

-- 
Kees Cook
