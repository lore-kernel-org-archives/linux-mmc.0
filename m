Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF201B4257
	for <linux-mmc@vger.kernel.org>; Sun, 21 Dec 2025 08:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766304742; cv=none; b=T51hNr877gp+egu4Nf/VyDCYqXzLW/k8Qfq/+YNfFfRKtxy2lw2mBtiq5ju8ra8CU0Uo4JqQtuQU48PQs+wKLzZepzbbdwpPi4lzC+7Pb84SffnJNiTDV1fFfcDBmeXkjD4gFqr2pvZ7ZdfQLkKqJvxmMzpkTJ9/VvOJP+f9RZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766304742; c=relaxed/simple;
	bh=ltObjjpZX+oPzbIgJY/dZY1A6l2IaBaevTzoiFzjl9Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nEOOEM+WS+Tw6JU+VS7SVkTiL/eRCcf9P8DRtZQ+oI4idK9Y2kgnAgNvUi3JtAccKspANbKAIJX9PYzj2GscA3U4H5U4W/GihN8R2QtyNsp+bj0IlA6VGGDHmVV40ThjMApvb82P3kjr2wuKmBAvf5/zHTodqfoA/2H4U3BV314=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OGVFLiXZ; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OGVFLiXZ"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-4308d81fdf6so1395788f8f.2
        for <linux-mmc@vger.kernel.org>; Sun, 21 Dec 2025 00:12:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766304739; x=1766909539; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gDvqrrfvlUBpws4CdKf/ed7ueYYTJ23PiR0bhQM9K4A=;
        b=OGVFLiXZwJgFFKqHFjtkfouOtAeEwsXjI/7N96jjCxC1rYQfFOIs9UUXs4AVGarxR7
         fZ1q0cf3uFn6ayddnn6KmIkxQ5S8W+xn8jIMWJa5XbtXyKxmTVWT3H5IY+Lo+Pt+OuZ/
         tYQLpoTi/e/puhT/4OcJLAgQflMPV9LJVgLZJHqKnVZ9Fl1KBc58vufyfZ6gCMpaoLlM
         KiDiXa9DT5SCW18iachQ1+zQj90TjrAObO7Z46/PBwHW8GQDsCpKI2WIbSbwSvEHCSOn
         4sehZNM3eBENC/Q784PfrtHlBCodynekTh+eHgJ2K5Drqn3ih/YhXrlaa7sWUl6BKyVi
         Oh/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766304739; x=1766909539;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gDvqrrfvlUBpws4CdKf/ed7ueYYTJ23PiR0bhQM9K4A=;
        b=K+ZAaMftn3k5clVhXNmMe8BxL2N0keTW3pZT0n9bdFkOg2ms7hUIMBPdsyIH2y/U+I
         X2us5Js1keiFU/okzA0VeqvSN4BXjYvr8/XWBFcOgWJioMPDqFJq1TPuDfBbao87EsGC
         Rnk6mSoaqAg6Heuo82b0UxD6k80JvWvOUeMaVKAGK+PDJq9oe478qBwA41+S2yn6LXjk
         EySpae8YX8lo1d3iTEPNnsyMibSlJbPwS3w+tfqkuwvgdA7DIBgwwOniWaAPKs7bDVTB
         woFU0okTrGW2PUyIaHQ5FHUVHu0CApQm2ETgT+9YOlX4xp0ZmUQU+MrNqJHEjFDylnJh
         SsNQ==
X-Forwarded-Encrypted: i=1; AJvYcCX6aUNwez1RUrj6LRQac4/igyaWfDn+ncUnpLccvJ/vxEz8lWNCkvKXr88C6hu0G02hwEyCZq9Fvrg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzisiVgLNd6LkNwrYPBoly8SyVJ+YIg7USWAJLfxar72Cxdx0+Z
	P0bOD4qaec7yNNgMglx5Sd4VXXpk5Tl0hWFpbNNOIo/10iWhrcYc5Lm1
X-Gm-Gg: AY/fxX5EgKGikgo0nrH1XHFfelz0QF1gqyDoaGtwf+2eySHZAcIApKjJt/AwRpERdHu
	jzPSVeArVT8PIC+KK1SSA/81wDN4T6GvRVHI/Wn4TmyPekEkz5/DiZf/mVBXG0QzWja/iHx0pk3
	es/DD0shMQUVZUhErMNcOZzOjmnXMP5L63J3mV/Rha33GmbuuAJMri5NbZyASjn/YkV5H6dMMxD
	feUCPahbai2H/twlMkmnQovXP/2VvM+fDIVMzoAZY1K6usH13m17bwZU9CSIV7DKiracrtKZAso
	F4crBJLxJWaKn9ldkA9g7xgKnvCMU/dcr776QUGlNUziaNoYrzgWY46LyrGte2e3lMo4vYOyhgi
	JRBvCnqofl6wc7ZIeGVhPclotsEeoMNvE/sQ5oDu4fOjG32OMOTTHsy12VJkXTfEwJkK+qVO3qd
	QHE3n86NvvKyaTL/Zq/JIBf1ipL45o3I5H0Otv0cXcfu667pWiP9Gl97RLSE181CGuqZIbWaQXv
	1pwtRB6xtVTX8QHUEiQjh1FRMHKodAR/Nk=
X-Google-Smtp-Source: AGHT+IFU9ArtB5sFOx4E7fFM747LfoNenEetLKaFo7EdnYxtmd+KRzV6rbGmsMZfuZ7/x8zz7rwFVw==
X-Received: by 2002:a5d:5887:0:b0:431:3bd:3781 with SMTP id ffacd0b85a97d-4324e4f935bmr8454146f8f.37.1766304738977;
        Sun, 21 Dec 2025 00:12:18 -0800 (PST)
Received: from avri-office.sdcorp.global.sandisk.com (212-235-122-32.bb.netvision.net.il. [212.235.122.32])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324ea1ae12sm14423075f8f.6.2025.12.21.00.12.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Dec 2025 00:12:18 -0800 (PST)
From: avri.altman@gmail.com
To: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org
Cc: Avri Altman <avri.altman@sandisk.com>
Subject: [PATCH] mmc-utils: recognize ext_csd_rev 9
Date: Sun, 21 Dec 2025 10:12:07 +0200
Message-Id: <20251221081207.4724-1-avri.altman@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Avri Altman <avri.altman@sandisk.com>

JEDEC JESD84-B51B, released in September 2025, increments the Extended
CSD Revision (EXT_CSD_REV) index to 9.  Thus, update the `read_extcsd`
command to recognize this new revision value.

Signed-off-by: Avri Altman <avri.altman@sandisk.com>
---
 mmc_cmds.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mmc_cmds.c b/mmc_cmds.c
index 5990502..fbf8e7d 100644
--- a/mmc_cmds.c
+++ b/mmc_cmds.c
@@ -1524,6 +1524,7 @@ int do_read_extcsd(int nargs, char **argv)
 	ext_csd_rev = ext_csd[EXT_CSD_REV];
 
 	switch (ext_csd_rev) {
+	case 9:
 	case 8:
 		str = "5.1";
 		break;
-- 
2.34.1

