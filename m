Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA2B222580
	for <linux-mmc@vger.kernel.org>; Thu, 20 Mar 2025 14:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742479254; cv=none; b=AfcJGCOwsxdTzpyCd2UVVXx0ob0KKExFVmcipXD16kggVYdsJpDPvg3SnX8CzYYEhewmvZN11fTO9ER5Gfbi8S37zanDODwkSYl9KXB8V3IIZR7WyTBvqY1dmxtf6S76w4ntVUKK4l2wsT01X7HGr8aWZvQfKZb1x2WJZ5ILQNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742479254; c=relaxed/simple;
	bh=j4UBzDHgk4sG7kqb/Znxr+FvEZ/5sfuewiW9AIFkVSw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KljY6c+27ywPmwSqp/q7cZILCorkHnGi/71JlQxk4EzayB7z12QlyqiNjRIiSx3j7WMZylz7V/N+hjFSLgIc0ui7U6kn45nrZoGyeaZ+BeSF7ZapOMo5i5gJ2DcsAy8T2AXglFqrq0HBhnEHervHS9peG1qI6JQnCB3dP3t4sQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NKAeFCP+; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NKAeFCP+"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-30bfc79ad97so19698221fa.1
        for <linux-mmc@vger.kernel.org>; Thu, 20 Mar 2025 07:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742479250; x=1743084050; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c1plaKCpUseZn1Yu08x42hT09CM3UN2ZDD1b7XB7y9s=;
        b=NKAeFCP+tJ9jaqQlMdRR3APcTkkrZ99hA0tP5R5qtxhXeC4jt9eDkkl2pqQq0OGDMh
         aN/S9eJ+dzKpewWdQbaJEM2QB4jkSQBZIODAUhEp3pgrbdleSyLDkdTrAaersbQ0RTVj
         q57b5hdc9wfCRVjktN3OnYDVC1peOBL0RdD0TAxHK+fCJc/WhGkwu5mTsGiXKneA6DFI
         gyl16nK34SRjGjakXTzfnqWoudAhaLhfmPQs9FNkTgYSwNfFAf/dlFzUDjYCIMbPhkiC
         xQj1ZeFRuaYWbruVlDNmfgC/wiBfgo9yN4J0UP1q8zWizr9JZlUZ7ZJyi9sEh0KlVw7B
         Gktg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742479250; x=1743084050;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c1plaKCpUseZn1Yu08x42hT09CM3UN2ZDD1b7XB7y9s=;
        b=FOo3azgu20x4eWq2ye4vz42qS0Czsf6tjRk9bDEoUfSiMQsZykwcmqB3NQX47dy/z6
         nYW8mb02fyVdidMbMPczcqB63mSAliXd/JVRE1S2OQXVfDm8aWXw6YMC77B+xmyp1WBy
         27hNiNpBEJF5mVBfce+kWVJTLdfFcr9CMKkx6R+NV5hvEy2UK5Froq9Tns9WjgqhvYqd
         HcxkN1/HlxTpc9kmBXaOdd8Zumh1FeY6aLBEL0z1ujKhN+N3AAhfRvqeGe3WnigudPnE
         pCooimFCeuuTfXsf5gdo/SzJPVkTsM5tFFfcTCEH0uofGYpXRgDYeFNhwRKN5d6W9SSH
         2v8g==
X-Gm-Message-State: AOJu0Ywrm6N4XAftE3e81YBpHZVue7oYeEfI9SKmz9Se/lBxVsK7vki1
	YhlMX4SNMFZ/+h2UvNpRHCbrpYW7fvgF2A/kW3V34uPtipzHiWIhAaSZi0qGGhblnazDobwrE1O
	c
X-Gm-Gg: ASbGncs6klFGLhCx2LkUzHRUy7+gbbHYd8bc/N9xL7Ez3gJiYWpDc1Rru1Zjy3w2gOI
	LSRcYt8GSrJE+7S4WYxmKFZFvnFoGuSt0mSKz6by4x/7hGJDXGcdzIFtfnfrAfUgqI4qdMg5Ybm
	5UpleK+yybhDoyOYrd1vcyI5d9JoeWpJ2Pb4T36XOnVNcXAUtBrEPPSWK40mLfRaXsgeEEpbE+D
	JAlwDdqEeJzrcIzNYFvLb67fhYYiFQsi/hwfdnolL5oRiSlUeFCBbNwzJL5mccvurjl66HchK+7
	8Z5+anpFMMwtgyGsREalLOW3FXzQ3J61iRYmUakS+bCWXLszAO1m9uVhTqVpPxVk2KxqrcwisEk
	L6zg7DRCvsJNXIcbmR9Q=
X-Google-Smtp-Source: AGHT+IGLDkayWqw+uQ+t5WY6cfFF97KDSfF4dlhtyKOD98B93BOTyBSUBT6MzlDFFxBRVZdolYijWg==
X-Received: by 2002:a05:6512:304f:b0:549:6ae7:e679 with SMTP id 2adb3069b0e04-54acfa79c17mr1505467e87.3.1742479249732;
        Thu, 20 Mar 2025 07:00:49 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549ba864dd9sm2295029e87.148.2025.03.20.07.00.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 07:00:49 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: linux-mmc@vger.kernel.org,
	Ulf Hansson <ulf.hansson@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] mmc: core: Convert mmc_can_poweroff_notify() into a bool
Date: Thu, 20 Mar 2025 15:00:32 +0100
Message-ID: <20250320140040.162416-2-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250320140040.162416-1-ulf.hansson@linaro.org>
References: <20250320140040.162416-1-ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It's really a true/false value that matters, let's make it clear by
returning a bool instead.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
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

