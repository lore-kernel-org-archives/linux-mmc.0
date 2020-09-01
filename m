Return-Path: <SRS0=T3o1=CK=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A0DFC433E2
	for <linux-mmc@archiver.kernel.org>; Tue,  1 Sep 2020 10:24:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1CDB20C56
	for <linux-mmc@archiver.kernel.org>; Tue,  1 Sep 2020 10:24:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="w1A/+3iE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725848AbgIAKYX (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 1 Sep 2020 06:24:23 -0400
Received: from www.zeus03.de ([194.117.254.33]:45800 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726311AbgIAKYV (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 1 Sep 2020 06:24:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=k1; bh=BjZKy24CLqczsJHypRPS8Iz06ulA
        rDhDWR4SwPVg3JM=; b=w1A/+3iEKKim9AwotI6vGzTkTAKwq6brsJso0d1bNlTx
        sog6E2ZdT4NE7ygUs0B/498emICzeA3NeDEXH6wPZJG3p1ZIf+ysFrjMpRZdx0De
        89R3Kiaddvf2LMI4per7KOzHSkGnwlQavFCJnlWENYExGhJTek69jmICrm8Kspg=
Received: (qmail 2477913 invoked from network); 1 Sep 2020 12:24:17 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 1 Sep 2020 12:24:17 +0200
X-UD-Smtp-Session: l3s3148p1@xHfo6z2uILggAwDPXymmANnQBv1GRuIL
Date:   Tue, 1 Sep 2020 12:24:16 +0200
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH 2/2] mmc: renesas_sdhi: keep SCC clock active when tuning
Message-ID: <20200901102416.GA2971@ninjato>
References: <20200604112040.22144-1-wsa+renesas@sang-engineering.com>
 <20200604112040.22144-3-wsa+renesas@sang-engineering.com>
 <TY2PR01MB36923A1D7091431CE3F73195D8850@TY2PR01MB3692.jpnprd01.prod.outlook.com>
 <20200608212702.GD917@ninjato>
 <TY2PR01MB3692310754A6B4D6A05DADF0D8820@TY2PR01MB3692.jpnprd01.prod.outlook.com>
 <20200814071500.GA9410@ninjato>
 <TY2PR01MB3692C46B1A21109E7CC03478D8520@TY2PR01MB3692.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qDbXVdCdHGoSgWSk"
Content-Disposition: inline
In-Reply-To: <TY2PR01MB3692C46B1A21109E7CC03478D8520@TY2PR01MB3692.jpnprd01.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org


--qDbXVdCdHGoSgWSk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Shimoda-san,

> I got a report from a colleague about this issue. According to the report,
> this issue is related to retuning. When retuning happens, the mmc core
> calls mmc_hs400_to_hs200() and then mmc_hs400_to_hs200() will set the clo=
ck
> as 52MHz at first. So, it's possible to cause the issue.
>=20
> It's difficult to cause retuning in normal situation. But, according to
> the report, if we add a code which the sdhi driver reports an error
> at the first CMD18 once, we can cause retuning and then the issue happens.

I took the liberty of a different approach because I wanted to reproduce
the issue when doing the initial tuning and not a retune. Because my new
series adds (and checks) a flag for doing_initial_tune, so I really
wanted to excercise this code path. This is a real problem, too, because
I saw this with my boards earlier back then.

And halleluja, today I saw it again, once. I switched to my H3-ES2.0
board which I haven't used for weeks. And when booting that for the
first time, I got a failure including logs. Later boots just went fine.

And because of the logs, I could finally inject an error which will
reproducibly cause the boot to hang because of a stalled SCC. Tada, here
is the patch:

=46rom: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH] GOLD: simulate stalled SCC

Geez, this took ages to find...
---
 drivers/mmc/core/mmc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 216bd1aed373..6b3056437b37 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1218,6 +1218,7 @@ static int mmc_select_hs400(struct mmc_card *card)
 		host->ops->hs400_complete(host);
=20
 	err =3D mmc_switch_status(card, true);
+	err =3D -EILSEQ;
 	if (err)
 		goto out_err;

Interestingly, the other mmc_switch_status() in mmc_select_hs400() was
not stalling the SCC. Anyhow, after this failute, the MMC core switches
back to 300kHz and the SCC clock is off but for some reason SCC is still
accessed. I will investigate why. The good news is that my new patch set
fixes the hang as expected. The board will continue to boot so we
probably want to have this series. However, I have the feeling that this
SCC access which hangs the board might be a bug because of an unintended
code path. I mean, this is also one reason why the bug triggers so
rarely these days. We have been fixing a lot of things and the SCC is
only accessed when it should be accessed. We will see. I also need to
test other boards, too.

So much for now, I hope I can report more later.

Happy hacking and kind regards,

   Wolfram


--qDbXVdCdHGoSgWSk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl9OIUwACgkQFA3kzBSg
KbZrsRAAqBLn5V3ZOaeNHiYrYdlFo62nukFYUH+yGD5RiEai16qD6npruMaUqMml
d/UzloiePYe5CWylaII0rFGNT+Xfq7/nx57g4V/cAFTYCOl+dT+97Xa6OBuSAnI5
aWbfRtYNeOrklMPjR0ywmigehUHFO2t/ks5DBOaAMgghfb+4MFJk/j56KkWBTlQJ
ZVFUqfsGisEmnLTNdVyLltKPWY9JKAMZTaVTeYO9xD2J3ObH5Ci5h7carjAw6kiu
agrYXZZgZzOnukCtb1XvUtkxgaNPQEZy0FwDv0Xv7hz6WF0LtLbVFZAa17eV4T7o
npm57nSceJ+sJC1poAL78qhuJzewWVLFBEgZTu5eXaTpW7GlJT1i8UXQwbGqDuQS
znfzEXYslpDYLYCy0JdWJjEK6f2WkJilf2K6ReTxncq14IVZJlk0KaFW/H1Dbnxv
c6RV2A0Qw06RbeB9eioHpSXyyR1OpKIdTdLj3Cyb19Ns4NSTiqzBcgaVu8p7I7AR
AOEA+NgpcEfcvjZI3/pQYF7J1QxJwLDyCJJmX2c24zzDlK1S4XwdrCIM63Gpisux
/Ek7vXUpRP+3cUOUdnR0BwYzv67iNC2F8ULe2k8YKFnmmhrnXQTCBos2W+QlcRGN
emT1fTfv1aYRuX1sDU/qkKFY4hKPFLAl8Jdzg8aeHLqVe2FSemU=
=LDzp
-----END PGP SIGNATURE-----

--qDbXVdCdHGoSgWSk--
