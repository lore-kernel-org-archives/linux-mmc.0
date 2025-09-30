Received: from www.redadmin.org (ag129037.ppp.asahi-net.or.jp [157.107.129.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D4D86340;
	Tue, 30 Sep 2025 13:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=157.107.129.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759239965; cv=pass; b=CQArHjiQnMFckIbORC5WXb8CtCmbTNhCkqV2wYKU7OxfmEXIc65OvpCHgnQEjHjXn4bf0Iq3Jhu+FcYcK+NTAnn6w7a6Zmdb5IrPBFnHqnVraSecX/ALK0Gbv2sDzhP0h42ORuOZ3BzI81WdxYu1hxq3pA1uhVLkGpZ3Zi8F+f0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759239965; c=relaxed/simple;
	bh=+FlFMn65PwSwsInMpFQINKycoHs65t4+qEHAT1KbyqQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oNrSw+v6otl4X70O0zrf1L0VTiz5ERgLXQhyXIiHd2N2nULjaBkHC51f2Rl45tFFKGBYeFiioCOfKmMNi9WCGETTn+LwPtdpm2+ev78Wq6GhrNOnsP6Dt7HrHbtbfkHExEeLM5gXBw5EWwLbjL8K5WdRFgrVOa5oRW37NBLDzgg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redadmin.org; spf=pass smtp.mailfrom=redadmin.org; dkim=pass (1024-bit key) header.d=redadmin.org header.i=@redadmin.org header.b=T49C/t9F; arc=pass smtp.client-ip=157.107.129.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redadmin.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redadmin.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redadmin.org header.i=@redadmin.org header.b="T49C/t9F"
Received: from localhost (localhost [127.0.0.1])
	by www.redadmin.org (Postfix) with ESMTP id 2E51C10796C03;
	Tue, 30 Sep 2025 22:45:52 +0900 (JST)
X-Virus-Scanned: amavis at redadmin.org
Received: from www.redadmin.org ([127.0.0.1])
 by localhost (redadmin.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IU5Th2j-tTlN; Tue, 30 Sep 2025 22:45:48 +0900 (JST)
Received: by www.redadmin.org (Postfix, from userid 1000)
	id B309D109EFD83; Tue, 30 Sep 2025 22:45:48 +0900 (JST)
Authentication-Results: www.redadmin.org; arc=none smtp.remote-ip=127.0.0.1
ARC-Seal: i=1; a=rsa-sha256; d=redadmin.org; s=20231208space; t=1759239948;
	cv=none; b=hJ54hEvUdA/Sgu1X7tx77ZhAiGRvKCJhc7IZako1C3m7DHYURfg2k0qWv4cFVOhHI3CPy1FO/q3tAqn7qD+mMciGi8S58ED43Q4urBXiH2NP53ccFhyrMrRpWiqf0WKbk+KY9L/gpR9snW3ehRjh4gktw4S3NXuLM1sgWMBacuM=
ARC-Message-Signature: i=1; a=rsa-sha256; d=redadmin.org; s=20231208space;
	t=1759239948; c=relaxed/relaxed;
	bh=hcLsrul/wXlLzNNpWTc3vNtijAfswDidjbEuP6VB2nA=;
	h=DKIM-Filter:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding; b=wKlvBM1YBjKZoT9YDy3a+/hxHfVkaNRuQc+CPagKTwiLOte07UO0B6zzBTrTEghyae0vPPRMqOG441UBoxt1VxYzhTegCf452wxAK4uGRBTTsctm5pDpgq4ALq0f/YX3WiSLk5Zr/ce3GuNosYwnHM6+OJFzWuwoxASYC5e0we4=
ARC-Authentication-Results: i=1; www.redadmin.org
DKIM-Filter: OpenDKIM Filter v2.11.0 www.redadmin.org B309D109EFD83
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redadmin.org;
	s=20231208space; t=1759239948;
	bh=hcLsrul/wXlLzNNpWTc3vNtijAfswDidjbEuP6VB2nA=;
	h=From:To:Cc:Subject:Date:From;
	b=T49C/t9FBor7m7YHgM8FukzdiLTFBGUBnX2xRpW6vJYc5I6aDj/PB6IT94JvbB43J
	 d+6A2id7j/wBcGLeUMrnuR1PP7tX75p16UZclsPC6or2JfVexsMXCp8Bli6R+RROHK
	 DwMo8thbaSW/sHMm+FeRzvclvgHe0EYQ9186H/84=
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
Date: Tue, 30 Sep 2025 22:45:47 +0900
Message-ID: <20250930134547.1096686-1-weibu@redadmin.org>
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

