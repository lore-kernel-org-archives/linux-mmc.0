Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B11D043D50E
	for <linux-mmc@vger.kernel.org>; Tue, 20 Jan 2026 14:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768919219; cv=none; b=iMIMkTfDPlmO+kcV93+ZFESPeXAHhsVJ9rq0lz6hjZ17/EtMRx9c8GhwYRynxHY2TmJ6U0Q95IKGRQJb57eSzUSIzAG/+maTyqnckV7drzeLdjJVEsGqMI/Ng+a9e3o2YetPH3CMoh4yTDRvoJoVGVVMP18OuLlayjJjA1ILmzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768919219; c=relaxed/simple;
	bh=3SREWp5AQuhpQ8ZTpxLinHFSGdQevh/GQ+DofGlz+zg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=IQAum8D1b0T3TAStpFVqc3nTdEzvWlfEcYi+PVQipHo27crM9gf2GbCQ7EUTolQLjPpLQUBk+dgUkf2Idxet8+f3c0jzozjsUvomj5FtjG/NzfMhPlyww6HkVR83MX6t69p8MmM0kmzzAbGSbE8CjXOK1BuBaRfYiOORJ7WxKV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e+gByRYE; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e+gByRYE"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-81c72659e6bso4570411b3a.0
        for <linux-mmc@vger.kernel.org>; Tue, 20 Jan 2026 06:26:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768919217; x=1769524017; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mMi0tfylR0DnWdm3ctlilGvDCJlYZg/nIaJrJ1jQ1/I=;
        b=e+gByRYE7dSAmW2EWBH9N3ryb2W6J/CbYaCpt1NhwsvVEdILb9EXcmRojJdGZRY0vx
         lFBEipe4o5b+hrzGNd7fl+sRdkb+AltnTP5Th4FZp27FU2tvWiniNuBXtX2UQg5XsdQy
         Pmj8g2YH0gtOBbFcEWL2IKe7cUuLDLtAQMOPKaLG1nnFxx54qeJi5PIMthtHMtq3bFmg
         /k9YR+xl/KcWS25rIYHJ0HspRuQlnx39OywGEgJXW8X9SOIQGuQCv3+5/HDglS6ja5sT
         vWqylmfLLDAYDE+1Un/d8zslgI6cLgmmIKOlV8iD9KxI18+GChfd54u0ovQ7bPQFAYa1
         S0lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768919217; x=1769524017;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mMi0tfylR0DnWdm3ctlilGvDCJlYZg/nIaJrJ1jQ1/I=;
        b=DZGzqQDBQus+5uXpK6p4zzsAeX9sXgrqma37hk3I9bTsit8D3jKvMII/ucj1e1nvxq
         3c7/uVE6HR8GcWv2kBuLQYRWJbWO9b3zcAKkio52iqfeQJA/WWckxpsO3HOzufEcLuNU
         AGvvLeifTeok2nC9OkSq6R5QS1B6sPi42yqyVxzgztMwJaiTk+3q0s/TDcgm4pGt9rkS
         t6MO5W3u0FVcFSpfklzgzN8Npc5fC9/DkPkwrFoM2u1TkoT3Z5gkgXSqdNBIO3YfDxfj
         K6wgZMQgESQik6Jmgb0TCAAganmRHF94dVqzo5/MbxTAVpgKJ8VouPIZYng8ShzmKr6p
         nO6Q==
X-Forwarded-Encrypted: i=1; AJvYcCVn/P37j5WSRF/0jm9StColIgcCZYTIRLlnvkp80JH4SUJl8hmn7PXJTxHoMe19QjQpROFLCco8aWA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGPozcSbKc5ahStHSirkxQM+v9P7U2s6bMTzhcN4r0RZ15/VaV
	wWBSFHAz3ZjztNMRWWpNnotHjDuMHMDJBLoz8aJPJbXicEYt/9XqYOJ7
X-Gm-Gg: AY/fxX57Yfe5A2Dia4nC/q9wSoeyifXihCNmYcyxpWqBm8toakRFPrRanJCv2CEHhF3
	5V+oVZSDhOZ9dL1x70F2nwKcuB96V/RmlTIaWl5IVM0/sl/JXTxxqOOhDyrO7mt5165JeO4aVkh
	aLu85pqMWMRiPdOZwqLatjQXofzT6ky0vA4LCkNKIbFh4Q5uIUy+RUY+wq/HGHhWpsWZ9K1TmG9
	Lc/kpCz/JZ3/TuaNUudW3bhK6tu9OuqsgW3NRy3ZQGyKMa4JhMCKHoxnjIAhKcoj3wR+OkIFXdE
	mHyr61RBgRsT8y/FXIsDvc6MkAQbiizTIye3VLLCgzRJL1rw9CrS1tvi2n4WMNqfBTeQGyAiOrz
	+csAFB3RMp9Xw5NeDAUNzoeHWpH5SsPbZVGtJfuNlwdPYgELdsdBe1jR+LOCee18HL34M3jHWJM
	B3+VXvnUTqL6c73aIcF7W8
X-Received: by 2002:a05:6a20:1583:b0:38d:f623:f876 with SMTP id adf61e73a8af0-38dfe9455d7mr14972273637.79.1768919216784;
        Tue, 20 Jan 2026 06:26:56 -0800 (PST)
Received: from junjungu-PC.localdomain ([188.253.124.89])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c5edf24dd20sm12323728a12.14.2026.01.20.06.26.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 06:26:56 -0800 (PST)
From: Felix Gu <ustc.gu@gmail.com>
X-Google-Original-From: Felix Gu <gu_0233@qq.com>
Date: Tue, 20 Jan 2026 22:26:46 +0800
Subject: [PATCH] mmc: mmci: Fix device_node reference leak in
 of_get_dml_pipe_index()
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260120-mmci_qcom_dml-v1-1-9b334479968e@qq.com>
X-B4-Tracking: v=1; b=H4sIAKWQb2kC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDQ0Nz3dzc5Mz4wuT83PiU3BzdVEMzSxMD85RE86Q0JaCegqLUtMwKsHn
 RsbW1ABqG8tpfAAAA
X-Change-ID: 20260117-mmci_qcom_dml-e169407da7bf
To: Ulf Hansson <ulf.hansson@linaro.org>, Linus Walleij <linusw@kernel.org>, 
 Srinivas Kandagatla <srini@kernel.org>, Stephen Boyd <sboyd@codeaurora.org>
Cc: linux-arm-msm@vger.kernel.org, linux-mmc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Felix Gu <gu_0233@qq.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768919211; l=990;
 i=gu_0233@qq.com; h=from:subject:message-id;
 bh=3SREWp5AQuhpQ8ZTpxLinHFSGdQevh/GQ+DofGlz+zg=;
 b=S2OhsVbilryU5HA4aYBMAty427/dcxFAd1FO2w1g88jwQwxwxY1YRiwpsuQkBKEY9xejdHBGm
 N5aSOKLz6yaA7hkuLew7GuRKxzzvrcrrXyf5JWdEdM4MPoMhnZRtdpb
X-Developer-Key: i=gu_0233@qq.com; a=ed25519;
 pk=fjUXwmjchVN7Ja6KGP55IXOzFeCl9edaHoQIEUA+/hw=

When calling of_parse_phandle_with_args(), the caller is responsible
to call of_node_put() to release the reference of device node.
In of_get_dml_pipe_index(), it does not release the reference.

Fixes: 9cb15142d0e3 ("mmc: mmci: Add qcom dml support to the driver.")
Signed-off-by: Felix Gu <gu_0233@qq.com>
---
 drivers/mmc/host/mmci_qcom_dml.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/mmci_qcom_dml.c b/drivers/mmc/host/mmci_qcom_dml.c
index 3da6112fbe39..67371389cc33 100644
--- a/drivers/mmc/host/mmci_qcom_dml.c
+++ b/drivers/mmc/host/mmci_qcom_dml.c
@@ -109,6 +109,7 @@ static int of_get_dml_pipe_index(struct device_node *np, const char *name)
 				       &dma_spec))
 		return -ENODEV;
 
+	of_node_put(dma_spec.np);
 	if (dma_spec.args_count)
 		return dma_spec.args[0];
 

---
base-commit: 9b7977f9e39b7768c70c2aa497f04e7569fd3e00
change-id: 20260117-mmci_qcom_dml-e169407da7bf

Best regards,
-- 
Felix Gu <gu_0233@qq.com>

