Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2B0206510
	for <linux-mmc@vger.kernel.org>; Tue, 29 Oct 2024 13:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730207886; cv=none; b=LLRUIrUu7vsqNqUqn4iSo7FLLa7hTZA1OkgEHqynYMirOyRTy737L+KQIUX02fghoJDz/og37gbiPyrv3ZriNbM7fkck33pvv+/011PXTC4iDHkjxhE2OXdCLBV7FVfBL3nlvvVjmqdgPVpQ0laAtgpMlc+4voJCWG5Z4nx+McE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730207886; c=relaxed/simple;
	bh=ANkqoHmBlWeAyTzEEJnr47Kb6ijhafWnHmW225AcRh0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ue2KgVAi7SbzsUbBffUhbIu/5gPo6Foh8qR9crYKwZqLFicV5IwZMClyxfTfpUbqVE3jTCLTwO73uG27Wyymv67qKZ9hnA6aS8lZx1bnErkdKtFHPseNd0L861XSMvgLbID5RgbJzAYErLIdwYmAo2/F7JI22pwPgeqYDo0ePlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Fn/dXq7N; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Fn/dXq7N"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2fb599aac99so50381721fa.1
        for <linux-mmc@vger.kernel.org>; Tue, 29 Oct 2024 06:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730207882; x=1730812682; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ECTIY6gQGhiQ/bshY9W31clyZwhWM9uKNHen6jEJgGY=;
        b=Fn/dXq7NLQbxGtcruPRmXUcYYUj/d+V5DJM58gCX0jhAkW2PCheM5BmCvfG81KkAO2
         xZioetQvZUhY/WD0TZEkolKrtjGbvr8UUdn6Wcl5Oyl692VNdzXUSRCYw/ythOP2W5II
         gYgEQ3rNE5QBLECo4myHVv/KNSupQRaymLDmIAjGI/iO+r7K3i4EIJPthv/KlXk5cHaG
         i/6C9hocksefldIlVmQYLEcdMRRnNHo4EguBJeCmE26vZUkSzEXerh6iBh1HSZDomD6P
         mmK4jgQy7qjTFhsgH0iN6NkfI8nmBTpXuqHgKHh+Xl79KbQWIS3Cm1AWXR7uSoE0gtXK
         1Eew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730207882; x=1730812682;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ECTIY6gQGhiQ/bshY9W31clyZwhWM9uKNHen6jEJgGY=;
        b=TNceX6fTVvSBSHGKKwn3VHgFsmKKP0S8w3CZVuzJpIJpDCUSX9Wd+8Ht2sajcknyo3
         VUqRZcTExjUqaFCSSXaksbSM1HC261fXVcaqrjFevJ94ykowXwxaFi6eMLXHoEE7bYoR
         WJ7dradq7ww1J8a/DM49EwSgFPhwdJVe8f9W4F7P8o3HRw55e47ITxOsP7B/MQm/dkJg
         B7FixjjpjB4VVZuVNnliNyrfswIreuVQ55pAD3aPPYt7z9iWS5bzjTsM/CMyiMZa8gvJ
         X76M4UYXVIfHsCw4D30LB3OvTrexnJaZgcBsuGBwBxrzBDxLYmq6WrvgJ38p95vSV4mE
         NqrA==
X-Gm-Message-State: AOJu0Yzebqm/f/8s3nOTgkUJK5ZugyKjPlmmU1ObO6JeWPZOTCxUCyrp
	QJed4QxVqvLTShqk9X3KAQbCZt5ffIuRnk197cbJCGz2pr55Z5lfZPCxkjX2j9UzT/p7txfgm9w
	c
X-Google-Smtp-Source: AGHT+IEuA9SbdruHeD5eBVnlwcAjleTiKR4nR44WwhRTZaq0GkM6heGs2eeyKJxyU8w6mf9sXe31DA==
X-Received: by 2002:a2e:511a:0:b0:2fb:3c44:7f8b with SMTP id 38308e7fff4ca-2fcbe0a42d3mr44496351fa.43.1730207882276;
        Tue, 29 Oct 2024 06:18:02 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2fcb45d1b5asm14898401fa.85.2024.10.29.06.18.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 06:18:01 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: linux-mmc@vger.kernel.org,
	Ulf Hansson <ulf.hansson@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Victor Shih <victor.shih@genesyslogic.com.tw>,
	Victor Shih <victorshihgli@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] mmc: core: Add error handling of sd_uhs2_power_up()
Date: Tue, 29 Oct 2024 14:17:48 +0100
Message-ID: <20241029131752.226764-3-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241029131752.226764-1-ulf.hansson@linaro.org>
References: <20241029131752.226764-1-ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In sd_uhs2_reinit() the call to sd_uhs2_power_up() lacks error handling, so
let's add it.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/sd_uhs2.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/sd_uhs2.c b/drivers/mmc/core/sd_uhs2.c
index 06857e1bbdb0..f0d631b4bbd7 100644
--- a/drivers/mmc/core/sd_uhs2.c
+++ b/drivers/mmc/core/sd_uhs2.c
@@ -999,7 +999,9 @@ static int sd_uhs2_reinit(struct mmc_host *host)
 	struct mmc_card *card = host->card;
 	int err;
 
-	sd_uhs2_power_up(host);
+	err = sd_uhs2_power_up(host);
+	if (err)
+		return err;
 
 	err = sd_uhs2_phy_init(host);
 	if (err)
-- 
2.43.0

