Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A8AA2E8B9E
	for <linux-mmc@vger.kernel.org>; Tue,  4 Nov 2025 20:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762286442; cv=none; b=QQMG+7/+iV/jZln46TaYBnPn+52iKgsfO/IkO9W0dKthEF/8n2rFOadUe3Exur7ppM+hvq1+DioRZVbh5veuh6IPy6wqcErKQtbKmGN6j95CQ0hkOWg7djXIjzT1fNKeICJT770ET3L02efE20OSOiNioYPPPyZkTQ0LftxUxs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762286442; c=relaxed/simple;
	bh=3qTAnNVoQqtYdxF0p0eXWGODlgYTinAY/C87s3jsGpA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=LexZB/uPkG3TSWO4Xd5X1/A2E3Ch6HPlsag05h1R2Iv+bRY0lM1QNSncchwLyxPf//h38P3GuE+CcgSbc5H53Z6ZLW5HZ0lsGUw6bhQOSPwdDkfqDUUMxqINDHIn4FDEf/wpZHM/noYO+a9SGg/ixc+Ru85+m5XmQ+Mr2x2DVSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=korsgaard.com; spf=pass smtp.mailfrom=korsgaard.com; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=JzDcIHW6; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=korsgaard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=korsgaard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="JzDcIHW6"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=JzDcIHW6o+WliAe8kjgpTqnw6baVGZf7YOVAkiLxLXW0rkh1bVog2s3YV+MADqb15Cchje3fPYhX1E62TKHSAG7HT4ZwhCLaOltPiHY0diyIa6/lrIsDUliUzozolEyNnxHWY1BgE6vwvdYiefJ9XgJHRjV54vLgIx2OsEBKp6g3uZtdRRxrdUPpPvNX10XBU/AAqhpP/ELWYOhsuOblUAgGYnpzeaqtMaVRr5O6Lr/LGk9Ev2KUNoRJxcXoBmW4gjAv27E+gs3DfZBntmCY1P9IvfKfVFdA5hzYisWKlBsH0UPLnc7QMdlKsN1RbzCfHlpjCeyPU64SKB1/ckKFbw==; s=purelymail1; d=purelymail.com; v=1; bh=3qTAnNVoQqtYdxF0p0eXWGODlgYTinAY/C87s3jsGpA=; h=Feedback-ID:Received:Received:From:To:Subject:Date;
Feedback-ID: 21632:4007:null:purelymail
X-Pm-Original-To: linux-mmc@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -883964821;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Tue, 04 Nov 2025 20:00:32 +0000 (UTC)
Received: from peko by dell.be.48ers.dk with local (Exim 4.96)
	(envelope-from <peko@dell.be.48ers.dk>)
	id 1vGNCh-003wZP-1q;
	Tue, 04 Nov 2025 21:00:31 +0100
From: Peter Korsgaard <peter@korsgaard.com>
To: linux-mmc@vger.kernel.org,
	Avri Altman <avri.altman@wdc.com>,
	Ulf Hansson <ulf.hansson@linaro.org>
Cc: Peter Korsgaard <peter@korsgaard.com>
Subject: [PATCH 1/2] mmc-utils: lsmmc.c: print_mmc_cid(): correct year/month parsing
Date: Tue,  4 Nov 2025 21:00:07 +0100
Message-Id: <20251104200008.940057-1-peter@korsgaard.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail

The parsing logic for the MMC manufacturing date had the year and month
swapped.  From JESD84:

The manufacturing date, MDT, is composed of two hexadecimal digits, four
bits each, representing a two digits date code m/y; The =E2=80=9Cm=E2=80=9D=
 field, most
significant nibble, is the month code.  1 =3D January.  The =E2=80=9Cy=E2=
=80=9D field, least
significant nibble, is the year code.

Notice that this is the opposite of the SD bit ordering.

Signed-off-by: Peter Korsgaard <peter@korsgaard.com>
---
 lsmmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lsmmc.c b/lsmmc.c
index 799e1ea..7331c1b 100644
--- a/lsmmc.c
+++ b/lsmmc.c
@@ -589,7 +589,7 @@ static void print_mmc_cid(struct config *config, char *=
cid)
=20
 =09parse_bin(cid, "8u6r2u8u48a4u4u32u4u4u7u1r",
 =09=09&mid, &cbx, &oid, &pnm[0], &prv_major, &prv_minor, &psn,
-=09=09&mdt_year, &mdt_month, &crc);
+=09=09&mdt_month, &mdt_year, &crc);
=20
 =09pnm[6] =3D '\0';
=20
--=20
2.39.5

