Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B543644A6
	for <linux-mmc@vger.kernel.org>; Fri,  9 Jan 2026 16:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767976943; cv=none; b=T89M2w5D0+6KyRN2BdNjUrHgx0Urjo6IXdyGhuvcIJFQMfney/FOd+WiNHTUgq/DYlAgb4MAg6DeOlyEF6M25NefcSh217oQROQIbuf2TYt63xFAY+Ye32OQ5llEym7tEY+u76XcQLGyUiwuH51lIoFTOTkSkYlqPSJ7wVKYxak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767976943; c=relaxed/simple;
	bh=iCdp8gctkLaPW3D/fei6jxGKlMAA2QOc3/o0wQqctm0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uObNLsh7MbwSN/UNACC0N2HeQOUy/S1Ny8ZP+xdik+WI3ZXaQn0YO3xkgPRLLv89wQEvP/zvs9trxo7ivxvwt3YUg+3sJ/LR1FTOwV+RIandgX34WdOUX3aUP5UAKLHqvxv2fwhBPw2435wizsORzcjBM8kDrvqm095sGiRHZu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PRnYhnm1; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=qVdje9Pv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PRnYhnm1";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="qVdje9Pv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767976933;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YD4ytu1UC7PeOKKacILQRYf/wWE4kZNXtZ0iRfKR+V8=;
	b=PRnYhnm1svwi4h8ZmA8DRNqxlSGWv+GeXTUNUZhr1paD2rkuQCsBjZ+AVom+0bVBHMroil
	rVmdcMkmWwdw7EePih1NYqL9cqHc5Zq+FfdwqSAHODaYFhOa7VbIHjpWY8GSPv6dVeH7eR
	wy+E8qFZtK6bygniaZTbIZg4aC+8D/g=
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-178-GfpAWAm9NUSY7XSDNhblaA-1; Fri, 09 Jan 2026 11:42:12 -0500
X-MC-Unique: GfpAWAm9NUSY7XSDNhblaA-1
X-Mimecast-MFC-AGG-ID: GfpAWAm9NUSY7XSDNhblaA_1767976932
Received: by mail-vk1-f197.google.com with SMTP id 71dfb90a1353d-5637112ac92so144047e0c.0
        for <linux-mmc@vger.kernel.org>; Fri, 09 Jan 2026 08:42:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767976931; x=1768581731; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YD4ytu1UC7PeOKKacILQRYf/wWE4kZNXtZ0iRfKR+V8=;
        b=qVdje9PvhGQyhhTGLZV9/FEpGuf4yRUZ44kuMQ7fOvmiygmSYo7s7hwmuA7vjAGIH5
         yP7QRREm/XiiX4468N7beBsDJezuwW34rpMfCXPoyX/M43kgmol37+h0fW/toc59K7CV
         8yjmbsGKDji8xiyttjEaokbQqBSKdS8/yzU1+Goz+HJ+pdXdx8fg+ZiYK5C8qyRnfsoR
         mVUx972Uh/WJ8QWV9ULVAAC/P8/2g+FlXx4dn1S8l5S8cI5qQlerzOXbOilGI8MpFL5m
         +zjtofKEmCwvsewsLd6+Lc/VI9QSIfi0N7nx0sPtyQE5HEmDuIOpuRV1ROK56eMtVT7u
         nR+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767976931; x=1768581731;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YD4ytu1UC7PeOKKacILQRYf/wWE4kZNXtZ0iRfKR+V8=;
        b=HITIzeCifwXjjnMAy45LW0teqjXLgQMk+tdkSAgNOJVOzqQUTJNqWXSyCmd3bO0ozj
         4FxuqRThjOMV/1eCWjsr+ng/ULhzlBScQnXLFdafFgJFSqqnSTg8Z3nzbE18KSr5zhlH
         kH+zJRbp15L5dWShqFJDYRztBnkG2I1ASFNS+oFAIRSGxgptB59sMLRBYJ48u+GPf53M
         ofJakrGrn3Z8w0OJAb5/XRrV4MtEZzjMMs42ufnxD4pjwekdsDcEdI6FMHfR4wqjQiCb
         SU99jVulb4nv/aGN9edaMu/L5tOePszKUoBGjuHV9I8kEaZITwLGlsY3kYG3LDTGmFfR
         B39A==
X-Forwarded-Encrypted: i=1; AJvYcCU4PPXTCC4K7vgI/jE75I/UG9IY9zwz4+DCzK7Jew6QwxXzlgBiFaflsGPF5Kq+jmFuzcxdTjq6bWA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJWF/0nmQ1DAJ8fhqhsZjDpvedcAHv2/2ysNiQe2fqud/Ni4JF
	3zozeufqdfyLzB/6GDpju52Xq08UA6tSRSxWFIofpLlq3VrTr6YR4jEFEDykiVywpj/moscoM47
	HBN24Y5rUmsZrHL40vlK6PP82wekMvI1mzqDw8wRHiXO4CBFLB2A77pI5VR6v1w==
X-Gm-Gg: AY/fxX78IzQMe0nfEFOgvSUy4MvqkIJRTXrJ6uwhbjbOkXC5jeICmYjCVxM2G3lg03c
	ziP4oEHpllxyzGaOKQoijdowjfWevR6CEjf3msBXU31j2rBUV3Taz2cEqXYFI46x2sBdvEcD3kx
	yu2tKfYHoFse1dBeKlyb8172jsJPcX8Ri0e942eQoDuVlioDeOK00nuOqgiP0u/ysuIBFii3MjR
	XRpxSEmjzzmMawMgwBk2bUyk8qltI71t8U+rBNoqgJ2Lf/T/tWYufjnjrGaCUzWCD9exmNXaRFw
	hitTOk8wJ2dz4sASofY8axZeW0hpGRr14IZs62MFWRhmAvGNvkI3BK8fkIrXJEeHpZmNav07TEF
	WSoOMCk/tHvi6swZaoIAX4wj6Xr5xsoB2FjkuiYU/awmYbQ+I
X-Received: by 2002:a05:6122:8c8a:b0:559:7077:9a8f with SMTP id 71dfb90a1353d-56347d6c262mr3203139e0c.5.1767976931722;
        Fri, 09 Jan 2026 08:42:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE1Il0vlFYOMp28oEjoG/ut2hiG8SvIDyOhFAIKIBiIxobLZx0OhzFwbcBRRlK0/0MtFuj8Hg==
X-Received: by 2002:a05:6122:8c8a:b0:559:7077:9a8f with SMTP id 71dfb90a1353d-56347d6c262mr3203128e0c.5.1767976931401;
        Fri, 09 Jan 2026 08:42:11 -0800 (PST)
Received: from [192.168.1.3] (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5636c753392sm1267752e0c.6.2026.01.09.08.42.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 08:42:10 -0800 (PST)
From: Brian Masney <bmasney@redhat.com>
Date: Fri, 09 Jan 2026 11:41:19 -0500
Subject: [PATCH 06/13] mmc: sdhci-pic32: update include to use pic32.h from
 platform_data
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260109-mips-pic32-header-move-v1-6-99859c55783d@redhat.com>
References: <20260109-mips-pic32-header-move-v1-0-99859c55783d@redhat.com>
In-Reply-To: <20260109-mips-pic32-header-move-v1-0-99859c55783d@redhat.com>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Brian Masney <bmasney@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, 
 Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1270; i=bmasney@redhat.com;
 s=20250903; h=from:subject:message-id;
 bh=iCdp8gctkLaPW3D/fei6jxGKlMAA2QOc3/o0wQqctm0=;
 b=owGbwMvMwCW2/dJd9di6A+2Mp9WSGDIT9Y/sD5640tDz3Rfr1tkvd8w7w1pxsrxiss4rwf4eP
 ZsfPN/WdpSyMIhxMciKKbIsyTUqiEhdZXvvjiYLzBxWJpAhDFycAjCRAzMZGWa2vqlml19y7FNL
 9a38R0/uRV432flh4mMejY9bI8PjWYMYGd4GOofoPS6oSc3PWzT3/bxdd19sVqhn+7d7yZPuiUU
 8vLwA
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

