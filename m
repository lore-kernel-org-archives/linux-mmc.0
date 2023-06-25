Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DC07EB64DC
	for <linux-mmc@archiver.kernel.org>; Sun, 25 Jun 2023 10:39:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231213AbjFYKjM (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 25 Jun 2023 06:39:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231389AbjFYKjK (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 25 Jun 2023 06:39:10 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECAC9E45
        for <linux-mmc@vger.kernel.org>; Sun, 25 Jun 2023 03:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1687689532; x=1719225532;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ShbTF5dHVyImpmx9MkyIpFezNqlNxYrjX59ePKZRqrY=;
  b=gacloTP2etHGIgu6yCc3grnSo8wvQ6E1k4Y6II6Gp5zuWjykfnW3vhBw
   BeYh21TLCmH/k7Q3aArE9+wrKwh32Bs2jePw13xGiVf0bnQyLUYyi3x+I
   W15g0btwbTl02A0iS6JHt00tr8eX0J444AkK7gN7/9yDm621bmRxLKqbK
   ykLXoEWVUDeCpCeP52aeu0h5Yn/vihrFBiA+w/8+Qto+cVQ+kiuQrm6Aw
   55RIwSpAQa5fxptm5owN0H8O1/Nc+VkB0P6jLLfXe9itMIRwGSwZ5wWBF
   GPIv9U6PeJx31ZM/hZ6vg02k8SH4d3lA9zVDC9laEoRkB7rsoKfAhLb4l
   g==;
X-IronPort-AV: E=Sophos;i="6.01,157,1684771200"; 
   d="scan'208";a="234861676"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 25 Jun 2023 18:38:52 +0800
IronPort-SDR: dq0bnib1Iyni+Fa5wGyOCUasl8E/EEsc6Ze9+W5JrI+wZsawhYeTleKMVlg5wK6PQMIcEa2OdV
 qRRHX03ratMo+/zvoEHe7tP5rkt2Mf0SeZ/8N655+ikC4S/zcLY9YZpXRiw3CpVcsJxv0hZvpG
 kZaJokMe1EbLKql1ivlIA0Z7V9LEBlIjPT8cuyk9yMdskZfFL7514a8tSvaDNMfjoFr8qnB+8v
 uH/iRrzV1Q7JubP67INJLyVwmSm7IuBJUsDO4dGotIagu2k63v6FXTLFksZjH39wrSNGEnFqan
 cy4=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Jun 2023 02:47:33 -0700
IronPort-SDR: hVv1vTsNogxcXPYRfuCBaoh1BWCh035BnABpRVKc4JjH2g7qbPkEcTluRSCPhLTeSR+7SHe6h8
 LhspKPQ7SfmNkEoAlLp7wHC1eP7+OocZiNtSwAEgashB+akiQl1uKwSPp24qv/8/sS4BvU6bWD
 AJa6RoiohHLpxRmUu7tMIcqmyN+Btlp8pTaLFYKuaGJTuW8Xg6Cpl10V9r+JvFy8GnSPIeFerB
 7OBmoh9Btj9gHkt1aSzOC7mhzKF94DmV7D/3J2FOi3deGlT2ZfUfr6whyc90q7tihfigBHNYCM
 hzM=
WDCIronportException: Internal
Received: from bxygm33.ad.shared ([10.45.31.229])
  by uls-op-cesaip01.wdc.com with ESMTP; 25 Jun 2023 03:38:52 -0700
From:   Avri Altman <avri.altman@wdc.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Cc:     Avri Altman <avri.altman@wdc.com>
Subject: [PATCH 3/6] mmc-utils: ffu: Simplify ext_csd bytes parsing
Date:   Sun, 25 Jun 2023 13:38:11 +0300
Message-Id: <20230625103814.105-4-avri.altman@wdc.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230625103814.105-1-avri.altman@wdc.com>
References: <20230625103814.105-1-avri.altman@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The ext_csd register has this habbit of linking a contiguous set of
bytes into one meaningful double-word.  It does that where the least
significant value is in the lower index - hence little-endian.

Signed-off-by: Avri Altman <avri.altman@wdc.com>
---
 mmc_cmds.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/mmc_cmds.c b/mmc_cmds.c
index 8650c2f..adb72af 100644
--- a/mmc_cmds.c
+++ b/mmc_cmds.c
@@ -2880,10 +2880,7 @@ int do_ffu(int nargs, char **argv)
 	}
 
 	/* set CMD ARG */
-	arg = ext_csd[EXT_CSD_FFU_ARG_0] |
-		ext_csd[EXT_CSD_FFU_ARG_1] << 8 |
-		ext_csd[EXT_CSD_FFU_ARG_2] << 16 |
-		ext_csd[EXT_CSD_FFU_ARG_3] << 24;
+	arg = htole32(*((__u32 *)&ext_csd[EXT_CSD_FFU_ARG_0]));
 
 	/* prepare multi_cmd for FFU based on cmd to be used */
 
@@ -2952,10 +2949,7 @@ do_retry:
 	}
 
 	/* Test if we need to restart the download */
-	sect_done = ext_csd[EXT_CSD_NUM_OF_FW_SEC_PROG_0] |
-			ext_csd[EXT_CSD_NUM_OF_FW_SEC_PROG_1] << 8 |
-			ext_csd[EXT_CSD_NUM_OF_FW_SEC_PROG_2] << 16 |
-			ext_csd[EXT_CSD_NUM_OF_FW_SEC_PROG_3] << 24;
+	sect_done = htole32(*((__u32 *)&ext_csd[EXT_CSD_NUM_OF_FW_SEC_PROG_0]));
 	/* By spec, host should re-start download from the first sector if sect_done is 0 */
 	if (sect_done == 0) {
 		if (retry--) {
-- 
2.40.1

