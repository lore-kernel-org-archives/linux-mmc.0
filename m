From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH REPOST 1/2] arm/dt: Tegra: Update SDHCI nodes to match bindings
Date: Thu, 22 Sep 2011 16:40:16 +0200
Message-ID: <201109221640.16985.arnd@arndb.de>
References: <1316537186-26753-1-git-send-email-swarren@nvidia.com> <201109202301.56983.arnd@arndb.de> <CAOesGMg4kBH77Ou1xyyVT-Ojxg=9uyxmfsmhbbKquru=j+z6Gg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:64021 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752161Ab1IVOkY (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 22 Sep 2011 10:40:24 -0400
In-Reply-To: <CAOesGMg4kBH77Ou1xyyVT-Ojxg=9uyxmfsmhbbKquru=j+z6Gg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Olof Johansson <olof@lixom.net>
Cc: Grant Likely <grant.likely@secretlab.ca>, Stephen Warren <swarren@nvidia.com>, nicolas.pitre@linaro.org, Shawn Guo <shawn.guo@linaro.org>, devicetree-discuss@lists.ozlabs.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org, Chris Ball <cjb@laptop.org>, linux-arm-kernel@lists.infradead.org

On Tuesday 20 September 2011, Olof Johansson wrote:
> On Tue, Sep 20, 2011 at 2:01 PM, Arnd Bergmann <arnd@arndb.de> wrote:

> > Should I take the other one as well? It's probably better to let that
> > go the proper way through the tegra tree for 3.2, right?
> 
> Given that you have a public tree right now, and I don't (since
> kernel.org is down), please feel free to start a tegra/for-3.2 branch
> for me and apply it there. I'll base further work on top of that if
> needed.
> 
> (There also aren't a whole lot of other patches queued for 3.2 right now).

Ok, I've put it into the next/fixes branch now, so it will be in 3.2.

Thanks,

	Arnd
