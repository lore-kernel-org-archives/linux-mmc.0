Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11022081.outbound.protection.outlook.com [40.107.200.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C4FF29A9FA;
	Thu,  5 Feb 2026 03:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770262606; cv=fail; b=fce4hlyPKE0VUJ2wRBLqrALvhdlCVaqsEHsHuTjAZ0vOz8iy0d4OnOis0f2tuwZBi2tGzsMuyF0ciuaxxriOwrBpAnfMqygvvMdrLaePciaWWfwPXLdYUXzO+xMyjoaOhku7h8817paXRDbyE+0wZAZaBMyXrVSPisuMFe9jHW4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770262606; c=relaxed/simple;
	bh=J3jZ8gbfu6sSDQ0vItfnttuJJIb7vIVW09aIBA64OVc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eIkdbxxcYMbaWhpWY8K5y3It+bMjtxas+krAYndpJ5b5bU3sT+SjNByD6mtnJCif0QKdZH5XZd9R5J9aXi7feuVJdVzshOZ0jm6Ys/nrL0LhKzkSNmdeb1GPruoDnz0VvxSE8VyRJM6bjY5TvN0ztjzaVjZNENMCfTVnhLVGq3E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axiado.com; spf=pass smtp.mailfrom=axiado.com; dkim=pass (2048-bit key) header.d=axiado.com header.i=@axiado.com header.b=RCJLzE+v; arc=fail smtp.client-ip=40.107.200.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axiado.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axiado.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=axiado.com header.i=@axiado.com header.b="RCJLzE+v"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lb+68VffSApNtnLRrJa8u4KrDv8erWb903+hNwGHsniyNruNu+BTro2kfQxzBsl604gaeln6bON+VFwXIe49l96Og9Yfusi3fFtHzGn464Z3wG2WcjLaYPRcrIz3b0cUYP+VAG6/G5z8Se2pXDYxSokcOtL4/4BN4+QtOPGNp2kPgKOrXbEgiZncDeQOpm4lQ7xVTKicGmG8PAkUXyTub57D4dGXG27Y3Wto64MhKz5NSmzrNeSTIzg+5+fVoDBCorGdSMBrx8lqbL+CstoaE/5PhQwMVotI4D4yVe12qgeU6NcpMyt8fNvb/NkgDhfAyM+N/zJ3fseS0a1AvJ34AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x0RFa5kPDBPn0aXxxeuGNLa4xtb/Uaw5TFcFW6AgJxk=;
 b=tiAy9hAxpnaMKF+T877iI4O81s8BwDhnWvrftdoDrkCEyFnZNjWRty6YlUDP/54Jyiuim+lx8d3rrLheOBdygbQkq01iDrkR619OfwxvY02N/k1VpJGa4AxNass/7pQln9Btuu1k6USkiHLVsRpaor8jQA/A1jv9z6ZnnPZ6bGLhts4dsMmRW1CIk/xdk0KAgVZCRRHskEXvdEK9IRTHfDQxpnkInZWg1/8hOl1lsDXnyoeqDZiBF7NiPBtX0aRKDzvBsZT03VpvtKk1YBcvoGbFrTo0IA6e+MhZcDl5lbn+zjZl9q37KIhMllGJKuNjdhsLnJFT5pg0nk/ZrrqR/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axiado.com; dmarc=pass action=none header.from=axiado.com;
 dkim=pass header.d=axiado.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x0RFa5kPDBPn0aXxxeuGNLa4xtb/Uaw5TFcFW6AgJxk=;
 b=RCJLzE+v7ci4CyQMKiwk44laBPhWqFeT/rX2+rqJrOJse9kHiznEOiGvrpLc4zRtwN/rFz4EeCwToKwzz1kK9/oQTv/lN3t40k7Obyn+M24PCDUe5sYKsBwN8Q9IzfSr33FZZT5zhLNRnbe5G6ZftuVDjrjz/iI8mrMajiGfIM3Wz9zMrQqH3SSfJMFDS/0ycxp/Rxx0OVdtHir8VCZm6o4+TQG4ALZdOQkLWVcn6Zv2u1+pCz2TPGcnSafYF9xXM6O3rsBWTvP0GWvAAqqG/4Fbm7sL+WXMz4/RgwbeRFwFp/nPPQkAuv3EVschrJaGk3l0A5YOXbXgzU19jdxsiQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received: from PH0PR18MB4558.namprd18.prod.outlook.com (2603:10b6:510:ac::13)
 by SA3PR18MB5391.namprd18.prod.outlook.com (2603:10b6:806:2f3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.14; Thu, 5 Feb
 2026 03:36:44 +0000
Received: from PH0PR18MB4558.namprd18.prod.outlook.com
 ([fe80::7a75:75a5:694b:2311]) by PH0PR18MB4558.namprd18.prod.outlook.com
 ([fe80::7a75:75a5:694b:2311%7]) with mapi id 15.20.9587.013; Thu, 5 Feb 2026
 03:36:44 +0000
Message-ID: <8233de0b-5e9a-4e11-bd24-241ffceb278d@axiado.com>
Date: Thu, 5 Feb 2026 11:36:39 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] dt-bindings: phy: axiado,ax3000-emmc-phy: add Axiado
 eMMC PHY document
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: SriNavmani A <srinavmani@axiado.com>,
 Prasad Bolisetty <pbolisetty@axiado.com>, Vinod Koul <vkoul@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Harshit Shah <hshah@axiado.com>,
 Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter
 <adrian.hunter@intel.com>, Michal Simek <michal.simek@amd.com>,
 linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mmc@vger.kernel.org
References: <20251222-axiado-ax3000-add-emmc-host-driver-support-v1-0-5457d0ebcdb4@axiado.com>
 <20251222-axiado-ax3000-add-emmc-host-driver-support-v1-1-5457d0ebcdb4@axiado.com>
 <20251223-adder-of-imminent-recreation-ea90c0@quoll>
Content-Language: en-US
From: Tzu-Hao Wei <twei@axiado.com>
In-Reply-To: <20251223-adder-of-imminent-recreation-ea90c0@quoll>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR01CA0014.prod.exchangelabs.com (2603:10b6:805:b6::27)
 To PH0PR18MB4558.namprd18.prod.outlook.com (2603:10b6:510:ac::13)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR18MB4558:EE_|SA3PR18MB5391:EE_
X-MS-Office365-Filtering-Correlation-Id: df8f9d39-ed5c-4c8c-0060-08de6467c84f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|42112799006|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cTVhNXVxM2R2QzAxdzB5NU02eSszQURhTkdkYTdDcm1zbDFwY0pPU0NDQUN3?=
 =?utf-8?B?S1BycXI4ZllyT21oRVlNeHBJSzJpaU5jZmx0MkVKSWtvL2cvN3hnY0I1TWZP?=
 =?utf-8?B?Y05sdEExUGt0Q0RRTjNZVUgrZFQ2NGN0QjliZmxnakdYNndzZ0dhN3FhcTdM?=
 =?utf-8?B?d1FVMnhNUHRDaGVhREduRUxsaEllSWZaLytiOWExRU5KSG9uZGNUZmI1T281?=
 =?utf-8?B?MzJIbm9vN2d1dlNSR2tNd1pLZm4vU2dGNnRlSGRpVFM3WW1WaitTV3g1clRv?=
 =?utf-8?B?U0RVNXZta2NnbXhmZHE3OUo2c0I4bXFXdllMbmMrQVBUL29MTERKNkFXYmpP?=
 =?utf-8?B?VmZpYmh2OWRPSmxrVXUxa3NsY2Z0SWg0amFHbnJyU1VmaVNVKytMQnE5d08z?=
 =?utf-8?B?N3RURmtGSWFvVGNZZVR3anNLM3JzZFA2M0pMekVUTFdjT0hxaXZBaHQ0ZW8r?=
 =?utf-8?B?Yktrdmd1MTRvNmlxam9CbFBLOGlKWU1Uc252Mk5GK2JkNjRjQ2d0UUo5NDhZ?=
 =?utf-8?B?V09TdFVNYTNsWXk5OVlaQjBnTUZwSEpIdEpUOEZROHJKcDFFQ3NxYnJsVVYr?=
 =?utf-8?B?R2lCUEs1b1dFdXhNSEFCMUFQOFJJZzJxYVA1OE91b3BHVllKYkIwdHJzV05v?=
 =?utf-8?B?VFFiV3AwbFpndFJ4QTZmTDY1MkpCcTNReDNmNmZpZHpqZkhCYWtoYUpYQTdM?=
 =?utf-8?B?VVpDdVJTZ1B0R2VJUlg0L3NyT2NVaGV3bVIyNUJiNUtwRkk3MDBVNkFnSVZV?=
 =?utf-8?B?alM0K1ZDOHZoazROQkRIamszVW5sTVBSamVJUlBBejE0TGJqcGdnTHdzQkdk?=
 =?utf-8?B?L3RiM0JiRlFrZGZWVzExRC9mMVdjY3pDT0FQeDRjajMvaEhpSXZJUHl4Ulkz?=
 =?utf-8?B?dlJCLzZkVVp2bTU0YTluOEpFQTlFY2gwQU9id2grRmVNVnNSVjN3cHBLaWE5?=
 =?utf-8?B?NU1OZVkwZm9sSWh0eU1qQkZabk1yaDNXZ1N4eE5LZUlPN1pDbUNpUDBUb2RL?=
 =?utf-8?B?eWdHejAva29qRkpMdDNZNU1zeElxNzBML0JtT1hKaWJGaWEvRnZOenAxTExM?=
 =?utf-8?B?NzM0UXBhYld0SlZ5TXNONnF2R0JhaEdzUm55N1pxY1BGWDl4N0djSGlBM1h0?=
 =?utf-8?B?QXRmQm5qdFBDbjg1SDJra2hScXlIZkc0Z0MwWGRBOTF6a2p2dm1RbGl4M1lq?=
 =?utf-8?B?bWxiTHpEcmxlaEthZHR6bXdRd3JMSFpFV3JEQllpamFNUTBGbkN6aWE1UGdM?=
 =?utf-8?B?d0hYWjdKYlN3VlhpK0g2ajJpUWIwVEV5c0lTVzQzbjd4K0l2cHkveHpXNjJB?=
 =?utf-8?B?ZzVWZWtJN1MweXVOWmpuSmd0bWV2STZwZjl4d1F1amRRenNlSzVCS0s3ZWpr?=
 =?utf-8?B?UWY4a0N4ajJxWUp5RjIvYzAvUUJIV2J3OWFwK0MwTkpIdHAwNEtkRHYwdmFR?=
 =?utf-8?B?bkNaY2xIeFFSbFYwTjhIelNzVkRSOVFENmJDSDFFZVRrUk9SWmZCWHF4ZmdG?=
 =?utf-8?B?bEpvbTQ3M2tIcFlnSWZJVTNsT2pOc3l0SXJoc3p4VWxucjlBU0YrK2VYcHY5?=
 =?utf-8?B?NUIzK2ltNlVWVXd1NjFLeThsOTROZnl0SzRkZHlTWHRGSUtLL3FqSStpUDZj?=
 =?utf-8?B?SjZZNDFDWVhHVU92Ulg4MXFNTVpsL1dzK3kwR2N2cVp6T2I2dmJtRENFUWRa?=
 =?utf-8?B?THRTeEFETmFycEJLbHJtUWRzSlJmcTliUGFXd2Y4cUZOSkJ6YWVzcGE1eDBV?=
 =?utf-8?B?NmlZTFc1MUpjQ3pHSUdxdGxRbXZUWjNKb29SMGgvcFRBcTJOdittTEpPb3hQ?=
 =?utf-8?B?OEoyRzVTdEExTkFBQnpOSTRwOTBqMFlsVlpZbmduVWRFbW9IVkNjcGxlWmpR?=
 =?utf-8?B?SVpubkxwNzJoUlJrMFdQM3JzUzFTUFF1VjRUN1B1dEpKbFVkTzRJVVlRUDlP?=
 =?utf-8?B?RUdOK2d0NDJHQXJkdlFpSU1zV1dzZFkwckZiNGRWSUdhT2VZRzVRQ2RRSEFm?=
 =?utf-8?B?TWhvMWFZSW1yYjBDKzlhZnF6V3BwaTZpRVkyWVZ2VWJ2T3dsVjBVWFpHUWtj?=
 =?utf-8?Q?YJncdj?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR18MB4558.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(42112799006)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bFZFS1JrdDhZeHRhSCsrMWg4RWtWdFE0empjdWFlYXVVSXRQcGxqcHFPc3ZS?=
 =?utf-8?B?UFYzOUc3STV1ME11Y2c0ci80STRpTUFhMGFxVEF4ZDlHSUliaUkxd2M3KzZt?=
 =?utf-8?B?SmEva0NoNG9peVM1VDgxTXVzNnRyTnhQMllvdEJuay9TZHk1M1llbUhLN1Zm?=
 =?utf-8?B?cG9QMlhiSWpMZ1pJOW5STnRScklVTjg0NkwzZFpaMVUvNGdJcW90Yyt6T1Br?=
 =?utf-8?B?M0xpY1B6ci9FWW5rTUpwdE9wRkk5dll1S3g2LzRIV1RpM1JkMXluTkJNNlJr?=
 =?utf-8?B?Rzdlc2orSytocWhsSjcyTGFjNkUwZTZWdUlTQUgySjdVNHpEY2dkWU51cCsw?=
 =?utf-8?B?VVZYYzdxQVl1RUxEaXdSYk8vOFREM0RXRE1sQ0E4ZFludHVvTkFCNG4zdDB2?=
 =?utf-8?B?eXVxdk1XR0FNNUdYelIxUmZNZUlLVS9OYm9LVjM2SkNHQW1XMXorU3VmWFlu?=
 =?utf-8?B?STdlaFRXdWhDREtPK2lmNVMvbzM4MXFxUWZQZ1EyMnVyb1RIZ1NtKzBhRUJK?=
 =?utf-8?B?ZnVQUjBVcXgva2FNV3ZGYlU2bkgvaFFKY29lMEJjL2RsNUp5TTFOWXFUMVFh?=
 =?utf-8?B?amUyaDhFcEhRNXB6TnJkeW44L0w2OWpZajRBZWRQM0drRDdpZmU2cTBEdnJw?=
 =?utf-8?B?c0JLaFFzOVZpWFpWV2U3YTAycmFhc0c5dnplZElqOTBtTXB5N0YxSDBwTGZ1?=
 =?utf-8?B?WElJdjNGc3BXblJENmQxMk9MZXphcVRlVXFuV3pKZi8xd2x5NU9DNndrUWFm?=
 =?utf-8?B?TUh6eEVVQ1RnYkRMZE9WWTFMK0VURWxZZ2o4SHJkTDViOGpYaDZLNjZmUjk5?=
 =?utf-8?B?ck5kL1ovdFhqUlM1Z0JhMjVabUoyMjVtdk4wUG5RcVBQbEF0dHZmTDJ6RDc1?=
 =?utf-8?B?c0ZNOFlRbFBQa2FqYllmb2c3ZDN3aWRBcUswVW84V3RBSVUwUm1OUUJLYSt1?=
 =?utf-8?B?d2VJOXlUOE1VN0h1OTgrS1daSTRCRXQ4S09nU2xkK3BZUlJtMjRwbXZzWVlI?=
 =?utf-8?B?VHk1bkVXd3EzZlpMdXZ1YWl0QkdSTXlBMkxNQyt1N2tZUU14dnB5bXlSRFRM?=
 =?utf-8?B?Tjdza1BVekdIUlhWUTJhZy9GUmxWVVp1SlhIKzdyVkxaOWx6YUNGWnc2NGdV?=
 =?utf-8?B?QkZXZjlUejhGWUx3aG0xa3B4dTd1bHd6U0Fzd2NmSVdpcGRrUGJNbW54eEVQ?=
 =?utf-8?B?ZkVHZG5TeDNodDM5NGdsOFhDRnNXL3BHWFpRSEZKd2pKYWhPSHg3S2E0a09X?=
 =?utf-8?B?U3FIVTBDSUxxSnpmVUM2Ulc5ZVNMNnlGVGdHMHkvTHdHdW40dmFzSHNKNVNY?=
 =?utf-8?B?OExaSVFoWXlHODRQdzh4bS9QSXdjZG01TDRKY2RiQjJ5WmlpakFFU0pYb3Vm?=
 =?utf-8?B?UUYySytieGo4U21kY3Y4TEh5dkFCQUVpVm8yTGc3djdFTHdWQzdPVk5SajRT?=
 =?utf-8?B?a3FDcHdxNTNKMkJ3MUhRSGM1Q3pwRGlVYXlIWlhHbjB4c2NTam1pSXk5SU9o?=
 =?utf-8?B?WGtHZk1tZ3lnVFBvZ3ZSUXdicllRMXA4YmZqbkJBOEFFRHRoeTFJeXkvTTY1?=
 =?utf-8?B?RXFPeWwvQy8wVDUyWGFEc0I4dDh4dUVYVGdHUG1VSXJ4a09oTmFRa2k0aEk0?=
 =?utf-8?B?NlhTMVlYc2pabVZSUlhDd2g3cXFXWmNmYWRjSWQ4NnNMUlJEejY2UFd3WEdO?=
 =?utf-8?B?MWw2YWFRTlh5YmZUN25WaG8vazhpNmFBL3RBcUhDQVJVMFhnK0N4R1JETlVr?=
 =?utf-8?B?KzIwYTY0b1JIYk1Rd01XTFQxMEFLeWdQNUZTYURuZmhYK1hNeTlHbFd0dGF6?=
 =?utf-8?B?VTZoem81WEVSRDExR3NSSTBqMU1nZ216blpxMTVreFlJTng4WXRYM0ZyeGZv?=
 =?utf-8?B?YlNBV1VpVndIMU9uMkIyQzBWbExIcHBVeGZweDdaSkhmTjExWVRHSkk4U0pX?=
 =?utf-8?B?cWE0RVYzNUY1cEUvMWpFTFVlUFFES1VzRHpjVUlBL21pM3pYVWdTejA1aURt?=
 =?utf-8?B?dk5WaFdNS0NZREhjckptTnlMa0xFbVlQdVEza3cyNWFrT3A2QzNtckRkSzRC?=
 =?utf-8?B?a0JOZFRQdEZ2cEVkcndtcjFDdkwvWFpyeHNXMDdnYmZpL2N1WDRza2IzeHBJ?=
 =?utf-8?B?cEZjMElOdEtYVEdENUo3WklUL0l6SER0a2pmVEpiMWRGQjl4bzM4ajlSZ1Jr?=
 =?utf-8?B?eEptV05DNm9rMThCZk5YbzhhVnRNcDNJOGdZa1RjTCt2VnY1TjdEQ3FDQzkv?=
 =?utf-8?B?SUxqdFVjd01JcnNXckY5cXp1OHQ2T2xMbnc0eXU0aW1hSlJ1WE9MeElCb2R5?=
 =?utf-8?Q?Bf4p7NMbL56uVPkQgR?=
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df8f9d39-ed5c-4c8c-0060-08de6467c84f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR18MB4558.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 03:36:43.9346
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DqrS/JHotTnuGv1LjdBgEgcN2eFMOQKxHLTg9lEsJXLwr3dM60NuycbG6UPMWRLe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR18MB5391

On 12/23/2025 10:23 PM, Krzysztof Kozlowski wrote:
> CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you recognize the sender and know the content is safe.
> 
> 
> On Mon, Dec 22, 2025 at 04:45:00PM +0800, Tzu-Hao Wei wrote:
>> From: SriNavmani A <srinavmani@axiado.com>
>>
>> Add device tree bindings for the Axiado AX3000 eMMC PHY. The bindings
>> define the required properties for configuring the external Arasan
> 
> Ah, and also:
> 
> A nit, subject: drop second/last, redundant "document". The
> "dt-bindings" prefix is already stating that these are documents.
> See also:
> https://elixir.bootlin.com/linux/v6.17-rc3/source/Documentation/devicetree/bindings/submitting-patches.rst#L18
> 
> Best regards,
> Krzysztof
> 
Revised the subject in the new patch

Best regards,
TH
