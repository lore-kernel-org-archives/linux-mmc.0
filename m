Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC5B3A75AC
	for <linux-mmc@vger.kernel.org>; Tue,  1 Sep 2026 04:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788237662; cv=none; b=S5Irz1hvfavikSWvUPYlM8Q+FaozabVzCvHOpqD1UyoEvNZ/4IQ9+sxNzIeMxFHNOLpzRJAs0EfRC6YqRckULfHHV5I4ODMI2/vaBomIZJV12hb6XqCdZOyFrhC4Rl6DM4t2gC00mWW5PlzB+CO011cgko7P3/YjZwRT8PQT9Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788237662; c=relaxed/simple;
	bh=fogOGiECK46KlKG6A90Hn/KlqqibbAb1EYawhy5Q3e8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AUWCldYo9Pz+eU10svHoEtmrj2qe+YvvL/+WQ7YJjOyK+9sOfyXB912+J5JC/9Ia2j/1gg+mxVXWHIz8Hv5Mef6a7+nSdOqn9Rik72P+2rDw94+d4Mv+1G4HUnpOXyGN8EIKGgLG8FdrolKEyx5+oxlba4BUt9JO5jPDP80nJ1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U1Ki526U; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U1Ki526U"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-38759bcd877so4249000a91.2
        for <linux-mmc@vger.kernel.org>; Mon, 31 Aug 2026 21:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788237660; x=1788842460; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Z+IXFWSB63JkB5NPYaCMrM5Ux3r1uuXw5+BbmZrpfR4=;
        b=U1Ki526UzcU7HSRfP0dbKkJq4UBNwubEWklY6ykphDoDHG5PTa3gNpMn+dVBWCCuzS
         ZQ+8vFHxmF3OiTGfut2jG4uJDjaujVCyw/mjxiop17oFdjtMIKbhXKgV1EV/YsaamLl6
         rQwflboxTyBDWgVUyRCxM5UtCtwraBs8/IQR2borP6/YfbL3w59cz2BDbpIol+rzzPZV
         /BgLK+q/JL2rVpQ50Jwt/B0heYTIoKxk06DeCiwqoBWDXRPU0PRRCyBE58EK8fu4RztD
         2is1Kc0spBKmeZhp/qygY+cNk9a9zt59j5U4hqHhOuGrm55ThMRn6eK0gDXP6bTIdb5/
         40xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788237660; x=1788842460;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Z+IXFWSB63JkB5NPYaCMrM5Ux3r1uuXw5+BbmZrpfR4=;
        b=m7zhUY+VwFlB2GYgEtRIm9aeWfSd5dbSdb/5dP3D2J6h3fpqdjp7Rt5Y/OzBzChuIK
         S1zq4xLp/utHMIlWe/9tjjkGNGiqUnfrcUqZY1sb/kWW0rNKJpBwRA3cZFu9gnKGm/Zd
         KJiFDamGZvVV7FkOvCmAqb3r5bINrqHiKAfGPoYVj+//K7Jk34xTIXxaobJednItdNok
         Bgn2nKBZb1FG30wd18P6k4Sf/czJhLiX2jSWX2Xbmd8rKixpZvWbsl0O7wJFRErlj4OG
         8bLaDfTgbKKYrAE7qw7tbbFjoKWYEihauwKNTCLxzHwtq2qayDlSxCk786PnWKAZRfCV
         nrrA==
X-Gm-Message-State: AFuF++lVsJyeZFkwidK0OYSm463uPKgTrLHRWvQ+ZDHbU5PTofAO5QZK
	3qzzaMo2eiLv938c0cSfiDiTPhgCpYbu16KgKrv7xlRMXsmwFUJkTCE3
X-Gm-Gg: AYBFou0niubuNs3M9Vc08EvfOggzs6WTd1eMPvEOWuuPH1syqQ0cUUlyz+kMjmEXQz6
	l1dcs5K0zf4PygZrjxX4kUR9sCXM9gbUJqi1e4UL8syx/lMzpizme2JriVh6zaiZZT6Knw+3hJM
	j4TCQdWuQzUNo7bnlz9muPsAJFSAr8HPHIm0VOEeaJT1kA//zfS2HsjdT/WP6qlUaX6E+NXSv02
	HKp+kMCGJhV025lpUOr4E5Lz2uWqqAvaxlzs9kvSpWTmJpF//Da1RIWFWM8Z5oZSUhQtLRsXWfL
	DSMqDtrfbOiAmuHRKD+8wXQIZ3NGDsKEqptVWahI24FwK10rRqY6BwSC1YEai9j0uWLUYBEq9bf
	ownN+Pr4J1W11VN+lJoJJB4DNSCziq4B8TUwbRO3udmXYk3SEiHSJMGcIwYQKLGtZlJnH2wf+GL
	umUBprxOHvfhdPqSpGgX5zCPoR8mGcxdUia8LCUn6MBiGao9OOdnDZ0DKv+BLe7NbTLVPp
X-Received: by 2002:a17:90b:2b4b:b0:398:9beb:5c18 with SMTP id 98e67ed59e1d1-3989beb635dmr33964438a91.19.1788237660571;
        Mon, 31 Aug 2026 21:41:00 -0700 (PDT)
Received: from i386.168.1.127 ([2402:a00:163:2ce9:6882:91b7:8e79:7958])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-142e0de4de3sm45447647c88.12.2026.08.31.21.40.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 21:41:00 -0700 (PDT)
From: Hrushiraj Gandhi <hrushirajg23@gmail.com>
To: ulfh@kernel.org
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hrushiraj Gandhi <hrushirajg23@gmail.com>
Subject: [PATCH] mmc: sdio_cis: use strscpy() instead of strcpy() in cistpl_vers_1()
Date: Tue,  1 Sep 2026 10:10:54 +0530
Message-ID: <20260901044054.346524-1-hrushirajg23@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cistpl_vers_1() copies each NUL-terminated string out of the raw CIS
TPLLV1_INFO data into a single kzalloc()'d blob shared by all of the
strings, using strcpy() with no bound. The strings are already known
to be well-formed within `size` bytes by the counting loop above, so
this isn't currently exploitable, but strcpy()'s lack of any bound is
still worth removing on general principle.

Track the end of the allocated string storage and use strscpy() with
the remaining space as an explicit, always-safe bound instead.

No functional change.

Signed-off-by: Hrushiraj Gandhi <hrushirajg23@gmail.com>
---
 drivers/mmc/core/sdio_cis.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/sdio_cis.c b/drivers/mmc/core/sdio_cis.c
index afaa6cab1adc..24f670a798e2 100644
--- a/drivers/mmc/core/sdio_cis.c
+++ b/drivers/mmc/core/sdio_cis.c
@@ -27,7 +27,7 @@ static int cistpl_vers_1(struct mmc_card *card, struct sdio_func *func,
 {
 	u8 major_rev, minor_rev;
 	unsigned i, nr_strings;
-	char **buffer, *string;
+	char **buffer, *string, *string_end;
 
 	if (size < 2)
 		return 0;
@@ -57,10 +57,11 @@ static int cistpl_vers_1(struct mmc_card *card, struct sdio_func *func,
 		return -ENOMEM;
 
 	string = (char*)(buffer + nr_strings);
+	string_end = string + size;
 
 	for (i = 0; i < nr_strings; i++) {
 		buffer[i] = string;
-		strcpy(string, buf);
+		strscpy(string, buf, string_end - string);
 		string += strlen(string) + 1;
 		buf += strlen(buf) + 1;
 	}
