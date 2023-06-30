Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C05A3EB64D7
	for <linux-mmc@archiver.kernel.org>; Fri, 30 Jun 2023 18:09:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232631AbjF3SJm (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 30 Jun 2023 14:09:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232965AbjF3SJj (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 30 Jun 2023 14:09:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3861B1FC0;
        Fri, 30 Jun 2023 11:09:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BB3BA617CE;
        Fri, 30 Jun 2023 18:09:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D1A5C433C8;
        Fri, 30 Jun 2023 18:09:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688148577;
        bh=bPxZ17UkvfpQ7cl+vOGA9tfbMxzVwDfaSHgruYnO23k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N42/HycNUB3R9rtOHRq82XbOPVJ4ZvgsDSe7ml5hzKpb6e1I+qg2pUeQJsQW5p9SL
         ckfnL+XH6Wlurgze98c1hk/HXd3Cri9vYgci7nIpWsGbMxEXM/eNx+ph7gBCPFolkK
         30liyPbnNpuAp/diWyYWLiSr7sIfxtBCmLuZxsmBP/th62XvXkkRdYA0kTpvO2CynS
         7J1rQXJ/0pSgYjMSga5pnGYWggYClqN+CTh4/Az+y34rCyR5cJaGNqGzUG9TtaDxKr
         u3z8Q+jNwdISz41O81vWHe7T2B3hhrpLrQRDbOR5sc5bcS7GhigxLme65HUzxC9oYk
         kSkr9dtRTwCkA==
Date:   Fri, 30 Jun 2023 19:09:31 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Frank Wunderlich <linux@fw-web.de>
Cc:     linux-mediatek@lists.infradead.org,
        Frank Wunderlich <frank-w@public-files.de>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Wenbin Mei <wenbin.mei@mediatek.com>,
        Sam Shih <sam.shih@mediatek.com>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 1/2] dt-bindings: mmc: mtk-sd: drop
 assigned-clocks/clock-parents
Message-ID: <20230630-enrich-configure-c0f640e32cbc@spud>
References: <20230629184318.551317-1-linux@fw-web.de>
 <20230629184318.551317-2-linux@fw-web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="XiSMeL3djetO3rf/"
Content-Disposition: inline
In-Reply-To: <20230629184318.551317-2-linux@fw-web.de>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org


--XiSMeL3djetO3rf/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 29, 2023 at 08:43:17PM +0200, Frank Wunderlich wrote:
> From: Frank Wunderlich <frank-w@public-files.de>
>=20
> MT7986 has 2 clock-parents and these properties are not needed in driver
> binding. So drop them completely.
>=20
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--XiSMeL3djetO3rf/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZJ8aWwAKCRB4tDGHoIJi
0rP5AQC2D2dKDFDysbpF3uvL/kWOnVWNg2SDJfdLvMCyaWBkpgD/U6aOgl/StE/w
Vj2pP1AqURfOz3A5FBU7BH6CuyWhRAQ=
=aQez
-----END PGP SIGNATURE-----

--XiSMeL3djetO3rf/--
