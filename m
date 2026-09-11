Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA2C5964FC
	for <linux-mmc@vger.kernel.org>; Fri, 11 Sep 2026 20:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789157389; cv=none; b=VA1H35bROpr4qAlB6Dmld6mmMJJsaAOKAXUlhdxxti/0zPcaJat64+LR894bHJ04xLUafd5ZT5KgplC5PkuCkwOYHEVs3ot4iBT+ykWewnsH+2lnZ7DV/Wcr5y4Dmut/VBosyESZhLlJu0Ga+9zlb8hUQvXVWbZ9DNQ69nHPB2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789157389; c=relaxed/simple;
	bh=gmphqcEHcmAbexF/WCs3NH83ZiEUKXidY90kjcoEzW8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=OsdD2X5oTB4IKmUfhx2iMXRUzoFVcevwMuIqCWMpBe55wHLCSz3DCucEQCne35CFvwnbsMjsM/rqU9bPGkQ34ixTVHWgQXbJtOlJVyeGQB/jpae+bsmcWSZWlenzRmd7dmKoZuJgHl2V59s1kUFghxwlvNVbLCvw0ol/qNMcYOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I75AqLEZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I75AqLEZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A151E1F00893;
	Fri, 11 Sep 2026 20:09:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789157386;
	bh=yQ+Qwoy1152BiqFRKDQHly3+iWczPAKUHqOzYbU3KKU=;
	h=From:Date:Subject:To:Cc;
	b=I75AqLEZeFp+pOgoogsb7XctB5FwKp8bE1Tp9pbSWr6kjynAUu14wx73Ls6oqatTu
	 aMSVpykNQQ0kOhnBY6dE6y4h/lrsQNWdAMOzPmLojoBXzojnUqCj8xeNijwPkDdO4F
	 W226N5J4+tHFXE7aJ0fyP5Ove/D1mQ9TojsdLGJVQQgJbgZUWzMsB7nUKsebyWYwOL
	 SNK3ZXnDu5kmuaynb+3bgJ50zhFHz6FDWIcHItQcusCjQYkE6pI0+hFKmpuHGgSaDF
	 zHj+5VcVkVfdmPKA/hg3+V78t45Cp38xjkvNjlxJ6jDcsKhlAXUq3Aif3FAhX0ZU0l
	 Jldq/fvqqgW0Q==
From: Linus Walleij <linusw@kernel.org>
Date: Fri, 11 Sep 2026 22:09:43 +0200
Subject: [PATCH] CREDITS: Add Pierre Ossman
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260911-mmc-credit-ossman-v1-1-9e914bf2a57a@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQrCMBBG4auUWTuQtBKLVxEX6fSvjpBUMq0Ip
 Xc36vJbvLeRoSiMzs1GBS81nXOFPzQk95hvYB2rqXVtcH3nOCVhKRh14dksxcz+eIphCoLeg2r
 3LJj0/Xtern/bOjwgy3dE+/4BWJjCJHUAAAA=
X-Change-ID: 20260830-mmc-credit-ossman-147a6f6ce81e
To: Ulf Hansson <ulfh@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc@vger.kernel.org, Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.16.0

Now I have a bad conscience for removing Pierre's name from
every dmesg without properly adding him to the CREDITS. OK,
it's an easy fix.

Fixes: 366b5941566c ("mmc: sdhci: Stop advertising the driver in dmesg")
Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 CREDITS | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/CREDITS b/CREDITS
index f8a33916e2a5..bcc2ce59b935 100644
--- a/CREDITS
+++ b/CREDITS
@@ -3109,6 +3109,11 @@ N: Peter Oruba
 D: AMD Microcode loader driver
 S: Germany
 
+N: Pierre Ossman
+D: MMC maintainer 2006-2009
+D: First SDIO implementation
+S: Sweden
+
 N: Jens Osterkamp
 E: jens@de.ibm.com
 D: Maintainer of Spidernet network driver for Cell

---
base-commit: f7e3f4d9f425cf4c5577cd84a096e6e618488083
change-id: 20260830-mmc-credit-ossman-147a6f6ce81e

Best regards,
--  
Linus Walleij <linusw@kernel.org>

