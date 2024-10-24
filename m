Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0E31A76AC;
	Thu, 24 Oct 2024 08:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729759924; cv=none; b=nBSQli6TbHJzut4Waw+wT6w5inlNB/OMSZWQ5y1TZj2GcE8XM06HtMngCFQ22rDrWliVy5vjv52TTsJrfrJGKazWYBoKM3P2ylIomKdVDWo5ZNueJ0KSEHVTdJOP7/1krtxPKLB/wGcnDHsPs7e2CQkB4fBS+S1Zj1MKPRVzbuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729759924; c=relaxed/simple;
	bh=hSB7ki9TCv25gEGRioPxfqiFePl7Oi/9o5aj1Euzkrs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kDcD/PDu1Ch8mtB0GBrGy65fXEuEH3nHfcPUHSRjnhINejfP5PTkckLgQVp14LZElTrjcJ9TFUfkI7DMIRXJsj+C8/1FAD+sdBRaoBZMxZu/VOessx3SPrd2vXy7kgOFySdsAi3Q/tUixgNeYGLU2hUEEQDO4DGjurjhyaJrwys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g9gjzmve; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g9gjzmve"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729759922; x=1761295922;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=hSB7ki9TCv25gEGRioPxfqiFePl7Oi/9o5aj1Euzkrs=;
  b=g9gjzmve/+OszGrozU4dxWcm6XuQl9HiW7REmQuus0AHf39DKmawao9C
   kXEzVx5495ZFfSs4Qo0dayeXJtd1VUqmcCa/qeGIsZY7RleeHK0AOA5ot
   r1EcC7IOgEebthng+bFNYYIe7ZM7aQrElokaNGffSBnrJRT6Gh5x/QS/k
   sjcNPHlGG2Bx7VV8oZWL36REA+3E0iU6ZmoF8vPhW50kWWyNfgPjK+taJ
   gynAiAkDY4LcYeKAH/RSGQ+mM56aJrCEyOs3+nWfRYo9yfkED7aC+FyaW
   ClgMBEsEcgA3ugQ16ikQkhaclqxX2lIzPmN/15RkJLQ8BVava09nrRvZi
   Q==;
X-CSE-ConnectionGUID: xtjVZoSNSRimd/qiz6ZoyA==
X-CSE-MsgGUID: UCoe1PHDShGEDMPX60DKDA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="29244044"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="29244044"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 01:52:01 -0700
X-CSE-ConnectionGUID: ZAiubq5eRbeJn35ZDyTAxg==
X-CSE-MsgGUID: lskRkljnSluJE2b6bfaR7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,228,1725346800"; 
   d="scan'208";a="80950434"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.246.16.81])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 01:51:57 -0700
Message-ID: <80c10cb0-20d8-4b36-93ec-1b2e4bd660ff@intel.com>
Date: Thu, 24 Oct 2024 11:51:53 +0300
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V23 00/16] Add support UHS-II for GL9755 and GL9767
To: Victor Shih <victorshihgli@gmail.com>, ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
 benchuanggli@gmail.com, Lucas.Lai@genesyslogic.com.tw,
 HL.Liu@genesyslogic.com.tw, Greg.tu@genesyslogic.com.tw,
 dlunev@chromium.org, Victor Shih <victor.shih@genesyslogic.com.tw>
References: <20241018105333.4569-1-victorshihgli@gmail.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20241018105333.4569-1-victorshihgli@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 18/10/24 13:53, Victor Shih wrote:
> From: Victor Shih <victor.shih@genesyslogic.com.tw>
> 
> Summary
> =======
> These patches[1] support UHS-II and fix GL9755 and GL9767
> UHS-II compatibility.
> 
> About UHS-II, roughly deal with the following three parts:
> 1) A UHS-II detection and initialization:
> - Host setup to support UHS-II (Section 3.13.1 Host Controller Setup
>   Sequence[2]).
> - Detect a UHS-II I/F (Section 3.13.2 Card Interface Detection Sequence
>   [2]).
> - In step(9) of Section 3.13.2 in [2], UHS-II initialization is include
>   Section 3.13.3 UHS-II Card Initialization and Section 3.13.4 UHS-II
>   Setting Register Setup Sequence.
> 
> 2) Send Legacy SD command through SD-TRAN
> - Encapsulated SD packets are defined in SD-TRAN in order to ensure Legacy
>   SD compatibility and preserve Legacy SD infrastructures (Section 7.1.1
>   Packet Types and Format Overview[3]).
> - Host issue a UHS-II CCMD packet or a UHS-II DCMD (Section 3.13.5 UHS-II
>   CCMD Packet issuing and Section 3.13.6 UHS-II DCMD Packet issuing[2]).
> 
> 3) UHS-II Interrupt
> - Except for UHS-II error interrupts, most interrupts share the original
>   interrupt registers.
> 
> Patch structure
> ===============
> patch#1:     for core
> patch#2-#14: for sdhci
> patch#15:    for GL9755
> patch#16:    for GL9767
> 
> Tests
> =====
> Ran 'dd' command to evaluate the performance 3 times:
> (SanDisk UHS-II card on GL9755 controller)
>                              Read    Write
> UHS-II disabled (UHS-I): 81.9MB/s 51.4MB/s
> UHS-II enabled         :  206MB/s 80.5MB/s
>                              Read    Write
> UHS-II disabled (UHS-I): 82.3MB/s 49.7MB/s
> UHS-II enabled         :  208MB/s 80.8MB/s
>                              Read    Write
> UHS-II disabled (UHS-I): 82.9MB/s 50.8MB/s
> UHS-II enabled         :  205MB/s 90.0MB/s
> (SanDisk UHS-II card on GL9767 controller)
>                              Read    Write
> UHS-II disabled (UHS-I): 83.5MB/s 50.5MB/s
> UHS-II enabled         :  200MB/s 75.3MB/s
>                              Read    Write
> UHS-II disabled (UHS-I): 85.2MB/s 56.3MB/s
> UHS-II enabled         :  203MB/s 75.8MB/s
>                              Read    Write
> UHS-II disabled (UHS-I): 82.9MB/s 51.1MB/s
> UHS-II enabled         :  196MB/s 77.8MB/s
> 
> Test command
> =====
> Read: dd if=/dev/mmcxxx of=/dev/null bs=4096k count=2000 iflag=direct
> Write:dd if=/dev/zero of=/dev/mmcxxx bs=4096k count=2000 oflag=direct
> 
> Changes in v23 (October. 18, 2024)
> * Rebase on latest mmc/next.
> * Version 22 patch#1-patch#6 have already been applied to the mmc/next
>   branch, so the patch order for version 23 has been shifted forward.
> * Patch#1: Remove mmc_uhs2_card_prepare_cmd() function.
>            Remove mmc_sd_can_poweroff_notify() function.
>            Modify ios.timing setting in the sd_uhs2_power_off() function.
>            Restore the position of assign the host->card to original
>            position in the sd_uhs2_init_card() function.
>            Remove unnecessary error handle in the sd_uhs2_init_card()
>            function.
>            Add oldcard judgment to skip some programs in the
>            sd_uhs2_legacy_init() function.
>            Remove unnecessary error handle in the sd_uhs2_legacy_init()
>            function.
>            Remove mmc_card_set_present() function in the
>            sd_uhs2_reinit()function.
> 
> Reference
> =========
> [1] https://gitlab.com/VictorShih/linux-uhs2.git
> [2] SD Host Controller Simplified Specification 4.20
> [3] UHS-II Simplified Addendum 1.02
> [4] https://patchwork.kernel.org/project/linux-mmc/cover/20240913102836.6144-1-victorshihgli@gmail.com/

Not all SDHCI patches show my Acked-by although I did give it
in V22 for SDHCI patches.  So again for SDHCI:

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

Ulf mentioned checkpatch warnings.  Here is a summary:

  ---------------------------------------------------------------------------------------
  heads/head-2024-10-24-01/0002-mmc-sdhci-add-UHS-II-related-definitions-in-headers.patch
  ---------------------------------------------------------------------------------------
  WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
  #20: 
  new file mode 100644

Nope - already covered by drivers/mmc/host/sdhci*

  WARNING: It's generally not useful to have the filename in the file
  #27: FILE: drivers/mmc/host/sdhci-uhs2.h:3:
  + *  linux/drivers/mmc/host/sdhci-uhs2.h - Secure Digital Host Controller Interface driver

Could drop the file name

  ----------------------------------------------------------------------------------------
  heads/head-2024-10-24-01/0003-mmc-sdhci-add-UHS-II-module-and-add-a-kernel-configu.patch
  ----------------------------------------------------------------------------------------
  WARNING: please write a help paragraph that fully describes the config symbol
  #33: FILE: drivers/mmc/host/Kconfig:101:
  +config MMC_SDHCI_UHS2
  +	tristate "UHS2 support on SDHCI controller"
  +	depends on MMC_SDHCI
  +	help
  +	  This option is selected by SDHCI controller drivers that want to
  +	  support UHS2-capable devices.
  +
  +	  If you have a controller with this feature, say Y or M here.
  +

A web-search for uhs2 says what it is, so I have no strong feelings
about adding more.

  WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
  #58: 
  new file mode 100644

Nope - already covered by drivers/mmc/host/sdhci*

  ----------------------------------------------------------------------------------------
  heads/head-2024-10-24-01/0010-mmc-sdhci-uhs2-add-related-functions-to-initialize-t.patch
  ----------------------------------------------------------------------------------------
  WARNING: Prefer a maximum 75 chars per line (possible unwrapped commit description?)
  #11: 
  After detected the UHS-II interface, the host's UHS-II capabilities will be set up here and

Commit message could be wrapped as requested

There is also the ones below, but please _leave_ the code as it is
consistent with the current code in the struct.

------------------------------------------------------------------------------
heads/head-2024-10-24-01/0014-mmc-sdhci-pci-add-UHS-II-support-framework.patch
------------------------------------------------------------------------------
WARNING: Unnecessary space before function pointer arguments
#81: FILE: drivers/mmc/host/sdhci-pci.h:148:
+	void			(*remove_host) (struct sdhci_pci_slot *, int);
WARNING: function definition argument 'struct sdhci_pci_slot *' should also have an identifier name
#81: FILE: drivers/mmc/host/sdhci-pci.h:148:
+	void			(*remove_host) (struct sdhci_pci_slot *, int);
WARNING: function definition argument 'int' should also have an identifier name
#81: FILE: drivers/mmc/host/sdhci-pci.h:148:
+	void			(*remove_host) (struct sdhci_pci_slot *, int);
total: 0 errors, 3 warnings, 0 checks, 56 lines checked

