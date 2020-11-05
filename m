Return-Path: <SRS0=4qKy=EL=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFB2DC2D0A3
	for <linux-mmc@archiver.kernel.org>; Thu,  5 Nov 2020 01:45:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 423FE20782
	for <linux-mmc@archiver.kernel.org>; Thu,  5 Nov 2020 01:45:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="GyZeaKLw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731218AbgKEBpK (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 4 Nov 2020 20:45:10 -0500
Received: from rere.qmqm.pl ([91.227.64.183]:21313 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725862AbgKEBpK (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 4 Nov 2020 20:45:10 -0500
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 4CRRCz3W7Zz8p;
        Thu,  5 Nov 2020 02:45:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1604540706; bh=aBt8pSRmlerJrDlZ6D4FmnV067XCrMRhQWKKKTapOdw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GyZeaKLwRHgqCMhnbX5TNybo0ANsgA3gM3TWkXagDl6z0z7YM2HVQ82gMuN0HVIHU
         7dp8iHeNlS1eCBKDju4naxFTjiE1S2c/jSNLdP0XdCQTQpCQrpbVB68WwxmQ5A1XTf
         HnQ5aLlJ45qUjgU2s/chEVHj9kK0YGzx1K0TBruAnEEtNFfEy/FeB5JRFXlnjVynQ2
         xj8dJwAqPPCRcBHEJBgull7vLVSSBUGpiGDT2jaC/jhSLrzGCOZ+TGsXznXqjpE9Bx
         c3X8v/y5wwipUDKK02Lc2jvLGWIt7L90BZ89QWrFtHZZdjtuMz767NBYOLe9wQce1i
         Ueh8sEtC2RP0g==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.4 at mail
Date:   Thu, 5 Nov 2020 02:45:02 +0100
From:   =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Peter Chen <Peter.Chen@nxp.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lee Jones <lee.jones@linaro.org>,
        Uwe =?iso-8859-2?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        linux-samsung-soc@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-usb@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-media@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v1 00/30] Introduce core voltage scaling for NVIDIA
 Tegra20/30 SoCs
Message-ID: <20201105014502.GB17266@qmqm.qmqm.pl>
References: <20201104234427.26477-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201104234427.26477-1-digetx@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, Nov 05, 2020 at 02:43:57AM +0300, Dmitry Osipenko wrote:
> Introduce core voltage scaling for NVIDIA Tegra20/30 SoCs, which reduces
> power consumption and heating of the Tegra chips. Tegra SoC has multiple
> hardware units which belong to a core power domain of the SoC and share
> the core voltage. The voltage must be selected in accordance to a minimum
> requirement of every core hardware unit.
[...]

Just looked briefly through the series - it looks like there is a lot of
code duplication in *_init_opp_table() functions. Could this be made
more generic / data-driven?

Best Regards
Micha³ Miros³aw
