From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 01/12] mmc: sdhci: add support for auto CMD23
Date: Fri, 18 Feb 2011 14:08:35 +0100
Message-ID: <201102181408.35946.arnd@arndb.de>
References: <1297762510-2696-1-git-send-email-arindam.nath@amd.com> <201102181150.41350.arnd@arndb.de> <6C03668EAF45B747AF947A1603D1B300DCED1913@SAUSEXMBP01.amd.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:53626 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754836Ab1BRNXS (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 18 Feb 2011 08:23:18 -0500
In-Reply-To: <6C03668EAF45B747AF947A1603D1B300DCED1913@SAUSEXMBP01.amd.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Nath, Arindam" <Arindam.Nath@amd.com>
Cc: zhangfei gao <zhangfei.gao@gmail.com>, "cjb@laptop.org" <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "Su, Henry" <Henry.Su@amd.com>, "Lu, Aaron" <Aaron.Lu@amd.com>, "anath.amd@gmail.com" <anath.amd@gmail.com>

On Friday 18 February 2011, Nath, Arindam wrote:
> > AFAICT, whether CMD23 can be used or not is primarily a decision based
> > on
> > the card, and the block driver might want issue it for a longer range
> > if it needs to split a block request into multiple MMC requests.
> 
> Thanks for the comments. Yes, whether a card supports CMD23 depends on
> the card, but Auto CMD23 is a feature added to the Host Controller v3.00
> just like Auto CMD12. I am already doing a check inside 
> sdhci_host_auto_cmd23_supported() whether the card supports CMD23, and
> whether the request is for multiple block transfers. Also I tried to make
> my implementation consistent with Auto CMD12 implementation already
> there in the sdhc code.

Ok, I see.

But, assuming that the block driver was changed to always to CMD23 where
appropriate, what is the advantage auf Auto CMD23?

As far as I can tell, changing the block driver would make all hosts
faster, not just sdhci, and it would be able to cover the split requests
I mentioned.

	Arnd

