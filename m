Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3510823815B
	for <linux-mmc@vger.kernel.org>; Sat, 11 Oct 2025 08:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760172239; cv=none; b=brejxTQyTbWfWa+bzBP5ZG2flLsAcBdvqF9ZuaYxVqQuWbs2BUuufT1jwwog6aeR6MD0VV8DS4dtUsS+darjJKbDF4xxaT/IqC3PRMkx3uGshYPMjN71Zs4n7avg5m77r60Ar4UcPkknL6zF6ffzLeKl50VEUXjbs3qxgH98Cm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760172239; c=relaxed/simple;
	bh=nIQkVkS00h/ZO5JRy6iR8QPChIVXZPi7LdPe3MlLTBo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=uvNQ4tFiRoaneC9hGiMYNzXBddUXKmmEqJijt3mLqTr+Bnfj0DwjW9Y8Szh6pjLdDoiVmR0w1QvwfK18zlxIeh5P0IfkkYnKJBFUqwAnI2cNAU2ubTNtz0dRLvZ9xznwQ59QS2tIxkBXL5L1Xu8ZlV+ghuNskFhdS64ecGxWpLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O5DuNRQt; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O5DuNRQt"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-77f605f22easo2493149b3a.2
        for <linux-mmc@vger.kernel.org>; Sat, 11 Oct 2025 01:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760172233; x=1760777033; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VqCd8yW9EYi9BPy6lU/qWlREPsP6CT/SF7s5Ft32XtM=;
        b=O5DuNRQtwvGH5+igVtg+6vsBk/2wnFLdS5+Ei+kZIGED2MX67fS9D53HV/p/Fi1k+D
         LHiWVtFKetOSTdNIDl2d8IW29fXquialQiDQY7N4tVJM89WryinaHrMBHTILLTek6dkE
         iYk9sqFAhSP1rh8BfFUmPpOqaAuSKSCRjaPdlw/TSRySVgZWQs5nPp3Zusb++XMxef6y
         5r1y13HatTxSup5ukmRwXDxhVi06OUoDJ3mMVi3Y1tzBORjXfAgOYOrYLMAuzTpEiul0
         Pca7FRKmI/kw5ZBvIN1NsPcHRyOCOQpD6sg+tPO+uVKgF+qRXxxLYwqimoLJB07WKsIx
         jpXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760172233; x=1760777033;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VqCd8yW9EYi9BPy6lU/qWlREPsP6CT/SF7s5Ft32XtM=;
        b=p66bkLZNSQJYpGzxJFOqY5Rch5LNyB2FltNWrVpEfYD+3lWyGt3CFmuHtbVqU2zlT2
         fPVpQEQBUEgoEvoUIGP0FihNBC3Gy/7fzmtqyzCk1MNOh8WEyOsU0A7cSyBVBkkG7SQv
         K2fqXNOGlHhQLhZcmsYQfS11BkO8/b11cY7CrS7l8k7vMpYvD3YG7lUlgB9KoSTOcQMd
         hJZOcnFbetxvwEpoxhpvJ6MiNAuYr/1Jw9o6iM3teHCXP+YoObReK8xbXOUDRMeTqUFh
         00MRK6Ma6E0LV/+VI0NTTVkEuc0SkgKH4ANpXxt46OPCZ7Z74AtEPaqpweCZ7MVImQKO
         g/8Q==
X-Gm-Message-State: AOJu0Yzp8/AHHkDNs5CKK0k/BZlE6JcmlLyT7ICbsjyE2wlgGoZnPvFn
	R8O+eTQ1ZqCgRZE3T4cxGVCsQPa8U8d7/Nimp5PwONetImSFhTLE4YrU
X-Gm-Gg: ASbGncsCzds+WwhqTPSeY2TfyDhhDv1uOAKKPPeP1aAns4DzVpslX+HYbBCNemiPGSA
	Mq9YHssoExCo9dYfnaNnDH6d7VjZ8U0pPHH6w6+8qChdj78Au0eK07qO7H5YGLzA5Z4UcxQcvhy
	RbJDoZyVEqB0rGU913vBpdr4QsB07/5xaEVg3jobO6QJRBCWElF4EGS2lDpQLooeqF3F5Vszvl9
	OtjrSq8Jd7d41flnOEWdyxRDsSFKwCKEmixJlSe/jf7uQHZeC90m+WcnsxFfkA7OpVBx5UsbS/9
	kPX2iDfAGlJ3ngev3IcipVoWTgveUfQ0N3EeFQU3LlJ37v09NQAVM/GrZsEUzlaYyL3cMAbEI0h
	j2OZyAldw+r8L0utICcZnRlxczom8oP/ZylnHZqGyXQcOJI3ulyQuNS/3P6h4TZyxltKM
X-Google-Smtp-Source: AGHT+IGTnRLwiun6qqczOPoNp2kFINO5SVtG6H2filW9Od839rhihT2CIxXWcMLbKI3mPbR5HTEQEg==
X-Received: by 2002:a05:6a20:939e:b0:2fb:add5:5583 with SMTP id adf61e73a8af0-32da8133300mr20569059637.24.1760172233455;
        Sat, 11 Oct 2025 01:43:53 -0700 (PDT)
Received: from Black-Pearl.localdomain ([157.50.164.155])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-7992d09659esm5401090b3a.45.2025.10.11.01.43.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Oct 2025 01:43:53 -0700 (PDT)
From: Charan Pedumuru <charan.pedumuru@gmail.com>
Subject: [PATCH v3 0/2] dt-bindings: mmc: ti,omap2430-sdhci: Add json
 schema for the text binding
Date: Sat, 11 Oct 2025 08:40:22 +0000
Message-Id: <20251011-ti-sdhci-omap-v3-0-9487ef2de559@gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPYX6mgC/13M0QqDIBiG4VsZHu8fapm6o93H2IGY1g8rQ0M2o
 nufxWCjw++D91lIchFdItfTQqLLmDCMZVTnE7G9GTsH2JZNOOWCCqZhRkhtbxHCYCbQVHpVSy9
 FRUlppug8vnbv/ii7xzSH+N75zLb3K/HqIGUGDBotbOOcsVKqWzcYfF5sGMgmZf6rNVXHmgMFy
 TWXStNacf9fr+v6AddTdwzoAAAA
X-Change-ID: 20250519-ti-sdhci-omap-907f847f7530
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Paul Barker <paul.barker@sancloud.com>, 
 Marc Murphy <marc.murphy@sancloud.com>, Tony Lindgren <tony@atomide.com>, 
 Kishon Vijay Abraham I <kishon@kernel.org>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, 
 Charan Pedumuru <charan.pedumuru@gmail.com>
X-Mailer: b4 0.14.2

Create a YAML binding for ti,omap2430-sdhci and fix vmmc-supply
property typo for a DTS file.

Signed-off-by: Charan Pedumuru <charan.pedumuru@gmail.com>
---
Note: The property "ti,needs-special-reset" was not removed from DTS cause it will
      disrupt the compilation for other compatibles as the node &mmc is used for all
      compatibles for some DTS files.

Changes in v3:
- Reverted the changes on removing ti,needs-special-reset, ti,needs-special-hs-handling
  cap-mmc-dual-data-rate from the DTS.
- Fixed a typo to resolve the errors identified by dtb_check.
- Changed commit message to justify the modified changes.
- Defined if-then statements for compatibles to add required properties.
- Removed "ti-hwmods" property from the YAML.
- Link to v2: https://lore.kernel.org/r/20250908-ti-sdhci-omap-v2-0-72927890482f@gmail.com

Changes in v2:
- Changed MAINTAINERS to "Kishon Vijay Abraham".
- Renamed the YAML file name to "ti,omap2430-sdhci.yaml" from
  "sdhci-omap.yaml".
- Dropped unnecessary or unused properties from DTS and made these
  changes as a seperate commit as there is no user of it.
- Removed previously defined properties like ti,needs-special-reset,
  ti,needs-special-hs-handling and cap-mmc-dual-data-rate from the YAML.
- Changed the commit message to elaborate the reasons for modifications.
- Removed the pattern property for pinctrl and redefined it in a regular format.
- Modified the description of the property "clock-frequency".
- Changed the subject line for the binding patch.
- Link to v1: https://lore.kernel.org/r/20250523-ti-sdhci-omap-v1-1-695c6eeac778@gmail.com

---
Charan Pedumuru (2):
      arm: dts: ti: omap: am335x-pepper: Fix vmmc-supply property typo
      dt-bindings: mmc: ti,omap2430-sdhci: convert to DT schema

 .../devicetree/bindings/mmc/sdhci-omap.txt         |  43 -----
 .../devicetree/bindings/mmc/ti,omap2430-sdhci.yaml | 202 +++++++++++++++++++++
 arch/arm/boot/dts/ti/omap/am335x-pepper.dts        |   2 +-
 3 files changed, 203 insertions(+), 44 deletions(-)
---
base-commit: ed61cb3d78d585209ec775933078e268544fe9a4
change-id: 20250519-ti-sdhci-omap-907f847f7530

Best regards,
-- 
Charan Pedumuru <charan.pedumuru@gmail.com>

