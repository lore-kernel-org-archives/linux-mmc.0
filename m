Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4254531ED83;
	Mon, 16 Mar 2026 15:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.143.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773673316; cv=none; b=Hl5SMKJS1rPK47dDbEiKMiDYHLICD0px4s7OorJGndak27XN4COQYbCW+MH8LDppI4tCxpsKT1ZBvXrhDiulnRpDooCch1EJBrchd9SNtYubYwWg2jBrxUdqaIh0u21pc/ywjWBIjs8rC6US+nKhFPiM+Sg2TdxeaJ1XXXOFSzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773673316; c=relaxed/simple;
	bh=9Cdluc1gyovzh4uKpTl/yZ/GJedv1fJHXv3ZTmh4DBI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kfqj9Y3Ygu77STW5FHOYlHyUJ9qd1ldPyXorWublpFfN2bDhYeluL/7lEox8LYE7epgEoKjbV0LN1ESRrB/LoX7F5nkqukHUngzFrqx+yDEhvMDHM3stpbHu0ekd2Z+SnKiXuGc6gqAcOaU60bvZLVJnicXaS3skyKwrEeSkbW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=IWW19YAv; arc=none smtp.client-ip=148.163.143.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="IWW19YAv"
Received: from pps.filterd (m0134423.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62GEuIHi1744348;
	Mon, 16 Mar 2026 15:01:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pps0720; bh=XTt3FvvLaweVl
	/vCuw9dtAut1ZG8aZFH311xqj0FNoo=; b=IWW19YAvAHw/0yrOjl8MVe0r5Y/p+
	hvoslGhErlKl1mK8MJBzxJ2sM5mJA+FH2GNIlCoKqxZGzSoAQElrU6H0JpDlIDt2
	3DAkzLasIID9ncwWssg2eFTjQq/Z0VVvNhwfF/BCZgTckmAo3J3QvG0NA6rA/L3v
	ISNxVmS6ScmOlCkvQElbcYotVGX+Xy7Gdvz4UOZVVkoyPG9mtzNBk05M+UCBRwmn
	roHKadBfkRgy2tS/JVxUB/WL4VJrKlu5T7Y9lyDMfxxpifrjp1abtlZI+Xh+dBOv
	PHZpywea5Jf3oRZyE71PeS2iv/MByB3sfxE6J84eL3utT87KViBRZxyBQ==
Received: from p1lg14878.it.hpe.com (p1lg14878.it.hpe.com [16.230.97.204])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 4cxm2m02b2-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 16 Mar 2026 15:01:27 +0000 (GMT)
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by p1lg14878.it.hpe.com (Postfix) with ESMTPS id CE8DE27675;
	Mon, 16 Mar 2026 15:01:20 +0000 (UTC)
Received: from hpe.com (unknown [16.231.227.39])
	by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTP id 7A2768081C8;
	Mon, 16 Mar 2026 15:01:20 +0000 (UTC)
From: nick.hawkins@hpe.com
To: ulf.hansson@linaro.org, adrian.hunter@intel.com, jszhang@kernel.org
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        shawn.lin@rock-chips.com, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nick Hawkins <nick.hawkins@hpe.com>
Subject: [PATCH v4 1/2] dt-bindings: mmc: snps,dwcmshc-sdhci: add HPE GSC dwcmshc compatible
Date: Mon, 16 Mar 2026 10:01:14 -0500
Message-Id: <20260316150115.2616827-2-nick.hawkins@hpe.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260316150115.2616827-1-nick.hawkins@hpe.com>
References: <20260316150115.2616827-1-nick.hawkins@hpe.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=H8bWAuYi c=1 sm=1 tr=0 ts=69b81b47 cx=c_pps
 a=UObrlqRbTUrrdMEdGJ+KZA==:117 a=UObrlqRbTUrrdMEdGJ+KZA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=gQcMVamqm3wCPoSYhaRC:22
 a=g3u0LPWLDYfGfufhFw6-:22 a=MvuuwTCpAAAA:8 a=Un5EUvwKq7LZpnUfPCQA:9
X-Proofpoint-GUID: Y9fpzdWznJXEQtyoCJTpg7WfY1JvYevr
X-Proofpoint-ORIG-GUID: Y9fpzdWznJXEQtyoCJTpg7WfY1JvYevr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDExMSBTYWx0ZWRfXzNTNJ5Z6ExHP
 jBlxGmTZpM74M+mdzLBWHtd3iasQJotLwGmMBGT7KoeCrY7EbcwViZeG36zTu9rWoEvP7XNPv9U
 jKeIRAnyx84En28awNCEohWMuJzg1w1r9Mha++3Bh8b/jywiOUxswURMrvxRJDgfRzzEQ2BWZIt
 iYy/nh6VLWK1xNYkro2GudaKmVQehFN32ri3A3kdQqKEemJ88FN+cwVjdevfkcW8ixZTPYVWWbg
 XefgpAzZ6kz+IJqvQIqXpeVk+TqsvcUL26LNyxliJ6VHO+mUdbHHew/Pw2jFZmCU43GJSvjUwlo
 DhDTJrq2kI/luBhQDUoWelvL7JyAGGUq/RSrnaIybDY3wYKyJkc9bztSNM6sJ7V9hf8vmpATVHA
 97H+YvD9MOd0MCNwYRiL5Of3ATZyb9MQxk7bmyc7kmksaPgVfxM2nCnQZo4fN/MIQyD50oKfbRg
 ruRXEhfG4FNxZF52qZw==
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_04,2026-03-16_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 suspectscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603160111

From: Nick Hawkins <nick.hawkins@hpe.com>

Add the 'hpe,gsc-dwcmshc' compatible string for the HPE GSC (ARM64
Cortex-A53) BMC SoC eMMC controller.

The HPE GSC requires access to the MSHCCS register in the SoC system
register block to configure SCG sync disable for HS200 RX delay-line
phase selection.  The required 'hpe,gxp-sysreg' property takes a
phandle to the existing 'hpe,gxp-sysreg' syscon and the MSHCCS
register offset within that block.

The HPE GSC eMMC interface only exposes a single 'core' clock (no
bus clock), so clocks/clock-names are constrained to a single item.

Signed-off-by: Nick Hawkins <nick.hawkins@hpe.com>
---
 .../bindings/mmc/snps,dwcmshc-sdhci.yaml      | 32 +++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml b/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
index 7e7c55dc2440..cf8b9b4ae5c5 100644
--- a/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
+++ b/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
@@ -23,6 +23,7 @@ properties:
           - const: sophgo,sg2044-dwcmshc
           - const: sophgo,sg2042-dwcmshc
       - enum:
+          - hpe,gsc-dwcmshc
           - rockchip,rk3568-dwcmshc
           - rockchip,rk3588-dwcmshc
           - snps,dwcmshc-sdhci
@@ -77,6 +78,17 @@ properties:
     description: Specifies the drive impedance in Ohm.
     enum: [33, 40, 50, 66, 100]
 
+  hpe,gxp-sysreg:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    items:
+      - items:
+          - description: phandle to HPE GXP SoC system register block (syscon)
+          - description: offset of the MSHCCS register within the syscon block
+    description:
+      Phandle to the HPE GXP SoC system register block (syscon) and
+      offset of the MSHCCS register used to configure clock
+      synchronisation for HS200 tuning.
+
 required:
   - compatible
   - reg
@@ -87,6 +99,26 @@ required:
 allOf:
   - $ref: mmc-controller.yaml#
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: hpe,gsc-dwcmshc
+
+    then:
+      properties:
+        clocks:
+          items:
+            - description: core clock
+        clock-names:
+          items:
+            - const: core
+      required:
+        - hpe,gxp-sysreg
+    else:
+      properties:
+        hpe,gxp-sysreg: false
+
   - if:
       properties:
         compatible:
-- 
2.34.1

