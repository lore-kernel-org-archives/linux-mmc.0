Return-Path: <SRS0=DxaD=D4=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B94E0C4363A
	for <linux-mmc@archiver.kernel.org>; Wed, 21 Oct 2020 22:17:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29003241A6
	for <linux-mmc@archiver.kernel.org>; Wed, 21 Oct 2020 22:17:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=inventati.org header.i=@inventati.org header.b="rovCxdJx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441254AbgJUWRE (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 21 Oct 2020 18:17:04 -0400
Received: from confino.investici.org ([212.103.72.250]:56119 "EHLO
        confino.investici.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438052AbgJUWRE (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 21 Oct 2020 18:17:04 -0400
X-Greylist: delayed 364 seconds by postgrey-1.27 at vger.kernel.org; Wed, 21 Oct 2020 18:17:03 EDT
Received: from mx1.investici.org (unknown [127.0.0.1])
        by confino.investici.org (Postfix) with ESMTP id 4CGl7J3Btwz12jt;
        Wed, 21 Oct 2020 22:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inventati.org;
        s=stigmate; t=1603318252;
        bh=7xdBSgqcErl/nBqUmdiMDfFJHZpW+MiTobnY3WYhlG0=;
        h=To:From:Subject:Date:From;
        b=rovCxdJx+OI1K/+qo56gyFjRdzy8iyBcHYPORBV04C4iAfP5jtW+z/nCKnsH/33u8
         dvp7UiqoXs/Ddz94RkqvTHW0saWeUo8nv02H4CmySASpxjYkNTWuVDWxQwfqN9Ai3d
         LKCP8ON3DgUOdASrl7fVm8/o8iOD7oI/sN+AXgzk=
Received: from [212.103.72.250] (mx1.investici.org [212.103.72.250]) (Authenticated sender: rinni@inventati.org) by localhost (Postfix) with ESMTPSA id 4CGl7J168hz12hw;
        Wed, 21 Oct 2020 22:10:52 +0000 (UTC)
To:     ulf.hansson@linaro.org, mripard@kernel.org, wens@csie.org,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@googlegroups.com
From:   Philip Rinn <rinni@inventati.org>
Autocrypt: addr=rinni@inventati.org; prefer-encrypt=mutual; keydata=
 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
 bA8HdppJKhaDOUdekpLdnVfd5A==
Subject: [PATCH] Disable HS-DDR mode for Olimex A64-OLinuXino variants with
 eMMC
Message-ID: <0d590f91-5d7a-697a-5644-710d14e3ea75@inventati.org>
Date:   Thu, 22 Oct 2020 00:10:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="amCrK47zbFWFEeiPCMuP3pIsC5IWfy3Ut"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--amCrK47zbFWFEeiPCMuP3pIsC5IWfy3Ut
Content-Type: multipart/mixed; boundary="ZCGaaHMqrAp8QQZ3clYP8dl3EBUxtvOQ0";
 protected-headers="v1"
From: Philip Rinn <rinni@inventati.org>
To: ulf.hansson@linaro.org, mripard@kernel.org, wens@csie.org,
 linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@googlegroups.com
Message-ID: <0d590f91-5d7a-697a-5644-710d14e3ea75@inventati.org>
Subject: [PATCH] Disable HS-DDR mode for Olimex A64-OLinuXino variants with
 eMMC

--ZCGaaHMqrAp8QQZ3clYP8dl3EBUxtvOQ0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi,

the Olimex A64-OLinuXino board comes in various variants, three with eMMC=
=2E
While MMC HS-DDR mode works fine on one of them (A64-OLinuXino-1Ge4GW) it=

doesn't work on the A64-OLinuXino-2Ge8G-IND variant (I don't have the
third variant so I can't check if it works there).

Disabling MMC HS-DDR mode fixes the problem. This is also what Olimex doe=
s
for their kernel:

https://github.com/OLIMEX/linux-olimex/commit/eef0e814e74f.patch

Mainline kernel doesn't differentiate between the different variants with=

eMMC so I'm disabling HS-DDR mode for all of them as done for the H5 eMMC=

controller.

Disable HS-DDR mode for Olimex A64-OLinuXino variants with eMMC

Signed-off-by: Philip Rinn <rinni@inventati.org>

---
drivers/mmc/host/sunxi-mmc.c | 5 +++--
1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
index fc62773602ec..240d3803b8b9 100644
--- a/drivers/mmc/host/sunxi-mmc.c
+++ b/drivers/mmc/host/sunxi-mmc.c
@@ -1397,7 +1397,7 @@ static int sunxi_mmc_probe(struct platform_device *=
pdev)
 				  MMC_CAP_SDIO_IRQ;

 	/*
-	 * Some H5 devices do not have signal traces precise enough to
+	 * Some devices do not have signal traces precise enough to
 	 * use HS DDR mode for their eMMC chips.
 	 *
 	 * We still enable HS DDR modes for all the other controller
@@ -1405,7 +1405,8 @@ static int sunxi_mmc_probe(struct platform_device *=
pdev)
 	 */
 	if ((host->cfg->clk_delays || host->use_new_timings) &&
 	    !of_device_is_compatible(pdev->dev.of_node,
-				     "allwinner,sun50i-h5-emmc"))
+				     "allwinner,sun50i-h5-emmc") &&
+			!of_machine_is_compatible("olimex,a64-olinuxino-emmc"))
 		mmc->caps      |=3D MMC_CAP_1_8V_DDR | MMC_CAP_3_3V_DDR;

 	ret =3D mmc_of_parse(mmc);
--
2.28.0


--ZCGaaHMqrAp8QQZ3clYP8dl3EBUxtvOQ0--

--amCrK47zbFWFEeiPCMuP3pIsC5IWfy3Ut
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEK9jU45eVX3dG2zuJrWkWlnOTmCsFAl+QsesACgkQrWkWlnOT
mCufAw/9FozzykJZQfO4CvGHyMbfxZWDngDVMOQsL/PbuviMZMPQWj6hrrijE4qe
8QsEmBXwiRolJ+br6XIc+LK6G7YRJT8FF7nNyXgJ81NWZAbcLOc1ifX9degqNtJo
Vcd6VLgKP0HCgYUVGX25w2d0ZO1+GKGq814yYoLpP7q5URpJ9wcrv/FtUWs5Rbcg
pVUPJ/qohG7WefJWjdP8C53vqO8r/1dKQEvV1syGvYbMVdO86Mwe3ycKdeXeOxnI
LDwdpR3DtpoURbHbuf0jx2fnRs5WFXa88ZntvY64mAS00z6M8tV9/MnJXvN3WyTK
WRe1zoGD3uqWLgWkQ+/rPyXIb9AW6V3jzf1TgItJiMS+WJwyGH4v1I9flOatsd7y
85zjrbCya9XO9ln000a4hn9RYV1nHaJrWJ/sF7xG4it80k2UxLOTyHNs7IFsNBZI
t3DStivxuIql4MHSSAGLL54aWKxfkjUVv6WgZM6JZoQliLbRExabQcPzCwE4bzp1
bkhvDeUSK7esL/TMxtEkvYdd2amJli0YsD8FmrbTIH+Nt8eh+nCpV8lLL8JFZk78
2D67WNM5ida8lVa4Kp+dN8cn1oqBIQH6BPk3pTzSZBGTtAkRHAXIJxUfCnblH+hs
BKxTzYdhMcCBijKJaksZdXObFgbLp7GkB4hEM0ecC+UXBY19K4c=
=vHF3
-----END PGP SIGNATURE-----

--amCrK47zbFWFEeiPCMuP3pIsC5IWfy3Ut--
