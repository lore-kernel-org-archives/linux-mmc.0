Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9861BC433DB
	for <linux-mmc@archiver.kernel.org>; Wed, 13 Jan 2021 09:52:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F57E233A2
	for <linux-mmc@archiver.kernel.org>; Wed, 13 Jan 2021 09:52:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727630AbhAMJwG (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 13 Jan 2021 04:52:06 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:60323 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727623AbhAMJwG (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 13 Jan 2021 04:52:06 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id E8E005C01D5;
        Wed, 13 Jan 2021 04:50:59 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Wed, 13 Jan 2021 04:50:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=ODWeXXXsQvr2ZAlqiDplPxSeA/h
        7luTX5Xi74ySlBFU=; b=LMByLSiKaw5p4WJnRZQ2SfbnP72ueDRgmwKKbilrHga
        NZV/CFhrH81oa7MoGiwtW2OBeuGqX/F/8f9t/11bJ7jwR+CLEL3LuwFxVG5ylbFR
        BdOP8SLPGriBzIH/5GFWVY+uzm+GiS9iNm6eiRMtF9aURuegH4iQPt/zv3gUYU+R
        nIVceD6eDI9SwUIjKafqkXuqkdeWZmBWA8JGdhmBzHKazCfVcnXe2Mhr9kGzBUTR
        070kFCMXYCdS9LBTMtppig886kGB7OOLwCe4sO+Hi1Ew3nfoTVt9eEohbVugrmSr
        6lsfiaBRPEunmNsZMnfLx4GiYBiNIm+BiexEJ5sC9Pg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=ODWeXX
        XsQvr2ZAlqiDplPxSeA/h7luTX5Xi74ySlBFU=; b=KHvr1eLZwjHABA2LeU3kdd
        0sLMzCsEHvxYttq6BfBUIrLq2GJhZEM4bZI8JIGkVGwvI73HoYHWTj2IckQuHlba
        QxzRuKzqISNb13qKUXehvEtxsHypnu0Asv0CfK8lBd0SMnx1ke6HPKApS5A6lNHy
        58IRXImYvLPsPxP4LUj3C99OYnMkqI8orsZ3hzpezTP+DeH6nsLyQr8/Ki7VXhGi
        qNpxFyh9+JZeccpSOXW/7JM3eg26cFR+Vq3eokJX0fAReTz1rGCNORjTlIVUw2DY
        bM9zTvKfrLGIIm5RT+7XLRhvDygD28ge0PdsPqh/dVbUpklqwyFbg/rwtgoxGRTA
        ==
X-ME-Sender: <xms:g8L-XxP-6VVIijZrbHB3LEnPo1rfAISySOGgGX7u_3gbfe97gGHXdQ>
    <xme:g8L-Xz9cYMpx1-9IqtSH6_KSgpTwuIuNZtS1kvacDeMKnTTlQhYPjVtzqSDqIafE6
    V_tZD7pszv_CzST8Xo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedukedrtdefgddtkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtth
    gvrhhnpeelkeeghefhuddtleejgfeljeffheffgfeijefhgfeufefhtdevteegheeiheeg
    udenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:g8L-XwQ5XGGhZo7-Hsb8MvDABYUpuj13ynl_8Lb3rhzKwFES1L-Pkg>
    <xmx:g8L-X9tKEZzaPIYAt0pteSyhDPhw-b7HEY6w9Aaq9kzVl7KoVkfaiA>
    <xmx:g8L-X5dlxSTWkDallsj5WnuoCFVKyp-Hlr6_gsGdO1iiTYRMBu8e-Q>
    <xmx:g8L-Xw6Z3MESLsGiU4TI6H8xmgeP0BWAAAHZTTV6IxEO5QbA1oCOCA>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 02F3A1080057;
        Wed, 13 Jan 2021 04:50:58 -0500 (EST)
Date:   Wed, 13 Jan 2021 10:50:56 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mmc: sunxi-mmc: Ensure host is suspended during system
 sleep
Message-ID: <20210113095056.pcwi6qjb7gl7qwwd@gilmour>
References: <20210113052421.36553-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6b6zzludmfekhuk2"
Content-Disposition: inline
In-Reply-To: <20210113052421.36553-1-samuel@sholland.org>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org


--6b6zzludmfekhuk2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 12, 2021 at 11:24:21PM -0600, Samuel Holland wrote:
> If the device suspend process begins before the mmc host's autosuspend
> timeout, the host will continue running during system sleep. Avoid
> this by forcing runtime suspend during a global suspend transition.
>=20
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Acked-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime

--6b6zzludmfekhuk2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX/7CgAAKCRDj7w1vZxhR
xQO+AQDqHiB1plcj1TBnOaMaoUULEzUpGDPudBxS4pjLYoiF6QD+IhWTapNy++xx
0OlAFepmg4h5j8+cw7pna8bT3d8u7Ao=
=vQci
-----END PGP SIGNATURE-----

--6b6zzludmfekhuk2--
