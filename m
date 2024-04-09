Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D35B55E55
	for <linux-mmc@vger.kernel.org>; Tue,  9 Apr 2024 10:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712659042; cv=none; b=psMp13XkaMP4Nu/+oAFpYR7cJs18Jph+OFFWsrnoILxdbRqf1Tnp/eGA4q/Zf5+hd/gYgdSChmFkXVGy34lYlcPP0X1AdF9O8Vrx7HWZAl+LLqTiy1J/VSYkGyoH7AWB0qultBz+flWVeUF/TkIOl0e/iki1UeA48pj4wAiUS00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712659042; c=relaxed/simple;
	bh=Ke9bTOQSP1jqhM7tYmyiExbpDzCgiAxCwnuBEFwvVcs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RE0PLgs3oZJobW2YS6hS0OEizEXwbqtTXO4qTTw4DqVHgTmufUr5P4N/sCrSHR1PKdLv3XLw5lGNGMzOxi7ounPiGH5esbOQxdjmtWt0QLGqcRRcT8EIb1+3wexcNi2va+pcCk4Wa/W367Go+YVELAW12CrV52GzD42ehXTpTBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mWL22Jn4; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mWL22Jn4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712659040; x=1744195040;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Ke9bTOQSP1jqhM7tYmyiExbpDzCgiAxCwnuBEFwvVcs=;
  b=mWL22Jn4arUkCHMh88Kz5vcSry89aR02bTap6vDXaXPVhU6OEnrjH18q
   caq32EwZ5Hs0Eh878wWWYWCEmFBlnuyAO4nCodC6pSZfdYPJUWSjj81Yr
   9C49do5iy4mqxn13onQpDpW4FZbkeEQ8LlKz1fsuVfHqi7Y9/B8YVYLZ9
   nlNPG/P6cBSOf9zsfKiAvW7d6zXuBTxNumKy6vTTbl6eyTJcHM91Q3qfl
   kyIPf3ci2klRhAruAIqY8/BU2XTEF7h/xOQOA+0PQc+HI1XIQMVe2Lj0A
   ISdbbKWzic28KR9vi4zJO2bfvrYW8OkWrzj6pIWbhCAzIyAIoMDOxQLI2
   g==;
X-CSE-ConnectionGUID: /q2yjUpwS9K1kePYQNc4sg==
X-CSE-MsgGUID: eMLRXeYjSkG93NkuAUnMHQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="11743402"
X-IronPort-AV: E=Sophos;i="6.07,189,1708416000"; 
   d="scan'208";a="11743402"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 03:37:20 -0700
X-CSE-ConnectionGUID: xq+V4yW+RNKqRHwjZWFBpw==
X-CSE-MsgGUID: aTZ5mbUnQmmieyHt566kgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,189,1708416000"; 
   d="scan'208";a="20629266"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.249.37.26])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 03:37:18 -0700
Message-ID: <199bb4aa-c6b5-453e-be37-58bbf468800c@intel.com>
Date: Tue, 9 Apr 2024 13:37:11 +0300
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/6] mmc: sdhci-acpi: Disable UHS/1.8V modes on Lenovo
 Yoga Tablet 2 series sdcard slot
To: Hans de Goede <hdegoede@redhat.com>
Cc: linux-mmc@vger.kernel.org,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Ulf Hansson <ulf.hansson@linaro.org>, Andy Shevchenko <andy@kernel.org>
References: <20240408195244.248280-1-hdegoede@redhat.com>
 <20240408195244.248280-5-hdegoede@redhat.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20240408195244.248280-5-hdegoede@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/04/24 22:52, Hans de Goede wrote:
> Unlike all other Bay Trail devices I have (quite a few) the BIOS on
> the Lenovo Yoga Tablet 2 830 / 1050 and Lenovo Yoga Tablet 2 Pro 1380 (8",
> 10" and 13") models sets the SDHCI_SUPPORT_DDR50 bit in the sdcard slots'
> SDHCI controller's Caps_1 register which causes Linux to try and use
> UHS SDR12 / SDR25 and DDR50 modes on UHS cards.
> 
> These tablets do have 1.8V signalling implemented in the hw level through
> the Bay Trail SoC's SD3_1P8EN pin. But trying to use UHS modes leads to
> lots of errors like these:
> 
> [  225.272001] mmc2: Unexpected interrupt 0x04000000.
> [  225.272024] mmc2: sdhci: ============ SDHCI REGISTER DUMP ===========
> [  225.272034] mmc2: sdhci: Sys addr:  0x0712c400 | Version:  0x0000b502
> [  225.272044] mmc2: sdhci: Blk size:  0x00007200 | Blk cnt:  0x00000007
> [  225.272054] mmc2: sdhci: Argument:  0x00000000 | Trn mode: 0x00000023
> [  225.272064] mmc2: sdhci: Present:   0x01e20002 | Host ctl: 0x00000016
> [  225.272073] mmc2: sdhci: Power:     0x0000000f | Blk gap:  0x00000000
> [  225.272082] mmc2: sdhci: Wake-up:   0x00000000 | Clock:    0x00000107
> [  225.272092] mmc2: sdhci: Timeout:   0x0000000e | Int stat: 0x00000001
> [  225.272101] mmc2: sdhci: Int enab:  0x03ff000b | Sig enab: 0x03ff000b
> [  225.272110] mmc2: sdhci: ACmd stat: 0x00000000 | Slot int: 0x00000001
> [  225.272119] mmc2: sdhci: Caps:      0x076864b2 | Caps_1:   0x00000004
> [  225.272129] mmc2: sdhci: Cmd:       0x00000c1b | Max curr: 0x00000000
> [  225.272138] mmc2: sdhci: Resp[0]:   0x00000c00 | Resp[1]:  0x00000000
> [  225.272147] mmc2: sdhci: Resp[2]:   0x00000000 | Resp[3]:  0x00000900
> [  225.272155] mmc2: sdhci: Host ctl2: 0x0000000c
> [  225.272164] mmc2: sdhci: ADMA Err:  0x00000003 | ADMA Ptr: 0x0712c200
> [  225.272172] mmc2: sdhci: ============================================
> 

0x04000000 is so-called "Tuning Error" which oddly the SDHCI driver
does not support / enable.

Could try making the IRQ handler process it and see if that helps:


diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index c79f73459915..746f4cf7ab03 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -3439,12 +3439,18 @@ static void sdhci_data_irq(struct sdhci_host *host, u32 intmask)
 		host->data->error = -EILSEQ;
 		if (!mmc_op_tuning(SDHCI_GET_CMD(sdhci_readw(host, SDHCI_COMMAND))))
 			sdhci_err_stats_inc(host, DAT_CRC);
-	} else if ((intmask & SDHCI_INT_DATA_CRC) &&
+	} else if ((intmask & (SDHCI_INT_DATA_CRC | SDHCI_INT_TUNING_ERROR)) &&
 		SDHCI_GET_CMD(sdhci_readw(host, SDHCI_COMMAND))
 			!= MMC_BUS_TEST_R) {
 		host->data->error = -EILSEQ;
 		if (!mmc_op_tuning(SDHCI_GET_CMD(sdhci_readw(host, SDHCI_COMMAND))))
 			sdhci_err_stats_inc(host, DAT_CRC);
+		if (intmask & SDHCI_INT_TUNING_ERROR) {
+			u16 ctrl2 = sdhci_readw(host, SDHCI_HOST_CONTROL2);
+
+			ctrl2 &= ~SDHCI_CTRL_TUNED_CLK;
+			sdhci_writew(host, ctrl2, SDHCI_HOST_CONTROL2);
+		}
 	} else if (intmask & SDHCI_INT_ADMA_ERROR) {
 		pr_err("%s: ADMA error: 0x%08x\n", mmc_hostname(host->mmc),
 		       intmask);
@@ -3979,7 +3985,7 @@ bool sdhci_cqe_irq(struct sdhci_host *host, u32 intmask, int *cmd_error,
 	} else
 		*cmd_error = 0;
 
-	if (intmask & (SDHCI_INT_DATA_END_BIT | SDHCI_INT_DATA_CRC)) {
+	if (intmask & (SDHCI_INT_DATA_END_BIT | SDHCI_INT_DATA_CRC | SDHCI_INT_TUNING_ERROR)) {
 		*data_error = -EILSEQ;
 		if (!mmc_op_tuning(SDHCI_GET_CMD(sdhci_readw(host, SDHCI_COMMAND))))
 			sdhci_err_stats_inc(host, DAT_CRC);
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index a20864fc0641..957c7a917ffb 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -158,6 +158,7 @@
 #define  SDHCI_INT_BUS_POWER	0x00800000
 #define  SDHCI_INT_AUTO_CMD_ERR	0x01000000
 #define  SDHCI_INT_ADMA_ERROR	0x02000000
+#define  SDHCI_INT_TUNING_ERROR	0x04000000
 
 #define  SDHCI_INT_NORMAL_MASK	0x00007FFF
 #define  SDHCI_INT_ERROR_MASK	0xFFFF8000
@@ -169,7 +170,7 @@
 		SDHCI_INT_DATA_AVAIL | SDHCI_INT_SPACE_AVAIL | \
 		SDHCI_INT_DATA_TIMEOUT | SDHCI_INT_DATA_CRC | \
 		SDHCI_INT_DATA_END_BIT | SDHCI_INT_ADMA_ERROR | \
-		SDHCI_INT_BLK_GAP)
+		SDHCI_INT_BLK_GAP | SDHCI_INT_TUNING_ERROR)
 #define SDHCI_INT_ALL_MASK	((unsigned int)-1)
 
 #define SDHCI_CQE_INT_ERR_MASK ( \


