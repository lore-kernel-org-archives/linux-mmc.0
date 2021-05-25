Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40A3CC2B9F8
	for <linux-mmc@archiver.kernel.org>; Tue, 25 May 2021 19:08:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18D646140F
	for <linux-mmc@archiver.kernel.org>; Tue, 25 May 2021 19:08:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231389AbhEYTKU (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 25 May 2021 15:10:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:45804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230029AbhEYTKT (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 25 May 2021 15:10:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7A4376140E;
        Tue, 25 May 2021 19:08:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621969729;
        bh=erpKjGqAF4AJzuEwJKCEvWLbw/VoBc5b49WkYqtFinA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i/OslaSNt1f+WuDzqwZneA+WCVy7F4O2r4E6SxvQqyzVtvoONE8Oms6MxSsMIgNtq
         Qla5P5gNkT3gVba+Pzicj25w7ka950Z+uebbJHXlNkOiGcof0B+yODgiRtIIRhWvpn
         Y+XhO/LPekhPoxrMqOcEwCg8xQjBoheTspChn8XnAAs/htgGxFBMwXcP/Wkt21EYSp
         +1zhoegPIDbPbh/GCcLaEkMAzz/FMWRebCpoYlACVzxSmcCk8fwrfvkFboLa0xNXYs
         xPbJEJi1K58DRU0iVbUL9FeuhDiW2OYDxt9jKnMKhMuABq2wnXb5OhFFurF1B67L87
         +wg2M+zrDp4xQ==
Date:   Tue, 25 May 2021 21:08:46 +0200
From:   Wolfram Sang <wsa@kernel.org>
To:     cl@rock-chips.com
Cc:     heiko@sntech.de, robh+dt@kernel.org, jagan@amarulasolutions.com,
        wens@csie.org, uwe@kleine-koenig.org, mail@david-bauer.net,
        jbx6244@gmail.com, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        jensenhuang@friendlyarm.com, michael@amarulasolutions.com,
        cnsztl@gmail.com, devicetree@vger.kernel.org,
        ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
        gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        linux-i2c@vger.kernel.org, jay.xu@rock-chips.com,
        shawn.lin@rock-chips.com, david.wu@rock-chips.com,
        zhangqing@rock-chips.com, huangtao@rock-chips.com,
        wim@linux-watchdog.org, linux@roeck-us.net, jamie@jamieiles.com,
        linux-watchdog@vger.kernel.org, maz@kernel.org
Subject: Re: [PATCH v4 01/10] dt-bindings: i2c: i2c-rk3x: add description for
 rk3568
Message-ID: <YK1LPjhjci5jejsD@kunai>
Mail-Followup-To: Wolfram Sang <wsa@kernel.org>, cl@rock-chips.com,
        heiko@sntech.de, robh+dt@kernel.org, jagan@amarulasolutions.com,
        wens@csie.org, uwe@kleine-koenig.org, mail@david-bauer.net,
        jbx6244@gmail.com, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        jensenhuang@friendlyarm.com, michael@amarulasolutions.com,
        cnsztl@gmail.com, devicetree@vger.kernel.org,
        ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
        gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        linux-i2c@vger.kernel.org, jay.xu@rock-chips.com,
        shawn.lin@rock-chips.com, david.wu@rock-chips.com,
        zhangqing@rock-chips.com, huangtao@rock-chips.com,
        wim@linux-watchdog.org, linux@roeck-us.net, jamie@jamieiles.com,
        linux-watchdog@vger.kernel.org, maz@kernel.org
References: <20210429081151.17558-1-cl@rock-chips.com>
 <20210429081151.17558-2-cl@rock-chips.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="NCc2q0vIdyd+dXz5"
Content-Disposition: inline
In-Reply-To: <20210429081151.17558-2-cl@rock-chips.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org


--NCc2q0vIdyd+dXz5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 29, 2021 at 04:11:42PM +0800, cl@rock-chips.com wrote:
> From: Liang Chen <cl@rock-chips.com>
>=20
> add "rockchip,rk3568-i2c", "rockchip,rk3399-i2c" for i2c nodes on
> a rk3568 platform to i2c-rk3x.yaml.
>=20
> Signed-off-by: Liang Chen <cl@rock-chips.com>

Applied to for-next, thanks!


--NCc2q0vIdyd+dXz5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmCtSz4ACgkQFA3kzBSg
KbbpaQ//ZFjmjk57xuPgcUkyVTPY3RLZE602/1iQ5IizdQa2vaxkuYrwoSSg4oH5
TUhCcfrs3oUrEq0ZvFeHevoBcxNqsz/2V2vEpUqGscwRtJnVVEoWwfWpLEZyp33k
8XPx/kEWyoiT8vqV8ZCz2kjEbBYxhZ3JESKGU7Jp3hhGTEE7i3OwKzokRgm05bXY
HRT6XvhR5rQ96Rc4j5YhEAchhDbAnS6TOhUGRzIQlgR/nKZXFUlCIwfozjdpBS+D
THbvK5W3hDqaSkt5y1ff0hujh/NZGl4jU3cOokSLnO+RdOPIZy833SenTp00VYU7
MmK4iB5ZI/wKOgTrJ3k3BlEzvrDZLfWyD9ZFa8dnuDR6yiDigOKv8osaGuHYopIF
fJ2QSMFZ8D0vSEc1nus1Jq5bEacIfMo2ZanOB6ZkImaDKfqajhHaMrNNE0eyhGT0
dSnsyBDSwRKDQdkGFGV3zeCYaYCs9i+Rv5ep6CwbgvfO9pLo7xnMHBK5+qFJIcv3
t/vm6cvy26GAUJEMP86XnWKnZirNLexFvfBFjXsg6qpwSjux1dfM8GjSBuLMkbSZ
Xe0h3C+IfThm2AsHc7LuEXMpiEZ0tlcCkW+vSgr9DG6viM7MLLgQeg3gwxvOAHLb
EWSrivI969UDnwVqd+Ebq8Yjs7vxjfgNCfflbxXOytLmSRkS9KU=
=OqI6
-----END PGP SIGNATURE-----

--NCc2q0vIdyd+dXz5--
