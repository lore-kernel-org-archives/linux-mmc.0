From: Eric Anholt <eric@anholt.net>
Subject: Re: [PATCH 2/2] mmc: sdhci-bcm2835: remove driver
Date: Fri, 03 Jun 2016 17:02:16 -0700
Message-ID: <87inxp7ref.fsf@eliezer.anholt.net>
References: <1464983233-27001-1-git-send-email-stefan.wahren@i2se.com>
 <1464983233-27001-3-git-send-email-stefan.wahren@i2se.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2655772443303433652=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1464983233-27001-3-git-send-email-stefan.wahren@i2se.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Stephen Warren <swarren@wwwdotorg.org>, Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>
Cc: Stefan Wahren <stefan.wahren@i2se.com>, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

--===============2655772443303433652==
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain

Stefan Wahren <stefan.wahren@i2se.com> writes:

> The sdhci-bcm2835 is no more needed since it has been replaced
> by sdhci-iproc.

We've had a cycle to catch regressions from the merged driver, so I'm
happy to see the old one go.  Thanks Stefan!

Acked-by: Eric Anholt <eric@anholt.net>

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJXUhqJAAoJELXWKTbR/J7oOzQQALoMi7JZzb8/kN3oVJt5UJwK
mmoPQnOpd946Y1Gm/eyjdPG9S+W+9gBGQctubhTVddthMsZWYcfylud70Bsral6S
N+dS7o7QLKCmk9fPOdN8MlYpfncHBOQbNMaEY2WEcHnd58uAV+CMME2p1WtTLJbd
tdWrDpN8qrrc+nsLB32bjTADExhSY5krSoGj+AeBB7okHvhFM6HTIwnDWjhnkOiC
KjXJadqbisUCWBPhW5vhWmNhLnFEt3IV/QtKGp9rm9IG6yCJp8MtzkcSlTt5s4qq
OhWKggyLM74fm8vByiXqqnR6xzQlTi4fKg+mimZnyzgYap4vdgynGhbmGr+8Kbpu
XraUWdbGG1X4Yr8v0W3j3mShtYEHK7JckNc5/90d9q/PNKhCSSCbCKGu0fjmsqZu
wP2h/xKwZQZn1R63Gks3cYRk1e7gwObmQ1GQQmpOxniB+d/Xwp+glETMnqu7YRP2
9xMUrEBlogZs/fC4BLKTfXH5U5Ggvpa8ZRfxxdGTt/4LFPCkLjAdd+VJZax92F2x
ljSx8IpJX5UmsHzxhHSO279Xi60DwhBPy48zy8KX+Nv+Y1JO/MzIFY5gD16lUT3B
gyMXXooIxjFv51JVZGS87FeREx5flLZvYvap0hf/DseeTkpME1568EjsB+JXDytt
SHwV+9r0r7vhCNNkKX1x
=CbU3
-----END PGP SIGNATURE-----
--=-=-=--


--===============2655772443303433652==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============2655772443303433652==--
