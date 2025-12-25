Received: from mail.mleia.com (mleia.com [178.79.152.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41EDA2BAF7;
	Thu, 25 Dec 2025 18:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.79.152.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766686583; cv=none; b=OPs60DCmjCJnU7KSZceL7eU3cIHfkCGBwNxr6981E27bfqulm0rGKuTiJZLSFfYR/unKb8GdmqvGAVGKVy7Erap2nfP17bXhX97IAFF7v3qts4fI3EW5oPdN6o8J2Ti8hzYxE2MIix2AYOLe8zzQ6gnjYvbQvwmNtLykSD5BHNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766686583; c=relaxed/simple;
	bh=v6275rn6sSC2/Ycn7rIgB3jfNbMlDqc1yXe3pne4wtE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o8gG4c8yKu6GrW+eZZGvqBBkOtw4KLuIiJvfGXGdUvTEIcXUNvp1rwiQhuhMFm1wFH2hlL/lZ+wKkIzxIraXulES9JJBmPUU0LGx+2nBA7cdLFRJYZ0jjMMaZbyqL8r2Knch5hbROFYgsXzDf9GeQSsgcIqEED/349AwZwkX810=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mleia.com; spf=none smtp.mailfrom=mleia.com; dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b=kVsooJJQ; dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b=kVsooJJQ; arc=none smtp.client-ip=178.79.152.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mleia.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mleia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b="kVsooJJQ";
	dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b="kVsooJJQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mleia.com; s=mail;
	t=1766686580; bh=v6275rn6sSC2/Ycn7rIgB3jfNbMlDqc1yXe3pne4wtE=;
	h=From:To:Cc:Subject:Date:From;
	b=kVsooJJQHD/R43rysbKnj4dGW8xIJcDWAVhEovYd7RmbrqYSD0cunMz7qxuD+G7XI
	 3rjJxdrqCjbcLeWqbtJRuJvxaNvZSlVgSv8tnp2PvWRZqr9bD04dv2HEpgUzMO/DkE
	 JGMq0YZfRbCb06PR3f+qqQ5T/mz5YOmuekYOqBifT2GxllK/aLMarA0XayEK34Ldoa
	 f1eJiDEBwu5P19tqlazCEfvPYD1RqhOyhOkbiW3atmzAb4da5F0XM2gXKpsrLZc9nD
	 yvpZsoTSEm6c9mXeQUQee9HAvgLzHpe469EP42UKkmA5sfm5OwwlJr3BcBLN8HApfJ
	 xfePCExxzIVaw==
Received: from mail.mleia.com (localhost [127.0.0.1])
	by mail.mleia.com (Postfix) with ESMTP id ABD393E8C62;
	Thu, 25 Dec 2025 18:16:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mleia.com; s=mail;
	t=1766686580; bh=v6275rn6sSC2/Ycn7rIgB3jfNbMlDqc1yXe3pne4wtE=;
	h=From:To:Cc:Subject:Date:From;
	b=kVsooJJQHD/R43rysbKnj4dGW8xIJcDWAVhEovYd7RmbrqYSD0cunMz7qxuD+G7XI
	 3rjJxdrqCjbcLeWqbtJRuJvxaNvZSlVgSv8tnp2PvWRZqr9bD04dv2HEpgUzMO/DkE
	 JGMq0YZfRbCb06PR3f+qqQ5T/mz5YOmuekYOqBifT2GxllK/aLMarA0XayEK34Ldoa
	 f1eJiDEBwu5P19tqlazCEfvPYD1RqhOyhOkbiW3atmzAb4da5F0XM2gXKpsrLZc9nD
	 yvpZsoTSEm6c9mXeQUQee9HAvgLzHpe469EP42UKkmA5sfm5OwwlJr3BcBLN8HApfJ
	 xfePCExxzIVaw==
Received: from mail.mleia.com (91-159-24-186.elisa-laajakaista.fi [91.159.24.186])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.mleia.com (Postfix) with ESMTPSA id 2A3853E8B7A;
	Thu, 25 Dec 2025 18:16:20 +0000 (UTC)
From: Vladimir Zapolskiy <vz@mleia.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH] dt-bindings: mmc: arm,pl18x: Do not use plural form of a proper noun PrimeCell
Date: Thu, 25 Dec 2025 20:16:15 +0200
Message-ID: <20251225181615.1402052-1-vz@mleia.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-49551924 
X-CRM114-CacheID: sfid-20251225_181620_720789_2E170A3B 
X-CRM114-Status: GOOD (  10.47  )

As a proper noun PrimeCell is a single entity and it can not have a plural
form, fix the typo.

Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
---
 Documentation/devicetree/bindings/mmc/arm,pl18x.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mmc/arm,pl18x.yaml b/Documentation/devicetree/bindings/mmc/arm,pl18x.yaml
index 8f62e2c7fa64..066f21deb3e8 100644
--- a/Documentation/devicetree/bindings/mmc/arm,pl18x.yaml
+++ b/Documentation/devicetree/bindings/mmc/arm,pl18x.yaml
@@ -11,7 +11,7 @@ maintainers:
   - Ulf Hansson <ulf.hansson@linaro.org>
 
 description:
-  The ARM PrimeCells MMCI PL180 and PL181 provides an interface for
+  The ARM PrimeCell MMCI PL180 and PL181 provides an interface for
   reading and writing to MultiMedia and SD cards alike. Over the years
   vendors have use the VHDL code from ARM to create derivative MMC/SD/SDIO
   host controllers with very similar characteristics.
-- 
2.43.0

