Return-Path: <SRS0=Uv8K=7S=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B43FC433E0
	for <linux-mmc@archiver.kernel.org>; Fri,  5 Jun 2020 15:18:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4659E206A2
	for <linux-mmc@archiver.kernel.org>; Fri,  5 Jun 2020 15:18:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="ExN7CqWr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="F0SyF/JM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726675AbgFEPSP (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 5 Jun 2020 11:18:15 -0400
Received: from wnew4-smtp.messagingengine.com ([64.147.123.18]:47429 "EHLO
        wnew4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726601AbgFEPSP (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 5 Jun 2020 11:18:15 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id 1B2636C7;
        Fri,  5 Jun 2020 11:18:14 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 05 Jun 2020 11:18:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=eDXBvR6YBBtfhuiC0E7a3EHj/Ym
        N6ySkgO12Cpj2Nrw=; b=ExN7CqWrg4jyViAfCa+fhX2rn1O70zwpNpT8K2nymCT
        EuTVoVh9M//JKOtrBcux+WH0wuXC8PziL8fNrzpSYTpyRE2wef7A4T0PnafZpjud
        6sN3kEk4DoSg3t9Y8mnsNgaT8x1mF+fwcOQl7syJlyahtXCmIbndzuSAKNT+FxBs
        1cvp4M5CWvtPKzQjvmEcBK40/5fMlaEXeZ12+KTQEpcRukiquUZIuvF/J0dV4azf
        7IkhOjzRYHRM8bm24gnasbK95WWj0gIZWErDzl4NNfVDCl9ZKJCMIMdxxFwCVrxf
        0t5vWIQwi3/8NXvVfgnZ0LFbKE0L3ckwIQtqFCzn6Fg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=eDXBvR
        6YBBtfhuiC0E7a3EHj/YmN6ySkgO12Cpj2Nrw=; b=F0SyF/JMN+D6e7CqCPOP8K
        6avtHMvP25wWVwrKG5TCReTrYZ3fDN2pHRRntboqsU9Ga54gNOPT3nZVxQQMCYdk
        2aB8dJcV2gykE3hO8WIXSLj0x3VzvNaR66QhRbjKhNGYGT7g5xwACa7XD0tNlblp
        uHmki7hCqRI45kd2mFgN8KmpY8ZGuM1uDEGtlW8k1Jr7LjmdXHNBWZantFQsk0YA
        rH7hRjfm1lnRi2epqsx4zxHIhI18Mbyr3ZIlYxIUzDY9d4GgVC+NUarxm3Fk+Tvq
        FbDtnDDMZ0rUQFamzs49qJ4+qf2wsYKqX3H5rOlw0uwfMUvhvjeHSAqjh4gAHRFw
        ==
X-ME-Sender: <xms:NGLaXsqg53A4vXafdJw4pq_lA7qt40tpwRF8q4-tc0E1SUULdOQmdA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrudegfedgjeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
    gedunecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:NGLaXioOQ9sTvkE8t2fbvYnoB0Xdmszj0f2VF6Phs5vc2DkgVxKx2g>
    <xmx:NGLaXhMcXwxl2_nKkYrgvE1SLyP_jqHsdtXwd4bNpkxWdr6SjKT2SQ>
    <xmx:NGLaXj5yH1gEu92lw8JY84PtauSDbXcZZBVvgtet0WogpEJQhdQadg>
    <xmx:NWLaXlsvqfIBPxsHWFF7JELiV3ds3aGkrB2r5WzrUyP-TK4b56pJuQhRsR8>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id F39FF3280065;
        Fri,  5 Jun 2020 11:18:11 -0400 (EDT)
Date:   Fri, 5 Jun 2020 17:18:10 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Frank Lee <frank@allwinnertech.com>
Cc:     chaotian.jing@mediatek.com, ulf.hansson@linaro.org,
        matthias.bgg@gmail.com, wens@csie.org, tiny.windzz@gmail.com,
        rmfrfs@gmail.com, marex@denx.de, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mmc: sunxi-mmc: do not hide address in
 sunxi_mmc_irq()
Message-ID: <20200605151810.vmgnnzp7cadfwsu5@gilmour.lan>
References: <20200605125545.31974-1-frank@allwinnertech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="lqyrkswqzjhc3pkq"
Content-Disposition: inline
In-Reply-To: <20200605125545.31974-1-frank@allwinnertech.com>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org


--lqyrkswqzjhc3pkq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Jun 05, 2020 at 08:55:44PM +0800, Frank Lee wrote:
> From: Yangtao Li <tiny.windzz@gmail.com>
>=20
> Using %px to show the actual address in sunxi_mmc_irq()
> to help us to debug issue.
>=20
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> Signed-off-by: Frank Lee <frank@allwinnertech.com>

I'm fairly sure this hash is on purpose, and both the commit log of the
%px introduction (ad67b74d2469) and the checkpatch message are pretty
explicit about it.

What issue were you trying to solve here?

Maxime

--lqyrkswqzjhc3pkq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXtpiMgAKCRDj7w1vZxhR
xX8tAQCtvLK2kLjK9ek6BhW0HKPRmxoCrg3HRrnR7yKGjtdBLgD/Ru2M3MqS1iws
hyuU+IoR9fzMA4nBd/Rq7FQ104ypeQQ=
=VGny
-----END PGP SIGNATURE-----

--lqyrkswqzjhc3pkq--
