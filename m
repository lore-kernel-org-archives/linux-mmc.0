Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35B612E8B8C
	for <linux-mmc@vger.kernel.org>; Tue,  4 Nov 2025 20:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762286439; cv=none; b=Z33JN16FpMWywk3sonoT5y6MUcQ2V2sB/cqUccVtT4zwC90ZsENDIy5M/CfyC7McCsHzYzonTtjoOqaBzROlQw8qwMbapZ23/q6wvE1hgyYC6KF5DqJ0hvCt60z+1GUZ5f7DI2suMmk9h/qe83sSpPVMuZSW5vclwx5LTJ6fSwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762286439; c=relaxed/simple;
	bh=UjtBXRqUvaC986gZhu+DGorynCqXZc/AMxXpV7RS1Is=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Pn5xKNYUcWeAHTtnXOStmwkEeoG1q3O9k7YnAEHl+sJDiPc8reWROS5qxiwKdAIGpxT3VIsXAKbtO9pKAmno9CBDOS9Y4LFhn9OhGHfpQo2EALgwRiUFvkRmOUfn8BhBZC8cDChp/KvMg8/G8vV5eT1qWQfm/Mt925Yj3de5l4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=korsgaard.com; spf=pass smtp.mailfrom=korsgaard.com; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=FwwTUard; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=korsgaard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=korsgaard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="FwwTUard"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=FwwTUard+tKjbJZ5rfscjfy8otlyc50JLj4i2/3bgy+59e7tmzxrSoT9zLBOkXHLS2dPPwsDs9KWzG+IiuBSyFoqnGMIpvHI2ph5T4MVzDmpvinfyp/RUdxdHS2DYVsPTaubzcOIKshdbu4N+ahorONEcZOGZXR5KxfbZwAG97MFaOHuVeUpDSNV9lgM6tgQDULoNWw9pR+T1nn3vo1PnpALp5L62Ppjh9c79PZn0UknwJ4XMbMI2y4lL3JD2HkUfmwATJCKtI2CalX0SD9/vUvGcyQUx4tvORfhGNRuHo7DXR2+16DmooclkQpL6zKr4SQ28/U5rKn8+/HDdjjHQw==; s=purelymail1; d=purelymail.com; v=1; bh=UjtBXRqUvaC986gZhu+DGorynCqXZc/AMxXpV7RS1Is=; h=Feedback-ID:Received:Received:From:To:Subject:Date;
Feedback-ID: 21632:4007:null:purelymail
X-Pm-Original-To: linux-mmc@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -791295020;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Tue, 04 Nov 2025 20:00:32 +0000 (UTC)
Received: from peko by dell.be.48ers.dk with local (Exim 4.96)
	(envelope-from <peko@dell.be.48ers.dk>)
	id 1vGNCh-003wZS-1v;
	Tue, 04 Nov 2025 21:00:31 +0100
From: Peter Korsgaard <peter@korsgaard.com>
To: linux-mmc@vger.kernel.org,
	Avri Altman <avri.altman@wdc.com>,
	Ulf Hansson <ulf.hansson@linaro.org>
Cc: Peter Korsgaard <peter@korsgaard.com>
Subject: [PATCH 2/2] mmc-utils: lsmmc.c: print_{mmc,sd}_cid(): correct month names
Date: Tue,  4 Nov 2025 21:00:08 +0100
Message-Id: <20251104200008.940057-2-peter@korsgaard.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251104200008.940057-1-peter@korsgaard.com>
References: <20251104200008.940057-1-peter@korsgaard.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail

The month nibble is 1-based, E.G. from JESD84:

The =E2=80=9Cm=E2=80=9D field, most significant nibble, is the month code. =
1 =3D January.

So mark 0 as invalid and shift all month names.

Signed-off-by: Peter Korsgaard <peter@korsgaard.com>
---
 lsmmc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/lsmmc.c b/lsmmc.c
index 7331c1b..dd3ab83 100644
--- a/lsmmc.c
+++ b/lsmmc.c
@@ -512,10 +512,10 @@ static void parse_bin(char *hexstr, char *fmt, ...)
 /* MMC/SD information parsing functions */
 static void print_sd_cid(struct config *config, char *cid)
 {
-=09static const char *months[] =3D {
+=09static const char *months[] =3D { "invalid0",
 =09=09"jan", "feb", "mar", "apr", "may", "jun",
 =09=09"jul", "aug", "sep", "oct", "nov", "dec",
-=09=09"invalid0", "invalid1", "invalid2", "invalid3",
+=09=09"invalid1", "invalid2", "invalid3",
 =09};
 =09unsigned int mid;
 =09char oid[3];
@@ -570,10 +570,10 @@ static void print_sd_cid(struct config *config, char =
*cid)
=20
 static void print_mmc_cid(struct config *config, char *cid)
 {
-=09static const char *months[] =3D {
+=09static const char *months[] =3D { "invalid0",
 =09=09"jan", "feb", "mar", "apr", "may", "jun",
 =09=09"jul", "aug", "sep", "oct", "nov", "dec",
-=09=09"invalid0", "invalid1", "invalid2", "invalid3",
+=09=09"invalid1", "invalid2", "invalid3",
 =09};
 =09unsigned int mid;
 =09unsigned int cbx;
--=20
2.39.5

