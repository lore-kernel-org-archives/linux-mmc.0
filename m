Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0611656766;
	Wed, 19 Jun 2024 05:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718776042; cv=none; b=UxFqTg2Viwsfg4bV7jLDz5Cxosuik35BZUTXGGUfFRMouoqI4YpFe8VpkyKT6w+orJjM+ssTgUAkNOm6ir6YvJySesXKWQQySnKfjXNjICZ2Jk17GKhaigafS8dnKbNw3vybogGUPxrkGfj/7cTUGdMNhc7FXPoANpHvwyHEKYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718776042; c=relaxed/simple;
	bh=7P1okWpOO6WNBJvAAoKUChYhTW+x7dpCaLkgFFkQJD0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=e9duikDfJCZPoysK5x3nd49TLQYyCyyTaeKw5F0Cr567xfVf6gJrW8n3utdRh+3cyvq/Q/LcBrhLt5+Ybd0lq2BH6ncATzeWE2iZLDUvVOUdpdBmNI1H3qmRH4fN030nTNP4B3OvdXnEVv9Uz2yMrisLNbhVvpHF1TAxmWXUp0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GgPDe75Q; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GgPDe75Q"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1f7274a453bso53826105ad.2;
        Tue, 18 Jun 2024 22:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718776040; x=1719380840; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xmy0N005vykACzOrwLWKg78YnGOsI46b19r1tLbKSGQ=;
        b=GgPDe75QhgoGneIq6JYZ3NIPacljyqjUXvmVPw9vaTsAnBviwBR47qQJAOR4kuUv2K
         otBs7gapZl+3OyUp/orG8C2ypM6f8SwJEj8Tj7ZcTlZNPJwwnaL7j2o02M03KQdMNDJe
         0TDPNHrMGsjd+R44D6580dPmBJEEQagn7yPN0IBUDIIuTZ+uIB+itOjUHi1l4Qlekzsm
         EoNwrE9cSZjjf6k5cSZaxKfpNKkG4mW8kxREeWofmjwjMHtDuc1yWnN3A+voO5smiVC8
         cGmjuCjJ15ItuEsev3+UZwzSKpvCpWd1MYcSnA6lLW2Q0FUiDFK5EzUhsrZsLqK5JuDa
         QdXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718776040; x=1719380840;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xmy0N005vykACzOrwLWKg78YnGOsI46b19r1tLbKSGQ=;
        b=rVmnkUB5bJcKBDy2jC3bjDT6KgaRE5K3pRTaUzAd5iSo1oYIhGrNpN4dl3Bgojxmy1
         waznDahz9RkFF9ULI/+I3775d//bJl5aszXG+DqxAKjXe7Obc7K+0O5Js9YqLsVQ6MJN
         v4I8coVOjPen7IZteYlzxUByungO8jusG5fs+AJOWaKXWhNuXl4C66VPZV4LmruuZJ+s
         l3QLoMzf4Fl4YtCZJOb0TOboVbT4BiGCr4hTdoF1nTcFGY/HLZnfc9o3azg5DaRpydib
         li7jm18ImmKu4w8Okp3HiNDYps0sG3Iq7lPKDV64tX576urtkuSrXtsCCksIMU6GExat
         PGHQ==
X-Forwarded-Encrypted: i=1; AJvYcCVhTFkW7eqMzQR59cxfogfPsWlYLiuhi996JdHLo8Qtx+csmIqShkrecNh10G8ZKhoVTAvSItoa1DNNp4FnoDvWmoz8RCp0A6UpOyqrSbjRPNCfMDCaqIxXc91+pvQ3XTfu9Qn3+iV+mXgfVfHHHjB+t4FNw1mVUO22zPkkvTNwMAdr1w==
X-Gm-Message-State: AOJu0YzUhKXeXCgTj1XUE/qKnVVpvW3twB88+NjjBncP4Ehz3GzvjoAG
	0/EJn7pnnE/lmArId0svXrVfBhsqojv8xs5LX/GbP2Voi9+zgBwg
X-Google-Smtp-Source: AGHT+IEqn0CmU/JsquGliQncUaNPPefNK8oEGv+ja6+2ZrmxDGOL3dPwo2hXNHhDVAF9nHh9qQmMYQ==
X-Received: by 2002:a17:903:1249:b0:1f7:26f:9185 with SMTP id d9443c01a7336-1f9aa3ecedfmr18080665ad.10.1718776040035;
        Tue, 18 Jun 2024 22:47:20 -0700 (PDT)
Received: from localhost.localdomain (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855f598bfsm107487865ad.300.2024.06.18.22.47.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 22:47:19 -0700 (PDT)
From: Shan-Chun Hung <shanchun1218@gmail.com>
To: ulf.hansson@linaro.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	adrian.hunter@intel.com,
	p.zabel@pengutronix.de,
	pbrobinson@gmail.com,
	serghox@gmail.com,
	mcgrof@kernel.org,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	forbidden405@outlook.com,
	tmaimon77@gmail.com,
	andy.shevchenko@gmail.com,
	linux-arm-kernel@lists.infradead.org,
	linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: ychuang3@nuvoton.com,
	schung@nuvoton.com
Subject: [PATCH 0/2] Add support for Nuvovon MA35D1 SDHCI
Date: Wed, 19 Jun 2024 13:46:39 +0800
Message-Id: <20240619054641.277062-1-shanchun1218@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: schung <schung@nuvoton.com>

This patch series adds the SDHCI driver for the Nuvoton MA35D1 series
platform. It includes DT binding documentation, the MA35D1 SDHCI driver.

This MA35D1 SDHCI driver has been tested on the MA35D1 SOM board with
Linux 6.10

Shan-Chun Hung (2):
  dt-bindings: mmc: nuvoton,ma35d1-sdhci: Document MA35D1 SDHCI
    controller
  mmc: sdhci-of-ma35d1: Add Novoton MA35D1 SDHCI driver

 .../bindings/mmc/nuvoton,ma35d1-sdhci.yaml    | 106 +++++++
 drivers/mmc/host/Kconfig                      |  13 +
 drivers/mmc/host/Makefile                     |   1 +
 drivers/mmc/host/sdhci-of-ma35d1.c            | 297 ++++++++++++++++++
 4 files changed, 417 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mmc/nuvoton,ma35d1-sdhci.yaml
 create mode 100644 drivers/mmc/host/sdhci-of-ma35d1.c

--
2.25.1
