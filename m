Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 055231E511;
	Wed, 30 Oct 2024 13:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730293685; cv=none; b=oB+Vh5eYkwTMsUq8k+y+kF8ZZy0DYvFBEc2kQebYSD2SQA+yp0S5dUtPVMphd16de9dBe9cuRQIuhhZU204AP7gadFzYUglszOmogMJT/KR1op/Cg/srRGv3wQ9YePT7BT72o1g1Ueu7gqXYKWkldKtAi8Vj67heFY77QT/wN4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730293685; c=relaxed/simple;
	bh=7Lrc/fy7ZXOMgQzQpHhKCI6qIWzKi7tusGok4VtyO08=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aYtnlm6C6vSCIxc4nxMSIZnjiTKgq1XcM137Fza2dIEuR6RotNWKKePrkKPx0st9+fw1of2WsHCTXEAla3kC6FovGuu8kGl7NBJIyphlVa+lTlANLq6P7U7Mi1H5LpcwcXZBRwpMuJlIPX23EBfl90DNgv8pV26mdLV8HE2Vo5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CTXdoO3m; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CTXdoO3m"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730293684; x=1761829684;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=7Lrc/fy7ZXOMgQzQpHhKCI6qIWzKi7tusGok4VtyO08=;
  b=CTXdoO3mTx5TaWufufTAPyLwcUv2ADEz13Y/hM4cUNS59R3yfzXERjVV
   nR0y3tv4akFCfBBmtn4B5otbZ393kF57UtCwXReqEx23xuWaoEs0Jvf46
   3JALvnWnLSbwlJZe/2jJgTMuhEJ6OzkqzMJDAVqMenmbthsASwYSJDLsp
   sJibPxAVr097tgNSOafh5r6/EdCALj8OwTxCMRbhvA1Gp50KnMNW4XAH5
   NLv/wF59DLnpOeUyn5BEwHQzxA46RxqfU+YcORfSU68cOUaz5k5QKs2J+
   6qHGbwSV5SJA7BQ5XQ0vT1BTbxET+aprkK+zJ9o5beB0mBNHlmiudS3k1
   g==;
X-CSE-ConnectionGUID: Qd6uvWacTqaD8otKC+aJ9Q==
X-CSE-MsgGUID: ZTaDvmX3QFytT4Ijs9cpnw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30141466"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="30141466"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2024 06:08:03 -0700
X-CSE-ConnectionGUID: HKyTL5tIQOaD0l1o3iLJOg==
X-CSE-MsgGUID: HX6+MiorShOHynQwC/+6vQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,245,1725346800"; 
   d="scan'208";a="83120769"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.245.115.59])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2024 06:07:59 -0700
Message-ID: <ece430b5-fa6b-4ad0-adfd-73778bae539b@intel.com>
Date: Wed, 30 Oct 2024 15:07:52 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1] mmc: sdhci-uhs2: correction of incorrect type in
 argument
To: Victor Shih <victorshihgli@gmail.com>, ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
 benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
 Greg.tu@genesyslogic.com.tw, kernel test robot <lkp@intel.com>,
 Ben Chuang <ben.chuang@genesyslogic.com.tw>,
 Victor Shih <victor.shih@genesyslogic.com.tw>
References: <20241030112216.4057-1-victorshihgli@gmail.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20241030112216.4057-1-victorshihgli@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 30/10/24 13:22, Victor Shih wrote:
> From: Victor Shih <victor.shih@genesyslogic.com.tw>
> 
> There is a type issue in the argument in the __sdhci_uhs2_send_command()
> that will generate a warning when building the kernel.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202410260525.ZUuPhMJz-lkp@intel.com/
> Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
> ---
>  drivers/mmc/host/sdhci-uhs2.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
> index 43820eb5a7ea..7f41ca67b069 100644
> --- a/drivers/mmc/host/sdhci-uhs2.c
> +++ b/drivers/mmc/host/sdhci-uhs2.c
> @@ -649,7 +649,8 @@ static void __sdhci_uhs2_send_command(struct sdhci_host *host, struct mmc_comman
>  	 * MSB when preparing config read/write commands.
>  	 */
>  	for (j = 0; j < cmd->uhs2_cmd->payload_len / sizeof(u32); j++) {
> -		sdhci_writel(host, *(cmd->uhs2_cmd->payload + j), SDHCI_UHS2_CMD_PACKET + i);
> +		sdhci_writel(host, *(__force u32 *)(cmd->uhs2_cmd->payload + j),
> +			     SDHCI_UHS2_CMD_PACKET + i);
>  		i += 4;
>  	}
>  

Thanks for doing this.

I just noticed there is another issue that was reported but
did not get highlighted:

>> drivers/mmc/host/sdhci-uhs2.c:73:16: sparse: sparse: cast to restricted __be16

So the following is needed also:

diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
index 0a597240d299..c53b64d50c0d 100644
--- a/drivers/mmc/host/sdhci-uhs2.c
+++ b/drivers/mmc/host/sdhci-uhs2.c
@@ -70,7 +70,7 @@ EXPORT_SYMBOL_GPL(sdhci_uhs2_dump_regs);
 
 static inline u16 uhs2_dev_cmd(struct mmc_command *cmd)
 {
-	return be16_to_cpu((__be16)cmd->uhs2_cmd->arg) & UHS2_ARG_IOADR_MASK;
+	return be16_to_cpu((__force __be16)cmd->uhs2_cmd->arg) & UHS2_ARG_IOADR_MASK;
 }
 
 static inline int mmc_opt_regulator_set_ocr(struct mmc_host *mmc,

