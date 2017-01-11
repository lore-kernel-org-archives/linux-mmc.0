From: Niklas =?iso-8859-1?Q?S=F6derlund?=
        <niklas.soderlund@ragnatech.se>
Subject: Re: [PATCH v8 6/6] mmc: sh_mobile_sdhi: Add tuning support
Date: Wed, 11 Jan 2017 16:57:23 +0100
Message-ID: <20170111155723.GE25542@bigcity.dyn.berto.se>
References: <1478182564-18762-1-git-send-email-horms+renesas@verge.net.au>
 <1478182564-18762-7-git-send-email-horms+renesas@verge.net.au>
 <20170110210848.GA25542@bigcity.dyn.berto.se>
 <20170110223043.GA2710@katana>
 <20170111083541.GB25542@bigcity.dyn.berto.se>
 <20170111150521.GA1486@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lf0-f49.google.com ([209.85.215.49]:35046 "EHLO
        mail-lf0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1763695AbdAKP51 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 11 Jan 2017 10:57:27 -0500
Received: by mail-lf0-f49.google.com with SMTP id m78so118402608lfg.2
        for <linux-mmc@vger.kernel.org>; Wed, 11 Jan 2017 07:57:26 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20170111150521.GA1486@katana>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Simon Horman <horms+renesas@verge.net.au>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulf.hansson@linaro.org>, Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Ai Kyuse <ai.kyuse.uw@renesas.com>

Hi Wolfram,

On 2017-01-11 16:05:21 +0100, Wolfram Sang wrote:
> Hi Niklas,
> 
> > I'm doing my tests on Koelsch so I'm afraid setting the TDSEL in 
> > pfc-r8a7795.c won't do much ;-) Nevertheless I tried to mimic the patch 
> > for Koelsch but found the documentation lacking and where unable to do 
> > so. That is I found a TDSEL register but no documentation of its 
> > content.
> 
> Sorry, that slipped through. Actually, I sent a patch for H2:
> 
> https://patchwork.kernel.org/patch/9434323/
> 
> I wanted to do some TDSEL testing on other Gen2 boards in Brussels,
> provided that people could bring some. So, if you could bring that
> Koelsch board, that would be really helpful.

Sure, can you or someone else bring a power source? I plan to not check 
luggage so everything to conserve space helps :-)

> 
> I assume that you created a similar patch to the above for Koelsch and
> the issue still remained? :(

Yes I did with the help from Geert, I have now also tried your patch.  
Unfortunately the result is the same and the warning is printed. I hope 
to be able to spend more time later this week with the tuning patch to 
try and figure this out.

> 
> Regards,
> 
>    Wolfram
> 



-- 
Regards,
Niklas Söderlund
