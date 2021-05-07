Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACBD2C433B4
	for <linux-mmc@archiver.kernel.org>; Fri,  7 May 2021 06:25:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 722F3613DD
	for <linux-mmc@archiver.kernel.org>; Fri,  7 May 2021 06:25:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232012AbhEGG0a (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 7 May 2021 02:26:30 -0400
Received: from twspam01.aspeedtech.com ([211.20.114.71]:52505 "EHLO
        twspam01.aspeedtech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230380AbhEGG03 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 7 May 2021 02:26:29 -0400
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 1476CRoH036991;
        Fri, 7 May 2021 14:12:27 +0800 (GMT-8)
        (envelope-from steven_lee@aspeedtech.com)
Received: from aspeedtech.com (192.168.100.253) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 7 May
 2021 14:24:18 +0800
Date:   Fri, 7 May 2021 14:24:17 +0800
From:   Steven Lee <steven_lee@aspeedtech.com>
To:     Andrew Jeffery <andrew@aj.id.au>
CC:     Philipp Zabel <p.zabel@pengutronix.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ryan Chen <ryanchen.aspeed@gmail.com>,
        "moderated list:ASPEED SD/MMC DRIVER" <linux-aspeed@lists.ozlabs.org>,
        "moderated list:ASPEED SD/MMC DRIVER" <openbmc@lists.ozlabs.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/ASPEED MACHINE SUPPORT" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        Hongwei Zhang <Hongweiz@ami.com>,
        Ryan Chen <ryan_chen@aspeedtech.com>,
        Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
Subject: Re: [PATCH v3 5/5] mmc: sdhci-of-aspeed: Assert/Deassert reset
 signal before probing eMMC
Message-ID: <20210507062416.GD23749@aspeedtech.com>
References: <20210506100312.1638-1-steven_lee@aspeedtech.com>
 <20210506100312.1638-6-steven_lee@aspeedtech.com>
 <20210506102458.GA20777@pengutronix.de>
 <19a81e25-dfa1-4ad3-9628-19f43f4230d2@www.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <19a81e25-dfa1-4ad3-9628-19f43f4230d2@www.fastmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [192.168.100.253]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-DNSRBL: 
X-MAIL: twspam01.aspeedtech.com 1476CRoH036991
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The 05/07/2021 09:32, Andrew Jeffery wrote:
> 
> 
> On Thu, 6 May 2021, at 19:54, Philipp Zabel wrote:
> > Hi Steven,
> > 
> > On Thu, May 06, 2021 at 06:03:12PM +0800, Steven Lee wrote:
> > > +	if (info) {
> > > +		if (info->flag & PROBE_AFTER_ASSET_DEASSERT) {
> > > +			sdc->rst = devm_reset_control_get(&pdev->dev, NULL);
> > 
> > Please use devm_reset_control_get_exclusive() or
> > devm_reset_control_get_optional_exclusive().
> > 
> > > +			if (!IS_ERR(sdc->rst)) {
> > 
> > Please just return errors here instead of ignoring them.
> > The reset_control_get_optional variants return NULL in case the
> > device node doesn't contain a resets phandle, in case you really
> > consider this reset to be optional even though the flag is set?
> 
> It feels like we should get rid of the flag and leave it to the 
> devicetree.
> 

Do you mean adding a flag, for instance, "mmc-reset" in the
device tree and call of_property_read_bool() in aspeed_sdc_probe()?

> I'm still kind of surprised it's not something we want to do for the 
> 2400 and 2500 as well.
> 

Per discussion with the chip designer, AST2400 and AST2500 doesn't need
this implementation since the chip design is different to AST2600.

> Andrew
