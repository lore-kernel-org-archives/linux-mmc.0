Return-Path: <SRS0=6pTx=6Q=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7251C3A5A9
	for <linux-mmc@archiver.kernel.org>; Sat,  2 May 2020 15:39:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADC8C21973
	for <linux-mmc@archiver.kernel.org>; Sat,  2 May 2020 15:39:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728311AbgEBPjV (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sat, 2 May 2020 11:39:21 -0400
Received: from smtprelay0132.hostedemail.com ([216.40.44.132]:49960 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728222AbgEBPjU (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 2 May 2020 11:39:20 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id BB9BE100E7B42;
        Sat,  2 May 2020 15:39:19 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: drain55_8b6d9ac2c1d13
X-Filterd-Recvd-Size: 1167
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf08.hostedemail.com (Postfix) with ESMTPA;
        Sat,  2 May 2020 15:39:18 +0000 (UTC)
Message-ID: <7298908d2397b2e753b844b690ef522c728d90a6.camel@perches.com>
Subject: Re: [PATCH] mmc: sdhci-esdhc: update contact email
From:   Joe Perches <joe@perches.com>
To:     Wolfram Sang <wsa@kernel.org>, linux-kernel@vger.kernel.org
Cc:     kernel@pengutronix.de, Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>, linux-mmc@vger.kernel.org
Date:   Sat, 02 May 2020 08:39:16 -0700
In-Reply-To: <20200502142840.19418-1-wsa@kernel.org>
References: <20200502142840.19418-1-wsa@kernel.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Sat, 2020-05-02 at 16:28 +0200, Wolfram Sang wrote:
> The 'pengutronix' address is defunct for years. Use the proper contact
> address.

Maybe add a .mailmap entry?


