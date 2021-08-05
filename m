Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4074EC432BE
	for <linux-mmc@archiver.kernel.org>; Thu,  5 Aug 2021 12:47:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F7BA601FC
	for <linux-mmc@archiver.kernel.org>; Thu,  5 Aug 2021 12:47:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241468AbhHEMrV (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 5 Aug 2021 08:47:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:55470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241459AbhHEMrU (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 5 Aug 2021 08:47:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A719C60E97;
        Thu,  5 Aug 2021 12:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628167626;
        bh=kMQY6aXotHYC4p1x2ZCwkER9VrbqS7BOEPHl0qOdbl0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fm3BZjczDQ2+LdzJrxVmZJRipDr45xGLn57fBW2eTDIubwQeumuffrzsf7geb1j4R
         XXkaLI7Nm5IrK4oVJNRHaE7F5JS3s6UjGdj3Tc4Z7G6Xp7hSrkdaEXZfTC2ivzwoov
         zpuxPEyjM5UjKKW9YYL6VsbKFrYteyQk0Vv5+bGq4/twGtG9Jgt7PnMAfqqG/AsAOi
         w4j5Vhq/kAYiKMEOsV6p7Z9Wi29twv2wMRKhtkt8vRnJvMT4Wjk9Ur0uWuCMQsefoJ
         JlQ1S2w3KUKxgxy9hdc+BanlCLF0m0k/bE22iZhGENI/ofXE395k35APuOGCZktaWd
         +YeFftygtS5QQ==
Date:   Thu, 5 Aug 2021 13:46:50 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Peter Geis <pgwipeout@gmail.com>
Cc:     Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, linux-mmc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        devicetree@vger.kernel.org
Subject: Re: [BUG] mmc_regulator_set_ocr can't cope with regulator-fixed
Message-ID: <20210805124650.GM26252@sirena.org.uk>
References: <CGME20210804143357epcas1p1c67eca591d8bb557c11b8175baaa8550@epcas1p1.samsung.com>
 <CAMdYzYrx8pgeyK7u=kcopZ+Wae+fQdr_uM4AuVjqWKfZYikgcA@mail.gmail.com>
 <a9aa636e-326f-a848-dd69-41df87c013af@samsung.com>
 <CAMdYzYr9PX-9=kkCAfGe8Q0-D+gRo_qCwse8SiGVsmod7fffiA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="+2GlJm56SCtLHYlr"
Content-Disposition: inline
In-Reply-To: <CAMdYzYr9PX-9=kkCAfGe8Q0-D+gRo_qCwse8SiGVsmod7fffiA@mail.gmail.com>
X-Cookie: MOUNT TAPE U1439 ON B3, NO RING
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org


--+2GlJm56SCtLHYlr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 05, 2021 at 07:38:06AM -0400, Peter Geis wrote:

> Also, I've got a possible fix to the dw-mmc issue, the following patch
> changes the behavior to only enable a fixed regulator, not try to set
> the voltage. It's a split between the behavior when vmmc isn't defined
> at all and when its a variable regulator:

One thing to watch out for with this approach is if there's things that
really need a specific voltage to be set then you'll have to stop those
things happening if you've got a voltage regulator that can't deliver a
voltage in the required range.  I don't know if this affects MMC or not,
if it's just a case of being less efficient it's not such an issue.

> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index d333130d1531..b30102980261 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -1446,11 +1446,13 @@ static void dw_mci_set_ios(struct mmc_host
> *mmc, struct mmc_ios *ios)
>   switch (ios->power_mode) {
>   case MMC_POWER_UP:
>   if (!IS_ERR(mmc->supply.vmmc)) {
> - ret = mmc_regulator_set_ocr(mmc, mmc->supply.vmmc,

This patch is very whitespace damaged FWIW.

--+2GlJm56SCtLHYlr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmEL3bkACgkQJNaLcl1U
h9AITwf+MrB+PWNVhpqW56tmJ9SGz8jrEIwUWscQhB2kdQKUFfRkN5wgnUliCrN6
z1aJqb2h4eiZWj5sVGXyQqMuFHRVh7+AIpXhkxPdBf7bn/CTJCgG13eOOP7FELnh
A3Ax+i9Y2Hhz8GxVFlokMxrCZo20pS+Z4qCTrENO0rzSppWlogkS2CBFNDUGndNs
lj8K9wLpqFSJFRPUqRdyohpR44cPpsB7hOfeJOh9Le+BdGfqMb2Zkhvwu++oP0is
NTe/bxNPjb0ta+njFHhF8UOyaBuTa7DeH/9snbYazu70pOZa2bZKiIcMr18qZ0O9
Edd5L///Ydo5pXWt+3UokRFB2cwkbw==
=02YF
-----END PGP SIGNATURE-----

--+2GlJm56SCtLHYlr--
