Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E2FCC4332B
	for <linux-mmc@archiver.kernel.org>; Wed,  3 Mar 2021 01:51:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3954D64E66
	for <linux-mmc@archiver.kernel.org>; Wed,  3 Mar 2021 01:51:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235477AbhCCBmS (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 2 Mar 2021 20:42:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:48692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1382694AbhCBJnj (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 2 Mar 2021 04:43:39 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4900564EF1;
        Tue,  2 Mar 2021 09:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614678177;
        bh=tCT8qwnYG4RkI1s3rfp8mZOoqjUkzArqaWnFSOdzjgY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bvi4gQkju7OOP4wP6KP74ZlBTL9XrgRf2/Vu/pIX+yBeHqPs0stx5mmow7Q3gxInG
         ey464XI516MBW8I6jT+QriI1wMjVJL9tK7g0phCOqsqq0hZuKJVdPvaGNSfNS6Um2v
         YQn+QF4b6kYIWBfIhGANLwKy493IeSj3hlxq4L09b9q7BQPNq8W50fjq+OPM9h4Yky
         g/m+wiyEJGqnkMsSN6A394g7E83Y8nHuI02n+uIEeFkaW463TYrNHoRBPMMzak6EBl
         N4AOBb98KUZvwjKAhYBr3pGiPa4vc+HmXv8d7MUrRMCZp9GJWK1yvZy/eeJIJrm9Ly
         l84DEbTvfTpBQ==
Date:   Tue, 2 Mar 2021 17:42:51 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Aisheng Dong <aisheng.dong@nxp.com>
Cc:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Mirela Rabulea <mirela.rabulea@nxp.com>,
        "dongas86@gmail.com" <dongas86@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH RESEND v4 00/18] arm64: dts: imx8: architecture
 improvement and adding imx8qm support
Message-ID: <20210302094250.GA15865@dragon>
References: <20201126105900.26658-1-aisheng.dong@nxp.com>
 <AM6PR04MB4966254794C77A1491252FF7809D9@AM6PR04MB4966.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM6PR04MB4966254794C77A1491252FF7809D9@AM6PR04MB4966.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, Feb 26, 2021 at 08:33:38AM +0000, Aisheng Dong wrote:
> Hi Shawn,
> 
> Could you please help take a look at this patch series? It's been without comments for months.
> Please let me know if you want me to resend now or I can resend later with new comments addressed if any.

I'm fine with the series, but there is a comment from Haibo on patch
#13.  And yes, you need to rebase and resend the series.

Shawn
