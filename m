Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 821E31FDE00
	for <linux-mmc@vger.kernel.org>; Mon,  7 Apr 2025 15:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744039690; cv=none; b=BqoOCbcnzuWm9dGrb2xkxNThu1y58TNhsrLNXPk5yA3OUQKnjndeMTeHRv+qgUjIjFhIJal0ZrK7B+8XwFDs6167G1aDQ+0WBb3RoGr8gQKlXY7kyqtiFMkidIoQgr1+cTGMSLTuEGTqQ8DBN99qmm6+q6MZEVjN9QevM6Mkfso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744039690; c=relaxed/simple;
	bh=AeCDJp54wAGtMg9CHmvKgr9djrzK4GgL9KpmTxPCRpU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pswHz/BKiDvS4prCZQKoDnF0dEE8oO1XaNWRIIDCQOHWwv02tEgOXIy4n1fNIiaZl8i0tSebspJrMe0v9Ku+H5zUyluqQm4po/95spfXobKBXZ+mtTrsqKGDzJ62MU4PT6C+n1h4BUwvLL49JP/3bP2jgtMTMRFSghljYvI9yZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ip7+SdGj; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ip7+SdGj"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-307325f2436so47140691fa.0
        for <linux-mmc@vger.kernel.org>; Mon, 07 Apr 2025 08:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744039686; x=1744644486; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q0o6na0F8TAk6lCusT5NLJ6CNUgxmH5Vy2ajrZSzJE8=;
        b=ip7+SdGjNUtgxOKuleuXElFbE+taTNOp21mE4yMEU060uNwuijy+AaNAIgkpy5Xe1b
         BMWxoMO7/2KNMJoH92cbcDgPL+ydUOPzVhpS/06/At+OS13M4SJF5d7nhKoEcDyC5hUi
         5NanepfdNLqTl4Q61rQwBk3tnjreCcerW+it/02yO8n4jjZGcdrXpwzTxyYZum723/JJ
         FcoYbC51fXiVoSPfEJANbdIGK5a8t5q+l2R7ximUipadjB+CL+RCz/R4OqYMC1ErfNrx
         kSU+eCd/j3VK8Z0DRfneu+J10UO7CXHJlJF3iOCObzF3e/LtcgZuQ9TVct9L2uWuB39S
         kdHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744039686; x=1744644486;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q0o6na0F8TAk6lCusT5NLJ6CNUgxmH5Vy2ajrZSzJE8=;
        b=m4xbOLMGQaTCWuSguQp7YJBEP49x9OcZb5ckwrJKWspE0uWz7S8n+iEB2eFANu/RoT
         Bqs6+EsRbOEjKPIjIvWi+/NopLGP7CBwEbYfQd3jVkZVjgbp9XRhDVtNDX9B2WLTsXbg
         GuoqVSqWe0JzIoxLXgIbpiq5yMAjrQns6Tmx9jPBp+Irm26/zftXABl1Wv7YRq+UV9Ql
         d/63JmYJV3XDEeoVRMJVacFbi2caKh02zLaYXIN+bv+7ZPtAJB4AqMYlu+9xzGd31Azq
         j5/PvdykME9A6LDTOauAT+j7JOLJA+u1qJAHiveRmHniQVhLX16NKBSc7EcK9ydAV/18
         SWEQ==
X-Gm-Message-State: AOJu0YxswfjUOiP6/b/oBNVnt2Hv0yfD7IGrix2P1jGY3cPyrVWvChA+
	WO18Pk7dA1PMPYm6LSTE1eDcvVb8GVHaulU9+uswvUC3ZKxSqOoY//uWCfuUQDid2P7No1zoW9T
	c
X-Gm-Gg: ASbGncvp/2QzQykfFDXL6YsEHFoQKS6eun/eYJMcG3aP/RGW51Aup6GtufIORd8Liye
	Yphz3ykmekiUvmuJieVDshNn3mAtVGxf1mdp3c1h5Q0Pks/+uXm6nOhmA8chzCy/QTOBFdDZw1X
	7ea87WWZlPXlkqtXWIFK4wFL3kN60KL0I4ngAUhlSNNcLQF03PhnCx9ItZQ8rtJYfgh5RIJ8/yo
	jlTC7U//cNl5CZFXm5XeuIA/KGzsgmC5QYvzlySPyiffjL/4qtyC+oU1j/ofMtUqFCPFEugYuTT
	t7zkRf7Aw0+e0t1r64YjDf+Ey5Ws6amCknoz1UD4vbXKJhSyD6bkAjVlNw6gCn1lNBWKgAyic1P
	3Xrs718QDbz0BkWqiWRI=
X-Google-Smtp-Source: AGHT+IGP9ssOV6pn79yVfRWiq3KAcys7QHTQQoul8wvyG5t+BivqElpyAW6czWaQuzr79w8RI0P1Cg==
X-Received: by 2002:a05:651c:211c:b0:308:f860:7c1 with SMTP id 38308e7fff4ca-30f0c03c545mr42993461fa.30.1744039686432;
        Mon, 07 Apr 2025 08:28:06 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30f0314c62bsm16158691fa.61.2025.04.07.08.28.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 08:28:05 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: linux-mmc@vger.kernel.org,
	Ulf Hansson <ulf.hansson@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Avri Altman <Avri.Altman@sandisk.com>,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Avri Altman <avri.altman@sandisk.com>
Subject: [PATCH v2 1/5] mmc: core: Convert mmc_can_poweroff_notify() into a bool
Date: Mon,  7 Apr 2025 17:27:51 +0200
Message-ID: <20250407152759.25160-2-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250407152759.25160-1-ulf.hansson@linaro.org>
References: <20250407152759.25160-1-ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It's really a true/false value that matters, let's make it clear by
returning a bool instead.

Reviewed-by: Avri Altman <avri.altman@sandisk.com>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v2:
	- None.

---
 drivers/mmc/core/mmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 1522fd2b517d..3424bc9e20c5 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -2007,7 +2007,7 @@ static int mmc_sleep(struct mmc_host *host)
 	return err;
 }
 
-static int mmc_can_poweroff_notify(const struct mmc_card *card)
+static bool mmc_can_poweroff_notify(const struct mmc_card *card)
 {
 	return card &&
 		mmc_card_mmc(card) &&
-- 
2.43.0

