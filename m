Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D34EC56201
	for <linux-mmc@archiver.kernel.org>; Thu, 19 Nov 2020 16:09:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10DE922256
	for <linux-mmc@archiver.kernel.org>; Thu, 19 Nov 2020 16:09:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=walle.cc header.i=@walle.cc header.b="SViSWSch"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727937AbgKSQI5 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 19 Nov 2020 11:08:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727795AbgKSQIx (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 19 Nov 2020 11:08:53 -0500
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9C2AC0613CF
        for <linux-mmc@vger.kernel.org>; Thu, 19 Nov 2020 08:08:52 -0800 (PST)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 3F27022EE4;
        Thu, 19 Nov 2020 17:08:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1605802119;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3mopfuXNiEIeUiZMJSAjJrgfgPbC7lFyWarEiZjQiYk=;
        b=SViSWSchFdgDX2H3c8i3mMIo6fzEH5VaQgqRkJB8rP776hyuv1j4hY+ECH51ZbBKlQJaVR
        j51K7P/8Nsp6jg8z7wP9pOHaKFPQrhuIOILUgDXDcAHdqH+676+m3GJ5lDTgfpf702Uq0y
        QwgqA2KkE21SBw+yCwTa28CkETDa8rc=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 19 Nov 2020 17:08:39 +0100
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
Subject: Re: [PATCH] arm64: dts: ls1028a: make the eMMC and SD card
 controllers use fixed indices
In-Reply-To: <20201119155025.965941-1-vladimir.oltean@nxp.com>
References: <20201119155025.965941-1-vladimir.oltean@nxp.com>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <e1926b2c2cccfe19f66562b50a686088@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Vladimir,

Am 2020-11-19 16:50, schrieb Vladimir Oltean:
> As the boot order in the kernel continues to change, sometimes it may
> happen that the eSDHC controller mmc@2150000 (the one for eMMC) gets
> probed before the one at mmc@2140000 (for external SD cards). The 
> effect
> is that the eMMC controller gets the /dev/mmcblk0 name, and the SD card
> gets /dev/mmcblk1.

Thanks for taking care.

> Since the introduction of this SoC, that has never happened in 
> practice,
> even though it was never guaranteed in theory. Setting
> "root=/dev/mmcblk0p2" in /proc/cmdline has always caused the kernel to
> use the second partition from the SD card as the rootfs.
> 
> Preserve that old behavior by adding some aliases which create naming
> consistency:
> - the SD card controller uses /dev/mmcblk0
> - the eMMC controller uses /dev/mmcblk1

Could you change this behaviour for the sl28 board(s)? I've always
found it counter-intuitive to have mmcblk1 being the eMMC on a board
which always have the eMMC populated. All our images uses UUIDs for
the "root=" parameter and, technically, the order wasn't specified yet.

So I'd like to have the eMMC as /dev/mmcblk0 and the SD card as
/dev/mmcblk1.

-michael
