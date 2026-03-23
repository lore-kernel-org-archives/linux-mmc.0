Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9228F33F5BA
	for <linux-mmc@vger.kernel.org>; Mon, 23 Mar 2026 19:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774295068; cv=none; b=aiNjVaXQ0rl2rh8BTHtXg3oup2tTAUwHTKpw5q73E3XriX/EADxJKZqWXQl86lGfdgWuJ+L5YiYT6CS97RsG0w09njqRiREGz4Flvbza5UEtAmsx81+oK9SKUoCIREkXWfr0eQu6i2mdaZcC6SdBT5BAiGntExcOkl6HF1K5kkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774295068; c=relaxed/simple;
	bh=aUrCSeofNzu8/MrUBwZdZqw4tYqho4z9B3oD2u6iUbg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XklU0UHXs8H8oGe9bdRfbNii1PIASOb6WMuCUjcQmKeumVvwDnWPzOaQWUJRd5tqFKESoFlVud1Y501xYSML7nNMkZkT3XJ/AUHKMaVWeVU5KS+s1pZq5o8c89bpWDzCnjL+wShpoxxrUvXlnPbCoPYUvtjwCeNB/KXBdyM212E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jZp3EiGu; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jZp3EiGu"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2ab39b111b9so14127505ad.1
        for <linux-mmc@vger.kernel.org>; Mon, 23 Mar 2026 12:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774295067; x=1774899867; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WarRcioHs25DGPZf7FPz++9Cb0BrMHjT45zAE3ZKzws=;
        b=jZp3EiGuZRC2M7USeBxZ0Jd93E0Ds/1UIZOI8wL8N/77Y5sCasd4WzrR1zxB9St0vi
         JF1HsCtBR2ZWiA2iuyHaDx/kWlcooH66NynVOPcAmKbQkyx/nztaQfHOsE4Q1UiiwlB/
         wXMhn67Ql81lAhY8q0YXJOBN0SinBGrBbk9zh5AmI/dEFCMH2JsIBxB8AjoHtDhlXvWi
         obuSV0EO86yseiX0PeGPM+nJniEFfvFKbXlllQ638tyG9gwkVRY9XvEAlTMChacOiQHP
         M+z3kVhRo090xrGHcTcBwKfOnQC8hrfWyX+tJXCZI1RwKBsCUWIR0oq4k4g7IQ0mIBdd
         8gOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774295067; x=1774899867;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WarRcioHs25DGPZf7FPz++9Cb0BrMHjT45zAE3ZKzws=;
        b=TVO0jNQAAoWj4T84NIQpP0PvxOcW+NlJDVWqzZUA5KFgpLlNEhJXsIufLx+yX+Y74P
         oilEJjr7P3RRXtdryoa2OYVzSPDMaHeHDumCVcmfEnnJrTWOAtm9RaTwSZ2F/OImr98C
         1rjShthF8EBCSzQ6PcPmITLISyjidPU4HQNb2jwJn7W8QKAVcEg3ltfZ6EnZd+gKgMcC
         ipgEfT1hJl9g1srVz2+G8vvkHDZZ0LwiIMwwOxuDx6K5+xymPWPNqBTMoaKXPTOFaOoS
         ihoXwB5Q7da+0qYKOinOYAepc8kHbQoA3kEQu1O5gAJLTw2zZpgv3QExfNDT+jT2Jaiy
         27rg==
X-Forwarded-Encrypted: i=1; AJvYcCVhDt0abjFyrBIM7T5kWY1cPF36FDHlApdjqiudWtjvNhaxsIeX3TLvu6THFXXYHxeguabxyGrwwi4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1dfxSgPdNtyU2CwkhtuvgLN5CJtTzm840spLKt/AdCTsX9tQc
	gfyiil84/3lo3GyasnPPT1NmWWzkKikGHxRNxaNTx5m4H/s4HoQ1x1Ux
X-Gm-Gg: ATEYQzwgyr4Oy0MRU+ppbOYiUw8G7yw+PWWR3rmulc5IUOSvQ7/lV5wGfn6KtHGACYw
	WwIBMqtlRfJP6RKPwNLLifClCwMynnUw1KCxnk6OwZBila1M6lGY54TrKlj+1SrAMu3uWdl3i6p
	1aLFl0RJDMu0Ib8A+FMR5B+VqemyHplhW4+OSQ6A8hOZyyeeSKeaa4VK/cR/jcAD2ET4wzglnsl
	6IRo5M4OLF3/4O8JSXotGFzJ3O5dU9XjNY/dg8XgoAMQs87WhwSAHcK3fftggaPbz/Ov3KJhtQx
	83/YoUmsXQolbjBXK4nLy3j8vwH2XGcNO20D2ZXnvAcTGp+sQ2eC4h2UjE765npdE6Vg5rLPr2w
	EWZaw0Yo12W8WQ4gh4DqxUfiim1mNhmNwF2HFqJwPPI9+dGUJ3hD8bYv96pg8X4fYtUDFKXG3Vi
	PeLQoT1W0dyyws053/VzJv7Wo=
X-Received: by 2002:a17:903:191:b0:2b0:5520:f497 with SMTP id d9443c01a7336-2b0826ffc53mr120406955ad.9.1774295066862;
        Mon, 23 Mar 2026 12:44:26 -0700 (PDT)
Received: from arch ([2409:40c2:5005:bea7:1ec:aaa7:ee5b:2371])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b08366c3f7sm152080805ad.60.2026.03.23.12.44.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 12:44:26 -0700 (PDT)
From: Bhargav Joshi <rougueprince47@gmail.com>
To: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	xuwei5@hisilicon.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	ulf.hansson@linaro.org,
	zhangfei.gao@linaro.org,
	linux-mmc@vger.kernel.org
Cc: daniel.baluta@nxp.com,
	simona.toaca@nxp.com,
	d-gole@ti.com,
	m-chawdhry@ti.com,
	rougueprince47@gmail.com
Subject: [PATCH 0/2] mmc: hisilicon: Convert dw-mshc bindings and fix dtbs
Date: Tue, 24 Mar 2026 01:13:58 +0530
Message-ID: <20260323194400.22886-1-rougueprince47@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series converts the Hisilicon dw-mshc text bindings to DT schema
format and cleans up legacy node names in Hisilicon board files.

While testing the new YAML schema, dtbs_check flagged the hi3660, 
hi3670, and hi6220 SoC files for using the non-standard 'dwmmc' node 
name prefix. resulting in warnings.

Patch 1 Convert to DT schema
Patch 2 updates the Hisilicon dtsi files to use standard 'mmc' 
node name.

Signed-off-by: Bhargav Joshi <rougueprince47@gmail.com>
---
Note: this patch is part of the process for applying to GSoC device
tree bindings conversion project #
https://github.com/LinuxFoundationGSoC/ProjectIdeas/wiki/GSoC-2026-Device-Tree-Bindings

- The file is enabled by arm64 defconfig (CONFIG_MMC_DW_K3=y)
- It is used in following
    /arch/arm64/boot/dts/hisilicon/hi3660.dtsi
    -included by /arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
    /arch/arm64/boot/dts/hisilicon/hi3670.dtsi
    -included by /arch/arm64/boot/dts/hisilicon/hi3670-hikey970.dts

Bhargav Joshi (2):
  dt-bindings: mmc: hisilicon,hi3660-dw-mshc: Convert to DT schema
  arm64: dts: hisilicon: Rename dwmmc nodes to mmc

 .../mmc/hisilicon,hi3660-dw-mshc.yaml         | 111 ++++++++++++++++++
 .../devicetree/bindings/mmc/k3-dw-mshc.txt    |  73 ------------
 arch/arm64/boot/dts/hisilicon/hi3660.dtsi     |   4 +-
 arch/arm64/boot/dts/hisilicon/hi3670.dtsi     |   4 +-
 arch/arm64/boot/dts/hisilicon/hi6220.dtsi     |   6 +-
 5 files changed, 118 insertions(+), 80 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/hisilicon,hi3660-dw-mshc.yaml
 delete mode 100644 Documentation/devicetree/bindings/mmc/k3-dw-mshc.txt

-- 
2.53.0

