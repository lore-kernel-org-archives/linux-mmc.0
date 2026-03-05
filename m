Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B808631F989
	for <linux-mmc@vger.kernel.org>; Thu,  5 Mar 2026 23:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772754457; cv=none; b=AaUFW91T95I7paD0kdqz56ldzJ0KkjbP9o5secZKQINkMbpg29AbWs86PcZAmrL1cF+qoCvKsswlQY0xNOvaJPBYgeYc4u5T0kKiK/qia0D6ETrJaIQOMmX9AyMpvZkSLrIdItJ8jZxPb8vL3DnK6pcZDLThXXTkM9feDEPtTnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772754457; c=relaxed/simple;
	bh=7uHrOrdZ5KHepAEYUTDsM0EnVX+c6J7LoR0QeJ1n0N4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cFaECSn1tYdQyIBtEH0UnaH+t2gtvumIAGYKpOd2KBmB8VBFZ7JTscrHWisjc4mP0D4YUSWG/h3RYGskz4SD1OQI+9FcSjsWKW9+/FSZTK7QFaf1v0n9SuWUTX/QNdYMzY+UEmqqn5e8wC3vWHqjOeWUfY8jArdYeNEe42d6TqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WQNy1YGO; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WQNy1YGO"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2a7a9b8ed69so97167235ad.2
        for <linux-mmc@vger.kernel.org>; Thu, 05 Mar 2026 15:47:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772754456; x=1773359256; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zcZpnrWcDjcweOn1Um75L9TOaVFcEi5KqxXQxmAOFC8=;
        b=WQNy1YGOZogMaXCJmBEPmcvwSIdkXLG2Mx7a3hYD2+Gi8GfaRX6oSJTgUuqXayq1ys
         nfiXzXou4XlK3aIHtscd7mqEQZWERSrRuKD+o+1/uw6VsyxpdjlnvXh/ESsgpsHSQOcw
         pqxocZ1xqfuT1+fslhtUnTwGZBk//K8DlKjeB2I+yZRkFuCPLlyRcHAQqCeRvm3IBolX
         Zy4hu8Tu2m4HYWqc19X8mDbiibXjL76Q3lEpL8V0Vj6XOAtDndpNi2wV0dOIA+sSd2QJ
         hyJxWEQCU2GcKP9B1TT9fw0HErklhuOuxbEYQ3RDetwv1WZBjGZurJrOKJumVC2ZroCc
         Qj2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772754456; x=1773359256;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zcZpnrWcDjcweOn1Um75L9TOaVFcEi5KqxXQxmAOFC8=;
        b=t+sjxrZyjJkkBG7+4G3bHvfhKo+R4I8Q16TL+lv8W9QWbUHuvzLHvWuVMB+nqMseBG
         yW7fvrPc1lp+8tOh/+fq635bqfa1RigWOFR6+wTpQBZb8bvWyZytl8fPmuAcio+6964j
         pSZXb/4pXRHRSd541at/NBUlUzjIGa0jCzDe5h9TppZJiXhIIDUBWSGzF9OSW/XSvR4V
         q1vvX7Mfpk3Aq/m9QZH5pfK4r+6KWxNIVXYw6OIIZUTRmRfJBTBCBAUPbQAxe4aKKghv
         CTLHGcyRj2AMsKoFY/Psc5rv+zQFvJhs0P5bs6E3PbhN1bAYmgiHD4eychP5kWJjsLA7
         c4/w==
X-Forwarded-Encrypted: i=1; AJvYcCWz9OklKM+DDZddQqsKgZESwwZUvjBiSroK//SIhQznfgxVV2c3LyvJYKXRA3ZC9/E2xNazMYfe6rs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvpZfqpZiyz0Z4C/UgIxdWB290vmCDAFImK+NgbLsDf8U4/+Dm
	Y8Mqe4WyjTcQugKFxYonjVRofP6UzHX0hLGRIKT71Koi96ZGihVbh46a
X-Gm-Gg: ATEYQzyIrZe9ZBdyg5kuBrlrPhsUgW7vdEArpTKe34r9KJJ8g0ebVMtOvRMarYhU7xd
	lbjNmsSNa5jkab2I+ZGqs+gWV+LnMKfRVx2+gtPJ3V2PQId9x/fR6CTFdSQz5Ku1vE7b+DWDTvq
	BCKo2vqYTxw9ycpED2y/ZwkqRlrRAK8O5Av+I9qBBC9NliBMOyxlmj5n2g4DOMNlHiK78hAE8W1
	E3vkIhUN7gvEeg8tEuWPGGf8ferLKCLSmYYEqJxI2Ipnf2/UzhcChGhlIPaESwgCe3Ncpdis1Mm
	FK6A7Is6y7Mc/x1KTE+qNwixTT0AwscplXV9mJVB0JBWaTG3EmYvzIscC/iLCG9lGDdtgjEHbfA
	LiCvvSh8Blcora/jLPR6ubDPLTd4fVgwdIJVzI1NiTF0x9txltnMelykcbSaQ5tEg0raBG6j08W
	m7/MWwTlRJOEX4nHq79U0+ogaq0RBo
X-Received: by 2002:a17:903:1986:b0:2ae:4847:cace with SMTP id d9443c01a7336-2ae8242cf7dmr3033205ad.28.1772754456050;
        Thu, 05 Mar 2026 15:47:36 -0800 (PST)
Received: from localhost.localdomain ([1.212.70.3])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c73917b4000sm2515316a12.15.2026.03.05.15.47.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 15:47:35 -0800 (PST)
From: Lee Yongjun <jun85566@gmail.com>
To: ulf.hansson@linaro.org,
	robh@kernel.org
Cc: krzk+dt@kernel.org,
	conor+dt@kernel.org,
	rjui@broadcom.com,
	sbranden@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com,
	nsaenz@kernel.org,
	linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Lee Yongjun <jun85566@gmail.com>
Subject: [PATCH] dt-bindings: mmc: brcm,iproc-sdhci: allow dma-coherent property
Date: Fri,  6 Mar 2026 08:47:03 +0900
Message-Id: <20260305234703.38490-1-jun85566@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Broadcom iProc SDHCI controller supports DMA, but its binding
schema does not allow the 'dma-coherent' property.

As a result, dtbs_check reports the following validation errors
on the Northstar2 SoC:

  mmc@66420000 (brcm,sdhci-iproc-cygnus): Unevaluated properties
  are not allowed ('dma-coherent' was unexpected)
  mmc@66430000 (brcm,sdhci-iproc-cygnus): Unevaluated properties
  are not allowed ('dma-coherent' was unexpected)

Allow the 'dma-coherent' property in the schema to fix the validation
errors and accurately reflect the hardware capability.

Signed-off-by: Lee Yongjun <jun85566@gmail.com>
---
 Documentation/devicetree/bindings/mmc/brcm,iproc-sdhci.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/brcm,iproc-sdhci.yaml b/Documentation/devicetree/bindings/mmc/brcm,iproc-sdhci.yaml
index 2f63f2cdeb71..579e44843404 100644
--- a/Documentation/devicetree/bindings/mmc/brcm,iproc-sdhci.yaml
+++ b/Documentation/devicetree/bindings/mmc/brcm,iproc-sdhci.yaml
@@ -38,6 +38,8 @@ properties:
     type: boolean
     description: Specifies that controller should use auto CMD12
 
+  dma-coherent: true
+
 required:
   - compatible
   - reg
-- 
2.34.1

