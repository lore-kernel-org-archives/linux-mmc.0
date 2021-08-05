Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E53C5C4338F
	for <linux-mmc@archiver.kernel.org>; Thu,  5 Aug 2021 13:09:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDAF860F42
	for <linux-mmc@archiver.kernel.org>; Thu,  5 Aug 2021 13:09:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241628AbhHENJO (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 5 Aug 2021 09:09:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:58832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240653AbhHENJM (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 5 Aug 2021 09:09:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 912C360F10;
        Thu,  5 Aug 2021 13:08:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628168938;
        bh=P4Z/HQKg5fpKU66bAy6OrZrqvVhFeTR4pYC3Wd1O1NU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W8DEzkZNl+Zrsm/7vGFU+rKFhA9TTCLvPi9qjuhMtSDbHelPRNZr8OZ3NUb1OKKiI
         uV22gyaX7Th7JuBuOpzLAovjA44f0Yq7oR02ZNf7DM1LcyTuYONVouYnTiV9UPVAbD
         COdEtFLfwLx81tfbTGC3zV3ZxMDD+zEhuuYPZoNo/b8OdG+uPPK6C5SM7XZanMbpNt
         Ast2P9eo9LmgpBMP6CdxC9HmAG4QLnlfAdDlILZqTcyputfnN2SHh50sO3uGWetm3n
         hDKZbJZmVbL3eqNIAlsIobfAaiAveA9wU+UYxpECpMtAcYLkQWOIdgkSIS2/f8cKgy
         RRptQnZpHqnqQ==
Date:   Thu, 5 Aug 2021 14:08:42 +0100
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
Message-ID: <20210805130842.GO26252@sirena.org.uk>
References: <CGME20210804143357epcas1p1c67eca591d8bb557c11b8175baaa8550@epcas1p1.samsung.com>
 <CAMdYzYrx8pgeyK7u=kcopZ+Wae+fQdr_uM4AuVjqWKfZYikgcA@mail.gmail.com>
 <a9aa636e-326f-a848-dd69-41df87c013af@samsung.com>
 <CAMdYzYr9PX-9=kkCAfGe8Q0-D+gRo_qCwse8SiGVsmod7fffiA@mail.gmail.com>
 <20210805124650.GM26252@sirena.org.uk>
 <CAMdYzYpR6br7s1RD2ze92WzJjtEDZwy9qS6YhghgXy7F91keFg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="eHmdSDY+kY2au76U"
Content-Disposition: inline
In-Reply-To: <CAMdYzYpR6br7s1RD2ze92WzJjtEDZwy9qS6YhghgXy7F91keFg@mail.gmail.com>
X-Cookie: MOUNT TAPE U1439 ON B3, NO RING
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org


--eHmdSDY+kY2au76U
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 05, 2021 at 08:58:58AM -0400, Peter Geis wrote:
> On Thu, Aug 5, 2021 at 8:47 AM Mark Brown <broonie@kernel.org> wrote:

> > One thing to watch out for with this approach is if there's things that
> > really need a specific voltage to be set then you'll have to stop those
> > things happening if you've got a voltage regulator that can't deliver a
> > voltage in the required range.  I don't know if this affects MMC or not,
> > if it's just a case of being less efficient it's not such an issue.

> Yeah, but if this is a fixed regulator and it's a problem, then the
> hardware is screwed anyways.

Well, the fact that the voltage is being changed at runtime indicates
that we're changing something from whatever was in the fixed setup - it
can sometimes be that we don't have access to some higher performance or
lower power features for example.  That's not ideal but works perfectly
safely.

--eHmdSDY+kY2au76U
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmEL4tkACgkQJNaLcl1U
h9Dbbgf/YunQb1UPyQ5czRyhW+fldplspxf07rcnSp/hwj2hV4FLvf9wzXk5thAp
vDMEhO16kYSmm7sgZgnwXrk6BdBcyznZReLOKvKRi4tL+ce9niWYlTaucGhJDdN+
tEFhB2q2wQx69UpWm0HzCkT2aZG1bi40plL7Y51UQGw5VmsbhigEwiLLQFBHsL6m
yn5/AksIgxD2zxHPx0N2CW/7CxzlLixhJYxNoZoCuWYR1YptFlOzqlL8NyftQ/kH
bi27Ep0qc3quoiIULpybE66b/0r6xFvNqWQ393La436az1KM5p10R5bNkT44bOWw
scag4eXxevkgaU0RgEUI0hQHq5zuHw==
=+zJO
-----END PGP SIGNATURE-----

--eHmdSDY+kY2au76U--
