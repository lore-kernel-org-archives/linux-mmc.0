Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C370405F7
	for <linux-mmc@vger.kernel.org>; Mon,  6 Oct 2025 09:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759742147; cv=none; b=l+mxBtLZJr4z4hddmc4a9Ns/Nv6Z1gtC2v1BabtJl0WtM+l2EYquZWFxLuT9LrTesKtaWQgabjdJyzGewPlBOMsoUABB31m1SHhVthtJ59KF4BpCNmXNW/WKxT5KWJZv4jU8UEvupy7prmf4HapTHMN1ivteS6Z48kATtq9n5v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759742147; c=relaxed/simple;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G6IAaXthr2F8AXm8s5UZ/Rma1mlneqlcz9UrPzpc57v3ACzvGa5j7Ls4m14ixq69tJfEKvJzeO0wJglMf7RZp2IXxpTbvDR3NuMBokMvp8OrA+9aBiHx0yeJJl0uUKK8a0i0493cxOliOf2TN7pRVB0oGIQzqUg51nQHCn7qXPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ue+RDgIg; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ue+RDgIg"
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-3688b4741d3so531936fac.0
        for <linux-mmc@vger.kernel.org>; Mon, 06 Oct 2025 02:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759742145; x=1760346945; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=Ue+RDgIgsE4yQT0Ng0r3AcP+Yffu6otobCd2y+DWE6V1V8Dk7TPSPmaZ6rfJg4od0C
         h61QBFJ67gtDODun/LL9D6Lx6u1kZbT0qmb39jlhQNfxJzKbJZnERIINLCU1kZbK7GKc
         yvOvAAGbiJyAIJvbd61o5rAdBpx+AokLZDSwNdpcJVqUmqQS3Rhb1XnDoJpSGyN/fhcw
         jSnbzAzWbgM3I5pgzX1xQBg2A+Jh3MqtkM4xDTha7mPGy9PwU1/FYP2Gos5ypXchY3ec
         pazagO+We58DuVSaPo2WgAqLK78Xni6v6NN00UjD8y0haYU93KXS90CXgDAt+5E+B4KT
         bqtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759742145; x=1760346945;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=wtX4DZh0WbNLJT+Ux1J2MLAzf+IV84D1ISHe5FWGnjQO4Av3xHY9gkI/y4PFXp4wtF
         UNdY7QY5YDIoV0OEEDTagbuiOI7q2oPG86gvipCsMO5IZlGl+d5cl5HFjD62urFYqYNT
         NRHhawQqYcZQf2aiftLlhQLMN/SEpWx93cp0FH0QeVzmmZUbjuoRWhTHenfA5Eb+jy9a
         5cRWpUGwcOyzIWbM3/l8VZj13GujDltw8brEwxMQpvmKZQ6vE0PLMsG5g+93KcM3rGDX
         A3uOEuI1kMeBATZmIgCzCAFD+NCPbe49oUA4VN5SqdcvtmBJjjl0r5b2HXSf/zvq/AYn
         5zUQ==
X-Forwarded-Encrypted: i=1; AJvYcCURyx2WGEPfjBoXY7QpqKcx90sO1eVaCB8StZjIV+uE2hcNVOFpKmEHZx9+61KrVdJ0OsZjNtgJIh8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKNVEBwRXPpFWssUXpRFHfwmW5XZCyZIRSHmIe3fP0WF0ii9Jn
	rIYmMXu+hfYm+qAx/exgFR8TwM5/yfSYAPNNLrVdhvNLcNm7trCcJGWw
X-Gm-Gg: ASbGncsMELcqAubfa8eyexosGpWj4PMyhSwDhmxZQoTMACZpxNt0Xw96lZYD7zHfYgE
	dMCIbpiM5UA/mfMbBhvZsrfEV3YachvnotJB2GRgpRrlpVuN5I6BNb2d+D2uSr3B2T0lwNSQjEv
	dnlOi+Dmh/hxlOFHbEaC88u1GsxDrJCSsvd0FEotfK9XGpgL/mMEGB9bK8JYsGPAnGtnOGMBeDj
	PJ6C9e28fnQ6mZfY5qDJdT3EH474Q2aKJbhqPX6PphQywENIwMA5mFWzT+U+oqrLIXQx37Q/LF6
	fzoKzPczRiK8ZMZQPMMWcuV8MTFDx27D/O8kjfFiViF6XYBSXpjcoGWrC8okxkyRoLESWpc0Hil
	LSfb3BFDx8fI53X0c1MS7ZHf4Yi07yWHBCRtd4ht7FwyrSMTUnwH8br2TuroZ4u+1bmTzN950IL
	vsicqRmG6qY9NyunBzqQ==
X-Google-Smtp-Source: AGHT+IEEmK6VSSPgZ0Bpy8zQeZLVTMyn3e1f2h8O1vtHHF+mmm9DcQ+TklYOMe+OOB72ZJsFEOrdMg==
X-Received: by 2002:a05:6870:e0d0:b0:315:b97d:c9c with SMTP id 586e51a60fabf-3b105cbd673mr3041577fac.8.1759742144989;
        Mon, 06 Oct 2025 02:15:44 -0700 (PDT)
Received: from Michael-ArchMiniPC.shack.lan ([75.167.107.197])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3b0f141ea6bsm3138712fac.18.2025.10.06.02.15.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 02:15:44 -0700 (PDT)
From: Michael Garofalo <officialtechflashyt@gmail.com>
X-Google-Original-From: Michael Garofalo <officialTechflashYT@gmail.com>
To: adrian.hunter@intel.com
Cc: linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	officialtechflashyt@gmail.com,
	ulf.hansson@linaro.org
Subject: Re: [PATCH 0/2] mmc: sdhci: add quirk to disable bounce buffer
Date: Mon,  6 Oct 2025 02:15:34 -0700
Message-ID: <20251006091534.2551249-1-officialTechflashYT@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <21d7f0c8-9a61-4759-b655-b12a6fad9885@intel.com>
References: <21d7f0c8-9a61-4759-b655-b12a6fad9885@intel.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

