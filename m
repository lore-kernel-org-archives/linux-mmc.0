From: Bastien Nocera <hadess@hadess.net>
Subject: Re: [Regression: mmc: sdhci-esdhc-imx: add runtime pm support]
Date: Wed, 1 Jul 2015 13:13:46 +0000 (UTC)
Message-ID: <loom.20150701T150850-834@post.gmane.org>
References: <52F3A267.8030302@parkeon.com> <CAA+hA=Qvnm4S1tEQbfopegTeE4uHDdu9nY=fnYAYqdzPrUP8CQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:58865 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753958AbbGANPG (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 1 Jul 2015 09:15:06 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glkm-linux-mmc@m.gmane.org>)
	id 1ZAHqx-0006lX-6A
	for linux-mmc@vger.kernel.org; Wed, 01 Jul 2015 15:15:03 +0200
Received: from mon69-7-83-155-44-161.fbx.proxad.net ([83.155.44.161])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mmc@vger.kernel.org>; Wed, 01 Jul 2015 15:15:03 +0200
Received: from hadess by mon69-7-83-155-44-161.fbx.proxad.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mmc@vger.kernel.org>; Wed, 01 Jul 2015 15:15:03 +0200
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Hey Dong,
<snip>
> Some SDIO cards may not be able to work well without clock.

I've been needing to use this particular patch on a BayTrail tablet with a
Realtek 8723BS SDIO Wi-Fi chip to get Wi-Fi to be stable. This is using
the most recent upstream Linus kernels as well. Is there any reason this
particular patch did not get sent for merging?

Cheers

