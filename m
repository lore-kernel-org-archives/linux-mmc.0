Received: from mail-qk1-f228.google.com (mail-qk1-f228.google.com [209.85.222.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B223FB042
	for <linux-mmc@vger.kernel.org>; Wed,  5 Aug 2026 22:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785968715; cv=none; b=SLMmqowuy7UQigYNlzaslfaZcl+ZyAdnNkrYxwb1GGlCS0Z6vxpNx0JKtRGjw91IQ3FCUiva9CNLFIg8TXr3OeSLLYQRRvs7lNGueBitcZKW3sw0rv5vTBKbp3XMhG7VYnYUP+k6h1u9xza0GWbCv7CdHM2T2epdFx7tfQ3WHbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785968715; c=relaxed/simple;
	bh=Qlzp5E9i+GZFM+UIin+Fmma2xkNpBqV2cfN3Yxh2qbU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Nqd8ATgufGDhM1R0paKBdxbHvh2Ug/dvkjkS2tI9W9zXgoUrwggx8mAC3m9d0HEK+CTagWjA2cPkZneQT46O1f/N1IgoT2rFPirDYV13UVUc5HQXuc7Uz6BTqP7OxxmaOcTiWvp7Yksj4rDOwoFUeH7p8v2HJibQFaA7fAWaSVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Wo+hJTKi; arc=none smtp.client-ip=209.85.222.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Wo+hJTKi"
Received: by mail-qk1-f228.google.com with SMTP id af79cd13be357-92ed19f4d60so24843285a.0
        for <linux-mmc@vger.kernel.org>; Wed, 05 Aug 2026 15:25:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785968712; x=1786573512;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9n0fizxp33zjg5nu+cX3jmQFUDtRl3HBk7n7rSIUnuM=;
        b=GJYv/FJIJj6p/cPr7YbKXP7/GXDLxG9N3J3Pp59ZDpJGx0P0xQBePIpjm88TDrnTlB
         +8bHiK4fy0P9B18zK4Ao88vZ2/b7V5dP3b4amHENZNB0YjdYfNpNQOnQBc3uF7w/Ufcg
         enbHjC8lTZsjwhKEloxaA5Kmi+TxaX97d8kmejgobMHhNfQE7Y7wMEqqDesOh68vZuFP
         DIf7IOLMjuUbL2a+KAlPFd2q6E+WLCis/DHfW6BX3L6/UB4O87Oq2NEvMlsyjCyRbZx+
         4b629IxwMT9cHwK7WnxGR+bucmDg6mqkHYBY71ndL7/qnjPp8vOAEKJnqgv1HYc5Bs5Y
         pOPg==
X-Forwarded-Encrypted: i=1; AHgh+RqK3/4CPM+RDeFRJhDCiQ4m/YfApiUDxKXKeMrOeDSCTHo7r1FncUbnv74wj8JmCN+9JuTtGQMs2hQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUoesb9zlF6j6i+qKMAuEDetoN6g0f0Lom6a28B6Hx8wQH0LvK
	s7svpR4BQR3zYsZtXXskLDhKMHDHDBM28V+9Rpbc69y6peJwXeL2UVBrPg1S1xQ1v3jOVJPJk1h
	6XUIkgijh/wYDXisr7R7GgU9/Wqr1vlL9eP0KDlKWqggrdlZAVl5cO2GvnhuXYI7DGokj8RWIO0
	lVvUQIuwSSK80OgDWQHczdO2GURRHYgnGVOut18apLVltkW0Nbs+PiRWxcH0jJ6R5+VByoEbARW
	nsCAhww3z6Y
X-Gm-Gg: AR+sD13ezIQO2Tm0Y0S6XGxMKJZrkMCMPB8N1Vc7OvMJcdx+q7BfpFbbyAnHKRGPpqr
	ghEpBa5PGiN06xyM1UAk475nVahseQ5jHWQVMmGYFY+pNV833UT8EVWoOXnZ/0xi/GrxJ5cE6jt
	qwJk0HWi0iaBp5UtGy3sRy58J+qpgAkzHu7BgRnBwyzENFSjvaMXRhv3I/clCpVWr6lHWhkks4U
	W8d9VoJ8ijAJv5bAnHnxXNLoIABbzze0zkmzzKNO9DKu8ICK3ZpdRvvcqHkkLI3lWvFybdXNnbh
	pvt6mLHcyF7Pcup3m30GmTsU6K9WuHsC8MvAUuwSCbArW33DOtHGxI3sA64rWKPuGd5JG4ZqGVi
	RiNXlBPMLlpGOP5jfd2WsDWnUgeIAhFHg71m17mLv+GslKFV5h3q3pEYICjUV3GFZXaiyZpLg3y
	5q3QsZEL7B3OIkGnqLnmtcx4sYEZSoCbks
X-Received: by 2002:a05:620a:936e:b0:92e:e601:d238 with SMTP id af79cd13be357-936594d99b7mr211014285a.10.1785968712201;
        Wed, 05 Aug 2026 15:25:12 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-27.dlp.protect.broadcom.com. [144.49.247.27])
        by smtp-relay.gmail.com with ESMTPS id af79cd13be357-93657914023sm25689885a.1.2026.08.05.15.25.11
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Aug 2026 15:25:12 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-38dbe39ce62so295594a91.0
        for <linux-mmc@vger.kernel.org>; Wed, 05 Aug 2026 15:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1785968711; x=1786573511; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9n0fizxp33zjg5nu+cX3jmQFUDtRl3HBk7n7rSIUnuM=;
        b=Wo+hJTKi5S/OEp8+1JSqQdkV4pBH6kEhUFNEreC/KacQXVPfMcJysi9RxX9VDG8PKy
         gz0sNDXPWNp91Uu3Yc4MvhPeBh6fQVrl9EIiZnomAVZr1IvGsXQYGcVeeS/6VWrmafL+
         Z7rkdW7QUqIAyNF2O+oaUI7teLY4F/sHFpIgE=
X-Forwarded-Encrypted: i=1; AHgh+RrRGRAcDNENoO0HUBm/EHiKoaBwN9/xQHKGC+SUv7Yu5PBglm1M6ujV/wuwGTVdT2klUzciLG64nqA=@vger.kernel.org
X-Received: by 2002:a17:90b:2ec4:b0:36b:de66:92c3 with SMTP id 98e67ed59e1d1-39083aba06emr1307748a91.10.1785968710843;
        Wed, 05 Aug 2026 15:25:10 -0700 (PDT)
X-Received: by 2002:a17:90b:2ec4:b0:36b:de66:92c3 with SMTP id 98e67ed59e1d1-39083aba06emr1307710a91.10.1785968710335;
        Wed, 05 Aug 2026 15:25:10 -0700 (PDT)
Received: from mail.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3158676f579sm18526160eec.20.2026.08.05.15.25.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 15:25:09 -0700 (PDT)
From: Kamal Dasu <kamal.dasu@broadcom.com>
To: Ulf Hansson <ulfh@kernel.org>
Cc: Kamal Dasu <kamal.dasu@broadcom.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Avri Altman <avri.altman@sandisk.com>,
	Pedro Demarchi Gomes <pedrodemargomes@gmail.com>,
	Erick Shepherd <erick.shepherd@ni.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v7 1/3] dt-bindings: mmc: Extend keep-power-in-suspend beyond SDIO
Date: Wed,  5 Aug 2026 18:24:58 -0400
Message-Id: <20260805222500.2567801-2-kamal.dasu@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260805222500.2567801-1-kamal.dasu@broadcom.com>
References: <y>
 <20260805222500.2567801-1-kamal.dasu@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

keep-power-in-suspend is currently documented as SDIO-only, but the
requirement it describes -- preserving card power across a
suspend/resume cycle -- applies just as well to any card type. Drop
the SDIO-only restriction so eMMC and SD platforms can use it too.

Signed-off-by: Kamal Dasu <kamal.dasu@broadcom.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
Changes in v7:
  - Added Krzysztof's Reviewed-by.

Changes in v6:
  - Split into a separate, minimal patch per Ulf: just extend
    keep-power-in-suspend's scope, with no brcmstb/firmware-specific
    rationale in its description. That rationale now lives in the new
    reset-card-at-resume property instead (patch 2/3), and the two
    are set together on brcmstb rather than folded into one property.
  - Also per Ulf (applies to v4 and v5 alike): dropped the mention of
    sdio_set_host_pm_flags() and how Linux's SDIO stack happens to
    expose this at runtime -- that's a software implementation
    detail, not a hardware/platform description.

Changes in v5:
  - Added Krzysztof's Reviewed-by.

Changes in v4:
  - Dropped no-mmc-poweroff-suspend entirely and extended
    keep-power-in-suspend instead, per Krzysztof: the two properties
    described the same "don't power off across suspend/resume"
    contract.

Changes in v3:
  - Renamed from no-mmc-sleep; dropped S_A_TIMEOUT framing per Ulf.

Changes in v2:
  - New patch, replacing v1's card-level quirk, per Ulf.

 Documentation/devicetree/bindings/mmc/mmc-controller-common.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mmc/mmc-controller-common.yaml b/Documentation/devicetree/bindings/mmc/mmc-controller-common.yaml
index 3d7195e9461c..c18bf0d6a56e 100644
--- a/Documentation/devicetree/bindings/mmc/mmc-controller-common.yaml
+++ b/Documentation/devicetree/bindings/mmc/mmc-controller-common.yaml
@@ -291,7 +291,7 @@ properties:
   keep-power-in-suspend:
     $ref: /schemas/types.yaml#/definitions/flag
     description:
-      SDIO only. Preserves card power during a suspend/resume cycle.
+      Preserves card power during a suspend/resume cycle.

   wakeup-source:
     $ref: /schemas/types.yaml#/definitions/flag
--
2.34.1

