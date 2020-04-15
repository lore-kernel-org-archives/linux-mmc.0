Return-Path: <SRS0=Q6+y=57=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39D1CC2BB85
	for <linux-mmc@archiver.kernel.org>; Wed, 15 Apr 2020 16:28:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19BA2206F9
	for <linux-mmc@archiver.kernel.org>; Wed, 15 Apr 2020 16:28:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="PAbQsHWp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1416013AbgDOQ2u (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 15 Apr 2020 12:28:50 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:12688 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1415786AbgDOQ2n (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 15 Apr 2020 12:28:43 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 492STj0yyrzCQ;
        Wed, 15 Apr 2020 18:28:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1586968121; bh=Rsasm2lhH1ZJqFeV4sB6sJTDdBy82LDRARlwkGNJNWs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PAbQsHWpbLD2Fo46RRsCnjnjAl/uJZvNeVFbsI4Dn2X8xsLouAhK+Nm42rC+0RS1l
         ryd81UC0NcB2qSWxgV7cNM+luxbeNGj2KwDhTEk13m5zrRKZ+UMOjI46fCnKyBOSdg
         4Ft6jkgljR6fRaSKTHT8lPTCkxCqZLnjDCjGtwv5kxQpQG3VtQ3UReeSbhooagqJ3t
         BNmvdT0zjOxdhqRDWj1T9QszgHlYKtDKFRsELBhHc7cdgvilIuzkHnVjBJ+XmxDql8
         NJloG6QxssZVgVZ/vCwgoxSyeloGRA5rhw7K8ot+1Gb2Jb8IAdc5xJmKzBoexgWKeR
         6EBa6MjRMorcw==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.2 at mail
Date:   Wed, 15 Apr 2020 18:28:39 +0200
From:   =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Kevin Liu <kliu5@marvell.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Suneel Garapati <suneel.garapati@xilinx.com>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/7] mmc: sdhci: fix base clock usage in preset value
Message-ID: <20200415162839.GD19897@qmqm.qmqm.pl>
References: <cover.1585827904.git.mirq-linux@rere.qmqm.pl>
 <23c3fe72b0ff0eabdbf3a45023a76da1b18a7e90.1585827904.git.mirq-linux@rere.qmqm.pl>
 <218dd61b-48cc-a161-240f-b3823e8f48cb@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <218dd61b-48cc-a161-240f-b3823e8f48cb@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, Apr 15, 2020 at 03:25:52PM +0300, Adrian Hunter wrote:
> On 2/04/20 2:54 pm, Micha³ Miros³aw wrote:
> > Fixed commit added an unnecessary read of CLOCK_CONTROL. The value read
> > is overwritten for programmable clock preset, but is carried over for
> > divided clock preset. This can confuse sdhci_enable_clk() if the register
> > has enable bits set for some reason at time time of clock calculation.
> > value to be ORed with enable flags. Remove the read.
> 
> The read is not needed, but drivers usually manage the enable bits,
> especially disabling the clock before changing the frequency.  What driver
> is it?

Hopefully no driver requires this. It's just removing a trap.

Best Regards,
Micha³ Miros³aw
