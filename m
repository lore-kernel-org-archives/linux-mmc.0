Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27E421B8F7;
	Mon,  8 Sep 2025 20:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757361823; cv=none; b=XsS4g3qFpmG1c6zm8347RPs/mpY742Qw13yw+AzEZqbvn9s9LA+toMSVO3wOi8+SjM9940P+ksAiO7SVUG3wVgxQEV4XpHWiR7LTVLCX5N83ZaTsIK2CaCg1igpLvV2uiZIEXMK8jZFzvYIdni+4yArPJKbN38xxP3P9497cutY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757361823; c=relaxed/simple;
	bh=ZAfY4nHqfgM8AK0O863nf5QpKC7p+HQ/dzofmqi7a2E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Cbpvv1CEx9+ewhgBWmhcmrUO+Rwy+hubEB7PzyAGgfju3lhuA7NpD2yPOhmeFUR4HdxGap+XICWiWmg6sqhlJJfSQlugZauo74BwHxHrZScma3O7FgCSHI+s0uQCHbfjhP5RGrWYw2UZ/d8xVaIHmqjDDj556YD3Xf6Scuu7oRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HG6RzaS+; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HG6RzaS+"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b042eb09948so934509166b.3;
        Mon, 08 Sep 2025 13:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757361820; x=1757966620; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ida/lmq2CvCaVRtbfZQogEzqIEvpKI5nNSXM2BB/1b8=;
        b=HG6RzaS+MWOzFBd8mu5lR2chilSQRVhQVzFMVhDf41LYzS9IbZsRtZZpn0P6X/ZH34
         tI3yemQX3fw6Y+payFjyyDMLZXIsJLn55FM+SVJ35D+UVqS+ZWPTZLSBkaS11JmaQdsR
         oOqa7c0RfinVXakZVVtYDonTTU+KsrN4ceoWuowswRDsa/lKQMcuQz0QSQW4zPdZTpMs
         XjyEAPaDQ7LACL4Zo/EJQZ4IUe6qinpxFlmcHUjr9qqD9i1TZr/IwOM+JCjooTH1NP4s
         vhkx81Vv0Sz+GjK+kyfDPfg44GuT/wFvJzFEswkfNxXv0R5TrSYbumeQG26itIdgOJUs
         3QPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757361820; x=1757966620;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ida/lmq2CvCaVRtbfZQogEzqIEvpKI5nNSXM2BB/1b8=;
        b=vBlUtbojPi7pSy3sF198cTjaeMg0MQKhmaEYivUBjlhY7ZoEyweP70gKgjc3apLgYm
         V54is81fER61FdlaY4nPvat75ltCpZ8LP/IUblYCtHScLOmu8kmc0CBYF/R9wtZpt1Dm
         J0p5l9bb/huTydITeNIw56FCqu/o9k5V2YKFfBgM0iDQ62r4o/7JAxvtZ4wkhltSJ/kE
         ABeF2jgJLUz6M2NoYA1uNLqsbr8OxjteNv84CwKCjph+Mbc2TtkHiBLN9YwHRzwmfTz3
         DCyXL2Hze1lhnhnGTXJDxMhbTngIyi084Ia6cwmvxIpZrYP5g57t6sMwb5W35O9/pVeo
         SrSg==
X-Forwarded-Encrypted: i=1; AJvYcCUmmCqDgBjrumVSCzuvWoJ/F9/5EPQBSpWFxJh1lG7A6axAZf8tdoNUtDfbFVm/IBMg6X/cMNSVNZub3E88@vger.kernel.org, AJvYcCWqTgMyK3J0GwMniIEVC09FWwsk9cU13rbMya78VPVC5FSjGPlqffXqy/PDTXMCwpSYF7Cjjul3U13hrzk=@vger.kernel.org, AJvYcCXTLKwgiA7FTP88+iR+AbMcR/LUFqxMQ2U8fDW7DBf7y/HXYdcap75sCMg1dlFaOZ4NImV6LBe+7MNU@vger.kernel.org
X-Gm-Message-State: AOJu0YxcUC67mcSkM4myWgnB7Iem94DEKxCCxKYwLi0akHmkYsgokuqi
	5m9RMV9G9oFf7KGdQPmPzDQSB1b+hU7kusemnbJkRUET5qjHX+G883+lLkUbWLQq
X-Gm-Gg: ASbGncvykFCoy8PagZTpMNqtUrVnULEpmvj98KZ/x/fESsDl1QsRtXQLC/vnl11XqdA
	8o3PjEbyzR6Zqj8q22X18sz63DP3dC0RqKq77fZjOoZiI4i6uFE0ceO+WgUCJdC9qkTj1OWcNNZ
	m+demssBYq02VCq8lywYg2SMIvRR6VzzCDCHIqWKGz3mYFEFSnUrFHzK69k2wOvDgophMer6Xrb
	ol99cWPFAi2WESKNO4z3gw19lM+xr2kZSY49JP3qHlT5cvNLE907ZmFKzDWpNMxoOh4MQCIcRZQ
	CAn3g9VLRZ+oeC1tqRuWkfqwnIkQKRLPmhVTKTzThrdg3HJ3Jp/krQdQTXSbr+6nY5SKPrVi64X
	lxpNduQA9d6kguMqEUastBtrl3qzBR6J7YKz3Mx5/tJ++NQ+2wW3UYK1VBouT3q9eielAzwlvxw
	==
X-Google-Smtp-Source: AGHT+IFqGWzlEZtQOk/UnWNlOkrNxSCMaLPJApJMoATfCsdd8Y1r8qxaW7hfuJYJTHH4C3WtzjR3aA==
X-Received: by 2002:a17:907:3d90:b0:af9:eace:8a52 with SMTP id a640c23a62f3a-b04b1712177mr802551966b.50.1757361819694;
        Mon, 08 Sep 2025 13:03:39 -0700 (PDT)
Received: from localhost (93-140-134-186.adsl.net.t-com.hr. [93.140.134.186])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b0466a962c4sm1440182366b.71.2025.09.08.13.03.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 13:03:38 -0700 (PDT)
From: =?UTF-8?q?Duje=20Mihanovi=C4=87?= <dujemihanovic32@gmail.com>
To: linux-mmc@vger.kernel.org,
	ulf.hansson@linaro.org,
	Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@bootlin.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Karel Balej <balejk@matfyz.cz>
Cc: =?UTF-8?q?Duje=20Mihanovi=C4=87?= <duje@dujemihanovic.xyz>,
	~postmarketos/upstreaming@lists.sr.ht,
	phone-devel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] samsung,coreprimevelte enhancements
Date: Mon,  8 Sep 2025 22:03:20 +0200
Message-ID: <175735302650.4660.10666700905284639683.b4-ty@dujemihanovic.xyz>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250828095028.24503-1-balejk@matfyz.cz>
References: <20250828095028.24503-1-balejk@matfyz.cz>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Duje Mihanović <duje@dujemihanovic.xyz>


On Thu, 28 Aug 2025 11:49:01 +0200, Karel Balej wrote:
> here are a few patches adding some of the stuff that have accumulated
> since the support for the samsung,coreprimevelte smartphone was first
> introduced and before it made it into the mainline tree.
> 
> The patches are based on mmc/next because it contains the new support
> for state_uhs in the sdhci-pxav3 driver.
> 
> [...]

Applied, thanks!

[1/3] arm64: dts: samsung,coreprimevelte: add PMIC
      commit: 9d5f358e797c87c304a8b0af5cd43f08218dfa2f
[2/3] arm64: dts: samsung,coreprimevelte: add touchscreen
      commit: 081ff07146ba5fc752843a389cf68a10c8047a73
[3/3] arm64: dts: samsung,coreprimevelte: add SDIO
      commit: 51d00644986b750d54e58aa3dd5eb5fb0e6040e8

Best regards,
-- 
Duje Mihanović <duje@dujemihanovic.xyz>
