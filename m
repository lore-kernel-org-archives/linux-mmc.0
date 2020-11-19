Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2385DC63697
	for <linux-mmc@archiver.kernel.org>; Thu, 19 Nov 2020 18:13:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B360A2078E
	for <linux-mmc@archiver.kernel.org>; Thu, 19 Nov 2020 18:13:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=walle.cc header.i=@walle.cc header.b="N0g9lCum"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728983AbgKSSMl (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 19 Nov 2020 13:12:41 -0500
Received: from ssl.serverraum.org ([176.9.125.105]:45795 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727117AbgKSSMl (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 19 Nov 2020 13:12:41 -0500
X-Greylist: delayed 7433 seconds by postgrey-1.27 at vger.kernel.org; Thu, 19 Nov 2020 13:12:40 EST
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 0F96422EE4;
        Thu, 19 Nov 2020 19:12:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1605809558;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vC7HVwjANH5oc4E2w8W2S6yvBbfs+xSzba3U+jaONBg=;
        b=N0g9lCumldkfoC6XZ82nBq+ZP+XoHM2K2t5RBTkSUZAv2ll9vNFdufhH4xFSsIXnNfCYj5
        NxYAJpcyYaGN69MOHWOMHellRWDQrKwxSy42nRljHrBq6MOE0UhOkq716mgJTfB4Nt6Qdi
        3rRweMg8Z68m5MeavEODNYPdoY0dowI=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 19 Nov 2020 19:12:37 +0100
From:   Michael Walle <michael@walle.cc>
To:     Vladimir Oltean <vladimir.oltean@nxp.com>
Cc:     Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ashish Kumar <Ashish.Kumar@nxp.com>,
        Yangbo Lu <yangbo.lu@nxp.com>
Subject: Re: [PATCH v2] arm64: dts: ls1028a: make the eMMC and SD card
 controllers use fixed indices
In-Reply-To: <20201119163821.980841-1-vladimir.oltean@nxp.com>
References: <20201119163821.980841-1-vladimir.oltean@nxp.com>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <31099f0d12b87ad330a59c84f0fa9b42@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Am 2020-11-19 17:38, schrieb Vladimir Oltean:
> As the boot order in the kernel continues to change, sometimes it may
> happen that the eSDHC controller mmc@2150000 (the one for eMMC) gets
> probed before the one at mmc@2140000 (for external SD cards). The 
> effect
> is that the eMMC controller gets the /dev/mmcblk0 name, and the SD card
> gets /dev/mmcblk1.
> 
> Since the introduction of this SoC, that has never happened in 
> practice,
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

Acked-by: Michael Walle <michael@walle.cc> [for the sl28 boards]

-michael
