Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D2D3128B5
	for <linux-mmc@vger.kernel.org>; Mon, 22 Dec 2025 08:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766392566; cv=none; b=JExEwmIThWxZasHwWOrIha0xNQSHLKDTMx4lqUt/ISXEzwCIeTvp8J/Dcu0gJ/fAsuDr45uGmJI/RUZVzIKvUkxwFQSL+RErVlFYWkjhMZ9J0QdGvUXHl0s583mGlfTYQmRlWpv384ejvSH+nDCeSJxAt/HMVAiS10we246foRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766392566; c=relaxed/simple;
	bh=hvDRuZmbTdF/Rt8AVmkAZyf+9l5FWb88TjlJNH1Sq3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MTdHTJC6XqQ7CvXgtqpOMkIxk8pkjWtoCAOxO2LgswISUWH8LDRztb+A21H2LQlHlxep6SsE5d5wku0SdpXemS+kBeeYkCxpoMhNqGnYJu0//jJjc1BAGuI12bR1j2lPoPWJQ+AGRa3ZFhDf1lf722lGLXkuXthtSics15k4MJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B37oeYNm; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B37oeYNm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766392564; x=1797928564;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hvDRuZmbTdF/Rt8AVmkAZyf+9l5FWb88TjlJNH1Sq3M=;
  b=B37oeYNmIh0p/i1lt3Yudmpgvxbbihuuo0wYwwHKCZk6N8SI/yEDNdR9
   neMz8Ml93YYy+aYA7l25WVkPGcN2n2XHxKYHwNDNAWvRsCVFfPJYI+1jp
   kVRSsnC0b1J5b3RPGzBs85a4aQaAdnbZDvxGVszmWCX4eIoDJfEoWS+3g
   pbF4mho9IatFowOinpEpnXU2pTLvErnlAxSo9mJ/p5aT3OOIeYjoroSWE
   j24WL59JmeIkh0jcwNtDAWbo1jSJ++BbvTfuwd5zNWyrObQ6H9+w4T4bp
   WULnc+4MrAU1D9KyFLBTXLq373rIvHAtVA+zVLVWyDSY5372neN23clAR
   A==;
X-CSE-ConnectionGUID: ZMwDfH8qQxW0LOX6BShTHw==
X-CSE-MsgGUID: Qbur9RtATQGP9blAAUD4qQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11649"; a="72105797"
X-IronPort-AV: E=Sophos;i="6.21,167,1763452800"; 
   d="scan'208";a="72105797"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2025 00:36:03 -0800
X-CSE-ConnectionGUID: mgiWnzuBSBiIlAWNEicM7g==
X-CSE-MsgGUID: wNo7kAmjSsG4KCrS2GOJjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,167,1763452800"; 
   d="scan'208";a="204414207"
Received: from lkp-server02.sh.intel.com (HELO dd3453e2b682) ([10.239.97.151])
  by fmviesa004.fm.intel.com with ESMTP; 22 Dec 2025 00:36:01 -0800
Received: from kbuild by dd3453e2b682 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vXbOV-000000000HB-0hM2;
	Mon, 22 Dec 2025 08:35:57 +0000
Date: Mon, 22 Dec 2025 16:35:27 +0800
From: kernel test robot <lkp@intel.com>
To: Shawn Lin <shawn.lin@rock-chips.com>,
	Ulf Hansson <ulf.hansson@linaro.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-mmc@vger.kernel.org,
	Jaehoon Chung <jh80.chung@samsung.com>,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH 14/18] mmc: dw_mmc: Remove unused register access macros
Message-ID: <202512221658.5xzUTXFV-lkp@intel.com>
References: <1766066445-14144-15-git-send-email-shawn.lin@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1766066445-14144-15-git-send-email-shawn.lin@rock-chips.com>

Hi Shawn,

kernel test robot noticed the following build errors:

[auto build test ERROR on next-20251218]
[cannot apply to rockchip/for-next linus/master ulf-hansson-mmc-mirror/next v6.19-rc1 v6.18 v6.18-rc7 v6.19-rc2]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Shawn-Lin/mmc-dw_mmc-Check-return-value-of-dma_ops-init-in-resume/20251218-222945
base:   next-20251218
patch link:    https://lore.kernel.org/r/1766066445-14144-15-git-send-email-shawn.lin%40rock-chips.com
patch subject: [PATCH 14/18] mmc: dw_mmc: Remove unused register access macros
config: m68k-randconfig-r071-20251222 (https://download.01.org/0day-ci/archive/20251222/202512221658.5xzUTXFV-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 14.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251222/202512221658.5xzUTXFV-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202512221658.5xzUTXFV-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/mmc/host/dw_mmc.c:33:
   drivers/mmc/host/dw_mmc.c: In function 'dw_mci_push_data64':
>> drivers/mmc/host/dw_mmc.h:457:41: error: implicit declaration of function '__raw_writeq' [-Wimplicit-function-declaration]
     457 | #define mci_fifo_writeq(__value, __reg) __raw_writeq(__reg, __value)
         |                                         ^~~~~~~~~~~~
   drivers/mmc/host/dw_mmc.c:2370:25: note: in expansion of macro 'mci_fifo_writeq'
    2370 |                         mci_fifo_writeq(host->fifo_reg, host->part_buf);
         |                         ^~~~~~~~~~~~~~~
   drivers/mmc/host/dw_mmc.c: In function 'dw_mci_pull_data64':
>> drivers/mmc/host/dw_mmc.h:453:33: error: implicit declaration of function '__raw_readq' [-Wimplicit-function-declaration]
     453 | #define mci_fifo_readq(__reg)   __raw_readq(__reg)
         |                                 ^~~~~~~~~~~
   drivers/mmc/host/dw_mmc.c:2420:50: note: in expansion of macro 'mci_fifo_readq'
    2420 |                                 aligned_buf[i] = mci_fifo_readq(host->fifo_reg);
         |                                                  ^~~~~~~~~~~~~~


vim +/__raw_writeq +457 drivers/mmc/host/dw_mmc.h

f95f3850f7a9e1 Will Newton         2011-01-02  337  
f95f3850f7a9e1 Will Newton         2011-01-02  338  /* Control register defines */
f95f3850f7a9e1 Will Newton         2011-01-02  339  #define SDMMC_CTRL_USE_IDMAC		BIT(25)
f95f3850f7a9e1 Will Newton         2011-01-02  340  #define SDMMC_CTRL_CEATA_INT_EN		BIT(11)
f95f3850f7a9e1 Will Newton         2011-01-02  341  #define SDMMC_CTRL_SEND_AS_CCSD		BIT(10)
f95f3850f7a9e1 Will Newton         2011-01-02  342  #define SDMMC_CTRL_SEND_CCSD		BIT(9)
f95f3850f7a9e1 Will Newton         2011-01-02  343  #define SDMMC_CTRL_ABRT_READ_DATA	BIT(8)
f95f3850f7a9e1 Will Newton         2011-01-02  344  #define SDMMC_CTRL_SEND_IRQ_RESP	BIT(7)
f95f3850f7a9e1 Will Newton         2011-01-02  345  #define SDMMC_CTRL_READ_WAIT		BIT(6)
f95f3850f7a9e1 Will Newton         2011-01-02  346  #define SDMMC_CTRL_DMA_ENABLE		BIT(5)
f95f3850f7a9e1 Will Newton         2011-01-02  347  #define SDMMC_CTRL_INT_ENABLE		BIT(4)
f95f3850f7a9e1 Will Newton         2011-01-02  348  #define SDMMC_CTRL_DMA_RESET		BIT(2)
f95f3850f7a9e1 Will Newton         2011-01-02  349  #define SDMMC_CTRL_FIFO_RESET		BIT(1)
f95f3850f7a9e1 Will Newton         2011-01-02  350  #define SDMMC_CTRL_RESET		BIT(0)
f95f3850f7a9e1 Will Newton         2011-01-02  351  /* Clock Enable register defines */
f95f3850f7a9e1 Will Newton         2011-01-02  352  #define SDMMC_CLKEN_LOW_PWR		BIT(16)
f95f3850f7a9e1 Will Newton         2011-01-02  353  #define SDMMC_CLKEN_ENABLE		BIT(0)
f95f3850f7a9e1 Will Newton         2011-01-02  354  /* time-out register defines */
f95f3850f7a9e1 Will Newton         2011-01-02  355  #define SDMMC_TMOUT_DATA(n)		_SBF(8, (n))
f95f3850f7a9e1 Will Newton         2011-01-02  356  #define SDMMC_TMOUT_DATA_MSK		0xFFFFFF00
f95f3850f7a9e1 Will Newton         2011-01-02  357  #define SDMMC_TMOUT_RESP(n)		((n) & 0xFF)
f95f3850f7a9e1 Will Newton         2011-01-02  358  #define SDMMC_TMOUT_RESP_MSK		0xFF
f95f3850f7a9e1 Will Newton         2011-01-02  359  /* card-type register defines */
f95f3850f7a9e1 Will Newton         2011-01-02  360  #define SDMMC_CTYPE_8BIT		BIT(16)
f95f3850f7a9e1 Will Newton         2011-01-02  361  #define SDMMC_CTYPE_4BIT		BIT(0)
f95f3850f7a9e1 Will Newton         2011-01-02  362  #define SDMMC_CTYPE_1BIT		0
f95f3850f7a9e1 Will Newton         2011-01-02  363  /* Interrupt status & mask register defines */
1a5c8e1f4f09e6 Shashidhar Hiremath 2011-08-29  364  #define SDMMC_INT_SDIO(n)		BIT(16 + (n))
f95f3850f7a9e1 Will Newton         2011-01-02  365  #define SDMMC_INT_EBE			BIT(15)
f95f3850f7a9e1 Will Newton         2011-01-02  366  #define SDMMC_INT_ACD			BIT(14)
f95f3850f7a9e1 Will Newton         2011-01-02  367  #define SDMMC_INT_SBE			BIT(13)
f95f3850f7a9e1 Will Newton         2011-01-02  368  #define SDMMC_INT_HLE			BIT(12)
f95f3850f7a9e1 Will Newton         2011-01-02  369  #define SDMMC_INT_FRUN			BIT(11)
f95f3850f7a9e1 Will Newton         2011-01-02  370  #define SDMMC_INT_HTO			BIT(10)
0173055842cd1d Doug Anderson       2014-08-22  371  #define SDMMC_INT_VOLT_SWITCH		BIT(10) /* overloads bit 10! */
3f7eec62ecb7e3 Jaehoon Chung       2013-05-27  372  #define SDMMC_INT_DRTO			BIT(9)
f95f3850f7a9e1 Will Newton         2011-01-02  373  #define SDMMC_INT_RTO			BIT(8)
f95f3850f7a9e1 Will Newton         2011-01-02  374  #define SDMMC_INT_DCRC			BIT(7)
f95f3850f7a9e1 Will Newton         2011-01-02  375  #define SDMMC_INT_RCRC			BIT(6)
f95f3850f7a9e1 Will Newton         2011-01-02  376  #define SDMMC_INT_RXDR			BIT(5)
f95f3850f7a9e1 Will Newton         2011-01-02  377  #define SDMMC_INT_TXDR			BIT(4)
f95f3850f7a9e1 Will Newton         2011-01-02  378  #define SDMMC_INT_DATA_OVER		BIT(3)
f95f3850f7a9e1 Will Newton         2011-01-02  379  #define SDMMC_INT_CMD_DONE		BIT(2)
f95f3850f7a9e1 Will Newton         2011-01-02  380  #define SDMMC_INT_RESP_ERR		BIT(1)
f95f3850f7a9e1 Will Newton         2011-01-02  381  #define SDMMC_INT_CD			BIT(0)
f95f3850f7a9e1 Will Newton         2011-01-02  382  /* Command register defines */
f95f3850f7a9e1 Will Newton         2011-01-02  383  #define SDMMC_CMD_START			BIT(31)
eede2111c52226 Dinh Nguyen         2013-06-12  384  #define SDMMC_CMD_USE_HOLD_REG	BIT(29)
0173055842cd1d Doug Anderson       2014-08-22  385  #define SDMMC_CMD_VOLT_SWITCH		BIT(28)
f95f3850f7a9e1 Will Newton         2011-01-02  386  #define SDMMC_CMD_CCS_EXP		BIT(23)
f95f3850f7a9e1 Will Newton         2011-01-02  387  #define SDMMC_CMD_CEATA_RD		BIT(22)
f95f3850f7a9e1 Will Newton         2011-01-02  388  #define SDMMC_CMD_UPD_CLK		BIT(21)
f95f3850f7a9e1 Will Newton         2011-01-02  389  #define SDMMC_CMD_INIT			BIT(15)
f95f3850f7a9e1 Will Newton         2011-01-02  390  #define SDMMC_CMD_STOP			BIT(14)
f95f3850f7a9e1 Will Newton         2011-01-02  391  #define SDMMC_CMD_PRV_DAT_WAIT		BIT(13)
f95f3850f7a9e1 Will Newton         2011-01-02  392  #define SDMMC_CMD_SEND_STOP		BIT(12)
f95f3850f7a9e1 Will Newton         2011-01-02  393  #define SDMMC_CMD_STRM_MODE		BIT(11)
f95f3850f7a9e1 Will Newton         2011-01-02  394  #define SDMMC_CMD_DAT_WR		BIT(10)
f95f3850f7a9e1 Will Newton         2011-01-02  395  #define SDMMC_CMD_DAT_EXP		BIT(9)
f95f3850f7a9e1 Will Newton         2011-01-02  396  #define SDMMC_CMD_RESP_CRC		BIT(8)
f95f3850f7a9e1 Will Newton         2011-01-02  397  #define SDMMC_CMD_RESP_LONG		BIT(7)
f95f3850f7a9e1 Will Newton         2011-01-02  398  #define SDMMC_CMD_RESP_EXP		BIT(6)
f95f3850f7a9e1 Will Newton         2011-01-02  399  #define SDMMC_CMD_INDX(n)		((n) & 0x1F)
f95f3850f7a9e1 Will Newton         2011-01-02  400  /* Status register defines */
ee5d19b20a711d Jaehoon Chung       2012-01-05  401  #define SDMMC_GET_FCNT(x)		(((x)>>17) & 0x1FFF)
3a33a94ce27068 Sonny Rao           2014-08-04  402  #define SDMMC_STATUS_DMA_REQ		BIT(31)
0173055842cd1d Doug Anderson       2014-08-22  403  #define SDMMC_STATUS_BUSY		BIT(9)
524268990e54da Seungwon Jeon       2013-08-31  404  /* FIFOTH register defines */
524268990e54da Seungwon Jeon       2013-08-31  405  #define SDMMC_SET_FIFOTH(m, r, t)	(((m) & 0x7) << 28 | \
524268990e54da Seungwon Jeon       2013-08-31  406  					 ((r) & 0xFFF) << 16 | \
524268990e54da Seungwon Jeon       2013-08-31  407  					 ((t) & 0xFFF))
3fc7eaef44dbcb Shawn Lin           2015-09-16  408  /* HCON register defines */
3fc7eaef44dbcb Shawn Lin           2015-09-16  409  #define DMA_INTERFACE_IDMA		(0x0)
3fc7eaef44dbcb Shawn Lin           2015-09-16  410  #define DMA_INTERFACE_DWDMA		(0x1)
3fc7eaef44dbcb Shawn Lin           2015-09-16  411  #define DMA_INTERFACE_GDMA		(0x2)
3fc7eaef44dbcb Shawn Lin           2015-09-16  412  #define DMA_INTERFACE_NODMA		(0x3)
3fc7eaef44dbcb Shawn Lin           2015-09-16  413  #define SDMMC_GET_TRANS_MODE(x)		(((x)>>16) & 0x3)
70692752af12e2 Shawn Lin           2015-09-16  414  #define SDMMC_GET_SLOT_NUM(x)		((((x)>>1) & 0x1F) + 1)
70692752af12e2 Shawn Lin           2015-09-16  415  #define SDMMC_GET_HDATA_WIDTH(x)	(((x)>>7) & 0x7)
70692752af12e2 Shawn Lin           2015-09-16  416  #define SDMMC_GET_ADDR_CONFIG(x)	(((x)>>27) & 0x1)
f95f3850f7a9e1 Will Newton         2011-01-02  417  /* Internal DMAC interrupt defines */
f95f3850f7a9e1 Will Newton         2011-01-02  418  #define SDMMC_IDMAC_INT_AI		BIT(9)
f95f3850f7a9e1 Will Newton         2011-01-02  419  #define SDMMC_IDMAC_INT_NI		BIT(8)
f95f3850f7a9e1 Will Newton         2011-01-02  420  #define SDMMC_IDMAC_INT_CES		BIT(5)
f95f3850f7a9e1 Will Newton         2011-01-02  421  #define SDMMC_IDMAC_INT_DU		BIT(4)
f95f3850f7a9e1 Will Newton         2011-01-02  422  #define SDMMC_IDMAC_INT_FBE		BIT(2)
f95f3850f7a9e1 Will Newton         2011-01-02  423  #define SDMMC_IDMAC_INT_RI		BIT(1)
f95f3850f7a9e1 Will Newton         2011-01-02  424  #define SDMMC_IDMAC_INT_TI		BIT(0)
f95f3850f7a9e1 Will Newton         2011-01-02  425  /* Internal DMAC bus mode bits */
f95f3850f7a9e1 Will Newton         2011-01-02  426  #define SDMMC_IDMAC_ENABLE		BIT(7)
f95f3850f7a9e1 Will Newton         2011-01-02  427  #define SDMMC_IDMAC_FB			BIT(1)
f95f3850f7a9e1 Will Newton         2011-01-02  428  #define SDMMC_IDMAC_SWRESET		BIT(0)
935a665e15dcda Shawn Lin           2016-01-14  429  /* H/W reset */
935a665e15dcda Shawn Lin           2016-01-14  430  #define SDMMC_RST_HWACTIVE		0x1
4e0a5adf46ee78 Jaehoon Chung       2011-10-17  431  /* Version ID register define */
4e0a5adf46ee78 Jaehoon Chung       2011-10-17  432  #define SDMMC_GET_VERID(x)		((x) & 0xFFFF)
f1d2736c815629 Seungwon Jeon       2013-08-31  433  /* Card read threshold */
7e4bf1bc9543a1 Jaehoon Chung       2016-06-21  434  #define SDMMC_SET_THLD(v, x)		(((v) & 0xFFF) << 16 | (x))
7e4bf1bc9543a1 Jaehoon Chung       2016-06-21  435  #define SDMMC_CARD_WR_THR_EN		BIT(2)
7e4bf1bc9543a1 Jaehoon Chung       2016-06-21  436  #define SDMMC_CARD_RD_THR_EN		BIT(0)
7e4bf1bc9543a1 Jaehoon Chung       2016-06-21  437  /* UHS-1 register defines */
e382ab74125247 tianshuliang        2018-03-08  438  #define SDMMC_UHS_DDR			BIT(16)
0173055842cd1d Doug Anderson       2014-08-22  439  #define SDMMC_UHS_18V			BIT(0)
e382ab74125247 tianshuliang        2018-03-08  440  /* DDR register defines */
e382ab74125247 tianshuliang        2018-03-08  441  #define SDMMC_DDR_HS400			BIT(31)
e382ab74125247 tianshuliang        2018-03-08  442  /* Enable shift register defines */
e382ab74125247 tianshuliang        2018-03-08  443  #define SDMMC_ENABLE_PHASE		BIT(0)
3a33a94ce27068 Sonny Rao           2014-08-04  444  /* All ctrl reset bits */
3a33a94ce27068 Sonny Rao           2014-08-04  445  #define SDMMC_CTRL_ALL_RESET_FLAGS \
3a33a94ce27068 Sonny Rao           2014-08-04  446  	(SDMMC_CTRL_RESET | SDMMC_CTRL_FIFO_RESET | SDMMC_CTRL_DMA_RESET)
3a33a94ce27068 Sonny Rao           2014-08-04  447  
76184ac17edf3c Ben Dooks           2015-03-25  448  /* FIFO register access macros. These should not change the data endian-ness
4b514fa28760cc Alexey Roslyakov    2018-02-23  449   * as they are written to memory to be dealt with by the upper layers
4b514fa28760cc Alexey Roslyakov    2018-02-23  450   */
76184ac17edf3c Ben Dooks           2015-03-25  451  #define mci_fifo_readw(__reg)	__raw_readw(__reg)
76184ac17edf3c Ben Dooks           2015-03-25  452  #define mci_fifo_readl(__reg)	__raw_readl(__reg)
76184ac17edf3c Ben Dooks           2015-03-25 @453  #define mci_fifo_readq(__reg)	__raw_readq(__reg)
76184ac17edf3c Ben Dooks           2015-03-25  454  
76184ac17edf3c Ben Dooks           2015-03-25  455  #define mci_fifo_writew(__value, __reg)	__raw_writew(__reg, __value)
76184ac17edf3c Ben Dooks           2015-03-25  456  #define mci_fifo_writel(__value, __reg)	__raw_writel(__reg, __value)
76184ac17edf3c Ben Dooks           2015-03-25 @457  #define mci_fifo_writeq(__value, __reg)	__raw_writeq(__reg, __value)
76184ac17edf3c Ben Dooks           2015-03-25  458  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
