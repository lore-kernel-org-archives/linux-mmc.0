From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Subject: Re: [PATCH] Revert "sdhci-of-esdhc: Support 8BIT bus width."
Date: Sun, 17 May 2015 08:36:07 +0000
Message-ID: <1431851766.6782.7.camel@transmode.se>
References: <1431671349-12759-1-git-send-email-haokexin@gmail.com>
	 <1431673364.13197.10.camel@transmode.se>
	 <1431674695.13197.14.camel@transmode.se>
	 <20150515074254.GP8870@pek-khao-d1.corp.ad.wrs.com>
	 <1431693634.13197.29.camel@transmode.se>
	 <20150517050602.GB23513@pek-khao-d1.corp.ad.wrs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.transmode.se ([31.15.61.139]:58545 "EHLO smtp.transmode.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752317AbbEQIgM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 17 May 2015 04:36:12 -0400
In-Reply-To: <20150517050602.GB23513@pek-khao-d1.corp.ad.wrs.com>
Content-Language: en-US
Content-ID: <604DF0BC898ED04893F94872253B3A6E@transmode.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "haokexin@gmail.com" <haokexin@gmail.com>
Cc: "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On Sun, 2015-05-17 at 13:06 +0800, Kevin Hao wrote:
> > 
> > How about this one:
> > 
> > From af6b18c056b6064424bd2ab1f9989bbadae5e701 Mon Sep 17 00:00:00 2001
> > From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
> > Date: Mon, 20 Apr 2015 22:36:55 +0200
> > Subject: [PATCHv3] sdhci-of-esdhc: Support 8BIT bus width.
> > 
> > esdhc_readb()/esdhc_writeb() did not adjust for 8BIT.
> 
> Do we really need this for the 8bit bus support? There is already a specific
> API for setting the bus width, this change seems unnecessary to me. That is
> also why I choose to revert that patch. Did I miss something?

We do, the bus API really only works well when the bus bits are in another 
register but the HOST_CONTROL register.
The only reason 4BIT works is because its bit placement is where 
SDHCI expects it to be. 8BIT is not, so unless readb/writeb funktions compensate
for that they will overwrite what the bus API set earlier.

Atleast this is my understanding, Ulf?

Didn't this patch work for you either?

 Jocke
