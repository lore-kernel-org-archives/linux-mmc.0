Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1433C4338F
	for <linux-mmc@archiver.kernel.org>; Sat,  7 Aug 2021 14:05:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93AD261078
	for <linux-mmc@archiver.kernel.org>; Sat,  7 Aug 2021 14:05:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232317AbhHGOF7 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sat, 7 Aug 2021 10:05:59 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:18975 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232408AbhHGOFj (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Sat, 7 Aug 2021 10:05:39 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 4Ghkd15NhXzv0;
        Sat,  7 Aug 2021 16:05:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1628345111; bh=yjEq3HV2DfPBHVHG9IY7O5ScXbWFrd1ZqcOnaYQKWV0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OANZhYoXnB0pxZk0VWPlKQyIOVxzdHKgKP+u1Of1W71Wsb6O7r+LkIGqm/KGZFXDQ
         TnnYn38eLB3xzp8FiUAlbszgaoLwVuynjrjoebtUIoZ8gxzBn4In5uPLmQhlNlZTXD
         6yh+5fH8FdyQZVPLd51yePtL9ceCegcLmI0a9uTdxOnszzwfsZop+KesUdJZKboi1c
         k3VdDoeBDXsPvvqGJCPftJjhkJ/WhwQPbE7C8mLCqNC77sbBM1fRrBWuxj1VsHc8xj
         adEqcrmjAwTQCT13H1a4HCB5utjAtdGCD5MT6i33Us0HzP2l9o6Dy3Anb27wswzIoy
         bIk4PGdOQtc4g==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.103.2 at mail
Date:   Sat, 7 Aug 2021 16:05:06 +0200
From:   =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Kevin Liu <kliu5@marvell.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Suneel Garapati <suneel.garapati@xilinx.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Al Cooper <alcooperx@gmail.com>
Subject: Re: [PATCH v4 2/5] mmc: sdhci: always obey programmable clock config
 in preset value
Message-ID: <YQ6TEhMLXH/4r4BS@qmqm.qmqm.pl>
References: <cover.1627204633.git.mirq-linux@rere.qmqm.pl>
 <e65dc96eb24caf8baa5431a51fe694b969e2d51f.1627204633.git.mirq-linux@rere.qmqm.pl>
 <fe01b20d-779b-1e2c-7702-5a4702900d84@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fe01b20d-779b-1e2c-7702-5a4702900d84@intel.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, Aug 04, 2021 at 01:52:21PM +0300, Adrian Hunter wrote:
> On 25/07/21 12:20 pm, Micha³ Miros³aw wrote:
> > When host controller uses programmable clock presets but doesn't
> > advertise programmable clock support, we can only guess what frequency
> > it generates. Let's at least return correct SDHCI_PROG_CLOCK_MODE bit
> > value in this case.
> If the preset value doesn't make sense, why use it at all?

If I understand the spec correctly, when the preset value is used the
values in Clock Control register are ignored by the module and so the
module can also actually use a different clock source than the ones
available to the driver directly. So either way the driver can't be
sure of the exact frequencu used. This is a cleanup to remove a case
when the code ignores a bit's value based on other unspecified assumptions.

[...]
> > --- a/drivers/mmc/host/sdhci.c
> > +++ b/drivers/mmc/host/sdhci.c
> > @@ -1859,11 +1859,14 @@ u16 sdhci_calc_clk(struct sdhci_host *host, unsigned int clock,
> >  
> >  			pre_val = sdhci_get_preset_value(host);
> >  			div = FIELD_GET(SDHCI_PRESET_SDCLK_FREQ_MASK, pre_val);
> > -			if (host->clk_mul &&
> > -				(pre_val & SDHCI_PRESET_CLKGEN_SEL)) {
> > +			if (pre_val & SDHCI_PRESET_CLKGEN_SEL) {
> >  				clk = SDHCI_PROG_CLOCK_MODE;
> >  				real_div = div + 1;
> >  				clk_mul = host->clk_mul;
> > +				if (!clk_mul) {
> > +					/* The clock frequency is unknown. Assume undivided base. */
> > +					clk_mul = 1;
> > +				}
> >  			} else {
> >  				real_div = max_t(int, 1, div << 1);
> >  			}
