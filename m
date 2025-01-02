Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF2A1C36;
	Thu,  2 Jan 2025 20:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735851542; cv=none; b=RA9GAB8Gv4coBPp9yp8w9dgOGKtY+BlBiyeEfTkEHkes9s89PWDRCjK7jNk4J5/pH+t8HlsFHBXX6GW8a6++IlAivjo8gvPEgUh3CyNHxwa/WxVGgUm62zyFnXSxM5ZxiiwRYlg4ngalpNzitSe6SDyJFWZIkhVmrG/vQU64bzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735851542; c=relaxed/simple;
	bh=+CgKeDYLj+HJKfNp7tUUpSjF2+oHQmSTpayCXyz9aLo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IcGM+GRu4JiiXSe+mtC9kxFVCjN+18eljA9LbOuWnkMyk12Yiy7soC9JtW65i+ALk1ZCtPm6iWlEUGff+yrNzg0H5Qonnwbfsq4BbMIfAdRXZ477sLyYot6YHT/jiBw0bg+Glsn7A7HHQt3m7XDYcZoy71Qgtu4Gl6kSf6Q2SSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KEk/R7Ui; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KEk/R7Ui"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5d3dce16a3dso20440293a12.1;
        Thu, 02 Jan 2025 12:59:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735851539; x=1736456339; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0kWXWi44B3HrD5CUe09lNd7VBLNzzP0xqVwo/jsaRdY=;
        b=KEk/R7Ui18lsygQa1hAB7OBZtfyEMFSKRUmXQQhlaTO+xtd9TyNBtqHlPO6+ucY2Qy
         Q3DXB13qjNTP/P7TSNRAP0lK9NnGZ8HvwwsZmLszeQIbEBoRqeUR9D3uhH8enJx0O51o
         FvGWJEhWrmv7EiMWdUiKofGOumGAmdokARi142sEpFJWXLjCOCRvCcF/D4Uv41rJCQ56
         wS8T6db0p8WrzSlM3XRay8p3WqyYUB7g7pIbm+B4R+aChOZODZQuR9+xqoHyBwIfCQmy
         ygsw/i3Am6GYo/xjWerb4rRf/XL2s4aJBypvC8RUFxqX7uGbPitpW7+txXTbhoJKVH14
         TCiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735851539; x=1736456339;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0kWXWi44B3HrD5CUe09lNd7VBLNzzP0xqVwo/jsaRdY=;
        b=iNPapP8T5CUtcjhRdZB4/D+5b8VU9SCDpJKs8I/QdBKCz6Bxc8RL3WwrndhDe8hnjc
         N/0IFAOzjlnsG+39Lp/f2M5TVXgVgqK0jW1DrJYqxoT9bvoGuDIVJmXN184xqDaB30V0
         0mZaCpJBVn2Fy9cI8YgHZyMhtQwPIvO1p2HyLEHk6aG39gy9DmVZFyo5p2oUkSO5Psyg
         AhrRJbkaFPvEarHuEAj6WaKXOp5FMa0H8HLXzimnCM11DEXRurReg6snMBobKhHFJbPI
         NPPH0bo2HjBtuEpsmKcAonCFpa/YZI042l78Hq0dh2Y4gjMXDaW3wbe3vZZsUl7aI1Ep
         0DAw==
X-Forwarded-Encrypted: i=1; AJvYcCUeYEwE0vQFofyOWab0vbXKlrKxycfJNm3mL5x927SkpOiRjIdDDHteGnoYdNs+YjCMUBQALU+pzsig@vger.kernel.org, AJvYcCWQlS2PgjlPUCTL5p5j5wT6YuljKUuwWL6wI4stJFFM9Zu7gyca72CKzRpvN07hpp+G5HW4Ff3qF4DYXED/@vger.kernel.org, AJvYcCWzNUL4k+oQlr835cg5xsbTsMurTuB+BLNPLlb4FkSwYUWj+5zGVfMm8ZObOL/CqByTkpxJFQ0htnrQswYpx+a3R8w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTVEohgGYp+xczNVJU31zCx1WJKzxsBDwZXgK20PXBjb3Wv/rz
	H4e4ul84Ib50xlTgUTNP1FUFHeLuJz30xEmKCtKvnNYyH01VFfJ5
X-Gm-Gg: ASbGncsSEUqmsVJF1hsxOs3IW/glm+ON12uupoKNxl0NdOrn4Y4grbuMQyCY6h+P8v1
	2mRG98UW5UCDSlNtW0ThU1OILo1eKFGK/+cxl+tTuqXu89lirOSS9DrZNI7DR2hjtgMhuvDBB1U
	Iy6F0YHqOqYEXSmwikb7Ne4yQnx2Rp4GnbqMKHvrajKtuxRB9mdE6TBLMF+wCcZUis+Tp1IACdT
	bfZnmJNe5olxd469t02JMdok7Xf3U0MKuDGLkVx5dhkBVI+QZw9VmPJPN6IVMh60C0NB5Zkl482
	fAvdCXjTdGQ=
X-Google-Smtp-Source: AGHT+IH1piG7mdo0z8tlBALc36OjUwXqC1PidNSuEDYBGYwirYC4nN4TmpY6pCEYB6gUtkCJFaDu0g==
X-Received: by 2002:a05:6402:4010:b0:5d3:f617:a003 with SMTP id 4fb4d7f45d1cf-5d802388f09mr47523330a12.4.1735851539030;
        Thu, 02 Jan 2025 12:58:59 -0800 (PST)
Received: from ivaylo-T580.. (85-118-76-61.mtel.net. [85.118.76.61])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d80676f397sm19231026a12.22.2025.01.02.12.58.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2025 12:58:58 -0800 (PST)
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
Subject: [PATCH v1 0/5] arm64: dts: exynos8895: define usi and mmc nodes
Date: Thu,  2 Jan 2025 22:58:41 +0200
Message-ID: <20250102205846.223955-1-ivo.ivanov.ivanov1@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hey folks,

This patch series adds the required syscons for controlling USI, as well
as defines all USIv1 nodes for Exynos8895 and adds support for utilizing
the external SD card storage in dreamlte. Due to PMIC not being supported
yet, we'll assume that the regulators are pre-enabled by the previous
bootloader for vqmmc. (in our case uniLoader).

The patchset relies on [1]. I also expect the exynos mmc binding
maintainer to pick the specific-compat patch.

Best regards,
Ivaylo

[1]: https://lore.kernel.org/all/20250102204015.222653-1-ivo.ivanov.ivanov1@gmail.com/

Ivaylo Ivanov (5):
  dt-bindings: mmc: samsung,exynos-dw-mshc: add specific compatible for
    exynos8895
  arm64: dts: exynos8895: add syscon nodes for peric0/1 and fsys0/1
  arm64: dts: exynos8895: define all usi nodes
  arm64: dts: exynos8895: add a node for mmc
  arm64: dts: exynos: exynos8895-dreamlte: enable support for microSD
    storage

 .../bindings/mmc/samsung,exynos-dw-mshc.yaml  |   1 +
 .../boot/dts/exynos/exynos8895-dreamlte.dts   |  39 +
 arch/arm64/boot/dts/exynos/exynos8895.dtsi    | 906 ++++++++++++++++++
 3 files changed, 946 insertions(+)

-- 
2.43.0

