Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9CDB17BAF;
	Sat,  8 Jun 2024 08:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717835317; cv=none; b=hrcWQIv4ZQxbpGobIGcV0fz0HutDxc4bFE3zkxXL5A1d6+8cJar4kzf7NRY8lQrBSvgo2FEWmBJqgynMuZSJHw0GTYL2hsOMbpickFQZ7G0Q4WurJFUAr941C3WeHEzuydK5xHmG5TP2xzhB4Mvzno0qDYoPew01KKP9LSqF11c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717835317; c=relaxed/simple;
	bh=kdVWVPrXiSu69RrjVp9Cvwdrm3PJeYfw2VOYRC4A+ww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VOVvYFY/OOtfzUn4LjwDsna7EKkvP35OWD+Pl6jwSEDnnEayUvuhxKK6+b6p7AqJtKIzYLCkTy5z9LYZZLfl06QdHTZgYkOY/OhtDE/1h48F42cfI+hQ0LHf9g8Q7PDuDJBlYo2oQLUiGJwHHgcJ+MHeqnQM/o8IQTgxcIuL5Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gp9c1ETl; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gp9c1ETl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717835310; x=1749371310;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kdVWVPrXiSu69RrjVp9Cvwdrm3PJeYfw2VOYRC4A+ww=;
  b=gp9c1ETlb7arFyE6+VVlnBRKAmAb3/tuBH536UEZQcZfsCOzA8pDH2H5
   kzzEm99aNl/UyuAJ7urjzBtnf2Wpm4+Hrkg/sT6kgDJXpxGyo/326qM0M
   q7DTIuBXdEkKemAUSR5zotgqYGYvQ0iF+pZ5Tl9+moRXVlRwbGL3QkMkk
   ntzDYz2/eYyCT94CExmGlC2/y2hL+1+Fz7FmhRFRAI7ec5jAp2T5B8lr1
   KfFKDMcGQol7xN0+pyV+IDgZGJiCHkheABXTh5VRAYODM+5jRiokPyNqh
   kunMihZfXJXh0i79aI/6OrHmHRhAatpaJs15FWqBOhGnJ+1R4dMXboqqv
   g==;
X-CSE-ConnectionGUID: eaUy2u3GT/SCHh7Jxl8gWQ==
X-CSE-MsgGUID: PpFHyheISrCgLUAH+kC3Kg==
X-IronPort-AV: E=McAfee;i="6600,9927,11096"; a="37090834"
X-IronPort-AV: E=Sophos;i="6.08,222,1712646000"; 
   d="scan'208";a="37090834"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2024 01:28:30 -0700
X-CSE-ConnectionGUID: f+Ey07P0THC88Nr9VAVkew==
X-CSE-MsgGUID: 1gXgnYGvQzm37CvxPpcuEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,222,1712646000"; 
   d="scan'208";a="43114740"
Received: from lkp-server01.sh.intel.com (HELO 472b94a103a1) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 08 Jun 2024 01:28:25 -0700
Received: from kbuild by 472b94a103a1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sFrR1-0001K0-27;
	Sat, 08 Jun 2024 08:28:23 +0000
Date: Sat, 8 Jun 2024 16:27:58 +0800
From: kernel test robot <lkp@intel.com>
To: Frank Li <Frank.Li@nxp.com>, krzk@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Frank.Li@nxp.com, conor+dt@kernel.org,
	devicetree@vger.kernel.org, imx@lists.linux.dev, krzk+dt@kernel.org,
	linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
	robh@kernel.org, ulf.hansson@linaro.org
Subject: Re: [PATCH v3 1/1] dt-bindings: mmc: Convert fsl-esdhc.txt to yaml
Message-ID: <202406081643.6gdr9Cm2-lkp@intel.com>
References: <20240605185046.1057877-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240605185046.1057877-1-Frank.Li@nxp.com>

Hi Frank,

kernel test robot noticed the following build warnings:

[auto build test WARNING on robh/for-next]
[also build test WARNING on krzk-dt/for-next ulf-hansson-mmc-mirror/next linus/master v6.10-rc2 next-20240607]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Frank-Li/dt-bindings-mmc-Convert-fsl-esdhc-txt-to-yaml/20240606-025247
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20240605185046.1057877-1-Frank.Li%40nxp.com
patch subject: [PATCH v3 1/1] dt-bindings: mmc: Convert fsl-esdhc.txt to yaml
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project d7d2d4f53fc79b4b58e8d8d08151b577c3699d4a)
dtschema version: 2024.6.dev1+g833054f
reproduce: (https://download.01.org/0day-ci/archive/20240608/202406081643.6gdr9Cm2-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406081643.6gdr9Cm2-lkp@intel.com/

dtcheck warnings: (new ones prefixed by >>)
>> arch/arm64/boot/dts/freescale/fsl-ls1012a-frdm.dtb: esdhc@1560000: voltage-ranges:0: [1800, 1800, 3300, 3300] is too long
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
>> arch/arm64/boot/dts/freescale/fsl-ls1012a-frdm.dtb: esdhc@1560000: $nodename:0: 'esdhc@1560000' does not match '^mmc(@.*)?$'
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
   arch/arm64/boot/dts/freescale/fsl-ls1012a-frdm.dtb: esdhc@1580000: voltage-ranges:0: [1800, 1800, 3300, 3300] is too long
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
   arch/arm64/boot/dts/freescale/fsl-ls1012a-frdm.dtb: esdhc@1580000: $nodename:0: 'esdhc@1580000' does not match '^mmc(@.*)?$'
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
   arch/arm64/boot/dts/freescale/fsl-ls1012a-frdm.dtb: crypto@1700000: rtic@60000:reg: [[393216, 256], [396800, 24]] is too long
   	from schema $id: http://devicetree.org/schemas/crypto/fsl,sec-v4.0.yaml#
   arch/arm64/boot/dts/freescale/fsl-ls1012a-frdm.dtb: /soc/clocking@1ee1000: failed to match any schema with compatible: ['fsl,ls1012a-clockgen']
   arch/arm64/boot/dts/freescale/fsl-ls1012a-frdm.dtb: /soc/spi@2100000: failed to match any schema with compatible: ['fsl,ls1012a-dspi', 'fsl,ls1021a-v1.0-dspi']
   arch/arm64/boot/dts/freescale/fsl-ls1012a-frdm.dtb: /soc/spi@2100000: failed to match any schema with compatible: ['fsl,ls1012a-dspi', 'fsl,ls1021a-v1.0-dspi']
--
>> arch/arm64/boot/dts/freescale/fsl-ls1012a-frwy.dtb: esdhc@1560000: voltage-ranges:0: [1800, 1800, 3300, 3300] is too long
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
>> arch/arm64/boot/dts/freescale/fsl-ls1012a-frwy.dtb: esdhc@1560000: $nodename:0: 'esdhc@1560000' does not match '^mmc(@.*)?$'
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
   arch/arm64/boot/dts/freescale/fsl-ls1012a-frwy.dtb: esdhc@1580000: voltage-ranges:0: [1800, 1800, 3300, 3300] is too long
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
   arch/arm64/boot/dts/freescale/fsl-ls1012a-frwy.dtb: esdhc@1580000: $nodename:0: 'esdhc@1580000' does not match '^mmc(@.*)?$'
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
   arch/arm64/boot/dts/freescale/fsl-ls1012a-frwy.dtb: crypto@1700000: rtic@60000:reg: [[393216, 256], [396800, 24]] is too long
   	from schema $id: http://devicetree.org/schemas/crypto/fsl,sec-v4.0.yaml#
   arch/arm64/boot/dts/freescale/fsl-ls1012a-frwy.dtb: /soc/clocking@1ee1000: failed to match any schema with compatible: ['fsl,ls1012a-clockgen']
   arch/arm64/boot/dts/freescale/fsl-ls1012a-frwy.dtb: /soc/spi@2100000: failed to match any schema with compatible: ['fsl,ls1012a-dspi', 'fsl,ls1021a-v1.0-dspi']
   arch/arm64/boot/dts/freescale/fsl-ls1012a-frwy.dtb: /soc/spi@2100000: failed to match any schema with compatible: ['fsl,ls1012a-dspi', 'fsl,ls1021a-v1.0-dspi']
--
>> arch/arm64/boot/dts/freescale/fsl-ls1012a-oxalis.dtb: esdhc@1560000: voltage-ranges:0: [1800, 1800, 3300, 3300] is too long
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
>> arch/arm64/boot/dts/freescale/fsl-ls1012a-oxalis.dtb: esdhc@1560000: $nodename:0: 'esdhc@1560000' does not match '^mmc(@.*)?$'
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
   arch/arm64/boot/dts/freescale/fsl-ls1012a-oxalis.dtb: esdhc@1580000: voltage-ranges:0: [1800, 1800, 3300, 3300] is too long
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
>> arch/arm64/boot/dts/freescale/fsl-ls1012a-oxalis.dtb: esdhc@1580000: 'clock-frequency' is a required property
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
   arch/arm64/boot/dts/freescale/fsl-ls1012a-oxalis.dtb: esdhc@1580000: $nodename:0: 'esdhc@1580000' does not match '^mmc(@.*)?$'
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
>> arch/arm64/boot/dts/freescale/fsl-ls1012a-oxalis.dtb: esdhc@1580000: Unevaluated properties are not allowed ('big-endian', 'broken-cd', 'bus-width', 'clocks', 'voltage-ranges' were unexpected)
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
   arch/arm64/boot/dts/freescale/fsl-ls1012a-oxalis.dtb: crypto@1700000: rtic@60000:reg: [[393216, 256], [396800, 24]] is too long
   	from schema $id: http://devicetree.org/schemas/crypto/fsl,sec-v4.0.yaml#
   arch/arm64/boot/dts/freescale/fsl-ls1012a-oxalis.dtb: /soc/clocking@1ee1000: failed to match any schema with compatible: ['fsl,ls1012a-clockgen']
   arch/arm64/boot/dts/freescale/fsl-ls1012a-oxalis.dtb: /soc/spi@2100000: failed to match any schema with compatible: ['fsl,ls1012a-dspi', 'fsl,ls1021a-v1.0-dspi']
   arch/arm64/boot/dts/freescale/fsl-ls1012a-oxalis.dtb: /soc/spi@2100000: failed to match any schema with compatible: ['fsl,ls1012a-dspi', 'fsl,ls1021a-v1.0-dspi']
   arch/arm64/boot/dts/freescale/fsl-ls1012a-oxalis.dtb: /soc/gpio@2300000: failed to match any schema with compatible: ['fsl,qoriq-gpio']
   arch/arm64/boot/dts/freescale/fsl-ls1012a-oxalis.dtb: /soc/gpio@2310000: failed to match any schema with compatible: ['fsl,qoriq-gpio']
   arch/arm64/boot/dts/freescale/fsl-ls1012a-oxalis.dtb: watchdog@2ad0000: Unevaluated properties are not allowed ('big-endian' was unexpected)
   	from schema $id: http://devicetree.org/schemas/watchdog/fsl-imx-wdt.yaml#
--
>> arch/arm64/boot/dts/freescale/fsl-ls1012a-qds.dtb: esdhc@1560000: voltage-ranges:0: [1800, 1800, 3300, 3300] is too long
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
>> arch/arm64/boot/dts/freescale/fsl-ls1012a-qds.dtb: esdhc@1560000: 'clock-frequency' is a required property
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
>> arch/arm64/boot/dts/freescale/fsl-ls1012a-qds.dtb: esdhc@1560000: $nodename:0: 'esdhc@1560000' does not match '^mmc(@.*)?$'
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
>> arch/arm64/boot/dts/freescale/fsl-ls1012a-qds.dtb: esdhc@1560000: Unevaluated properties are not allowed ('big-endian', 'bus-width', 'clocks', 'voltage-ranges' were unexpected)
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
   arch/arm64/boot/dts/freescale/fsl-ls1012a-qds.dtb: esdhc@1580000: voltage-ranges:0: [1800, 1800, 3300, 3300] is too long
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
   arch/arm64/boot/dts/freescale/fsl-ls1012a-qds.dtb: esdhc@1580000: 'clock-frequency' is a required property
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
   arch/arm64/boot/dts/freescale/fsl-ls1012a-qds.dtb: esdhc@1580000: $nodename:0: 'esdhc@1580000' does not match '^mmc(@.*)?$'
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
>> arch/arm64/boot/dts/freescale/fsl-ls1012a-qds.dtb: esdhc@1580000: Unevaluated properties are not allowed ('big-endian', 'broken-cd', 'bus-width', 'clocks', 'voltage-ranges' were unexpected)
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
   arch/arm64/boot/dts/freescale/fsl-ls1012a-qds.dtb: crypto@1700000: rtic@60000:reg: [[393216, 256], [396800, 24]] is too long
   	from schema $id: http://devicetree.org/schemas/crypto/fsl,sec-v4.0.yaml#
   arch/arm64/boot/dts/freescale/fsl-ls1012a-qds.dtb: /soc/clocking@1ee1000: failed to match any schema with compatible: ['fsl,ls1012a-clockgen']
   arch/arm64/boot/dts/freescale/fsl-ls1012a-qds.dtb: /soc/spi@2100000: failed to match any schema with compatible: ['fsl,ls1012a-dspi', 'fsl,ls1021a-v1.0-dspi']
   arch/arm64/boot/dts/freescale/fsl-ls1012a-qds.dtb: /soc/spi@2100000: failed to match any schema with compatible: ['fsl,ls1012a-dspi', 'fsl,ls1021a-v1.0-dspi']
   arch/arm64/boot/dts/freescale/fsl-ls1012a-qds.dtb: /soc/spi@2100000/flash@2: failed to match any schema with compatible: ['en25s64', 'jedec,spi-nor']
   arch/arm64/boot/dts/freescale/fsl-ls1012a-qds.dtb: /soc/gpio@2300000: failed to match any schema with compatible: ['fsl,qoriq-gpio']
   arch/arm64/boot/dts/freescale/fsl-ls1012a-qds.dtb: /soc/gpio@2310000: failed to match any schema with compatible: ['fsl,qoriq-gpio']
   arch/arm64/boot/dts/freescale/fsl-ls1012a-qds.dtb: watchdog@2ad0000: Unevaluated properties are not allowed ('big-endian' was unexpected)
--
>> arch/arm64/boot/dts/freescale/fsl-ls1012a-rdb.dtb: esdhc@1560000: voltage-ranges:0: [1800, 1800, 3300, 3300] is too long
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
>> arch/arm64/boot/dts/freescale/fsl-ls1012a-rdb.dtb: esdhc@1560000: 'clock-frequency' is a required property
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
>> arch/arm64/boot/dts/freescale/fsl-ls1012a-rdb.dtb: esdhc@1560000: $nodename:0: 'esdhc@1560000' does not match '^mmc(@.*)?$'
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
>> arch/arm64/boot/dts/freescale/fsl-ls1012a-rdb.dtb: esdhc@1560000: Unevaluated properties are not allowed ('big-endian', 'bus-width', 'clocks', 'sd-uhs-sdr104', 'sd-uhs-sdr12', 'sd-uhs-sdr25', 'sd-uhs-sdr50', 'voltage-ranges' were unexpected)
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
   arch/arm64/boot/dts/freescale/fsl-ls1012a-rdb.dtb: esdhc@1580000: voltage-ranges:0: [1800, 1800, 3300, 3300] is too long
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
   arch/arm64/boot/dts/freescale/fsl-ls1012a-rdb.dtb: esdhc@1580000: 'clock-frequency' is a required property
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
   arch/arm64/boot/dts/freescale/fsl-ls1012a-rdb.dtb: esdhc@1580000: $nodename:0: 'esdhc@1580000' does not match '^mmc(@.*)?$'
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
>> arch/arm64/boot/dts/freescale/fsl-ls1012a-rdb.dtb: esdhc@1580000: Unevaluated properties are not allowed ('big-endian', 'broken-cd', 'bus-width', 'clocks', 'mmc-hs200-1_8v', 'voltage-ranges' were unexpected)
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
   arch/arm64/boot/dts/freescale/fsl-ls1012a-rdb.dtb: crypto@1700000: rtic@60000:reg: [[393216, 256], [396800, 24]] is too long
   	from schema $id: http://devicetree.org/schemas/crypto/fsl,sec-v4.0.yaml#
   arch/arm64/boot/dts/freescale/fsl-ls1012a-rdb.dtb: /soc/clocking@1ee1000: failed to match any schema with compatible: ['fsl,ls1012a-clockgen']
   arch/arm64/boot/dts/freescale/fsl-ls1012a-rdb.dtb: /soc/spi@2100000: failed to match any schema with compatible: ['fsl,ls1012a-dspi', 'fsl,ls1021a-v1.0-dspi']
   arch/arm64/boot/dts/freescale/fsl-ls1012a-rdb.dtb: /soc/spi@2100000: failed to match any schema with compatible: ['fsl,ls1012a-dspi', 'fsl,ls1021a-v1.0-dspi']
   arch/arm64/boot/dts/freescale/fsl-ls1012a-rdb.dtb: /soc/gpio@2300000: failed to match any schema with compatible: ['fsl,qoriq-gpio']
   arch/arm64/boot/dts/freescale/fsl-ls1012a-rdb.dtb: /soc/gpio@2310000: failed to match any schema with compatible: ['fsl,qoriq-gpio']
   arch/arm64/boot/dts/freescale/fsl-ls1012a-rdb.dtb: watchdog@2ad0000: Unevaluated properties are not allowed ('big-endian' was unexpected)
   	from schema $id: http://devicetree.org/schemas/watchdog/fsl-imx-wdt.yaml#
--
   	from schema $id: http://devicetree.org/schemas/mfd/syscon.yaml#
   arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-kbox-a-230-ls.dtb: efuse@1e80000: Unevaluated properties are not allowed ('unique-id@1c' was unexpected)
   	from schema $id: http://devicetree.org/schemas/nvmem/fsl,layerscape-sfp.yaml#
   arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-kbox-a-230-ls.dtb: /soc/clock-controller@1300000: failed to match any schema with compatible: ['fsl,ls1028a-clockgen']
   arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-kbox-a-230-ls.dtb: /soc/spi@2100000: failed to match any schema with compatible: ['fsl,ls1028a-dspi', 'fsl,ls1021a-v1.0-dspi']
   arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-kbox-a-230-ls.dtb: /soc/spi@2100000: failed to match any schema with compatible: ['fsl,ls1028a-dspi', 'fsl,ls1021a-v1.0-dspi']
   arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-kbox-a-230-ls.dtb: /soc/spi@2110000: failed to match any schema with compatible: ['fsl,ls1028a-dspi', 'fsl,ls1021a-v1.0-dspi']
   arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-kbox-a-230-ls.dtb: /soc/spi@2110000: failed to match any schema with compatible: ['fsl,ls1028a-dspi', 'fsl,ls1021a-v1.0-dspi']
   arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-kbox-a-230-ls.dtb: /soc/spi@2120000: failed to match any schema with compatible: ['fsl,ls1028a-dspi', 'fsl,ls1021a-v1.0-dspi']
   arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-kbox-a-230-ls.dtb: /soc/spi@2120000: failed to match any schema with compatible: ['fsl,ls1028a-dspi', 'fsl,ls1021a-v1.0-dspi']
>> arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-kbox-a-230-ls.dtb: mmc@2140000: voltage-ranges:0: [1800, 1800, 3300, 3300] is too long
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
>> arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-kbox-a-230-ls.dtb: mmc@2140000: Unevaluated properties are not allowed ('clocks', 'voltage-ranges' were unexpected)
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
>> arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-kbox-a-230-ls.dtb: mmc@2150000: Unevaluated properties are not allowed ('clocks' was unexpected)
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
   arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-kbox-a-230-ls.dtb: /soc/gpio@2300000: failed to match any schema with compatible: ['fsl,ls1028a-gpio', 'fsl,qoriq-gpio']
   arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-kbox-a-230-ls.dtb: /soc/gpio@2300000: failed to match any schema with compatible: ['fsl,ls1028a-gpio', 'fsl,qoriq-gpio']
   arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-kbox-a-230-ls.dtb: /soc/gpio@2310000: failed to match any schema with compatible: ['fsl,ls1028a-gpio', 'fsl,qoriq-gpio']
   arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-kbox-a-230-ls.dtb: /soc/gpio@2310000: failed to match any schema with compatible: ['fsl,ls1028a-gpio', 'fsl,qoriq-gpio']
   arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-kbox-a-230-ls.dtb: /soc/gpio@2320000: failed to match any schema with compatible: ['fsl,ls1028a-gpio', 'fsl,qoriq-gpio']
   arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-kbox-a-230-ls.dtb: /soc/gpio@2320000: failed to match any schema with compatible: ['fsl,ls1028a-gpio', 'fsl,qoriq-gpio']
   arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-kbox-a-230-ls.dtb: /soc/usb@3100000: failed to match any schema with compatible: ['fsl,ls1028a-dwc3', 'snps,dwc3']
   arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-kbox-a-230-ls.dtb: /soc/usb@3110000: failed to match any schema with compatible: ['fsl,ls1028a-dwc3', 'snps,dwc3']
   arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-kbox-a-230-ls.dtb: /soc/sata@3200000: failed to match any schema with compatible: ['fsl,ls1028a-ahci']
--
   	from schema $id: http://devicetree.org/schemas/mfd/syscon.yaml#
   arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28.dtb: efuse@1e80000: Unevaluated properties are not allowed ('unique-id@1c' was unexpected)
   	from schema $id: http://devicetree.org/schemas/nvmem/fsl,layerscape-sfp.yaml#
   arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28.dtb: /soc/clock-controller@1300000: failed to match any schema with compatible: ['fsl,ls1028a-clockgen']
   arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28.dtb: /soc/spi@2100000: failed to match any schema with compatible: ['fsl,ls1028a-dspi', 'fsl,ls1021a-v1.0-dspi']
   arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28.dtb: /soc/spi@2100000: failed to match any schema with compatible: ['fsl,ls1028a-dspi', 'fsl,ls1021a-v1.0-dspi']
   arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28.dtb: /soc/spi@2110000: failed to match any schema with compatible: ['fsl,ls1028a-dspi', 'fsl,ls1021a-v1.0-dspi']
   arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28.dtb: /soc/spi@2110000: failed to match any schema with compatible: ['fsl,ls1028a-dspi', 'fsl,ls1021a-v1.0-dspi']
   arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28.dtb: /soc/spi@2120000: failed to match any schema with compatible: ['fsl,ls1028a-dspi', 'fsl,ls1021a-v1.0-dspi']
   arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28.dtb: /soc/spi@2120000: failed to match any schema with compatible: ['fsl,ls1028a-dspi', 'fsl,ls1021a-v1.0-dspi']
>> arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28.dtb: mmc@2140000: voltage-ranges:0: [1800, 1800, 3300, 3300] is too long
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
>> arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28.dtb: mmc@2140000: Unevaluated properties are not allowed ('clocks', 'voltage-ranges' were unexpected)
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
>> arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28.dtb: mmc@2150000: Unevaluated properties are not allowed ('clocks' was unexpected)
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
   arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28.dtb: /soc/gpio@2300000: failed to match any schema with compatible: ['fsl,ls1028a-gpio', 'fsl,qoriq-gpio']
   arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28.dtb: /soc/gpio@2300000: failed to match any schema with compatible: ['fsl,ls1028a-gpio', 'fsl,qoriq-gpio']
   arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28.dtb: /soc/gpio@2310000: failed to match any schema with compatible: ['fsl,ls1028a-gpio', 'fsl,qoriq-gpio']
   arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28.dtb: /soc/gpio@2310000: failed to match any schema with compatible: ['fsl,ls1028a-gpio', 'fsl,qoriq-gpio']
   arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28.dtb: /soc/gpio@2320000: failed to match any schema with compatible: ['fsl,ls1028a-gpio', 'fsl,qoriq-gpio']
   arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28.dtb: /soc/gpio@2320000: failed to match any schema with compatible: ['fsl,ls1028a-gpio', 'fsl,qoriq-gpio']
   arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28.dtb: /soc/usb@3100000: failed to match any schema with compatible: ['fsl,ls1028a-dwc3', 'snps,dwc3']
   arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28.dtb: /soc/usb@3110000: failed to match any schema with compatible: ['fsl,ls1028a-dwc3', 'snps,dwc3']
   arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28.dtb: /soc/sata@3200000: failed to match any schema with compatible: ['fsl,ls1028a-ahci']
--
   	from schema $id: http://devicetree.org/schemas/mfd/syscon.yaml#
   arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var1.dtb: efuse@1e80000: Unevaluated properties are not allowed ('unique-id@1c' was unexpected)
   	from schema $id: http://devicetree.org/schemas/nvmem/fsl,layerscape-sfp.yaml#
   arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var1.dtb: /soc/clock-controller@1300000: failed to match any schema with compatible: ['fsl,ls1028a-clockgen']
   arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var1.dtb: /soc/spi@2100000: failed to match any schema with compatible: ['fsl,ls1028a-dspi', 'fsl,ls1021a-v1.0-dspi']
   arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var1.dtb: /soc/spi@2100000: failed to match any schema with compatible: ['fsl,ls1028a-dspi', 'fsl,ls1021a-v1.0-dspi']
   arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var1.dtb: /soc/spi@2110000: failed to match any schema with compatible: ['fsl,ls1028a-dspi', 'fsl,ls1021a-v1.0-dspi']
   arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var1.dtb: /soc/spi@2110000: failed to match any schema with compatible: ['fsl,ls1028a-dspi', 'fsl,ls1021a-v1.0-dspi']
   arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var1.dtb: /soc/spi@2120000: failed to match any schema with compatible: ['fsl,ls1028a-dspi', 'fsl,ls1021a-v1.0-dspi']
   arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var1.dtb: /soc/spi@2120000: failed to match any schema with compatible: ['fsl,ls1028a-dspi', 'fsl,ls1021a-v1.0-dspi']
>> arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var1.dtb: mmc@2140000: voltage-ranges:0: [1800, 1800, 3300, 3300] is too long
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
>> arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var1.dtb: mmc@2140000: Unevaluated properties are not allowed ('clocks', 'voltage-ranges' were unexpected)
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
>> arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var1.dtb: mmc@2150000: Unevaluated properties are not allowed ('clocks' was unexpected)
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
   arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var1.dtb: /soc/gpio@2300000: failed to match any schema with compatible: ['fsl,ls1028a-gpio', 'fsl,qoriq-gpio']
   arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var1.dtb: /soc/gpio@2300000: failed to match any schema with compatible: ['fsl,ls1028a-gpio', 'fsl,qoriq-gpio']
   arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var1.dtb: /soc/gpio@2310000: failed to match any schema with compatible: ['fsl,ls1028a-gpio', 'fsl,qoriq-gpio']
   arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var1.dtb: /soc/gpio@2310000: failed to match any schema with compatible: ['fsl,ls1028a-gpio', 'fsl,qoriq-gpio']
   arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var1.dtb: /soc/gpio@2320000: failed to match any schema with compatible: ['fsl,ls1028a-gpio', 'fsl,qoriq-gpio']
   arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var1.dtb: /soc/gpio@2320000: failed to match any schema with compatible: ['fsl,ls1028a-gpio', 'fsl,qoriq-gpio']
   arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var1.dtb: /soc/usb@3100000: failed to match any schema with compatible: ['fsl,ls1028a-dwc3', 'snps,dwc3']
   arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var1.dtb: /soc/usb@3110000: failed to match any schema with compatible: ['fsl,ls1028a-dwc3', 'snps,dwc3']
   arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var1.dtb: /soc/sata@3200000: failed to match any schema with compatible: ['fsl,ls1028a-ahci']
--
   	from schema $id: http://devicetree.org/schemas/mfd/syscon.yaml#
   arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var2.dtb: efuse@1e80000: Unevaluated properties are not allowed ('unique-id@1c' was unexpected)
   	from schema $id: http://devicetree.org/schemas/nvmem/fsl,layerscape-sfp.yaml#
   arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var2.dtb: /soc/clock-controller@1300000: failed to match any schema with compatible: ['fsl,ls1028a-clockgen']
   arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var2.dtb: /soc/spi@2100000: failed to match any schema with compatible: ['fsl,ls1028a-dspi', 'fsl,ls1021a-v1.0-dspi']
   arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var2.dtb: /soc/spi@2100000: failed to match any schema with compatible: ['fsl,ls1028a-dspi', 'fsl,ls1021a-v1.0-dspi']
   arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var2.dtb: /soc/spi@2110000: failed to match any schema with compatible: ['fsl,ls1028a-dspi', 'fsl,ls1021a-v1.0-dspi']
   arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var2.dtb: /soc/spi@2110000: failed to match any schema with compatible: ['fsl,ls1028a-dspi', 'fsl,ls1021a-v1.0-dspi']
   arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var2.dtb: /soc/spi@2120000: failed to match any schema with compatible: ['fsl,ls1028a-dspi', 'fsl,ls1021a-v1.0-dspi']
   arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var2.dtb: /soc/spi@2120000: failed to match any schema with compatible: ['fsl,ls1028a-dspi', 'fsl,ls1021a-v1.0-dspi']
>> arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var2.dtb: mmc@2140000: voltage-ranges:0: [1800, 1800, 3300, 3300] is too long
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
>> arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var2.dtb: mmc@2140000: Unevaluated properties are not allowed ('clocks', 'voltage-ranges' were unexpected)
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
>> arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var2.dtb: mmc@2150000: Unevaluated properties are not allowed ('clocks' was unexpected)
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
   arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var2.dtb: /soc/gpio@2300000: failed to match any schema with compatible: ['fsl,ls1028a-gpio', 'fsl,qoriq-gpio']
   arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var2.dtb: /soc/gpio@2300000: failed to match any schema with compatible: ['fsl,ls1028a-gpio', 'fsl,qoriq-gpio']
   arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var2.dtb: /soc/gpio@2310000: failed to match any schema with compatible: ['fsl,ls1028a-gpio', 'fsl,qoriq-gpio']
   arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var2.dtb: /soc/gpio@2310000: failed to match any schema with compatible: ['fsl,ls1028a-gpio', 'fsl,qoriq-gpio']
   arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var2.dtb: /soc/gpio@2320000: failed to match any schema with compatible: ['fsl,ls1028a-gpio', 'fsl,qoriq-gpio']
   arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var2.dtb: /soc/gpio@2320000: failed to match any schema with compatible: ['fsl,ls1028a-gpio', 'fsl,qoriq-gpio']
   arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var2.dtb: /soc/usb@3100000: failed to match any schema with compatible: ['fsl,ls1028a-dwc3', 'snps,dwc3']
   arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var2.dtb: /soc/usb@3110000: failed to match any schema with compatible: ['fsl,ls1028a-dwc3', 'snps,dwc3']
   arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var2.dtb: /soc/sata@3200000: failed to match any schema with compatible: ['fsl,ls1028a-ahci']
--
   	from schema $id: http://devicetree.org/schemas/mfd/syscon.yaml#
   arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var3.dtb: efuse@1e80000: Unevaluated properties are not allowed ('unique-id@1c' was unexpected)
   	from schema $id: http://devicetree.org/schemas/nvmem/fsl,layerscape-sfp.yaml#
   arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var3.dtb: /soc/clock-controller@1300000: failed to match any schema with compatible: ['fsl,ls1028a-clockgen']
   arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var3.dtb: /soc/spi@2100000: failed to match any schema with compatible: ['fsl,ls1028a-dspi', 'fsl,ls1021a-v1.0-dspi']
   arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var3.dtb: /soc/spi@2100000: failed to match any schema with compatible: ['fsl,ls1028a-dspi', 'fsl,ls1021a-v1.0-dspi']
   arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var3.dtb: /soc/spi@2110000: failed to match any schema with compatible: ['fsl,ls1028a-dspi', 'fsl,ls1021a-v1.0-dspi']
   arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var3.dtb: /soc/spi@2110000: failed to match any schema with compatible: ['fsl,ls1028a-dspi', 'fsl,ls1021a-v1.0-dspi']
   arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var3.dtb: /soc/spi@2120000: failed to match any schema with compatible: ['fsl,ls1028a-dspi', 'fsl,ls1021a-v1.0-dspi']
   arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var3.dtb: /soc/spi@2120000: failed to match any schema with compatible: ['fsl,ls1028a-dspi', 'fsl,ls1021a-v1.0-dspi']
>> arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var3.dtb: mmc@2140000: voltage-ranges:0: [1800, 1800, 3300, 3300] is too long
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
>> arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var3.dtb: mmc@2140000: Unevaluated properties are not allowed ('clocks', 'voltage-ranges' were unexpected)
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
>> arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var3.dtb: mmc@2150000: Unevaluated properties are not allowed ('clocks' was unexpected)
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
   arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var3.dtb: /soc/gpio@2300000: failed to match any schema with compatible: ['fsl,ls1028a-gpio', 'fsl,qoriq-gpio']
   arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var3.dtb: /soc/gpio@2300000: failed to match any schema with compatible: ['fsl,ls1028a-gpio', 'fsl,qoriq-gpio']
   arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var3.dtb: /soc/gpio@2310000: failed to match any schema with compatible: ['fsl,ls1028a-gpio', 'fsl,qoriq-gpio']
   arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var3.dtb: /soc/gpio@2310000: failed to match any schema with compatible: ['fsl,ls1028a-gpio', 'fsl,qoriq-gpio']
   arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var3.dtb: /soc/gpio@2320000: failed to match any schema with compatible: ['fsl,ls1028a-gpio', 'fsl,qoriq-gpio']
   arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var3.dtb: /soc/gpio@2320000: failed to match any schema with compatible: ['fsl,ls1028a-gpio', 'fsl,qoriq-gpio']
   arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var3.dtb: /soc/usb@3100000: failed to match any schema with compatible: ['fsl,ls1028a-dwc3', 'snps,dwc3']
   arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var3.dtb: /soc/usb@3110000: failed to match any schema with compatible: ['fsl,ls1028a-dwc3', 'snps,dwc3']
   arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var3.dtb: /soc/sata@3200000: failed to match any schema with compatible: ['fsl,ls1028a-ahci']
--
   arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var3-ads2.dtb: audio-codec@1a: 'DCVDD-supply' is a required property
   	from schema $id: http://devicetree.org/schemas/sound/wlf,wm8904.yaml#
   arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var3-ads2.dtb: audio-codec@1a: 'MICVDD-supply' is a required property
   	from schema $id: http://devicetree.org/schemas/sound/wlf,wm8904.yaml#
   arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var3-ads2.dtb: /soc/spi@2100000: failed to match any schema with compatible: ['fsl,ls1028a-dspi', 'fsl,ls1021a-v1.0-dspi']
   arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var3-ads2.dtb: /soc/spi@2100000: failed to match any schema with compatible: ['fsl,ls1028a-dspi', 'fsl,ls1021a-v1.0-dspi']
   arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var3-ads2.dtb: /soc/spi@2110000: failed to match any schema with compatible: ['fsl,ls1028a-dspi', 'fsl,ls1021a-v1.0-dspi']
   arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var3-ads2.dtb: /soc/spi@2110000: failed to match any schema with compatible: ['fsl,ls1028a-dspi', 'fsl,ls1021a-v1.0-dspi']
   arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var3-ads2.dtb: /soc/spi@2120000: failed to match any schema with compatible: ['fsl,ls1028a-dspi', 'fsl,ls1021a-v1.0-dspi']
   arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var3-ads2.dtb: /soc/spi@2120000: failed to match any schema with compatible: ['fsl,ls1028a-dspi', 'fsl,ls1021a-v1.0-dspi']
>> arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var3-ads2.dtb: mmc@2140000: voltage-ranges:0: [1800, 1800, 3300, 3300] is too long
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
>> arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var3-ads2.dtb: mmc@2140000: Unevaluated properties are not allowed ('clocks', 'voltage-ranges' were unexpected)
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
>> arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var3-ads2.dtb: mmc@2150000: Unevaluated properties are not allowed ('clocks' was unexpected)
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
   arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var3-ads2.dtb: /soc/gpio@2300000: failed to match any schema with compatible: ['fsl,ls1028a-gpio', 'fsl,qoriq-gpio']
   arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var3-ads2.dtb: /soc/gpio@2300000: failed to match any schema with compatible: ['fsl,ls1028a-gpio', 'fsl,qoriq-gpio']
   arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var3-ads2.dtb: /soc/gpio@2310000: failed to match any schema with compatible: ['fsl,ls1028a-gpio', 'fsl,qoriq-gpio']
   arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var3-ads2.dtb: /soc/gpio@2310000: failed to match any schema with compatible: ['fsl,ls1028a-gpio', 'fsl,qoriq-gpio']
   arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var3-ads2.dtb: /soc/gpio@2320000: failed to match any schema with compatible: ['fsl,ls1028a-gpio', 'fsl,qoriq-gpio']
   arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var3-ads2.dtb: /soc/gpio@2320000: failed to match any schema with compatible: ['fsl,ls1028a-gpio', 'fsl,qoriq-gpio']
   arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var3-ads2.dtb: /soc/usb@3100000: failed to match any schema with compatible: ['fsl,ls1028a-dwc3', 'snps,dwc3']
   arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var3-ads2.dtb: /soc/usb@3110000: failed to match any schema with compatible: ['fsl,ls1028a-dwc3', 'snps,dwc3']
   arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var3-ads2.dtb: /soc/sata@3200000: failed to match any schema with compatible: ['fsl,ls1028a-ahci']
--
   	from schema $id: http://devicetree.org/schemas/mfd/syscon.yaml#
   arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var4.dtb: efuse@1e80000: Unevaluated properties are not allowed ('unique-id@1c' was unexpected)
   	from schema $id: http://devicetree.org/schemas/nvmem/fsl,layerscape-sfp.yaml#
   arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var4.dtb: /soc/clock-controller@1300000: failed to match any schema with compatible: ['fsl,ls1028a-clockgen']
   arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var4.dtb: /soc/spi@2100000: failed to match any schema with compatible: ['fsl,ls1028a-dspi', 'fsl,ls1021a-v1.0-dspi']
   arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var4.dtb: /soc/spi@2100000: failed to match any schema with compatible: ['fsl,ls1028a-dspi', 'fsl,ls1021a-v1.0-dspi']
   arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var4.dtb: /soc/spi@2110000: failed to match any schema with compatible: ['fsl,ls1028a-dspi', 'fsl,ls1021a-v1.0-dspi']
   arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var4.dtb: /soc/spi@2110000: failed to match any schema with compatible: ['fsl,ls1028a-dspi', 'fsl,ls1021a-v1.0-dspi']
   arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var4.dtb: /soc/spi@2120000: failed to match any schema with compatible: ['fsl,ls1028a-dspi', 'fsl,ls1021a-v1.0-dspi']
   arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var4.dtb: /soc/spi@2120000: failed to match any schema with compatible: ['fsl,ls1028a-dspi', 'fsl,ls1021a-v1.0-dspi']
>> arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var4.dtb: mmc@2140000: voltage-ranges:0: [1800, 1800, 3300, 3300] is too long
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
>> arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var4.dtb: mmc@2140000: Unevaluated properties are not allowed ('clocks', 'voltage-ranges' were unexpected)
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
>> arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var4.dtb: mmc@2150000: Unevaluated properties are not allowed ('clocks' was unexpected)
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
   arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var4.dtb: /soc/gpio@2300000: failed to match any schema with compatible: ['fsl,ls1028a-gpio', 'fsl,qoriq-gpio']
   arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var4.dtb: /soc/gpio@2300000: failed to match any schema with compatible: ['fsl,ls1028a-gpio', 'fsl,qoriq-gpio']
   arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var4.dtb: /soc/gpio@2310000: failed to match any schema with compatible: ['fsl,ls1028a-gpio', 'fsl,qoriq-gpio']
   arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var4.dtb: /soc/gpio@2310000: failed to match any schema with compatible: ['fsl,ls1028a-gpio', 'fsl,qoriq-gpio']
   arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var4.dtb: /soc/gpio@2320000: failed to match any schema with compatible: ['fsl,ls1028a-gpio', 'fsl,qoriq-gpio']
   arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var4.dtb: /soc/gpio@2320000: failed to match any schema with compatible: ['fsl,ls1028a-gpio', 'fsl,qoriq-gpio']
   arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var4.dtb: /soc/usb@3100000: failed to match any schema with compatible: ['fsl,ls1028a-dwc3', 'snps,dwc3']
   arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var4.dtb: /soc/usb@3110000: failed to match any schema with compatible: ['fsl,ls1028a-dwc3', 'snps,dwc3']
   arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var4.dtb: /soc/sata@3200000: failed to match any schema with compatible: ['fsl,ls1028a-ahci']
--
   	from schema $id: http://devicetree.org/schemas/nvmem/fsl,layerscape-sfp.yaml#
   arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dtb: /soc/clock-controller@1300000: failed to match any schema with compatible: ['fsl,ls1028a-clockgen']
   arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dtb: /soc/i2c@2000000/fpga@66: failed to match any schema with compatible: ['fsl,ls1028aqds-fpga', 'fsl,fpga-qixis-i2c', 'simple-mfd']
   arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dtb: /soc/i2c@2000000/fpga@66: failed to match any schema with compatible: ['fsl,ls1028aqds-fpga', 'fsl,fpga-qixis-i2c', 'simple-mfd']
   arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dtb: /soc/spi@2100000: failed to match any schema with compatible: ['fsl,ls1028a-dspi', 'fsl,ls1021a-v1.0-dspi']
   arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dtb: /soc/spi@2100000: failed to match any schema with compatible: ['fsl,ls1028a-dspi', 'fsl,ls1021a-v1.0-dspi']
   arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dtb: /soc/spi@2110000: failed to match any schema with compatible: ['fsl,ls1028a-dspi', 'fsl,ls1021a-v1.0-dspi']
   arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dtb: /soc/spi@2110000: failed to match any schema with compatible: ['fsl,ls1028a-dspi', 'fsl,ls1021a-v1.0-dspi']
   arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dtb: /soc/spi@2120000: failed to match any schema with compatible: ['fsl,ls1028a-dspi', 'fsl,ls1021a-v1.0-dspi']
   arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dtb: /soc/spi@2120000: failed to match any schema with compatible: ['fsl,ls1028a-dspi', 'fsl,ls1021a-v1.0-dspi']
>> arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dtb: mmc@2140000: voltage-ranges:0: [1800, 1800, 3300, 3300] is too long
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
>> arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dtb: mmc@2140000: Unevaluated properties are not allowed ('clocks', 'voltage-ranges' were unexpected)
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
>> arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dtb: mmc@2150000: Unevaluated properties are not allowed ('clocks' was unexpected)
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
   arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dtb: /soc/gpio@2300000: failed to match any schema with compatible: ['fsl,ls1028a-gpio', 'fsl,qoriq-gpio']
   arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dtb: /soc/gpio@2300000: failed to match any schema with compatible: ['fsl,ls1028a-gpio', 'fsl,qoriq-gpio']
   arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dtb: /soc/gpio@2310000: failed to match any schema with compatible: ['fsl,ls1028a-gpio', 'fsl,qoriq-gpio']
   arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dtb: /soc/gpio@2310000: failed to match any schema with compatible: ['fsl,ls1028a-gpio', 'fsl,qoriq-gpio']
   arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dtb: /soc/gpio@2320000: failed to match any schema with compatible: ['fsl,ls1028a-gpio', 'fsl,qoriq-gpio']
   arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dtb: /soc/gpio@2320000: failed to match any schema with compatible: ['fsl,ls1028a-gpio', 'fsl,qoriq-gpio']
   arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dtb: /soc/usb@3100000: failed to match any schema with compatible: ['fsl,ls1028a-dwc3', 'snps,dwc3']
   arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dtb: /soc/usb@3110000: failed to match any schema with compatible: ['fsl,ls1028a-dwc3', 'snps,dwc3']
   arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dtb: /soc/sata@3200000: failed to match any schema with compatible: ['fsl,ls1028a-ahci']
--
   	from schema $id: http://devicetree.org/schemas/mfd/syscon.yaml#
   arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dtb: efuse@1e80000: Unevaluated properties are not allowed ('unique-id@1c' was unexpected)
   	from schema $id: http://devicetree.org/schemas/nvmem/fsl,layerscape-sfp.yaml#
   arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dtb: /soc/clock-controller@1300000: failed to match any schema with compatible: ['fsl,ls1028a-clockgen']
   arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dtb: /soc/spi@2100000: failed to match any schema with compatible: ['fsl,ls1028a-dspi', 'fsl,ls1021a-v1.0-dspi']
   arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dtb: /soc/spi@2100000: failed to match any schema with compatible: ['fsl,ls1028a-dspi', 'fsl,ls1021a-v1.0-dspi']
   arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dtb: /soc/spi@2110000: failed to match any schema with compatible: ['fsl,ls1028a-dspi', 'fsl,ls1021a-v1.0-dspi']
   arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dtb: /soc/spi@2110000: failed to match any schema with compatible: ['fsl,ls1028a-dspi', 'fsl,ls1021a-v1.0-dspi']
   arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dtb: /soc/spi@2120000: failed to match any schema with compatible: ['fsl,ls1028a-dspi', 'fsl,ls1021a-v1.0-dspi']
   arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dtb: /soc/spi@2120000: failed to match any schema with compatible: ['fsl,ls1028a-dspi', 'fsl,ls1021a-v1.0-dspi']
>> arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dtb: mmc@2140000: voltage-ranges:0: [1800, 1800, 3300, 3300] is too long
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
>> arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dtb: mmc@2140000: Unevaluated properties are not allowed ('clocks', 'voltage-ranges' were unexpected)
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
>> arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dtb: mmc@2150000: Unevaluated properties are not allowed ('clocks' was unexpected)
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
   arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dtb: can@2180000: 'can-transceiver' does not match any of the regexes: 'pinctrl-[0-9]+'
   	from schema $id: http://devicetree.org/schemas/net/can/fsl,flexcan.yaml#
   arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dtb: can@2190000: 'can-transceiver' does not match any of the regexes: 'pinctrl-[0-9]+'
   	from schema $id: http://devicetree.org/schemas/net/can/fsl,flexcan.yaml#
   arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dtb: /soc/gpio@2300000: failed to match any schema with compatible: ['fsl,ls1028a-gpio', 'fsl,qoriq-gpio']
   arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dtb: /soc/gpio@2300000: failed to match any schema with compatible: ['fsl,ls1028a-gpio', 'fsl,qoriq-gpio']
   arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dtb: /soc/gpio@2310000: failed to match any schema with compatible: ['fsl,ls1028a-gpio', 'fsl,qoriq-gpio']
   arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dtb: /soc/gpio@2310000: failed to match any schema with compatible: ['fsl,ls1028a-gpio', 'fsl,qoriq-gpio']
   arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dtb: /soc/gpio@2320000: failed to match any schema with compatible: ['fsl,ls1028a-gpio', 'fsl,qoriq-gpio']
--
   arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dtb: mdio-mux-emi1@54: mdio@20:reg:0:0: 32 is greater than the maximum of 31
   	from schema $id: http://devicetree.org/schemas/net/mdio.yaml#
   arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dtb: mdio-mux-emi1@54: mdio@40:reg:0:0: 64 is greater than the maximum of 31
   	from schema $id: http://devicetree.org/schemas/net/mdio.yaml#
   arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dtb: mdio-mux-emi1@54: mdio@60:reg:0:0: 96 is greater than the maximum of 31
   	from schema $id: http://devicetree.org/schemas/net/mdio.yaml#
   arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dtb: mdio-mux-emi1@54: mdio@80:reg:0:0: 128 is greater than the maximum of 31
   	from schema $id: http://devicetree.org/schemas/net/mdio.yaml#
   arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dtb: mdio-mux-emi1@54: mdio@a0:reg:0:0: 160 is greater than the maximum of 31
   	from schema $id: http://devicetree.org/schemas/net/mdio.yaml#
>> arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dtb: esdhc@1560000: voltage-ranges:0: [1800, 1800, 3300, 3300] is too long
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
>> arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dtb: esdhc@1560000: $nodename:0: 'esdhc@1560000' does not match '^mmc(@.*)?$'
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
>> arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dtb: esdhc@1560000: Unevaluated properties are not allowed ('big-endian', 'bus-width', 'voltage-ranges' were unexpected)
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
   arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dtb: memory-controller@1080000: 'big-endian' does not match any of the regexes: 'pinctrl-[0-9]+'
   	from schema $id: http://devicetree.org/schemas/memory-controllers/fsl/fsl,ddr.yaml#
   arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dtb: /soc/qman@1880000: failed to match any schema with compatible: ['fsl,qman']
   arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dtb: /soc/bman@1890000: failed to match any schema with compatible: ['fsl,bman']
   arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dtb: bman-portals@508000000: $nodename:0: 'bman-portals@508000000' does not match '^([a-z][a-z0-9\\-]+-bus|bus|localbus|soc|axi|ahb|apb)(@.+)?$'
   	from schema $id: http://devicetree.org/schemas/simple-bus.yaml#
   arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dtb: /soc/bman-portals@508000000/bman-portal@0: failed to match any schema with compatible: ['fsl,bman-portal']
   arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dtb: /soc/bman-portals@508000000/bman-portal@10000: failed to match any schema with compatible: ['fsl,bman-portal']
   arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dtb: /soc/bman-portals@508000000/bman-portal@20000: failed to match any schema with compatible: ['fsl,bman-portal']
--
   arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dtb: thermal-zones: 'core-cluster', 'ddr-controller', 'fman', 'sec', 'serdes' do not match any of the regexes: '^[a-zA-Z][a-zA-Z0-9\\-]{1,12}-thermal$', 'pinctrl-[0-9]+'
   	from schema $id: http://devicetree.org/schemas/thermal/thermal-zones.yaml#
   arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dtb: /soc/clocking@1ee1000: failed to match any schema with compatible: ['fsl,ls1043a-clockgen']
   arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dtb: nor@0,0: $nodename:0: 'nor@0,0' does not match '^(flash|.*sram|nand)(@.*)?$'
   	from schema $id: http://devicetree.org/schemas/mtd/mtd-physmap.yaml#
   arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dtb: /soc/memory-controller@1530000/nand@1,0: failed to match any schema with compatible: ['fsl,ifc-nand']
   arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dtb: /soc/memory-controller@1530000/board-control@2,0: failed to match any schema with compatible: ['fsl,ls1043ardb-cpld']
>> arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dtb: esdhc@1560000: voltage-ranges:0: [1800, 1800, 3300, 3300] is too long
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
>> arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dtb: esdhc@1560000: $nodename:0: 'esdhc@1560000' does not match '^mmc(@.*)?$'
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
>> arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dtb: esdhc@1560000: Unevaluated properties are not allowed ('big-endian', 'bus-width', 'voltage-ranges' were unexpected)
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
   arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dtb: memory-controller@1080000: 'big-endian' does not match any of the regexes: 'pinctrl-[0-9]+'
   	from schema $id: http://devicetree.org/schemas/memory-controllers/fsl/fsl,ddr.yaml#
   arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dtb: /soc/qman@1880000: failed to match any schema with compatible: ['fsl,qman']
   arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dtb: /soc/bman@1890000: failed to match any schema with compatible: ['fsl,bman']
   arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dtb: bman-portals@508000000: $nodename:0: 'bman-portals@508000000' does not match '^([a-z][a-z0-9\\-]+-bus|bus|localbus|soc|axi|ahb|apb)(@.+)?$'
   	from schema $id: http://devicetree.org/schemas/simple-bus.yaml#
   arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dtb: /soc/bman-portals@508000000/bman-portal@0: failed to match any schema with compatible: ['fsl,bman-portal']
   arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dtb: /soc/bman-portals@508000000/bman-portal@10000: failed to match any schema with compatible: ['fsl,bman-portal']
   arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dtb: /soc/bman-portals@508000000/bman-portal@20000: failed to match any schema with compatible: ['fsl,bman-portal']
--
   arch/arm64/boot/dts/freescale/fsl-ls1043a-tqmls1043a.dtsi:17.19-31.4: Warning (avoid_unnecessary_addr_size): /soc/spi@1550000/flash@0: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
   arch/arm64/boot/dts/freescale/fsl-ls1043a-tqmls1043a-mbls10xxa.dtb: thermal-zones: 'core-cluster', 'ddr-controller', 'fman', 'sec', 'serdes' do not match any of the regexes: '^[a-zA-Z][a-zA-Z0-9\\-]{1,12}-thermal$', 'pinctrl-[0-9]+'
   	from schema $id: http://devicetree.org/schemas/thermal/thermal-zones.yaml#
   arch/arm64/boot/dts/freescale/fsl-ls1043a-tqmls1043a-mbls10xxa.dtb: /soc/clocking@1ee1000: failed to match any schema with compatible: ['fsl,ls1043a-clockgen']
>> arch/arm64/boot/dts/freescale/fsl-ls1043a-tqmls1043a-mbls10xxa.dtb: esdhc@1560000: voltage-ranges:0: [1800, 1800, 3300, 3300] is too long
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
>> arch/arm64/boot/dts/freescale/fsl-ls1043a-tqmls1043a-mbls10xxa.dtb: esdhc@1560000: $nodename:0: 'esdhc@1560000' does not match '^mmc(@.*)?$'
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
>> arch/arm64/boot/dts/freescale/fsl-ls1043a-tqmls1043a-mbls10xxa.dtb: esdhc@1560000: Unevaluated properties are not allowed ('big-endian', 'bus-width', 'cd-gpios', 'disable-wp', 'mmc-hs200-1_8v', 'non-removable', 'sd-uhs-sdr104', 'sd-uhs-sdr12', 'sd-uhs-sdr25', 'sd-uhs-sdr50', 'voltage-ranges', 'wp-gpios' were unexpected)
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
   arch/arm64/boot/dts/freescale/fsl-ls1043a-tqmls1043a-mbls10xxa.dtb: memory-controller@1080000: 'big-endian' does not match any of the regexes: 'pinctrl-[0-9]+'
   	from schema $id: http://devicetree.org/schemas/memory-controllers/fsl/fsl,ddr.yaml#
   arch/arm64/boot/dts/freescale/fsl-ls1043a-tqmls1043a-mbls10xxa.dtb: /soc/qman@1880000: failed to match any schema with compatible: ['fsl,qman']
   arch/arm64/boot/dts/freescale/fsl-ls1043a-tqmls1043a-mbls10xxa.dtb: /soc/bman@1890000: failed to match any schema with compatible: ['fsl,bman']
   arch/arm64/boot/dts/freescale/fsl-ls1043a-tqmls1043a-mbls10xxa.dtb: bman-portals@508000000: $nodename:0: 'bman-portals@508000000' does not match '^([a-z][a-z0-9\\-]+-bus|bus|localbus|soc|axi|ahb|apb)(@.+)?$'
   	from schema $id: http://devicetree.org/schemas/simple-bus.yaml#
   arch/arm64/boot/dts/freescale/fsl-ls1043a-tqmls1043a-mbls10xxa.dtb: /soc/bman-portals@508000000/bman-portal@0: failed to match any schema with compatible: ['fsl,bman-portal']
   arch/arm64/boot/dts/freescale/fsl-ls1043a-tqmls1043a-mbls10xxa.dtb: /soc/bman-portals@508000000/bman-portal@10000: failed to match any schema with compatible: ['fsl,bman-portal']
   arch/arm64/boot/dts/freescale/fsl-ls1043a-tqmls1043a-mbls10xxa.dtb: /soc/bman-portals@508000000/bman-portal@20000: failed to match any schema with compatible: ['fsl,bman-portal']
--
   arch/arm64/boot/dts/freescale/fsl-ls1046a-frwy.dtb: thermal-zones: 'core-cluster', 'ddr-controller', 'fman', 'sec', 'serdes' do not match any of the regexes: '^[a-zA-Z][a-zA-Z0-9\\-]{1,12}-thermal$', 'pinctrl-[0-9]+'
   	from schema $id: http://devicetree.org/schemas/thermal/thermal-zones.yaml#
   arch/arm64/boot/dts/freescale/fsl-ls1046a-frwy.dtb: memory-controller@1080000: 'big-endian' does not match any of the regexes: 'pinctrl-[0-9]+'
   	from schema $id: http://devicetree.org/schemas/memory-controllers/fsl/fsl,ddr.yaml#
   arch/arm64/boot/dts/freescale/fsl-ls1046a-frwy.dtb: /soc/memory-controller@1530000/nand@0,0: failed to match any schema with compatible: ['fsl,ifc-nand']
>> arch/arm64/boot/dts/freescale/fsl-ls1046a-frwy.dtb: esdhc@1560000: voltage-ranges:0: [1800, 1800, 3300, 3300] is too long
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
>> arch/arm64/boot/dts/freescale/fsl-ls1046a-frwy.dtb: esdhc@1560000: 'clock-frequency' is a required property
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
>> arch/arm64/boot/dts/freescale/fsl-ls1046a-frwy.dtb: esdhc@1560000: $nodename:0: 'esdhc@1560000' does not match '^mmc(@.*)?$'
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
>> arch/arm64/boot/dts/freescale/fsl-ls1046a-frwy.dtb: esdhc@1560000: Unevaluated properties are not allowed ('big-endian', 'bus-width', 'clocks', 'voltage-ranges' were unexpected)
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
   arch/arm64/boot/dts/freescale/fsl-ls1046a-frwy.dtb: /soc/qman@1880000: failed to match any schema with compatible: ['fsl,qman']
   arch/arm64/boot/dts/freescale/fsl-ls1046a-frwy.dtb: /soc/bman@1890000: failed to match any schema with compatible: ['fsl,bman']
   arch/arm64/boot/dts/freescale/fsl-ls1046a-frwy.dtb: qman-portals@500000000: $nodename:0: 'qman-portals@500000000' does not match '^([a-z][a-z0-9\\-]+-bus|bus|localbus|soc|axi|ahb|apb)(@.+)?$'
   	from schema $id: http://devicetree.org/schemas/simple-bus.yaml#
   arch/arm64/boot/dts/freescale/fsl-ls1046a-frwy.dtb: /soc/qman-portals@500000000/qman-portal@0: failed to match any schema with compatible: ['fsl,qman-portal']
   arch/arm64/boot/dts/freescale/fsl-ls1046a-frwy.dtb: /soc/qman-portals@500000000/qman-portal@10000: failed to match any schema with compatible: ['fsl,qman-portal']
   arch/arm64/boot/dts/freescale/fsl-ls1046a-frwy.dtb: /soc/qman-portals@500000000/qman-portal@20000: failed to match any schema with compatible: ['fsl,qman-portal']
   arch/arm64/boot/dts/freescale/fsl-ls1046a-frwy.dtb: /soc/qman-portals@500000000/qman-portal@30000: failed to match any schema with compatible: ['fsl,qman-portal']
   arch/arm64/boot/dts/freescale/fsl-ls1046a-frwy.dtb: /soc/qman-portals@500000000/qman-portal@40000: failed to match any schema with compatible: ['fsl,qman-portal']
--
   arch/arm64/boot/dts/freescale/fsl-ls1046a-qds.dtb: /soc/memory-controller@1530000/board-control@2,0: failed to match any schema with compatible: ['fsl,ls1046aqds-fpga', 'fsl,fpga-qixis', 'simple-mfd']
   arch/arm64/boot/dts/freescale/fsl-ls1046a-qds.dtb: /soc/memory-controller@1530000/board-control@2,0: failed to match any schema with compatible: ['fsl,ls1046aqds-fpga', 'fsl,fpga-qixis', 'simple-mfd']
   arch/arm64/boot/dts/freescale/fsl-ls1046a-qds.dtb: mdio-mux-emi1: mdio@1:reg:0:0: 32 is greater than the maximum of 31
   	from schema $id: http://devicetree.org/schemas/net/mdio.yaml#
   arch/arm64/boot/dts/freescale/fsl-ls1046a-qds.dtb: mdio-mux-emi1: mdio@2:reg:0:0: 64 is greater than the maximum of 31
   	from schema $id: http://devicetree.org/schemas/net/mdio.yaml#
   arch/arm64/boot/dts/freescale/fsl-ls1046a-qds.dtb: mdio-mux-emi1: mdio@3:reg:0:0: 96 is greater than the maximum of 31
   	from schema $id: http://devicetree.org/schemas/net/mdio.yaml#
   arch/arm64/boot/dts/freescale/fsl-ls1046a-qds.dtb: mdio-mux-emi1: mdio@5:reg:0:0: 128 is greater than the maximum of 31
   	from schema $id: http://devicetree.org/schemas/net/mdio.yaml#
>> arch/arm64/boot/dts/freescale/fsl-ls1046a-qds.dtb: esdhc@1560000: voltage-ranges:0: [1800, 1800, 3300, 3300] is too long
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
>> arch/arm64/boot/dts/freescale/fsl-ls1046a-qds.dtb: esdhc@1560000: 'clock-frequency' is a required property
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
>> arch/arm64/boot/dts/freescale/fsl-ls1046a-qds.dtb: esdhc@1560000: $nodename:0: 'esdhc@1560000' does not match '^mmc(@.*)?$'
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
>> arch/arm64/boot/dts/freescale/fsl-ls1046a-qds.dtb: esdhc@1560000: Unevaluated properties are not allowed ('big-endian', 'bus-width', 'clocks', 'voltage-ranges' were unexpected)
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
   arch/arm64/boot/dts/freescale/fsl-ls1046a-qds.dtb: /soc/qman@1880000: failed to match any schema with compatible: ['fsl,qman']
   arch/arm64/boot/dts/freescale/fsl-ls1046a-qds.dtb: /soc/bman@1890000: failed to match any schema with compatible: ['fsl,bman']
   arch/arm64/boot/dts/freescale/fsl-ls1046a-qds.dtb: qman-portals@500000000: $nodename:0: 'qman-portals@500000000' does not match '^([a-z][a-z0-9\\-]+-bus|bus|localbus|soc|axi|ahb|apb)(@.+)?$'
   	from schema $id: http://devicetree.org/schemas/simple-bus.yaml#
   arch/arm64/boot/dts/freescale/fsl-ls1046a-qds.dtb: /soc/qman-portals@500000000/qman-portal@0: failed to match any schema with compatible: ['fsl,qman-portal']
   arch/arm64/boot/dts/freescale/fsl-ls1046a-qds.dtb: /soc/qman-portals@500000000/qman-portal@10000: failed to match any schema with compatible: ['fsl,qman-portal']
   arch/arm64/boot/dts/freescale/fsl-ls1046a-qds.dtb: /soc/qman-portals@500000000/qman-portal@20000: failed to match any schema with compatible: ['fsl,qman-portal']
   arch/arm64/boot/dts/freescale/fsl-ls1046a-qds.dtb: /soc/qman-portals@500000000/qman-portal@30000: failed to match any schema with compatible: ['fsl,qman-portal']
   arch/arm64/boot/dts/freescale/fsl-ls1046a-qds.dtb: /soc/qman-portals@500000000/qman-portal@40000: failed to match any schema with compatible: ['fsl,qman-portal']
--
   arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dtb: thermal-zones: 'core-cluster', 'ddr-controller', 'fman', 'sec', 'serdes' do not match any of the regexes: '^[a-zA-Z][a-zA-Z0-9\\-]{1,12}-thermal$', 'pinctrl-[0-9]+'
   	from schema $id: http://devicetree.org/schemas/thermal/thermal-zones.yaml#
   arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dtb: memory-controller@1080000: 'big-endian' does not match any of the regexes: 'pinctrl-[0-9]+'
   	from schema $id: http://devicetree.org/schemas/memory-controllers/fsl/fsl,ddr.yaml#
   arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dtb: /soc/memory-controller@1530000/nand@0,0: failed to match any schema with compatible: ['fsl,ifc-nand']
   arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dtb: /soc/memory-controller@1530000/board-control@2,0: failed to match any schema with compatible: ['fsl,ls1046ardb-cpld']
>> arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dtb: esdhc@1560000: voltage-ranges:0: [1800, 1800, 3300, 3300] is too long
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
>> arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dtb: esdhc@1560000: 'clock-frequency' is a required property
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
>> arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dtb: esdhc@1560000: $nodename:0: 'esdhc@1560000' does not match '^mmc(@.*)?$'
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
>> arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dtb: esdhc@1560000: Unevaluated properties are not allowed ('big-endian', 'bus-width', 'clocks', 'mmc-hs200-1_8v', 'sd-uhs-sdr104', 'sd-uhs-sdr12', 'sd-uhs-sdr25', 'sd-uhs-sdr50', 'voltage-ranges' were unexpected)
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
   arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dtb: /soc/qman@1880000: failed to match any schema with compatible: ['fsl,qman']
   arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dtb: /soc/bman@1890000: failed to match any schema with compatible: ['fsl,bman']
   arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dtb: qman-portals@500000000: $nodename:0: 'qman-portals@500000000' does not match '^([a-z][a-z0-9\\-]+-bus|bus|localbus|soc|axi|ahb|apb)(@.+)?$'
   	from schema $id: http://devicetree.org/schemas/simple-bus.yaml#
   arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dtb: /soc/qman-portals@500000000/qman-portal@0: failed to match any schema with compatible: ['fsl,qman-portal']
   arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dtb: /soc/qman-portals@500000000/qman-portal@10000: failed to match any schema with compatible: ['fsl,qman-portal']
   arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dtb: /soc/qman-portals@500000000/qman-portal@20000: failed to match any schema with compatible: ['fsl,qman-portal']
   arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dtb: /soc/qman-portals@500000000/qman-portal@30000: failed to match any schema with compatible: ['fsl,qman-portal']
   arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dtb: /soc/qman-portals@500000000/qman-portal@40000: failed to match any schema with compatible: ['fsl,qman-portal']
--
   arch/arm64/boot/dts/freescale/fsl-ls1046a-tqmls1046a.dtsi:17.19-31.4: Warning (avoid_unnecessary_addr_size): /soc/spi@1550000/flash@0: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
   arch/arm64/boot/dts/freescale/fsl-ls1046a-tqmls1046a-mbls10xxa.dtb: thermal-zones: 'core-cluster', 'ddr-controller', 'fman', 'sec', 'serdes' do not match any of the regexes: '^[a-zA-Z][a-zA-Z0-9\\-]{1,12}-thermal$', 'pinctrl-[0-9]+'
   	from schema $id: http://devicetree.org/schemas/thermal/thermal-zones.yaml#
   arch/arm64/boot/dts/freescale/fsl-ls1046a-tqmls1046a-mbls10xxa.dtb: memory-controller@1080000: 'big-endian' does not match any of the regexes: 'pinctrl-[0-9]+'
   	from schema $id: http://devicetree.org/schemas/memory-controllers/fsl/fsl,ddr.yaml#
>> arch/arm64/boot/dts/freescale/fsl-ls1046a-tqmls1046a-mbls10xxa.dtb: esdhc@1560000: voltage-ranges:0: [1800, 1800, 3300, 3300] is too long
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
>> arch/arm64/boot/dts/freescale/fsl-ls1046a-tqmls1046a-mbls10xxa.dtb: esdhc@1560000: 'clock-frequency' is a required property
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
>> arch/arm64/boot/dts/freescale/fsl-ls1046a-tqmls1046a-mbls10xxa.dtb: esdhc@1560000: $nodename:0: 'esdhc@1560000' does not match '^mmc(@.*)?$'
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
>> arch/arm64/boot/dts/freescale/fsl-ls1046a-tqmls1046a-mbls10xxa.dtb: esdhc@1560000: Unevaluated properties are not allowed ('big-endian', 'bus-width', 'cd-gpios', 'clocks', 'disable-wp', 'mmc-hs200-1_8v', 'non-removable', 'sd-uhs-sdr104', 'sd-uhs-sdr12', 'sd-uhs-sdr25', 'sd-uhs-sdr50', 'voltage-ranges', 'wp-gpios' were unexpected)
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
   arch/arm64/boot/dts/freescale/fsl-ls1046a-tqmls1046a-mbls10xxa.dtb: /soc/qman@1880000: failed to match any schema with compatible: ['fsl,qman']
   arch/arm64/boot/dts/freescale/fsl-ls1046a-tqmls1046a-mbls10xxa.dtb: /soc/bman@1890000: failed to match any schema with compatible: ['fsl,bman']
   arch/arm64/boot/dts/freescale/fsl-ls1046a-tqmls1046a-mbls10xxa.dtb: qman-portals@500000000: $nodename:0: 'qman-portals@500000000' does not match '^([a-z][a-z0-9\\-]+-bus|bus|localbus|soc|axi|ahb|apb)(@.+)?$'
   	from schema $id: http://devicetree.org/schemas/simple-bus.yaml#
   arch/arm64/boot/dts/freescale/fsl-ls1046a-tqmls1046a-mbls10xxa.dtb: /soc/qman-portals@500000000/qman-portal@0: failed to match any schema with compatible: ['fsl,qman-portal']
   arch/arm64/boot/dts/freescale/fsl-ls1046a-tqmls1046a-mbls10xxa.dtb: /soc/qman-portals@500000000/qman-portal@10000: failed to match any schema with compatible: ['fsl,qman-portal']
   arch/arm64/boot/dts/freescale/fsl-ls1046a-tqmls1046a-mbls10xxa.dtb: /soc/qman-portals@500000000/qman-portal@20000: failed to match any schema with compatible: ['fsl,qman-portal']
   arch/arm64/boot/dts/freescale/fsl-ls1046a-tqmls1046a-mbls10xxa.dtb: /soc/qman-portals@500000000/qman-portal@30000: failed to match any schema with compatible: ['fsl,qman-portal']
   arch/arm64/boot/dts/freescale/fsl-ls1046a-tqmls1046a-mbls10xxa.dtb: /soc/qman-portals@500000000/qman-portal@40000: failed to match any schema with compatible: ['fsl,qman-portal']
--
   arch/arm64/boot/dts/freescale/fsl-ls1088a-qds.dtb: /soc/gpio@2310000: failed to match any schema with compatible: ['fsl,ls1088a-gpio', 'fsl,qoriq-gpio']
   arch/arm64/boot/dts/freescale/fsl-ls1088a-qds.dtb: /soc/gpio@2320000: failed to match any schema with compatible: ['fsl,ls1088a-gpio', 'fsl,qoriq-gpio']
   arch/arm64/boot/dts/freescale/fsl-ls1088a-qds.dtb: /soc/gpio@2320000: failed to match any schema with compatible: ['fsl,ls1088a-gpio', 'fsl,qoriq-gpio']
   arch/arm64/boot/dts/freescale/fsl-ls1088a-qds.dtb: /soc/gpio@2330000: failed to match any schema with compatible: ['fsl,ls1088a-gpio', 'fsl,qoriq-gpio']
   arch/arm64/boot/dts/freescale/fsl-ls1088a-qds.dtb: /soc/gpio@2330000: failed to match any schema with compatible: ['fsl,ls1088a-gpio', 'fsl,qoriq-gpio']
   arch/arm64/boot/dts/freescale/fsl-ls1088a-qds.dtb: nor@0,0: $nodename:0: 'nor@0,0' does not match '^(flash|.*sram|nand)(@.*)?$'
   	from schema $id: http://devicetree.org/schemas/mtd/mtd-physmap.yaml#
   arch/arm64/boot/dts/freescale/fsl-ls1088a-qds.dtb: /soc/memory-controller@2240000/nand@2,0: failed to match any schema with compatible: ['fsl,ifc-nand']
   arch/arm64/boot/dts/freescale/fsl-ls1088a-qds.dtb: /soc/memory-controller@2240000/board-control@3,0: failed to match any schema with compatible: ['fsl,ls1088aqds-fpga', 'fsl,fpga-qixis']
   arch/arm64/boot/dts/freescale/fsl-ls1088a-qds.dtb: /soc/memory-controller@2240000/board-control@3,0: failed to match any schema with compatible: ['fsl,ls1088aqds-fpga', 'fsl,fpga-qixis']
>> arch/arm64/boot/dts/freescale/fsl-ls1088a-qds.dtb: esdhc@2140000: voltage-ranges:0: [1800, 1800, 3300, 3300] is too long
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
>> arch/arm64/boot/dts/freescale/fsl-ls1088a-qds.dtb: esdhc@2140000: $nodename:0: 'esdhc@2140000' does not match '^mmc(@.*)?$'
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
>> arch/arm64/boot/dts/freescale/fsl-ls1088a-qds.dtb: esdhc@2140000: Unevaluated properties are not allowed ('bus-width', 'clocks', 'voltage-ranges' were unexpected)
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
   arch/arm64/boot/dts/freescale/fsl-ls1088a-qds.dtb: /soc/sata@3200000: failed to match any schema with compatible: ['fsl,ls1088a-ahci']
   arch/arm64/boot/dts/freescale/fsl-ls1088a-qds.dtb: pcie-ep@3400000: compatible: ['fsl,ls1088a-pcie-ep', 'fsl,ls-pcie-ep'] is too long
   	from schema $id: http://devicetree.org/schemas/pci/fsl,layerscape-pcie-ep.yaml#
   arch/arm64/boot/dts/freescale/fsl-ls1088a-qds.dtb: /soc/pcie-ep@3400000: failed to match any schema with compatible: ['fsl,ls1088a-pcie-ep', 'fsl,ls-pcie-ep']
   arch/arm64/boot/dts/freescale/fsl-ls1088a-qds.dtb: pcie-ep@3500000: compatible: ['fsl,ls1088a-pcie-ep', 'fsl,ls-pcie-ep'] is too long
   	from schema $id: http://devicetree.org/schemas/pci/fsl,layerscape-pcie-ep.yaml#
   arch/arm64/boot/dts/freescale/fsl-ls1088a-qds.dtb: /soc/pcie-ep@3500000: failed to match any schema with compatible: ['fsl,ls1088a-pcie-ep', 'fsl,ls-pcie-ep']
   arch/arm64/boot/dts/freescale/fsl-ls1088a-qds.dtb: pcie-ep@3600000: compatible: ['fsl,ls1088a-pcie-ep', 'fsl,ls-pcie-ep'] is too long
   	from schema $id: http://devicetree.org/schemas/pci/fsl,layerscape-pcie-ep.yaml#
--
   arch/arm64/boot/dts/freescale/fsl-ls1088a-rdb.dtb: /soc/gpio@2300000: failed to match any schema with compatible: ['fsl,ls1088a-gpio', 'fsl,qoriq-gpio']
   arch/arm64/boot/dts/freescale/fsl-ls1088a-rdb.dtb: /soc/gpio@2310000: failed to match any schema with compatible: ['fsl,ls1088a-gpio', 'fsl,qoriq-gpio']
   arch/arm64/boot/dts/freescale/fsl-ls1088a-rdb.dtb: /soc/gpio@2310000: failed to match any schema with compatible: ['fsl,ls1088a-gpio', 'fsl,qoriq-gpio']
   arch/arm64/boot/dts/freescale/fsl-ls1088a-rdb.dtb: /soc/gpio@2320000: failed to match any schema with compatible: ['fsl,ls1088a-gpio', 'fsl,qoriq-gpio']
   arch/arm64/boot/dts/freescale/fsl-ls1088a-rdb.dtb: /soc/gpio@2320000: failed to match any schema with compatible: ['fsl,ls1088a-gpio', 'fsl,qoriq-gpio']
   arch/arm64/boot/dts/freescale/fsl-ls1088a-rdb.dtb: /soc/gpio@2330000: failed to match any schema with compatible: ['fsl,ls1088a-gpio', 'fsl,qoriq-gpio']
   arch/arm64/boot/dts/freescale/fsl-ls1088a-rdb.dtb: /soc/gpio@2330000: failed to match any schema with compatible: ['fsl,ls1088a-gpio', 'fsl,qoriq-gpio']
   arch/arm64/boot/dts/freescale/fsl-ls1088a-rdb.dtb: /soc/memory-controller@2240000/nand@0,0: failed to match any schema with compatible: ['fsl,ifc-nand']
   arch/arm64/boot/dts/freescale/fsl-ls1088a-rdb.dtb: /soc/memory-controller@2240000/board-control@2,0: failed to match any schema with compatible: ['fsl,ls1088ardb-fpga', 'fsl,fpga-qixis']
   arch/arm64/boot/dts/freescale/fsl-ls1088a-rdb.dtb: /soc/memory-controller@2240000/board-control@2,0: failed to match any schema with compatible: ['fsl,ls1088ardb-fpga', 'fsl,fpga-qixis']
>> arch/arm64/boot/dts/freescale/fsl-ls1088a-rdb.dtb: esdhc@2140000: voltage-ranges:0: [1800, 1800, 3300, 3300] is too long
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
>> arch/arm64/boot/dts/freescale/fsl-ls1088a-rdb.dtb: esdhc@2140000: $nodename:0: 'esdhc@2140000' does not match '^mmc(@.*)?$'
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
>> arch/arm64/boot/dts/freescale/fsl-ls1088a-rdb.dtb: esdhc@2140000: Unevaluated properties are not allowed ('bus-width', 'clocks', 'mmc-hs200-1_8v', 'voltage-ranges' were unexpected)
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
   arch/arm64/boot/dts/freescale/fsl-ls1088a-rdb.dtb: /soc/sata@3200000: failed to match any schema with compatible: ['fsl,ls1088a-ahci']
   arch/arm64/boot/dts/freescale/fsl-ls1088a-rdb.dtb: pcie-ep@3400000: compatible: ['fsl,ls1088a-pcie-ep', 'fsl,ls-pcie-ep'] is too long
   	from schema $id: http://devicetree.org/schemas/pci/fsl,layerscape-pcie-ep.yaml#
   arch/arm64/boot/dts/freescale/fsl-ls1088a-rdb.dtb: /soc/pcie-ep@3400000: failed to match any schema with compatible: ['fsl,ls1088a-pcie-ep', 'fsl,ls-pcie-ep']
   arch/arm64/boot/dts/freescale/fsl-ls1088a-rdb.dtb: pcie-ep@3500000: compatible: ['fsl,ls1088a-pcie-ep', 'fsl,ls-pcie-ep'] is too long
   	from schema $id: http://devicetree.org/schemas/pci/fsl,layerscape-pcie-ep.yaml#
   arch/arm64/boot/dts/freescale/fsl-ls1088a-rdb.dtb: /soc/pcie-ep@3500000: failed to match any schema with compatible: ['fsl,ls1088a-pcie-ep', 'fsl,ls-pcie-ep']
   arch/arm64/boot/dts/freescale/fsl-ls1088a-rdb.dtb: pcie-ep@3600000: compatible: ['fsl,ls1088a-pcie-ep', 'fsl,ls-pcie-ep'] is too long
   	from schema $id: http://devicetree.org/schemas/pci/fsl,layerscape-pcie-ep.yaml#
--
   arch/arm64/boot/dts/freescale/fsl-ls1088a-ten64.dtb: /soc/gpio@2330000: failed to match any schema with compatible: ['fsl,ls1088a-gpio', 'fsl,qoriq-gpio']
   arch/arm64/boot/dts/freescale/fsl-ls1088a-ten64.dtb: /soc/gpio@2330000: failed to match any schema with compatible: ['fsl,ls1088a-gpio', 'fsl,qoriq-gpio']
   arch/arm64/boot/dts/freescale/fsl-ls1088a-ten64.dtb: gpio@76: 'admin_led_lower' does not match any of the regexes: '^(hog-[0-9]+|.+-hog(-[0-9]+)?)$', 'pinctrl-[0-9]+'
   	from schema $id: http://devicetree.org/schemas/gpio/gpio-pca95xx.yaml#
   arch/arm64/boot/dts/freescale/fsl-ls1088a-ten64.dtb: admin_led_lower: $nodename:0: 'admin_led_lower' does not match '^(hog-[0-9]+|.+-hog(-[0-9]+)?)$'
   	from schema $id: http://devicetree.org/schemas/gpio/gpio-hog.yaml#
   arch/arm64/boot/dts/freescale/fsl-ls1088a-ten64.dtb: flash@0: partitions: Unevaluated properties are not allowed ('partition@5C0000' was unexpected)
   	from schema $id: http://devicetree.org/schemas/mtd/jedec,spi-nor.yaml#
   arch/arm64/boot/dts/freescale/fsl-ls1088a-ten64.dtb: flash@0: Unevaluated properties are not allowed ('#address-cells', '#size-cells', 'partitions' were unexpected)
   	from schema $id: http://devicetree.org/schemas/mtd/jedec,spi-nor.yaml#
>> arch/arm64/boot/dts/freescale/fsl-ls1088a-ten64.dtb: esdhc@2140000: voltage-ranges:0: [1800, 1800, 3300, 3300] is too long
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
>> arch/arm64/boot/dts/freescale/fsl-ls1088a-ten64.dtb: esdhc@2140000: $nodename:0: 'esdhc@2140000' does not match '^mmc(@.*)?$'
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
>> arch/arm64/boot/dts/freescale/fsl-ls1088a-ten64.dtb: esdhc@2140000: Unevaluated properties are not allowed ('bus-width', 'clocks', 'voltage-ranges' were unexpected)
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
   arch/arm64/boot/dts/freescale/fsl-ls1088a-ten64.dtb: /soc/sata@3200000: failed to match any schema with compatible: ['fsl,ls1088a-ahci']
   arch/arm64/boot/dts/freescale/fsl-ls1088a-ten64.dtb: pcie-ep@3400000: compatible: ['fsl,ls1088a-pcie-ep', 'fsl,ls-pcie-ep'] is too long
   	from schema $id: http://devicetree.org/schemas/pci/fsl,layerscape-pcie-ep.yaml#
   arch/arm64/boot/dts/freescale/fsl-ls1088a-ten64.dtb: /soc/pcie-ep@3400000: failed to match any schema with compatible: ['fsl,ls1088a-pcie-ep', 'fsl,ls-pcie-ep']
   arch/arm64/boot/dts/freescale/fsl-ls1088a-ten64.dtb: pcie-ep@3500000: compatible: ['fsl,ls1088a-pcie-ep', 'fsl,ls-pcie-ep'] is too long
   	from schema $id: http://devicetree.org/schemas/pci/fsl,layerscape-pcie-ep.yaml#
   arch/arm64/boot/dts/freescale/fsl-ls1088a-ten64.dtb: /soc/pcie-ep@3500000: failed to match any schema with compatible: ['fsl,ls1088a-pcie-ep', 'fsl,ls-pcie-ep']
   arch/arm64/boot/dts/freescale/fsl-ls1088a-ten64.dtb: pcie-ep@3600000: compatible: ['fsl,ls1088a-pcie-ep', 'fsl,ls-pcie-ep'] is too long
   	from schema $id: http://devicetree.org/schemas/pci/fsl,layerscape-pcie-ep.yaml#
--
   arch/arm64/boot/dts/freescale/fsl-ls1088a-tqmls1088a-mbls10xxa.dtb: /soc/spi@2100000: failed to match any schema with compatible: ['fsl,ls1088a-dspi', 'fsl,ls1021a-v1.0-dspi']
   arch/arm64/boot/dts/freescale/fsl-ls1088a-tqmls1088a-mbls10xxa.dtb: /soc/spi@2100000: failed to match any schema with compatible: ['fsl,ls1088a-dspi', 'fsl,ls1021a-v1.0-dspi']
   arch/arm64/boot/dts/freescale/fsl-ls1088a-tqmls1088a-mbls10xxa.dtb: /soc/gpio@2300000: failed to match any schema with compatible: ['fsl,ls1088a-gpio', 'fsl,qoriq-gpio']
   arch/arm64/boot/dts/freescale/fsl-ls1088a-tqmls1088a-mbls10xxa.dtb: /soc/gpio@2300000: failed to match any schema with compatible: ['fsl,ls1088a-gpio', 'fsl,qoriq-gpio']
   arch/arm64/boot/dts/freescale/fsl-ls1088a-tqmls1088a-mbls10xxa.dtb: /soc/gpio@2310000: failed to match any schema with compatible: ['fsl,ls1088a-gpio', 'fsl,qoriq-gpio']
   arch/arm64/boot/dts/freescale/fsl-ls1088a-tqmls1088a-mbls10xxa.dtb: /soc/gpio@2310000: failed to match any schema with compatible: ['fsl,ls1088a-gpio', 'fsl,qoriq-gpio']
   arch/arm64/boot/dts/freescale/fsl-ls1088a-tqmls1088a-mbls10xxa.dtb: /soc/gpio@2320000: failed to match any schema with compatible: ['fsl,ls1088a-gpio', 'fsl,qoriq-gpio']
   arch/arm64/boot/dts/freescale/fsl-ls1088a-tqmls1088a-mbls10xxa.dtb: /soc/gpio@2320000: failed to match any schema with compatible: ['fsl,ls1088a-gpio', 'fsl,qoriq-gpio']
   arch/arm64/boot/dts/freescale/fsl-ls1088a-tqmls1088a-mbls10xxa.dtb: /soc/gpio@2330000: failed to match any schema with compatible: ['fsl,ls1088a-gpio', 'fsl,qoriq-gpio']
   arch/arm64/boot/dts/freescale/fsl-ls1088a-tqmls1088a-mbls10xxa.dtb: /soc/gpio@2330000: failed to match any schema with compatible: ['fsl,ls1088a-gpio', 'fsl,qoriq-gpio']
>> arch/arm64/boot/dts/freescale/fsl-ls1088a-tqmls1088a-mbls10xxa.dtb: esdhc@2140000: voltage-ranges:0: [1800, 1800, 3300, 3300] is too long
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
>> arch/arm64/boot/dts/freescale/fsl-ls1088a-tqmls1088a-mbls10xxa.dtb: esdhc@2140000: $nodename:0: 'esdhc@2140000' does not match '^mmc(@.*)?$'
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
>> arch/arm64/boot/dts/freescale/fsl-ls1088a-tqmls1088a-mbls10xxa.dtb: esdhc@2140000: Unevaluated properties are not allowed ('bus-width', 'cd-gpios', 'clocks', 'disable-wp', 'mmc-hs200-1_8v', 'non-removable', 'sd-uhs-sdr104', 'sd-uhs-sdr12', 'sd-uhs-sdr25', 'sd-uhs-sdr50', 'voltage-ranges', 'wp-gpios' were unexpected)
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
   arch/arm64/boot/dts/freescale/fsl-ls1088a-tqmls1088a-mbls10xxa.dtb: /soc/sata@3200000: failed to match any schema with compatible: ['fsl,ls1088a-ahci']
   arch/arm64/boot/dts/freescale/fsl-ls1088a-tqmls1088a-mbls10xxa.dtb: pcie-ep@3400000: compatible: ['fsl,ls1088a-pcie-ep', 'fsl,ls-pcie-ep'] is too long
   	from schema $id: http://devicetree.org/schemas/pci/fsl,layerscape-pcie-ep.yaml#
   arch/arm64/boot/dts/freescale/fsl-ls1088a-tqmls1088a-mbls10xxa.dtb: /soc/pcie-ep@3400000: failed to match any schema with compatible: ['fsl,ls1088a-pcie-ep', 'fsl,ls-pcie-ep']
   arch/arm64/boot/dts/freescale/fsl-ls1088a-tqmls1088a-mbls10xxa.dtb: pcie-ep@3500000: compatible: ['fsl,ls1088a-pcie-ep', 'fsl,ls-pcie-ep'] is too long
   	from schema $id: http://devicetree.org/schemas/pci/fsl,layerscape-pcie-ep.yaml#
   arch/arm64/boot/dts/freescale/fsl-ls1088a-tqmls1088a-mbls10xxa.dtb: /soc/pcie-ep@3500000: failed to match any schema with compatible: ['fsl,ls1088a-pcie-ep', 'fsl,ls-pcie-ep']
   arch/arm64/boot/dts/freescale/fsl-ls1088a-tqmls1088a-mbls10xxa.dtb: pcie-ep@3600000: compatible: ['fsl,ls1088a-pcie-ep', 'fsl,ls-pcie-ep'] is too long
   	from schema $id: http://devicetree.org/schemas/pci/fsl,layerscape-pcie-ep.yaml#
--
   arch/arm64/boot/dts/freescale/fsl-ls2080a-qds.dtb: /soc/mdio@8c2b000: failed to match any schema with compatible: ['fsl,fman-memac-mdio']
   arch/arm64/boot/dts/freescale/fsl-ls2080a-qds.dtb: /soc/mdio@8c2f000: failed to match any schema with compatible: ['fsl,fman-memac-mdio']
   arch/arm64/boot/dts/freescale/fsl-ls2080a-qds.dtb: /soc/mdio@8c33000: failed to match any schema with compatible: ['fsl,fman-memac-mdio']
   arch/arm64/boot/dts/freescale/fsl-ls2080a-qds.dtb: /soc/mdio@8c37000: failed to match any schema with compatible: ['fsl,fman-memac-mdio']
   arch/arm64/boot/dts/freescale/fsl-ls2080a-qds.dtb: /soc/mdio@8c3b000: failed to match any schema with compatible: ['fsl,fman-memac-mdio']
   arch/arm64/boot/dts/freescale/fsl-ls2080a-qds.dtb: /soc/mdio@8c3f000: failed to match any schema with compatible: ['fsl,fman-memac-mdio']
   arch/arm64/boot/dts/freescale/fsl-ls2080a-qds.dtb: /soc/mdio@8c43000: failed to match any schema with compatible: ['fsl,fman-memac-mdio']
   arch/arm64/boot/dts/freescale/fsl-ls2080a-qds.dtb: /soc/fsl-mc@80c000000: failed to match any schema with compatible: ['fsl,qoriq-mc']
   arch/arm64/boot/dts/freescale/fsl-ls2080a-qds.dtb: /soc/spi@2100000: failed to match any schema with compatible: ['fsl,ls2080a-dspi', 'fsl,ls2085a-dspi']
   arch/arm64/boot/dts/freescale/fsl-ls2080a-qds.dtb: /soc/spi@2100000: failed to match any schema with compatible: ['fsl,ls2080a-dspi', 'fsl,ls2085a-dspi']
>> arch/arm64/boot/dts/freescale/fsl-ls2080a-qds.dtb: esdhc@2140000: voltage-ranges:0: [1800, 1800, 3300, 3300] is too long
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
>> arch/arm64/boot/dts/freescale/fsl-ls2080a-qds.dtb: esdhc@2140000: 'clock-frequency' is a required property
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
>> arch/arm64/boot/dts/freescale/fsl-ls2080a-qds.dtb: esdhc@2140000: $nodename:0: 'esdhc@2140000' does not match '^mmc(@.*)?$'
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
>> arch/arm64/boot/dts/freescale/fsl-ls2080a-qds.dtb: esdhc@2140000: Unevaluated properties are not allowed ('bus-width', 'clocks', 'mmc-hs200-1_8v', 'voltage-ranges' were unexpected)
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
   arch/arm64/boot/dts/freescale/fsl-ls2080a-qds.dtb: /soc/gpio@2300000: failed to match any schema with compatible: ['fsl,ls2080a-gpio', 'fsl,qoriq-gpio']
   arch/arm64/boot/dts/freescale/fsl-ls2080a-qds.dtb: /soc/gpio@2300000: failed to match any schema with compatible: ['fsl,ls2080a-gpio', 'fsl,qoriq-gpio']
   arch/arm64/boot/dts/freescale/fsl-ls2080a-qds.dtb: /soc/gpio@2310000: failed to match any schema with compatible: ['fsl,ls2080a-gpio', 'fsl,qoriq-gpio']
   arch/arm64/boot/dts/freescale/fsl-ls2080a-qds.dtb: /soc/gpio@2310000: failed to match any schema with compatible: ['fsl,ls2080a-gpio', 'fsl,qoriq-gpio']
   arch/arm64/boot/dts/freescale/fsl-ls2080a-qds.dtb: /soc/gpio@2320000: failed to match any schema with compatible: ['fsl,ls2080a-gpio', 'fsl,qoriq-gpio']
   arch/arm64/boot/dts/freescale/fsl-ls2080a-qds.dtb: /soc/gpio@2320000: failed to match any schema with compatible: ['fsl,ls2080a-gpio', 'fsl,qoriq-gpio']
   arch/arm64/boot/dts/freescale/fsl-ls2080a-qds.dtb: /soc/gpio@2330000: failed to match any schema with compatible: ['fsl,ls2080a-gpio', 'fsl,qoriq-gpio']
   arch/arm64/boot/dts/freescale/fsl-ls2080a-qds.dtb: /soc/gpio@2330000: failed to match any schema with compatible: ['fsl,ls2080a-gpio', 'fsl,qoriq-gpio']
   arch/arm64/boot/dts/freescale/fsl-ls2080a-qds.dtb: i2c@2000000: clock-names:0: 'ipg' was expected
--
   arch/arm64/boot/dts/freescale/fsl-ls2080a-rdb.dtb: /soc/mdio@8c2b000: failed to match any schema with compatible: ['fsl,fman-memac-mdio']
   arch/arm64/boot/dts/freescale/fsl-ls2080a-rdb.dtb: /soc/mdio@8c2f000: failed to match any schema with compatible: ['fsl,fman-memac-mdio']
   arch/arm64/boot/dts/freescale/fsl-ls2080a-rdb.dtb: /soc/mdio@8c33000: failed to match any schema with compatible: ['fsl,fman-memac-mdio']
   arch/arm64/boot/dts/freescale/fsl-ls2080a-rdb.dtb: /soc/mdio@8c37000: failed to match any schema with compatible: ['fsl,fman-memac-mdio']
   arch/arm64/boot/dts/freescale/fsl-ls2080a-rdb.dtb: /soc/mdio@8c3b000: failed to match any schema with compatible: ['fsl,fman-memac-mdio']
   arch/arm64/boot/dts/freescale/fsl-ls2080a-rdb.dtb: /soc/mdio@8c3f000: failed to match any schema with compatible: ['fsl,fman-memac-mdio']
   arch/arm64/boot/dts/freescale/fsl-ls2080a-rdb.dtb: /soc/mdio@8c43000: failed to match any schema with compatible: ['fsl,fman-memac-mdio']
   arch/arm64/boot/dts/freescale/fsl-ls2080a-rdb.dtb: /soc/fsl-mc@80c000000: failed to match any schema with compatible: ['fsl,qoriq-mc']
   arch/arm64/boot/dts/freescale/fsl-ls2080a-rdb.dtb: /soc/spi@2100000: failed to match any schema with compatible: ['fsl,ls2080a-dspi', 'fsl,ls2085a-dspi']
   arch/arm64/boot/dts/freescale/fsl-ls2080a-rdb.dtb: /soc/spi@2100000: failed to match any schema with compatible: ['fsl,ls2080a-dspi', 'fsl,ls2085a-dspi']
>> arch/arm64/boot/dts/freescale/fsl-ls2080a-rdb.dtb: esdhc@2140000: voltage-ranges:0: [1800, 1800, 3300, 3300] is too long
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
>> arch/arm64/boot/dts/freescale/fsl-ls2080a-rdb.dtb: esdhc@2140000: 'clock-frequency' is a required property
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
>> arch/arm64/boot/dts/freescale/fsl-ls2080a-rdb.dtb: esdhc@2140000: $nodename:0: 'esdhc@2140000' does not match '^mmc(@.*)?$'
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
>> arch/arm64/boot/dts/freescale/fsl-ls2080a-rdb.dtb: esdhc@2140000: Unevaluated properties are not allowed ('bus-width', 'clocks', 'voltage-ranges' were unexpected)
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
   arch/arm64/boot/dts/freescale/fsl-ls2080a-rdb.dtb: /soc/gpio@2300000: failed to match any schema with compatible: ['fsl,ls2080a-gpio', 'fsl,qoriq-gpio']
   arch/arm64/boot/dts/freescale/fsl-ls2080a-rdb.dtb: /soc/gpio@2300000: failed to match any schema with compatible: ['fsl,ls2080a-gpio', 'fsl,qoriq-gpio']
   arch/arm64/boot/dts/freescale/fsl-ls2080a-rdb.dtb: /soc/gpio@2310000: failed to match any schema with compatible: ['fsl,ls2080a-gpio', 'fsl,qoriq-gpio']
   arch/arm64/boot/dts/freescale/fsl-ls2080a-rdb.dtb: /soc/gpio@2310000: failed to match any schema with compatible: ['fsl,ls2080a-gpio', 'fsl,qoriq-gpio']
   arch/arm64/boot/dts/freescale/fsl-ls2080a-rdb.dtb: /soc/gpio@2320000: failed to match any schema with compatible: ['fsl,ls2080a-gpio', 'fsl,qoriq-gpio']
   arch/arm64/boot/dts/freescale/fsl-ls2080a-rdb.dtb: /soc/gpio@2320000: failed to match any schema with compatible: ['fsl,ls2080a-gpio', 'fsl,qoriq-gpio']
   arch/arm64/boot/dts/freescale/fsl-ls2080a-rdb.dtb: /soc/gpio@2330000: failed to match any schema with compatible: ['fsl,ls2080a-gpio', 'fsl,qoriq-gpio']
   arch/arm64/boot/dts/freescale/fsl-ls2080a-rdb.dtb: /soc/gpio@2330000: failed to match any schema with compatible: ['fsl,ls2080a-gpio', 'fsl,qoriq-gpio']
   arch/arm64/boot/dts/freescale/fsl-ls2080a-rdb.dtb: i2c@2000000: clock-names:0: 'ipg' was expected
--
   arch/arm64/boot/dts/freescale/fsl-ls2081a-rdb.dtb: /soc/mdio@8c2b000: failed to match any schema with compatible: ['fsl,fman-memac-mdio']
   arch/arm64/boot/dts/freescale/fsl-ls2081a-rdb.dtb: /soc/mdio@8c2f000: failed to match any schema with compatible: ['fsl,fman-memac-mdio']
   arch/arm64/boot/dts/freescale/fsl-ls2081a-rdb.dtb: /soc/mdio@8c33000: failed to match any schema with compatible: ['fsl,fman-memac-mdio']
   arch/arm64/boot/dts/freescale/fsl-ls2081a-rdb.dtb: /soc/mdio@8c37000: failed to match any schema with compatible: ['fsl,fman-memac-mdio']
   arch/arm64/boot/dts/freescale/fsl-ls2081a-rdb.dtb: /soc/mdio@8c3b000: failed to match any schema with compatible: ['fsl,fman-memac-mdio']
   arch/arm64/boot/dts/freescale/fsl-ls2081a-rdb.dtb: /soc/mdio@8c3f000: failed to match any schema with compatible: ['fsl,fman-memac-mdio']
   arch/arm64/boot/dts/freescale/fsl-ls2081a-rdb.dtb: /soc/mdio@8c43000: failed to match any schema with compatible: ['fsl,fman-memac-mdio']
   arch/arm64/boot/dts/freescale/fsl-ls2081a-rdb.dtb: /soc/fsl-mc@80c000000: failed to match any schema with compatible: ['fsl,qoriq-mc']
   arch/arm64/boot/dts/freescale/fsl-ls2081a-rdb.dtb: /soc/spi@2100000: failed to match any schema with compatible: ['fsl,ls2080a-dspi', 'fsl,ls2085a-dspi']
   arch/arm64/boot/dts/freescale/fsl-ls2081a-rdb.dtb: /soc/spi@2100000: failed to match any schema with compatible: ['fsl,ls2080a-dspi', 'fsl,ls2085a-dspi']
>> arch/arm64/boot/dts/freescale/fsl-ls2081a-rdb.dtb: esdhc@2140000: voltage-ranges:0: [1800, 1800, 3300, 3300] is too long
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
>> arch/arm64/boot/dts/freescale/fsl-ls2081a-rdb.dtb: esdhc@2140000: 'clock-frequency' is a required property
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
>> arch/arm64/boot/dts/freescale/fsl-ls2081a-rdb.dtb: esdhc@2140000: $nodename:0: 'esdhc@2140000' does not match '^mmc(@.*)?$'
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
>> arch/arm64/boot/dts/freescale/fsl-ls2081a-rdb.dtb: esdhc@2140000: Unevaluated properties are not allowed ('bus-width', 'clocks', 'voltage-ranges' were unexpected)
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
   arch/arm64/boot/dts/freescale/fsl-ls2081a-rdb.dtb: /soc/gpio@2300000: failed to match any schema with compatible: ['fsl,ls2080a-gpio', 'fsl,qoriq-gpio']
   arch/arm64/boot/dts/freescale/fsl-ls2081a-rdb.dtb: /soc/gpio@2300000: failed to match any schema with compatible: ['fsl,ls2080a-gpio', 'fsl,qoriq-gpio']
   arch/arm64/boot/dts/freescale/fsl-ls2081a-rdb.dtb: /soc/gpio@2310000: failed to match any schema with compatible: ['fsl,ls2080a-gpio', 'fsl,qoriq-gpio']
   arch/arm64/boot/dts/freescale/fsl-ls2081a-rdb.dtb: /soc/gpio@2310000: failed to match any schema with compatible: ['fsl,ls2080a-gpio', 'fsl,qoriq-gpio']
   arch/arm64/boot/dts/freescale/fsl-ls2081a-rdb.dtb: /soc/gpio@2320000: failed to match any schema with compatible: ['fsl,ls2080a-gpio', 'fsl,qoriq-gpio']
   arch/arm64/boot/dts/freescale/fsl-ls2081a-rdb.dtb: /soc/gpio@2320000: failed to match any schema with compatible: ['fsl,ls2080a-gpio', 'fsl,qoriq-gpio']
   arch/arm64/boot/dts/freescale/fsl-ls2081a-rdb.dtb: /soc/gpio@2330000: failed to match any schema with compatible: ['fsl,ls2080a-gpio', 'fsl,qoriq-gpio']
   arch/arm64/boot/dts/freescale/fsl-ls2081a-rdb.dtb: /soc/gpio@2330000: failed to match any schema with compatible: ['fsl,ls2080a-gpio', 'fsl,qoriq-gpio']
   arch/arm64/boot/dts/freescale/fsl-ls2081a-rdb.dtb: i2c@2000000: clock-names:0: 'ipg' was expected
--
   arch/arm64/boot/dts/freescale/fsl-ls2080a-simu.dtb: /soc/mdio@8c2b000: failed to match any schema with compatible: ['fsl,fman-memac-mdio']
   arch/arm64/boot/dts/freescale/fsl-ls2080a-simu.dtb: /soc/mdio@8c2f000: failed to match any schema with compatible: ['fsl,fman-memac-mdio']
   arch/arm64/boot/dts/freescale/fsl-ls2080a-simu.dtb: /soc/mdio@8c33000: failed to match any schema with compatible: ['fsl,fman-memac-mdio']
   arch/arm64/boot/dts/freescale/fsl-ls2080a-simu.dtb: /soc/mdio@8c37000: failed to match any schema with compatible: ['fsl,fman-memac-mdio']
   arch/arm64/boot/dts/freescale/fsl-ls2080a-simu.dtb: /soc/mdio@8c3b000: failed to match any schema with compatible: ['fsl,fman-memac-mdio']
   arch/arm64/boot/dts/freescale/fsl-ls2080a-simu.dtb: /soc/mdio@8c3f000: failed to match any schema with compatible: ['fsl,fman-memac-mdio']
   arch/arm64/boot/dts/freescale/fsl-ls2080a-simu.dtb: /soc/mdio@8c43000: failed to match any schema with compatible: ['fsl,fman-memac-mdio']
   arch/arm64/boot/dts/freescale/fsl-ls2080a-simu.dtb: /soc/fsl-mc@80c000000: failed to match any schema with compatible: ['fsl,qoriq-mc']
   arch/arm64/boot/dts/freescale/fsl-ls2080a-simu.dtb: /soc/spi@2100000: failed to match any schema with compatible: ['fsl,ls2080a-dspi', 'fsl,ls2085a-dspi']
   arch/arm64/boot/dts/freescale/fsl-ls2080a-simu.dtb: /soc/spi@2100000: failed to match any schema with compatible: ['fsl,ls2080a-dspi', 'fsl,ls2085a-dspi']
>> arch/arm64/boot/dts/freescale/fsl-ls2080a-simu.dtb: esdhc@2140000: voltage-ranges:0: [1800, 1800, 3300, 3300] is too long
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
>> arch/arm64/boot/dts/freescale/fsl-ls2080a-simu.dtb: esdhc@2140000: $nodename:0: 'esdhc@2140000' does not match '^mmc(@.*)?$'
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
   arch/arm64/boot/dts/freescale/fsl-ls2080a-simu.dtb: /soc/gpio@2300000: failed to match any schema with compatible: ['fsl,ls2080a-gpio', 'fsl,qoriq-gpio']
   arch/arm64/boot/dts/freescale/fsl-ls2080a-simu.dtb: /soc/gpio@2300000: failed to match any schema with compatible: ['fsl,ls2080a-gpio', 'fsl,qoriq-gpio']
   arch/arm64/boot/dts/freescale/fsl-ls2080a-simu.dtb: /soc/gpio@2310000: failed to match any schema with compatible: ['fsl,ls2080a-gpio', 'fsl,qoriq-gpio']
   arch/arm64/boot/dts/freescale/fsl-ls2080a-simu.dtb: /soc/gpio@2310000: failed to match any schema with compatible: ['fsl,ls2080a-gpio', 'fsl,qoriq-gpio']
   arch/arm64/boot/dts/freescale/fsl-ls2080a-simu.dtb: /soc/gpio@2320000: failed to match any schema with compatible: ['fsl,ls2080a-gpio', 'fsl,qoriq-gpio']
   arch/arm64/boot/dts/freescale/fsl-ls2080a-simu.dtb: /soc/gpio@2320000: failed to match any schema with compatible: ['fsl,ls2080a-gpio', 'fsl,qoriq-gpio']
   arch/arm64/boot/dts/freescale/fsl-ls2080a-simu.dtb: /soc/gpio@2330000: failed to match any schema with compatible: ['fsl,ls2080a-gpio', 'fsl,qoriq-gpio']
   arch/arm64/boot/dts/freescale/fsl-ls2080a-simu.dtb: /soc/gpio@2330000: failed to match any schema with compatible: ['fsl,ls2080a-gpio', 'fsl,qoriq-gpio']
   arch/arm64/boot/dts/freescale/fsl-ls2080a-simu.dtb: i2c@2000000: clock-names:0: 'ipg' was expected
--
   arch/arm64/boot/dts/freescale/fsl-ls2088a-qds.dtb: /soc/mdio@8c2b000: failed to match any schema with compatible: ['fsl,fman-memac-mdio']
   arch/arm64/boot/dts/freescale/fsl-ls2088a-qds.dtb: /soc/mdio@8c2f000: failed to match any schema with compatible: ['fsl,fman-memac-mdio']
   arch/arm64/boot/dts/freescale/fsl-ls2088a-qds.dtb: /soc/mdio@8c33000: failed to match any schema with compatible: ['fsl,fman-memac-mdio']
   arch/arm64/boot/dts/freescale/fsl-ls2088a-qds.dtb: /soc/mdio@8c37000: failed to match any schema with compatible: ['fsl,fman-memac-mdio']
   arch/arm64/boot/dts/freescale/fsl-ls2088a-qds.dtb: /soc/mdio@8c3b000: failed to match any schema with compatible: ['fsl,fman-memac-mdio']
   arch/arm64/boot/dts/freescale/fsl-ls2088a-qds.dtb: /soc/mdio@8c3f000: failed to match any schema with compatible: ['fsl,fman-memac-mdio']
   arch/arm64/boot/dts/freescale/fsl-ls2088a-qds.dtb: /soc/mdio@8c43000: failed to match any schema with compatible: ['fsl,fman-memac-mdio']
   arch/arm64/boot/dts/freescale/fsl-ls2088a-qds.dtb: /soc/fsl-mc@80c000000: failed to match any schema with compatible: ['fsl,qoriq-mc']
   arch/arm64/boot/dts/freescale/fsl-ls2088a-qds.dtb: /soc/spi@2100000: failed to match any schema with compatible: ['fsl,ls2080a-dspi', 'fsl,ls2085a-dspi']
   arch/arm64/boot/dts/freescale/fsl-ls2088a-qds.dtb: /soc/spi@2100000: failed to match any schema with compatible: ['fsl,ls2080a-dspi', 'fsl,ls2085a-dspi']
>> arch/arm64/boot/dts/freescale/fsl-ls2088a-qds.dtb: esdhc@2140000: voltage-ranges:0: [1800, 1800, 3300, 3300] is too long
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
>> arch/arm64/boot/dts/freescale/fsl-ls2088a-qds.dtb: esdhc@2140000: 'clock-frequency' is a required property
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
>> arch/arm64/boot/dts/freescale/fsl-ls2088a-qds.dtb: esdhc@2140000: $nodename:0: 'esdhc@2140000' does not match '^mmc(@.*)?$'
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
>> arch/arm64/boot/dts/freescale/fsl-ls2088a-qds.dtb: esdhc@2140000: Unevaluated properties are not allowed ('bus-width', 'clocks', 'mmc-hs200-1_8v', 'voltage-ranges' were unexpected)
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
   arch/arm64/boot/dts/freescale/fsl-ls2088a-qds.dtb: /soc/gpio@2300000: failed to match any schema with compatible: ['fsl,ls2080a-gpio', 'fsl,qoriq-gpio']
   arch/arm64/boot/dts/freescale/fsl-ls2088a-qds.dtb: /soc/gpio@2300000: failed to match any schema with compatible: ['fsl,ls2080a-gpio', 'fsl,qoriq-gpio']
   arch/arm64/boot/dts/freescale/fsl-ls2088a-qds.dtb: /soc/gpio@2310000: failed to match any schema with compatible: ['fsl,ls2080a-gpio', 'fsl,qoriq-gpio']
   arch/arm64/boot/dts/freescale/fsl-ls2088a-qds.dtb: /soc/gpio@2310000: failed to match any schema with compatible: ['fsl,ls2080a-gpio', 'fsl,qoriq-gpio']
   arch/arm64/boot/dts/freescale/fsl-ls2088a-qds.dtb: /soc/gpio@2320000: failed to match any schema with compatible: ['fsl,ls2080a-gpio', 'fsl,qoriq-gpio']
   arch/arm64/boot/dts/freescale/fsl-ls2088a-qds.dtb: /soc/gpio@2320000: failed to match any schema with compatible: ['fsl,ls2080a-gpio', 'fsl,qoriq-gpio']
   arch/arm64/boot/dts/freescale/fsl-ls2088a-qds.dtb: /soc/gpio@2330000: failed to match any schema with compatible: ['fsl,ls2080a-gpio', 'fsl,qoriq-gpio']
   arch/arm64/boot/dts/freescale/fsl-ls2088a-qds.dtb: /soc/gpio@2330000: failed to match any schema with compatible: ['fsl,ls2080a-gpio', 'fsl,qoriq-gpio']
   arch/arm64/boot/dts/freescale/fsl-ls2088a-qds.dtb: i2c@2000000: clock-names:0: 'ipg' was expected
--
   arch/arm64/boot/dts/freescale/fsl-ls2088a-rdb.dtb: /soc/mdio@8c2b000: failed to match any schema with compatible: ['fsl,fman-memac-mdio']
   arch/arm64/boot/dts/freescale/fsl-ls2088a-rdb.dtb: /soc/mdio@8c2f000: failed to match any schema with compatible: ['fsl,fman-memac-mdio']
   arch/arm64/boot/dts/freescale/fsl-ls2088a-rdb.dtb: /soc/mdio@8c33000: failed to match any schema with compatible: ['fsl,fman-memac-mdio']
   arch/arm64/boot/dts/freescale/fsl-ls2088a-rdb.dtb: /soc/mdio@8c37000: failed to match any schema with compatible: ['fsl,fman-memac-mdio']
   arch/arm64/boot/dts/freescale/fsl-ls2088a-rdb.dtb: /soc/mdio@8c3b000: failed to match any schema with compatible: ['fsl,fman-memac-mdio']
   arch/arm64/boot/dts/freescale/fsl-ls2088a-rdb.dtb: /soc/mdio@8c3f000: failed to match any schema with compatible: ['fsl,fman-memac-mdio']
   arch/arm64/boot/dts/freescale/fsl-ls2088a-rdb.dtb: /soc/mdio@8c43000: failed to match any schema with compatible: ['fsl,fman-memac-mdio']
   arch/arm64/boot/dts/freescale/fsl-ls2088a-rdb.dtb: /soc/fsl-mc@80c000000: failed to match any schema with compatible: ['fsl,qoriq-mc']
   arch/arm64/boot/dts/freescale/fsl-ls2088a-rdb.dtb: /soc/spi@2100000: failed to match any schema with compatible: ['fsl,ls2080a-dspi', 'fsl,ls2085a-dspi']
   arch/arm64/boot/dts/freescale/fsl-ls2088a-rdb.dtb: /soc/spi@2100000: failed to match any schema with compatible: ['fsl,ls2080a-dspi', 'fsl,ls2085a-dspi']
>> arch/arm64/boot/dts/freescale/fsl-ls2088a-rdb.dtb: esdhc@2140000: voltage-ranges:0: [1800, 1800, 3300, 3300] is too long
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
>> arch/arm64/boot/dts/freescale/fsl-ls2088a-rdb.dtb: esdhc@2140000: 'clock-frequency' is a required property
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
>> arch/arm64/boot/dts/freescale/fsl-ls2088a-rdb.dtb: esdhc@2140000: $nodename:0: 'esdhc@2140000' does not match '^mmc(@.*)?$'
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
>> arch/arm64/boot/dts/freescale/fsl-ls2088a-rdb.dtb: esdhc@2140000: Unevaluated properties are not allowed ('bus-width', 'clocks', 'voltage-ranges' were unexpected)
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
   arch/arm64/boot/dts/freescale/fsl-ls2088a-rdb.dtb: /soc/gpio@2300000: failed to match any schema with compatible: ['fsl,ls2080a-gpio', 'fsl,qoriq-gpio']
   arch/arm64/boot/dts/freescale/fsl-ls2088a-rdb.dtb: /soc/gpio@2300000: failed to match any schema with compatible: ['fsl,ls2080a-gpio', 'fsl,qoriq-gpio']
   arch/arm64/boot/dts/freescale/fsl-ls2088a-rdb.dtb: /soc/gpio@2310000: failed to match any schema with compatible: ['fsl,ls2080a-gpio', 'fsl,qoriq-gpio']
   arch/arm64/boot/dts/freescale/fsl-ls2088a-rdb.dtb: /soc/gpio@2310000: failed to match any schema with compatible: ['fsl,ls2080a-gpio', 'fsl,qoriq-gpio']
   arch/arm64/boot/dts/freescale/fsl-ls2088a-rdb.dtb: /soc/gpio@2320000: failed to match any schema with compatible: ['fsl,ls2080a-gpio', 'fsl,qoriq-gpio']
   arch/arm64/boot/dts/freescale/fsl-ls2088a-rdb.dtb: /soc/gpio@2320000: failed to match any schema with compatible: ['fsl,ls2080a-gpio', 'fsl,qoriq-gpio']
   arch/arm64/boot/dts/freescale/fsl-ls2088a-rdb.dtb: /soc/gpio@2330000: failed to match any schema with compatible: ['fsl,ls2080a-gpio', 'fsl,qoriq-gpio']
   arch/arm64/boot/dts/freescale/fsl-ls2088a-rdb.dtb: /soc/gpio@2330000: failed to match any schema with compatible: ['fsl,ls2080a-gpio', 'fsl,qoriq-gpio']
   arch/arm64/boot/dts/freescale/fsl-ls2088a-rdb.dtb: i2c@2000000: clock-names:0: 'ipg' was expected
--
   arch/arm64/boot/dts/freescale/fsl-lx2160a-bluebox3.dtb: i2c@2060000: clock-names:0: 'ipg' was expected
   	from schema $id: http://devicetree.org/schemas/i2c/i2c-imx.yaml#
   arch/arm64/boot/dts/freescale/fsl-lx2160a-bluebox3.dtb: i2c@2070000: clock-names:0: 'ipg' was expected
   	from schema $id: http://devicetree.org/schemas/i2c/i2c-imx.yaml#
   arch/arm64/boot/dts/freescale/fsl-lx2160a-bluebox3.dtb: /soc/spi@2100000: failed to match any schema with compatible: ['fsl,lx2160a-dspi', 'fsl,ls2085a-dspi']
   arch/arm64/boot/dts/freescale/fsl-lx2160a-bluebox3.dtb: /soc/spi@2100000: failed to match any schema with compatible: ['fsl,lx2160a-dspi', 'fsl,ls2085a-dspi']
   arch/arm64/boot/dts/freescale/fsl-lx2160a-bluebox3.dtb: /soc/spi@2110000: failed to match any schema with compatible: ['fsl,lx2160a-dspi', 'fsl,ls2085a-dspi']
   arch/arm64/boot/dts/freescale/fsl-lx2160a-bluebox3.dtb: /soc/spi@2110000: failed to match any schema with compatible: ['fsl,lx2160a-dspi', 'fsl,ls2085a-dspi']
   arch/arm64/boot/dts/freescale/fsl-lx2160a-bluebox3.dtb: /soc/spi@2120000: failed to match any schema with compatible: ['fsl,lx2160a-dspi', 'fsl,ls2085a-dspi']
   arch/arm64/boot/dts/freescale/fsl-lx2160a-bluebox3.dtb: /soc/spi@2120000: failed to match any schema with compatible: ['fsl,lx2160a-dspi', 'fsl,ls2085a-dspi']
>> arch/arm64/boot/dts/freescale/fsl-lx2160a-bluebox3.dtb: esdhc@2140000: compatible:0: 'fsl,esdhc' is not one of ['fsl,mpc8536-esdhc', 'fsl,mpc8378-esdhc', 'fsl,p2020-esdhc', 'fsl,p4080-esdhc', 'fsl,t1040-esdhc', 'fsl,t4240-esdhc', 'fsl,ls1012a-esdhc', 'fsl,ls1028a-esdhc', 'fsl,ls1088a-esdhc', 'fsl,ls1043a-esdhc', 'fsl,ls1046a-esdhc', 'fsl,ls2080a-esdhc']
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
>> arch/arm64/boot/dts/freescale/fsl-lx2160a-bluebox3.dtb: esdhc@2140000: compatible: ['fsl,esdhc'] is too short
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
>> arch/arm64/boot/dts/freescale/fsl-lx2160a-bluebox3.dtb: esdhc@2140000: voltage-ranges:0: [1800, 1800, 3300, 3300] is too long
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
>> arch/arm64/boot/dts/freescale/fsl-lx2160a-bluebox3.dtb: esdhc@2140000: 'clock-frequency' is a required property
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
>> arch/arm64/boot/dts/freescale/fsl-lx2160a-bluebox3.dtb: esdhc@2140000: $nodename:0: 'esdhc@2140000' does not match '^mmc(@.*)?$'
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
>> arch/arm64/boot/dts/freescale/fsl-lx2160a-bluebox3.dtb: esdhc@2140000: Unevaluated properties are not allowed ('bus-width', 'clocks', 'compatible', 'dma-coherent', 'sd-uhs-sdr104', 'sd-uhs-sdr12', 'sd-uhs-sdr25', 'sd-uhs-sdr50', 'voltage-ranges' were unexpected)
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
   arch/arm64/boot/dts/freescale/fsl-lx2160a-bluebox3.dtb: esdhc@2150000: compatible:0: 'fsl,esdhc' is not one of ['fsl,mpc8536-esdhc', 'fsl,mpc8378-esdhc', 'fsl,p2020-esdhc', 'fsl,p4080-esdhc', 'fsl,t1040-esdhc', 'fsl,t4240-esdhc', 'fsl,ls1012a-esdhc', 'fsl,ls1028a-esdhc', 'fsl,ls1088a-esdhc', 'fsl,ls1043a-esdhc', 'fsl,ls1046a-esdhc', 'fsl,ls2080a-esdhc']
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
   arch/arm64/boot/dts/freescale/fsl-lx2160a-bluebox3.dtb: esdhc@2150000: compatible: ['fsl,esdhc'] is too short
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
   arch/arm64/boot/dts/freescale/fsl-lx2160a-bluebox3.dtb: esdhc@2150000: voltage-ranges:0: [1800, 1800, 3300, 3300] is too long
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
   arch/arm64/boot/dts/freescale/fsl-lx2160a-bluebox3.dtb: esdhc@2150000: 'clock-frequency' is a required property
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
   arch/arm64/boot/dts/freescale/fsl-lx2160a-bluebox3.dtb: esdhc@2150000: $nodename:0: 'esdhc@2150000' does not match '^mmc(@.*)?$'
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
>> arch/arm64/boot/dts/freescale/fsl-lx2160a-bluebox3.dtb: esdhc@2150000: Unevaluated properties are not allowed ('broken-cd', 'bus-width', 'clocks', 'compatible', 'dma-coherent', 'mmc-hs200-1_8v', 'mmc-hs400-1_8v', 'voltage-ranges' were unexpected)
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
   arch/arm64/boot/dts/freescale/fsl-lx2160a-bluebox3.dtb: can@2180000: 'can-transceiver' does not match any of the regexes: 'pinctrl-[0-9]+'
   	from schema $id: http://devicetree.org/schemas/net/can/fsl,flexcan.yaml#
   arch/arm64/boot/dts/freescale/fsl-lx2160a-bluebox3.dtb: can@2190000: 'can-transceiver' does not match any of the regexes: 'pinctrl-[0-9]+'
   	from schema $id: http://devicetree.org/schemas/net/can/fsl,flexcan.yaml#
   arch/arm64/boot/dts/freescale/fsl-lx2160a-bluebox3.dtb: /soc/gpio@2300000: failed to match any schema with compatible: ['fsl,qoriq-gpio']
   arch/arm64/boot/dts/freescale/fsl-lx2160a-bluebox3.dtb: /soc/gpio@2310000: failed to match any schema with compatible: ['fsl,qoriq-gpio']
   arch/arm64/boot/dts/freescale/fsl-lx2160a-bluebox3.dtb: /soc/gpio@2320000: failed to match any schema with compatible: ['fsl,qoriq-gpio']
   arch/arm64/boot/dts/freescale/fsl-lx2160a-bluebox3.dtb: /soc/gpio@2330000: failed to match any schema with compatible: ['fsl,qoriq-gpio']
   arch/arm64/boot/dts/freescale/fsl-lx2160a-bluebox3.dtb: power-controller@1e34040: '#power-domain-cells' is a required property
--
   arch/arm64/boot/dts/freescale/fsl-lx2160a-bluebox3-rev-a.dtb: i2c@2060000: clock-names:0: 'ipg' was expected
   	from schema $id: http://devicetree.org/schemas/i2c/i2c-imx.yaml#
   arch/arm64/boot/dts/freescale/fsl-lx2160a-bluebox3-rev-a.dtb: i2c@2070000: clock-names:0: 'ipg' was expected
   	from schema $id: http://devicetree.org/schemas/i2c/i2c-imx.yaml#
   arch/arm64/boot/dts/freescale/fsl-lx2160a-bluebox3-rev-a.dtb: /soc/spi@2100000: failed to match any schema with compatible: ['fsl,lx2160a-dspi', 'fsl,ls2085a-dspi']
   arch/arm64/boot/dts/freescale/fsl-lx2160a-bluebox3-rev-a.dtb: /soc/spi@2100000: failed to match any schema with compatible: ['fsl,lx2160a-dspi', 'fsl,ls2085a-dspi']
   arch/arm64/boot/dts/freescale/fsl-lx2160a-bluebox3-rev-a.dtb: /soc/spi@2110000: failed to match any schema with compatible: ['fsl,lx2160a-dspi', 'fsl,ls2085a-dspi']
   arch/arm64/boot/dts/freescale/fsl-lx2160a-bluebox3-rev-a.dtb: /soc/spi@2110000: failed to match any schema with compatible: ['fsl,lx2160a-dspi', 'fsl,ls2085a-dspi']
   arch/arm64/boot/dts/freescale/fsl-lx2160a-bluebox3-rev-a.dtb: /soc/spi@2120000: failed to match any schema with compatible: ['fsl,lx2160a-dspi', 'fsl,ls2085a-dspi']
   arch/arm64/boot/dts/freescale/fsl-lx2160a-bluebox3-rev-a.dtb: /soc/spi@2120000: failed to match any schema with compatible: ['fsl,lx2160a-dspi', 'fsl,ls2085a-dspi']
>> arch/arm64/boot/dts/freescale/fsl-lx2160a-bluebox3-rev-a.dtb: esdhc@2140000: compatible:0: 'fsl,esdhc' is not one of ['fsl,mpc8536-esdhc', 'fsl,mpc8378-esdhc', 'fsl,p2020-esdhc', 'fsl,p4080-esdhc', 'fsl,t1040-esdhc', 'fsl,t4240-esdhc', 'fsl,ls1012a-esdhc', 'fsl,ls1028a-esdhc', 'fsl,ls1088a-esdhc', 'fsl,ls1043a-esdhc', 'fsl,ls1046a-esdhc', 'fsl,ls2080a-esdhc']
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
>> arch/arm64/boot/dts/freescale/fsl-lx2160a-bluebox3-rev-a.dtb: esdhc@2140000: compatible: ['fsl,esdhc'] is too short
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
>> arch/arm64/boot/dts/freescale/fsl-lx2160a-bluebox3-rev-a.dtb: esdhc@2140000: voltage-ranges:0: [1800, 1800, 3300, 3300] is too long
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
>> arch/arm64/boot/dts/freescale/fsl-lx2160a-bluebox3-rev-a.dtb: esdhc@2140000: 'clock-frequency' is a required property
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
>> arch/arm64/boot/dts/freescale/fsl-lx2160a-bluebox3-rev-a.dtb: esdhc@2140000: $nodename:0: 'esdhc@2140000' does not match '^mmc(@.*)?$'
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
>> arch/arm64/boot/dts/freescale/fsl-lx2160a-bluebox3-rev-a.dtb: esdhc@2140000: Unevaluated properties are not allowed ('bus-width', 'clocks', 'compatible', 'dma-coherent', 'sd-uhs-sdr104', 'sd-uhs-sdr12', 'sd-uhs-sdr25', 'sd-uhs-sdr50', 'voltage-ranges' were unexpected)
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
   arch/arm64/boot/dts/freescale/fsl-lx2160a-bluebox3-rev-a.dtb: esdhc@2150000: compatible:0: 'fsl,esdhc' is not one of ['fsl,mpc8536-esdhc', 'fsl,mpc8378-esdhc', 'fsl,p2020-esdhc', 'fsl,p4080-esdhc', 'fsl,t1040-esdhc', 'fsl,t4240-esdhc', 'fsl,ls1012a-esdhc', 'fsl,ls1028a-esdhc', 'fsl,ls1088a-esdhc', 'fsl,ls1043a-esdhc', 'fsl,ls1046a-esdhc', 'fsl,ls2080a-esdhc']
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
   arch/arm64/boot/dts/freescale/fsl-lx2160a-bluebox3-rev-a.dtb: esdhc@2150000: compatible: ['fsl,esdhc'] is too short
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
   arch/arm64/boot/dts/freescale/fsl-lx2160a-bluebox3-rev-a.dtb: esdhc@2150000: voltage-ranges:0: [1800, 1800, 3300, 3300] is too long
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
   arch/arm64/boot/dts/freescale/fsl-lx2160a-bluebox3-rev-a.dtb: esdhc@2150000: 'clock-frequency' is a required property
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
   arch/arm64/boot/dts/freescale/fsl-lx2160a-bluebox3-rev-a.dtb: esdhc@2150000: $nodename:0: 'esdhc@2150000' does not match '^mmc(@.*)?$'
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
>> arch/arm64/boot/dts/freescale/fsl-lx2160a-bluebox3-rev-a.dtb: esdhc@2150000: Unevaluated properties are not allowed ('broken-cd', 'bus-width', 'clocks', 'compatible', 'dma-coherent', 'mmc-hs200-1_8v', 'mmc-hs400-1_8v', 'voltage-ranges' were unexpected)
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
   arch/arm64/boot/dts/freescale/fsl-lx2160a-bluebox3-rev-a.dtb: can@2180000: 'can-transceiver' does not match any of the regexes: 'pinctrl-[0-9]+'
   	from schema $id: http://devicetree.org/schemas/net/can/fsl,flexcan.yaml#
   arch/arm64/boot/dts/freescale/fsl-lx2160a-bluebox3-rev-a.dtb: can@2190000: 'can-transceiver' does not match any of the regexes: 'pinctrl-[0-9]+'
   	from schema $id: http://devicetree.org/schemas/net/can/fsl,flexcan.yaml#
   arch/arm64/boot/dts/freescale/fsl-lx2160a-bluebox3-rev-a.dtb: /soc/gpio@2300000: failed to match any schema with compatible: ['fsl,qoriq-gpio']
   arch/arm64/boot/dts/freescale/fsl-lx2160a-bluebox3-rev-a.dtb: /soc/gpio@2310000: failed to match any schema with compatible: ['fsl,qoriq-gpio']
   arch/arm64/boot/dts/freescale/fsl-lx2160a-bluebox3-rev-a.dtb: /soc/gpio@2320000: failed to match any schema with compatible: ['fsl,qoriq-gpio']
   arch/arm64/boot/dts/freescale/fsl-lx2160a-bluebox3-rev-a.dtb: /soc/gpio@2330000: failed to match any schema with compatible: ['fsl,qoriq-gpio']
   arch/arm64/boot/dts/freescale/fsl-lx2160a-bluebox3-rev-a.dtb: power-controller@1e34040: '#power-domain-cells' is a required property
--
   arch/arm64/boot/dts/freescale/fsl-lx2160a-clearfog-cx.dtb: i2c@2060000: clock-names:0: 'ipg' was expected
   	from schema $id: http://devicetree.org/schemas/i2c/i2c-imx.yaml#
   arch/arm64/boot/dts/freescale/fsl-lx2160a-clearfog-cx.dtb: i2c@2070000: clock-names:0: 'ipg' was expected
   	from schema $id: http://devicetree.org/schemas/i2c/i2c-imx.yaml#
   arch/arm64/boot/dts/freescale/fsl-lx2160a-clearfog-cx.dtb: /soc/spi@2100000: failed to match any schema with compatible: ['fsl,lx2160a-dspi', 'fsl,ls2085a-dspi']
   arch/arm64/boot/dts/freescale/fsl-lx2160a-clearfog-cx.dtb: /soc/spi@2100000: failed to match any schema with compatible: ['fsl,lx2160a-dspi', 'fsl,ls2085a-dspi']
   arch/arm64/boot/dts/freescale/fsl-lx2160a-clearfog-cx.dtb: /soc/spi@2110000: failed to match any schema with compatible: ['fsl,lx2160a-dspi', 'fsl,ls2085a-dspi']
   arch/arm64/boot/dts/freescale/fsl-lx2160a-clearfog-cx.dtb: /soc/spi@2110000: failed to match any schema with compatible: ['fsl,lx2160a-dspi', 'fsl,ls2085a-dspi']
   arch/arm64/boot/dts/freescale/fsl-lx2160a-clearfog-cx.dtb: /soc/spi@2120000: failed to match any schema with compatible: ['fsl,lx2160a-dspi', 'fsl,ls2085a-dspi']
   arch/arm64/boot/dts/freescale/fsl-lx2160a-clearfog-cx.dtb: /soc/spi@2120000: failed to match any schema with compatible: ['fsl,lx2160a-dspi', 'fsl,ls2085a-dspi']
>> arch/arm64/boot/dts/freescale/fsl-lx2160a-clearfog-cx.dtb: esdhc@2140000: compatible:0: 'fsl,esdhc' is not one of ['fsl,mpc8536-esdhc', 'fsl,mpc8378-esdhc', 'fsl,p2020-esdhc', 'fsl,p4080-esdhc', 'fsl,t1040-esdhc', 'fsl,t4240-esdhc', 'fsl,ls1012a-esdhc', 'fsl,ls1028a-esdhc', 'fsl,ls1088a-esdhc', 'fsl,ls1043a-esdhc', 'fsl,ls1046a-esdhc', 'fsl,ls2080a-esdhc']
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
>> arch/arm64/boot/dts/freescale/fsl-lx2160a-clearfog-cx.dtb: esdhc@2140000: compatible: ['fsl,esdhc'] is too short
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
>> arch/arm64/boot/dts/freescale/fsl-lx2160a-clearfog-cx.dtb: esdhc@2140000: voltage-ranges:0: [1800, 1800, 3300, 3300] is too long
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
>> arch/arm64/boot/dts/freescale/fsl-lx2160a-clearfog-cx.dtb: esdhc@2140000: 'clock-frequency' is a required property
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
>> arch/arm64/boot/dts/freescale/fsl-lx2160a-clearfog-cx.dtb: esdhc@2140000: $nodename:0: 'esdhc@2140000' does not match '^mmc(@.*)?$'
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
>> arch/arm64/boot/dts/freescale/fsl-lx2160a-clearfog-cx.dtb: esdhc@2140000: Unevaluated properties are not allowed ('bus-width', 'clocks', 'compatible', 'dma-coherent', 'sd-uhs-sdr104', 'sd-uhs-sdr12', 'sd-uhs-sdr25', 'sd-uhs-sdr50', 'voltage-ranges' were unexpected)
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
   arch/arm64/boot/dts/freescale/fsl-lx2160a-clearfog-cx.dtb: esdhc@2150000: compatible:0: 'fsl,esdhc' is not one of ['fsl,mpc8536-esdhc', 'fsl,mpc8378-esdhc', 'fsl,p2020-esdhc', 'fsl,p4080-esdhc', 'fsl,t1040-esdhc', 'fsl,t4240-esdhc', 'fsl,ls1012a-esdhc', 'fsl,ls1028a-esdhc', 'fsl,ls1088a-esdhc', 'fsl,ls1043a-esdhc', 'fsl,ls1046a-esdhc', 'fsl,ls2080a-esdhc']
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
   arch/arm64/boot/dts/freescale/fsl-lx2160a-clearfog-cx.dtb: esdhc@2150000: compatible: ['fsl,esdhc'] is too short
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
   arch/arm64/boot/dts/freescale/fsl-lx2160a-clearfog-cx.dtb: esdhc@2150000: voltage-ranges:0: [1800, 1800, 3300, 3300] is too long
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
   arch/arm64/boot/dts/freescale/fsl-lx2160a-clearfog-cx.dtb: esdhc@2150000: 'clock-frequency' is a required property
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
   arch/arm64/boot/dts/freescale/fsl-lx2160a-clearfog-cx.dtb: esdhc@2150000: $nodename:0: 'esdhc@2150000' does not match '^mmc(@.*)?$'
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
>> arch/arm64/boot/dts/freescale/fsl-lx2160a-clearfog-cx.dtb: esdhc@2150000: Unevaluated properties are not allowed ('broken-cd', 'bus-width', 'clocks', 'compatible', 'dma-coherent', 'mmc-hs200-1_8v', 'mmc-hs400-1_8v', 'voltage-ranges' were unexpected)
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
   arch/arm64/boot/dts/freescale/fsl-lx2160a-clearfog-cx.dtb: /soc/gpio@2300000: failed to match any schema with compatible: ['fsl,qoriq-gpio']
   arch/arm64/boot/dts/freescale/fsl-lx2160a-clearfog-cx.dtb: /soc/gpio@2310000: failed to match any schema with compatible: ['fsl,qoriq-gpio']
   arch/arm64/boot/dts/freescale/fsl-lx2160a-clearfog-cx.dtb: /soc/gpio@2320000: failed to match any schema with compatible: ['fsl,qoriq-gpio']
   arch/arm64/boot/dts/freescale/fsl-lx2160a-clearfog-cx.dtb: /soc/gpio@2330000: failed to match any schema with compatible: ['fsl,qoriq-gpio']
   arch/arm64/boot/dts/freescale/fsl-lx2160a-clearfog-cx.dtb: power-controller@1e34040: '#power-domain-cells' is a required property
   	from schema $id: http://devicetree.org/schemas/power/power-domain.yaml#
   arch/arm64/boot/dts/freescale/fsl-lx2160a-clearfog-cx.dtb: /soc/power-controller@1e34040: failed to match any schema with compatible: ['fsl,lx2160a-rcpm', 'fsl,qoriq-rcpm-2.1+']
   arch/arm64/boot/dts/freescale/fsl-lx2160a-clearfog-cx.dtb: /soc/power-controller@1e34040: failed to match any schema with compatible: ['fsl,lx2160a-rcpm', 'fsl,qoriq-rcpm-2.1+']
   arch/arm64/boot/dts/freescale/fsl-lx2160a-clearfog-cx.dtb: /soc/timer@2800000: failed to match any schema with compatible: ['fsl,lx2160a-ftm-alarm']
--
   arch/arm64/boot/dts/freescale/fsl-lx2160a-honeycomb.dtb: i2c@2060000: clock-names:0: 'ipg' was expected
   	from schema $id: http://devicetree.org/schemas/i2c/i2c-imx.yaml#
   arch/arm64/boot/dts/freescale/fsl-lx2160a-honeycomb.dtb: i2c@2070000: clock-names:0: 'ipg' was expected
   	from schema $id: http://devicetree.org/schemas/i2c/i2c-imx.yaml#
   arch/arm64/boot/dts/freescale/fsl-lx2160a-honeycomb.dtb: /soc/spi@2100000: failed to match any schema with compatible: ['fsl,lx2160a-dspi', 'fsl,ls2085a-dspi']
   arch/arm64/boot/dts/freescale/fsl-lx2160a-honeycomb.dtb: /soc/spi@2100000: failed to match any schema with compatible: ['fsl,lx2160a-dspi', 'fsl,ls2085a-dspi']
   arch/arm64/boot/dts/freescale/fsl-lx2160a-honeycomb.dtb: /soc/spi@2110000: failed to match any schema with compatible: ['fsl,lx2160a-dspi', 'fsl,ls2085a-dspi']
   arch/arm64/boot/dts/freescale/fsl-lx2160a-honeycomb.dtb: /soc/spi@2110000: failed to match any schema with compatible: ['fsl,lx2160a-dspi', 'fsl,ls2085a-dspi']
   arch/arm64/boot/dts/freescale/fsl-lx2160a-honeycomb.dtb: /soc/spi@2120000: failed to match any schema with compatible: ['fsl,lx2160a-dspi', 'fsl,ls2085a-dspi']
   arch/arm64/boot/dts/freescale/fsl-lx2160a-honeycomb.dtb: /soc/spi@2120000: failed to match any schema with compatible: ['fsl,lx2160a-dspi', 'fsl,ls2085a-dspi']
>> arch/arm64/boot/dts/freescale/fsl-lx2160a-honeycomb.dtb: esdhc@2140000: compatible:0: 'fsl,esdhc' is not one of ['fsl,mpc8536-esdhc', 'fsl,mpc8378-esdhc', 'fsl,p2020-esdhc', 'fsl,p4080-esdhc', 'fsl,t1040-esdhc', 'fsl,t4240-esdhc', 'fsl,ls1012a-esdhc', 'fsl,ls1028a-esdhc', 'fsl,ls1088a-esdhc', 'fsl,ls1043a-esdhc', 'fsl,ls1046a-esdhc', 'fsl,ls2080a-esdhc']
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
>> arch/arm64/boot/dts/freescale/fsl-lx2160a-honeycomb.dtb: esdhc@2140000: compatible: ['fsl,esdhc'] is too short
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
>> arch/arm64/boot/dts/freescale/fsl-lx2160a-honeycomb.dtb: esdhc@2140000: voltage-ranges:0: [1800, 1800, 3300, 3300] is too long
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
>> arch/arm64/boot/dts/freescale/fsl-lx2160a-honeycomb.dtb: esdhc@2140000: 'clock-frequency' is a required property
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
>> arch/arm64/boot/dts/freescale/fsl-lx2160a-honeycomb.dtb: esdhc@2140000: $nodename:0: 'esdhc@2140000' does not match '^mmc(@.*)?$'
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
>> arch/arm64/boot/dts/freescale/fsl-lx2160a-honeycomb.dtb: esdhc@2140000: Unevaluated properties are not allowed ('bus-width', 'clocks', 'compatible', 'dma-coherent', 'sd-uhs-sdr104', 'sd-uhs-sdr12', 'sd-uhs-sdr25', 'sd-uhs-sdr50', 'voltage-ranges' were unexpected)
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
   arch/arm64/boot/dts/freescale/fsl-lx2160a-honeycomb.dtb: esdhc@2150000: compatible:0: 'fsl,esdhc' is not one of ['fsl,mpc8536-esdhc', 'fsl,mpc8378-esdhc', 'fsl,p2020-esdhc', 'fsl,p4080-esdhc', 'fsl,t1040-esdhc', 'fsl,t4240-esdhc', 'fsl,ls1012a-esdhc', 'fsl,ls1028a-esdhc', 'fsl,ls1088a-esdhc', 'fsl,ls1043a-esdhc', 'fsl,ls1046a-esdhc', 'fsl,ls2080a-esdhc']
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
   arch/arm64/boot/dts/freescale/fsl-lx2160a-honeycomb.dtb: esdhc@2150000: compatible: ['fsl,esdhc'] is too short
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
   arch/arm64/boot/dts/freescale/fsl-lx2160a-honeycomb.dtb: esdhc@2150000: voltage-ranges:0: [1800, 1800, 3300, 3300] is too long
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
   arch/arm64/boot/dts/freescale/fsl-lx2160a-honeycomb.dtb: esdhc@2150000: 'clock-frequency' is a required property
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
   arch/arm64/boot/dts/freescale/fsl-lx2160a-honeycomb.dtb: esdhc@2150000: $nodename:0: 'esdhc@2150000' does not match '^mmc(@.*)?$'
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
>> arch/arm64/boot/dts/freescale/fsl-lx2160a-honeycomb.dtb: esdhc@2150000: Unevaluated properties are not allowed ('broken-cd', 'bus-width', 'clocks', 'compatible', 'dma-coherent', 'mmc-hs200-1_8v', 'mmc-hs400-1_8v', 'voltage-ranges' were unexpected)
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
   arch/arm64/boot/dts/freescale/fsl-lx2160a-honeycomb.dtb: /soc/gpio@2300000: failed to match any schema with compatible: ['fsl,qoriq-gpio']
   arch/arm64/boot/dts/freescale/fsl-lx2160a-honeycomb.dtb: /soc/gpio@2310000: failed to match any schema with compatible: ['fsl,qoriq-gpio']
   arch/arm64/boot/dts/freescale/fsl-lx2160a-honeycomb.dtb: /soc/gpio@2320000: failed to match any schema with compatible: ['fsl,qoriq-gpio']
   arch/arm64/boot/dts/freescale/fsl-lx2160a-honeycomb.dtb: /soc/gpio@2330000: failed to match any schema with compatible: ['fsl,qoriq-gpio']
   arch/arm64/boot/dts/freescale/fsl-lx2160a-honeycomb.dtb: power-controller@1e34040: '#power-domain-cells' is a required property
   	from schema $id: http://devicetree.org/schemas/power/power-domain.yaml#
   arch/arm64/boot/dts/freescale/fsl-lx2160a-honeycomb.dtb: /soc/power-controller@1e34040: failed to match any schema with compatible: ['fsl,lx2160a-rcpm', 'fsl,qoriq-rcpm-2.1+']
   arch/arm64/boot/dts/freescale/fsl-lx2160a-honeycomb.dtb: /soc/power-controller@1e34040: failed to match any schema with compatible: ['fsl,lx2160a-rcpm', 'fsl,qoriq-rcpm-2.1+']
   arch/arm64/boot/dts/freescale/fsl-lx2160a-honeycomb.dtb: /soc/timer@2800000: failed to match any schema with compatible: ['fsl,lx2160a-ftm-alarm']
--
   arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dtb: i2c@2060000: clock-names:0: 'ipg' was expected
   	from schema $id: http://devicetree.org/schemas/i2c/i2c-imx.yaml#
   arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dtb: i2c@2070000: clock-names:0: 'ipg' was expected
   	from schema $id: http://devicetree.org/schemas/i2c/i2c-imx.yaml#
   arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dtb: /soc/spi@2100000: failed to match any schema with compatible: ['fsl,lx2160a-dspi', 'fsl,ls2085a-dspi']
   arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dtb: /soc/spi@2100000: failed to match any schema with compatible: ['fsl,lx2160a-dspi', 'fsl,ls2085a-dspi']
   arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dtb: /soc/spi@2110000: failed to match any schema with compatible: ['fsl,lx2160a-dspi', 'fsl,ls2085a-dspi']
   arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dtb: /soc/spi@2110000: failed to match any schema with compatible: ['fsl,lx2160a-dspi', 'fsl,ls2085a-dspi']
   arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dtb: /soc/spi@2120000: failed to match any schema with compatible: ['fsl,lx2160a-dspi', 'fsl,ls2085a-dspi']
   arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dtb: /soc/spi@2120000: failed to match any schema with compatible: ['fsl,lx2160a-dspi', 'fsl,ls2085a-dspi']
>> arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dtb: esdhc@2140000: compatible:0: 'fsl,esdhc' is not one of ['fsl,mpc8536-esdhc', 'fsl,mpc8378-esdhc', 'fsl,p2020-esdhc', 'fsl,p4080-esdhc', 'fsl,t1040-esdhc', 'fsl,t4240-esdhc', 'fsl,ls1012a-esdhc', 'fsl,ls1028a-esdhc', 'fsl,ls1088a-esdhc', 'fsl,ls1043a-esdhc', 'fsl,ls1046a-esdhc', 'fsl,ls2080a-esdhc']
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
>> arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dtb: esdhc@2140000: compatible: ['fsl,esdhc'] is too short
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
>> arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dtb: esdhc@2140000: voltage-ranges:0: [1800, 1800, 3300, 3300] is too long
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
>> arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dtb: esdhc@2140000: 'clock-frequency' is a required property
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
>> arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dtb: esdhc@2140000: $nodename:0: 'esdhc@2140000' does not match '^mmc(@.*)?$'
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
>> arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dtb: esdhc@2140000: Unevaluated properties are not allowed ('bus-width', 'clocks', 'compatible', 'dma-coherent', 'voltage-ranges' were unexpected)
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
   arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dtb: esdhc@2150000: compatible:0: 'fsl,esdhc' is not one of ['fsl,mpc8536-esdhc', 'fsl,mpc8378-esdhc', 'fsl,p2020-esdhc', 'fsl,p4080-esdhc', 'fsl,t1040-esdhc', 'fsl,t4240-esdhc', 'fsl,ls1012a-esdhc', 'fsl,ls1028a-esdhc', 'fsl,ls1088a-esdhc', 'fsl,ls1043a-esdhc', 'fsl,ls1046a-esdhc', 'fsl,ls2080a-esdhc']
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
   arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dtb: esdhc@2150000: compatible: ['fsl,esdhc'] is too short
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
   arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dtb: esdhc@2150000: voltage-ranges:0: [1800, 1800, 3300, 3300] is too long
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
   arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dtb: esdhc@2150000: 'clock-frequency' is a required property
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
   arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dtb: esdhc@2150000: $nodename:0: 'esdhc@2150000' does not match '^mmc(@.*)?$'
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
>> arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dtb: esdhc@2150000: Unevaluated properties are not allowed ('broken-cd', 'bus-width', 'clocks', 'compatible', 'dma-coherent', 'voltage-ranges' were unexpected)
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
   arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dtb: /soc/gpio@2300000: failed to match any schema with compatible: ['fsl,qoriq-gpio']
   arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dtb: /soc/gpio@2310000: failed to match any schema with compatible: ['fsl,qoriq-gpio']
   arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dtb: /soc/gpio@2320000: failed to match any schema with compatible: ['fsl,qoriq-gpio']
   arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dtb: /soc/gpio@2330000: failed to match any schema with compatible: ['fsl,qoriq-gpio']
   arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dtb: power-controller@1e34040: '#power-domain-cells' is a required property
   	from schema $id: http://devicetree.org/schemas/power/power-domain.yaml#
   arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dtb: /soc/power-controller@1e34040: failed to match any schema with compatible: ['fsl,lx2160a-rcpm', 'fsl,qoriq-rcpm-2.1+']
   arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dtb: /soc/power-controller@1e34040: failed to match any schema with compatible: ['fsl,lx2160a-rcpm', 'fsl,qoriq-rcpm-2.1+']
   arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dtb: /soc/timer@2800000: failed to match any schema with compatible: ['fsl,lx2160a-ftm-alarm']
--
   arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dtb: i2c@2060000: clock-names:0: 'ipg' was expected
   	from schema $id: http://devicetree.org/schemas/i2c/i2c-imx.yaml#
   arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dtb: i2c@2070000: clock-names:0: 'ipg' was expected
   	from schema $id: http://devicetree.org/schemas/i2c/i2c-imx.yaml#
   arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dtb: /soc/spi@2100000: failed to match any schema with compatible: ['fsl,lx2160a-dspi', 'fsl,ls2085a-dspi']
   arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dtb: /soc/spi@2100000: failed to match any schema with compatible: ['fsl,lx2160a-dspi', 'fsl,ls2085a-dspi']
   arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dtb: /soc/spi@2110000: failed to match any schema with compatible: ['fsl,lx2160a-dspi', 'fsl,ls2085a-dspi']
   arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dtb: /soc/spi@2110000: failed to match any schema with compatible: ['fsl,lx2160a-dspi', 'fsl,ls2085a-dspi']
   arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dtb: /soc/spi@2120000: failed to match any schema with compatible: ['fsl,lx2160a-dspi', 'fsl,ls2085a-dspi']
   arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dtb: /soc/spi@2120000: failed to match any schema with compatible: ['fsl,lx2160a-dspi', 'fsl,ls2085a-dspi']
>> arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dtb: esdhc@2140000: compatible:0: 'fsl,esdhc' is not one of ['fsl,mpc8536-esdhc', 'fsl,mpc8378-esdhc', 'fsl,p2020-esdhc', 'fsl,p4080-esdhc', 'fsl,t1040-esdhc', 'fsl,t4240-esdhc', 'fsl,ls1012a-esdhc', 'fsl,ls1028a-esdhc', 'fsl,ls1088a-esdhc', 'fsl,ls1043a-esdhc', 'fsl,ls1046a-esdhc', 'fsl,ls2080a-esdhc']
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
>> arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dtb: esdhc@2140000: compatible: ['fsl,esdhc'] is too short
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
>> arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dtb: esdhc@2140000: voltage-ranges:0: [1800, 1800, 3300, 3300] is too long
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
>> arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dtb: esdhc@2140000: 'clock-frequency' is a required property
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
>> arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dtb: esdhc@2140000: $nodename:0: 'esdhc@2140000' does not match '^mmc(@.*)?$'
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
>> arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dtb: esdhc@2140000: Unevaluated properties are not allowed ('bus-width', 'clocks', 'compatible', 'dma-coherent', 'sd-uhs-sdr104', 'sd-uhs-sdr12', 'sd-uhs-sdr25', 'sd-uhs-sdr50', 'voltage-ranges' were unexpected)
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
   arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dtb: esdhc@2150000: compatible:0: 'fsl,esdhc' is not one of ['fsl,mpc8536-esdhc', 'fsl,mpc8378-esdhc', 'fsl,p2020-esdhc', 'fsl,p4080-esdhc', 'fsl,t1040-esdhc', 'fsl,t4240-esdhc', 'fsl,ls1012a-esdhc', 'fsl,ls1028a-esdhc', 'fsl,ls1088a-esdhc', 'fsl,ls1043a-esdhc', 'fsl,ls1046a-esdhc', 'fsl,ls2080a-esdhc']
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
   arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dtb: esdhc@2150000: compatible: ['fsl,esdhc'] is too short
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
   arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dtb: esdhc@2150000: voltage-ranges:0: [1800, 1800, 3300, 3300] is too long
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
   arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dtb: esdhc@2150000: 'clock-frequency' is a required property
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
   arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dtb: esdhc@2150000: $nodename:0: 'esdhc@2150000' does not match '^mmc(@.*)?$'
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
>> arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dtb: esdhc@2150000: Unevaluated properties are not allowed ('broken-cd', 'bus-width', 'clocks', 'compatible', 'dma-coherent', 'mmc-hs200-1_8v', 'mmc-hs400-1_8v', 'voltage-ranges' were unexpected)
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
   arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dtb: can@2180000: 'can-transceiver' does not match any of the regexes: 'pinctrl-[0-9]+'
   	from schema $id: http://devicetree.org/schemas/net/can/fsl,flexcan.yaml#
   arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dtb: can@2190000: 'can-transceiver' does not match any of the regexes: 'pinctrl-[0-9]+'
   	from schema $id: http://devicetree.org/schemas/net/can/fsl,flexcan.yaml#
   arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dtb: /soc/gpio@2300000: failed to match any schema with compatible: ['fsl,qoriq-gpio']
   arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dtb: /soc/gpio@2310000: failed to match any schema with compatible: ['fsl,qoriq-gpio']
   arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dtb: /soc/gpio@2320000: failed to match any schema with compatible: ['fsl,qoriq-gpio']
   arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dtb: /soc/gpio@2330000: failed to match any schema with compatible: ['fsl,qoriq-gpio']
   arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dtb: power-controller@1e34040: '#power-domain-cells' is a required property
--
   arch/arm64/boot/dts/freescale/fsl-lx2162a-clearfog.dtb: i2c@2060000: clock-names:0: 'ipg' was expected
   	from schema $id: http://devicetree.org/schemas/i2c/i2c-imx.yaml#
   arch/arm64/boot/dts/freescale/fsl-lx2162a-clearfog.dtb: i2c@2070000: clock-names:0: 'ipg' was expected
   	from schema $id: http://devicetree.org/schemas/i2c/i2c-imx.yaml#
   arch/arm64/boot/dts/freescale/fsl-lx2162a-clearfog.dtb: /soc/spi@2100000: failed to match any schema with compatible: ['fsl,lx2160a-dspi', 'fsl,ls2085a-dspi']
   arch/arm64/boot/dts/freescale/fsl-lx2162a-clearfog.dtb: /soc/spi@2100000: failed to match any schema with compatible: ['fsl,lx2160a-dspi', 'fsl,ls2085a-dspi']
   arch/arm64/boot/dts/freescale/fsl-lx2162a-clearfog.dtb: /soc/spi@2110000: failed to match any schema with compatible: ['fsl,lx2160a-dspi', 'fsl,ls2085a-dspi']
   arch/arm64/boot/dts/freescale/fsl-lx2162a-clearfog.dtb: /soc/spi@2110000: failed to match any schema with compatible: ['fsl,lx2160a-dspi', 'fsl,ls2085a-dspi']
   arch/arm64/boot/dts/freescale/fsl-lx2162a-clearfog.dtb: /soc/spi@2120000: failed to match any schema with compatible: ['fsl,lx2160a-dspi', 'fsl,ls2085a-dspi']
   arch/arm64/boot/dts/freescale/fsl-lx2162a-clearfog.dtb: /soc/spi@2120000: failed to match any schema with compatible: ['fsl,lx2160a-dspi', 'fsl,ls2085a-dspi']
>> arch/arm64/boot/dts/freescale/fsl-lx2162a-clearfog.dtb: esdhc@2140000: compatible:0: 'fsl,esdhc' is not one of ['fsl,mpc8536-esdhc', 'fsl,mpc8378-esdhc', 'fsl,p2020-esdhc', 'fsl,p4080-esdhc', 'fsl,t1040-esdhc', 'fsl,t4240-esdhc', 'fsl,ls1012a-esdhc', 'fsl,ls1028a-esdhc', 'fsl,ls1088a-esdhc', 'fsl,ls1043a-esdhc', 'fsl,ls1046a-esdhc', 'fsl,ls2080a-esdhc']
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
>> arch/arm64/boot/dts/freescale/fsl-lx2162a-clearfog.dtb: esdhc@2140000: compatible: ['fsl,esdhc'] is too short
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
>> arch/arm64/boot/dts/freescale/fsl-lx2162a-clearfog.dtb: esdhc@2140000: voltage-ranges:0: [1800, 1800, 3300, 3300] is too long
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
>> arch/arm64/boot/dts/freescale/fsl-lx2162a-clearfog.dtb: esdhc@2140000: 'clock-frequency' is a required property
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
>> arch/arm64/boot/dts/freescale/fsl-lx2162a-clearfog.dtb: esdhc@2140000: $nodename:0: 'esdhc@2140000' does not match '^mmc(@.*)?$'
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
>> arch/arm64/boot/dts/freescale/fsl-lx2162a-clearfog.dtb: esdhc@2140000: Unevaluated properties are not allowed ('bus-width', 'clocks', 'compatible', 'dma-coherent', 'sd-uhs-sdr104', 'sd-uhs-sdr12', 'sd-uhs-sdr25', 'sd-uhs-sdr50', 'voltage-ranges' were unexpected)
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
   arch/arm64/boot/dts/freescale/fsl-lx2162a-clearfog.dtb: esdhc@2150000: compatible:0: 'fsl,esdhc' is not one of ['fsl,mpc8536-esdhc', 'fsl,mpc8378-esdhc', 'fsl,p2020-esdhc', 'fsl,p4080-esdhc', 'fsl,t1040-esdhc', 'fsl,t4240-esdhc', 'fsl,ls1012a-esdhc', 'fsl,ls1028a-esdhc', 'fsl,ls1088a-esdhc', 'fsl,ls1043a-esdhc', 'fsl,ls1046a-esdhc', 'fsl,ls2080a-esdhc']
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
   arch/arm64/boot/dts/freescale/fsl-lx2162a-clearfog.dtb: esdhc@2150000: compatible: ['fsl,esdhc'] is too short
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
   arch/arm64/boot/dts/freescale/fsl-lx2162a-clearfog.dtb: esdhc@2150000: voltage-ranges:0: [1800, 1800, 3300, 3300] is too long
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
   arch/arm64/boot/dts/freescale/fsl-lx2162a-clearfog.dtb: esdhc@2150000: 'clock-frequency' is a required property
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
   arch/arm64/boot/dts/freescale/fsl-lx2162a-clearfog.dtb: esdhc@2150000: $nodename:0: 'esdhc@2150000' does not match '^mmc(@.*)?$'
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
>> arch/arm64/boot/dts/freescale/fsl-lx2162a-clearfog.dtb: esdhc@2150000: Unevaluated properties are not allowed ('broken-cd', 'bus-width', 'clocks', 'compatible', 'dma-coherent', 'mmc-hs200-1_8v', 'mmc-hs400-1_8v', 'voltage-ranges' were unexpected)
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
   arch/arm64/boot/dts/freescale/fsl-lx2162a-clearfog.dtb: /soc/gpio@2300000: failed to match any schema with compatible: ['fsl,qoriq-gpio']
   arch/arm64/boot/dts/freescale/fsl-lx2162a-clearfog.dtb: /soc/gpio@2310000: failed to match any schema with compatible: ['fsl,qoriq-gpio']
   arch/arm64/boot/dts/freescale/fsl-lx2162a-clearfog.dtb: /soc/gpio@2320000: failed to match any schema with compatible: ['fsl,qoriq-gpio']
   arch/arm64/boot/dts/freescale/fsl-lx2162a-clearfog.dtb: /soc/gpio@2330000: failed to match any schema with compatible: ['fsl,qoriq-gpio']
   arch/arm64/boot/dts/freescale/fsl-lx2162a-clearfog.dtb: power-controller@1e34040: '#power-domain-cells' is a required property
   	from schema $id: http://devicetree.org/schemas/power/power-domain.yaml#
   arch/arm64/boot/dts/freescale/fsl-lx2162a-clearfog.dtb: /soc/power-controller@1e34040: failed to match any schema with compatible: ['fsl,lx2160a-rcpm', 'fsl,qoriq-rcpm-2.1+']
   arch/arm64/boot/dts/freescale/fsl-lx2162a-clearfog.dtb: /soc/power-controller@1e34040: failed to match any schema with compatible: ['fsl,lx2160a-rcpm', 'fsl,qoriq-rcpm-2.1+']
   arch/arm64/boot/dts/freescale/fsl-lx2162a-clearfog.dtb: /soc/timer@2800000: failed to match any schema with compatible: ['fsl,lx2160a-ftm-alarm']
--
   arch/arm64/boot/dts/freescale/fsl-lx2162a-qds.dtb: i2c@2060000: clock-names:0: 'ipg' was expected
   	from schema $id: http://devicetree.org/schemas/i2c/i2c-imx.yaml#
   arch/arm64/boot/dts/freescale/fsl-lx2162a-qds.dtb: i2c@2070000: clock-names:0: 'ipg' was expected
   	from schema $id: http://devicetree.org/schemas/i2c/i2c-imx.yaml#
   arch/arm64/boot/dts/freescale/fsl-lx2162a-qds.dtb: /soc/spi@2100000: failed to match any schema with compatible: ['fsl,lx2160a-dspi', 'fsl,ls2085a-dspi']
   arch/arm64/boot/dts/freescale/fsl-lx2162a-qds.dtb: /soc/spi@2100000: failed to match any schema with compatible: ['fsl,lx2160a-dspi', 'fsl,ls2085a-dspi']
   arch/arm64/boot/dts/freescale/fsl-lx2162a-qds.dtb: /soc/spi@2110000: failed to match any schema with compatible: ['fsl,lx2160a-dspi', 'fsl,ls2085a-dspi']
   arch/arm64/boot/dts/freescale/fsl-lx2162a-qds.dtb: /soc/spi@2110000: failed to match any schema with compatible: ['fsl,lx2160a-dspi', 'fsl,ls2085a-dspi']
   arch/arm64/boot/dts/freescale/fsl-lx2162a-qds.dtb: /soc/spi@2120000: failed to match any schema with compatible: ['fsl,lx2160a-dspi', 'fsl,ls2085a-dspi']
   arch/arm64/boot/dts/freescale/fsl-lx2162a-qds.dtb: /soc/spi@2120000: failed to match any schema with compatible: ['fsl,lx2160a-dspi', 'fsl,ls2085a-dspi']
>> arch/arm64/boot/dts/freescale/fsl-lx2162a-qds.dtb: esdhc@2140000: compatible:0: 'fsl,esdhc' is not one of ['fsl,mpc8536-esdhc', 'fsl,mpc8378-esdhc', 'fsl,p2020-esdhc', 'fsl,p4080-esdhc', 'fsl,t1040-esdhc', 'fsl,t4240-esdhc', 'fsl,ls1012a-esdhc', 'fsl,ls1028a-esdhc', 'fsl,ls1088a-esdhc', 'fsl,ls1043a-esdhc', 'fsl,ls1046a-esdhc', 'fsl,ls2080a-esdhc']
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
>> arch/arm64/boot/dts/freescale/fsl-lx2162a-qds.dtb: esdhc@2140000: compatible: ['fsl,esdhc'] is too short
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
>> arch/arm64/boot/dts/freescale/fsl-lx2162a-qds.dtb: esdhc@2140000: voltage-ranges:0: [1800, 1800, 3300, 3300] is too long
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
>> arch/arm64/boot/dts/freescale/fsl-lx2162a-qds.dtb: esdhc@2140000: 'clock-frequency' is a required property
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
>> arch/arm64/boot/dts/freescale/fsl-lx2162a-qds.dtb: esdhc@2140000: $nodename:0: 'esdhc@2140000' does not match '^mmc(@.*)?$'
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
>> arch/arm64/boot/dts/freescale/fsl-lx2162a-qds.dtb: esdhc@2140000: Unevaluated properties are not allowed ('bus-width', 'clocks', 'compatible', 'dma-coherent', 'sd-uhs-sdr104', 'sd-uhs-sdr12', 'sd-uhs-sdr25', 'sd-uhs-sdr50', 'voltage-ranges' were unexpected)
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
   arch/arm64/boot/dts/freescale/fsl-lx2162a-qds.dtb: esdhc@2150000: compatible:0: 'fsl,esdhc' is not one of ['fsl,mpc8536-esdhc', 'fsl,mpc8378-esdhc', 'fsl,p2020-esdhc', 'fsl,p4080-esdhc', 'fsl,t1040-esdhc', 'fsl,t4240-esdhc', 'fsl,ls1012a-esdhc', 'fsl,ls1028a-esdhc', 'fsl,ls1088a-esdhc', 'fsl,ls1043a-esdhc', 'fsl,ls1046a-esdhc', 'fsl,ls2080a-esdhc']
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
   arch/arm64/boot/dts/freescale/fsl-lx2162a-qds.dtb: esdhc@2150000: compatible: ['fsl,esdhc'] is too short
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
   arch/arm64/boot/dts/freescale/fsl-lx2162a-qds.dtb: esdhc@2150000: voltage-ranges:0: [1800, 1800, 3300, 3300] is too long
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
   arch/arm64/boot/dts/freescale/fsl-lx2162a-qds.dtb: esdhc@2150000: 'clock-frequency' is a required property
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
   arch/arm64/boot/dts/freescale/fsl-lx2162a-qds.dtb: esdhc@2150000: $nodename:0: 'esdhc@2150000' does not match '^mmc(@.*)?$'
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
>> arch/arm64/boot/dts/freescale/fsl-lx2162a-qds.dtb: esdhc@2150000: Unevaluated properties are not allowed ('broken-cd', 'bus-width', 'clocks', 'compatible', 'dma-coherent', 'mmc-hs200-1_8v', 'mmc-hs400-1_8v', 'voltage-ranges' were unexpected)
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
   arch/arm64/boot/dts/freescale/fsl-lx2162a-qds.dtb: /soc/gpio@2300000: failed to match any schema with compatible: ['fsl,qoriq-gpio']
   arch/arm64/boot/dts/freescale/fsl-lx2162a-qds.dtb: /soc/gpio@2310000: failed to match any schema with compatible: ['fsl,qoriq-gpio']
   arch/arm64/boot/dts/freescale/fsl-lx2162a-qds.dtb: /soc/gpio@2320000: failed to match any schema with compatible: ['fsl,qoriq-gpio']
   arch/arm64/boot/dts/freescale/fsl-lx2162a-qds.dtb: /soc/gpio@2330000: failed to match any schema with compatible: ['fsl,qoriq-gpio']
   arch/arm64/boot/dts/freescale/fsl-lx2162a-qds.dtb: power-controller@1e34040: '#power-domain-cells' is a required property
   	from schema $id: http://devicetree.org/schemas/power/power-domain.yaml#
   arch/arm64/boot/dts/freescale/fsl-lx2162a-qds.dtb: /soc/power-controller@1e34040: failed to match any schema with compatible: ['fsl,lx2160a-rcpm', 'fsl,qoriq-rcpm-2.1+']
   arch/arm64/boot/dts/freescale/fsl-lx2162a-qds.dtb: /soc/power-controller@1e34040: failed to match any schema with compatible: ['fsl,lx2160a-rcpm', 'fsl,qoriq-rcpm-2.1+']
   arch/arm64/boot/dts/freescale/fsl-lx2162a-qds.dtb: /soc/timer@2800000: failed to match any schema with compatible: ['fsl,lx2160a-ftm-alarm']
--
   arch/arm64/boot/dts/freescale/fsl-lx2160a-tqmlx2160a-mblx2160a.dtb: i2c@2060000: clock-names:0: 'ipg' was expected
   	from schema $id: http://devicetree.org/schemas/i2c/i2c-imx.yaml#
   arch/arm64/boot/dts/freescale/fsl-lx2160a-tqmlx2160a-mblx2160a.dtb: i2c@2070000: clock-names:0: 'ipg' was expected
   	from schema $id: http://devicetree.org/schemas/i2c/i2c-imx.yaml#
   arch/arm64/boot/dts/freescale/fsl-lx2160a-tqmlx2160a-mblx2160a.dtb: /soc/spi@2100000: failed to match any schema with compatible: ['fsl,lx2160a-dspi', 'fsl,ls2085a-dspi']
   arch/arm64/boot/dts/freescale/fsl-lx2160a-tqmlx2160a-mblx2160a.dtb: /soc/spi@2100000: failed to match any schema with compatible: ['fsl,lx2160a-dspi', 'fsl,ls2085a-dspi']
   arch/arm64/boot/dts/freescale/fsl-lx2160a-tqmlx2160a-mblx2160a.dtb: /soc/spi@2110000: failed to match any schema with compatible: ['fsl,lx2160a-dspi', 'fsl,ls2085a-dspi']
   arch/arm64/boot/dts/freescale/fsl-lx2160a-tqmlx2160a-mblx2160a.dtb: /soc/spi@2110000: failed to match any schema with compatible: ['fsl,lx2160a-dspi', 'fsl,ls2085a-dspi']
   arch/arm64/boot/dts/freescale/fsl-lx2160a-tqmlx2160a-mblx2160a.dtb: /soc/spi@2120000: failed to match any schema with compatible: ['fsl,lx2160a-dspi', 'fsl,ls2085a-dspi']
   arch/arm64/boot/dts/freescale/fsl-lx2160a-tqmlx2160a-mblx2160a.dtb: /soc/spi@2120000: failed to match any schema with compatible: ['fsl,lx2160a-dspi', 'fsl,ls2085a-dspi']
>> arch/arm64/boot/dts/freescale/fsl-lx2160a-tqmlx2160a-mblx2160a.dtb: esdhc@2140000: compatible:0: 'fsl,esdhc' is not one of ['fsl,mpc8536-esdhc', 'fsl,mpc8378-esdhc', 'fsl,p2020-esdhc', 'fsl,p4080-esdhc', 'fsl,t1040-esdhc', 'fsl,t4240-esdhc', 'fsl,ls1012a-esdhc', 'fsl,ls1028a-esdhc', 'fsl,ls1088a-esdhc', 'fsl,ls1043a-esdhc', 'fsl,ls1046a-esdhc', 'fsl,ls2080a-esdhc']
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
>> arch/arm64/boot/dts/freescale/fsl-lx2160a-tqmlx2160a-mblx2160a.dtb: esdhc@2140000: compatible: ['fsl,esdhc'] is too short
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
>> arch/arm64/boot/dts/freescale/fsl-lx2160a-tqmlx2160a-mblx2160a.dtb: esdhc@2140000: voltage-ranges:0: [1800, 1800, 3300, 3300] is too long
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
>> arch/arm64/boot/dts/freescale/fsl-lx2160a-tqmlx2160a-mblx2160a.dtb: esdhc@2140000: 'clock-frequency' is a required property
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
>> arch/arm64/boot/dts/freescale/fsl-lx2160a-tqmlx2160a-mblx2160a.dtb: esdhc@2140000: $nodename:0: 'esdhc@2140000' does not match '^mmc(@.*)?$'
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
>> arch/arm64/boot/dts/freescale/fsl-lx2160a-tqmlx2160a-mblx2160a.dtb: esdhc@2140000: Unevaluated properties are not allowed ('bus-width', 'cd-gpios', 'clocks', 'compatible', 'dma-coherent', 'no-mmc', 'no-sdio', 'sd-uhs-sdr104', 'sd-uhs-sdr12', 'sd-uhs-sdr25', 'sd-uhs-sdr50', 'voltage-ranges', 'wp-gpios' were unexpected)
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
   arch/arm64/boot/dts/freescale/fsl-lx2160a-tqmlx2160a-mblx2160a.dtb: esdhc@2150000: compatible:0: 'fsl,esdhc' is not one of ['fsl,mpc8536-esdhc', 'fsl,mpc8378-esdhc', 'fsl,p2020-esdhc', 'fsl,p4080-esdhc', 'fsl,t1040-esdhc', 'fsl,t4240-esdhc', 'fsl,ls1012a-esdhc', 'fsl,ls1028a-esdhc', 'fsl,ls1088a-esdhc', 'fsl,ls1043a-esdhc', 'fsl,ls1046a-esdhc', 'fsl,ls2080a-esdhc']
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
   arch/arm64/boot/dts/freescale/fsl-lx2160a-tqmlx2160a-mblx2160a.dtb: esdhc@2150000: compatible: ['fsl,esdhc'] is too short
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
   arch/arm64/boot/dts/freescale/fsl-lx2160a-tqmlx2160a-mblx2160a.dtb: esdhc@2150000: voltage-ranges:0: [1800, 1800, 3300, 3300] is too long
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
   arch/arm64/boot/dts/freescale/fsl-lx2160a-tqmlx2160a-mblx2160a.dtb: esdhc@2150000: 'clock-frequency' is a required property
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
   arch/arm64/boot/dts/freescale/fsl-lx2160a-tqmlx2160a-mblx2160a.dtb: esdhc@2150000: $nodename:0: 'esdhc@2150000' does not match '^mmc(@.*)?$'
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
>> arch/arm64/boot/dts/freescale/fsl-lx2160a-tqmlx2160a-mblx2160a.dtb: esdhc@2150000: Unevaluated properties are not allowed ('broken-cd', 'bus-width', 'clocks', 'compatible', 'dma-coherent', 'mmc-hs200-1_8v', 'no-sd', 'no-sdio', 'non-removable', 'voltage-ranges' were unexpected)
   	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
   arch/arm64/boot/dts/freescale/fsl-lx2160a-tqmlx2160a-mblx2160a.dtb: /soc/gpio@2300000: failed to match any schema with compatible: ['fsl,qoriq-gpio']
   arch/arm64/boot/dts/freescale/fsl-lx2160a-tqmlx2160a-mblx2160a.dtb: /soc/gpio@2310000: failed to match any schema with compatible: ['fsl,qoriq-gpio']
   arch/arm64/boot/dts/freescale/fsl-lx2160a-tqmlx2160a-mblx2160a.dtb: /soc/gpio@2320000: failed to match any schema with compatible: ['fsl,qoriq-gpio']
   arch/arm64/boot/dts/freescale/fsl-lx2160a-tqmlx2160a-mblx2160a.dtb: /soc/gpio@2330000: failed to match any schema with compatible: ['fsl,qoriq-gpio']
   arch/arm64/boot/dts/freescale/fsl-lx2160a-tqmlx2160a-mblx2160a.dtb: power-controller@1e34040: '#power-domain-cells' is a required property
   	from schema $id: http://devicetree.org/schemas/power/power-domain.yaml#
   arch/arm64/boot/dts/freescale/fsl-lx2160a-tqmlx2160a-mblx2160a.dtb: /soc/power-controller@1e34040: failed to match any schema with compatible: ['fsl,lx2160a-rcpm', 'fsl,qoriq-rcpm-2.1+']
   arch/arm64/boot/dts/freescale/fsl-lx2160a-tqmlx2160a-mblx2160a.dtb: /soc/power-controller@1e34040: failed to match any schema with compatible: ['fsl,lx2160a-rcpm', 'fsl,qoriq-rcpm-2.1+']
   arch/arm64/boot/dts/freescale/fsl-lx2160a-tqmlx2160a-mblx2160a.dtb: /soc/timer@2800000: failed to match any schema with compatible: ['fsl,lx2160a-ftm-alarm']

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
