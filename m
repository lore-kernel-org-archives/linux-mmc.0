Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728DD2D0C8F;
	Tue, 14 Jul 2026 09:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784021639; cv=fail; b=T9QQxetXEVRl5Nm1IMaPLby2Ifjpt6Qc3ciumuDBeb8UI4cZngVrBTIEOLEnCMdryLyIWW2bI8mERmkgrDkOZiqNqgaN9XandynZy8OKXAt5BsjEn+UjurS2OpFNaUHnxnVzHL+5EStDwEY+eEtp3BaCjsEjCVuw8JgDik7J05g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784021639; c=relaxed/simple;
	bh=83KHyJ/b2FtbERA6/65ngMJebElt5Qh4alz8bB5cPN0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XmUHmyTDsS5UhNfOj8kcfFnWyooF/iLLde0FEuPrXeS+oV1wTF5dqtqfS7S23y6p+msEUpHy9mcJdunfP2O7BGoy1JO2kbG/UQY/B9FpdVzck21R7tkFTiFrzcLbU4pC/SV8AkiGLefivBHJgsyiR/4+EyFFZoZg2s67yH6Jjak=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UyQbOSLU; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UyQbOSLU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784021638; x=1815557638;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=83KHyJ/b2FtbERA6/65ngMJebElt5Qh4alz8bB5cPN0=;
  b=UyQbOSLUUiHfEmCx4z6oDAFZ9CXcLFarToqJM1I0zB/XRsIxEY0vc7dB
   FWvMN676n6A8Wm4FPIYZSpEDSH2mRH16xFoe6XkNUklU57fx1YhvgbwH2
   8wSPIXNQZmkyWglO4bofa8Lp6+rdM5/ATNhcPbhSQkyU0SLt/DBCRfJIU
   /ehqKw6sVJXylUxP12N5es7h/lQ/Zn+7S2MVm5mSbDokhMN1gqftAZR41
   krC9+pmlfyHFT7xRF+sha8kqABe6kM2sTFDyjHEzOWo/qrauJB/FKQmUG
   Dt3CDSqPuRj1tSWlEn/EX8gyOW9Pot3YUrojHceWIiqqsW4gWCb+LJBSn
   A==;
X-CSE-ConnectionGUID: gQ2zn+fYQTi0csVbXtrL6g==
X-CSE-MsgGUID: 3C470zk0T9S45XspMe7agQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11846"; a="84661521"
X-IronPort-AV: E=Sophos;i="6.25,163,1779174000"; 
   d="scan'208";a="84661521"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 02:33:56 -0700
X-CSE-ConnectionGUID: gNS4ltISRpWvhIvYooZwgg==
X-CSE-MsgGUID: o9FhYcdkQJm9A4g8pPc3rQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,163,1779174000"; 
   d="scan'208";a="279079121"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 02:33:56 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 14 Jul 2026 02:33:55 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Tue, 14 Jul 2026 02:33:55 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.35) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 14 Jul 2026 02:33:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D1vZ1Adz8a1F+PtsoBOLAyB8osC+xY4wsqooIVejyGIZFPwGXyMFMIR3+1xo1ZpNhVHGnVWwO+coOFEhiJ6AaaULT7igKAnbSj2gH6w6oVBt1dQDsba7YrJ7xjYbrbC0+ZZNhh/8vbzzhhxPTe1IVwYHe3CgU9Y02TspenTGXfrA434O7tf2fXC89BUPd+iJq8BdvMffPhF8qtdGIFhdLpoXGG3qzG+5dKI3fICe2g/EhXX9653sKCJMfAX9lUo5iOjFc5XRtu6oj/SgkoeCdf111TFOa5i0+v4olpSV263JV6JGrJnG+CY40PCfOIJq7U5BBsA5TcuqugFf01xFSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6bzcUh0NeTVNFO0dsN2oH13jNagu/WW2Eke4TUjbiss=;
 b=BR/NLzKhy8VGsgKjuSF8u/q12LiaD9GV9V0R+RzViv5QmBpyjG8tafkPd4oCD0P01r7hqi2bZP8NLp3eiNazd+S+L8FzEAY8/3aF8aiegvXCRhOsXxYPu5jfxWkFDjJXIeV7IbRazP3mIYNLdhxmIEX2bWZw3EaBU+N6eC7fCna4ycJjWRr7WT7TerkyyB9mN+r807IsINS5L2r0F4ESKROd7WCk4juP9U4mnmVSxLYeoOh/RYd8Yf5tV8sXe/RmQ1QrVH5gSyV9UJTRhDtpaJXI0STQe8mtbsf6VMWz3XX9MeXr0gTKY5rbInkl0/lf6NOCCpkOZ8SqtGrtC/Dtaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by SA1PR11MB5948.namprd11.prod.outlook.com (2603:10b6:806:23c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.9; Tue, 14 Jul
 2026 09:33:51 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%3]) with mapi id 15.21.0181.019; Tue, 14 Jul 2026
 09:33:51 +0000
Message-ID: <a822ae4b-1bc3-4b55-b65b-9503dad39c20@intel.com>
Date: Tue, 14 Jul 2026 12:33:31 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 23/42] mmc: sdhci-of-bst: Use
 devm_of_reserved_mem_device_init_by_idx()
To: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>, Bjorn Andersson
	<andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, Liviu Dudau
	<liviu.dudau@arm.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, "Joel
 Stanley" <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>,
	"Paul Cercueil" <paul@crapouillou.net>, Anitha Chrisanthus
	<anitha.chrisanthus@intel.com>, Paul Kocialkowski <paulk@sys-base.io>, "Linus
 Walleij" <linusw@kernel.org>, Chen-Yu Tsai <wens@kernel.org>, Jernej Skrabec
	<jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, "Alexey
 Brodkin" <abrodkin@synopsys.com>, Laurent Pinchart
	<laurent.pinchart@ideasonboard.com>, Tomi Valkeinen
	<tomi.valkeinen@ideasonboard.com>, Michal Simek <michal.simek@amd.com>,
	Daniel Scally <dan.scally@ideasonboard.com>, Jacopo Mondi
	<jacopo.mondi@ideasonboard.com>, Mauro Carvalho Chehab <mchehab@kernel.org>,
	Eddie James <eajames@linux.ibm.com>, Tiffany Lin <tiffany.lin@mediatek.com>,
	Andrew-CT Chen <andrew-ct.chen@mediatek.com>, Yunfei Dong
	<yunfei.dong@mediatek.com>, Minghsiu Tsai <minghsiu.tsai@mediatek.com>,
	Houlong Wei <houlong.wei@mediatek.com>, Matthias Brugger
	<matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, Joseph Liu <kwliu@nuvoton.com>,
	Marvin Lin <kflin@nuvoton.com>, Dmitry Osipenko
	<dmitry.osipenko@collabora.com>, Krzysztof Kozlowski <krzk@kernel.org>,
	Thierry Reding <thierry.reding@kernel.org>, Jonathan Hunter
	<jonathanh@nvidia.com>, Srinivas Kandagatla <srini@kernel.org>, Arnd Bergmann
	<arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ge Gordon
	<gordon.ge@bst.ai>, Ulf Hansson <ulfh@kernel.org>, Rob Herring
	<robh@kernel.org>, Saravana Kannan <saravanak@kernel.org>, Mathieu Poirier
	<mathieu.poirier@linaro.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai
	<tiwai@suse.com>, Shengjiu Wang <shengjiu.wang@gmail.com>, Xiubo Li
	<Xiubo.Lee@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown
	<broonie@kernel.org>, Frank Li <Frank.Li@nxp.com>, Sascha Hauer
	<s.hauer@pengutronix.de>, Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>, Daniel Baluta
	<daniel.baluta@nxp.com>, Orson Zhai <orsonzhai@gmail.com>, Baolin Wang
	<baolin.wang@linux.alibaba.com>, Peter Chen <peter.chen@cixtech.com>, "Fugang
 Duan" <fugang.duan@cixtech.com>
CC: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>, "BST Linux Kernel Upstream
 Group" <bst-upstream@bstai.top>, Fabio Estevam <festevam@gmail.com>, "Nicolin
 Chen" <nicoleotsuka@gmail.com>, Pengutronix Kernel Team
	<kernel@pengutronix.de>, Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>, Vijendar Mukunda
	<Vijendar.Mukunda@amd.com>, Chunyan Zhang <zhang.lyra@gmail.com>, "CIX Linux
 Kernel Upstream Group" <cix-kernel-upstream@cixtech.com>,
	<linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<dri-devel@lists.freedesktop.org>, <linux-aspeed@lists.ozlabs.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mips@vger.kernel.org>,
	<linux-sunxi@lists.linux.dev>, <linux-media@vger.kernel.org>,
	<openbmc@lists.ozlabs.org>, <linux-mediatek@lists.infradead.org>,
	<kernel@collabora.com>, <linux-tegra@vger.kernel.org>,
	<linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-remoteproc@vger.kernel.org>, <linux-staging@lists.linux.dev>,
	<linux-sound@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
	<imx@lists.linux.dev>, <sound-open-firmware@alsa-project.org>
References: <20260703193855.110619-1-mukesh.ojha@oss.qualcomm.com>
 <20260703193855.110619-24-mukesh.ojha@oss.qualcomm.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <20260703193855.110619-24-mukesh.ojha@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB9PR06CA0007.eurprd06.prod.outlook.com
 (2603:10a6:10:1db::12) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|SA1PR11MB5948:EE_
X-MS-Office365-Filtering-Correlation-Id: 4325f7c8-c50c-4021-36f4-08dee18b0373
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|23010399003|921020|18002099003|22082099003|4143699003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: mLuVenHFAgU3xwyWjzjD/YkQsDks53sEakK/j3atPYHwWC9pPNfyeZGUBnOLsPz//XhTpmSxVONdMl917Of0tfRP9Ls0NyFm/5g98gdhaS47FT8jUzyWIDtm5/yYJI7/RHvKPJyX9DXQBA4iTa1Uaz/uwE1DsDMTDoNnSR6qhNeRaSK1HymNamWNi2OLTTkobBvTD/X1qK7Qc9rau78ODgKxhkLtV/ERKMUX7trUXsRi1QBtskZpa/OwFV3F0O56wAwSG462jE3M9TD7QhLX98eqYfIkGXVDuJMbkTFTcXeSeOX0bhWkGD2Xj4pHvDsl1SS2yBHVvYoemB12CMvHpAEwtStFIbowdtnAaFjIAGMws0kzhorWD4xY/Y8sUiqxs1VYCkmY0XdMZtiaCjO6dVFrPqIB4GxS5puTGnXfI0TuH6G1gnfsq53fc3HkCXLL7bshKujEQRnpYn2CGH/ewXM5qpE7LF/KhcK9cwQeT8IGro4fjPpR9eD343AlIlkGl36th/FwgGk8CylJIb9OZbITPbLHb7MbXVmCC0prjHLCX7499iy9y9UUH8BZeIPkpSxL7rbm3bkJjPYNZhXP9jOYvcNx08bPqMPa2z583yP9co6/R2c9eI8A5HPSZB2joQQqE7nbuW44VCGgPinWT1Zd1CcVnmPIQeMmGtf/+a2GVTgAvXaXIaqLsWjBLo3np00nN8UMwZLoPBEGZAsAqA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(23010399003)(921020)(18002099003)(22082099003)(4143699003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eThXd0ZPZHJvdkZRb05GL1llck1zZGZ1eUxuOTNvc0N6a0U2dzRPclZMbFAv?=
 =?utf-8?B?ajJ6S2V1OWpmamt2L1A5TG9xcDRHNTc2YS9GcmIzNi9iRWliVEpsZzV2bmdW?=
 =?utf-8?B?TDhyUHBEUnJ3NE9ENDlGdjc3eVp4MHc3Tk9hWlVVL2MzKytQcDRNQWhVYmxE?=
 =?utf-8?B?eTRsa2s0cmNZMlJXcE5JQ2tVTnUyQ0ZTUWpaekJpOGw4VGhFOEpRLzRTeTY5?=
 =?utf-8?B?Zkd1ay8wR2JURy9Ba1RSWi9hVUg0UXFrUnEvaHFLTDMzZVN3Z0xFS1RDaWRt?=
 =?utf-8?B?VVFVSlk0MFVXVm9xakZpdWtkRVZJU1dxc09hVWV6MWZHVmpoSTBDWllBMms5?=
 =?utf-8?B?bytER2pLZFZRWlIweHpLY2FmZVJIOWl0VzB0b0ZLRDVrL1EybmZ2d0RwdlRR?=
 =?utf-8?B?L3dCK2NENHpmaG1XOElzTmN5U0k3bXhNQllEVVpkY1ptbGM2Z3FFSzdEc3V2?=
 =?utf-8?B?S0cydzU4Z0RUQ1dSUDdmRll5dDRWWXpqQlNDSkdCTlVLb29Udis2a2ZZemt1?=
 =?utf-8?B?RU1SeWxZZDZYeWhORldIYnViLzU0eVVTYkFkTXZWb0RQWkdGMTlZV0FWdTVU?=
 =?utf-8?B?RnR1MHRwTWlobWNTUHhlekxtcEltZUpQcmtUTHR4NGhtMGtNSnFhNldLK0hB?=
 =?utf-8?B?anovQzFCWEs3S2ptMGlNajFsZFNQaHA2SXZ5Ti9YTUc1S282cHEzeGE5UGho?=
 =?utf-8?B?LysyMzlSZkh6eGVvclZnNjF2OUMzRXI4N3Rnc1A1cHEzQTQyTldrUnlDVjN2?=
 =?utf-8?B?NzNPNERrZW43TU9xeXFYbzZuMDRQMGQ5MTFweFk1aTJnNUVvRjljdlFiSTVN?=
 =?utf-8?B?MGpCN3U2TFREYm9tODNBVjZPdS84dkJQUmlIM2xIUVJqbE03NmJrNWx6ak5w?=
 =?utf-8?B?a0tUTGhJc0FlTlVoQTBzaEkvT1dORFM2MlUzZ0NNV2IrNnFVeVVsMk5Ra0Iz?=
 =?utf-8?B?R1pGMHhnL2UwZ2hWZnFkK0Rrdk00RFpKT1dNVkxkYkViVFB2WjBGcnNEazV4?=
 =?utf-8?B?U0I5K0FHK1lmOEVDSGZyUnJ5aEYzcVFNSFI5N0N2Zy9MQkpyTEphTmRLeGhu?=
 =?utf-8?B?L3Z4NHNUYVRGckxPSk5BN0lwZmlRMEhVZkovWnpINU9jdjVqN3lsT2RmUFY5?=
 =?utf-8?B?S1k2RkJmR3oyUjlYcU5OMENCa0lnMGNjNU1JM0JFU0RPT1pCcWpXMExTOEVK?=
 =?utf-8?B?TjhXQzFrdE5mMjZPeVVsV3pWSDZLMXNzUDMzZWF1bEV1SUJycVd3ajhkOEpn?=
 =?utf-8?B?RmxzdnhKNTBBdjZyVWltclhScnoxQ3ZHWjdramU4SFFKZ0tKUFZQekthcGFS?=
 =?utf-8?B?QnI1VU5tV3NZUEFINmRIWEFYdVBieStrdHgxNDdTS05KaG92MjFCd2ZsbExQ?=
 =?utf-8?B?OW12Um1YV1o2TjQ1Q3U3TytMYUtWa0Y1TjdlU3pzcVMvMDcraW9acU51S1Vh?=
 =?utf-8?B?ejFEUG10UnhTaHczUWZqYjJ4YWFCNFZCb3U2UW9yWGZQdzhpUElDaVFicFFa?=
 =?utf-8?B?UEhYamVMUldUeUZzbUlBNXlpN1E0SFRwUkhuSHp5Y0FLdU1heG5HNG0wU1g0?=
 =?utf-8?B?T3lTQnFlWWJtYldkM2RrOWV2OGJUUnlaTGhlL3kxNnlQcGJFNFc3Sjl1ekhH?=
 =?utf-8?B?M09nbkpZSXNnTHI2d1FZWjl0NlB6MTVzSlVPc0ExWFVaWGxONnFndDBZMWQ4?=
 =?utf-8?B?eFJPa1JTZVZsaFVKZ2NZL25qV2pmSEhFa1hmSGZkQ0ppQXJyQzVaQnpmZE10?=
 =?utf-8?B?RC9WUFJkNS9ZdzA1aVJaZUVzY2xFYUxCUzErM2R4QVU2RzhzUGVjaUcyUW44?=
 =?utf-8?B?YTdZRjZmbXJXVGRROVRsVXNYdXFNaHlnQWNjZUhXS0dFOEY2M244V3dlNHow?=
 =?utf-8?B?TEdyMDJ5T21OR0VoZzVVNXAyN2xEZXBrSU9vTG41Vkw1OEE3QU1TczZNQ3Rz?=
 =?utf-8?B?NjNNYnlGZ2JvRFhWSEN3bkNCTWRqR1Fxb1B1ZUxKVzcxd2VzYmVUTUxYbm1W?=
 =?utf-8?B?QTBFazV4WU5GWjZaVms3aDRkcGg4aW5jM2hiM2FRaW9vZjVVVXU4eXBjc2hm?=
 =?utf-8?B?T1VXTzl4Ym9DdGhyMlViSFRyMWU4czBlbldUZzFiTGxxMzJQMkZYUHlqSVkz?=
 =?utf-8?B?SlNlZ1hTZDJxQ0N3SzNhS3E1QkhBL2xXNEN2Zm53S2dlUGx5TUN2anlad3Ry?=
 =?utf-8?B?QVBTWVVrWmlzbVR3djVaVXpPaVYzdk0vNnlJelAwWDlZNWRuUi9Ubk1ZSzd6?=
 =?utf-8?B?WVN1VG5kdnpoNloyT01LaHdLN3B6YVlGM0M5M3Nndy9Sd3RodFJnaE5ySDRv?=
 =?utf-8?B?Y0FIczlTZ21iNUJmK1B2OGs3WXdVVm1jdXNJL0RQTHBlR3dNUElwMHFUcWRt?=
 =?utf-8?Q?S05dAGM5QphIvG+0=3D?=
X-Exchange-RoutingPolicyChecked: ASmWy+HYE36u6olMgt3DDWeHRYL3ZzYuoOK5jiEJNw0KXCgIC2CgzRbNHmVQWVFvUELyVMzdDFABIJcaU4osYFWoCuguMBdWXzD/Tkx5sjxWLLhfzRKiEqQri37eH2IyHrcn/s6+E8K41gecT7tV9qtHi/BwXmHVDI8qlG+bfXGpUghJVkvrwfZhED+f+CjqpsVzEynrnG4LmCnbgf89zUn4xUJQNKmVwh812tcJ4leXueNeDru3MdJ4wUknGyikV2G07qgVvSqU4hMZh+C0muXZ/84kk3cnNXYsk1RnIbaWsq60wkwJl9p9Awixkhhrhacv8NTX4NB4c381IsxzEQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 4325f7c8-c50c-4021-36f4-08dee18b0373
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 09:33:50.9994
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2da2RgD5tAjivEP34EyjeABap+LOcNWNDA6RCPTE/2Li5U9RbM1HKE1FIod7RhbXSALmevsJClPAYrwAHBG5ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5948
X-OriginatorOrg: intel.com

On 03/07/2026 22:38, Mukesh Ojha wrote:
> Use the devres-managed devm_of_reserved_mem_device_init_by_idx() instead
> of the manual of_reserved_mem_device_init_by_idx()/
> of_reserved_mem_device_release() pair, letting the device resource
> manager handle cleanup automatically.
> 
> Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-of-bst.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-of-bst.c b/drivers/mmc/host/sdhci-of-bst.c
> index f8d3df715e1a..304554ced690 100644
> --- a/drivers/mmc/host/sdhci-of-bst.c
> +++ b/drivers/mmc/host/sdhci-of-bst.c
> @@ -405,7 +405,6 @@ static void sdhci_bst_free_bounce_buffer(struct sdhci_host *host)
>  				  host->bounce_buffer, host->bounce_addr);
>  		host->bounce_buffer = NULL;
>  	}
> -	of_reserved_mem_device_release(mmc_dev(host->mmc));
>  }
>  
>  static int sdhci_bst_alloc_bounce_buffer(struct sdhci_host *host)
> @@ -417,7 +416,7 @@ static int sdhci_bst_alloc_bounce_buffer(struct sdhci_host *host)
>  	/* Fixed SRAM bounce size to 32KB: verified config under 32-bit DMA addressing limit */
>  	bounce_size = SZ_32K;
>  
> -	ret = of_reserved_mem_device_init_by_idx(mmc_dev(mmc), mmc_dev(mmc)->of_node, 0);
> +	ret = devm_of_reserved_mem_device_init_by_idx(mmc_dev(mmc), mmc_dev(mmc)->of_node, 0);
>  	if (ret) {
>  		dev_err(mmc_dev(mmc), "Failed to initialize reserved memory\n");
>  		return ret;
> @@ -425,10 +424,8 @@ static int sdhci_bst_alloc_bounce_buffer(struct sdhci_host *host)
>  
>  	host->bounce_buffer = dma_alloc_coherent(mmc_dev(mmc), bounce_size,
>  						 &host->bounce_addr, GFP_KERNEL);
> -	if (!host->bounce_buffer) {
> -		of_reserved_mem_device_release(mmc_dev(mmc));
> +	if (!host->bounce_buffer)
>  		return -ENOMEM;
> -	}
>  
>  	host->bounce_buffer_size = bounce_size;
>  

