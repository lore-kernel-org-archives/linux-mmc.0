Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B05BC433E0
	for <linux-mmc@archiver.kernel.org>; Tue, 23 Feb 2021 09:35:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CEE876023C
	for <linux-mmc@archiver.kernel.org>; Tue, 23 Feb 2021 09:35:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbhBWJe4 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 23 Feb 2021 04:34:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230466AbhBWJdh (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 23 Feb 2021 04:33:37 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6596C06178A
        for <linux-mmc@vger.kernel.org>; Tue, 23 Feb 2021 01:32:56 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id q14so62261117ljp.4
        for <linux-mmc@vger.kernel.org>; Tue, 23 Feb 2021 01:32:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0lDejisqH6bDNxUrmvdHi9RzSa2AbCpbgwdzBzgYc20=;
        b=IijTlhJOHG0LCb+oN6ToVlMQD0Z5bgmZKQqPqfKmKXknGIc1CgKPVRVsrVyB681+VP
         5IVImZ88u/9HXpCMlywH21Q0rJ5MmCPpFWNTYJ3FkVhK0aU3RNFB0kc/rYVSY4HJBCom
         /1JuU1DT8oOTlKgt7JtsoSvGm3z8lQiJbdr3tRtbNANG7ISf/KBidEsrbqrv0y7hROEi
         8neIROOavQfPe3Ecelh81tNFdarGOaUKSMXwWTiWiLQKYodgJVxIjRAvDFVFdeUy1LR2
         kHnIi8bfqQsvYvXjM8q0hpfrAqMbNnjkhVjZK8POr6s95i+yoGAqsjxJIX5rK8SwTcHE
         hdfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0lDejisqH6bDNxUrmvdHi9RzSa2AbCpbgwdzBzgYc20=;
        b=rr7MH7XpplzhqsgJ6B9jcNZD2iVOJQg40ne0GegCX+DAVSzcIjLPBIcEEO0aBspjX5
         G5c9/N945VjqcHwRakYoItD5gzuIcQvrc1Ft1EC1ofLiGZvs53ivsx/eNvUYEU5/fy/N
         hRjQFGgBsyDbwbgDi1ByHFoCwEuNApKFA7LITh8WqsyitYWevrlnQYAIR+6SB9PfBlJC
         Cbv53yi8hCdmJcEOwyBNQ4SPKanadJQ4vY74K3Ggk6m6QR+mEChAKIqfhnW5lwwPE+D6
         oE1zvL5xjqZATx9JMTrWwdexC2hM5CvOZgCsr9nYv6WAcQCDHwMQIpamjFeZ9rigcFel
         W6NA==
X-Gm-Message-State: AOAM531YTe1nhTZmRgUPA4zk+B3KpyRZZvK2kqTNWjPEBaGQ+ABArS2I
        QoOfdqPUvcWvgxssO6Y4Ans=
X-Google-Smtp-Source: ABdhPJwb3hWtZzMT4BgXVWPhyvqdnAA2Ee6xs+9F4ilamJJV80nYyy01slEUt3qLSkSuu0xan0qELw==
X-Received: by 2002:a2e:b051:: with SMTP id d17mr160213ljl.255.1614072772754;
        Tue, 23 Feb 2021 01:32:52 -0800 (PST)
Received: from home.paul.comp (paulfertser.info. [2001:470:26:54b:226:9eff:fe70:80c2])
        by smtp.gmail.com with ESMTPSA id h11sm1883537lfc.298.2021.02.23.01.32.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Feb 2021 01:32:52 -0800 (PST)
Received: from home.paul.comp (home.paul.comp [IPv6:0:0:0:0:0:0:0:1])
        by home.paul.comp (8.15.2/8.15.2/Debian-14~deb10u1) with ESMTP id 11N9Wn8m010817;
        Tue, 23 Feb 2021 12:32:50 +0300
Received: (from paul@localhost)
        by home.paul.comp (8.15.2/8.15.2/Submit) id 11N9Wlrk010816;
        Tue, 23 Feb 2021 12:32:47 +0300
Date:   Tue, 23 Feb 2021 12:32:47 +0300
From:   Paul Fertser <fercerpav@gmail.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Subject: Re: [PATCH 3/3] mmc: core: Default to generic_cmd6_time as timeout
 in __mmc_switch()
Message-ID: <20210223093247.GA2059@home.paul.comp>
References: <20200122142747.5690-1-ulf.hansson@linaro.org>
 <20200122142747.5690-4-ulf.hansson@linaro.org>
 <20210222162406.GA17142@home.paul.comp>
 <20210222201245.GW2059@home.paul.comp>
 <CAPDyKFpXceh0qWZMxnOnLmrnwyt==qWWaxHCYzb6UxGRcvgksA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFpXceh0qWZMxnOnLmrnwyt==qWWaxHCYzb6UxGRcvgksA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hello Ulf,

On Tue, Feb 23, 2021 at 10:23:28AM +0100, Ulf Hansson wrote:
> > diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> > index f5dedb7f9b27..9adf735391fa 100644
> > --- a/drivers/mmc/core/mmc.c
> > +++ b/drivers/mmc/core/mmc.c
> > @@ -426,8 +426,7 @@ static int mmc_decode_ext_csd(struct mmc_card *card, u8 *ext_csd)
> >                 /* EXT_CSD value is in units of 10ms, but we store in ms */
> >                 card->ext_csd.part_time = 10 * ext_csd[EXT_CSD_PART_SWITCH_TIME];
> >                 /* Some eMMC set the value too low so set a minimum */
> > -               if (card->ext_csd.part_time &&
> > -                   card->ext_csd.part_time < MMC_MIN_PART_SWITCH_TIME)
> > +               if (card->ext_csd.part_time < MMC_MIN_PART_SWITCH_TIME)
> >                         card->ext_csd.part_time = MMC_MIN_PART_SWITCH_TIME;
> >
> >                 /* Sleep / awake timeout in 100ns units */
> >
> > I do not see any more warnings on my system.
> 
> That looks like the correct fix to the problem. Do you want to send a
> proper patch that I can pick up or do you prefer if help to do it?

I've sent this as a diff precisely because 1c447116d017 was so
explicit about special-casing zero ext_csd timeout value, so I thought
probably Adrian can provide the rationale for that. I'd prefer to wait
for his feedback before sending a formal patch. Does this make sense?

-- 
Be free, use free (http://www.gnu.org/philosophy/free-sw.html) software!
mailto:fercerpav@gmail.com
