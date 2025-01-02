Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B142F1A2543;
	Thu,  2 Jan 2025 20:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735851544; cv=none; b=hV08xgz5/GNseY6DVA/psrcvGM66W+2ht/DBi83b2SkO3krafRU4yDsmxsQXHQKNnfcjA4PUC5IGgutiuz5D5z53W8z+SO8ExOk3dTovMUccl9CyHxYe+rCaEcQv1aIlRDha2TRr0l49qmT8OpJv34YItzZtqp8UUb1mITWiJNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735851544; c=relaxed/simple;
	bh=pmcXzPGWNkwKDTowcYr2CkrLly8C98ecWjmCsGnSc+I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W64Gz+US/ah29EuO9KxmnHzdi/ddxHPpPT92lDyADV0wvZ3Sxf/QokNLNuEVTXU87IXD6bCnSNZ+lAzXcAag3UN0TGgGd1VHrr/J0V9jfK9qLvMcfhy3dk41327h2GZ4f+VQ7AVAOrNCA5TZJD4xhYG5A0RW7r/90S/Th8B3pa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nowaCw8v; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nowaCw8v"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5d4e2aa7ea9so21375085a12.2;
        Thu, 02 Jan 2025 12:59:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735851541; x=1736456341; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sBnqxBdA04NC/VPNVOL2IprXPii/fgtDRyZ/Qqd6qg4=;
        b=nowaCw8vMOiwvx1SQwq+rW6tRof25Pp4fb2/WqP+aQn+udQScovwe7+hMVum+vot0+
         aa9VZNayVhhGEcOvUawS+DZA4zUNrgSal4ZB+W+XWoPpNUTEKpiKoDJfO+f+OsrQu/nx
         DpNkIOmPUtG30LQjsQDkgoUo4/sk+aUJKYgcncOuivWkubjZtHmOumfBxIqLIewt7u/w
         kmp8aD+LokPV6bkgdzq6ObJsLRMURBDOHLCuTEsnEIyOOq6+yWq/CKidFMZo7Z72B8U7
         gdIeTrFbXFzfKFSoqjeIN7NXudd+YNwdpD3fATbIG9dXAC+W55ATVbd74mf2ifCoUSK8
         y8Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735851541; x=1736456341;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sBnqxBdA04NC/VPNVOL2IprXPii/fgtDRyZ/Qqd6qg4=;
        b=B8/z5wuf/9g3pGgFjXebzXMujZmmOCS3+nDmDTuT1peoUGqpJpDjcPLvO9ZZLuYDJs
         /te/V0nLU7PezVz1q2gq5Tgvzm2zWpjzbttgYVX7yv+er5jRqyb+/nkpr3C1OByvDWsk
         TcKEaRZBDaBuwStjSYCHY5QS5J2MjRwc4BD4TgWF3LDbUxMe4lQoh/sZ3z54mp+qM0f0
         Mzaytu/CMkjSgVthjuL6Nb9mGluoUPJwpm5mA0/KEsTFVgqMrYmNOWiyvwHsoVLxmV4B
         slkTxDJPx8OAEAXDjyBbC1/fY1KkuVxFhLtKIXsJQ98XH8is4LU1V18hWP0ZbUxz8Ank
         cR2Q==
X-Forwarded-Encrypted: i=1; AJvYcCU11OYCZK9P2iKVcx4Lj4sl/qR3LJvZcx72TW30kjMhrzMOo52v/bOzsrWpQl1iVg/dcB805M8B6o43ecph@vger.kernel.org, AJvYcCW6JCryHijQ/RJ0YdpwFvfVdQOln5hp1DZzohxhnQMoQ0U+1+L1XZLNLx4qCJXIaaLHvmGCAci8CdHmiJv0nBakNWs=@vger.kernel.org, AJvYcCWuRP+dA1bx4/n9X58GuppTaEOors+HeYHoIaAWjTH9wwbZ8w/9woXlY2KmWfGksusntAAiBsQUoq4r@vger.kernel.org
X-Gm-Message-State: AOJu0Yxjvga1Tgc4bveUa8H1VvV4pagp2aPcKno9E7RDn8tPD3oJWNqn
	V6aBJIiw5XmstsVGeAKepwNt1i+9S13lEvf2gwJQp8TwOzrRXwtT
X-Gm-Gg: ASbGncvD0c20B5sg2DEQoAcHhFPOMzlhzG1wuORxr8tEy9iO+eAGijjo9eYFCxQ8FcG
	A+jHHEC6724xmr8s/gktsjXrcIjMPLkS3i4sDDRjnX/tdIvyXINt9dpAFy3/KmWV1l0AshkCHYk
	Wcdt9ibaTL7tVQ0F4hhZTlbDFC4cOBPCSlPCyznGORaVT/LW2mebIGYgh7jRP0aBv7j5r7vJIuB
	XoMBNw2hWFx7+5HgzqMqPmaYLeADxgIqYInVSBQDVgLrDrHK/ZuXmgCIEAwNcchxteYW3Hx/y5X
	esTag9KMW5M=
X-Google-Smtp-Source: AGHT+IF3MmqnoF7IbEFavv53iFCaciUlpugsImCEl91cDLF+CSq63GBmgDJVIz4qbLmGReThikaRNw==
X-Received: by 2002:a05:6402:34ca:b0:5d2:d72a:77e4 with SMTP id 4fb4d7f45d1cf-5d81de38bd2mr49286444a12.28.1735851540889;
        Thu, 02 Jan 2025 12:59:00 -0800 (PST)
Received: from ivaylo-T580.. (85-118-76-61.mtel.net. [85.118.76.61])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d80676f397sm19231026a12.22.2025.01.02.12.58.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2025 12:59:00 -0800 (PST)
From: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/5] dt-bindings: mmc: samsung,exynos-dw-mshc: add specific compatible for exynos8895
Date: Thu,  2 Jan 2025 22:58:42 +0200
Message-ID: <20250102205846.223955-2-ivo.ivanov.ivanov1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250102205846.223955-1-ivo.ivanov.ivanov1@gmail.com>
References: <20250102205846.223955-1-ivo.ivanov.ivanov1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add samsung,exynos8895-dw-mshc-smu specific compatible to the bindings
documentation. Since Samsung, as usual, likes reusing devices from older
designs, use the samsung,exynos7-dw-mshc-smu compatible.

Signed-off-by: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
---
 .../devicetree/bindings/mmc/samsung,exynos-dw-mshc.yaml          | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mmc/samsung,exynos-dw-mshc.yaml b/Documentation/devicetree/bindings/mmc/samsung,exynos-dw-mshc.yaml
index 5fe65795f..ef2d1d7c9 100644
--- a/Documentation/devicetree/bindings/mmc/samsung,exynos-dw-mshc.yaml
+++ b/Documentation/devicetree/bindings/mmc/samsung,exynos-dw-mshc.yaml
@@ -29,6 +29,7 @@ properties:
               - samsung,exynos5433-dw-mshc-smu
               - samsung,exynos7885-dw-mshc-smu
               - samsung,exynos850-dw-mshc-smu
+              - samsung,exynos8895-dw-mshc-smu
           - const: samsung,exynos7-dw-mshc-smu
 
   reg:
-- 
2.43.0

