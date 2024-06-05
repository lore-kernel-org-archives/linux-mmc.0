Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ACC518FC94
	for <linux-mmc@vger.kernel.org>; Wed,  5 Jun 2024 09:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717580091; cv=none; b=oNp4zB52ocGoO0+k0xPSbJwi/aGWvqhHaycKdftIKF2wzTz8eWO3mYN1GqM+LFKaQZzsd83CZdhMzxiUVEsST6Aid+dljC0eKkuX21B3wbTE4ZAxhl7ww4hlQz51WWQLAAigRkYS6mQCcSzoVEsPeXcl9pkiaUKyOkAGIgE6O4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717580091; c=relaxed/simple;
	bh=xBAm8wTcfqGX3dIxsqtVeoTa9bDUYS6PYfrGXcdiaYQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=QLsFEUigpcrmaJkqy7sz5TEFZ3wdo/kpkivIRS8jOgr1pjfe2UudUMxVYFKUSOpXq4lTakVBzJrwDldBUNuR796MOGqdDa+ISyRooOD6V0joqxZXUR7TRnJvAsZY8KCQL4qe+cQt5uxYbYpmS6fRBUliXc3GzRR1RRmg5KtBfVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MVhe5WiF; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MVhe5WiF"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2eaafda3b90so39981991fa.0
        for <linux-mmc@vger.kernel.org>; Wed, 05 Jun 2024 02:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717580088; x=1718184888; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EcCIMAk/UPmF2QOWtKC+NjAHfooYSjfuFRNn5zlzBig=;
        b=MVhe5WiFlNA5BGEPKHMZhsBAOm8vroWal65iTNi6Ik6KABO8PzMHlbCkbQtgWOJPO7
         ICFsj+dJlTiDiPAPdK1QNd3XY8XFjqimAcI0n/Lj46CafePsMpANttjYckzlGqeI6M+w
         cgfFdFC+d4f4PsH5Chr4dn6OvcveqyDDX/lhSrLfJhdci1F1zMl2Jiz3VG+Wam+pYrrK
         aEvpYxW13zpQsvYl8StPZZe0wvZqbZuZtV80DNSQO2ra0CciZmWxa/z/l6eZUO479zIS
         eFExPX9JFk6OmFAa1RfLalP72I5MR6YLfMh995O36iUiHEAg//R7fLDI3oVO2v2wfpNr
         ypJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717580088; x=1718184888;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EcCIMAk/UPmF2QOWtKC+NjAHfooYSjfuFRNn5zlzBig=;
        b=LAqbLngfm5KfnNUTiFNWYqZr9xGqLRC5Iu/a/rWnjmoux0VhqK2ap23y1HtCWdxgCI
         kouXwCPe3xLUlKk++mDQINpR4ktiB2Sz3I+L50hlnk17ESUHwNdFy+cclewBEMAtXMX2
         6mQO5CnYUrtZreFgtu4eNPMEFfgXpv61K2AupKbTV70MtoAWo1iN1JyFCtjTeJGcZO1s
         gsiTbk5jnLLuALnHo5w/c78ec4fs8rlhlS963Mds8VBmALkrurRUCDH5OFdu2s2Sl2yZ
         WuMYG+SrkTJjYORGU/o8McY9oLaCj8O4x8T/jSTXRWO3rFkCqQnRo3zrbhsRJejheMh4
         ldQw==
X-Gm-Message-State: AOJu0YwsyhprlLvOjhMSBPEEPNFNbtc9u2MK+wQnedCEbS/qsCiWIWZ0
	PhLuQ8niMPtMYaJTq5V20uxJleUTqP40nj05K9jrxw8S+JOG+W16ebm+T8nvwiVMDmohLEL0GPR
	o
X-Google-Smtp-Source: AGHT+IFrG+jNVJ8h9d5eB5hGA5iRr6gghB4XBEaPt4CsQhQbvd8pdG/9ny1ye/OC2oDLUbpTZTMJpw==
X-Received: by 2002:a05:651c:19aa:b0:2ea:7d8f:b0a with SMTP id 38308e7fff4ca-2eac776f5d4mr13032741fa.0.1717580088298;
        Wed, 05 Jun 2024 02:34:48 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35dd062eda6sm13963300f8f.86.2024.06.05.02.34.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 02:34:47 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Wed, 05 Jun 2024 11:34:46 +0200
Subject: [PATCH] dt-bindings: mmc: meson-gx: add optional power-domains
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240605-topic-amlogic-upstream-bindings-fixes-power-domains-mmc-v1-1-4acbb8cc2626@linaro.org>
X-B4-Tracking: v=1; b=H4sIADUxYGYC/x2M3QrCMAxGX2Xk2kBXZnG+inhR11gDtinN/IGxd
 zd49XHgO2cDpc6kcB426PRmZakG42GA5RFrJuRkDN75yQV3xFUaLxjLU7Ltq+naKRa8cU1cs+K
 dv6TY5EMdk5TIVbEUM+YphdOYPIUZrN46/a8Wv1z3/QfmnwjfiQAAAA==
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Kevin Hilman <khilman@baylibre.com>, 
 Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1062;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=xBAm8wTcfqGX3dIxsqtVeoTa9bDUYS6PYfrGXcdiaYQ=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBmYDE3gykIcqg7w/K2xquhdS/1vZnPmbjX3Y1R46+s
 F/TOW+qJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZmAxNwAKCRB33NvayMhJ0d5iEA
 DBCg+egVU6ZccVQoRXOvbCGcVAN8f/NB5weY5GF9MW68KPHZMyE7DWMMG1kK+XQsOrDXR0etcrl0KE
 W0iNASKvlLDMTO5q8F15f9M+hevwA7qRJFlpC7vSLkhAI4FPiHynJnvIveQqZSxjbs8yYLFB335h8F
 HbrgD5ZGSbg+b58zuXf+luckfwxwbqkJvu1Xn/CWakTfFhfwu/epU/ADGbWA9RaoJyP/+JBh+MivVQ
 rY4a9fMB+2jrMBHVi97o90Bw5uSYUR6ZuFdnlkv205aOKB+uHYXIiJ7oyG6PRgvQ873G7tkUy43q2+
 3z42YOFmh5jDLbOYxykW4IARtcavA5RvCRzD9d+pLpls4KYm/al/O+0f+A/7oZ3/4bIxp2q9J47NzE
 6eIilGwm0184FzaVPQ1ym7ILE01R5bUwNS8uiJNdcZ92jeh3o6bAX5fjBeqzISVQ7IFl+lW0eHC1UK
 myOpjfI0q8UisbwMBQTxxNZ8p1Wc744sYZHUXLnYQ1ek518alCCdbX5HdYscFg6JbhyZ1L4dziHqG1
 4tc9RBkoMGAGaj3DiFQiO5jaBxUkWYvsKjWe4ajMTsmePQ88jndkb8Eqgm0jkeKV7zCDi3QuXZfhCD
 HcEr9bs+fBbHzR1QFy0AKK+pojNcr7WpOLBVA0liaLFQ2cYiDUmAq/Oi2mmg==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

On newer SoCs, the MMC controller can require a power-domain to operate,
add it as optional.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 Documentation/devicetree/bindings/mmc/amlogic,meson-gx-mmc.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/amlogic,meson-gx-mmc.yaml b/Documentation/devicetree/bindings/mmc/amlogic,meson-gx-mmc.yaml
index bc403ae9e5d9..57646575a13f 100644
--- a/Documentation/devicetree/bindings/mmc/amlogic,meson-gx-mmc.yaml
+++ b/Documentation/devicetree/bindings/mmc/amlogic,meson-gx-mmc.yaml
@@ -51,6 +51,9 @@ properties:
       set when controller's internal DMA engine cannot access the DRAM memory,
       like on the G12A dedicated SDIO controller.
 
+  power-domains:
+    maxItems: 1
+
 required:
   - compatible
   - reg

---
base-commit: c3f38fa61af77b49866b006939479069cd451173
change-id: 20240605-topic-amlogic-upstream-bindings-fixes-power-domains-mmc-a94d681d2e69

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

