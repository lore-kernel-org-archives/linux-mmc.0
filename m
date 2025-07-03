Received: from mail-m19731110.qiye.163.com (mail-m19731110.qiye.163.com [220.197.31.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FCF1286A1;
	Thu,  3 Jul 2025 04:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751517427; cv=none; b=VBFmiDINJGn1yUaWl8xcoUd31coabshjYuOLHm4VbiU+McKypQShLOfFGqna4dbIi1riUbhT2u8I7oilYvpAMZEe5FjyoXgLyy7PK50MSP9dCz6x1zE125A2H9cvo7eLwvzVrIob1DyN00mjiACh2Bz1tAd8HciknrDrXtb1hiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751517427; c=relaxed/simple;
	bh=eq/0Gz6yWgurCokFmD71XuCYX8fNFWyC9taesIVujXY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mxxUBE+fVBNx168jZL5ftNma4PEicrPqb81yewDwX10xJzciFKRqlzwVpztVmdAUQ8BqU3Gc1SRsi27NkMK8EJXwKJlsQ9afPGELWG/m0Uoir9v1NxoMCDGXsJSGbRuUZUlVL+EaK+XZMRF43ElmcyZqkX4bbVwQlFxllJS1ExA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thundersoft.com; spf=pass smtp.mailfrom=thundersoft.com; dkim=pass (1024-bit key) header.d=thundersoft.com header.i=@thundersoft.com header.b=jn/m6+qx; arc=none smtp.client-ip=220.197.31.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thundersoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thundersoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=thundersoft.com header.i=@thundersoft.com header.b="jn/m6+qx"
Received: from localhost.localdomain (unknown [117.184.129.134])
	by smtp.qiye.163.com (Hmail) with ESMTP id 1ac1ee70e;
	Thu, 3 Jul 2025 12:36:55 +0800 (GMT+08:00)
From: Albert Yang <yangzh0906@thundersoft.com>
To: robh@kernel.org
Cc: krzk+dt@kernel.org,
	krzk@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/8] dt-bindings: mmc: add binding for BST DWCMSHC SDHCI controller
Date: Thu,  3 Jul 2025 12:36:54 +0800
Message-Id: <20250703043654.4083833-1-yangzh0906@thundersoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <175146290763.1131398.8272632937196214694.robh@kernel.org>
References: <175146290763.1131398.8272632937196214694.robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaSE9PVhlJSk4dGE0fTEkaTlYVFAkWGhdVEwETFh
	oSFyQUDg9ZV1kYEgtZQVlKSkxVSkNPVUpJQlVKSE9ZV1kWGg8SFR0UWUFZT0tIVUpLSEpOTEpVSk
	tLVUpCS0tZBg++
X-HM-Tid: 0a97ce92c74109cckunm9641f1be55a1d0
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MzI6NSo5LDE6CkxITS0WPzMs
	HUoKFCxVSlVKTE5KTkpMT0pNSUtKVTMWGhIXVQIaFRwBE0tCS007DxMOFR8eCQgUHQ9VGBQWRVlX
	WRILWUFZSkpMVUpDT1VKSUJVSkhPWVdZCAFZQUlNSkg3Bg++
DKIM-Signature:a=rsa-sha256;
	b=jn/m6+qxbXdFQcrKxZa8eYip3Zg8G6TyRaF4QxUtkVoGcpfIhVdRLBEj2heRgB7oJH/HVrokj7jzCvAyFvw4qOq+LdmuW5BitO0uTQdWRBoqo/7LUQdQS089/U0QfOT0ADPYAmCuZ1jlg+zldT6r5wApdjehvJqAO+Pwg3B+9Eo=; c=relaxed/relaxed; s=default; d=thundersoft.com; v=1;
	bh=PteOhnwZL6+z6LVTAMqE16FB0kBja4U8lGBV/Y06h0M=;
	h=date:mime-version:subject:message-id:from;

Hi Rob,

Thank you for the automated dt-binding check report.

> My bot found errors running 'make dt_binding_check' on your patch:
> 
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mmc/bst,dwcmshc-sdhci.example.dtb: mmc@22200000 (bst,c1200-dwcmshc-sdhci): reg: [[0, 572522496], [0, 4096], [0, 587227136], [0, 4096]] is too long
> 	from schema $id: http://devicetree.org/schemas/mmc/bst,dwcmshc-sdhci.yaml#

I have identified and fixed this issue. The problem was that the binding example used 64-bit addresses but lacked the proper bus wrapper with #address-cells and #size-cells settings.

Fix Applied:
I've wrapped the example in a proper bus node with the correct address/size-cells, following the pattern used in sdhci-am654.yaml for handling 64-bit addresses:

examples:
  - |
    #include <dt-bindings/interrupt-controller/arm-gic.h>
    #include <dt-bindings/interrupt-controller/irq.h>

    bus {
        #address-cells = <2>;
        #size-cells = <2>;

        mmc@22200000 {
            compatible = "bst,c1200-dwcmshc-sdhci";
            reg = <0x0 0x22200000 0x0 0x1000>,
                  <0x0 0x23006000 0x0 0x1000>;
            interrupts = <GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>;
            clocks = <&clk_mmc>;
            clock-names = "core";
            memory-region = <&mmc0_reserved>;
            max-frequency = <200000000>;
            bus-width = <8>;
            non-removable;
            dma-coherent;
        };
    };

This approach is consistent with how sdhci-am654.yaml handles multiple reg entries with 64-bit addresses, and matches the actual usage in our bstc1200.dtsi file where the soc node defines #address-cells = <2> and #size-cells = <2>.

Verification:
After the fix, make dt_binding_check DT_SCHEMA_FILES=Documentation/devicetree/bindings/mmc/bst,dwcmshc-sdhci.yaml passes without errors.

Best regards,
Albert Yang
