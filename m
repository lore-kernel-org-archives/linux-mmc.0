Return-Path: <SRS0=KkSK=AD=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28327C433E1
	for <linux-mmc@archiver.kernel.org>; Mon, 22 Jun 2020 08:51:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E31A62070E
	for <linux-mmc@archiver.kernel.org>; Mon, 22 Jun 2020 08:51:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="J7jaHAeb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725958AbgFVIvp (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 22 Jun 2020 04:51:45 -0400
Received: from mail-dm6nam10on2089.outbound.protection.outlook.com ([40.107.93.89]:6149
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725952AbgFVIvo (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 22 Jun 2020 04:51:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bJVl4z6rYfyZ8dLiMraF3Q98dUrpPReJLsyNs9C+PblIMN16v875ygKydZ1LxOgh/9BJ/buLpFMm1b+DM1M5Iqi2+pZwR3SHEvHzmmx7t7MfTfOZju0pNtEUXJVKu19MwCI62iUxByOT2hY1kznTl+GQO8mLUZezoCZteqUvCBT4NMEW6mx3dDe51KpCCeWDa3bLUSPm/Y2dSp+qDk6bSWtwYo7B6sx55avTOUyKJ4G/ot5Pm1f+X757niB4INlBV4qKkNZt+ZhYuvrjnU5DQeJNsCjVMYwSGqrbgv0mU/h3E+KEiSiDRd9z1OUPN+Hm3FKWLqk7mg/DoUDNvv/41g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D7v39zB2rBdGcrL7S9IqrMJx5TMhZ5Py1bSPh2IYiHA=;
 b=RT4O//vQ0IcR/o9/mZOAADy27P/nJqSaKp4oTyvEpbYdxGDjfS1YcvYiwDTDKg/Kl+qebypMaImhBODEtr7iBgzMTvQ8t+MjrSzlRCFGPmCws+KlaiM0sU/t+puvvfwWfl4LAeYIkHqfp8BbkWaUOrjPlURai6G1VhVXn+fYFOhW9gHy58mAqrOiQlKTTabBy5lKJKiPvhu5EKYvVV2gw8djLMfAdYTd10fWXKNryvptZ0z3uPyIZWj6BDiX9O0Q9FMVNSpHXumBNzfQAjaGVGlmQAv1yne/84XX/lEAEPb9eVzcyZ5dXNWlDoFIobKFhMvY0lmJMuTvycaZDwsG6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D7v39zB2rBdGcrL7S9IqrMJx5TMhZ5Py1bSPh2IYiHA=;
 b=J7jaHAebK/EDyVel79IGd52BhYzBNFUS8kJ+XqChNd4PLYJH6cPBFNxu/wpdqDC9jpGyMiMYeqwNhmcdt0KMCKSStMNNskOxbYsiElV4BBWTOYKUWI5VA/4xPXJR9zUQXvqrSisyxCbnoduYjwnWcF2F4ZS40hhufijSBO/M5yU=
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=synaptics.com;
Received: from BYAPR03MB3573.namprd03.prod.outlook.com (2603:10b6:a02:ae::15)
 by BYAPR03MB3509.namprd03.prod.outlook.com (2603:10b6:a02:aa::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Mon, 22 Jun
 2020 08:51:40 +0000
Received: from BYAPR03MB3573.namprd03.prod.outlook.com
 ([fe80::d1ae:8ea7:ea:8998]) by BYAPR03MB3573.namprd03.prod.outlook.com
 ([fe80::d1ae:8ea7:ea:8998%7]) with mapi id 15.20.3109.027; Mon, 22 Jun 2020
 08:51:40 +0000
Date:   Mon, 22 Jun 2020 16:44:31 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] dt-bindings: mmc: Convert pwrseq to json-schema
Message-ID: <20200622164431.3dbc8c5a@xhacker.debian>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TY2PR06CA0048.apcprd06.prod.outlook.com
 (2603:1096:404:2e::36) To BYAPR03MB3573.namprd03.prod.outlook.com
 (2603:10b6:a02:ae::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from xhacker.debian (124.74.246.114) by TY2PR06CA0048.apcprd06.prod.outlook.com (2603:1096:404:2e::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22 via Frontend Transport; Mon, 22 Jun 2020 08:51:38 +0000
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
X-Originating-IP: [124.74.246.114]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8e0ff31a-69b9-4015-83cf-08d816897ad7
X-MS-TrafficTypeDiagnostic: BYAPR03MB3509:
X-Microsoft-Antispam-PRVS: <BYAPR03MB35099A8856215875E3BD1C91ED970@BYAPR03MB3509.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0442E569BC
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HVzpMQVvUNHHNVztAyuitzQNF9x2BbTGQ9b1G66GyNayJ9Wg2GYEh3C+FwoTreTPXgMAXcK60agJ5FADPq6Zht/tslB8m77dTPM+2jJ7UKeii1mNTRLvrJtIOmerS6WY4cnppgnV0uQGdbiYQOuiINVzfjBAepGv7VH1sHlv/PpRXHjq8DCzbh9qqx/9P7tfWfEgM+ZlpbLK3VP9KO8zDgHhiC7Q6YgZNRIAso2BpxI/Va2xb9t2rIpqJsWcOijvOCpaZa7kwFOWDdB65WOKE5p/Y0itY6mZH5TfX+XQaY51Wd1yTLBm8vr5gc/GAIcx1ZsnB1/uQZ8JyzOJcreosl6G4jxJiYV+uSN2MK3ydHYc9zHF+annvzW6JlYxKGnVNryxhQc7c4yX67yRFxjrtg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3573.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(136003)(366004)(346002)(39860400002)(396003)(376002)(2906002)(966005)(66556008)(110136005)(1076003)(5660300002)(66476007)(9686003)(66946007)(6666004)(83380400001)(86362001)(8676002)(956004)(4326008)(55016002)(316002)(26005)(16526019)(186003)(52116002)(6506007)(478600001)(7696005)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: W7kvPQK80O5auJqwBSw82erluW3ygWFVZYC2pdAEEISErOI2sWVifb+/3fXDTlBcnrfEO5ZAe8VAAnNQVwAashS9AFI9k3MI/6ow7G+xvVOitbHYJBfHCj3EwBrjxGGsFHTFP/PEW0OuvYj5acr3kWPy9KQEkXInTFgzYC+fHiNzbxLWQ+8O682j1UnWPV7Vmw02+eipSmg7OJIVHALd607RFFfnZy4icK0oCOaoDViBdjhwP4uHZqh3PVXsUr2YuF6OA3KP+JBJsYcE+CS+n7PEl1v4DgB6GAEYTgVXsI06YOEKbdTr/vwBHXQpsJD1slW76FyazSvUuwGeGtAT0AgMtEvyG2rIfHG8TPs/pd5CtcwLB4VB9OHl10lyV+1I8dDVBPSJrikl3eI8zPNJ+nX7C1sc7g4Lch711+YSEXrbMEuUnMKCWO8b1o+Yrt+UAlLM+C1UoDdo2uc7RQzbtnaNJuCktvbekgtvLEDEkpOUJ47u0MudTsK/pSScMifl
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e0ff31a-69b9-4015-83cf-08d816897ad7
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2020 08:51:40.2948
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +AxNhsRMLHdY50QZa471sxw5UrsjvGFfJ115Jf9/kY9V2BdDn7jBAzLulgbPQK1of+t8Ak2xff9C0GXGZxBYuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB3509
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Convert the pwrseq binding to DT schema format using json-schema.

At the same time, fix a couple of issues with the examples discovered by
the validation tool -- missing ";"

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
since v1:
 - conver pwrseq to yaml format rather than fixing old docs

 .../bindings/mmc/mmc-pwrseq-emmc.txt          | 25 --------
 .../bindings/mmc/mmc-pwrseq-emmc.yaml         | 46 ++++++++++++++
 .../bindings/mmc/mmc-pwrseq-sd8787.txt        | 16 -----
 .../bindings/mmc/mmc-pwrseq-sd8787.yaml       | 39 ++++++++++++
 .../bindings/mmc/mmc-pwrseq-simple.txt        | 31 ----------
 .../bindings/mmc/mmc-pwrseq-simple.yaml       | 62 +++++++++++++++++++
 6 files changed, 147 insertions(+), 72 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/mmc/mmc-pwrseq-emmc.txt
 create mode 100644 Documentation/devicetree/bindings/mmc/mmc-pwrseq-emmc.yaml
 delete mode 100644 Documentation/devicetree/bindings/mmc/mmc-pwrseq-sd8787.txt
 create mode 100644 Documentation/devicetree/bindings/mmc/mmc-pwrseq-sd8787.yaml
 delete mode 100644 Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.txt
 create mode 100644 Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.yaml

diff --git a/Documentation/devicetree/bindings/mmc/mmc-pwrseq-emmc.txt b/Documentation/devicetree/bindings/mmc/mmc-pwrseq-emmc.txt
deleted file mode 100644
index 3d965d57e00b..000000000000
--- a/Documentation/devicetree/bindings/mmc/mmc-pwrseq-emmc.txt
+++ /dev/null
@@ -1,25 +0,0 @@
-* The simple eMMC hardware reset provider
-
-The purpose of this driver is to perform standard eMMC hw reset
-procedure, as described by Jedec 4.4 specification. This procedure is
-performed just after MMC core enabled power to the given mmc host (to
-fix possible issues if bootloader has left eMMC card in initialized or
-unknown state), and before performing complete system reboot (also in
-case of emergency reboot call). The latter is needed on boards, which
-doesn't have hardware reset logic connected to emmc card and (limited or
-broken) ROM bootloaders are unable to read second stage from the emmc
-card if the card is left in unknown or already initialized state.
-
-Required properties:
-- compatible : contains "mmc-pwrseq-emmc".
-- reset-gpios : contains a GPIO specifier. The reset GPIO is asserted
-	and then deasserted to perform eMMC card reset. To perform
-	reset procedure as described in Jedec 4.4 specification, the
-	gpio line should be defined as GPIO_ACTIVE_LOW.
-
-Example:
-
-	sdhci0_pwrseq {
-		compatible = "mmc-pwrseq-emmc";
-		reset-gpios = <&gpio1 12 GPIO_ACTIVE_LOW>;
-	}
diff --git a/Documentation/devicetree/bindings/mmc/mmc-pwrseq-emmc.yaml b/Documentation/devicetree/bindings/mmc/mmc-pwrseq-emmc.yaml
new file mode 100644
index 000000000000..77f746f57284
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/mmc-pwrseq-emmc.yaml
@@ -0,0 +1,46 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mmc/mmc-pwrseq-emmc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Simple eMMC hardware reset provider binding
+
+maintainers:
+  - Ulf Hansson <ulf.hansson@linaro.org>
+
+description:
+  The purpose of this driver is to perform standard eMMC hw reset
+  procedure, as described by Jedec 4.4 specification. This procedure is
+  performed just after MMC core enabled power to the given mmc host (to
+  fix possible issues if bootloader has left eMMC card in initialized or
+  unknown state), and before performing complete system reboot (also in
+  case of emergency reboot call). The latter is needed on boards, which
+  doesn't have hardware reset logic connected to emmc card and (limited or
+  broken) ROM bootloaders are unable to read second stage from the emmc
+  card if the card is left in unknown or already initialized state.
+
+properties:
+  compatible:
+    const: mmc-pwrseq-emmc
+
+  reset-gpios:
+    minItems: 1
+    description:
+      contains a GPIO specifier. The reset GPIO is asserted
+      and then deasserted to perform eMMC card reset. To perform
+      reset procedure as described in Jedec 4.4 specification, the
+      gpio line should be defined as GPIO_ACTIVE_LOW.
+
+required:
+  - compatible
+  - reset-gpios
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    sdhci0_pwrseq {
+      compatible = "mmc-pwrseq-emmc";
+      reset-gpios = <&gpio1 12 GPIO_ACTIVE_LOW>;
+    };
+...
diff --git a/Documentation/devicetree/bindings/mmc/mmc-pwrseq-sd8787.txt b/Documentation/devicetree/bindings/mmc/mmc-pwrseq-sd8787.txt
deleted file mode 100644
index 22e9340e4ba2..000000000000
--- a/Documentation/devicetree/bindings/mmc/mmc-pwrseq-sd8787.txt
+++ /dev/null
@@ -1,16 +0,0 @@
-* Marvell SD8787 power sequence provider
-
-Required properties:
-- compatible: must be "mmc-pwrseq-sd8787".
-- powerdown-gpios: contains a power down GPIO specifier with the
-		   default active state
-- reset-gpios: contains a reset GPIO specifier with the default
-		   active state
-
-Example:
-
-	wifi_pwrseq: wifi_pwrseq {
-		compatible = "mmc-pwrseq-sd8787";
-		powerdown-gpios = <&twl_gpio 0 GPIO_ACTIVE_LOW>;
-		reset-gpios = <&twl_gpio 1 GPIO_ACTIVE_LOW>;
-	}
diff --git a/Documentation/devicetree/bindings/mmc/mmc-pwrseq-sd8787.yaml b/Documentation/devicetree/bindings/mmc/mmc-pwrseq-sd8787.yaml
new file mode 100644
index 000000000000..a68820d31d50
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/mmc-pwrseq-sd8787.yaml
@@ -0,0 +1,39 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mmc/mmc-pwrseq-sd8787.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Marvell SD8787 power sequence provider binding
+
+maintainers:
+  - Ulf Hansson <ulf.hansson@linaro.org>
+
+properties:
+  compatible:
+    const: mmc-pwrseq-sd8787
+
+  powerdown-gpios:
+    minItems: 1
+    description:
+      contains a power down GPIO specifier with the default active state
+
+  reset-gpios:
+    minItems: 1
+    description:
+      contains a reset GPIO specifier with the default active state
+
+required:
+  - compatible
+  - powerdown-gpios
+  - reset-gpios
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    wifi_pwrseq: wifi_pwrseq {
+      compatible = "mmc-pwrseq-sd8787";
+      powerdown-gpios = <&twl_gpio 0 GPIO_ACTIVE_LOW>;
+      reset-gpios = <&twl_gpio 1 GPIO_ACTIVE_LOW>;
+    };
+...
diff --git a/Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.txt b/Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.txt
deleted file mode 100644
index 9029b45b8a22..000000000000
--- a/Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.txt
+++ /dev/null
@@ -1,31 +0,0 @@
-* The simple MMC power sequence provider
-
-The purpose of the simple MMC power sequence provider is to supports a set of
-common properties between various SOC designs. It thus enables us to use the
-same provider for several SOC designs.
-
-Required properties:
-- compatible : contains "mmc-pwrseq-simple".
-
-Optional properties:
-- reset-gpios : contains a list of GPIO specifiers. The reset GPIOs are asserted
-	at initialization and prior we start the power up procedure of the card.
-	They will be de-asserted right after the power has been provided to the
-	card.
-- clocks : Must contain an entry for the entry in clock-names.
-  See ../clocks/clock-bindings.txt for details.
-- clock-names : Must include the following entry:
-  "ext_clock" (External clock provided to the card).
-- post-power-on-delay-ms : Delay in ms after powering the card and
-	de-asserting the reset-gpios (if any)
-- power-off-delay-us : Delay in us after asserting the reset-gpios (if any)
-	during power off of the card.
-
-Example:
-
-	sdhci0_pwrseq {
-		compatible = "mmc-pwrseq-simple";
-		reset-gpios = <&gpio1 12 GPIO_ACTIVE_LOW>;
-		clocks = <&clk_32768_ck>;
-		clock-names = "ext_clock";
-	}
diff --git a/Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.yaml b/Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.yaml
new file mode 100644
index 000000000000..449215444723
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.yaml
@@ -0,0 +1,62 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mmc/mmc-pwrseq-simple.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Simple MMC power sequence provider binding
+
+maintainers:
+  - Ulf Hansson <ulf.hansson@linaro.org>
+
+description:
+  The purpose of the simple MMC power sequence provider is to supports a set
+  of common properties between various SOC designs. It thus enables us to use
+  the same provider for several SOC designs.
+
+properties:
+  compatible:
+    const: mmc-pwrseq-simple
+
+  reset-gpios:
+    minItems: 1
+    description:
+      contains a list of GPIO specifiers. The reset GPIOs are asserted
+      at initialization and prior we start the power up procedure of the card.
+      They will be de-asserted right after the power has been provided to the
+      card.
+
+  clocks:
+    minItems: 1
+    description: Handle for the entry in clock-names.
+
+  clock-names:
+    items:
+      - const: ext_clock
+    description: External clock provided to the card.
+
+  post-power-on-delay-ms:
+    description:
+      Delay in ms after powering the card and de-asserting the
+      reset-gpios (if any).
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+  power-off-delay-us:
+    description:
+      Delay in us after asserting the reset-gpios (if any)
+      during power off of the card.
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+required:
+  - compatible
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    sdhci0_pwrseq {
+      compatible = "mmc-pwrseq-simple";
+      reset-gpios = <&gpio1 12 GPIO_ACTIVE_LOW>;
+      clocks = <&clk_32768_ck>;
+      clock-names = "ext_clock";
+    };
+...
-- 
2.27.0

