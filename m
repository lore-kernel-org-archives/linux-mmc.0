From: Eric Anholt <eric@anholt.net>
Subject: Re: [PATCH v4 0/7] mmc: bcm2835: Add new driver for the sdhost controller
Date: Thu, 16 Mar 2017 11:32:22 -0700
Message-ID: <87r31xysw9.fsf@eliezer.anholt.net>
References: <1488964751-22763-1-git-send-email-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from anholt.net ([50.246.234.109]:58814 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752848AbdCPSc0 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 16 Mar 2017 14:32:26 -0400
In-Reply-To: <1488964751-22763-1-git-send-email-kraxel@redhat.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-rpi-kernel@lists.infradead.org
Cc: ulf.hansson@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, lee@kernel.org, stefan.wahren@i2se.com, f.fainelli@gmail.com, rjui@broadcom.com, sbranden@broadcom.com, bcm-kernel-feedback-list@broadcom.com, linux@armlinux.org.uk, catalin.marinas@arm.com, will.deacon@arm.com, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Gerd Hoffmann <kraxel@redhat.com>

--=-=-=
Content-Type: text/plain

Gerd Hoffmann <kraxel@redhat.com> writes:

>   Hi,
>
> Next version if the bcm2835 sdhost patch series.

Still waiting for the subsystem maintainer to merge the driver before
merging the platform side.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIyBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAljK2jYACgkQtdYpNtH8
nugK2w/3e4YIZdq7YeHuSuBZIdB2fP815WJGvfI0fhg4+pnyprF/psaHkQujhrjT
TGs66BXQlrB1LfGgAKHQDzlEmMwij42DZmQ+SCXzpAVGbal1lgSSjD9HQZwPWo3K
lnYG+VWNwBGav2BTC0GHDb1FqUhUpTU/FmqzZI+GKe0KJfgg7x2aHLE5hdmwH6Cs
RdYiybIgTxgnk9N6NyrhP2mO6ElCPJ8E15fPnTxk7IzbzJ3NEo/0nkn8hJHZ/JOk
maxLKeAWKpKML/7QhkrVFuMgwFfc9Il2nTWSitT0qmPKnP8+5iE45od582iuQ78f
gruvYAX2zPLaP2t/9YLtq62Y01fUQgjNh444Of/x5ICdOOhMfE0Jjb69Mbg43NpD
Xpvp1w5qX65vyWP5U7ArZQVlMU/n6AubXyAS8uS4h9N5/uJ1hp6kmBR2QC0ziuAG
PsS9zkKrbEkwaRS2dVIyZsG2OSN3kfofI/hy5CJQMO1kh+Aaby+AMK4maL9jOQSU
5uhuAeBEPoH/pZOFFTyOdHpOCggaGvYz442RscLfGMM5w312lkepmzRicBMzIXVH
1IPC+90f1QZvTcaohp1sZZ0TyzVipsj+I++/z2JH4cdAPp9cBzuQb/UaSR/1Zzne
yOxkrLB3jlqY87/3VIgxek0DgEtaKnTTmUAngS8Wu/E2nGHs0A==
=dhYi
-----END PGP SIGNATURE-----
--=-=-=--
