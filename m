Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76022C1788
	for <linux-mmc@vger.kernel.org>; Mon, 12 Jan 2026 22:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768258163; cv=none; b=gzBg2p5B/KFrwdTNPTmELUTDPbvYeBWYAtf2pHxcsFMqujoka9A0XWr7PgsefZ3WxTqZVahXjgiqGZ+quSqfpWd0ldLzWjSsyN/SHi3jlQ/GyUcsh6ImgwsHZzIJOtD7q16/2rYJYXyUQlWohgxUiRIROfRUaR7xCYbHy53Oihg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768258163; c=relaxed/simple;
	bh=iCdp8gctkLaPW3D/fei6jxGKlMAA2QOc3/o0wQqctm0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HifhMLzSPnxNqvrX5qu7PhL7Q5kCXsa72qdd4PwH6g90KzXqn0S1kIkstmBGpMjLARC5Ar1KDl1qUdCYO6uBuQQUHjHkAeHt3XLT1NUajxe6+9VMspHwiFIbWDJGzrlMFfSvnr2ns0iDBQP7DkE+CUg/bwkscs1Jcb/M3+uuw0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BYve7gLJ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=m4wJ37Wh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BYve7gLJ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="m4wJ37Wh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768258141;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YD4ytu1UC7PeOKKacILQRYf/wWE4kZNXtZ0iRfKR+V8=;
	b=BYve7gLJrkHfeK5feRE1VT/x654c4gASvX44Vw4qfqyxr5f5rstBTf38LYNFXITElhId+o
	KgboPCHcNLhwPEB/z5Hl6c/ZtT1QRLljlOBQ/sztYypxr9u/uSUszy2mJ51h20LSp3S3th
	PsnfjVoyIkXt3k9ySPEK8TzYyM3KCd4=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-120-shSUF-0TMkGwNNzcxVcUeg-1; Mon, 12 Jan 2026 17:49:00 -0500
X-MC-Unique: shSUF-0TMkGwNNzcxVcUeg-1
X-Mimecast-MFC-AGG-ID: shSUF-0TMkGwNNzcxVcUeg_1768258140
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8b2217a9c60so2158137485a.3
        for <linux-mmc@vger.kernel.org>; Mon, 12 Jan 2026 14:49:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768258140; x=1768862940; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YD4ytu1UC7PeOKKacILQRYf/wWE4kZNXtZ0iRfKR+V8=;
        b=m4wJ37WhhPaCKUPOpoK5fqS/rng3r+lGtLvgtxOGsouNIDVI6SAibGVzrsO1zQvdbW
         lMkeU/i0ZXl5uj2uPpSUsJhHeaLkDbdoQgON2DAFpWKJ1/W1lvDP7bJx4QZIQntnk5Pm
         ZuOMC753NZTOyLfN3o/cP0fsapvv8nv52/QDdoK+vWJPzxKYJugW8NgtY4VilER3wJea
         RGSV5huF6iw+u+vekm8WTpjMpkHfU5Szb358OwbM9F2RApl4ZO3w2s+iiOsJPoTTWAJ8
         GceA1Q+FwSgZ5cgfXlrult5qJxbHZiTmVFFAV6zExqQylTAnsLRRSrTKRWU17iskvKDQ
         x8fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768258140; x=1768862940;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YD4ytu1UC7PeOKKacILQRYf/wWE4kZNXtZ0iRfKR+V8=;
        b=AkFIOst8+8uE2w4V7OqgM5lo+zG8IU3MtuQdDzZPSlGCXt0LEaI+xVeS390b7ali+i
         x4X3Zqp/JF0LlGhFTwJDvTn7y+lfBVHefP+xTqy7tmohlBpQDr0NR8993G4j6o7pEd9q
         ePh19pNkK6zmbHtu/xMzw1OgIR5hv8PFaXd8eOnCdyc5RCrQbmZnLZLrOep+HkRg12bD
         zVSbX6kDHbB/9Zcf5WkWuDeksQ757wk39KqPZS2KOQF+HnCS0ZYK7gNi2HkjBZGzQQyt
         Pa1UwfXzxde1G5XepxB0VYiQvVXos0WgVP5KsA4LZSvcKYeWdM3IILEdVgP7TnlIpJFp
         3+eA==
X-Forwarded-Encrypted: i=1; AJvYcCWw4YMB7DA7DMGuqOwSMFQpifMBLxmtwXIoITiBmjqniK4bG8guAqG45hZVJOV74H+Qvk1i0mcMJps=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8eshKMLvYvYjgjRvh4psJsKkW5kDU7AaZ7gWKew+UdPEZiQ+o
	gNVg5eA6XBNjMtx0Ufbvy1qofbAUvxuz2nJWlJYcMcCmmfrkoxwjPi32ABVHBT3yJLmwWAvCvvm
	5Xl8EYojIOEZmmJddaFdwMPqDXtlvSRIHQR/1Q3tHL+mr+aOiJmi43dPYmGvXtA==
X-Gm-Gg: AY/fxX7d7L9BgU9LiKE7Rlq/D5h1RBcgLkcxQ+rMOOGdBsOlZHW0u3Ja5uOT4jg/k7P
	KqqbFn1fgVS+AMiPTbmLkRQtALiUK6sVcriH+1gQcJdaIZICc8onXGw8XcwaJAcxUZFJZanHeoZ
	V/UmPCeZU6oRbws+PYU4aC6Xeq4PFXmxji4yl2pCcquDbRQofWHfMi9wapMefaWG1K66JbYnZql
	2q78xqNZMx8M/Pnhz6V/7zE3n4vzpwzTnMb3bFtwCLDZJPSeLj+K3eoNZFsY8iQHD/R4Xvx1wi8
	KvbF5i2s3MSOoQfypHYLIvqIe/DaRh7R0po88kpcnp8jrcEC9ZjELgsdFB0ettgnzJh4AHejgn5
	6BHt3Owj7uiH/m4ZdRlxK3/CERicrHV6tluXS3Gre4mE8hXWUrA==
X-Received: by 2002:a05:620a:4108:b0:891:ff1e:f6ad with SMTP id af79cd13be357-8c3894074b8mr2453278085a.69.1768258140185;
        Mon, 12 Jan 2026 14:49:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG201o4ExC/9sZW9hmJWN6Sg/WNrAeO7v2m8Isi7OqtUUCnuLGIBG6+RVNvUpMuFweqnF6Qcg==
X-Received: by 2002:a05:620a:4108:b0:891:ff1e:f6ad with SMTP id af79cd13be357-8c3894074b8mr2453276785a.69.1768258139846;
        Mon, 12 Jan 2026 14:48:59 -0800 (PST)
Received: from [192.168.1.15] (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c37f4a6145sm1580930385a.5.2026.01.12.14.48.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 14:48:59 -0800 (PST)
From: Brian Masney <bmasney@redhat.com>
Date: Mon, 12 Jan 2026 17:48:03 -0500
Subject: [PATCH v2 09/16] mmc: sdhci-pic32: update include to use pic32.h
 from platform_data
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260112-mips-pic32-header-move-v2-9-927d516b1ff9@redhat.com>
References: <20260112-mips-pic32-header-move-v2-0-927d516b1ff9@redhat.com>
In-Reply-To: <20260112-mips-pic32-header-move-v2-0-927d516b1ff9@redhat.com>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Brian Masney <bmasney@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, 
 Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1270; i=bmasney@redhat.com;
 s=20250903; h=from:subject:message-id;
 bh=iCdp8gctkLaPW3D/fei6jxGKlMAA2QOc3/o0wQqctm0=;
 b=owGbwMvMwCW2/dJd9di6A+2Mp9WSGDJTq7y/57X/4i3dN2fFy5u7fHKs/TKqBd2DFpzsU71/X
 WPVzTV3O0pZGMS4GGTFFFmW5BoVRKSusr13R5MFZg4rE8gQBi5OAZjI3s2MDFeK3/4+sMcj+4xY
 0qTsysWH+KfNDPOwdw/On8oUyqJQsoKR4XBdg3NARmvz74KEfSsLDotMnrOx+UjObaaN15WtIxp
 T+QA=
X-Developer-Key: i=bmasney@redhat.com; a=openpgp;
 fpr=A46D32705865AA3DDEDC2904B7D2DD275D7EC087

Use the linux/platform_data/pic32.h include instead of
asm/mach-pic32/pic32.h so that the asm variant can be dropped. This
is in preparation for allowing some drivers to be compiled on other
architectures with COMPILE_TEST enabled.

Signed-off-by: Brian Masney <bmasney@redhat.com>

---
To: Adrian Hunter <adrian.hunter@intel.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/mmc/host/sdhci-pic32.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-pic32.c b/drivers/mmc/host/sdhci-pic32.c
index 7ddac0befed87e6e46acfa7593203a5b540558bf..2cc632e91fe454bf29c1da22e45135d5d0267f54 100644
--- a/drivers/mmc/host/sdhci-pic32.c
+++ b/drivers/mmc/host/sdhci-pic32.c
@@ -18,6 +18,7 @@
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/of.h>
+#include <linux/platform_data/sdhci-pic32.h>
 #include <linux/platform_device.h>
 #include <linux/pm.h>
 #include <linux/slab.h>
@@ -25,7 +26,6 @@
 #include <linux/io.h>
 #include "sdhci.h"
 #include "sdhci-pltfm.h"
-#include <linux/platform_data/sdhci-pic32.h>
 
 #define SDH_SHARED_BUS_CTRL		0x000000E0
 #define SDH_SHARED_BUS_NR_CLK_PINS_MASK	0x7

-- 
2.52.0

