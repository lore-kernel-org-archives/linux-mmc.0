Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C76F24B28;
	Fri,  5 Jul 2024 10:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720176690; cv=none; b=oWLpov2lPP5fjNvoG84UY7P6GblKc4d+DkWpNHOTwkpXRAfLEc0qHRFwrINxGNh433i16bgDRQBiNjvmTcWByEaoGqAfX1sKtR16xKmicaTKZxDhn7M0+gjuQ1aoH+r3pjuk8l7Q1tRDHILVDioB8mzqPIa3gS/hXgVsljuweHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720176690; c=relaxed/simple;
	bh=DGTH126eFM0R8kz9es0Gnq4h/3IHDY4vjazCHvSRvlo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ciXxL1uuT90X6I7P4cqIzvVzGPERqgUNNKzPHKbJokOI1rQODQlPzQv+Ap9UM7iqh5P79l5CgiPT1qmItpt8Yp22GCVBqAl/46Khh0rKHdYPQ8Za1Psal1ajTbpN4e0NgxJ7+oaCi8YUdcBhMbqmTtuG3HdY+nS0CmhSk01OoCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MbUoJ09m; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MbUoJ09m"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-58d24201934so2369386a12.0;
        Fri, 05 Jul 2024 03:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720176686; x=1720781486; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JL3weazmmkxmyZdC6ciYHOna5cNAoVZOW7KlwIYW0CE=;
        b=MbUoJ09mOEGzhKLEPMBH6SV3wjuBa86nPF8uXz7Q9cVLel+3fsIFsuClPtOW0E4nmj
         Ts/w+vsJEBif6Psd+9ViDI7U8GKWxSvgp9UZ6d83tiof/nP/M4L/A22h7FU0GH4ccMDX
         pmrTIire/fFfMXh3Twr446XhTXIwt+Ax5YTiMMAGFB1L3dhvACHlJuJVEcti/3+V0Hfx
         xU8/w9J2YXMwIhrCp0bxYWmmGHQpbty5L7Ip8n92BR8cYoK7Sm7lPDxD01eumArr0AHt
         CHfLZbmmmqL54nXzw9p5uOn291LhQmQrFl5tfQLRd7q6KcJ+z826E+83j1UOrosf/bgn
         DbEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720176686; x=1720781486;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JL3weazmmkxmyZdC6ciYHOna5cNAoVZOW7KlwIYW0CE=;
        b=rWTT+AWeVb5xgZOySkkLULkKRD8wbZ+eskZKQhBteTMENEOmeSloo3MMz1b3tNBxcq
         ZRLNK6+QH+cyrEq5IgSgJZYzdNbPpvuxsrefyqMw8J7k3RDl0KzPaFFyKGYJ/7ts27hm
         NWy0JxKd8J8YdB7ESLF5Vui1K45rkHqhBOyLEeYtjhfKccLaggJ/pj/2fOJu+hT2TS49
         JYB3g/+wA4t63SOC1BF9IfwUvlBuA20MEJqwATGHpsANyXmEH3hHyvLmjVVHcvqun8h3
         gCoTYOwpQ4RSTranrRcB9JiSFrWCEx7ol48t37GIO1uusSQI0if/R5rveuY+xxdnNouP
         aXtg==
X-Forwarded-Encrypted: i=1; AJvYcCU+tr2iEP5X+ZZqbitygBhi8R9avoaoh4RdXBNODVZRutmPlL78v6Y6AvFh6NEb4yvD9Vah/ROWJAL58PdvAYFfvzeK96YUdRSzqIr/
X-Gm-Message-State: AOJu0YyT+5ojZyx6z3wLihH33tshEXbdgUhvbsEzDyo9Z3E+RcQ4OSTT
	kj2Mt8QhQePdXFQOP/JDqYQhYJ3cBYIPZC7BTVrWNBNeW7DL4sTXFI4hrCBA
X-Google-Smtp-Source: AGHT+IGuTwQFNxjxGLtXuKiAtEA/cVmhYW2z9koxrMGoW8d0RpBZSf1TlXXGI/Z3Jz2ZdRzT6QgVtw==
X-Received: by 2002:a05:6402:5202:b0:58c:36e:51bf with SMTP id 4fb4d7f45d1cf-58e7a74c721mr3350745a12.3.1720176685954;
        Fri, 05 Jul 2024 03:51:25 -0700 (PDT)
Received: from [127.0.1.1] (91-118-163-37.static.upcbusiness.at. [91.118.163.37])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-58d0043404fsm3214242a12.17.2024.07.05.03.51.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 03:51:25 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Fri, 05 Jul 2024 12:51:23 +0200
Subject: [PATCH] mmc: sdhci_am654: Constify struct regmap_config
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240705-sdhci_am654-const-regmap_config-v1-1-c166a8d48a66@gmail.com>
X-B4-Tracking: v=1; b=H4sIACrQh2YC/x3NQQqDMBBA0avIrDsw1WiwVyklhGQSZ2GUTCkF8
 e4Gl2/z/wHKVVjh1R1Q+ScqW2l4PjoIiy+ZUWIz9NQbsjSixiWI8+s0Ggxb0S9WzqvfXUOSjGm
 2Mw2BiW2CVtkrJ/nfh/fnPC+0yqZqcQAAAA==
To: Adrian Hunter <adrian.hunter@intel.com>, 
 Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720176685; l=982;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=DGTH126eFM0R8kz9es0Gnq4h/3IHDY4vjazCHvSRvlo=;
 b=C6bN89w99OrrWn7Ay/BZn/JQzTpUsnGVoV/ZSC6h7G7jZRxDbHnaIPHeVd3C4eOeuJB8hawbh
 L3uMnP5gXhTD9GHtDIfXUZ/9VdCccQ40rsc5mPyq6ACjIr88HcnXEph
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

`sdhci_am654_regmap_config` is not modified and can be declared as const
to move its data to a read-only section.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/mmc/host/sdhci_am654.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
index 17ad32cfc0c3..64e10f7c9faa 100644
--- a/drivers/mmc/host/sdhci_am654.c
+++ b/drivers/mmc/host/sdhci_am654.c
@@ -90,7 +90,7 @@
 /* Command Queue Host Controller Interface Base address */
 #define SDHCI_AM654_CQE_BASE_ADDR 0x200
 
-static struct regmap_config sdhci_am654_regmap_config = {
+static const struct regmap_config sdhci_am654_regmap_config = {
 	.reg_bits = 32,
 	.val_bits = 32,
 	.reg_stride = 4,

---
base-commit: 0b58e108042b0ed28a71cd7edf5175999955b233
change-id: 20240705-sdhci_am654-const-regmap_config-f97903ce0e7f

Best regards,
-- 
Javier Carrasco <javier.carrasco.cruz@gmail.com>

