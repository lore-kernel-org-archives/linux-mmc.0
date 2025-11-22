Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19DB736D4E5
	for <linux-mmc@vger.kernel.org>; Sat, 22 Nov 2025 07:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763795100; cv=none; b=M/E+EVrG40y33+qsfQ51vackKPVg/ENYpjRATj+pxjlVa2S1xj/oWl/jK2g8sR2SFJAIIM+xOigemmHSbrqa0u/NkcnYOFMt6BCm85l3th81usJB36VH6Ra+yZ3upDhMZVBUyl/SpUj958TOU+bIcADnlRwFFytAqJEtaThfgL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763795100; c=relaxed/simple;
	bh=uZ1qbud89PlExS4+yDnvXeDrHQdBGKhIv0X9Azkk1KM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HqMWRyM/dX8XEb7IZuC3+wkjLi7tfp3cJbgevCmxVox57LYHvMn0uyAq68Kmnnvgwvd+b45VDPSBUUp/f3RKxeoNx9+ErAyjZw5IkknidSUnKoVoq67cqHi/TI8jZAxBR31gdbqm9Xqyd+xrQyzfzD815D/3cyiULiKTiVkEM5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ehTNjdBp; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ehTNjdBp"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-477aa218f20so17468215e9.0
        for <linux-mmc@vger.kernel.org>; Fri, 21 Nov 2025 23:04:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763795096; x=1764399896; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bVfqE5oQf1zmohx4lqsBU8REkdX6akz5voG2q5iRJXU=;
        b=ehTNjdBpdtHzM1344PQ6ikqEdQjhIb/O/10xKFwab53IZ5kWFyg/AprHM2d9KPPKCJ
         AQ+7s09sE/c+tMiFzZUe2GBshP62wJkeFhSHeG6KH+9s/mD1Jefz8VOCHnihMzMyRaZ3
         YzKCkQGzz7b9yH562qijL3AwErw1+Uynd5lLaCvJcibWoUYNDKh/fEDIZPj3QTKPNIgW
         UgJno0D+ShSAVdVvU++dggWp370NiAJzC7YHch7JbVNe+o90VXHd76NjcdhWDGYjbo+a
         isM7KmzNadpAJFxxGjx8X9csIkHQpBN6JLIZvP4PqRfUuW4/8ZiVmJgl0CBr5wlh40ZR
         uULw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763795096; x=1764399896;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bVfqE5oQf1zmohx4lqsBU8REkdX6akz5voG2q5iRJXU=;
        b=LkqyjUtK/EULoRrUnqfa9B3kCyz93ekcSIh9wbXqKlUbkiDRW91KdVINUZD5zu7G+Z
         Z8QTfxhaosINymIuqzzCQR7kef77wRxUQlI0Qg3fHSWxqowEP65Rhb2z/lrsXCmPmhYT
         Q7DFEq2Y6XYtmpKq/3porr77ymbDvz0tGA4XyXXzvuRf3P02eDEh5IFsBiBzFaBMBIIy
         2/D/wamcqJM3/79PWqxqD85Gb4HY6lf9FjMv32QwtDq/NsfZ+fZXrG4Wfrsf2pQg+kkB
         bstAcupnwYQ9bGJrZ7J9bZm1BY6aKWSnu2rVlcbmtBh1sWVHK+EafCHhiaC1kblNVfOD
         7yqw==
X-Forwarded-Encrypted: i=1; AJvYcCUVjwa6LIKldna1QGzE3GjJEJOEfHbAhPzrUB01Piz6bsFxpTaBK8kdylXAIzrZqwY+9e77gWeYm8s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzjnl5LcGhnEVk7ukp1dk/AXftsIr0qxG+m0P0AAPr1lq4t+sYE
	Hxpi4MxxrvC/THfSy4c5ADtdQYMmROlZHBHDOd13ZRGCYYHyR7W8QfPR
X-Gm-Gg: ASbGncsUIgEMZYgFehrDe6WYOlQ+jBmruvU6pXiot73I/CdZC5hioK44/CmOEs4G1IS
	NBagBXLrfU5VOlU8dbk1uZAGFIbMaE63KWjMvXTInMhYZHUZwdp09gTB09dXmD9DibSb+K81zFi
	vRHaHx5yTFzWHRnN3vkn6lG/0SS3CpzsujvMwZZCy81UY2vZx1JhtRWTezrYTWI+slfk0oJ+pBZ
	xsovygpzZQGRQxrLORlYtjvd1Ow4TYmVL5sIhubijBGBcK/FerpSTl/PNWCDB0/nk3FN1p+Iyjq
	Lek9wfOvLg5JXK8iCmEbw+vWYuLJPqxBJDMlRZHvTYFJ9IAz1TakL/3NbPy0iYVXZtl9uzw5pGb
	JqAR9o7SQLiTapLD1Le/OZQpxhpbUYaPSqh/VYAm4tX23JhVKZi5etetNJh88wsqA9QrDCRUYXI
	1LCzpulGsPbL7UbbJN8YzOM+gZG4A8PNRdR6i2iG5bF0/q3C0AvgkENPQYI1iTZDPv7DZe04VK
X-Google-Smtp-Source: AGHT+IHKHE+5PK43oJipc0zqbwgY9Y2cWKaCqq6mLV5325L1SCihs0xDg6Y63JcOqikNYG+efw+8SA==
X-Received: by 2002:a05:600c:8b16:b0:477:94e3:8a96 with SMTP id 5b1f17b1804b1-477c01b512cmr39412105e9.20.1763795096195;
        Fri, 21 Nov 2025 23:04:56 -0800 (PST)
Received: from avri-office.sdcorp.global.sandisk.com ([129.253.242.14])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477a9d198a0sm104914505e9.1.2025.11.21.23.04.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 23:04:55 -0800 (PST)
From: Avri Altman <avri.altman@gmail.com>
X-Google-Original-From: Avri Altman <avri.altman@sandisk.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org
Cc: Avri Altman <avri.altman@sandisk.com>
Subject: [PATCH 1/2] mmc: core: Adjust MDT beyond 2025
Date: Sat, 22 Nov 2025 09:04:41 +0200
Message-Id: <20251122070442.111690-2-avri.altman@sandisk.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251122070442.111690-1-avri.altman@sandisk.com>
References: <20251122070442.111690-1-avri.altman@sandisk.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

JEDEC JC64.1 proposal, which was recently approved, increases the
manufacturing year limit for eMMC devices. The eMMC manufacturing year
is stored in a 4-bit field in the CID register. Originally, it covered
1997–2012. Later, with EXT_CSD_REV=8, it was extended up to 2025. Now,
with EXT_CSD_REV=9, the range is rolled over by another 16 years, up to
2038.

The mapping is as follows:
cid[8..11] | rev ≤ 4 | 8 ≥ rev > 4 | rev > 8
---------------------------------------------
0          | 1997    | 2013        | 2029
1          | 1998    | 2014        | 2030
2          | 1999    | 2015        | 2031
3          | 2000    | 2016        | 2032
4          | 2001    | 2017        | 2033
5          | 2002    | 2018        | 2034
6          | 2003    | 2019        | 2035
7          | 2004    | 2020        | 2036
8          | 2005    | 2021        | 2037
9          | 2006    | 2022        | 2038
10         | 2007    | 2023        |
11         | 2008    | 2024        |
12         | 2009    | 2025        |
13         | 2010    |             | 2026
14         | 2011    |             | 2027
15         | 2012    |             | 2028

Signed-off-by: Avri Altman <avri.altman@sandisk.com>
---
 drivers/mmc/core/mmc.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 7c86efb1044a..4c36029b28a3 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -671,7 +671,14 @@ static int mmc_decode_ext_csd(struct mmc_card *card, u8 *ext_csd)
 		card->ext_csd.enhanced_rpmb_supported =
 					(card->ext_csd.rel_param &
 					 EXT_CSD_WR_REL_PARAM_EN_RPMB_REL_WR);
+
+                if (card->ext_csd.rev >= 9) {
+		        /* Adjust production date as per JEDEC JC64.1 */
+		        if (card->cid.year < 2023)
+			        card->cid.year += 16;
+	        }
 	}
+
 out:
 	return err;
 }
-- 
2.34.1

