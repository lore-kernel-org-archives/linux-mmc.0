From: Eric Anholt <eric@anholt.net>
Subject: Re: [PATCH 1/2] mmc: sdhci-iproc: Apply caps from bcm2835-mmc driver
Date: Tue, 03 Jan 2017 10:27:08 -0800
Message-ID: <87lgusngn7.fsf@eliezer.anholt.net>
References: <1483111474-29907-1-git-send-email-stefan.wahren@i2se.com> <1483111474-29907-2-git-send-email-stefan.wahren@i2se.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from anholt.net ([50.246.234.109]:38670 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1760159AbdACS2E (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 3 Jan 2017 13:28:04 -0500
In-Reply-To: <1483111474-29907-2-git-send-email-stefan.wahren@i2se.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Gerd Hoffmann <kraxel@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, Jon Mason <jonmason@broadcom.com>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, bcm-kernel-feedback-list@broadcom.com, linux-rpi-kernel@lists.infradead.org, Stefan Wahren <stefan.wahren@i2se.com>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Stefan Wahren <stefan.wahren@i2se.com> writes:

> Since the mmc module on bcm2835 neither provide a capabilities register n=
or=20
> free documentation we must rely on the downstream implementation [1].

Yeah, caps reg is wired to 0, but it can do high speed.

Since we're VDD_330 only, I'm not sure the driver type flags do
anything, but I'm still good with having consistency.

Reviewed-by: Eric Anholt <eric@anholt.net>

Interested in porting over the DMA support? :)

I also noticed that the emmc wrapper module claims it can run with a
clock from 50-100mhz, and the arasan says it can run at up to 50, 52, or
208mhz depending on SD/MMC mode.  Could we get a boost from running the
module at a higher clock rate?

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAlhr7PwACgkQtdYpNtH8
nui7UA//RT75RQ1XbJ2jqEw5ZmBMSA2sDsPkZxw+Oox1UiG7luKzoQX8P889lO8Z
wrR3d0plHBFoVe0d0yrc53qVkWlzBuuTPfh/QFRBQXWU3LZQmOWST1zBE9rVj0n3
+DcsEEl2aoiX+kAdtsXa0EZ+MUPP1w8YZtG+cWBhwbnFpjb2LQLLztj5E+BTnBu9
mnBhqcIDxlLC8raJ/cBixlD4onRmKb36tlLc/KZi2tIXRZwHXP34NAo6f5S6xDNt
LagJKhQG2qWuWvNH4xYhytqMv+emCLIi5ZCcM0tizOoN6IqjPqFxyZ6IW7UrU/kv
zGNEgNPNO5TopKIztWHeAWjubPdhC/eQ47497/BPWC+plD3ORdz4xz6UnKYL9ERP
ipcqMsOu4ti+kf/btYAJbkzMdv/5AqRhBmWIXJjRu/gXPCvhkdcGyTOqCRhB7PDr
JWzaAUs2R9BArUScwmJFngV5qlsVmVwuN9wMnWb8tPWOMSiOcGHpdD38qq85w6dM
M6wUcYq+0SoHd81HoH+lmTRx3uV5yTOvivFb0cQxE1Pss7AEYOhq6PIB8JWb9ZBL
aJ42Nt0RojTuP3uFEgywtgKU+Sqyi/ZLHoX3hLCTvCCnrn7RSgJyQxUBN/x51XQP
GL9pgbSvrIl7JSQiAlDT9RDX2vw8D/6cI2niMN3CXgx12CtUR2s=
=eRHl
-----END PGP SIGNATURE-----
--=-=-=--
