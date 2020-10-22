Return-Path: <SRS0=TbaS=D5=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46D80C4363A
	for <linux-mmc@archiver.kernel.org>; Thu, 22 Oct 2020 09:09:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D9612415A
	for <linux-mmc@archiver.kernel.org>; Thu, 22 Oct 2020 09:09:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2895780AbgJVJJs (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 22 Oct 2020 05:09:48 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:33307 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2502677AbgJVJJp (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 22 Oct 2020 05:09:45 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id F3C555C0041;
        Thu, 22 Oct 2020 05:09:43 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 22 Oct 2020 05:09:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=8jfWJXL45oSWtMhGajV9DknwPlR
        xYHd0bFTEduuTNKI=; b=XUY1FbveFQib6ceRvyAzzgtqr5I73FSTh7tJCiZBi8m
        xqvHjXKI3K+z2kGeWj/oPyNeIO6FDAgV0LiVScQIgbbTignyuuGk4dNKByv5VFt3
        3jJSiYGv10CAb45qOacCxBiPrrKuFCH0ruzfy2EZRi2ZcJmTsWgVp+lWTm4OV4f+
        TG2QXZJITd7EmxSX6NNsOMFZZ/gr1JbBW0pSogfJQEI2oCqxWqh1BfM0US4+DlkA
        MzIg33UuG7lLlD7L/3az9kYt48vheCZTwXeV9Byq9IFUMLPo0QaWmFxtOoqKmU6k
        PWig3J5a3eC0ZzOzpLoZD3XXiAIWWhOJvwHI5nOVo3A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=8jfWJX
        L45oSWtMhGajV9DknwPlRxYHd0bFTEduuTNKI=; b=g2nDceojZSw/wmbH2cIdpR
        IkDtS24LGsjVljv1/tr24XZmxEdWpi9EpvnzaqTV+MIXraGJ7mN2YosGhmwDp5v6
        X98lrcMVdGBqBdHchIjw7tgpn8mpxldNdsYZ+VMWm9FVW0nX+TlB+JkctwM5wPZ+
        Sk8rtt8vUNqDNQ9k99rCUwclVLkwf758S1NSOetEX+birDCD13iAl7IJoUhQAO+4
        5QKPEdrNk36TNvjYvt3MhDMzBNv6sjDFlFo2TLbY3RfeQKJcCOdXHIRKJ+Q5I19X
        /v0iY+LG6+h6Y3/P5rNMPwnt+zgqkKUwGiaBZCDaEBFFeqxsabk1620gkbH0n/iQ
        ==
X-ME-Sender: <xms:VEyRX8hqH2squY5OMYFhLXUA1BRmPpDAxsnNRyzMIGInazf4SUFjtg>
    <xme:VEyRX1BDpv7k8es_-svqbwuQM-akG2d008olJaKi6mNRRFApD758Wxp9393rkrC6j
    nCnEeL8TE5QmeHY154>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrjeejgdduvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtth
    gvrhhnpeevgeduteektefhtefggfdtkeekgfehhffffeegudelheegheeiueevfeegvdei
    geenucffohhmrghinhepghhithhhuhgsrdgtohhmnecukfhppeeltddrkeelrdeikedrje
    einecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhgr
    gihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:VEyRX0HhZDKRipVbcltBBb2AOdhbY44ceBVYaolhwDEktOXjJMRY_g>
    <xmx:VEyRX9S6I2K1QT7M5FBCXEulpXiU3n41PdfPxnuWBdgAFAlgyj0npQ>
    <xmx:VEyRX5zIxDJX3hadaVRDjGA8C_dq0bc2QgFRDei2wzAuCtqDPD-2gg>
    <xmx:V0yRXx9uaATy4v8z6yt8fNoT3ebqOaAwW6hR3UJsH8AuoFpbxRBIVQ>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 90BF43280059;
        Thu, 22 Oct 2020 05:09:40 -0400 (EDT)
Date:   Thu, 22 Oct 2020 11:09:38 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Philip Rinn <rinni@inventati.org>
Cc:     ulf.hansson@linaro.org, wens@csie.org, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH] Disable HS-DDR mode for Olimex A64-OLinuXino variants
 with eMMC
Message-ID: <20201022090938.ukfn52hfil6xi6us@gilmour.lan>
References: <0d590f91-5d7a-697a-5644-710d14e3ea75@inventati.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="34niqqyzl3favo4v"
Content-Disposition: inline
In-Reply-To: <0d590f91-5d7a-697a-5644-710d14e3ea75@inventati.org>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org


--34niqqyzl3favo4v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Oct 22, 2020 at 12:10:45AM +0200, Philip Rinn wrote:
> Hi,

The commit log is going to end up in the git history, so the hi should
be dropped :)

> the Olimex A64-OLinuXino board comes in various variants, three with eMMC.
> While MMC HS-DDR mode works fine on one of them (A64-OLinuXino-1Ge4GW) it
> doesn't work on the A64-OLinuXino-2Ge8G-IND variant (I don't have the
> third variant so I can't check if it works there).

Why is it not working? That flag is just setting what the controller is
capable of, if the eMMC wasn't supporting that mode it wouldn't even
try.

> Disabling MMC HS-DDR mode fixes the problem. This is also what Olimex does
> for their kernel:
>=20
> https://github.com/OLIMEX/linux-olimex/commit/eef0e814e74f.patch

Again, there's no context there

Maxime

--34niqqyzl3favo4v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX5FMUgAKCRDj7w1vZxhR
xWdrAQDPVErjtYzTLW27+SbSgqaHrIJRwyfIOhUk6/RThcMZUwD+Lq/s3n10EJfj
NIxNjNxpue/aSKjK4r+mSNh8ydQOEwA=
=/ovm
-----END PGP SIGNATURE-----

--34niqqyzl3favo4v--
