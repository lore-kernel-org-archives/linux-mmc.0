Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.70.59
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793866749;
	b=Il8VIC1HyGZSDztSOrERfDJBz4Ytyp9FSaCaC0Xjmi7g7yjK7ARbmN83T8yVWIhNywur
	 Exy5GIYnhwxwy4+p0YbcYJKXDNpmtusCZDydCxEWSMeO1OA64o2AYfOYA9G9VgDE+MTRi
	 rULFrcJAB/cQJT138VjHbpOKDuUZDOqQ66K4W7gbdqDvrJuzy6ggbPMPG7FaNEksWccRn
	 jGyQbf/F+g7MCISlCf/frvttY0tmdgVjd4h1rzNfn34kalCUK1q20C5P5hjDFjvcI2tbg
	 sjRDtExTSkOxtRlMiRDBjA/bmzPZQCn8st8Gsb0XvMnvPXmp2W/HQ6fCeHCfZCdR+yw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793866749;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:CC:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy:
	 X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=Jezb5M1R4S9EPSI3qudCjR3JSXde/F+quZ+bw+ThREU=;
	b=NWMQ6ra4gshVWd1e892JGPs8EcTzHiewN+VPETCMrRis9CEQEm4Qu0yFz5BcbjR+zSNr
	 c0r5J8vPh0hwvNWeE/g6iQAP4vHaG5lTH6zJ4B3b9Mt5XcagUIJ2VFypPVzc9zYtDLXPU
	 GSp2VL88SG1T0wyDMmvM0Sd8VP6jmYbe+QrrwkspBohHpKGIVRddtOkUWS5zP7yH1TUEi
	 Q+1PLwQDI58Bst4DUQTnAexpsb1l+DRpdbwz0kcqOCKQI/iXQ+MlrNhhI0LwSZ3zgj/7o
	 YrPURwflL+2ERh3z9q3Ly/8rpt66FtK+AW7Tfzv4Doz95szjLDQaMNFJcHmWVcSUDpw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=foss.st.com;
	spf=pass smtp.mailfrom=foss.st.com;
	dkim=pass header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=Z+BGdudK;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.70.59
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011059.outbound.protection.outlook.com [52.101.70.59])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1AEE606D806;
	Thu,  5 Nov 2026 08:19:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D1AEE606D806
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=Z+BGdudK
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OhweFSWWl1/EjRecfkbqocoWmADOmm5gzzFVVXk9WNiaAriZEjsqUnW5PdgoUjMkYvf+O6KOBZhsWRSY6xqpbL1cFWkZASDQ3uSYKa8lCjBYqurbnWaOh3+bLBR1nf9AsiX+OoYRtKqkeUjV2JsWjItr7LiNf07ZQQtG7OEtmuaHo5IdZEccncrJYOBFLfN+r/dcj+JvE5xPz7VFdYrkAdW1HyLjAKkm0nXAhuBKTtnwF/ltB3rMj7CKz4py5iiA2ohkNvx8V1sOWaq7OoOZywIK2N1YtkapzGle0arpj/0OwWsk4GhMq8JqwHpxGdGYjOoYlTAsDXQ10hv24lqjdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jezb5M1R4S9EPSI3qudCjR3JSXde/F+quZ+bw+ThREU=;
 b=UuZOYqev4DBXBXrv78wkFr+138RkIzfblKnrqjfxOFSrFeh2R2IuG26NF1rs3+FIW4BS3nS+R0Xr/xiWYnbdVeriYPAmnH++HBE91fQglJ4OGhUP4RXOjQ+6by8/ia/K3Pn7BqgXcdM5lVtGB2iTUm4bcb/mSP1qo8GtdRDs7m/xI0+jqKRcrYfqsHMtnkgZkKfqeuJSNp6Uxnm9/koQi8ElRt14QKsB/XheRyGwl3RbrekiM2LdCK0LSLEEOrVM1Pdn5OMJn1F6ea30pl3VIxYnoVmnNsTL+VVoyllO5wfj7CLUocTy3w3UbuDFG3kqYE4jZbGK2uIVOKqZaaldFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=posteo.net smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jezb5M1R4S9EPSI3qudCjR3JSXde/F+quZ+bw+ThREU=;
 b=Z+BGdudKYu+BpmzIAwNWHBjiGX18XS59DtbFd/D+C+MOmpUGj1H1jA/H4M7527h9nlQAl4VSQlB3ZWuV7GK2zGimnHcuIOnyDDJjUtqJgWsmrWxfeMx9nyn0jPNtN/b2LNGocuWx+qkWnJT4EpIBMaqSWD1rLI2CQh6vbVsJKE45U94+m8RW6KLhFmMpABfvlsKVMTq1wvBONcPh1uAQRIAFkEW1eV+2IyW4PwoG4bxtEy8RvUb5YAXLQe2lcZ3APmGjQNS5ses9baBzJubXZ5qKkEfLdVlPo3qwHTD1hrOwIIqY4NylV/SBlJbOoj0aWqhu+6T0G9X8m5i9n+UDtQ==
Received: from PR3P192CA0003.EURP192.PROD.OUTLOOK.COM (2603:10a6:102:56::8) by
 DB9PR10MB6316.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:39d::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4; Thu, 5 Nov 2026 08:19:02 +0000
Received: from MI3PEPF00008497.eurprd03.prod.outlook.com
 (2603:10a6:102:56:cafe::37) by PR3P192CA0003.outlook.office365.com
 (2603:10a6:102:56::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.9 via Frontend Transport; Thu, 5
 Nov 2026 08:19:02 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.59) smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 MI3PEPF00008497.mail.protection.outlook.com (10.167.240.182) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Thu, 5 Nov 2026 08:19:01 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 5 Nov
 2026 09:19:31 +0100
Received: from [10.48.86.101] (10.48.86.101) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 5 Nov
 2026 09:19:00 +0100
Message-ID: <5feb3116-5550-4330-bb34-af2e5a1a608d@foss.st.com>
Date: Thu, 5 Nov 2026 09:18:59 +0100
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] arm64: dts: st: remove sdmmc2 pins_b from
 stm32mp25
To: Mateusz Nowicki <mateusz.nowicki@posteo.net>, Ulf Hansson
	<ulfh@kernel.org>, <linux-mmc@vger.kernel.org>
CC: Russell King <linux@armlinux.org.uk>, Linus Walleij <linusw@kernel.org>,
	Yann Gautier <yann.gautier@foss.st.com>, Maxime Coquelin
	<mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, <devicetree@vger.kernel.org>,
	<linux-stm32@st-md-mailman.stormreply.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20261104152657.14909-1-mateusz.nowicki@posteo.net>
 <20261104152657.14909-6-mateusz.nowicki@posteo.net>
Content-Language: en-US
From: Christophe KERELLO <christophe.kerello@foss.st.com>
In-Reply-To: <20261104152657.14909-6-mateusz.nowicki@posteo.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI3PEPF00008497:EE_|DB9PR10MB6316:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ddc4d33-5226-4ac3-4956-08df3b1572d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|7416014|376014|36860700016|82310400026|261022105027099003|261026140227099003|11063799006|4143699003|5023799004|261021121427099003|261102123227099003|261009223027099003|261028144727099003|261021123027099003|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	6J4/uVyPxcWKQLPlY820J9FF+cuCzidnd2yoqpp/Z83vYwbcsDHb8lpmmipBoz8YK4GFtGQEpXr/RR8wxBNdYpFUE+CYerVvNmEpZ8EXZyw2vOsYHQZ3Bl1aj02NTP1zg6/Uc5LNH2+kyDygFQVcHad8Aw2c57tIF1fyVAClbfF6TxpJECzl06+UC1p/lLvWg8UqUI9UC7M7XO3y+QWKm/4vY2ZctwVHflaqQTOjddcgppl7wKpy5kW4MOh1W2VVOYK4MrlgQebJrpCQB1oxmln4XaXte+sAKSsF7C8soPpJFUgzAl0+TmEEkoZjLcALTgbqpCTkP+XxM9lPxcBfldts0n+ddWxTkvtDl8YqHRH7Go1SCumsvuS/atcAp4fWnOjJSSltqJXgGYUH2NHp2gvgYJHr2d6FuyxRZ0NPqCx1XHuRwTEXMQdtxsESSUyei6b5FF+8vJTugVP0+GlOKFzpEFLKUfPl17IW+uveDJFVcrucRacmI9MhVxyM3Nv1VfxRwA2zVNEgAJOj9955IKvdnqjoeeEpWMZPVdZAt7vEY77K/lzXhO4X4g+kZY2KKNRZ+X+ovopcgCoSaswMyPGRcY6WDqxLcyO5QBmlzTZt4ot1K/vwPAJm8CbGRKmpBPCxUAeeHnw1NqF7KRN5vybWnnZ2ih0U9TEQauc9CcCBgTHoYHgdX+6WEAce9jqmDD2FVIFQfhuLDL03jVQGsw==
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(7416014)(376014)(36860700016)(82310400026)(261022105027099003)(261026140227099003)(11063799006)(4143699003)(5023799004)(261021121427099003)(261102123227099003)(261009223027099003)(261028144727099003)(261021123027099003)(56012099006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	vl4/Pvi4g8IvUe3WeiCQIuyJGSdkFwgUp5F6selgNmPnyJN2CAPwBQqzP81I+fvL1dA3P1QnU7aC9vTJW4QKu8Lc9Plu+jmdKw7YmtCx88vSZnTstQOenCg3gTpFOsFHxJAOfA52BR0yCD92WiMWCmNYs10Fr83iLKI1Aufk2L/bDzfiu43f0J3GuHmk8RH2LOLwpxoPFqxXEbvnpUps9ixIZ8LdV3ojzIPvSLABugbvu3uyZgXGdeUCQCb+GzCtp/WMem17X+nf2iNBMjGBTw+49bCfOA7fOcjQfBqldNldI+y36lbdPJxu4KeHlnDZ+LDUIyxu+dZOKg4uYnqV4MSA7aGCFTmIvGbx5kmDoM4WHOENuhonBzBoRyMQ3MClGXCzAsiPEbB4RAXziG73wBYnByznTIF3j/0hG5h9u68JtPSxWGnwHVYmMslhfk6z
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 08:19:01.6691
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ddc4d33-5226-4ac3-4956-08df3b1572d8
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MI3PEPF00008497.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB6316

Hello Mateusz,

On 11/4/26 16:27, Mateusz Nowicki wrote:
> The sdmmc2 pins_b groups were only added for the eMMC of the
> STM32MP257F-DK, which uses pins_a again. Nothing else references them,
> remove them.
>
> Suggested-by: Christophe Kerello<christophe.kerello@foss.st.com>
> Signed-off-by: Mateusz Nowicki<mateusz.nowicki@posteo.net>
> ---
>   arch/arm64/boot/dts/st/stm32mp25-pinctrl.dtsi | 58 -------------------
>   1 file changed, 58 deletions(-)

Reviewed-by: Christophe Kerello <christophe.kerello@foss.st.com>

Regards,
Christophe Kerello.
