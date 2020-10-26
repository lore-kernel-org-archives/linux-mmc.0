Return-Path: <SRS0=obPU=EB=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5DFFC4363A
	for <linux-mmc@archiver.kernel.org>; Mon, 26 Oct 2020 17:21:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8730620B1F
	for <linux-mmc@archiver.kernel.org>; Mon, 26 Oct 2020 17:21:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1775609AbgJZRVA (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 26 Oct 2020 13:21:00 -0400
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:39043 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1775583AbgJZRU7 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 26 Oct 2020 13:20:59 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 663E02EB;
        Mon, 26 Oct 2020 13:20:58 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 26 Oct 2020 13:20:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=9brhYO8xpx4+REnXroPuvPTAIjU
        O6ryHGplm9oTBwEA=; b=nuJtIIDksEVjnLT5ce7cCg8RIaCjm+5PmMG7VHswekX
        h/BSqV5iZbWwlot23tUFkrKu2+UEkDP2V4/U1XGQCQ59o2nnEwmhh4AjRZNRev9O
        snEIW8I4vsz5+JwrTs/q9BJztHzbpURDP/ZT3v2aWGG24YO96+BTZvcr9i6tX3dd
        TB2KQhmvqY+jz5g/kZywdAMGP/tU5GySTCDLbuODZTitEjk8CPPohiv7ahiSn4fo
        9tL8tsAIy0VMkR87Y89o2I3vDPAnfYq1fK1j6LzAOQrZqpdPGuqZWBVA6XVp7O2M
        L7sFxWvCcTtyvR7QsnAT/BIWRFF3tR3YIIt1O35A8Lg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=9brhYO
        8xpx4+REnXroPuvPTAIjUO6ryHGplm9oTBwEA=; b=SWGPMvq/bQutCDfi0GPe8r
        R+GUcSVIaBeeLa090lVdRbjwNV//FBCksjBzlZueux1G0f3Lc0i80+/OAkiK6gt4
        Z9LxiIRDy3/gW+e7oHN4P4ALry9O754Kj2dEA7aeGFvPPjlMG7pnUG+/okCfKIfD
        9S6MrcWVG9V7JiDxI4VBlDTipGU45nU6AnkWoD7vQ/uQW0X4Q13Mmdyyw4me405z
        CrQAQQ1YMcW/vkqYpIe/J9gCq6hHGCkXQt9QMOe3UN5ih+Iu7M8dt+d7SgWdvK3G
        HQWXdFHpjys2X3kb3ZBOzln+KWbQVAsMblP7NXyp2a7tJ91OTMvfk81+6MZ/KKEw
        ==
X-ME-Sender: <xms:eQWXX6tRXzbzjTmkFaeeb7LbbCpn0wwmYuXbVttwTihRXOClh_84RQ>
    <xme:eQWXX_eDj6V_Bcn93nFKtk6yTtjfDhPZTUxxBXCCUg0ee8hBYPVtrMdYtPnWtO-sN
    UnJBNEwl_jjT8SMsho>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrkeejgdeigecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtjeenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtth
    gvrhhnpeeutdfgjeeuudehvefgvedvtedtudelfffgffekledtffekgedukeejueevieeg
    udenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:eQWXX1xyvz9GQ8TD2jyLw9an833sbKnDDj7kXocJL2yc0WCOqHIXbw>
    <xmx:eQWXX1PF9Z5J31dp7YR0KeVFuuoSUW3SxR6sbgQDsdnsYV28tHDkPA>
    <xmx:eQWXX69atZxBi0MAzsXGdNZfPoKpme9GmGurHWxRB4Xaq8UT8xM7Tg>
    <xmx:egWXX6x3wFl_aQXVX3whJB-u54p3MgRVxfDy8vYvybEphW7AMD7fkg>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 2EB103064683;
        Mon, 26 Oct 2020 13:20:57 -0400 (EDT)
Date:   Mon, 26 Oct 2020 18:20:55 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Ben Dooks <ben-linux@fluff.org>, Chen-Yu Tsai <wens@csie.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH 3/3] mmc: sunxi: drop of_match_ptr from of_device_id table
Message-ID: <20201026172055.i3sitigeodo52oap@gilmour.lan>
References: <20201026153810.89512-1-krzk@kernel.org>
 <20201026153810.89512-3-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="yyirc6kkxyfjwhkt"
Content-Disposition: inline
In-Reply-To: <20201026153810.89512-3-krzk@kernel.org>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org


--yyirc6kkxyfjwhkt
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 26, 2020 at 04:38:10PM +0100, Krzysztof Kozlowski wrote:
> The driver can match only via DT table so it should be always used and
> the of_match_ptr does not have any sense (this also allows ACPI
> matching via PRP0001, even though it is not relevant for sunxi).  This
> fixes compile warning:
>=20
>     drivers/mmc/host/sunxi-mmc.c:1181:34: warning: =E2=80=98sunxi_mmc_of_=
match=E2=80=99 defined but not used [-Wunused-const-variable=3D]
>=20
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Acked-by: Maxime Ripard <mripard@kernel.org>

Maxime

--yyirc6kkxyfjwhkt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX5cFdwAKCRDj7w1vZxhR
xewwAQDBZYJGz0TeOAO1CnJklck5NVE4CFLs48RlmGKWA0/hhgD/XMl12/MdHIms
9EDT019tiEUeJEqW8EHSHNyrzZnrKQA=
=ej/D
-----END PGP SIGNATURE-----

--yyirc6kkxyfjwhkt--
