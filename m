Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 285DE22A7F4;
	Fri, 23 May 2025 11:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747998128; cv=none; b=muoSawc4i38kS6xSLRkswODi7M8hCJ3lqJxbAHdRfJSwtBAVWl182j/0j5IexD6Ou2RDJ9fcj8Lvt0uZeWNHUIOu2NOf6Mw9cNza+eODI6m3RFLhudOAe/mKo3nQSW7jZOniznFSl2lLLIxe3pPneNUt/KKWEoWaZdRpDBQHpUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747998128; c=relaxed/simple;
	bh=Ta1a6XiujNB2xDIBTAbxKCZudWyRkNA13y0JiAa+ty8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UEQ8BMsZeMSfq9+ucu6CuK6QpUiUKs2zWWOg1IYSdbTChUn6BRJMNMYg9yYLdhlLJSsCQWaZzgJZ1dPZIipzxdGwUQB15MLd7fe4N3jH1QgwuWsZ5Nx4fHVEZ1M8+mLmxlkhU28tEJoLl/YoBhhQuimEG3SpEEl9wdyYJqiVGI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IZhVW2XJ; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IZhVW2XJ"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-742c27df0daso5252294b3a.1;
        Fri, 23 May 2025 04:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747998126; x=1748602926; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x1BxauimJQV9tBwhYpsh7ZmpbEkfrPazvraZsHAY0lg=;
        b=IZhVW2XJwiEjKLSHSGwXqRnyvNN/afQaLRwkBKmPmcVLpDg31qGI0ikZZVvH7Oe08g
         d2aOwBmmV3bNqfo2JannDTNLZDRtpwljjd4zJ4QBZxkHQbvEl4+S+OPjYxmYeOxohdYw
         GEMLfjpORRbpk+ky7okoatbLid3zvUJK9yBkkgHiDyovZJhJ1ANPXAsAst+v4qt249/M
         tNyUFOwGxWNzHDJoF8KNUv3g0JMj1XXL4JtznZHPK9i1Xqf1AKdvodzNsL9L6H7Tbd2C
         hqOPMniPqJXRR+/xjVNs2lv0KMyzlGe7PLS/ga13H8Uj9W6QoAP6w4PcA0NBL0+xwJmB
         jDfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747998126; x=1748602926;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x1BxauimJQV9tBwhYpsh7ZmpbEkfrPazvraZsHAY0lg=;
        b=KWWiFR5tKRxCi8TcKoJWwM0xueXVQ0OosHaV0myeSIt7w3DMnItfA8upnALlwJfaFy
         RZZVxzrdDkIN67JugyNqqOgY6EMQZiQ1Ts4faiLRPCHpNllLz0jOaF79Qi//vynl0zRv
         h9Co46UIa/qqiCaNYeobk35TNF7mfn/aoND9F94jIZnXS4Wm+sbCm4s241zRbVjCpzMi
         t6sucnaWQG474tlYFF9SdJ9JlLv/GVi5fSEMhdxEOTGiyYijBuNW9YdvPP8SB6Y/g09w
         wL8iNdSbLradoqhNFseBYUyh312C3ASCXP4ATZaGGSen/g0KsJfJRBUYoB+NK8FGnDHZ
         3Vdw==
X-Forwarded-Encrypted: i=1; AJvYcCVZ5R8Vre9oesnMYyIxSxs0K8LqfwkbHG9StRbDIuhuAOQdSAc0GYrnJJ3rSRrqySYG+viGDwBV84FbUGc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxi8AbPcTpUXc7zgxtyb14cJfcuodfmQkp29+febO3cnOnhCxRS
	vMeXqyrezsQEBrMN9czc3+NaFJUkaI34H3exh9vE3kKiVahHr9lSzHLRmIYp7w==
X-Gm-Gg: ASbGncuhrYc49HEeQuib/ZvaDh5shhs1mo4gAGL4YCJRatWt8e7kLu61Z9GszZsEb97
	viNBevNYo/8Sfi6ChtylkB/LgO+ptXVzNkHqM1b9C2/PVqXPdszup4l1Eow00II+d62c1oXMCxw
	3TS7NLuaN4Ih/4sb3ObQwq3WTon1KipAppJOl81BinS0lUjLyOoZPj7nLPgsVFnNKbXJHt1Wuxq
	Zri4T9bEkSJYyfRoSbHoO8eaF7spu4M6XKhSw5sJ5QTRY+OAH6/yvUmAAU4jGEP2AC0eMVsBcwb
	xlyL7ZxwguKZXytaiVBjgzq8UyI+qPMGhc9Rer61nM9+zWxDHfirZMIp2zQ=
X-Google-Smtp-Source: AGHT+IGDYaaVUOCEK1xwB9jpEFXbhZfI57nIhhtQTRb+hG+nGClQMJJajsZAr83Fw8X9dWa/uXwDdQ==
X-Received: by 2002:a05:6a20:7f8a:b0:215:d14d:6626 with SMTP id adf61e73a8af0-2162189e1a1mr37035883637.12.1747998126163;
        Fri, 23 May 2025 04:02:06 -0700 (PDT)
Received: from victorshih.. ([2402:7500:577:397a:c299:a1bd:2b60:56b8])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b26eaf6dc3csm12541617a12.24.2025.05.23.04.02.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 May 2025 04:02:05 -0700 (PDT)
From: Victor Shih <victorshihgli@gmail.com>
To: ulf.hansson@linaro.org,
	adrian.hunter@intel.com
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	benchuanggli@gmail.com,
	HL.Liu@genesyslogic.com.tw,
	Greg.tu@genesyslogic.com.tw,
	Ben.Chuang@genesyslogic.com.tw,
	Victor Shih <victorshihgli@gmail.com>,
	Victor Shih <victor.shih@genesyslogic.com.tw>
Subject: [PATCH RESEND V2 1/2] mmc: core: Adjust some error messages for SD UHS-II cards
Date: Fri, 23 May 2025 19:01:54 +0800
Message-ID: <20250523110155.10451-2-victorshihgli@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250523110155.10451-1-victorshihgli@gmail.com>
References: <20250523110155.10451-1-victorshihgli@gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Victor Shih <victor.shih@genesyslogic.com.tw>

Adjust some error messages to debug mode to avoid causing
misunderstanding it is an error.

Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
---
 drivers/mmc/core/sd_uhs2.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/sd_uhs2.c b/drivers/mmc/core/sd_uhs2.c
index 1c31d0dfa961..de17d1611290 100644
--- a/drivers/mmc/core/sd_uhs2.c
+++ b/drivers/mmc/core/sd_uhs2.c
@@ -91,8 +91,8 @@ static int sd_uhs2_phy_init(struct mmc_host *host)
 
 	err = host->ops->uhs2_control(host, UHS2_PHY_INIT);
 	if (err) {
-		pr_err("%s: failed to initial phy for UHS-II!\n",
-		       mmc_hostname(host));
+		pr_debug("%s: failed to initial phy for UHS-II!\n",
+			 mmc_hostname(host));
 	}
 
 	return err;
-- 
2.43.0

