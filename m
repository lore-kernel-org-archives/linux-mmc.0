Received: from mail-m1973180.qiye.163.com (mail-m1973180.qiye.163.com [220.197.31.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6D07262F;
	Wed, 15 Oct 2025 09:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760521586; cv=none; b=XrRfmjVb/eiikCq+yOxPT3mDMAbG+8szZKirFknvsNEe9cZ/rCOlT5cUNS6zGSo/9LxhmLXvzF9XT89I8HtAvQ6Uggrngvkl/XCt2iIPeH5aPGkZuONtI/E/XWb3962PfgLOiMKc02ze9Unvk7ffbcL2pT5qIffzQzXqMS67Z8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760521586; c=relaxed/simple;
	bh=EeTz9XPuu7BAUwUtkubwAobfgHHacbYpZdkwkkjlacY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hROJz8KPKY5owbJ+fQulYFt22TYuWeBCSW2MpaK2+IQxyRWD7NDxB7fj3snBoLLclkW+ymX+2ZFb5yQiviIobkF4RZoLdoNTv52RF2PcnC4p0N3H3bTSKM+kNz2cSJjSI3pceaswgotPFya2Uk3dV77O1eAuTdb/uk2o8D11KeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thundersoft.com; spf=pass smtp.mailfrom=thundersoft.com; dkim=pass (1024-bit key) header.d=thundersoft.com header.i=@thundersoft.com header.b=ZF/M/Ju1; arc=none smtp.client-ip=220.197.31.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thundersoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thundersoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=thundersoft.com header.i=@thundersoft.com header.b="ZF/M/Ju1"
Received: from albert-OptiPlex-7080.. (unknown [117.184.129.134])
	by smtp.qiye.163.com (Hmail) with ESMTP id 25feb775a;
	Wed, 15 Oct 2025 17:31:03 +0800 (GMT+08:00)
From: Albert Yang <yangzh0906@thundersoft.com>
To: robh@kernel.org
Cc: adrian.hunter@intel.com,
	arnd@arndb.de,
	bst-upstream@bstai.top,
	catalin.marinas@arm.com,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	gordon.ge@bst.ai,
	krzk+dt@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	ulf.hansson@linaro.org,
	will@kernel.org,
	yangzh0906@thundersoft.com
Subject: Re: [PATCH 4/9] dt-bindings: mmc: add binding for BST DWCMSHC SDHCI controller
Date: Wed, 15 Oct 2025 17:31:02 +0800
Message-ID: <20251015093102.1554881-1-yangzh0906@thundersoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <175862238966.2427901.366123788055800395.robh@kernel.org>
References: <175862238966.2427901.366123788055800395.robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a99e735723809cckunmdf24c7d565021a
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZTB4ZVktJQ0oeSEJMTE4YQ1YVFAkWGhdVEwETFh
	oSFyQUDg9ZV1kYEgtZQVlKSkxVSkNPVUpJQlVKSE9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0hVSk
	tLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=ZF/M/Ju14bJoKl5y4eEJGYP+s0aqD7uGcfvw6nQhqPmgd7COTxeBT+TFvcHvOjbd8kJlLRbTfVAIQR7H7D34x6MAH3qImVJ9geDT/PWlOacYoRi3t7NIuEmCumdyE++j2qtKrIPtAP27XwQqUMtyCXGaJHhsFv/xvD77YW+8EPQ=; c=relaxed/relaxed; s=default; d=thundersoft.com; v=1;
	bh=kazy95w4NqQW9hygc2OcQJl8bs8aQ8rm5/DSPqHwz30=;
	h=date:mime-version:subject:message-id:from;

Hi Rob,

Thank you for running the dt_binding_check on this patch!

On Tue, Sep 23, 2025 at 05:13:09AM -0500, Rob Herring (Arm) wrote:
> My bot found errors running 'make dt_binding_check' on your patch:
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> Documentation/devicetree/bindings/mmc/bst,dwcmshc-sdhci.example.dtb: /example-0/bus/mmc@22200000: failed to match any schema with compatible: ['bst,c1200-dwcmshc-sdhci']

This error occurred because in v4, while I updated the dts compatible property 
definition to "bst,c1200-sdhci" (as requested in review), I failed to update 
the compatible string in the example node accordingly. The example was still 
using the old "bst,c1200-dwcmshc-sdhci", causing the schema validation to fail.

I have now corrected the example's compatible string from:
    compatible = "bst,c1200-dwcmshc-sdhci";
to:
    compatible = "bst,c1200-sdhci";

Following your suggestion, I've upgraded dtschema:
    pip3 install dtschema --upgrade

and verified the fix with:
    make dt_binding_check DT_SCHEMA_FILES=Documentation/devicetree/bindings/mmc/bst,c1200-sdhci.yaml

The binding now passes all validation checks. This fix will be included in v5.

Best regards,
Albert Yang
