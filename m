Return-Path: <SRS0=U+Jx=5C=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C26D8C3F2CE
	for <linux-mmc@archiver.kernel.org>; Tue, 17 Mar 2020 13:19:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 921DA20724
	for <linux-mmc@archiver.kernel.org>; Tue, 17 Mar 2020 13:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584451153;
	bh=PPTCcLBzoBUtw5DYWX1xW4upjr/Y52oDu4qgwDi0Iww=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=BzApxrlRDliZGVzWCtuQnWunns3DybpEbiDY37aGXsLvSwFirx+whRHpG/Cjv8r7E
	 EinirLi1+uBmGYOPyADWy0d740EluoQu+jvb6uebBEK6hjTxaNxAr28iu/A9Eb/bp2
	 TdoGzAaBDsQpn+JZ5JdM3mDz7lLVEcTFj79e8WLs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbgCQNTK (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 17 Mar 2020 09:19:10 -0400
Received: from foss.arm.com ([217.140.110.172]:38088 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726082AbgCQNTJ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 17 Mar 2020 09:19:09 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8CCF330E;
        Tue, 17 Mar 2020 06:19:08 -0700 (PDT)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0B9523F534;
        Tue, 17 Mar 2020 06:19:08 -0700 (PDT)
Date:   Tue, 17 Mar 2020 13:19:06 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-media@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH 00/28] DT: Improve validation for Marvell SoCs
Message-ID: <20200317131906.GF3971@sirena.org.uk>
References: <20200317093922.20785-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="A9z/3b/E4MkkD+7G"
Content-Disposition: inline
In-Reply-To: <20200317093922.20785-1-lkundrak@v3.sk>
X-Cookie: There's only one everything.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org


--A9z/3b/E4MkkD+7G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 17, 2020 at 10:38:54AM +0100, Lubomir Rintel wrote:

> None of the patches depends on any other and they can be applied in any
> order.

For future reference since this is a large set of mostly unrelated
changes it'd be as well to split it up via subsystem or something so
that the CC lists get reduced.

--A9z/3b/E4MkkD+7G
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5wzkkACgkQJNaLcl1U
h9B6lQf+JamIVdYxjeWpJEdZLraQ2ZAnjCDDODoguz6v4CAvK8mbvceAlz/ugLsK
mjNdEb4Z3nOWKxnpII99UfKyDb0s1EhYcovC0vJ71uSHJA9fIFxtnvxk9YSEP2Cd
nfXaYzDl1OJJ3DRJXCrudH/j2dwtX2hGBFjIx/havnLkr2dwzfUzsI3uUSFAWwgt
mv2uHQwNP6rR230/NWLqUPNN6/Gal8/4Pj2cAimegQOFW7493PQQKHoG9JttRQgC
PGbYFjB/JV+gk9Sg4R+afcEFHQN7D17H/Lb+HwFPu6+jWqgUEdLgSTOyELAXnamE
me5/+eb94GmNyA3atUU9W4Ju5o+joQ==
=WksN
-----END PGP SIGNATURE-----

--A9z/3b/E4MkkD+7G--
