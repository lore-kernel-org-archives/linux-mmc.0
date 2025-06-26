Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B2E2EAB96;
	Thu, 26 Jun 2025 14:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750949064; cv=none; b=hlnFyny0jUQrANepqBNnJsPS8wCAimHCaIXAOp0c9FIQK87ijvlzDtwFI1p92Tuu7eVNOAduYH4RSlEc0DIUo+lQTbzmuy8jMIDl7vvVfmtaU+p87llbqmlEuXjFfw1AblTZabWy64RRhmSQwkVOL6I4A6hiA79j8d18CUUEld0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750949064; c=relaxed/simple;
	bh=fukcXIXMQoVZn94YvDdjm8nFKb8RmuU90szx32AqnB0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tTR162lSMx9qWNMno7Xdzv/P7x3HdAiymBdwjzOto9QmumuvOxyiK+pf+AlXOCeV5LOr+webqeuL6YACbXYJau/cbFvsXy4qGuJBAuer0i/ct1yez4POaizmscC3nkityJWsSSSdHaXpaVDj0ZuLMp4gdG927vIXtVfJwxI1LHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=UfnshkbR; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="UfnshkbR"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3958E43A12;
	Thu, 26 Jun 2025 14:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1750949054;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TL3SbPdWICbQ9mpLgPyWfu19LSVtxwepVcgJQRcbOzM=;
	b=UfnshkbR/9+AhrRyWniTdHHpUQLl14+QYhvLOlTYT/vtUzZLHJ3QORpLwToRmilhuQZUH3
	nCZR6WCjv8ex62fWAMP6lEAZ8DxkIALwktqbSkrAOu0GFp2wyfR0hnBSQl013Hr7F89fSq
	/yl52qmaszzJTipQe+iiAa9AgLT7nP0ZbBHYDgrfXhL8fs2VTO8xnASSSIGrPg/AgJFNFV
	7nJ3jJSjOWmM0cFBbhYM3k2RvWsXG6vFYdA43SNHuw0yZPRuF4xi6OLOSLn/2vHj2FVNfI
	zLmQmcJsYrA3FRro1n0J5nRS8ieTAehJmkwwUrUxv6zha4vFlMytG9kU3q0FYA==
From: =?UTF-8?q?Beno=C3=AEt=20Monin?= <benoit.monin@bootlin.com>
To: Adrian Hunter <adrian.hunter@intel.com>,
	Ulf Hansson <ulf.hansson@linaro.org>
Cc: =?UTF-8?q?Beno=C3=AEt=20Monin?= <benoit.monin@bootlin.com>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
	Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
	Gregory CLEMENT <gregory.clement@bootlin.com>,
	=?UTF-8?q?Th=C3=A9o=20Lebrun?= <theo.lebrun@bootlin.com>,
	"Thomas Petazzoni" <thomas.petazzoni@bootlin.com>
Subject: [PATCH 1/2] mmc: sdhci-cadence: use of_property_present
Date: Thu, 26 Jun 2025 16:43:31 +0200
Message-ID: <e244c1377f7b2ad5d026c9d9368a08de3887129f.1750943549.git.benoit.monin@bootlin.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <cover.1750943549.git.benoit.monin@bootlin.com>
References: <cover.1750943549.git.benoit.monin@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeghecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgjfhggtgfgsehtkeertdertdejnecuhfhrohhmpeeuvghnohpfthcuofhonhhinhcuoegsvghnohhithdrmhhonhhinhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepvdfffeeiieejkeevuefhvdeggeefudffueeuffehffehffevjedugfdtueegtddvnecukfhppedvrgdtudemtggsudegmeehheeimeejrgdttdemudehfeejmehffeehmeelfeeiugemvgelvdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgdugeemheehieemjegrtddtmeduheefjeemfhefheemleefiegumegvledvhedphhgvlhhopehfrhgrmhgvfihorhhkpdhmrghilhhfrhhomhepsggvnhhoihhtrdhmohhnihhnsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedutddprhgtphhtthhopegrughrihgrnhdrhhhunhhtvghrsehinhhtvghlrdgtohhmpdhrtghpthhtohepuhhlfhdrhhgrnhhsshhonheslhhinhgrrhhordhorhhgpdhrtghpthhtohepsggvnhhoihhtrdhmohhnihhnsegsohhothhlihhnrdgtohhmpdhrtghpthhtoheplhhinhhugidqm
 hhmtgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehvlhgrughimhhirhdrkhhonhgurhgrthhivghvsehmohgsihhlvgihvgdrtghomhdprhgtphhtthhopehtrgiffhhikhdrsggrhihouhhksehmohgsihhlvgihvgdrtghomhdprhgtphhtthhopehgrhgvghhorhihrdgtlhgvmhgvnhhtsegsohhothhlihhnrdgtohhm
X-GND-Sasl: benoit.monin@bootlin.com

Instead of using of_property_read_bool to check the presence of the
cdns,phy-* properties in the device tree, use of_property_present in
function sdhci_cdns_phy_param_count.

This silences the following warning messages since the cdns,phy-*
properties are all u32, not boolean.

OF: /soc/sdhci@d8010000: Read of boolean property 'cdns,phy-input-delay-legacy' with a value.
OF: /soc/sdhci@d8010000: Read of boolean property 'cdns,phy-input-delay-mmc-highspeed' with a value.
OF: /soc/sdhci@d8010000: Read of boolean property 'cdns,phy-input-delay-mmc-ddr' with a value.
OF: /soc/sdhci@d8010000: Read of boolean property 'cdns,phy-dll-delay-sdclk' with a value.
OF: /soc/sdhci@d8010000: Read of boolean property 'cdns,phy-dll-delay-sdclk-hsmmc' with a value.

Signed-off-by: Benoît Monin <benoit.monin@bootlin.com>
---
 drivers/mmc/host/sdhci-cadence.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-cadence.c b/drivers/mmc/host/sdhci-cadence.c
index a94b297fcf2a..27bd2eb29948 100644
--- a/drivers/mmc/host/sdhci-cadence.c
+++ b/drivers/mmc/host/sdhci-cadence.c
@@ -144,7 +144,7 @@ static unsigned int sdhci_cdns_phy_param_count(struct device_node *np)
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(sdhci_cdns_phy_cfgs); i++)
-		if (of_property_read_bool(np, sdhci_cdns_phy_cfgs[i].property))
+		if (of_property_present(np, sdhci_cdns_phy_cfgs[i].property))
 			count++;
 
 	return count;
