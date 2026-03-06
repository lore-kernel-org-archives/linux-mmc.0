Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB16B385521
	for <linux-mmc@vger.kernel.org>; Fri,  6 Mar 2026 11:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772795242; cv=none; b=UtTOeqY+yZLsmY+AN9v03eUolT1YQgbe5OL+UIYTOuOXsycotNLZoShJ9xagMEfvJiPluNE/k5jlgrOXH9Tx6kZVaj3mMnJHDuTZ6ZVxl+x58vPrXUSbBSZyofhGqdAwKjxijk5SSA7+9xiMEX0LhzS1+o+0EDJNZ8tKqKRHblU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772795242; c=relaxed/simple;
	bh=FSIP3SM84dQdhjEo4jc4DMMlhDQi8z47WoQbZCoDWLc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BOIySmH4NSEfWpgsPPOgFCfV/EmT+E/oRcUrnHEBRcSQ9IX/bhXMKn3+yS00g39QhxeUGd6ZUY/YWNzGL4qlQhtHwblbKMs+o3Ipe/sltGUASThxAsCcuV+y4Z2/FjOTItVbihL6nTScHE8CGtLs06lBGDFjo+SbTdrs2l8whm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JWcsCK20; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JWcsCK20"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-829a9c03780so227254b3a.1
        for <linux-mmc@vger.kernel.org>; Fri, 06 Mar 2026 03:07:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772795239; x=1773400039; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LkZRQN19x7mFcsCOofw3+jxcPy1oc8gx31GqMlFvfgk=;
        b=JWcsCK204wvRcUmpZXjnfDLoZsRcUseoY/HgqISRjwES9SByQm8Y1fRcd9cWDXPMTb
         crwCvFziEpz/6w2Yo3RWHa5ARGREubngZCQpx4QF+uuTM8RDtqgl8rC+PnLT6R2XqwXB
         6u515Ty1gTk1EMAZEz1tNCm3U5/MuStYcH1W+OHU3AXyUJH4lIqehgfLAh40p392xMQo
         k4dVXxfu4BH5NZu3N35AjmHqZDpWgICc3D3IwnZPOhjx3HwixDqtRCCU5N19dLAzytF7
         /1yFv+K6fst/AwUpT09TO9WytjoM96ELxvKoFatDGEstgFxOCQcaBn5Yqwb4jmOPJNpX
         AkMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772795239; x=1773400039;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LkZRQN19x7mFcsCOofw3+jxcPy1oc8gx31GqMlFvfgk=;
        b=FA+CUPPUbXSX/Inz51LSA5Hurqe4N53dhjTd3emQJwnNTY9zvQgjo3wxsJLia4u8cU
         c+OI3DkI9J1sE/lPOCf0BXciNBfYAxmbFF4ezB4pzPy9nnaOZceAXBqdteb3+prh2FnO
         MkByDoIS3QsXFgNKuYF1X/fq5EGlHfjA6aOrVaU8dDUIjLqmszjTytJ3PuG1mf1r56TV
         KEIQ/GEPow9gqlcCQTdtr1VZoGxWzF74Pyhvec+VNgMoreOJOTWoOacTPBr9uNGRPboV
         9zpzQRA+vMFHeelba087cN5mN0sJSZSgky1Cy5snKxFs8j7MJJrPPISRUHEeV/FhIiQT
         ddkA==
X-Forwarded-Encrypted: i=1; AJvYcCUPKBhHxyZHY7/RpsrV1zUUeGslynjyf4gIvMWyuIMSIX2qb/TanIiBSzDH4QOG/ZSYo68Y/h1qaq8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxU0CcpEGpffimQZ4PO3gNfuXmk1qgZOxj+h4ho5nbVeT4ojbvT
	SXbPpiMq6N//ILwc7x6I1vxvfW3swubbs8Tm1XY+C5Btq3VccU1gROhaVwpUOfVH
X-Gm-Gg: ATEYQzwbq0uUgJY/hyv0dn2BG1G7WgSVPkj7nPhys0Wrad0CsyHYpeLLBwOl1lx+kHL
	BCH+3J6ya7k1EVy/ibGQWJjcZuy9kP3fg7ngf3wgA8VdGPgd3tWydhqLL2O15457jboOsAGsJUb
	G9mLADXQxLb0NxNLQTXHP3WWUNVz2a7tlJsyrf6hKHL6KiEFJLLCI5NORapZqnRRmiQywXCMa/n
	cEQxmhefnOpG1aHXmOc6PrfMJFm5bILr0a3UGE1GR3NFHis3biLhf0MJnHQK9VFKcWe3XA6jp8x
	DVHwOtpUHPWXvr83cTMz2ujiOMwAJD3ObCBL2S39hIUlNRTuCJhWOH6sXQheFHX22/vmRkUDNM4
	LwiAQyxnCKd8vSKq0+qihjD4N66eErTXb92JvtUmqe5hhz73QwH32AqDm0nQ9keyONLYbqInDWo
	ajmfLJJZcWT2ju0RTi3nkSRMPOcxmLTK4=
X-Received: by 2002:a05:6a00:1a0e:b0:829:8e91:eff with SMTP id d2e1a72fcca58-829a2f1429fmr1340770b3a.30.1772795239104;
        Fri, 06 Mar 2026 03:07:19 -0800 (PST)
Received: from localhost.localdomain ([58.29.79.238])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829a48d6985sm1428631b3a.63.2026.03.06.03.07.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 03:07:18 -0800 (PST)
From: Lee Yongjun <jun85566@gmail.com>
To: krzk+dt@kernel.org
Cc: robh@kernel.org,
	rjui@broadcom.com,
	florian.fainelli@broadcom.com,
	sbranden@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com,
	nsaenz@kernel.org,
	ulf.hansson@linaro.org,
	linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: mmc: brcm,iproc-sdhci: allow dma-coherent property
Date: Fri,  6 Mar 2026 20:06:53 +0900
Message-Id: <20260306110653.3519-1-jun85566@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260305234703.38490-1-jun85566@gmail.com>
References: <20260305234703.38490-1-jun85566@gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Dear Krzysztof, Rob, and Ray,

Thank you for the feedback. I've checked the linux-next tree and confirmed 
that Rob Herring's patch (commit acb52756e90c) already addresses this issue.

I apologize for the redundant submission. Please disregard this patch.

Best regards,
Lee Yongjun
