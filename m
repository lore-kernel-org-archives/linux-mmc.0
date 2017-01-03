From: Eric Anholt <eric@anholt.net>
Subject: Re: [PATCH 2/2] mmc: sdhci-iproc: Increase max_blk_size for bcm2835
Date: Tue, 03 Jan 2017 10:04:28 -0800
Message-ID: <87o9zonhoz.fsf@eliezer.anholt.net>
References: <1483111474-29907-1-git-send-email-stefan.wahren@i2se.com> <1483111474-29907-3-git-send-email-stefan.wahren@i2se.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from anholt.net ([50.246.234.109]:38480 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1760132AbdACSEa (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 3 Jan 2017 13:04:30 -0500
In-Reply-To: <1483111474-29907-3-git-send-email-stefan.wahren@i2se.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Gerd Hoffmann <kraxel@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, Jon Mason <jonmason@broadcom.com>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, bcm-kernel-feedback-list@broadcom.com, linux-rpi-kernel@lists.infradead.org, Stefan Wahren <stefan.wahren@i2se.com>

--=-=-=
Content-Type: text/plain

Stefan Wahren <stefan.wahren@i2se.com> writes:

> According to the BCM2835 datasheet the maximum block size for the
> eMMC module is restricted to the internal data FIFO which is 1024 byte.
> But this is still an improvement to the default of 512 byte.

Confirmed that the internal FIFOs are 1k.

Reviewed-by: Eric Anholt <eric@anholt.net>

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAlhr56wACgkQtdYpNtH8
nuhkhxAAgZuD0LniyBCeaTkbaJFNpVuSJOCFOboB3X7CMML86YmnlWA0SCEjiiSj
tZgj6EV+9j26Xt/mbVFnsg0GmD2Hq+bg8iyOz2PjQXM1NP1O9WXHK6qdf489uQ/N
eLlyRejToCUBT7VU1R5i0R/gf9g/Ha2OfFWU0U07lRi0KHvgzpb8BJw3FlD68KxT
8P3cdoX3qFh7UXMPn1LqsmKIPBWhkzkzZpxXlmWAxkpD8C7o8eyVT1hr1X4nM8Cq
TwXCrKmsuDKoXG4526hVvCxgBUG22bTVcqjjMZiq8P1t6GhYYnnYcwbGqt4cSWQ3
g/bJzc2dF4gkEfj8epy0qM6bqCt9ihWZsHbwgEKuLYLQoWhAMIIW+iMSNJGP67RH
wIPVXfFctRhnAooz8Nc8uNw7RX7fcpCCRWb0TtWdG2jVt2ndTv/vZ2SHUElsszJb
Y+X9GIb3CsUwKwbAt5a7MRw0VJXa3TsV0O+O4AYeYOe8Sc7+JnS0mic1prMOt/Rc
dz6QZKnQaxuecKLitt3SfBmcwvTeaOLGM9a1WXVhoQIaSdq2AJCMWOx+MiB4CweV
x3fymdWHQq3qqgHy+G9GgpTBfy+2AZN6XsYra1aMty27oySXvGJzyQVrlTJWWyzV
poV3AyF66wFROz8KWXdT0zgbad7T7lq0pBc1rnW1aXX4LoXIFNM=
=AbUr
-----END PGP SIGNATURE-----
--=-=-=--
