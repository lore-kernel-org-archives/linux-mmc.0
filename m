Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3E1DC56202
	for <linux-mmc@archiver.kernel.org>; Mon, 23 Nov 2020 11:09:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2217D2100A
	for <linux-mmc@archiver.kernel.org>; Mon, 23 Nov 2020 11:09:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=walle.cc header.i=@walle.cc header.b="Ac+d/i/k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727210AbgKWLJb (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 23 Nov 2020 06:09:31 -0500
Received: from ssl.serverraum.org ([176.9.125.105]:42641 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725806AbgKWLJa (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 23 Nov 2020 06:09:30 -0500
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 1437C22F99;
        Mon, 23 Nov 2020 12:09:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1606129768;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2Ueqku/JVNSF/2s8zRFoeRCB+yxaWGTNZHlXD0vl0yg=;
        b=Ac+d/i/ksWz/18OB3eyODgr1vHRZdVbui2nzOE7zfBcQyBcwgUh4bJjYQdBBug4O5y2WI4
        C/HN77/y/dXOfoV8jAjSguqTYpDK6Jey2CBfED0xidqQSeAcqvpJmzW2pnxUZGNB+YljqD
        WFImC6lopFoAqkVwrZ329l/F7M6Melg=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 23 Nov 2020 12:09:23 +0100
From:   Michael Walle <michael@walle.cc>
To:     Vladimir Oltean <vladimir.oltean@nxp.com>
Cc:     "Y.b. Lu" <yangbo.lu@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
        Leo Li <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ashish Kumar <ashish.kumar@nxp.com>
Subject: Re: [PATCH] arm64: dts: ls1028a: make the eMMC and SD card
 controllers use fixed indices
In-Reply-To: <20201120093015.duel3yx63cbya77w@skbuf>
References: <20201119155025.965941-1-vladimir.oltean@nxp.com>
 <AM7PR04MB688536E10A0B35D75A9F8F34F8FF0@AM7PR04MB6885.eurprd04.prod.outlook.com>
 <20201120093015.duel3yx63cbya77w@skbuf>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <47517939c251b1bc2f04ee1962caddf4@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Am 2020-11-20 10:30, schrieb Vladimir Oltean:
> On Fri, Nov 20, 2020 at 02:04:02AM +0000, Y.b. Lu wrote:
>> Hi Vladimir,
>> 
>> I have already upstreamed a patch for all affected layerscape boards.
>> https://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git/commit/?h=imx/dt64&id=342ab37ecaf8c1b10dd3ca9a1271db29a6af0705
>> 
>> Please check whether it works for you.
> 
> Thanks, one can tell that I haven't done my due diligence of checking
> Shawn's tree first. I'll cherry-pick that patch and carry on with my
> work.
> 
> However, the fact still remains that Michael has expressed his opinion
> regarding mmcblk0 vs mmcblk1. Do you think that we could make the
> aliases a per-board option instead of per-SoC? Consider that there 
> might
> even be boards that only use SD card. It would be strange for the block
> device in that case to be called /dev/mmcblk1.

Yangbo, any news on this? I'd like to have this resorted out before it 
is
set in stone for 5.10.

-- 
-michael
