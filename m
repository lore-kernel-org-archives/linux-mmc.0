Return-Path: <SRS0=TbaS=D5=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90223C4363A
	for <linux-mmc@archiver.kernel.org>; Thu, 22 Oct 2020 09:13:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38918223FB
	for <linux-mmc@archiver.kernel.org>; Thu, 22 Oct 2020 09:13:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2509411AbgJVJNk (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 22 Oct 2020 05:13:40 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:58847 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2509404AbgJVJNk (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 22 Oct 2020 05:13:40 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 62CC25C0102;
        Thu, 22 Oct 2020 05:13:39 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 22 Oct 2020 05:13:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=k1kXJts1XVZPl4f0UrQscBYspND
        kM06UcM5jB0NwT0o=; b=m93cgHaGcNC1DOVsz3Z2ILvco4KxzKB4HCgh4DNsS3+
        LqqzjNkfS9+FmNeB4PSPfqXrDAenqM39Cz6UWG0SLmEGaqBqCaSaYSSc6CB+xqPT
        LTOPFlgb8BrIyRM3NZlQg0LDtzmiemWkZFTaYmzXo9N+GbW2O80a3wWEnfiHYq6o
        9/ktbUDplohbkQ1qjqZ+s/ezpDQrkLR18U9oh4G13cotxxz7JBHyFjMdIkqgmrr7
        /tCE5edxYW12U18HSZHoS62OVizdDX/cU4c0LDyX5VLj+pN7C9Xdeyd9NU2Alk65
        8Ln9dkyMWd9TWxOiVKGIbHXaMxJ5tV2k0zKCMSb4bbQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=k1kXJt
        s1XVZPl4f0UrQscBYspNDkM06UcM5jB0NwT0o=; b=A1tWVkswb81KbcQDSFTpDG
        rSarZhOZV1rHnoNpvW9GwUdGfnfWXbM2iNiS5C8C88rRkUGLZeRHumaCkGRxHj/2
        gVFw67035hLUtylk3s3HBHnYSLcEYjJMT2ZBue9DrB6K2so95striYvjfXtKQPCn
        9CtIc1EZ1Zej3HzNYornuW5QygEWaeXDGT7C50RrIK8i/ZgWePD/5Mi90cXejuys
        cvl6zKX3891klevJ4d6Fooj+MA1IuTlqVEB2s8WitQD3AT91oNyTCUqClktlJGWA
        cJFcG34PkYSuqgvO8wZdK1ESqz+Vn2m4JRBYKN0iP8MJPdJuY4B9qdsiXrnqDLnA
        ==
X-ME-Sender: <xms:Qk2RX_WWPsgz1BEENDm59YjZ5dpM-3-4j_bizvsaGmzA4TgIjXxSpQ>
    <xme:Qk2RX3mAGGZGONdCMJH46qXbICF_E73OycZcZ5VSFmHSVoO07dWEvUx2dfGSCtR95
    1pX_A_6upoS1WH8u2k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrjeejgddufecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtudenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtth
    gvrhhnpeegffejfeetkefhffehfedugfdtgeejuddtudfhieevieeigeeujeevleekhfej
    geenucffohhmrghinhepshhpihhnihgtshdrnhgvthenucfkphepledtrdekledrieekrd
    ejieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehm
    rgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:Qk2RX7bBx9CsVAiOj1CR0fcFCokJW8cln4bLMMJbgJKtfP891VvUhQ>
    <xmx:Qk2RX6VqwgnPNEz9SXG9Lb1ZveEtKvOGbBGcSTnYF9vyPj0__piSbQ>
    <xmx:Qk2RX5lq93XHHlZC8-GE8OpMS5q0bBph7kFP2Hzi0MDcA-5jCSY7Iw>
    <xmx:Q02RXyBjcktEmO1lsRqWaZDkJqTaoOKQY41qIvzQuhQ21BqVdLZTrQ>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 247EB3280059;
        Thu, 22 Oct 2020 05:13:38 -0400 (EDT)
Date:   Thu, 22 Oct 2020 11:13:37 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     =?utf-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Cc:     rinni@inventati.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>, linux-mmc@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Subject: Re: [linux-sunxi] [PATCH] Disable HS-DDR mode for Olimex
 A64-OLinuXino variants with eMMC
Message-ID: <20201022091337.3u5ya3jouhmaukcj@gilmour.lan>
References: <0d590f91-5d7a-697a-5644-710d14e3ea75@inventati.org>
 <CAJiuCceLR_zfyA0zHyRrqZ46DoQ6Ju-xVaa2Rf_PkjDkPOR8JA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="j7uerhezri4g3gp5"
Content-Disposition: inline
In-Reply-To: <CAJiuCceLR_zfyA0zHyRrqZ46DoQ6Ju-xVaa2Rf_PkjDkPOR8JA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org


--j7uerhezri4g3gp5
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Oct 22, 2020 at 09:52:29AM +0200, Cl=E9ment P=E9ron wrote:
> Hi Philipp,
>=20
> On Thu, 22 Oct 2020 at 00:10, Philip Rinn <rinni@inventati.org> wrote:
> >
> > Hi,
> >
> > the Olimex A64-OLinuXino board comes in various variants, three with eM=
MC.
> > While MMC HS-DDR mode works fine on one of them (A64-OLinuXino-1Ge4GW) =
it
> > doesn't work on the A64-OLinuXino-2Ge8G-IND variant (I don't have the
> > third variant so I can't check if it works there).
>=20
> We got similar situations for Allwinner H6 (Beelink GS1 and Tanix TX6).
>=20
> There is definitely an issue in the MMC sunxi driver with HS-DDR mode
> and it's not limited to "olimex,a64-olinuxino-emmc".
>=20
> Have a look at this this message posted by Jernej:
> https://www.spinics.net/lists/arm-kernel/msg846093.html
>=20
> I think we should disable the HS-DDR mode for A64 / H6 like it's done
> for H5 and not disable board per board until the issue is resolved.

I'm not opposed to that on principle, but "it doesn't work on some
board" is not a proper justification to do so. It does on some others,
so surely there's more to it and this would just paper over whatever
issue we have instead of properly fixing it.

> If you want to disable only for your board you can set in your
> device-tree: mmc-hs200-1_8v; This will switch to HS200 mode without
> using the HS-DDR mode.

Sigh. Can we at least work on a fix instead of providing terrible
workarounds?

Maxime

--j7uerhezri4g3gp5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX5FNQQAKCRDj7w1vZxhR
xaJcAP4+0n84pLwTbYHVpqnYTq2kb8+APRRXylHYfKL7/6oOkgD/dsxJf8ryuXFV
5fxEDJAZPqS3aiVkuff2CSYVwVn5Zw4=
=2emh
-----END PGP SIGNATURE-----

--j7uerhezri4g3gp5--
