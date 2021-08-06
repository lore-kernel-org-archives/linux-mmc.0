Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5301CC4320A
	for <linux-mmc@archiver.kernel.org>; Fri,  6 Aug 2021 11:00:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32280611BF
	for <linux-mmc@archiver.kernel.org>; Fri,  6 Aug 2021 11:00:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245068AbhHFLA1 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 6 Aug 2021 07:00:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:54254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231700AbhHFLA0 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 6 Aug 2021 07:00:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5056B61181;
        Fri,  6 Aug 2021 11:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628247610;
        bh=QpcuE6Xf3nDEPx4ouJJKA1Lw/VkQU5tSiR6QM0SDGjs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TGxIvA1adK17UB8Pb8OpkZJguwjCWUPpcMIbWJ55Hj2Gn/epB/L6shK2tky7YwjGq
         zFnBiULVRqq8kU2wGF/m7I3DIIriIh+wHmBQdfFXuwPcXyPmsvDJhKA8nCCCnVDvQ/
         EhEQ+aBwQTMgrHmLrCjEJKSbw7bQz3QCT9Q3x9C7VKPygtqaw2DZZvIgi3cZFg6iYl
         gXYbLYPL+6JsKYte4VMdPhu4btEmIPpEF0xwZRYMGk0csA6RLr3qlpJDDPB9o/dYza
         FiqJSghtKO29O4rRJtWx8y5TJUst/caNVm30P9AqnkkPqa91iiqdgY6Fgc/yZHitvw
         dzv43fOo3x37g==
Date:   Fri, 6 Aug 2021 11:59:54 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Ravikumar Kattekola <callmerk1986@gmail.com>
Cc:     Peter Geis <pgwipeout@gmail.com>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, linux-mmc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        devicetree@vger.kernel.org
Subject: Re: [BUG] mmc_regulator_set_ocr can't cope with regulator-fixed
Message-ID: <20210806105954.GV26252@sirena.org.uk>
References: <CGME20210804143357epcas1p1c67eca591d8bb557c11b8175baaa8550@epcas1p1.samsung.com>
 <CAMdYzYrx8pgeyK7u=kcopZ+Wae+fQdr_uM4AuVjqWKfZYikgcA@mail.gmail.com>
 <a9aa636e-326f-a848-dd69-41df87c013af@samsung.com>
 <CAMdYzYr9PX-9=kkCAfGe8Q0-D+gRo_qCwse8SiGVsmod7fffiA@mail.gmail.com>
 <20210805124650.GM26252@sirena.org.uk>
 <CAMdYzYpR6br7s1RD2ze92WzJjtEDZwy9qS6YhghgXy7F91keFg@mail.gmail.com>
 <20210805130842.GO26252@sirena.org.uk>
 <81006771-99bf-a5f9-4001-2cf3dc84f69d@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zvmqw4jX2vbPsMQB"
Content-Disposition: inline
In-Reply-To: <81006771-99bf-a5f9-4001-2cf3dc84f69d@gmail.com>
X-Cookie: MOUNT TAPE U1439 ON B3, NO RING
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org


--zvmqw4jX2vbPsMQB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 06, 2021 at 01:44:45PM +0530, Ravikumar Kattekola wrote:

> But, IMO mmc core should check if the voltage can be changed or not
>=20
> before trying to do regulator_set_voltage() in mmc_regulator_set_ocr().

It does exactly that in mmc_regulator_get_ocrmask().

--zvmqw4jX2vbPsMQB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmENFikACgkQJNaLcl1U
h9CJcAf/dMneLY3//GjYvaXP4Dl2LqP/fc83WqO6E4dJf+Q9FzvqkBneamuQfUYH
QpjYRGO3aTuTAdw5sLmDfsZVMgbcMkQMumppkrTKP1QVWOSwHkMCLYeb061mmp5i
Uf+FG0NaQ8HGEN/wk6ac3BuDntvg8tj5pPGu3RDU474sIzXDZb0q2FqCMyYlC3dp
78ueiE8XQg4CMrcnwVfZ5nbmB1kM1t83UmkO8N8ZDLpwAWFbtwDm5NzaPSFVhWJV
M7hYPYTOW6I+apyCHwArzVNMPMJEV8B5nQm92V6F5AQzqU0s529DKNPjv9YnSnP6
DWoW7yM+miX/2so5WGlNRcexznpX8A==
=a6Wc
-----END PGP SIGNATURE-----

--zvmqw4jX2vbPsMQB--
