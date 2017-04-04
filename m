From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 07/25] mmc: sdhci-pci: Use ACPI DSM to get driver
 strength for some Intel devices
Date: Tue, 4 Apr 2017 10:48:47 +0200
Message-ID: <20170404084847.GB1439@katana>
References: <1490032253-6030-1-git-send-email-adrian.hunter@intel.com>
 <1490032253-6030-8-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="E39vaYmALEf/7YXx"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from www.zeus03.de ([194.117.254.33]:52082 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751843AbdDDIsw (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 4 Apr 2017 04:48:52 -0400
Content-Disposition: inline
In-Reply-To: <1490032253-6030-8-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, Al Cooper <alcooperx@gmail.com>, Jaedon Shin <jaedon.shin@gmail.com>, Haibo Chen <haibo.chen@nxp.com>, Dong Aisheng <aisheng.dong@nxp.com>, Shawn Lin <shawn.lin@rock-chips.com>, Douglas Anderson <dianders@chromium.org>, Zach Brown <zach.brown@ni.com>, Ludovic Desroches <ludovic.desroches@atmel.com>, Jisheng Zhang <jszhang@marvell.com>, Yangbo Lu <yangbo.lu@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, Weijun Yang <Weijun.Yang@csr.com>, Barry Song <Baohua.Song@csr.com>, Peter Griffin <peter.griffin@linaro.org>, Lee Jones <lee.jones@linaro.org>, Jon Hunter <jonathanh@nvidia.com>, Harjani Ritesh <riteshh@codeaurora.org>


--E39vaYmALEf/7YXx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Adrian,

On Mon, Mar 20, 2017 at 07:50:35PM +0200, Adrian Hunter wrote:
> Make use  of an Intel ACPI _DSM that provides eMMC driver strength.
>=20
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

This is an interesting patch for me because it seems I have to deal with
drive-strength soon, as well, for the SDHI driver. You basically fall
back here to simply read the drive strength value from ACPI, right? So,
do you think it makes sense then to have a similar encoded value from DT
(maybe "mmc-fixed-driver-type-<n>" with n=3D0..4)? This is a largely
reduced encoding of what you proposed in 2015 [1] but may be more
pragmatic for soldered on-board devices working on their max speeds with
fixed voltages and frequencies? Or did I get something wrong?

Thanks,

   Wolfram

[1] https://lkml.org/lkml/2015/2/16/273



--E39vaYmALEf/7YXx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJY413vAAoJEBQN5MwUoCm2AgMP/2DCbnXawk/2oJVilxclzayx
LgHL8emFKT5AZ09hxVqDBX74tokocsGkplHuXXGgJrFpIupGOwTvTF0DZjaCvxkV
0tPoi9a5LJkY5wr31UfOTP/8aVE2LQEs71DjfCzt5e+TOfZwr9HffmiP2wplwQ7L
3EZZvQ4MhQUKR5Sm1e/sDyd5eyLfjkL4yrVZd33l+pMdbnlBBU8+VKCXnG9fRtR2
O7grN25aWX6ax2qmbeh/20MmP4wWpfCs8f3h3FWNMLlavqNmkU5eH1uo7IJIvAbU
AFXTQ/SSldzMD4iwKJl7edMrDGKeZD/qLm7y+U4bE9fSyJi8yg4amCgIroVDavLk
sfEeoJ9JvXIQeALd5TEB2hXKR2XcwUq7SVVuWJ5D0Zkpp6k3gYGnzg1vsfkBilqb
LcqOHRKtZ9xYRNkGfQX3zT9azSP6wFOoiywgpWbalO10Wqj/J+QnW8HCTMnRtM5N
dV12AL7thyzIJ5nB0G6zIRPDGRT7sEWALTl1R03ymDCftM1BHzOWEnZcuJbTa9Jj
TzH49KT9uDjTVfmBVVgEXUKcnrahayewocyrs3jtUcVuFeujM8oFuvdCtZfyC9T4
iF3wxUjwAAHALoxvCdUd7lkFU4PuSYLwPuhA59rOXBt4310/U3KhufMSaSa1vthZ
tHA6SRQjUTmBEXQBO02n
=kQI2
-----END PGP SIGNATURE-----

--E39vaYmALEf/7YXx--
