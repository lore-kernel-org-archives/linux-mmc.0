Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1635131A576
	for <linux-mmc@vger.kernel.org>; Fri, 12 Sep 2025 14:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757686994; cv=none; b=Qom6mg6rhRTfb1AQn8dz2xP+9rQf62ALopPupWM8v7sISdTdmNzk4wo2PRF30Blq5h7hrRCctnJn+YtkcouU9Z9qJeyqSoA4XJU6zF87PFT1Gp0iXy1wH0GEuMmQu4FCJZumzY/jaTeFLo/a93rszFZrN54q+GKferX2cTV4buQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757686994; c=relaxed/simple;
	bh=QFBxOpXKFdUsBBboSwrFkX85dFPDXK3RGBPvIvbMZv8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DEiCLTTcZGfmp+D4WykLQLXg3yv6Ni1usYq+VfKbpJj/YE3n4zqgHrow99fzivdIG95eim1HBhCkFNoyE75eX0adZuQDvoRbBlE6WM6p1dTfhoF07AK9E/bXBFWeNP3VwQE2GxmAtcgerFq8hZB/EqD5Aqg6CotirxnTKZclhss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HOafQr+8; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HOafQr+8"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-55f7a34fb35so1781644e87.1
        for <linux-mmc@vger.kernel.org>; Fri, 12 Sep 2025 07:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757686991; x=1758291791; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HUiyOZ4i6Z7SnqGnRt6/7sGsiUAMT9ZWi+zfYj8DH6g=;
        b=HOafQr+8UQoklMpK2qsZ+SqaxqZXtjtXq/NmyE0AqWTV3Bu8FlsVFLd8BVneOxhh0q
         k/zzE+vBT/OeThiM/eYBjOhLp2Kd7QXPpiqwo8pNZdMde0Y5mwvm5znlY7k06wZ4tDtO
         WMkA9M2Fnok0VIeifmtu9d5ZOCaQGmhYA7E/+/hNNXC1jJ72HT6ugmniY+k4hDORayl/
         mLxQYwNeWqARtBoEuC+lxensJRW5H+rst7zpMK6k/5svXbNTx522j/ulw4K5HG8da6aR
         71dJH5An0wmAX6dCwteOpltVgT0xbHrXh8y80TyA2f6NNHXIO3cYyg4BilwkoLsTk/1+
         N7DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757686991; x=1758291791;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HUiyOZ4i6Z7SnqGnRt6/7sGsiUAMT9ZWi+zfYj8DH6g=;
        b=pK89yjoKRpe6SzBhjTBgbvWcyltwUYLal7rv79UgVqEUtj5V4xa2eLdgHSaQp54o6b
         TPceyWA1hfgmSScY8bzj36RZ2d5WQEpI6mGc4n1GGh5QSaefqbKwsuFdDHHxkrrc72u1
         lb9ZYYCStuVbC6bIgWSIcpRdOk8plUFHvIIetgUu63suV33jQ5hAb8rvwpX1EDQeVNtX
         ctaWbjbThW1n0QJR42SmmzvBXRuKducqsK44Wv1oTwiEAn/ayYZvYGulrFknmH4Th7Go
         wYaaAh5HKZ0JVDk6bc1v7o3Cs6z6CDMJZ2zuZ0E9tV3uS1+cSow3WAPoa93kLBn9hcy2
         jxpA==
X-Gm-Message-State: AOJu0YxonYzEAM2lCaMZKluAgWxgoYwgV2Iy/htApLCVj++LpVxzdDDl
	KLZCnNDbB9p9o9Sf0Cf7MPZxtZGG7iN9TFnMq/Ne4Arp21SZOo7m0c+Q2tR82qNZxWUZe4aFy+T
	KNk+tdMwB/Q==
X-Gm-Gg: ASbGncvZuXl6OQ0sJpmLLwlhWVlBqvbFUWkoTkDnH0cT5J/7hr5CCDHrqy8UrYJKnYM
	7JSjNCNBw0B6NBMGDwYkIDFGCLIoR1+VHiEsgwVWjIJyx3xozPN5TsQIZuph3dI9MOON0hTOUQh
	khED+uCY6xMdMVHGOS15CUd4GyvaTx4TbMOP5OFMCqeTg3ViX4iFIlNq55RdPl0W7dzbgImG9+P
	qD9CsMXtGzD8FwfNAhEyEoKGCO/TAyrRnOH65PK4eByTFDE7jxSPTDJSf2U9T389dHryCzVkz1b
	sIGtA2jiwoWqeD3nHd0eSexu/GWTD5tnQjZogXRJLLB80VQxDn54j/YuW0yOoLpEYHeBecp1DOj
	6ZifP2GIXkL4sqBm2SPJ4C0APgBKq1QmWk9hllEosMw8FGjysbRppkyUqmn2ZAD+bZw==
X-Google-Smtp-Source: AGHT+IGdxKLtOe0+gsm8bwgR1GeYx44jfxsOGHDZU3t9lKwYxQzb6vqr4Xr/Ni+j2w631ApUy2bsKA==
X-Received: by 2002:a05:6512:712:b0:55f:6fb4:e084 with SMTP id 2adb3069b0e04-57050fe4cbemr812199e87.50.1757686990958;
        Fri, 12 Sep 2025 07:23:10 -0700 (PDT)
Received: from nuoska (87-100-249-247.bb.dnainternet.fi. [87.100.249.247])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-571a5df5f74sm164981e87.54.2025.09.12.07.23.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 07:23:10 -0700 (PDT)
From: Mikko Rapeli <mikko.rapeli@linaro.org>
To: linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org,
	=?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
	linux-kernel@vger.kernel.org,
	adrian.hunter@intel.com,
	victor.shih@genesyslogic.com.tw,
	ben.chuang@genesyslogic.com.tw,
	geert+renesas@glider.be,
	angelogioacchino.delregno@collabora.com,
	dlan@gentoo.org,
	arnd@arndb.de,
	zhoubinbin@loongson.cn,
	Mikko Rapeli <mikko.rapeli@linaro.org>
Subject: [PATCH v3 3/4] mmc: remove COMPILE_TEST from MMC_LOONGSON2
Date: Fri, 12 Sep 2025 17:22:52 +0300
Message-ID: <20250912142253.2843018-4-mikko.rapeli@linaro.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250912142253.2843018-1-mikko.rapeli@linaro.org>
References: <20250912142253.2843018-1-mikko.rapeli@linaro.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It fails to link due to undeclared dependency
to regmap which is not enabled for COMPILE_TEST:

ERROR: modpost: "__devm_regmap_init_mmio_clk"
[drivers/mmc/host/loongson2-mmc.ko] undefined!

Signed-off-by: Mikko Rapeli <mikko.rapeli@linaro.org>
---
 drivers/mmc/host/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 2db46291ae442..e2d9a7cf9f855 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -1113,7 +1113,7 @@ config MMC_OWL
 
 config MMC_LOONGSON2
 	tristate "Loongson-2K SD/SDIO/eMMC Host Interface support"
-	depends on LOONGARCH || COMPILE_TEST
+	depends on LOONGARCH
 	depends on HAS_DMA
 	help
 	  This selects support for the SD/SDIO/eMMC Host Controller on
-- 
2.34.1

