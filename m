Received: from www.redadmin.org (ag129037.ppp.asahi-net.or.jp [157.107.129.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C5B307494;
	Mon, 29 Sep 2025 13:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=157.107.129.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759152278; cv=pass; b=a7no/AwBR8SkB5aW5xQWJt479VMVnSmaCosa8gnBps3mYesJ8fca6e3FkqB+f/KIq//xm/v/VKAN4IeucwQO7YkG5FtxBRbeXKB/VqKLbuQRfJMX2Folc48kpwOIH7dF4WriFc9235shSiJ4lYokifSmst8PO45Y/daG6CxydyE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759152278; c=relaxed/simple;
	bh=+FlFMn65PwSwsInMpFQINKycoHs65t4+qEHAT1KbyqQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GQMF2l10tvk8/NKngy41TU1HAfHNuHQjDrIPv8fl0QTzj4EiDiOlH3wYSOV8S2yoKUou+JZsbiCYHxG7C8kHtC2ipGUpGckiZlfHZC4wMly4rezgK3d7UnpURqP6kaJT6arKht77IgG1vhdUNC7LCEwKyZgwfb3zA19ddqpsaSc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redadmin.org; spf=pass smtp.mailfrom=redadmin.org; dkim=pass (1024-bit key) header.d=redadmin.org header.i=@redadmin.org header.b=W53BDsfE; arc=pass smtp.client-ip=157.107.129.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redadmin.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redadmin.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redadmin.org header.i=@redadmin.org header.b="W53BDsfE"
Received: from localhost (localhost [127.0.0.1])
	by www.redadmin.org (Postfix) with ESMTP id 5037010F40F4D;
	Mon, 29 Sep 2025 22:24:27 +0900 (JST)
X-Virus-Scanned: amavis at redadmin.org
Received: from www.redadmin.org ([127.0.0.1])
 by localhost (redadmin.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id l749kElyyYoW; Mon, 29 Sep 2025 22:24:24 +0900 (JST)
Received: by www.redadmin.org (Postfix, from userid 1000)
	id 019B410F40F49; Mon, 29 Sep 2025 22:24:23 +0900 (JST)
Authentication-Results: www.redadmin.org; arc=none smtp.remote-ip=127.0.0.1
ARC-Seal: i=1; a=rsa-sha256; d=redadmin.org; s=20231208space; t=1759152264;
	cv=none; b=IYytWn9Tw5sCejDHJIBM/SSZO8cOq2syUVaZLHDRbq/k4DHLhBRJacetWY1Q8UnFT3QIzkfFw9HSFWfumBeixckp5H2q/8OdqW32hn0DRgKjJ4tQpKLgVrqnw7nFmvRtDqgEWbroatDV2U2hNhKEum17ee2xW02I7istKl2oy3s=
ARC-Message-Signature: i=1; a=rsa-sha256; d=redadmin.org; s=20231208space;
	t=1759152264; c=relaxed/relaxed;
	bh=hcLsrul/wXlLzNNpWTc3vNtijAfswDidjbEuP6VB2nA=;
	h=DKIM-Filter:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding; b=z7pup9enNZX9aq2tSCbLl7b6KYx13I+9+4VSMe4zmy4jP11NDs0Jc+53zGoayjwqXWXRkoFsTUpxACR9gFAhapGES9pxOzGHqbjdGmm4IIyLgjaaQNpAWeRHP1cMQjD5DaKlp42J5nj2hLi+zmKWQZ04Qk/SmXkAhKFqu7Hnz6c=
ARC-Authentication-Results: i=1; www.redadmin.org
DKIM-Filter: OpenDKIM Filter v2.11.0 www.redadmin.org 019B410F40F49
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redadmin.org;
	s=20231208space; t=1759152264;
	bh=hcLsrul/wXlLzNNpWTc3vNtijAfswDidjbEuP6VB2nA=;
	h=From:To:Cc:Subject:Date:From;
	b=W53BDsfEzYPjqtAvtc79eeZxsPZKf6NbBHFvUhYRb/uycFoEOvjcEw7SJxtRxPM6f
	 v65AbL/2SnoiE1BFnA5jSAndwo4o4ItO6GIDG2ORAy/PGKVrDT/wdf9Wy0FCiSOcm2
	 ab8SA+cOLn3OzUq+/eaH4h+15t2r57xMJgYU8nCM=
From: Akiyoshi Kurita <weibu@redadmin.org>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Akiyoshi Kurita <weibu@redadmin.org>
Subject: [PATCH] dt-bindings: mmc: Correct typo "upto" to "up to"
Date: Mon, 29 Sep 2025 22:24:22 +0900
Message-ID: <20250929132422.934713-1-weibu@redadmin.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The word "upto" is a typo for "up to". Correct this typo in the
mmc-controller-common binding documentation.

Signed-off-by: Akiyoshi Kurita <weibu@redadmin.org>
---
 .../devicetree/bindings/mmc/mmc-controller-common.yaml          | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mmc/mmc-controller-common.ya=
ml b/Documentation/devicetree/bindings/mmc/mmc-controller-common.yaml
index 9a7235439759..4e49035ab7a9 100644
--- a/Documentation/devicetree/bindings/mmc/mmc-controller-common.yaml
+++ b/Documentation/devicetree/bindings/mmc/mmc-controller-common.yaml
@@ -85,7 +85,7 @@ properties:
         - for eMMC, the maximum supported frequency is 200MHz,
         - for SD/SDIO cards the SDR104 mode has a max supported
           frequency of 208MHz,
-        - some mmc host controllers do support a max frequency upto
+        - some mmc host controllers do support a max frequency up to
           384MHz.
       So, lets keep the maximum supported value here.
=20
--=20
2.47.3

