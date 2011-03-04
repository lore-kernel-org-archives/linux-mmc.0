From: Maxim Levitsky <maximlevitsky@gmail.com>
Subject: Re: [PATCH 1/3] mmc: skip detection of nonremovable cards on
 rescan - card removal detection regression
Date: Fri, 04 Mar 2011 04:22:46 +0200
Message-ID: <1299205366.4999.3.camel@maxim-laptop>
References: <1290921690-6133-1-git-send-email-ohad@wizery.com>
	 <1290921690-6133-2-git-send-email-ohad@wizery.com>
	 <20101217005123.GD17239@void.printf.net>
	 <AANLkTi=ff=kkaRHOrDyoxOgw_Bt7raiPf3T=ed1=EveZ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:58946 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759190Ab1CDCWw (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 3 Mar 2011 21:22:52 -0500
Received: by eyx24 with SMTP id 24so559252eyx.19
        for <linux-mmc@vger.kernel.org>; Thu, 03 Mar 2011 18:22:51 -0800 (PST)
In-Reply-To: <AANLkTi=ff=kkaRHOrDyoxOgw_Bt7raiPf3T=ed1=EveZ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org

On Mon, 2010-12-20 at 00:11 +0200, Ohad Ben-Cohen wrote:
> Hi Chris,
> 
> On Fri, Dec 17, 2010 at 2:51 AM, Chris Ball <cjb@laptop.org> wrote:
> ...
> > Thanks, pushed to mmc-next with trivial cleanup as below:
> 
> Looks good, thanks.
> 
> I just briefly tested mmc-next and it looks fine.

This patch breaks the CONFIG_MMC_UNSAFE_RESUME, because it sets fake
non-removeable flag, but the intended use of this option is to assume
that card is not removed _during_ suspend,  and it can still be removed
during normal use.
With this commit, card removal isn't detected.

Best regards,
	Maxim Levitsky

