From: Valdis.Kletnieks@vt.edu
Subject: Re: [PATCH] PM: HIBERNATION: add resume_wait param to support
	MMC-like devices as resume file
Date: Thu, 29 Sep 2011 08:30:01 -0400
Message-ID: <59872.1317299401@turing-police.cc.vt.edu>
References: <1317288548-19560-1-git-send-email-Barry.Song@csr.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1036539712=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: Your message of "Thu, 29 Sep 2011 02:29:08 PDT."
	<1317288548-19560-1-git-send-email-Barry.Song@csr.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Barry Song <Barry.Song@csr.com>
Cc: frank.hofmann@tomtom.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, workgroup.linux@csr.com, rjw@sisk.pl, pavel@ucw.cz, Barry Song <baohua.song@csr.com>, linux-pm@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

--===============1036539712==
Content-Type: multipart/signed; boundary="==_Exmh_1317299401_4421P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit

--==_Exmh_1317299401_4421P
Content-Type: text/plain; charset=us-ascii

On Thu, 29 Sep 2011 02:29:08 PDT, Barry Song said:

> This patch adds resumewait kernel param just like rootwait so
> that we have enough time to wait mmc ready. The differene is
> here we wait for resume partition but rootwait waits for rootfs
> partition.

OK, seems a reasonable idea...

> kernel/power/hibernate.c |   16 ++++++++++++++++
> 1 files changed, 16 insertions(+), 0 deletions(-)

We have a __setup() parameter, this patch appears to be missing
a hunk for Documentation/kernel-parameters.txt?

Fix that issue, and you can stick this on there:

Reviewed-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>

--==_Exmh_1317299401_4421P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFOhGTJcC3lWbTT17ARAjcbAJ9hqeFvA1FK4z3s4R/KevywFcmyKACgtGnI
QJpEBIgiSQbQUp+U16+tHfs=
=aeYo
-----END PGP SIGNATURE-----

--==_Exmh_1317299401_4421P--



--===============1036539712==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============1036539712==--
