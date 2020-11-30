Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2445CC64E90
	for <linux-mmc@archiver.kernel.org>; Mon, 30 Nov 2020 14:40:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9AF620C56
	for <linux-mmc@archiver.kernel.org>; Mon, 30 Nov 2020 14:40:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="gg/Ygpse"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726737AbgK3OkV (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 30 Nov 2020 09:40:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:49392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725859AbgK3OkU (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 30 Nov 2020 09:40:20 -0500
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D3B7420725;
        Mon, 30 Nov 2020 14:39:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606747180;
        bh=UtCy0Q6iAI4eqrqdFVaVCDH6fxHOhNgoqJvsr9jGwsM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gg/Ygpse1DxxvOKzrzCjkMF/Pgu5rh3vH7qvVS8mBomxHfCZK3OZhKvLU4LgxQBud
         RisRlDu+LAZ9haxNjtRDI0ST9xxrOMVjj6vyl17VJCsxpPrh7GM8fSCXeP4YEIoN9Z
         H6aN7ObL2gz1snrIYOScVqA1+c8o/pBKkjfv1mfw=
Date:   Mon, 30 Nov 2020 22:39:32 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Vladimir Oltean <vladimir.oltean@nxp.com>
Cc:     Li Yang <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ashish Kumar <Ashish.Kumar@nxp.com>,
        Yangbo Lu <yangbo.lu@nxp.com>, Michael Walle <michael@walle.cc>
Subject: Re: [PATCH v2] arm64: dts: ls1028a: make the eMMC and SD card
 controllers use fixed indices
Message-ID: <20201130143923.GK4072@dragon>
References: <20201119163821.980841-1-vladimir.oltean@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201119163821.980841-1-vladimir.oltean@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, Nov 19, 2020 at 06:38:21PM +0200, Vladimir Oltean wrote:
> As the boot order in the kernel continues to change, sometimes it may
> happen that the eSDHC controller mmc@2150000 (the one for eMMC) gets
> probed before the one at mmc@2140000 (for external SD cards). The effect
> is that the eMMC controller gets the /dev/mmcblk0 name, and the SD card
> gets /dev/mmcblk1.
> 
> Since the introduction of this SoC, that has never happened in practice,
> even though it was never guaranteed in theory. Setting
> "root=/dev/mmcblk0p2" in /proc/cmdline has always caused the kernel to
> use the second partition from the SD card as the rootfs.
> 
> The NXP development boards are typically shipped with either
> - LSDK, which uses "root=UUID=", or
> - OpenIL, which uses "root=/dev/mmcblkNp2"
> 
> So for OpenIL, let's preserve that old behavior by adding some aliases
> which create naming consistency (for LSDK it doesn't matter):
> - the SD card controller uses /dev/mmcblk0
> - the eMMC controller uses /dev/mmcblk1
> 
> For the Kontron SL28 boards, Michael Walle says that they are shipped
> with "root=UUID=" already, so the probing order doesn't matter, but it
> is more natural to him for /dev/mmcblk0 to be the eMMC, so let's do it
> the other way around there.
> 
> The aliases are parsed by mmc_alloc_host() in drivers/mmc/core/host.c.
> 
> Cc: Ashish Kumar <Ashish.Kumar@nxp.com>
> Cc: Yangbo Lu <yangbo.lu@nxp.com>
> Cc: Michael Walle <michael@walle.cc>
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>

Applied, thanks.
