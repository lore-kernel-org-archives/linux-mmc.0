Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D2825333F
	for <linux-mmc@vger.kernel.org>; Fri, 28 Nov 2025 05:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764307241; cv=none; b=gutVXOVO2IUFsY+gLDsR/IBcdX5sb9Bv+06sGPfZ2WF3IXOFUbTAWBdjCZ6aPa/p3TTD71sy9Vbfz/T2Na/TfkXNypAi/LVv3P4PsQEN2cC4Tbjz2Q+qRcNCPLLp64sUVT2tq5OcdjyWqJWmLOSZ5ciD/m61y4wTlqVZWtX6aME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764307241; c=relaxed/simple;
	bh=FQy2zkjuLq7LnIo+Yz35bjZBbxJxI/vBRyWPYtKYJGw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ksZoXUD3Z/OJ7d364etijihEWr2lRfZhGnO6BUcNeJuoMWXbYPcdToygHykYuwVcBvy9qIeBzRZAEYGXKZtc3O8Z+wKwSfaavPak4ReBqZaTOheFooRUcKTfkZH7+u5wXB4/mWN/0/xMxQ2/U+3oxyIKMaaiGtDG5J+JhuxCm70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ST3F3+8y; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ST3F3+8y"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-47798ded6fcso7286355e9.1
        for <linux-mmc@vger.kernel.org>; Thu, 27 Nov 2025 21:20:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764307238; x=1764912038; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HRy8IlKRHh6vqhgxBRGBewb2qEuhWs+kknTqoU506fg=;
        b=ST3F3+8ydspkHpkGzrp5NAHl91YO4+ZtWfI8N1pMCIv2Ycc+VEwrjHxWa7DCBDRmus
         +NgYGadDH3kcbZQbgs1rwxH9Kk3HqqJqMqCVK1uK4SzQS0ezWJXmvgGtVRZwxU+Gi/Jo
         7gc791gxFJiSjwhC1ipHGMxeC93KNGybsuol0z4+bBsUys/xtsLiw1tk1HqfOFPe7JOj
         zn+tWtVXxb49iKJDcK5EdhqmP7pdQQLKHiBDpv3ppIdX2/yq8ExVPM0LB2l8vIlPemSb
         aYiE40+u4zqotAvogBC+qodL1zHhm8TBddHAqfE2Kt0atUbCxDFYAOnGmpM5E3CSHyh1
         D+kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764307238; x=1764912038;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HRy8IlKRHh6vqhgxBRGBewb2qEuhWs+kknTqoU506fg=;
        b=b9ODNKaF440B84jiXIy9h9mZiRQMhxpV88IrkwzRzIElCTJW3ok1eIol0yRcm9yZvZ
         8rqP86gpKz9/jMHOqNew0z+2SRKM19QpQvyKYv6Fejr2eyBwmfgRHNHEOX5GemiYXP2/
         Mpn5p1Y+EbZy7n7evyeg8vi6LzKUTvzAH6ta98KExbMbGVlmmwToTywSA/EAUpRLx+VP
         QBDtgq6sbKDzZUFWW/JHjjPNlx+LsDQmXAcwDH6qxIPzmhyBPzySy3Evlha55dZG4oMj
         dCDa0m7YlbARcihoa3cW4uRed+O7q9mjyHXkn+01MlG2A6AGY7Cz9mXpKY9FTToPGfxX
         JuDg==
X-Forwarded-Encrypted: i=1; AJvYcCW+uA7ltKVmbCEFtgG57bI6HUWiH9n5FTEih0ApdnL9ty6Vu6Gn5xkBEwjw1sMMViuJL1OZ3s79Jg4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaazlpMegTl8esh37KujShe1Z93LPa1kc5KQl6vtPVK14u0vz6
	+3rcmFVgFEyaOGsj04PJCwaU8d2LHcZfzst5qcbq1Z02ka1Yl4LrlW+E
X-Gm-Gg: ASbGncuWaxvk4bGfSMiw9NFbUAws4+P8sfSRBbso7fwDgfwiLSCt7Cj3gT4i1loA/fT
	eN9y83TZmBf3VHPgOYEV54hMuwEIJsUHmAmFiif4ZEW4EuxFNwYYeT29gh9zoJruI99CAk+TZhF
	NS1XxvNRy7xEFD1yxXLTbmDNTcFHreAfOqzaS/XbGsSHQgkUKWf0KKaVBKPtvxfkp8UyUkz6onb
	Om4vgoRV2KUj4QppvVa6/J5Bnikgj+QFRYJ0iHUsU6DCxwPXEQRhJpv9hfe9SQxdopKAZWQ+PC4
	WQ1+gky+Qr8X/X9K5S6XQ1r4zC2vdqs4pk0kMTYytshinCwgIEECRvpbr7stLnEgAtMrkLcpBEp
	ymsRDadMSbDIeHtMgZMKLMyK3f/Ynjd5QhhTow5pqUFdW/QxF6o740VVTKIT8S753Av4uYBU7Vj
	aZarPjrHy9wysCcpMVHxQmlGjsPuJpQ3RN6/ddq/CHpHV+AOtAyVSs5eO3r0/zZCzZ4eKzdIJa
X-Google-Smtp-Source: AGHT+IEZsI2k5cVtCt1ihfzQRmFUD1FSkLBDzxhRsLPiIsoUOfUATj6nG8k2CGq73kjWQWRzEnG6vA==
X-Received: by 2002:a05:600c:3590:b0:477:54f9:6ac2 with SMTP id 5b1f17b1804b1-477c104fc20mr307883795e9.0.1764307237524;
        Thu, 27 Nov 2025 21:20:37 -0800 (PST)
Received: from avri-office.sdcorp.global.sandisk.com ([129.253.242.14])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4791116c3c0sm65802385e9.8.2025.11.27.21.20.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Nov 2025 21:20:37 -0800 (PST)
From: Avri Altman <avri.altman@gmail.com>
X-Google-Original-From: Avri Altman <avri.altman@sandisk.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org
Cc: Avri Altman <avri.altman@sandisk.com>,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v2 1/2] mmc: core: Adjust MDT beyond 2025
Date: Fri, 28 Nov 2025 07:20:10 +0200
Message-Id: <20251128052011.204735-2-avri.altman@sandisk.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251128052011.204735-1-avri.altman@sandisk.com>
References: <20251128052011.204735-1-avri.altman@sandisk.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

JEDEC JESD84-B51B which was released in September 2025, increases the
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
Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>
---
 drivers/mmc/core/mmc.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 7c86efb1044a..f744dd501842 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -671,7 +671,14 @@ static int mmc_decode_ext_csd(struct mmc_card *card, u8 *ext_csd)
 		card->ext_csd.enhanced_rpmb_supported =
 					(card->ext_csd.rel_param &
 					 EXT_CSD_WR_REL_PARAM_EN_RPMB_REL_WR);
+
+		if (card->ext_csd.rev >= 9) {
+			/* Adjust production date as per JEDEC JESD84-B51B September 2025 */
+			if (card->cid.year < 2023)
+				card->cid.year += 16;
+		}
 	}
+
 out:
 	return err;
 }
-- 
2.34.1

