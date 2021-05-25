Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F10C8C4707F
	for <linux-mmc@archiver.kernel.org>; Tue, 25 May 2021 09:48:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1CD0613E6
	for <linux-mmc@archiver.kernel.org>; Tue, 25 May 2021 09:48:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232723AbhEYJuA (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 25 May 2021 05:50:00 -0400
Received: from twspam01.aspeedtech.com ([211.20.114.71]:48537 "EHLO
        twspam01.aspeedtech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232705AbhEYJtz (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 25 May 2021 05:49:55 -0400
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 14P9ZLSX049551;
        Tue, 25 May 2021 17:35:21 +0800 (GMT-8)
        (envelope-from steven_lee@aspeedtech.com)
Received: from aspeedtech.com (192.168.100.253) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 25 May
 2021 17:48:19 +0800
Date:   Tue, 25 May 2021 17:48:16 +0800
From:   Steven Lee <steven_lee@aspeedtech.com>
To:     Joel Stanley <joel@jms.id.au>
CC:     Andrew Jeffery <andrew@aj.id.au>, Rob Herring <robh+dt@kernel.org>,
        "Adrian Hunter" <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/ASPEED MACHINE SUPPORT" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/ASPEED MACHINE SUPPORT" 
        <linux-aspeed@lists.ozlabs.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        "moderated list:ASPEED SD/MMC DRIVER" <openbmc@lists.ozlabs.org>,
        "Hongwei Zhang" <Hongweiz@ami.com>,
        Ryan Chen <ryan_chen@aspeedtech.com>,
        Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
Subject: Re: [PATCH v5 0/4] mmc: sdhci-of-aspeed: Support toggling SD bus
 signal
Message-ID: <20210525094815.GA8757@aspeedtech.com>
References: <20210524073308.9328-1-steven_lee@aspeedtech.com>
 <CACPK8XcfvUQD5xwb=2Va5Sr+bmaWfJMZkh61HK1=J1qLYc84zQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <CACPK8XcfvUQD5xwb=2Va5Sr+bmaWfJMZkh61HK1=J1qLYc84zQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [192.168.100.253]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-DNSRBL: 
X-MAIL: twspam01.aspeedtech.com 14P9ZLSX049551
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The 05/25/2021 15:55, Joel Stanley wrote:
> On Mon, 24 May 2021 at 07:33, Steven Lee <steven_lee@aspeedtech.com> wrote:
> >
> > AST2600-A2 EVB has the reference design for enabling SD bus
> > power and toggling SD bus signal voltage between 3.3v and 1.8v by
> > GPIO regulators.
> > This patch series adds sdhci node and gpio regulators in a new dts file
> > for AST2600-A2 EVB.
> > The description of the reference design of AST2600-A2 EVB is added
> > in the new dts file.
> >
> > This patch also include a helper for updating AST2600 sdhci capability
> > registers.
> 
> The device trees look good:
> 
> Reviewed-by: Joel Stanley <joel@jms.id.au>
> 
> I've applied patches 1-3 to the aspeed tree for v5.14. I made a little
> fix to patch 3 as it needed to add the new device tree to the
> makefile.
> 

Thanks!

> When I was testing on my A2 EVB I saw this:
> 
> [    1.436219] sdhci-aspeed 1e750100.sdhci: Requested out of range
> phase tap 192 for 9 degrees of phase compensation at 1562500Hz,
> clamping to tap 15
> [    1.450913] sdhci-aspeed 1e750100.sdhci: Requested out of range
> phase tap 963 for 45 degrees of phase compensation at 1562500Hz,
> clamping to tap 15
> 
> Do you know what is happening there?
> 

Per MMC spec, eMMC bus speed is set as legacy mode(0~26MHz) at startup of
eMMC initializtion flow. Clock phase calculation is triggered in set_clock()
and it calculates taps based on phase_deg(<9>, <225>) in the dts file and the
current speed(1562500Hz), which causes the warning message you mentioned.
As the phase_deg in the dts file should be calculated with 100MHz.

https://lkml.org/lkml/2021/5/24/95

But after some initialization flow, eMMC bus speed will be set to
correct speed(100MHz).
Clock phase calculation will be triggered again to get correct taps.

> Cheers,
> 
> Joel
