Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AA5AC2BB48
	for <linux-mmc@archiver.kernel.org>; Mon, 14 Dec 2020 14:40:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8A612255F
	for <linux-mmc@archiver.kernel.org>; Mon, 14 Dec 2020 14:40:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403920AbgLNOjf (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 14 Dec 2020 09:39:35 -0500
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:54579 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2407382AbgLNOjR (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 14 Dec 2020 09:39:17 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 941676F3;
        Mon, 14 Dec 2020 09:38:10 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 14 Dec 2020 09:38:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=L+rX2CmOwQGtvUvi7iN9sVCi3bo
        tW8KO7zKQJDj5/e8=; b=M44ztO4Lp5nIQkl5yGMu8Lj+rMlArxAoQNakc+VGKhn
        BusDmpc5r9yQaTpnUuKWo8o4OnZfDcxztxiqlNynf3RdyWzl+WuUQRYJ0k73vNcY
        k0CaIWlQGOTz7RaNmdw7k2ZOgNtnBFLmVhaIz/F8fUCcN7q2jnBTacCakb0wYv3R
        y/n5GC2S9nddyB+ZzfF/HMwXkDJj0/D6Ra+aNauwRD/V/x9eIXyjPhZtR21S+vCj
        R1FpNqQ0ViBY7W+go7AS3sOxJl3c3ycEvfA+CSyBbfqgO5okA2H+6Cck1dMJb7L6
        Fw/ixxPuV0BZ8FOne+xTiIrDGIoR/A9u2kMa3N46MXA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=L+rX2C
        mOwQGtvUvi7iN9sVCi3botW8KO7zKQJDj5/e8=; b=OSw83sUVy9b4tJ1Mt3Y3d7
        41MyykYsyVFwwDS4Em4rp0zKlwEm63e1HYObAyW3WJEZ+e7x8fnXWGFLzq2CjTKg
        SlxIjysJfkatVbshPBsy+QVzKJ2Ua4YkEZ6gMu6DgsIFabSIuhzuxQVbHyBC3u17
        gfnqCsEohhpUeLZPBRBiMM7YicZjGJVm9bgxs2dM12JsqXnJRRYvupAtee0JnNKi
        MsQS+3LGc7zQpt7f8K2YBsiDFeAjdeLX+9fnw8oZFm0Z0K7VVrwWs0nkyVOHf6LV
        2pfphw7FWdKaD2NNb8aF69qOI95J1KUJPeHTxIbdhk0MuP7Dma70OoHOPRXPBw6g
        ==
X-ME-Sender: <xms:0HjXXz_IBu7DCxzaVLNKrX7KB8uYkIdu5jsmJ30MKJW9s-SeBpS4Yg>
    <xme:0HjXX5WPdIhe7e_ATKx3qOP8CwFQTGHHIv5XwoBMPfaRJ-fGUKIPnMWix2OitCL8v
    HeTmEmNWO-cIjjOWoM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudekkedgieejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
    gedunecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:0HjXXxD4zheHsrNA1_mBSeTuKerQo_9u-KguPDmv9_V81iRapXSpNA>
    <xmx:0HjXXywHPNkHqxOb6acVIJUNke1FQqr7u62cg4NRonXzbZLqgeKapQ>
    <xmx:0HjXX2AZWxre5nDxsco4GLWno4v-l8bNSXQwuguD_rbqJqeUaaTatw>
    <xmx:0njXX54d4kKHNovKyH_0npolRJRxu7ezyjvW4qqFKintTc-r8oBhNw>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 4FF64108005F;
        Mon, 14 Dec 2020 09:38:08 -0500 (EST)
Date:   Mon, 14 Dec 2020 15:38:07 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Icenowy Zheng <icenowy@aosc.io>
Cc:     Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org
Subject: Re: [RFC PATCH 08/12] dt-bindings: mmc: sunxi: add compatible
 strings for V831 MMC
Message-ID: <20201214143807.3wsot6yk4z6s32u5@gilmour>
References: <20201212040157.3639864-1-icenowy@aosc.io>
 <20201212050346.3644673-1-icenowy@aosc.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="a6eeaa2leewxdmgu"
Content-Disposition: inline
In-Reply-To: <20201212050346.3644673-1-icenowy@aosc.io>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org


--a6eeaa2leewxdmgu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 12, 2020 at 01:03:42PM +0800, Icenowy Zheng wrote:
> V831 has MMC controllers similar to the ones on H6.
>=20
> Add a compatible string for them.
>=20
> The eMMC controller compatible is not added, because the eMMC controller
> is not available on V831, only V833.
>=20
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: linux-mmc@vger.kernel.org
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>

There's pretty much the same comment than on the H616, it would be great
to not have any mode flags being set by the driver to avoid the mess we
have on the older SoCs right now.

Maxime

--a6eeaa2leewxdmgu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX9d4zwAKCRDj7w1vZxhR
xeatAQDlfmtMP5DKMl4QYDtMXUTYVkUEr47s/NVuvZOKmuYQ+AD7B1b1CtM9BG2Q
TiZsaeXjCGmbFXswP8LlUIdf8b3UhgE=
=csW8
-----END PGP SIGNATURE-----

--a6eeaa2leewxdmgu--
