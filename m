Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011032.outbound.protection.outlook.com [52.101.70.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43DCB37BE60;
	Tue, 24 Feb 2026 11:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771931747; cv=fail; b=mH4Pt+SSlYmgWTLefD3XU3wkxBwXnscOQrES+KBfhmg3rMDitQlLhUdVt7vYK7unYYqXMLre3aAFEReJZvppouv+1moAcrZrewRI8xg0bH0Yf9Wg8buq8XDLc2ZrJN/sS51kgSJdOD5UJuwc0zesF4GuRhs7NDEvXZYSASjhuro=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771931747; c=relaxed/simple;
	bh=jiLgjin10y+xHab4T5SGF+1pQ/J9bktzPkym0UZnVHc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kxX0KNdEp6F244dhlNNycRRjbpMowhwWrxo5XC/2v+BFe2OOUPug4xD2jwF3TBYpttZLUIPfrjLiKEF+jJnZHKayM9hJHK1sxW7mY5xhOOnNpXSzhHuEaR7WzwFG7VzIBasrc1Q6OPnLqWv02ROMkQRke+LpNvWX/hPO6fUCk90=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=Ce2PPCte; arc=fail smtp.client-ip=52.101.70.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Ce2PPCte"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JapkWS9MNfDhCPDZX3jP+TEPT8ErwBNVvAwAksPeHIAJN8BJaLb1RGM5l3MqVxBae9IGue0duj7NYYfflzeZcdhpDvMDlomvAgZBt+UhTexN5T0VhWtMO5YjusJjz3JnjzI34f7EOo0wPvNvSmaCeIlXe5u39TiiBdl64E1lCcOIt0ImNhL/Xvh7CzrMkO0Da2J5GGKfwx3p0GkVLJ5mI+HwiJEyHjFgbE3MY/M32tFzmFrDU77R+NpfOM7aALAGqlkDuEpZ4vflY4inun3NTV2mJlPpZtW0BYWAh39KcGULurhDvhyKLz4JPBmHLz/0EBecpS6vmByN2VEU/cH0ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eYaHZoOgGRL7OLNCU0XTn6cZonlsuVmV9uEkjz43sxU=;
 b=Dzj98pzrHGUoFW2grRTMzhDo29tC+RY/TDNiaiiwFCgHOnTByaMLmVksraK9EXxKzczcWioF4CT6Ubs8UonlnKp9nLEcV6lIF0e91bmXDlhPZm8bAS5M7JwPQf51yKo4AEUUOTgB9t9BG2rX89IiR8uec0yxPeaF1Pg9nulQr5Nm2fOusBgLUWk3OOe2ooOxDvmq0jQ1zZwFf1DUJqcQ0fn9dkmOANkEtNUxu5u6gyRHTPjeRF0Q6IZp1G/5w5LMzul5LoFRm6sK3XGQyX3jkD0E/mEnP0iznJFVju13oDI0a3Kh91DquOniZt5H+Abi6f3l/o/K5vmpSYMCA3xHTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eYaHZoOgGRL7OLNCU0XTn6cZonlsuVmV9uEkjz43sxU=;
 b=Ce2PPCtekUINsD+mOtn35HMpUcH+Je/kWw5W1EiTpHfSqiFN8XJpNHy5zwneVjFLjTtmBtD0Nq/GFXCbAyF5RA8qIHDdoVFNx3TWd6ysEO6Le4JqkS9ZhNbVqJDAT9OG+YCofXcaPrJobgdGuJktNM3dLG6V15JBwjsyveivzyvTR6mUbkXbHtyKcvUEANmkKyhBFjgvcKdgwWzjBEO+wkwxKsXPwIn67VtqDef5IeE1sGjZlh9E9akAv0AN+6eOqLHJYm0SnfCV1XmF0VR1mP+b0rX3VUs+i7M4ZYTeLGkO67x2Srg8/2dxkq80KGJrsHAYlcpcmx3RVIK6v3v4ig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com (2603:10a6:10:352::15)
 by VI0PR04MB12114.eurprd04.prod.outlook.com (2603:10a6:800:315::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Tue, 24 Feb
 2026 11:15:42 +0000
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::5c3a:1a67:2e02:20d0]) by DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::5c3a:1a67:2e02:20d0%5]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 11:15:42 +0000
From: Ciprian Costea <ciprianmarian.costea@oss.nxp.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Lucas Stach <l.stach@pengutronix.de>,
	Christophe Lizzi <clizzi@redhat.com>,
	Alberto Ruiz <aruizrui@redhat.com>,
	Enric Balletbo <eballetb@redhat.com>,
	Eric Chanudet <echanude@redhat.com>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	NXP S32 Linux Team <s32@nxp.com>,
	Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>,
	Larisa Grigore <larisa.grigore@nxp.com>
Subject: [PATCH 1/4] dt-bindings: interrupt-controller: fsl,irqsteer: add S32N79 support
Date: Tue, 24 Feb 2026 12:15:30 +0100
Message-ID: <20260224111533.3194883-2-ciprianmarian.costea@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260224111533.3194883-1-ciprianmarian.costea@oss.nxp.com>
References: <20260224111533.3194883-1-ciprianmarian.costea@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0067.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::7) To DU0PR04MB9251.eurprd04.prod.outlook.com
 (2603:10a6:10:352::15)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9251:EE_|VI0PR04MB12114:EE_
X-MS-Office365-Filtering-Correlation-Id: ee5b72ec-a407-4571-49f1-08de73960c32
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|7416014|376014|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?by9SYklmZEFiRGYrdW1wN0c5Y0tYbE5sOGJOVUx6OXk2NG9wUmRCMi9rQXg0?=
 =?utf-8?B?SzhMblB0dGE4Uzd3R0xQZ0E1WU05UHJqZlpVU0IxbFd3NjgwV1pJRVlPaVhl?=
 =?utf-8?B?RUJ2bC9kUlhtYlBKb2xhTkM4c3hQSzlUbzZNcUFWN2dwdXVpRHpwam5wWDBN?=
 =?utf-8?B?OXZUVFpQQW12REZnb01Ob1ZOc0ZJYm1YaFVudzdYeEF4SklzUHNzeTI2YjYv?=
 =?utf-8?B?SjRadWxCYlBPYkdmQXlIU2RiZE1oaG9qVXluMVRMNWcvSFJjSGRnUmRGN1Uy?=
 =?utf-8?B?MmJBMFZzUHRtbzZrTHQ5V1M5VUYzYWhuek00ZXJsQk14WkgzbkN3djJqb3V4?=
 =?utf-8?B?ai9jMDFjVkJFdDh5UEVleWEyVnUvUGc4S3hHb3ErcWx5VnFUQ3QwbEtXYTAy?=
 =?utf-8?B?UXNJaTY5d3UzbnJ0RExWOXIvdUc4ZWh0QXBaeTU1V3kra29ncFMxS2RNZ0U4?=
 =?utf-8?B?NHpkbG1aVDZQN2xlaDQ3ODg4bVBITFJHZnlMSnVCTkUzQUJsTVlLelMwai8z?=
 =?utf-8?B?RU1zcEVkWVBVRktqbmJEeHpSYWRpRS9FT0VwcUx1eFV3YWczeGdvQjZHVkdH?=
 =?utf-8?B?eHl1VUdkckhCdzJTSlkxU3NDOWs0ZmUzZkU5VU9EZ2RiVmhlSTdUeE1haVNy?=
 =?utf-8?B?SlBBYytBWjN0dEFPMkp4Z045anVxeXJMZTRseGRCU09aK0Z6OG9ZRHIxd05Q?=
 =?utf-8?B?anppUE5ic28yeXd0NTUrMmtnNnA0enI2bmpPbEIvQTVsbTZPNHRHS1VaMXd4?=
 =?utf-8?B?K0t3ZzlYOXBkcDZSM2Y1WmlYcXM0RGI0ek52STUvTk5iaXc0cE4zb2FJV1ZL?=
 =?utf-8?B?WURLSXNYODZJbTdUVWxPS0ZSNHBnYUZlU205M0x5MXJQWmtBWW90UTlRWnlO?=
 =?utf-8?B?Z2dnK2VNcDU3NE9yOVBzNW90RHNaalVlYnFWOTZyajdrK09XMXlpaENMUjgy?=
 =?utf-8?B?QVNodkNEWGtOdHZ3eXl4SXIzZnptcVUrYVlIZ2lGSVZUSVduTFl6QUs0MVFw?=
 =?utf-8?B?ZENlNElWTTh5N3U5SHdESUZGZlRoK09PdVRxbTNTNnFjVG9XNGkwaktUd0VU?=
 =?utf-8?B?RzZabVFiT0hFWmJqeE1RclFKdXdIQmorWEJTRWNLVldsaEpITEl2aVBZOTVU?=
 =?utf-8?B?S0FDQ0wxelFUT213dmFyOCs1N2JOSkJqRFR1dEsrc1NmRWdTTGF4NFd3QTlO?=
 =?utf-8?B?bU9OVzliLzd0dUg0bGZ4emQ5WEJYYk5KY3RZUWJVelpNWFF0bWhaNUVnYTE2?=
 =?utf-8?B?Zy85YjNlWUw1Zm9TWE80UmpoUy9ITUJCNTREZVc5aWxzRU9WVVRvdEVxQ0Nq?=
 =?utf-8?B?Q0taaUR6ZXAwdWxUcFhVak5WeHR1UW5OZjErSUtCUkp6NHNGU3NJdWI2UzZU?=
 =?utf-8?B?Nkg5ZUdOam9yZWV3UjU4MmZsQ3VVTkttbHcyOVJESTI5c09LVXJiamN5SWlw?=
 =?utf-8?B?UVQ0dWxYb3BNQnB2Syt4T3VHTnBoaUl3RGt5NWd2RHNzZ3Jtd2tOOWRDVC9n?=
 =?utf-8?B?b1VkaE5BK1VvVzlwang2L1NiWWtkb1NWWlJEWUFvd2NZQjBIekxqTzNia29H?=
 =?utf-8?B?aWdlbUgvS3UwYVJzSnhCaFVScE5Gb0VoNGh6bW5YNVoweTFJZldkaWcvT3lI?=
 =?utf-8?B?N05wSUpMSHBMS0JlemVqZ3VKczhPRXoyL1QxQjdLN3JTdXVEZmd1bGx4ZWxO?=
 =?utf-8?B?SUZJYWlHYVBWWkNjVjk1eHBjUDFmaGlUaHF4QzVPT3BQdk01VVlOWW4wWVVo?=
 =?utf-8?B?eXJrb1JUTzBaS2xUdGJwb09HVzBYYVU1bnkvdTg2S3ZUdU4yVkFuV3Rxbkc2?=
 =?utf-8?B?NzBYTUZ5aWR6aHdkUmVNeEpBU3hjcUc5dzRPRGd1RWlDOFRlMUVGa0xiZVkz?=
 =?utf-8?B?ekt2cWUyUng5SDZCS0h4c3YzRXIzZENGY3BsaGVlby9UVWRzbTJwUjNlSFRa?=
 =?utf-8?B?TktOeENuVElid0xSL3Z2eWJGYVAzR3U1V0hQc3BLVHAwZVdDRldsRWpQU21s?=
 =?utf-8?B?cURaSmxJTjE0T05QTnhiaU42SC94ZlEzaDQ4MFN5N2pLampZc0JHWjl5ZFhF?=
 =?utf-8?B?dWU1ZWJCNm91T0FLSUljZ2NPckczbU9tcWpvMjQrcis4NEkrR1FsV0dCNnBT?=
 =?utf-8?B?WVdqaDZ2TUpwSmErUElPU0dtSERGb3NVWjEyR3RpVHpnNkdmYmhTQnhsY3M5?=
 =?utf-8?B?NXc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9251.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(7416014)(376014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eFhpZFFmT092S3NIL3dxSkx2emNiN3FhQUwyQ2EwU2pNZm4wNXVQMzBYUk9P?=
 =?utf-8?B?MEM3SDhMQWVkTHBCV09DUXpVQWs5cXljeFMrU1FiU1ZkTm1RUTB2V0xQL0tr?=
 =?utf-8?B?M0YvYmdNTTRCYWh2Q3ZTaFNPYnBpVlJ6MmNucUgyUXM4dUp6RDhiRGxXLzdK?=
 =?utf-8?B?eHoybTJoSTNDbEx6VnlwWEpQRjdyNVd4THhzYXBKN3psb0tHZFFad3UxVTZK?=
 =?utf-8?B?RXBXdWJVWGU5S2ZqQXhsbHprNnZDbURuUDJuZHUrS0NyMmlBNTFaZnZkSzJR?=
 =?utf-8?B?T0dkcnRSSHpZcmlzYnJHaVJQOUhqUy9vbEVOR3NjaHBEOG5wZUJrcFE0bndM?=
 =?utf-8?B?Tm40TTFrT0YyS0laUGFOWVRlYmNaQU5FRTRETTgvNXJ1OW9STEsxQlNFMXkx?=
 =?utf-8?B?RUdKRGlaY2JjbFhTSE10VGN5S3pXT3pSVm1hN3B2dmtrWXRJQWVURjdHaHZ2?=
 =?utf-8?B?WTF0K1A2eUQrK0tpTGtpSkxYNXZLNHkvVWFFNk0zcWhUV0xoNUcrRzg4U2ow?=
 =?utf-8?B?ckd2WFVINnYzUGI5cjJxdHppdU5MZU5EcENHUmVRRVZkY09CWnlwY2xKM3d6?=
 =?utf-8?B?MkFSZllrUEFaUUdrK0p3UXgvZ3ovTWowZG9vUXBRb2hhUHF6OGllYnJraTE5?=
 =?utf-8?B?Wk5MRnZoN2ZXL0tQN3Fad0g0YkcwNCtaaEZTZDRmSTJMc1A4VmNLSVJSWXZo?=
 =?utf-8?B?c1NtY1JwalhJL01oR0h5VE1ONGVIdjMxdkt1NlN2NHk0RVlpZU1lNHBET3pl?=
 =?utf-8?B?aWlNSUhQMktSVHdJeWRpUEwydm4zY3hoZUR2cWFGcFF2bHNqNjM1VS9TenMy?=
 =?utf-8?B?UjV0ZkxNMVNJd1ZtaTVoYWtacXUvbDBiMkl0ME80eE1pY2FwbU0rNUtSUDlC?=
 =?utf-8?B?WGh6RTFsZHhsekg4TzFLZ04wMmZxZWcrRldsL212S0VVMFl5OGpubE9BWUpp?=
 =?utf-8?B?TUtXVkdNcmRxQUxmUmNqQ0dNRTRvV2l2QnMvQ3VPTk5DME1pYkF4NTlEUURw?=
 =?utf-8?B?eGpyMk0xQ1dzWndkMzRBVVhpenhrclNURFVHejdyQ1RJVlp1UDNDWVBXR0Y3?=
 =?utf-8?B?V04veFErU2EvYW9ETnFhaXB0Vzl3blVHbGxCUFJ1OHo4dEFidzZNc2NCMXl2?=
 =?utf-8?B?OE92a0NySFdqS0dhMjFISFppc3R0RnZuKzk3OTdZdUI4OWtZc3JjaE1Ba1l6?=
 =?utf-8?B?eVM0blhwTmxYSGV0dTlqL2k4cU1tcVZUa0k4QWRpVTI2TXd4Ky9QZnllZjRJ?=
 =?utf-8?B?K0xiUDhxeFlVeVhyNFVjSGdwY2NTT2pRdndzd0lOWkNnLzh6bW8rUEhtU05y?=
 =?utf-8?B?YVZqckdLU3QrbGZ3TnA5YVNwVEZrRXl0WEVMbEJYbFBtNTdYQ2ZiVE9FcENp?=
 =?utf-8?B?cGI4YWRPdDFoalRwRUQ1K2FXOWh3MmNBaFBmdisrNWV6UG1OZmhlejNGTkpw?=
 =?utf-8?B?NGhhaEVHMWFOS1Q0TVkzeE5YcHIyZ0NxUGhkc3lPa0hHalE2elFYV0JPM3Jm?=
 =?utf-8?B?dCs5Z0NFLzlkLzRWa0JwUTBYZC9jdlhRWHVKVVd3NHViSWtEMEFyNnUzK2pR?=
 =?utf-8?B?YjZRT09TWUoxSklnRVpXN29yQXJsMUdPeDNWbEVPSVptZmtKekkwMG1wdFlj?=
 =?utf-8?B?MUJwZ0VoZ1JjREhQbjRxUmZpZUpKWWRnZUhicE9YTlhESGdEbVlqVlgweVFl?=
 =?utf-8?B?RUZ0U1lmeHlRWXRCN3BoeTZIcGpNUEpMbjdiczMvVVNFano0dkNYVndISytw?=
 =?utf-8?B?TW92ek5vMUZGRFI0aU9tTHgxZW9EN0UvcE9Fbm5VeHFrNUJMTFU1YThvOTdv?=
 =?utf-8?B?WmgrVlgzNVIwMHcrdEl0Mi9oR05vV0JDcXI3cTZValVDblBVN2I3NE96TCtZ?=
 =?utf-8?B?VkRseFNqZ1RRcTZ2ZjZBSG1RM3JIR3lXSmczVnJKd3RTYU53cS9DS0Z1aXcv?=
 =?utf-8?B?czJXdXp3VGxHR1pxd3JVR0FDcUNoaWRUb2kxZlI3c0xNSlJGQi9SRUdEUEMr?=
 =?utf-8?B?cWQ2TjMreTdpNTdISHdodUIvVjZwUFRMNTY1VnBWVFJOUWh2OVZoWTNqT1VR?=
 =?utf-8?B?MzhBbHhPWUhvN1ZCVk1ZTktEWkJTd3dsM2UxQmhRZyttNUlOSDM3Y3gyM3VS?=
 =?utf-8?B?alluS0lWcmw3YWxtMk84ditoQjR4YTlOczh0WHVNaFdJSXpvd1RXZ3RVRm5E?=
 =?utf-8?B?aDUyeXJDUEFVM0JPSzA2NEFHK05ENDdrTXlCbW1jcTczRG9GYW5uNjJnWmVP?=
 =?utf-8?B?aU0wNURYZCtmLzlRVFlGMmJSc1NUeVV6VnFsQjlpSVdjTEc2MkJyM2FwNWk2?=
 =?utf-8?B?VFo0Wi9zU0V5ZDVGa1ByYnY3ZkcxUmV0c25IcUhQR3BYWm4vYk00Q2tIUStC?=
 =?utf-8?Q?HheKbDcokI46NlKI=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee5b72ec-a407-4571-49f1-08de73960c32
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9251.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 11:15:42.4188
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pe/sta65sBTAos+hgHqwr2oOpkxZY0u3mU++4qYboUE/GJw+Q6m40PYYJylOch0GDka5bcPHBzYWoCm2MBIdcDEbDj+YfSY1dYfHGSPrg7s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB12114

From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>

Add compatible string for the interrupt steering controller used in NXP
S32N79 SoC.

The S32N79 SoC differs from the i.MX version by not implementing the
CHANCTRL register, but otherwise maintains the same programming model and
register layout.

Co-developed-by: Larisa Grigore <larisa.grigore@nxp.com>
Signed-off-by: Larisa Grigore <larisa.grigore@nxp.com>
Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
---
 .../devicetree/bindings/interrupt-controller/fsl,irqsteer.yaml   | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/fsl,irqsteer.yaml b/Documentation/devicetree/bindings/interrupt-controller/fsl,irqsteer.yaml
index 5c768c1e159c..caf3e4a1f26f 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/fsl,irqsteer.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/fsl,irqsteer.yaml
@@ -22,6 +22,7 @@ properties:
               - fsl,imx94-irqsteer
               - fsl,imx95-irqsteer
           - const: fsl,imx-irqsteer
+      - const: nxp,s32n79-irqsteer
 
   reg:
     maxItems: 1
-- 
2.43.0

