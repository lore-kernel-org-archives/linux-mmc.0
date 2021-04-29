Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C465C433B4
	for <linux-mmc@archiver.kernel.org>; Thu, 29 Apr 2021 12:41:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3865260E0B
	for <linux-mmc@archiver.kernel.org>; Thu, 29 Apr 2021 12:41:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231490AbhD2Mma (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 29 Apr 2021 08:42:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231343AbhD2Mm3 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 29 Apr 2021 08:42:29 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F748C06138B;
        Thu, 29 Apr 2021 05:41:41 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id e7so78275395edu.10;
        Thu, 29 Apr 2021 05:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=KpoRY41AF/OOHS14vTdGwor5lyD+2aObyNv/uzMvDE8=;
        b=sKp/ST+iN+nr0XPCl51JGFgXE4DiE6w2Jl9pYOqKgAZ+FQpH0QUnBXAjrciOLY7MJS
         upkT1d0iGjdYMKrY0lca4e0AVZlif+jlQ3qVHyxO+/51cPrFHBL9EwCd/b/K4gw5s4Dz
         NxlsdAsbShzS9g5Acpz5r07hkacmqQJLch+WLaXyFSRNlvJ8uRgAF2rDWveEXbGK4hjn
         jb+R1N0UdxzUlFomYtL/finyC0xLdUD4imtQl9FsRWJ0hg+eLxK1zh7lzsQ1usl0AUMc
         yfPjWenw8mcnPl4g3KP5UHpivcF4Z5LSsiK+XtEpmo5ycXGa5gsaMMKb3Mkgbizg48mv
         zPmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=KpoRY41AF/OOHS14vTdGwor5lyD+2aObyNv/uzMvDE8=;
        b=Q65rIaTqJRG8jtkKDG590xDLdVCi5W0t87QRcHGrxQ/QhjbNTa5Gr2yrz1m11x8Ybb
         IG2QpiuNoUMDL8XYJMN4ISUlrHkAL0QmEn9RDhdLiS2NuLZeChmqX/No5aTJbA6NftdE
         CXttHi70z2jJZcRLPgi4unXylnnNwhMVWq5j0EDX5EpGgJW1hrYs8E9IGT/zUa0CjBtQ
         NBTWieqvwInuecFJj2dFLlWikUakRoSV2hDiOhVTEVT9ValcFaL3Wnpd7r+wkxBnfg7d
         IjjraRebTV2tJ/6HuHAOllckPVIrhwcS7WGevu7KoEo285NhKLVv6dZou4/O0Mo94pBk
         P30g==
X-Gm-Message-State: AOAM533c4ZMh+VZfg8f0HpyPq4wufko0TXEbAh+2HJFH5/C/zT5ysi/4
        njKJxAKaS2l4hd/ptEQGUjE=
X-Google-Smtp-Source: ABdhPJw8t2bxvS6sMwo8sHjmzTfLvVJSst9VeriEMMM+BRKRUTegQIOdsokxh332+2CTkV4Y4Yx07Q==
X-Received: by 2002:aa7:c454:: with SMTP id n20mr18387352edr.138.1619700100185;
        Thu, 29 Apr 2021 05:41:40 -0700 (PDT)
Received: from ubuntu-laptop (ip5f5bec5d.dynamic.kabel-deutschland.de. [95.91.236.93])
        by smtp.googlemail.com with ESMTPSA id d15sm2283510edu.86.2021.04.29.05.41.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Apr 2021 05:41:39 -0700 (PDT)
Message-ID: <b14312f5e6c2bcf711397a7c26782710b7a4707b.camel@gmail.com>
Subject: Re: [PATCH RESEND v3] mmc-utils: Add eMMC erase command support
From:   Bean Huo <huobean@gmail.com>
To:     Avri Altman <Avri.Altman@wdc.com>,
        "luserhker@gmail.com" <luserhker@gmail.com>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        "kenny.gibbons@oracle.com" <kenny.gibbons@oracle.com>,
        "kimito.sakata@oracle.com" <kimito.sakata@oracle.com>,
        "rkamdar@micron.com" <rkamdar@micron.com>,
        "chris@printf.net" <chris@printf.net>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Thu, 29 Apr 2021 14:41:34 +0200
In-Reply-To: <DM6PR04MB657542B3CB77F6D894B1EA84FC409@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20210427195157.26568-1-luserhker@gmail.com>
         <DM6PR04MB657542B3CB77F6D894B1EA84FC409@DM6PR04MB6575.namprd04.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 2021-04-28 at 05:57 +0000, Avri Altman wrote:
> > We need to send 3 MMC commands and it is important that they
> > stay in sequence. Therefore we are using MMC_IOC_MULTI_CMD.
> 
> 
> You might also want to indicate on which platform it was tested.


I tested on HP laptop PC X86 based and xilinx Zedboard ARM based.

thanks,
Bean

