From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 1/6] mmc: renesas_sdhc: remove eprobe jump label
Date: Mon, 20 Nov 2017 21:31:25 +0100
Message-ID: <20171120203125.nbtaeqpwk4zg6fxz@ninjato>
References: <1510042172-27220-1-git-send-email-yamada.masahiro@socionext.com>
 <1510042172-27220-2-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="sli4w7vq4pq23uge"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:50653 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751173AbdKTUb2 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 20 Nov 2017 15:31:28 -0500
Content-Disposition: inline
In-Reply-To: <1510042172-27220-2-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-mmc@vger.kernel.org, Simon Horman <simon.horman@netronome.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>


--sli4w7vq4pq23uge
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> -		ret = PTR_ERR(priv->clk);
> -		dev_err(&pdev->dev, "cannot get clock: %d\n", ret);
> -		goto eprobe;
> +		dev_err(&pdev->dev, "cannot get clock\n");
> +		return PTR_ERR(priv->clk);

Why dropping the 'ret' printout? Will it be printed by the core?


--sli4w7vq4pq23uge
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAloTO5kACgkQFA3kzBSg
KbZv8w/8CzLtTH18GOE8yklUddoesE/Ob13XO43/r3J7v0LZKEkx9V0NK6HTypsQ
gMuzWsLiv4j9b9YsG/E36t4/kOdhzcqITTTAPtKnWseFEU1outC7Or+v9ysPUCgq
dz99ccUFpZWF0iJC63+rOpC7lbZECaonRy+gL/m/5Q5DW37xg+zkrjXReiWf2Nrl
E5tvF5KdFeFeKbFHqI+Q0vcp9pHese90xI8EMDm6pBzrtsHJV2IYQaGQJKnjHHcJ
xbab/uFevb1e1BZkf32yCZapspV5eDfAyaqZjFeJdaVfhtxXXiSLX/EmCCJkkPfu
Lvqip5N3R+TcDUw21ANDFxWwWc/Gg6WXEBDnYGxO9ht8pvticEDSRLX5ZXYm6Wmt
O4dadsP0h4VZTdrNUjVk39Jn7VBeCYZAiXC5uimYid2F0J76IVKvlO8REt9GtrUp
O2Il7Blb36XPSfZnvFfE+OYh3IOFA2EWqJdV6WZjPCfyuGtZFmuNbZbAi7hYHDbb
ukHaGQT9kq5qgfVtP243U1j1RdJrdsFgO0lxuZ+MFnbd5IKV9ZNbt16ouCwL59wh
dnSPpKnwnFhRLWEyQrctOyUtiWgW+CRN0YDSreTcDNsTl1rq2HYjlq9jlSR2BkIH
smr1sc7QAqKkn6H7d3/W9SYHjQ1R2Ymqk2ZkvaGl4zZ8Em235oU=
=YFrE
-----END PGP SIGNATURE-----

--sli4w7vq4pq23uge--
