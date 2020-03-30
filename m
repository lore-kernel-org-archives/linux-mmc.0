Return-Path: <SRS0=N9dB=5P=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81355C2D0EC
	for <linux-mmc@archiver.kernel.org>; Mon, 30 Mar 2020 05:42:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E63720786
	for <linux-mmc@archiver.kernel.org>; Mon, 30 Mar 2020 05:42:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="GphrfgoX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728503AbgC3Fmg (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 30 Mar 2020 01:42:36 -0400
Received: from mail-bn8nam12on2048.outbound.protection.outlook.com ([40.107.237.48]:6218
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728471AbgC3Fmg (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 30 Mar 2020 01:42:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kMwel7OBCRuG1RoQqOZVFoyMfhIAel4dQEwht3c+sGtyodiNC5Hc1xT1N+FMWkd8BwSAaljBvl39Vll4yXvvaB5yvZ7AVNnX115NCoTOM6v9YQgy4Hkb+LdaT0c8kA9GXRVdEZMSsKZODTMw68hNUHLy511Od7CCMYEn5gQoTLpLXtX/9ENSsNy3Kp+TOxFOi+jKhfTp97ILYexXrs1lyXvwmWffV7kwOF08CixZT+K21ox+97o2lbkAm6EhmNzwv8r4rHwYRA8eKDVdcNRPrYiMZM0/lJa6Sa4mmmDqUrEO5pxwv0621oOITD5DXnqU0s77/LvKlXgXJWpwEkY5vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0gNBqh3HtnAGmPPKJEbBzltwRdHdZed8PGBV0USGeoo=;
 b=NxygUb4Ir2R//uOos79h1283aHMu+r8svgFE6Zt7WfxWVnwqAGWfb2IeU33WdKUpXDYLbmwT1BdW6+S+BaxeukqhAPNLOnsxEpsJA+6+lLnE+4xAqN2TMqpEMYaqg/fOvtNnJnMUo2w+1BltOsWdV9L8r9ah7yDFe7mJgZFksc2xccIphldUmeb9V99GqQDKfZwEBa7Hs9b3nr0ZVKN4V0cZ8NuBvhUf+2saeUj8UHItyzwii1N+mBI1+kC6JluVKLBciMmjp2CKY0ngdsPYJcNm5843thNrwO7utNbLmzzRPutXd/DvPUw6+hqSPkrtEd2IxHh5oZKJFYDxZNeBdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=arm.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0gNBqh3HtnAGmPPKJEbBzltwRdHdZed8PGBV0USGeoo=;
 b=GphrfgoXSDQkwz4DekCVFTa9WNktOgqEjrAV0I5YnbrVYbjxrWieyHzJirgFikG95/gBU+H4E3NwW2x/ZAMmYh8I3l1j5Io3lystVgWo5pcjO2TA+XSwVlE9j/g9P0Oq8vA717TA3A6bviwRLwZ23pPUPOxpHm6IbGlsbNC2EcM=
Received: from MN2PR22CA0029.namprd22.prod.outlook.com (2603:10b6:208:238::34)
 by DM6PR02MB4428.namprd02.prod.outlook.com (2603:10b6:5:1f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.20; Mon, 30 Mar
 2020 05:42:30 +0000
Received: from BL2NAM02FT013.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:238:cafe::78) by MN2PR22CA0029.outlook.office365.com
 (2603:10b6:208:238::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.20 via Frontend
 Transport; Mon, 30 Mar 2020 05:42:30 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT013.mail.protection.outlook.com (10.152.77.19) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2856.17
 via Frontend Transport; Mon, 30 Mar 2020 05:42:29 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1jInBt-0005hZ-5e; Sun, 29 Mar 2020 22:42:29 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1jInBo-0003Qa-2H; Sun, 29 Mar 2020 22:42:24 -0700
Received: from [172.23.64.106] (helo=xhdvnc125.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <mnarani@xilinx.com>)
        id 1jInBf-0003Oa-SS; Sun, 29 Mar 2020 22:42:16 -0700
Received: by xhdvnc125.xilinx.com (Postfix, from userid 16987)
        id 71AC2121373; Mon, 30 Mar 2020 11:11:26 +0530 (IST)
From:   Manish Narani <manish.narani@xilinx.com>
To:     ulf.hansson@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        adrian.hunter@intel.com, michal.simek@xilinx.com
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        git@xilinx.com, Manish Narani <manish.narani@xilinx.com>
Subject: [PATCH v2 4/4] mmc: sdhci-of-arasan: Fix kernel-doc warnings
Date:   Mon, 30 Mar 2020 11:11:19 +0530
Message-Id: <1585546879-91037-5-git-send-email-manish.narani@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1585546879-91037-1-git-send-email-manish.narani@xilinx.com>
References: <1585546879-91037-1-git-send-email-manish.narani@xilinx.com>
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(396003)(376002)(39850400004)(346002)(136003)(46966005)(6666004)(356004)(2906002)(6636002)(478600001)(316002)(42186006)(36756003)(47076004)(186003)(8936002)(6266002)(426003)(82740400003)(44832011)(5660300002)(2616005)(26005)(30864003)(70206006)(4326008)(8676002)(336012)(107886003)(81156014)(70586007)(81166006);DIR:OUT;SFP:1101;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 39042dc4-d2b3-4055-b7b7-08d7d46d2310
X-MS-TrafficTypeDiagnostic: DM6PR02MB4428:
X-Microsoft-Antispam-PRVS: <DM6PR02MB4428BC0411A99074E46B390AC1CB0@DM6PR02MB4428.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0358535363
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HAFj1tsPV0NYSicEV9/wXTj1VB9sp14LJ4pQguenFeXHBkA1m6fKy4z/Shiz4fbFouedsTwIHoLhmhFfr6yZWpoLg0Ji/J5rFNEqek+NBFj9ra7ReDyCH/ZCHjh0lc99EXTUnQVEzKrBah4B/bEElOJ+ldUJiuQcnUkAT0ZjSr9X9Pd/1ZqmhmOubY/gMyE2miYruXRjuI9LWqYmgLy3DNUwopZRe6cOgSVLbO7gybr6sB+aAGS3ZYr527rcDYOSGE4DN0dFeveFdZEhBW4s5E0xurntHjsplUcva2mpJEwLCBlTySL/Nx2H0x7APiy1ac1M5luti73J6C5Xa7+2Mx5uMp4a2CjItWrxdG+fcy2k4HFzaDZ7Uy5/4OZRcVuJipONljumP83pRIY+sgNy11Vzrimaq/YsHDx5Exa9NF+ARC47f8MzJT4ZQrQ9hicIsdLQ+CZiVcZZKaBa2iyQ6XzqoW4fNAfR7A1nm4eEeOJm0ET34PN9IfZ/zIX+a2Zv2CvGMRJrGtZMhPMz4rcWaw==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2020 05:42:29.7986
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 39042dc4-d2b3-4055-b7b7-08d7d46d2310
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4428
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Modify code to fix the warnings reported by kernel-doc for better
documentation.

Signed-off-by: Manish Narani <manish.narani@xilinx.com>
---
 drivers/mmc/host/sdhci-of-arasan.c | 114 ++++++++++++++++-------------
 1 file changed, 64 insertions(+), 50 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
index 89dbd1e9a830..0396d6b5396a 100644
--- a/drivers/mmc/host/sdhci-of-arasan.c
+++ b/drivers/mmc/host/sdhci-of-arasan.c
@@ -73,13 +73,13 @@ struct sdhci_arasan_soc_ctl_field {
 /**
  * struct sdhci_arasan_soc_ctl_map - Map in syscon to corecfg registers
  *
- * It's up to the licensee of the Arsan IP block to make these available
- * somewhere if needed.  Presumably these will be scattered somewhere that's
- * accessible via the syscon API.
- *
  * @baseclkfreq:	Where to find corecfg_baseclkfreq
  * @clockmultiplier:	Where to find corecfg_clockmultiplier
  * @hiword_update:	If true, use HIWORD_UPDATE to access the syscon
+ *
+ * It's up to the licensee of the Arsan IP block to make these available
+ * somewhere if needed.  Presumably these will be scattered somewhere that's
+ * accessible via the syscon API.
  */
 struct sdhci_arasan_soc_ctl_map {
 	struct sdhci_arasan_soc_ctl_field	baseclkfreq;
@@ -99,7 +99,8 @@ struct sdhci_arasan_clk_ops {
 };
 
 /**
- * struct sdhci_arasan_clk_data
+ * struct sdhci_arasan_clk_data - Arasan Controller Clock Data.
+ *
  * @sdcardclk_hw:	Struct for the clock we might provide to a PHY.
  * @sdcardclk:		Pointer to normal 'struct clock' for sdcardclk_hw.
  * @sampleclk_hw:	Struct for the clock we might provide to a PHY.
@@ -125,15 +126,18 @@ struct sdhci_arasan_zynqmp_clk_data {
 };
 
 /**
- * struct sdhci_arasan_data
+ * struct sdhci_arasan_data - Arasan Controller Data
+ *
  * @host:		Pointer to the main SDHCI host structure.
  * @clk_ahb:		Pointer to the AHB clock
  * @phy:		Pointer to the generic phy
  * @is_phy_on:		True if the PHY is on; false if not.
+ * @has_cqe:		True if controller has command queuing engine.
  * @clk_data:		Struct for the Arasan Controller Clock Data.
  * @clk_ops:		Struct for the Arasan Controller Clock Operations.
  * @soc_ctl_base:	Pointer to regmap for syscon for soc_ctl registers.
  * @soc_ctl_map:	Map to get offsets into soc_ctl registers.
+ * @quirks:		Arasan deviations from spec.
  */
 struct sdhci_arasan_data {
 	struct sdhci_host *host;
@@ -147,7 +151,7 @@ struct sdhci_arasan_data {
 
 	struct regmap	*soc_ctl_base;
 	const struct sdhci_arasan_soc_ctl_map *soc_ctl_map;
-	unsigned int	quirks; /* Arasan deviations from spec */
+	unsigned int	quirks;
 
 /* Controller does not have CD wired and will not function normally without */
 #define SDHCI_ARASAN_QUIRK_FORCE_CDTEST	BIT(0)
@@ -183,14 +187,16 @@ static const struct sdhci_arasan_soc_ctl_map intel_lgm_sdxc_soc_ctl_map = {
 /**
  * sdhci_arasan_syscon_write - Write to a field in soc_ctl registers
  *
+ * @host:	The sdhci_host
+ * @fld:	The field to write to
+ * @val:	The value to write
+ *
  * This function allows writing to fields in sdhci_arasan_soc_ctl_map.
  * Note that if a field is specified as not available (shift < 0) then
  * this function will silently return an error code.  It will be noisy
  * and print errors for any other (unexpected) errors.
  *
- * @host:	The sdhci_host
- * @fld:	The field to write to
- * @val:	The value to write
+ * Return: 0 on success and error value on error
  */
 static int sdhci_arasan_syscon_write(struct sdhci_host *host,
 				   const struct sdhci_arasan_soc_ctl_field *fld,
@@ -431,9 +437,10 @@ static const struct sdhci_pltfm_data sdhci_arasan_cqe_pdata = {
 /**
  * sdhci_arasan_suspend - Suspend method for the driver
  * @dev:	Address of the device structure
- * Returns 0 on success and error value on error
  *
  * Put the device in a low power state.
+ *
+ * Return: 0 on success and error value on error
  */
 static int sdhci_arasan_suspend(struct device *dev)
 {
@@ -474,9 +481,10 @@ static int sdhci_arasan_suspend(struct device *dev)
 /**
  * sdhci_arasan_resume - Resume method for the driver
  * @dev:	Address of the device structure
- * Returns 0 on success and error value on error
  *
  * Resume operation after suspend
+ *
+ * Return: 0 on success and error value on error
  */
 static int sdhci_arasan_resume(struct device *dev)
 {
@@ -525,16 +533,16 @@ static SIMPLE_DEV_PM_OPS(sdhci_arasan_dev_pm_ops, sdhci_arasan_suspend,
 /**
  * sdhci_arasan_sdcardclk_recalc_rate - Return the card clock rate
  *
+ * @hw:			Pointer to the hardware clock structure.
+ * @parent_rate:		The parent rate (should be rate of clk_xin).
+ *
  * Return the current actual rate of the SD card clock.  This can be used
  * to communicate with out PHY.
  *
- * @hw:			Pointer to the hardware clock structure.
- * @parent_rate		The parent rate (should be rate of clk_xin).
- * Returns the card clock rate.
+ * Return: The card clock rate.
  */
 static unsigned long sdhci_arasan_sdcardclk_recalc_rate(struct clk_hw *hw,
 						      unsigned long parent_rate)
-
 {
 	struct sdhci_arasan_clk_data *clk_data =
 		container_of(hw, struct sdhci_arasan_clk_data, sdcardclk_hw);
@@ -552,16 +560,16 @@ static const struct clk_ops arasan_sdcardclk_ops = {
 /**
  * sdhci_arasan_sampleclk_recalc_rate - Return the sampling clock rate
  *
+ * @hw:			Pointer to the hardware clock structure.
+ * @parent_rate:		The parent rate (should be rate of clk_xin).
+ *
  * Return the current actual rate of the sampling clock.  This can be used
  * to communicate with out PHY.
  *
- * @hw:			Pointer to the hardware clock structure.
- * @parent_rate		The parent rate (should be rate of clk_xin).
- * Returns the sample clock rate.
+ * Return: The sample clock rate.
  */
 static unsigned long sdhci_arasan_sampleclk_recalc_rate(struct clk_hw *hw,
 						      unsigned long parent_rate)
-
 {
 	struct sdhci_arasan_clk_data *clk_data =
 		container_of(hw, struct sdhci_arasan_clk_data, sampleclk_hw);
@@ -579,14 +587,14 @@ static const struct clk_ops arasan_sampleclk_ops = {
 /**
  * sdhci_zynqmp_sdcardclk_set_phase - Set the SD Output Clock Tap Delays
  *
+ * @hw:			Pointer to the hardware clock structure.
+ * @degrees:		The clock phase shift between 0 - 359.
+ *
  * Set the SD Output Clock Tap Delays for Output path
  *
- * @hw:			Pointer to the hardware clock structure.
- * @degrees		The clock phase shift between 0 - 359.
  * Return: 0 on success and error value on error
  */
 static int sdhci_zynqmp_sdcardclk_set_phase(struct clk_hw *hw, int degrees)
-
 {
 	struct sdhci_arasan_clk_data *clk_data =
 		container_of(hw, struct sdhci_arasan_clk_data, sdcardclk_hw);
@@ -651,14 +659,14 @@ static const struct clk_ops zynqmp_sdcardclk_ops = {
 /**
  * sdhci_zynqmp_sampleclk_set_phase - Set the SD Input Clock Tap Delays
  *
+ * @hw:			Pointer to the hardware clock structure.
+ * @degrees:		The clock phase shift between 0 - 359.
+ *
  * Set the SD Input Clock Tap Delays for Input path
  *
- * @hw:			Pointer to the hardware clock structure.
- * @degrees		The clock phase shift between 0 - 359.
  * Return: 0 on success and error value on error
  */
 static int sdhci_zynqmp_sampleclk_set_phase(struct clk_hw *hw, int degrees)
-
 {
 	struct sdhci_arasan_clk_data *clk_data =
 		container_of(hw, struct sdhci_arasan_clk_data, sampleclk_hw);
@@ -723,10 +731,11 @@ static const struct clk_ops zynqmp_sampleclk_ops = {
 /**
  * sdhci_versal_sdcardclk_set_phase - Set the SD Output Clock Tap Delays
  *
+ * @hw:			Pointer to the hardware clock structure.
+ * @degrees:		The clock phase shift between 0 - 359.
+ *
  * Set the SD Output Clock Tap Delays for Output path
  *
- * @hw:			Pointer to the hardware clock structure.
- * @degrees		The clock phase shift between 0 - 359.
  * Return: 0 on success and error value on error
  */
 static int sdhci_versal_sdcardclk_set_phase(struct clk_hw *hw, int degrees)
@@ -794,10 +803,11 @@ static const struct clk_ops versal_sdcardclk_ops = {
 /**
  * sdhci_versal_sampleclk_set_phase - Set the SD Input Clock Tap Delays
  *
+ * @hw:			Pointer to the hardware clock structure.
+ * @degrees:		The clock phase shift between 0 - 359.
+ *
  * Set the SD Input Clock Tap Delays for Input path
  *
- * @hw:			Pointer to the hardware clock structure.
- * @degrees		The clock phase shift between 0 - 359.
  * Return: 0 on success and error value on error
  */
 static int sdhci_versal_sampleclk_set_phase(struct clk_hw *hw, int degrees)
@@ -913,6 +923,9 @@ static int arasan_zynqmp_execute_tuning(struct mmc_host *mmc, u32 opcode)
 /**
  * sdhci_arasan_update_clockmultiplier - Set corecfg_clockmultiplier
  *
+ * @host:		The sdhci_host
+ * @value:		The value to write
+ *
  * The corecfg_clockmultiplier is supposed to contain clock multiplier
  * value of programmable clock generator.
  *
@@ -924,8 +937,6 @@ static int arasan_zynqmp_execute_tuning(struct mmc_host *mmc, u32 opcode)
  * - The value of corecfg_clockmultiplier should sync with that of corresponding
  *   value reading from sdhci_capability_register. So this function is called
  *   once at probe time and never called again.
- *
- * @host:		The sdhci_host
  */
 static void sdhci_arasan_update_clockmultiplier(struct sdhci_host *host,
 						u32 value)
@@ -952,6 +963,8 @@ static void sdhci_arasan_update_clockmultiplier(struct sdhci_host *host,
 /**
  * sdhci_arasan_update_baseclkfreq - Set corecfg_baseclkfreq
  *
+ * @host:		The sdhci_host
+ *
  * The corecfg_baseclkfreq is supposed to contain the MHz of clk_xin.  This
  * function can be used to make that happen.
  *
@@ -963,8 +976,6 @@ static void sdhci_arasan_update_clockmultiplier(struct sdhci_host *host,
  * - It's assumed that clk_xin is not dynamic and that we use the SDHCI divider
  *   to achieve lower clock rates.  That means that this function is called once
  *   at probe time and never called again.
- *
- * @host:		The sdhci_host
  */
 static void sdhci_arasan_update_baseclkfreq(struct sdhci_host *host)
 {
@@ -1028,10 +1039,10 @@ static void arasan_dt_read_clk_phase(struct device *dev,
 /**
  * arasan_dt_parse_clk_phases - Read Clock Delay values from DT
  *
- * Called at initialization to parse the values of Clock Delays.
- *
  * @dev:		Pointer to our struct device.
  * @clk_data:		Pointer to the Clock Data structure
+ *
+ * Called at initialization to parse the values of Clock Delays.
  */
 static void arasan_dt_parse_clk_phases(struct device *dev,
 				       struct sdhci_arasan_clk_data *clk_data)
@@ -1202,14 +1213,15 @@ MODULE_DEVICE_TABLE(of, sdhci_arasan_of_match);
 /**
  * sdhci_arasan_register_sdcardclk - Register the sdcardclk for a PHY to use
  *
+ * @sdhci_arasan:	Our private data structure.
+ * @clk_xin:		Pointer to the functional clock
+ * @dev:		Pointer to our struct device.
+ *
  * Some PHY devices need to know what the actual card clock is.  In order for
  * them to find out, we'll provide a clock through the common clock framework
  * for them to query.
  *
- * @sdhci_arasan:	Our private data structure.
- * @clk_xin:		Pointer to the functional clock
- * @dev:		Pointer to our struct device.
- * Returns 0 on success and error value on error
+ * Return: 0 on success and error value on error
  */
 static int
 sdhci_arasan_register_sdcardclk(struct sdhci_arasan_data *sdhci_arasan,
@@ -1251,14 +1263,15 @@ sdhci_arasan_register_sdcardclk(struct sdhci_arasan_data *sdhci_arasan,
 /**
  * sdhci_arasan_register_sampleclk - Register the sampleclk for a PHY to use
  *
+ * @sdhci_arasan:	Our private data structure.
+ * @clk_xin:		Pointer to the functional clock
+ * @dev:		Pointer to our struct device.
+ *
  * Some PHY devices need to know what the actual card clock is.  In order for
  * them to find out, we'll provide a clock through the common clock framework
  * for them to query.
  *
- * @sdhci_arasan:	Our private data structure.
- * @clk_xin:		Pointer to the functional clock
- * @dev:		Pointer to our struct device.
- * Returns 0 on success and error value on error
+ * Return: 0 on success and error value on error
  */
 static int
 sdhci_arasan_register_sampleclk(struct sdhci_arasan_data *sdhci_arasan,
@@ -1300,10 +1313,10 @@ sdhci_arasan_register_sampleclk(struct sdhci_arasan_data *sdhci_arasan,
 /**
  * sdhci_arasan_unregister_sdclk - Undoes sdhci_arasan_register_sdclk()
  *
+ * @dev:		Pointer to our struct device.
+ *
  * Should be called any time we're exiting and sdhci_arasan_register_sdclk()
  * returned success.
- *
- * @dev:		Pointer to our struct device.
  */
 static void sdhci_arasan_unregister_sdclk(struct device *dev)
 {
@@ -1318,6 +1331,10 @@ static void sdhci_arasan_unregister_sdclk(struct device *dev)
 /**
  * sdhci_arasan_register_sdclk - Register the sdcardclk for a PHY to use
  *
+ * @sdhci_arasan:	Our private data structure.
+ * @clk_xin:		Pointer to the functional clock
+ * @dev:		Pointer to our struct device.
+ *
  * Some PHY devices need to know what the actual card clock is.  In order for
  * them to find out, we'll provide a clock through the common clock framework
  * for them to query.
@@ -1330,10 +1347,7 @@ static void sdhci_arasan_unregister_sdclk(struct device *dev)
  * to create nice clean device tree bindings and later (if needed) we can try
  * re-architecting SDHCI if we see some benefit to it.
  *
- * @sdhci_arasan:	Our private data structure.
- * @clk_xin:		Pointer to the functional clock
- * @dev:		Pointer to our struct device.
- * Returns 0 on success and error value on error
+ * Return: 0 on success and error value on error
  */
 static int sdhci_arasan_register_sdclk(struct sdhci_arasan_data *sdhci_arasan,
 				       struct clk *clk_xin,
-- 
2.17.1

