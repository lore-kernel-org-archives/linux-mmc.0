From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 2/2] mmc: add sdhci-tegra driver for Tegra SoCs
Date: Fri, 31 Dec 2010 04:11:26 +0000
Message-ID: <20101231041124.GB19122@void.printf.net>
References: <1293096475-19634-1-git-send-email-olof@lixom.net> <1293096828-19985-1-git-send-email-olof@lixom.net> <20101223112346.GA5044@pengutronix.de> <AANLkTinpfKrLoZEr4RkiLJvNNHKavKCY4VBaJn+eGCv_@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:45082 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750827Ab0LaELl (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 30 Dec 2010 23:11:41 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTinpfKrLoZEr4RkiLJvNNHKavKCY4VBaJn+eGCv_@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Olof Johansson <olof@lixom.net>
Cc: Wolfram Sang <w.sang@pengutronix.de>, Mike Rapoport <mike@compulab.co.il>, linux-mmc@vger.kernel.org, linux-tegra@vger.kernel.org, Yvonne Yip <y@palm.com>

Hi Olof,

On Thu, Dec 23, 2010 at 10:27:29AM -0800, Olof Johansson wrote:
> But yeah, defaulting to RW makes more sense. v4 coming once I know if
> you want me to rip out the new quirk or not.

I'll take a v4 with the remaining quirk for now, and we'd be extremely
interested in seeing sdhci_ops->fixup work and quirk removal from you.

For what it's worth, Wolfram's not singling you out -- recently we've
been consistently rejecting patches that add new SDHCI quirks and
asking for rework.  (See Takashi's JMicron 388 patch, for example.)

Thanks!

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
