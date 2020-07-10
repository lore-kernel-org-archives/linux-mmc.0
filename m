Return-Path: <SRS0=hS93=AV=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94C13C433DF
	for <linux-mmc@archiver.kernel.org>; Fri, 10 Jul 2020 03:04:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D8D420720
	for <linux-mmc@archiver.kernel.org>; Fri, 10 Jul 2020 03:04:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="Z0lNoGhG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbgGJDEQ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 9 Jul 2020 23:04:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbgGJDEQ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 9 Jul 2020 23:04:16 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37299C08C5CE;
        Thu,  9 Jul 2020 20:04:16 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id dm19so3414451edb.13;
        Thu, 09 Jul 2020 20:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YLfw68r/hxoh0NgCLBxSxGfsf8FdyOcJYnFgZuru9c8=;
        b=Z0lNoGhGxomlXESnJmJIj3kaLlNfCpfGBY6uILkYPuZZ9qub3uS3pGM34slmHTbaLj
         +0gus1ZS50pj/Rg3hgjpyR5wff9NX1Ufq6Uu8ucnJW3va9mS5yhDd4NyuQZPyzZSAKhH
         PneheiBTt10S8gJdhP0qMjFUgIW6DvjkkgEVk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YLfw68r/hxoh0NgCLBxSxGfsf8FdyOcJYnFgZuru9c8=;
        b=rRf8GI/aASv6dUGTACnZrA9xf/EJ5QviiLNb7y5jvN+RHpQ+Gr+xraJfB5IZV8/CW1
         y++ZqnTmiTwftTGmv+Y4/LYE0LQdgny0ZiK7j0lc1UJTO7otkBu/XSkSV8e5eEbegAnX
         1Kg2JdtKuvoM2bDmEYg4PG4rfwtjfLPtSayjXyyQrDDx1SnlfrfQGrSmmVEuQa6Mks3J
         /+/De0g4WxEDNPkuhJFLMl4XbQgZIK6FvLdhTUH70J5VD2SanRZVrcblMVEvZLn0E8xS
         psRmFmSITJe4PbyNYnpG2tUsUL9xafrgO7jPgVlF2y5elkkXizpDpE+1iTNK2gcqA7OK
         IDtw==
X-Gm-Message-State: AOAM531mSthAHS4VKPtD3lz1+o0R4xuVv5ojcohvp6+6BzRT2lToDrS7
        vwrVFzBVsgnSlsX8QzkrYRcteF3FOf6TEUMAERs=
X-Google-Smtp-Source: ABdhPJzpdveYcIc6pgM/Fe1jdllnZf80Q1VMKGv/QELC2YPCTMnO/7YKXw2PDoRwqL2q3b7XfvqI/pFBrn+kpAQhutY=
X-Received: by 2002:a05:6402:202e:: with SMTP id ay14mr75165877edb.233.1594350254944;
 Thu, 09 Jul 2020 20:04:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200709195706.12741-1-eajames@linux.ibm.com> <20200709195706.12741-3-eajames@linux.ibm.com>
 <4acad452-33c7-4fb2-ba90-19a824558b94@www.fastmail.com>
In-Reply-To: <4acad452-33c7-4fb2-ba90-19a824558b94@www.fastmail.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Fri, 10 Jul 2020 03:04:03 +0000
Message-ID: <CACPK8XcWEn-M291U1va7T=5R0qHp3D0hy53-fkEw7pa_iQu6tA@mail.gmail.com>
Subject: Re: [PATCH 2/2] mmc: sdhci-of-aspeed: Fix clock divider calculation
To:     Andrew Jeffery <andrew@aj.id.au>
Cc:     Eddie James <eajames@linux.ibm.com>, linux-clk@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 10 Jul 2020 at 01:14, Andrew Jeffery <andrew@aj.id.au> wrote:
>
>
>
> On Fri, 10 Jul 2020, at 05:27, Eddie James wrote:
> > When calculating the clock divider, start dividing at 2 instead of 1.
> > The divider is divided by two at the end of the calculation, so starting
> > at 1 may result in a divider of 0, which shouldn't happen.
> >
> > Signed-off-by: Eddie James <eajames@linux.ibm.com>
>
> Reviewed-by: Andrew Jeffery <andrew@aj.id.au>

Acked-by: Joel Stanley <joel@jms.id.au>
Fixes: d3d04f6c330a ("clk: Add support for AST2600 SoC")

Stephen, I think this should go to stable too along with 1/2.

Cheers,

Joel
