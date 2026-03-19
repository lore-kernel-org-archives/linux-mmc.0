Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DEB63FA5C8
	for <linux-mmc@vger.kernel.org>; Thu, 19 Mar 2026 20:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773953263; cv=none; b=UCa5STksQg7eUIxuCrqbpa1K6BxrGhP8jQbtyYZQNBwj7MktQPJB+y7OUfMbOd1NmB0xQxivKHtp/rmf7aFlXLp/MSTvQA3tNJm+E/P9721PsvGFj3iKx4VnAOZykCfA1NBC65W6MsMcBKPVmGA6uu0RM8WosKWuFYvzHlWpRLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773953263; c=relaxed/simple;
	bh=014sjU+XdA/SuNquuHDFKzVFPp3enVj9IWnY/vHOZIw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=O3MkNBrVf4LhcTJs8T/f+PWL6dc9sdCLioNE/vCFKzRkEWgv5nJtB7UDzh3sonelqOngnmo2gw+7Yo+MFH0UKG5qoA5kq5rpRp2Jja1PyHfbA+CvPysr+duhCW2SoUjpBDCEA3mEzpuN0GBHL//euh+2utA/3ah3bs1vh+XCAc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GOIhKUJI; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GOIhKUJI"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-48558d6ef83so11114175e9.3
        for <linux-mmc@vger.kernel.org>; Thu, 19 Mar 2026 13:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773953259; x=1774558059; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=i0xT1xYExTKZgM/fwlpabfSXPeemeC77Pfk/8l/5YTk=;
        b=GOIhKUJI6w1Rq316Zv+BsJVIr4y8UQ7MiVfWTi0tpEmGmWj5Qa6QnFSAmd5KYAoj/d
         0USllR7FNZuL5jDVekBUqKIUeM7mIOlTwRLYNyMatC/zoJj32Suy845+K3dVqso4HmVl
         /sSS/tgGPLgd+ZETLtqHWZLj4qwElvSSRPld6+T3aUwl1UQVc7onCRnUOOaQD7uMYbvB
         MBohUr0pRsxOdy1IBWDNRUVUN0vBSUIzRciUgTAcvWYdXSYXvxVokmlQ1E+jCMQ8YGmz
         V8b0FKOYmvErmYleFuOtfwl9WPWqigJeK29O/jkVUElRSowIjsU1/xaZxPhiADEDNmIR
         YTUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773953259; x=1774558059;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i0xT1xYExTKZgM/fwlpabfSXPeemeC77Pfk/8l/5YTk=;
        b=bITxg8inzxBBHX5V73QRYFTdg9ovcSM0ljo+R+K08x8+kD+L0FGfXQ5gKsfNAZWFhA
         3+reg++Xou+kTmlltvJ8DDS1AgbuqAZeVsCpEWzj2LGyaq4U7mguEdTzhf9VzLRbpnEQ
         bVdwnY9g6W+IDPckH8M4v/oOBA24jAkEZ5CKmibT4OpWyXRvBRigOuKQ/5zBeHhL4X8+
         ogn7Juc4BNeUWhRcJSMkn961p6pSEEtLNoUOBUs3dFuu0Ejxl3UWSW45D0c3wQ5UrQPz
         lIiuF+3hqQGx1uwdAFV7vEynLuqm91cCbKWd4Ly/U6p3MroxyzyW2tln2AhkZ98BW6s2
         q0UA==
X-Gm-Message-State: AOJu0YwpyhK185hAsFXY25lFqhoeRO5qCFKzDuIPWJG8qW7Z7foon81H
	3FpwSOF3JBMm7Ybx/gvmsXqU7bu5CbqlhXI4qnkQ4HJDkkvQg5uaVLQMBIRldAIGvW89cQ==
X-Gm-Gg: ATEYQzwLmv8H4tCV7EVJt4PvOpBPDTyqERtXet44663KUnxX/X45MReKUCzirLBfbHf
	IxSdBpU6tr1JwEi72MiPLOSMLoOJCG63vjH6/qY8ho6Tt5lQj2wcRM5KIMJY27f3bInJ0jeTcqP
	Fjk9aK5KGPDgyJo2ap+XFA278tp5tCt3v2Gl6F7jM6mofBpND856IoS2pofcYFDy/n4Np71Hf74
	gpQZKQrdopJzSp60+sJCLfNEDSGwUB88GHrg9ejAteFujLhLBokmpkEGXZj0P7NCw1YMOJu62e7
	pJbT1uLg+bijoKazUweTz/oUtUAiIMMQNlAVTKGlqyfIyHQKjnC2gTz47VVC7musKRIitsKQhPi
	jb4sETitb7ssoz7RIUm3DJcpt/zXJ6getgtYByb4LikFvQofKWSch1UIEwM4UaDIore4DjZySLz
	nKWKuU0X2XyV0OEdhg5yXHelkeqKSrfqAeUA==
X-Received: by 2002:a05:600c:45c5:b0:485:3b34:2f51 with SMTP id 5b1f17b1804b1-486febbc66bmr8964735e9.4.1773953258615;
        Thu, 19 Mar 2026 13:47:38 -0700 (PDT)
Received: from debian.lan ([171.22.85.208])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486fe6d9896sm14981505e9.2.2026.03.19.13.47.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 13:47:38 -0700 (PDT)
From: =?UTF-8?q?Adri=C3=A1n=20Garc=C3=ADa=20Casado?= <adriangarciacasado42@gmail.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	=?UTF-8?q?Adri=C3=A1n=20Garc=C3=ADa=20Casado?= <adriangarciacasado42@gmail.com>
Subject: [PATCH v9 2/2] mmc: core: add Kingston CID to quirks
Date: Thu, 19 Mar 2026 21:47:33 +0100
Message-ID: <20260319204733.24870-1-adriangarciacasado42@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The CID_MANFID_KINGSTON definition is required for centralized
management of microSD cards. This allows identifying Kingston cards
that require specific workarounds.

Add the CID_MANFID_KINGSTON definition and its association with the
known Kingston manufacturer ID.

Signed-off-by: Adrián García Casado <adriangarciacasado42@gmail.com>
---
 drivers/mmc/core/quirks.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mmc/core/quirks.h b/drivers/mmc/core/quirks.h
index c417ed34c0576..d736bb4bedf7b 100644
--- a/drivers/mmc/core/quirks.h
+++ b/drivers/mmc/core/quirks.h
@@ -15,6 +15,10 @@
 
 #include "card.h"
 
+#ifndef CID_MANFID_KINGSTON
+#define CID_MANFID_KINGSTON	0x70
+#endif
+
 static const struct mmc_fixup __maybe_unused mmc_sd_fixups[] = {
 	/*
 	 * Kingston Canvas Go! Plus microSD cards never finish SD cache flush.
-- 
2.47.3

