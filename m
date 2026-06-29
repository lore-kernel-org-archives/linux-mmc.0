Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D663D6CA7
	for <linux-mmc@vger.kernel.org>; Mon, 29 Jun 2026 07:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782717944; cv=none; b=Bbto4QswPJM94WKOfKJHn7A7DJMFLs1UDyjMUphoTaCYroXY/voOZlT6a/rPDox/EMftTLYpPpyV7KYLU4uHzQIi5+mfdkCeALjNuuFXEhtEzfD6x46Hb/Biu9D6pWsHOhvPjoGWs/Is4GixSE2B0d8cS6vPMScN5TTBS73I5dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782717944; c=relaxed/simple;
	bh=NAEob6Xx8uYZGneVINsBEv+zQynoEZ+MaDTJLa0nm0I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PLuYDkSsr0Gh5yA3SFrHgVRjtIoPT5QG60hwav/yR0ns4bNb6UmJDBDkphFeJXGJTJih3aOlrk4RmWTqmFZZCPDJbt0sWq5APmXpQTLQp6Em0ZNCR11DnBRuFPBF/s0zF7YQAF89oUywHG2BYdYV6wbf8D78FhMWFtsphpRKCuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K8Vrm4wO; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K8Vrm4wO"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2c81d799ef2so13162855ad.3
        for <linux-mmc@vger.kernel.org>; Mon, 29 Jun 2026 00:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782717937; x=1783322737; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Clb1hh+8YmrAzYXyQFYV27pFJzKo0zM1FY3TyvCkLJk=;
        b=K8Vrm4wODCGDpy+PW/EqATGdOUj4x27LkUWbIJjWd22W3zJPW9UZSfEkozvqd1CXkn
         w0xlm+Pev8Z6JAxDK5/TsKX9ePDA7CUPi+mI0/y1TKOHOxHQ0ukKAoG6JS2OV7SuZkkz
         TbjuICHmZ7a9o04xhXA4GyHHXI39BL8aMSgfdejpTEJ+LrKBBnVK4Rno6mKkvHfSHvo8
         Wl9q/tR4c/9RJhkpczKPTU35xbZgY4/+HdeIVXoGrXV9EgqBrpiK9Gp8pTOw8RZQKYMf
         9KjqsfMeNHUnsL5ECTnDJccBc9Di4pid6eQ2HpLPfcnYYURckgAoZCSK7fWpaa7R4A5T
         +8GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782717937; x=1783322737;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Clb1hh+8YmrAzYXyQFYV27pFJzKo0zM1FY3TyvCkLJk=;
        b=HZ5cdw/TAdkU5Opgf7Kp6zQ43xzNJP0G93XxQXaItnMNlrrXyD1FhjEq+6FbDLFhhF
         Tc+uyIZCqHEIAImIN23UJIQolYv2T5gOWOZTrnfqjjsKTikS7qtZOCoqsU9pCuwZ40lj
         Ki0nDfvZRrQl4amb70GqI9NP8QKQuZF3zXk2RoQZyKkM95LnpQW6uEP1s/ZybJBfpbhx
         hqEVWQuGqm9MVc7I0OS3Z1TsPhXIrfXTRX2WqpYHRhEP0f/SCrbxXnywRRVUeGOcE4xG
         DUDcqkDD8yIOskNDjTzEpojSUMr7zoeX1W1iA8j99emMFM7j2Bi0UPvf6jeY+qZOLGBj
         QKgQ==
X-Forwarded-Encrypted: i=1; AHgh+RpfNHMPl2CjuhdD267PHhWjbdgiZwqjtcoo4jbZRxcj4CwUFUfp90yCf/ncTPay+TAAA2jO7VxNLfE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKBw6K0GvTVERc93Y/oWJbori4Ari8RpNBKfErXGoT0g5CbBmi
	L0VDr1+8l66vJ+fmB8LmKDxqxtaqgNyCMYXohf6TofsBwngoVDjbCvED
X-Gm-Gg: AfdE7clZg5CZoLvMhyksmrYrqPwCIC+gc8DE07vtkz6f3uPjXpGzL5Frf9hzXs65R7m
	E6yxfWRzuWIWmXhyOuunSqroNGxbSOFr9BLiay+KZrT3nyVDHBQMYx1zjA89JGAP5LnRYOcrFMb
	YsciGrMMZVrmoqlolLurSeH7hjX7/Kk7M7Px4v2JUsr7CFEMOyxhjc1GwsfYi6FsuK3cLvkJgr0
	pKZL6COQNlwJV9OE0YvewPK36wdWWccZRptHuoKuhsN6xR54JzCNF2HoRhAh1MjQosQFsablDqN
	AK3sgCvobFy53xa7V2IAoEWKvxtNnfF/Zq5fd4XiJwRlm7pU1Pg8PmTFySjGBD156Rz5ZMPs2DR
	nDUU1MLF055N7h/aSkLU5b1i1ppUeGZz7HyFkXuhjYxuxRZkAEdHP0VJlFaUiBq+Mbapy/MDB/h
	xZNdJAvnPTt2w=
X-Received: by 2002:a17:903:2f8b:b0:2c9:97a7:f546 with SMTP id d9443c01a7336-2c997a7f636mr70780035ad.44.1782717936867;
        Mon, 29 Jun 2026 00:25:36 -0700 (PDT)
Received: from localhost ([2001:19f0:8000:3e6e:5400:6ff:fe38:3d01])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7f63aecb4sm86896695ad.46.2026.06.29.00.25.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 00:25:36 -0700 (PDT)
From: Inochi Amaoto <inochiama@gmail.com>
To: Ulf Hansson <ulfh@kernel.org>,
	Karol Gugala <kgugala@antmicro.com>,
	Mateusz Holenko <mholenko@antmicro.com>,
	Gabriel Somlo <gsomlo@gmail.com>,
	Joel Stanley <joel@jms.id.au>
Cc: Inochi Amaoto <inochiama@gmail.com>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: [PATCH 0/2] mmc: litex_mmc: Respect the bus width request from the core.
Date: Mon, 29 Jun 2026 15:25:06 +0800
Message-ID: <20260629072510.1451480-1-inochiama@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The litex_mmc only forces to use a 4-bits bus width for data transfer,
however, it does support setting bus width. Use this interface to simplify
the litex_mmc driver.

Inochi Amaoto (2):
  mmc: litex_mmc: Set width from linux request
  mmc: litex_mmc: Remove unused logic for the fixed bus width

 drivers/mmc/host/litex_mmc.c | 131 +++++++++--------------------------
 1 file changed, 32 insertions(+), 99 deletions(-)

--
2.54.0

