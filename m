From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v7 0/5] Add DT support for davinci_mmc driver
Date: Thu, 28 Mar 2013 15:28:37 +0000
Message-ID: <201303281528.37228.arnd@arndb.de>
References: <1364476211-14322-1-git-send-email-prakash.pm@ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:57372 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755204Ab3C1P2r (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 28 Mar 2013 11:28:47 -0400
In-Reply-To: <1364476211-14322-1-git-send-email-prakash.pm@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Manjunathappa, Prakash" <prakash.pm@ti.com>
Cc: davinci-linux-open-source@linux.davincidsp.com, linux-mmc@vger.kernel.org, cjb@laptop.org, nsekhar@ti.com, grant.likely@secretlab.ca, rob.herring@calxeda.com, rob@landley.net, linux@arm.linux.org.uk, hs@denx.de, devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, mark.rutland@arm.com

On Thursday 28 March 2013, Manjunathappa, Prakash wrote:
> 
> Patch set adds DT support for davinci_mmc driver and is
> verified on da850-evm without card_detect/write_protect and
> EDMA support. Also takecare to derive controller IP version from
> platform_device_id table, remove version specification in pdata.
> 
> Applies on top of below patch series under community review:
> "Enable SPI flash support on da850-evm DT kernel"
> http://www.spinics.net/lists/arm-kernel/msg231546.html
> 
> This series is reviewed and tested by Sekhar Nori, with and
> without DT on da850 EVM.

Very nice!

Acked-by: Arnd Bergmann <arnd@arndb.de>

> Since v6:
> Add DMA handling capability, but not tested.

What I was asking for was actually just adding the description to the
binding documentation, not also to the code, but the code does look
correct to me, so this is fine, too.

	Arnd
