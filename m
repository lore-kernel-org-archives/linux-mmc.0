Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034F92D8DBD
	for <linux-mmc@vger.kernel.org>; Tue, 24 Jun 2025 15:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750777718; cv=none; b=H/QhImeUzFdCeSfYUiN0rMQwlOjK7YNbB2EaYuFU7LupGmZuChYoaqxudPh6rdt7ycL527OTkUwgeo+YKddtfyrdrTuSPFfH3vI9q526EZZ2AEfzVWhWDk1sNntvZ0hFtCP5yEY74kqyYJEwDY3ceYpvcHYUnmMUHrcoA/vUabo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750777718; c=relaxed/simple;
	bh=V1zBXnrO3sZPKcmbx6+Rt9pQYsUWDBe2xc1l77S9+GQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EA+bty88neKiVRQror7cX+vSvD+O5BSVuRITbho/k0fKxacNaz4u9+8/+PSEZ7AwxP79zyFeTtb2h5DF//OMdMLYHLHF8mJg3ngSsAirY7YIBVr6SLCVID1lAdDk/4lk6zErWRyZGqu5aLUFWHixedg0ShTUdbXsfMRp76DtD+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=t9TpXwYe; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t9TpXwYe"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-553b82f3767so4899943e87.3
        for <linux-mmc@vger.kernel.org>; Tue, 24 Jun 2025 08:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750777715; x=1751382515; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=V1zBXnrO3sZPKcmbx6+Rt9pQYsUWDBe2xc1l77S9+GQ=;
        b=t9TpXwYe7zBTNjSGNnVGdNT2do8V/PQyi1SBBfmBZ1+Nd6m31p4fkQu3dn93a5rpa+
         KXbLEoH5OZFX0+uGDbIONjHpjQLL01WbJfzh+Va/b0CTKB+73BxizXnaBfQHzz/hQo94
         jEbbbl0iUnVR/xLpxKge4lIMj+KWFYwMVZSo+dfT65f8o/n/UTQc6hi8iY6gLXIDZNk4
         PbHLAuGlocy+Y73R8yv6b7npvljLBbhe01o7wUPpVsubg8J9L4YAh7UoXDV6MAaOTbAk
         EaT65FZ8f5D502U/9WOZn7ZBVGqG2GoqZ7rTW6V1+bll2ILzZHArJvATkKEeGVi7lYJZ
         EDDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750777715; x=1751382515;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V1zBXnrO3sZPKcmbx6+Rt9pQYsUWDBe2xc1l77S9+GQ=;
        b=Baf5ntjnfZTZ0N29or2SHoGUDsHssCkISmbCb/zmg7Fs+KnLwLVv6I4hElQpNeUAoX
         ynSqTGgAAPxnocLAJgl1AHhAkV5+R7vwdvClmQSfXb1X1sat/Ja4GntFdQNkclu5eol5
         46WJGop2T8CiwhEYaVWF/MII9DoHgRQ4a4KmXt22aT3V6T6OiUI3AqzUIxYnCIgEXI3c
         bDMJbhTD6mmdYv4OyJQAxB9RXnBO3oH4oD9y53Ln6XcdRnjbqLENQ0MUKgMpb0mCWRpH
         9tPVm/JK9W7YLqffzbYiI2eBEEA9T6HgwaU1SoFp8vR4IMJyzkbgJcI34FcELE4LEnaS
         ihsA==
X-Gm-Message-State: AOJu0YyeZinQRWsAT6Is2pW6iKkSL2QKu6ZBENR2a4QLPImJZayYD37g
	mNxQxtzzWz838/Bex14+WME5k7+scrCT6YMQUmEeESgqfKfOhtyJN74Zt5OHDbutKybzER3CPBV
	oBMFs
X-Gm-Gg: ASbGncs3Il5Y08CgLoOePAY1hLShUkMQbu2tOMxkRVX09A7YZ3i5OfHqUOakqW8kOIJ
	y6HbmIdAV1TFZytiyaIEtMAOzFTjM+OuwsY0frsiFqKVtrsQnrn+WJ+lUhEgWHUfh1g/mIMZE0h
	+nW0JC8S4F3fdAyrhUNIOPFTJjoNUjwJvY0tMZYmL9i1GZhCd4QvZWw1i+2xutJOmqArx+In7GE
	z7HyjC4UdRqPYghAdsF17/XGjWoo3ve1Hq2mjndbh5G5qPDx8UprNy61evMWKWqlrkYNW9ktfjQ
	z+ORUMu3XHL9aH0DgA+MVXLOFk/yzn18+aTlF7EOD8OpIetYuu6bKDN7PGUsNvue8tuFmAY9QSA
	MJw6xhcFM+jQ/VKj78prAumPuSJE4kO8bUuR/
X-Google-Smtp-Source: AGHT+IGZqPD+VeY8eWQGlzj2ZKoy4ts+dJxoke/1KMUXrCImIZBI6ZAkuzpVOcutbrc1wic5SSu6jA==
X-Received: by 2002:a05:6512:3d1f:b0:553:2ed2:15b5 with SMTP id 2adb3069b0e04-553e3d26505mr5235188e87.57.1750777714283;
        Tue, 24 Jun 2025 08:08:34 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-553e41bbda8sm1859856e87.127.2025.06.24.08.08.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 08:08:33 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: linux-mmc@vger.kernel.org,
	Avri Altman <Avri.Altman@sandisk.com>
Cc: Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] mmc-utils v1.0
Date: Tue, 24 Jun 2025 17:08:32 +0200
Message-ID: <20250624150832.185271-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This is the first official release for the mmc-utils tool.

Moving forward we don't intend to use a specific schedule for providing new
releases. Instead, we will decide along the road, based upon contributions.

https://git.kernel.org/pub/scm/utils/mmc/mmc-utils.git v1.0

Kind regards
Ulf Hansson
