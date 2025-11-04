Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27997346E61
	for <linux-mmc@vger.kernel.org>; Tue,  4 Nov 2025 23:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762297623; cv=none; b=L4j9aUKzvmCm/2TdnIG9W4y8RDnPc+w8NjEIA2ivB26/S6CdQmyIb6kq7CHv+pdQKsdVWkWDM3v23wgjSeKX814Y0vbI4S23qaNgQ4tE220v8UFWgvVL3tlkAAMQvP334G7jbMt4cfjByEJRPFG4OPTMEwmWnCAVyOqT9om+1WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762297623; c=relaxed/simple;
	bh=yHkKXPbR33zJA3OGgfovSgAEgZn+oC9vSJyjIjciccM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=h8/UjNA+uy+/4wJl6FFzyQIbT17y3Ue/JRiAxDYTyoTGlAkAfKBU0w6Palqr7kVpPz1iLSupx7TfCAQfe25gNc47JhKIfl18cwr+mScPQkGdlpy+BSo1GPUEWXeiGWjf24O+lb4VN9wzXUZoAF3FlCsqDXQ2OgxczUSLqPT3084=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=MfeTqO1D; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="MfeTqO1D"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-76e2ea933b7so298109b3a.1
        for <linux-mmc@vger.kernel.org>; Tue, 04 Nov 2025 15:07:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1762297621; x=1762902421; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jIQrxW79ZVgRUN8Wsqvx7zHmiYo35lAP7L+li0aZHjA=;
        b=MfeTqO1Dvc8gouY2B2MNvQcXsm2O8X03r/Lixk7jAziZuiOeFhg1SyTpjWVkEfhz2c
         ykr5/EWl1hFW0yrRt4PwJSX0mQM41w0zLhfHoSCSnTsyOdbTo1cWUwTVDhaPTjEKLh/z
         ePtdeekuC4Izp31jNFWLrTMOhjG45oNDA1nWzLqSH50VqtF2UvWck1mM8Ovd1eq9Vl+m
         Spg/mMZhTfOC0Hsjeluohu0OthqwbSBMu1AtrV9WlWt6DmZs+wXruxjfvw33I9DYuuyy
         dEX8kbwO+W7F386i6Yy5GaK5ir8IowSDJypN+Jmvih8uFABlGmi8V01o9QBNC8IidIOT
         J9Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762297621; x=1762902421;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jIQrxW79ZVgRUN8Wsqvx7zHmiYo35lAP7L+li0aZHjA=;
        b=HoVJEs7HS/0NFtLCZliJS9mT/mkaF4A7iBYl4UYjp0mxxXccAb8FofWixgbbNnYSwC
         CsbEdBiUMpYHddOrpCyc2xCb6mlIBdc01bZyqybzKYeG/bK78mErXn2OKnCAqAFTTSJT
         YvBeGHTe6P5H/z9lVVwwHID6TDR++vNE+cEv6hGOuY0plYPB+lG/FlaFpmTXYr4CQQG1
         w+OGouqczGUlaYXYCtgyxF/SDjWDm6RZcuUDzp+GksmfIxis6jBdDKvNr7JtcO+lQQL+
         bmiZ7/qhR1px355xTqhJtpMzEE7HuMQj22xKTxtJYekQkr//yeGA/QJD20buX2TLfV4A
         vHcA==
X-Gm-Message-State: AOJu0YzPibs0cOcoZgxW2C5kGVGWVcFExCMqD3xqzNzL3B6CgNQtMfv0
	h8C1oY0edEs5Mrh5padWRj5WaSDXysyiWJJlBmnr3JUgcnSJKmHg7A0foux6u8k7Cpw=
X-Gm-Gg: ASbGncsHgTAffHvatfGNYNRVJ2Cyla7MKNah23AEnYPiq1h/4umOitaWZv/mXq7x80+
	ST4G562ZzjxbnK1J6taxXnPCCw7hZ2itIg8x9mZDg0FkamN91MVhijJJYW+3qugpNXgc5OZ/CmZ
	HpHbewccltyQ5SRRmTsSna2FdrenyLI6ziqqwN/DWxNepZQvGK3oKXsuGvavJcbmbIyTXeUcJJE
	D6+CbyLLyKe3b9h6CTO5WKKID4cyr7tCljh9djXlNSTARvhbTATR5J4U6RdkVrSDJzjg5apmKUp
	HCDDKTxC9aX+qZ14lRQvueoEGqwmh/wQN3OvUl3vnpJ0DvmeQEwCVjEzl7hn4GfpgPz+ZA8oFwL
	uT7HWZiZriiimji0eKtnMfSp/2IXb3YsX0pexK1/xBKpuTpVMF/rSspnWTzbLJCAZexu8Glnt5Q
	==
X-Google-Smtp-Source: AGHT+IGGdQvgI/Vf/KKbauI1cOuwqSxlp39uLs0QpL5udfp/2y8wBHW57wYN3h5DJcHi+fIfaHZvoA==
X-Received: by 2002:a05:6a00:9515:b0:7a9:7887:f0fa with SMTP id d2e1a72fcca58-7ae035df724mr1524948b3a.1.1762297621600;
        Tue, 04 Nov 2025 15:07:01 -0800 (PST)
Received: from localhost ([71.212.208.158])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7acd5d5797dsm4147472b3a.49.2025.11.04.15.07.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 15:07:01 -0800 (PST)
From: Kevin Hilman <khilman@baylibre.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Paul Barker <paul.barker@sancloud.com>, 
 Marc Murphy <marc.murphy@sancloud.com>, Tony Lindgren <tony@atomide.com>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Charan Pedumuru <charan.pedumuru@gmail.com>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
In-Reply-To: <20251024-ti-sdhci-omap-v5-0-df5f6f033a38@gmail.com>
References: <20251024-ti-sdhci-omap-v5-0-df5f6f033a38@gmail.com>
Subject: Re: [PATCH v5 0/3] dt-bindings: mmc: ti,omap2430-sdhci: Add json
 schema for the text binding
Message-Id: <176229762078.2840692.12323662945445152208.b4-ty@baylibre.com>
Date: Tue, 04 Nov 2025 15:07:00 -0800
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-56183


On Fri, 24 Oct 2025 07:57:07 +0000, Charan Pedumuru wrote:
> Create a YAML binding for ti,omap2430-sdhci and fix vmmc-supply
> property typo for a DTS file.
> 
> 

Applied, thanks!

[1/3] arm: dts: ti: omap: am335x-pepper: Fix vmmc-supply property typo
      commit: bb2ffb47d82229a4f54ca6a83784fa288914803b
[2/3] arm: dts: ti: omap: Drop unnecessary properties for SDHCI node
      commit: 9485ba8ab325c4b420ec92661f15ed14741bb9d1
[3/3] dt-bindings: mmc: ti,omap2430-sdhci: convert to DT schema
      commit: 333fa35fbd1f20b0d8a4af3b236fd9f52f3431b2

Best regards,
-- 
Kevin Hilman <khilman@baylibre.com>

