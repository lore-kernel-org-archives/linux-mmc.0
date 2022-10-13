Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 832FAC43217
	for <linux-mmc@archiver.kernel.org>; Thu, 13 Oct 2022 09:45:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbiJMJo7 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 13 Oct 2022 05:44:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbiJMJo6 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 13 Oct 2022 05:44:58 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 235B11DA67
        for <linux-mmc@vger.kernel.org>; Thu, 13 Oct 2022 02:44:54 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1oiulo-00009M-9R; Thu, 13 Oct 2022 11:44:52 +0200
Received: from sha by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1oiuln-0005FU-Nl; Thu, 13 Oct 2022 11:44:51 +0200
Date:   Thu, 13 Oct 2022 11:44:51 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     linux-mmc@vger.kernel.org
Cc:     Haibo Chen <haibo.chen@nxp.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>
Subject: Re: [PATCH] mmc: sdhci-esdhc-imx: Propagate ESDHC_FLAG_HS400* only
 on 8bit bus
Message-ID: <20221013094451.GH6702@pengutronix.de>
References: <20221013093248.2220802-1-s.hauer@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221013093248.2220802-1-s.hauer@pengutronix.de>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-mmc@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, Oct 13, 2022 at 11:32:48AM +0200, Sascha Hauer wrote:
> The core issues the warning "drop HS400 support since no 8-bit bus" when
> one of the ESDHC_FLAG_HS400* flags is set on a non 8bit capable host. To
> avoid this warning set these flags only on hosts that actually can do
> 8bit, i.e. have bus-width = <8> set in the device tree.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)

Forgot to pass --notes to git send email, so adding this here:

An alternative approach would be to just lower the warning message
to debug level. In the end it's nice from the core to take the load
from the drivers, if only the core wouldn't complain about it.

Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
