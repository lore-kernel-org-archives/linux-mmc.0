Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5486928134C;
	Fri, 25 Jul 2025 06:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753423324; cv=none; b=k/5XpqJraUjXFd6SK5I/if9Dl63M6BG2BCuQzURuh7zCkoAnvKl8FDpadzCrTM7zVXn2J8beNzvVySm2RYG5yAcjN2C/q02PIIXeRT1RG4cLaW4DIqkGjcmEUedcAgJLnNwZmBKWbU9zGvx2NU0GgANJooCmcxU/RkrWZbkfLD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753423324; c=relaxed/simple;
	bh=YRw7rFcDu4vNvOdSRQLyK0d6LASTLKXnrjMnLq+m7Ks=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UX8pO7gNn15uT8xdtKRTIxpSXbNct0p8JxVn4nKwZmsgvlsreLTITL6U+8GG/NtE9KS37Y9BKyEucG7rr++vHrDwR2cQdRmJYVAisM+Fq5jQTzcIaS11lEotmln+gY2CYmaaC4F2bBt1zJXBcDge+FfWu1avOEMZq58vo8xAPK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=A8qTrCfz; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=VbWMIsUg reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="A8qTrCfz";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="VbWMIsUg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1753423323; x=1784959323;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=gIjF0WLoJjIsLlPCbmDEL7SMVw5aD5pTVu3bKIXQuW4=;
  b=A8qTrCfze0P/e6iCm7mfDXoF0gb4NQc9Zp5grB8MUsi88ltRbQ1zDqJ5
   YNM9JBvqpBkIYHSR6KdU5wgA31YMoxKBV9GV+1YoUHqcKTF4GbOFRs0JO
   hVU8ixqr1xnjgth+kHamP1YJYYAbhM8ukFW5RXnuxJZynnSRixPOZNEX7
   ZTce0Do6Vx6XHMHrDWCt3EUdjMkCCy9eWam2ncpbutRlzO7wxAYe3ycK1
   WHIZxcsBXAPJDoEBiIAD5ibxX3+FkmNhtCeMDbu3fWdVu6j1Vo6jxfXM+
   Ir1bdtHrI4JWB7MqXKBKO3rnmVJlpFI1UwK7WOtUAs6AAwo2uO3LNi6Wa
   g==;
X-CSE-ConnectionGUID: tlaNM64zQbS/EQVWluh68A==
X-CSE-MsgGUID: 7EQxuGH/R3O0c8k3t8Rv2Q==
X-IronPort-AV: E=Sophos;i="6.16,338,1744063200"; 
   d="scan'208";a="45412710"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 25 Jul 2025 08:01:59 +0200
X-CheckPoint: {68831DD7-1A-4FC15ADB-CD71293B}
X-MAIL-CPID: 34F13FDAA2F1E88CBE740EB9BBCB8E95_0
X-Control-Analysis: str=0001.0A00210F.68831D5C.0053,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 911FE160F69;
	Fri, 25 Jul 2025 08:01:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1753423314;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=gIjF0WLoJjIsLlPCbmDEL7SMVw5aD5pTVu3bKIXQuW4=;
	b=VbWMIsUgUy7EWPX+DTUHgI808r/pem+uKeOoLAcdqD7GktqxL7BnBTJ+3hetENyiSsjkBc
	NrCnN+imsh6MkoOBFDlpcJhoCI7+VuyXwTmE97l4tRVp22aXwIsHZ/3IfTKsSEcmQkCv1l
	udi5eTjtvxU8oc+dR6QocEykd25/f2stwkoc9jbGIruOHLIb50rnhyFyqx+Pk0K2PfnlL4
	OaZx2h0DaCePSCCCVh8AYkElS5BfELSED8KT9XMhKGmFw8gBBoq7Bt0QzaAVJMu4+Q+uCv
	2id01y/sqwnoAjdpIitF0AlOrsOFOUaOOkogO3YhE7iK5974SDXxvyCgwFDydg==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Frank Li <Frank.Li@nxp.com>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
	linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] dt-bindings: mmc: fsl,esdhc: Add explicit reference to mmc-controller-common
Date: Fri, 25 Jul 2025 08:01:51 +0200
Message-ID: <20250725060152.262094-1-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Even though it is referenced by mmc/mmc-controller.yaml it still raises
the warning:
  esdhc@1560000 (fsl,ls1021a-esdhc): Unevaluated properties are not allowed ('bus-width' was unexpected)

Adding an explicit reference fixes this.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
I don't know if this is a tooling problem or whatever. I would have
expected that mmc-controller-common.yaml is added via
mmc-controller.yaml. But apparently this is missing resulting in the
given warning. Hence adding the reference

 Documentation/devicetree/bindings/mmc/fsl,esdhc.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mmc/fsl,esdhc.yaml b/Documentation/devicetree/bindings/mmc/fsl,esdhc.yaml
index 62087cf920df8..f45e592901e24 100644
--- a/Documentation/devicetree/bindings/mmc/fsl,esdhc.yaml
+++ b/Documentation/devicetree/bindings/mmc/fsl,esdhc.yaml
@@ -90,6 +90,7 @@ required:
 
 allOf:
   - $ref: sdhci-common.yaml#
+  - $ref: mmc-controller-common.yaml#
 
 unevaluatedProperties: false
 
-- 
2.43.0

