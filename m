Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20D21C64E8A
	for <linux-mmc@archiver.kernel.org>; Mon, 30 Nov 2020 14:30:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5318206D4
	for <linux-mmc@archiver.kernel.org>; Mon, 30 Nov 2020 14:30:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y/UtU5s9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbgK3OaH (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 30 Nov 2020 09:30:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:41590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726736AbgK3OaG (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 30 Nov 2020 09:30:06 -0500
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9AAFE20684;
        Mon, 30 Nov 2020 14:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606746566;
        bh=4Bkq+wkg1FT3dpd82K8c4Joe5aGfJRX9UwPUxafFRUQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y/UtU5s9oMuYQepwAHqZI7eQwB3OlRW3OxVd/FwIrdPOh5fUgkJrSZLxkiGxdBJiP
         zIZkOVLoHLivWXXq/0T+z0uu8EJyCHBlrVKC/sMgZ0p9lzDAt387YtviGCAuuf5OLJ
         6EghO+4+YCWIM+IP6R/beqjDNOUwIWOE8Vyc+CSQ=
Date:   Mon, 30 Nov 2020 22:29:19 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Michael Walle <michael@walle.cc>
Cc:     "Y.b. Lu" <yangbo.lu@nxp.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Leo Li <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ashish Kumar <ashish.kumar@nxp.com>
Subject: Re: [PATCH] arm64: dts: ls1028a: make the eMMC and SD card
 controllers use fixed indices
Message-ID: <20201130142918.GJ4072@dragon>
References: <VI1PR04MB6896C22F6B304F365C3BA626F8FB0@VI1PR04MB6896.eurprd04.prod.outlook.com>
 <71a86b0fbc95892f8fd240e0919e7e23@walle.cc>
 <AM7PR04MB6885CA8A965A49C456454254F8FB0@AM7PR04MB6885.eurprd04.prod.outlook.com>
 <3293d698bf26ecf08f22e7e2ffe55e74@walle.cc>
 <AM7PR04MB688518B8AE836C2CC37FED6AF8FB0@AM7PR04MB6885.eurprd04.prod.outlook.com>
 <20201124103128.zucizod344dgme4o@skbuf>
 <AM7PR04MB688567CA698191E2DB73DEF5F8FB0@AM7PR04MB6885.eurprd04.prod.outlook.com>
 <20201124112822.2ui57jmoc73top35@skbuf>
 <AM7PR04MB688524B26F99EB2C5B86ED48F8FA0@AM7PR04MB6885.eurprd04.prod.outlook.com>
 <31db48954bdf02fc0af73871043fc76b@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <31db48954bdf02fc0af73871043fc76b@walle.cc>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, Nov 25, 2020 at 09:25:23AM +0100, Michael Walle wrote:
> We are going cirlces here. I guess Shawn (as the soc maintainer) has to
> step in and decide if a common soc include should contain aliases for
> nodes which are disabled. That is what it boils down to.
> 
> All other arguments against having aliases in the common include can be
> found in this thread.
> 
> > Distros, bootloaders, and users' cases using fixed index before could
> > avoid issues, and been used as they were.
> 
> Nobody argue against having these alias. We are arguing against having
> them in the common soc include.

342ab37ecaf8 ("arm64: dts: freescale: use fixed index mmcN for
layerscape") is dropped from my tree.

Shawn
