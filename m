Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81375C4332F
	for <linux-mmc@archiver.kernel.org>; Tue, 29 Nov 2022 03:44:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235097AbiK2DoE (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 28 Nov 2022 22:44:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234975AbiK2DoD (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 28 Nov 2022 22:44:03 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA903245
        for <linux-mmc@vger.kernel.org>; Mon, 28 Nov 2022 19:44:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 870176153C
        for <linux-mmc@vger.kernel.org>; Tue, 29 Nov 2022 03:44:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B8A6C433D6;
        Tue, 29 Nov 2022 03:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669693441;
        bh=PMP/QfNOctNe2oS/JANJSE31HDY5XY2hHuMrM+6+4+M=;
        h=Date:From:To:Cc:Subject:From;
        b=U90rh4zo92kPOUwnMSm0hlbzlX2WJE8wsRpTUsaZKF9EG2ymZDgagj2HDEOo0EARd
         S9V1KjvRPvCbm69ST+4IRaYVK5HywQe04mARXfe2mtOlBFc4pLGP5TNrYxMK9kbH+U
         P1ADaVVZnI+IObbFv2+NAOIweIHU3OXGtwI7N/FI/nbqNC+dkd41xGIsmJoG1+qjsO
         Dy6BC/0a5Vn7mo5C6DvkNf57IokEiYFSLT/mMLD7jb4tkDUVmhnsmPcK5ZC5qtdG8x
         TNmgvAofGZUUMMX54Q9P7Olg0OKgd8SjdcyONqHIE/z+HyVozp2DTP397F+pFEMbSG
         s0pW7ocCEGEdQ==
Date:   Tue, 29 Nov 2022 04:43:54 +0100
From:   Wolfram Sang <wsa@kernel.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org
Subject: Q: mmc: core: Issue power off notification in mmc_remove()
Message-ID: <Y4V/+jJxnQur4M9s@shikoro>
Mail-Followup-To: Wolfram Sang <wsa@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="k1T3YHhzYxaT5yOR"
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org


--k1T3YHhzYxaT5yOR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Ulf,

sorry for bringing up this 2 year old topic again, but we still carry
this patch from Shimoda-san in our BSP:

"[v3] mmc: core: Issue power off notification in mmc_remove()" [1]

You said you wanted to try some alternative solutions. Did this happen?
I was digging in the MMC core trying to find it but to no avail. But I
simply might have missed it?

All the best,

   Wolfram


[1] https://patchwork.kernel.org/project/linux-mmc/patch/1605005330-7178-1-git-send-email-yoshihiro.shimoda.uh@renesas.com/


--k1T3YHhzYxaT5yOR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmOFf/YACgkQFA3kzBSg
KbaN3w//VjKga7/JMi95nnyIPPT22eTqVj9HvPZ0X/DBbLqRTBEpvF8m5ZQjtq0O
W8jUFawf8dYFNaymUymBqnazj81O4lalPpP0+IScjWfdwlbxd75gx7EiBbMIYUZl
eujCgEhQZTmBUVpgw4bFUOFsRnuDRKZUx1zORXHM0Ltg9XNzqg/5iID/vJAu9jM8
bBvi6SafIedH1xKNKko+7/ICTuq24QDx3/HlyxO65fydY+1XLEp1xByCigSuSZ/P
5zFfdgBkN6kqn8sbkqve3vA0LeyPZskN7CY7tgEa0+QtwgTbkz703pZmsYuUDyCq
gB4zcRH0IAogQfG/C88Ic/CbYz1JLxmjxTpwEFoVGUOrCdhjjyUN9N7FuixmdGsZ
8XBHQBYUnlqtgpueWjIPUOFd6g/tNG3L3zcVnQZa6nxciAgrkJvvjZ8auWchwCs4
OZF/evnoet903jZkg+hSEfeDunOX3B1yV3drlf4FcEP89/83BxGfzZiHSch+PwCm
9dlcydwjeTFTpfVONZ4X+Q6/udE2zg3Ph43KRVFHu9nviucleBhKHZ+EtV/0qMus
IsIsC5pCfJkYkbo6/j11h8zbOOzDas+Wxc1EmrzZqxH4EtV8mgvlXa3GviPqDzIc
H7q8spIU/45cL1/xTrlVjZfHQZIUPOE6QfirTbFFKPpo+eGi9Ng=
=lwYZ
-----END PGP SIGNATURE-----

--k1T3YHhzYxaT5yOR--
