Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC9B13BC24
	for <linux-mmc@vger.kernel.org>; Fri, 29 Mar 2024 17:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711733105; cv=none; b=XBIqY1vwrFaRVFJRQFJTe7A9bv01TKNxSEIT6dr+QB6R1LW+W2kVSeK6cqTmgZ997vZOBF0zIhBgTqJHJ/CngkyglQX/17Cf1AdHlP1ROxZGAvV+ArC1VORVlfsc4PHZK+id9WDfivS0rsVFrNHu5V55W+g7VV5fTMN5sprrFBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711733105; c=relaxed/simple;
	bh=dy5/P4BbGd7xVHeclyb88G2cDXZH9d/+8cFl6+jA+cY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Y+eTTUFZnMoi+wyD6/KSEXf+PJLW4WzzwGSRDqRHE69A/xCn68EaoOyr34Q57pnmd+TUesoFawFQ5PgRIdsaO5CO0KImVvUmz1rlLKI7qgAelZYANu1EbvXCXf8EQunMzXmWwDFtdpmG0CdtRLOtFNWh2AG7Bhpb5Cfh4aIgBwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uHzQAnVB; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uHzQAnVB"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2d52e65d4a8so29266621fa.0
        for <linux-mmc@vger.kernel.org>; Fri, 29 Mar 2024 10:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711733100; x=1712337900; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KcD8HRHcrp/DV6/mbC4noaoosmpuTxjJzgOpstPofQw=;
        b=uHzQAnVBz2D91jS9kmxkJKFO+WhpsJbYe+7KdINzZJbNUr9H8uHlwmZrddkC8rGVqs
         iz6BwGOl+qgzYOSs3jhH27uqZ4qMgu1rRxheiAVPy5mwCoHQdpkuIBNYyGzhaJVICT7H
         5IBEBSSJVfJYWI5rfkfHC5x6d+zc4rronihRvBUpZ135y4S8i6GyF6G29Q1fH3wJXBSy
         QCHeJkGHu2Ufr9L8GS9w5f5R7T62+8qIJ4d3oz3DfJHPMbfM1uiYfMV9/55uFGwcSH8S
         DRw8py8yXCBahd+vQeZoahqLYmKIeVx2y8HS+5NeAQ6z1ZYDjwBAHJdn/BfHJsKdMV1O
         x9ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711733100; x=1712337900;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KcD8HRHcrp/DV6/mbC4noaoosmpuTxjJzgOpstPofQw=;
        b=LD8E/meEc2pNzg3gnskDjIJYfpsdY6DUGZbKGIkV9Ft3yd5uVmgNNQS4BE3N5PRvRf
         kDHnQxAgKBlctQRuB6FIh6QGb4GPrSTjH8REygwu0fARh9BU/l1T+2oZQ+6hSZvuBzFF
         f4FrdeozUoJqk4nd+U3B0eaH3DbQxy+ZI74dcxEDNzf/no/QvNPs87zh6XyvKdClhdji
         FGMMcaIJMup8yLydBI0sFvPIyT8xxMG7KR3BTGZpP1exfsi+CnI5fXAs67mReMW4OAFl
         WmqyWpnnDW1LdOdLTkhE7w/U3jz7F5IXKDxptyOwdMLlgS9w2LyS03rRod7Sy/Qjmbb4
         3Y2g==
X-Gm-Message-State: AOJu0Yw/axOwsbLflFwOcbPmrptyDBu161/nQjYIoqk53aBT8wb0M9l6
	bxGc+C/OFxr7vd3F8rRXTBgzIskjhtioW/nlz/+leBcn0+3m6Y4/Ziji+BJfADk=
X-Google-Smtp-Source: AGHT+IFyjNez3sE4PWODMtgmz7C3Sd3IPme3UL4MYB3hYvUDweMQ3FjLWXzSNso3+baxRqVn9yAqyA==
X-Received: by 2002:a2e:a40e:0:b0:2d4:ad34:85a7 with SMTP id p14-20020a2ea40e000000b002d4ad3485a7mr1899831ljn.29.1711733099818;
        Fri, 29 Mar 2024 10:24:59 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id v8-20020a05600c470800b004149543c82fsm8491069wmo.39.2024.03.29.10.24.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 10:24:59 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Fri, 29 Mar 2024 18:24:37 +0100
Subject: [PATCH 7/7] wifi: silabs: wfx: drop driver owner initialization
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240329-module-owner-sdio-v1-7-e4010b11ccaa@linaro.org>
References: <20240329-module-owner-sdio-v1-0-e4010b11ccaa@linaro.org>
In-Reply-To: <20240329-module-owner-sdio-v1-0-e4010b11ccaa@linaro.org>
To: Ulf Hansson <ulf.hansson@linaro.org>, 
 Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Kalle Valo <kvalo@kernel.org>, Jeff Johnson <jjohnson@kernel.org>, 
 Arend van Spriel <arend.vanspriel@broadcom.com>, 
 Brian Norris <briannorris@chromium.org>, 
 =?utf-8?q?J=C3=A9r=C3=B4me_Pouiller?= <jerome.pouiller@silabs.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-bluetooth@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, linux-wireless@vger.kernel.org, 
 ath10k@lists.infradead.org, brcm80211@lists.linux.dev, 
 brcm80211-dev-list.pdl@broadcom.com, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=750;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=dy5/P4BbGd7xVHeclyb88G2cDXZH9d/+8cFl6+jA+cY=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmBvlcZ0oBCo8Oq6N8hTvt2aQpgKAKxHIpjqSlr
 SahyH8uLI6JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZgb5XAAKCRDBN2bmhouD
 1/gPD/92fMg4HeDOH6UvazVFxNBFDiNGJ0FuWFqOWnbcog8PrO2WrRE1CwCalUVCWLtRzP/1FSC
 wPYAKDHxoCbDCUBmACS1AywZqPGdRT/aw3iVNVrBDP8MD36K+MzLgAysUxL+5DCQsNF+L+hi7JW
 3gtzJRKDlGqFn/qAnv+C9FI/Ds01g5GuA0re2O1B1Pjl/6AuKk9hLXXOaWOsgDdjhU+z8KaW2Tf
 xhU15j9lvurPC3StuJfkS3YV/4SoVpPzvO8YB54LV6wyx6RHDxi7UItPbp1KbECx/NE2oGo/EQq
 5NRKXKzKAUd+Ldk9rKoRG0Qns2jZdUZd/9UIbgZIBcVTCd6XbVolP0fzkibJ878LM9hxbq8ZX4l
 qILgzeZ0//xpzDjVLIraNWKk7sZ5rHsOUI2TFzneTIuVzfDM9vc9ArlWOPoe1zJSWathXf8DG+O
 WatvfNlBC2gQ9NTQGlOgJQDC7sjHIeIheQAGBrvbfhhCMooPM9G8Ca8p+ivZvs+WRI1mn253DY1
 +qus3gE+ShRmFXkyRfALGgV5dwLm6Me6e2CoBys14WXjhMe9d3hog/3RNZtVjIeAdG5J+Vw5PgT
 StMgaYVmpBBm4LkTKTBuvaFhH89MiGxa7ChhElyueeFEP7QVpO+cVfVEASSGeAOL1vSNOX0M7cE
 osfdo2scTUV3CIg==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Core in sdio_register_driver() already sets the .owner, so driver does
not need to.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Depends on the first patch.
---
 drivers/net/wireless/silabs/wfx/bus_sdio.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/wireless/silabs/wfx/bus_sdio.c b/drivers/net/wireless/silabs/wfx/bus_sdio.c
index 909d5f346a01..f290eecde773 100644
--- a/drivers/net/wireless/silabs/wfx/bus_sdio.c
+++ b/drivers/net/wireless/silabs/wfx/bus_sdio.c
@@ -267,7 +267,6 @@ struct sdio_driver wfx_sdio_driver = {
 	.probe = wfx_sdio_probe,
 	.remove = wfx_sdio_remove,
 	.drv = {
-		.owner = THIS_MODULE,
 		.of_match_table = wfx_sdio_of_match,
 	}
 };

-- 
2.34.1

