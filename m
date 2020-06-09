Return-Path: <SRS0=tDFP=7W=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A73EFC433DF
	for <linux-mmc@archiver.kernel.org>; Tue,  9 Jun 2020 16:04:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6992620737
	for <linux-mmc@archiver.kernel.org>; Tue,  9 Jun 2020 16:04:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="iXSICJKU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KevHb/78"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731040AbgFIQE6 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 9 Jun 2020 12:04:58 -0400
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:38899 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730999AbgFIQE4 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 9 Jun 2020 12:04:56 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 00C9D580198;
        Tue,  9 Jun 2020 12:04:54 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 09 Jun 2020 12:04:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=+Z1CbKKzxFQkq1/YTSxGbIdFSzg
        K4ihAD5NZF8upwxI=; b=iXSICJKUKbub8O1mb/4XprYG6trgvVZ4uvlrXgS6UAu
        c/McrLTaBFyWCe4ecRAseIC+ifBoW5MlWqPmgDAcH9CiFJdaYh0MrveUwspHRR3S
        h+JcXC77Qph8GLfibzZsYPx6mytiIT37zLfd4QTnetypJDO1xGsqhg8mkiUPGNGF
        fnZS+aYnQSw6na7bt/wCkN8r4250fx6vx9QTdzE0e+DAVIgc6+qPsPQ7YGsy7ban
        9E+V3ODTGK6PA0xlZC+UCNCdYKqcEO4JjURsm/Pl6HdwX4LtLPNf8arzMf1O2wR4
        v7ithUgvhcJ8R00QgJteE93qBUfRB9OHW14zfSmIxOQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=+Z1CbK
        KzxFQkq1/YTSxGbIdFSzgK4ihAD5NZF8upwxI=; b=KevHb/78PKKepKdMUBnr7h
        R+3lIkYZ6Zt08egMuE/+Hk7EI89kBhUVXeE7KTd+SLGGqZ00cJoDemOBkhAjd9T9
        qLzRgYxZCSnjG0mNo0k9Awg8jzwL+QZFYDcyKvu7c1IP44AXb2L0Noi3dR8n3JHv
        uj+ztELeVjOCQF+KwWPWbVqY0WpiyPmzBJOiCR7lCQNoJPDy11e4JG4+ToWboADn
        NOg7rCJzuJt1makv7efI6L7YDyADgKYO+aWvtYM8k++ALzAtEQEFA93m0FZSU520
        WguNFHqrTaYOGZ2hjWYYx/epchsMOjpzVBeiyZwAE6z0xP4dV9hYZOpFNwiCGANQ
        ==
X-ME-Sender: <xms:IrPfXuWsSVa0ZPTZYogX02FsTEzNbd6NO09uJ5DEEC7s36akvn7-1g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrudehgedgleekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
    gedunecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:IrPfXql3xi9awde6ICH0Hx-fY0FjpOH84zr4Y_UEMI7Yd0GL9dhQwQ>
    <xmx:IrPfXiYhL3ztgubReA5xwKSGkPocTbuzeOFsM1nJ3S3-yniFLQ7NNA>
    <xmx:IrPfXlWtxP9_Dk07K6cZ9SZF-Jk3BaVFA9LMLlEfJZ-VEsuQ92jxMQ>
    <xmx:JrPfXi6fIGP-gCnnKabye7wBEem0m1quMDoyKnUC1ckdjhuXeWEQbQ>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 47B1F328005D;
        Tue,  9 Jun 2020 12:04:50 -0400 (EDT)
Date:   Tue, 9 Jun 2020 18:04:48 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Frank Lee <tiny.windzz@gmail.com>
Cc:     Frank Lee <frank@allwinnertech.com>, chaotian.jing@mediatek.com,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>, rmfrfs@gmail.com, marex@denx.de,
        linux-mmc@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-mediatek@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] mmc: sunxi-mmc: do not hide address in
 sunxi_mmc_irq()
Message-ID: <20200609160448.cy47xfwqs6hkxi7d@gilmour.lan>
References: <20200605125545.31974-1-frank@allwinnertech.com>
 <20200605151810.vmgnnzp7cadfwsu5@gilmour.lan>
 <CAEExFWuoHhLqt4aukmP30SSXmwnmYuRq2t5HWKUBvreeABg=XQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="uphnnc535acqsyc6"
Content-Disposition: inline
In-Reply-To: <CAEExFWuoHhLqt4aukmP30SSXmwnmYuRq2t5HWKUBvreeABg=XQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org


--uphnnc535acqsyc6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 08, 2020 at 08:54:51PM +0800, Frank Lee wrote:
> On Fri, Jun 5, 2020 at 11:18 PM Maxime Ripard <maxime@cerno.tech> wrote:
> >
> > Hi,
> >
> > On Fri, Jun 05, 2020 at 08:55:44PM +0800, Frank Lee wrote:
> > > From: Yangtao Li <tiny.windzz@gmail.com>
> > >
> > > Using %px to show the actual address in sunxi_mmc_irq()
> > > to help us to debug issue.
> > >
> > > Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> > > Signed-off-by: Frank Lee <frank@allwinnertech.com>
> >
> > I'm fairly sure this hash is on purpose, and both the commit log of the
> > %px introduction (ad67b74d2469) and the checkpatch message are pretty
> > explicit about it.
> >
> > What issue were you trying to solve here?
>=20
> There doesn't seem to be a strong requirement to force this to be printed=
 out,
> I just think that ____ptrval____ is very unpleasant.

That should happen only at boot when the system doesn't have enough
entropy iirc, after a while it prints out hashes.

> Or delete %p directly?

You mean the message in the driver? I'd be fine with that too.

Maxime

--uphnnc535acqsyc6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXt+zIAAKCRDj7w1vZxhR
xb84AP46JXO+C4VULSIH3+jYn7G+NlNEDTE3GV7/bT7NB3BsmQEA7Kq4fnJRdk4P
/iG2Sff9PD+15yt8ZNIKVw2xH/1twQI=
=t5aH
-----END PGP SIGNATURE-----

--uphnnc535acqsyc6--
