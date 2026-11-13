Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.15
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794588846;
	b=HeM5U1RUfJBESu0mo3Hy75B/ktiM1+61QyUk0TTx8PPJ1RVvJfZZy4kSMhruDBI0EHuy
	 mcXCAJ5ZZr+fT8kMksz1t5fyJWdp2QhI774rnHtQn9HJ0YFk5YW2HF8JANTslWriVBEGf
	 85Q2RcsuH1CxgIRhafi6aZ2BUC2nmXlx/2OOs0CJyQkEtFRcBi7KeOBPUSv+HUNbcLL5y
	 7lzb93uf/4KcYaLO+kWL4gXSltykosAFq6HNEuya64PeGFSLJb4i6I/A2ETWRoq2sxAfp
	 10tu6/zQkQDiGQ8pmeqKLftiuc9h5D4FWuKeLPbn1D8Pp7Q7iAgwJpD7IvsZfy5Esgw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794588846;
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
	bh=mbQLA9RhCWmXcAWxbqzsBqYRPUnBHPgRA659HER5bFU=;
	b=oTwFIt3SyO8mpzXoRf12KOcxTFvLGGQr2dZnFbXGAgCgf3b7SkwIS9CZoNUbTRZcjpN1
	 FGpTzNs1FRAK4jArDrp+H8dZfgd0B0tdRaJi1O+OoaVF7+wxomYjeQUrZ+7hLE+KMx34I
	 U/AbzFnoo85PoSLCZJ9Tt+tJ/LB5v9WYJt1e79LKGmqJ9kSUAPq2Bo3Go6rfPemMntE9F
	 fXrjE3MHoZmS5FFy/5alBuU4BB3RxjuUHFk89w3pfLRznyLb6LFGTZSXt2qVFrosmEAnV
	 1Z00l8RZUv4X4PGkwqN5ar85yuaFKubGPBfMTA5o9BHDXEZI94n+ws3SXAIZcAmegPw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=foss.st.com;
	spf=pass smtp.mailfrom=foss.st.com;
	dkim=pass header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=TVP+Stmj;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.15
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010015.outbound.protection.outlook.com [52.101.69.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F81606F5C5;
	Fri, 13 Nov 2026 16:54:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A7F81606F5C5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=TVP+Stmj
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=quyeqhBU1ZVELHVUmh2Ul5oQY7D2gxBziNZXxIaJucJ2xh9Wod2T9RFcifEKjMgJrqcCVOqWRhvj2CY/SYuacwWM4Mq9NA+wxpFcxFTpU1nKntGbZbkv9rnkm2cfXlOCEdU712nRMSv27U+8yePDdGkYVmgXSe+Lw/xCNTTfgenn06x64920LN7gJvhpaSqHGTHaek77WhayB4nU6F6KdsNPj5tSTdt8agOr6wYoOevIO1+7C0X9Ij5N0UmNNMvUOcgStrc9sLqs08eVX45wNhMxM9/atHRwR/yG8bTmCtFnL7dsqHGRX/UIPWr7u55SogJGQtE87bU9Q1kLYdxsTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mbQLA9RhCWmXcAWxbqzsBqYRPUnBHPgRA659HER5bFU=;
 b=o4GNV3iE6/doAHOz6MhTXjTrbdGXT5XEqlmf6VVrVmLGaMbF/Vhp9vEPigvI+pr0jr8e881cjDLRR1/L+VrRpghEXQMKEmeTsi/EkTNWrdUIdZHHrbmS6uKwGsE+K/LEbQoGCP+qwrS2Iw/17AceLcTKlRaw8jf6+dve7+98tEbYvjqfgVzyh4mOXjQW0FCg7HwYOCNWTXSJnZ1SL2Gn6m1FZvMjkd6NclfatNRP16D4X2dpM3yYVIQQnvhvPC2pXNHRyF+qP5kOL/BUnZw4GcjyMsHHE0Sl1a/qqfZxKbhIu28yZQgeWPxBGM0oCXtPLmA5HWfYxUOVZQUvxkS39A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=oss.qualcomm.com smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mbQLA9RhCWmXcAWxbqzsBqYRPUnBHPgRA659HER5bFU=;
 b=TVP+Stmj5HP2lRUFtAZBmLGTVK6T3fXOOhJTBW1Ox66dTq8pNRN2/41rSDkfJnu/8iyz2jfv86VxCkwExNU9IE7bHxtSeUqa69B89a2UnVps8s+8GbTiT0Uw0cwGQZpephomPp5Uk/aMyxgheTT631JO1fkNeEFfdD6xWkrOv4BYIjcyZeMtvvB8fXqhVs0iunbYP3o4bTR/sB6BK1DQ/43SsIoF1gkb3oT879iWmx4Gh/TC5GJPuVnZyCHz3jAhVhpJj/57kYgcR4n6jQuD+mRx1irZ/B0/6HGn1Yjgj/KhU7oURG2ik7E/FFNNvuvEfZlQSzhDh6E9VcJqvtoNMg==
Received: from AS9PR06CA0473.eurprd06.prod.outlook.com (2603:10a6:20b:49a::25)
 by AM0PR10MB3667.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:158::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Fri, 13 Nov
 2026 16:54:01 +0000
Received: from AM2PEPF00070CF3.eurprd02.prod.outlook.com
 (2603:10a6:20b:49a:cafe::3) by AS9PR06CA0473.outlook.office365.com
 (2603:10a6:20b:49a::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.9 via Frontend Transport; Fri, 13
 Nov 2026 16:54:01 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.59) smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 AM2PEPF00070CF3.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 13 Nov 2026 16:54:00 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Fri, 13 Nov
 2026 17:54:39 +0100
Received: from [10.48.86.101] (10.48.86.101) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 13 Nov
 2026 17:53:56 +0100
Message-ID: <e996f9ab-6373-4a27-b5ae-591ba33845c5@foss.st.com>
Date: Fri, 13 Nov 2026 17:53:50 +0100
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
Subject: Re: [PATCH] mmc: mmci: stm32: handle mmc power up
To: Ulf Hansson <ulf.hansson@oss.qualcomm.com>, Marek Vasut
	<marex@nabladev.com>
CC: <linux-mmc@vger.kernel.org>, Alexandre Torgue
	<alexandre.torgue@foss.st.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Ulf Hansson <ulfh@kernel.org>, <kernel@dh-electronics.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-stm32@st-md-mailman.stormreply.com>
References: <20261030215427.488298-1-marex@nabladev.com>
 <CAPx+jO8sc8gbxNQTjK2tx+1UPLqwwEof3E9vknHNc4kmbeB7oA@mail.gmail.com>
 <51207e63-ec60-4805-bf6a-b10647ee3866@nabladev.com>
 <CAPx+jO89Z0Z241L1jyB_3sUygdEwGicqT-WfHc6ppG8egHUO2w@mail.gmail.com>
 <c3cbd7ab-e689-4a9b-b311-af43980738d2@nabladev.com>
 <CAPx+jO8=nVBUuOQ==Q66nOnH+VeXur88DetmETe8qmOiS_NCWQ@mail.gmail.com>
Content-Language: en-US
From: Christophe KERELLO <christophe.kerello@foss.st.com>
In-Reply-To: <CAPx+jO8=nVBUuOQ==Q66nOnH+VeXur88DetmETe8qmOiS_NCWQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM2PEPF00070CF3:EE_|AM0PR10MB3667:EE_
X-MS-Office365-Filtering-Correlation-Id: 8459cac2-f557-492f-cb27-08df41a6b73f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|23010399003|376014|36860700016|261021123027099003|11063799006|4143699003|261026121527099003|56012099006|5023799004|261009223027099003|261021121427099003|18002099003|22082099003|261102123227099003|10067099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	MlGW5nof5PIUMgnFmp0GQVdBvFJBFCu6tEE/nMXCv4xbQG5ci/XSPSNUHy0ON+rj9yfKRuetAwBLH++J0aWNr74z8Nk41tRfYR5Fo0OKIQGhtIZU0768ssX5TfFpZoRBg9ZvTx+QKwSIJA5ZcnExur/BdbNB+shEOZo6f4EJJrRgdHbSYoFJTYyFCOWHsK7wAPb3s6UXmtEHwtXeudVeKxMiKt2ITNNdYa6VBJZ5O0WQFzGIyYqeDt+FKrRrbgCY/ExCAFO/XY4W/6Vf9wWOGRf2jR9mKJyPmV6G5W5LQZYT3W0EbNV1GsEC6DeFZ9jAY0J6Mrgl8v7m+EtqYBHTwgJop5cTz9BcITiUzWMEbt0mWqJbGxsuUnpaZIkNptiKyTQQjlJ5mW0XpRlkUe6Mjnn/qiwIPt/fiEYQsFTimqyYndTzFAvqYMxs10f6MbV4Vs2MnCnhz5rYjFsB62noFOHRL/fGrypYZSMRLt8yoyksi8ROsYor5hIHK+2s6WDOCxIm/YlSqYderwlZPJxk1O1XIGi2oltRKicn0BxiEC/nRxlUFW2SHFTKIcdQlhcNcEiKZfE+OI0VsLvuUeAARl/eqzz7gYp6wpWOu5Mk+KsGapHe91rqu71chmgzhvVmMi7ouyqhDlrN5PHF+rZ4YoPaKA5hBM+bRf0/OLUXoe0=
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(23010399003)(376014)(36860700016)(261021123027099003)(11063799006)(4143699003)(261026121527099003)(56012099006)(5023799004)(261009223027099003)(261021121427099003)(18002099003)(22082099003)(261102123227099003)(10067099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	/N6tdmRDO3+BvlHUnhT1JBpG3baSeZoK8DhYXjgJd7GSvlS+jvG5EdDIzcD16ztc2DDTY5FWaxckJqrsmuI/f7Gy3RzaR2qoT1viRoJ+ValDxPBYzaUhSqi11OSpUt3a1jpxCGsLV8OQ6xbENM00i+lubbCA6zEPzRekpd3m52bMykdIqLCiw+AS2YevBcZ3eZhPUA++lzSXvnn6wJTdOwQ7XQxsG2WVYtpm/A26G/2SXJCjmw7WywiON599ZYUZ4mAkeat88Qqy/6CzdGfk3TqoL+0HVzmzII8oh7D6vSY/gUr+WkmOs09xbHPt5zXKzBGrAmScuD1HdjHAbCRb99GcXW0QTorF0Ck4UOYUjUbCzHOGlhBBAmiwLS7HYsLYx6iN4gceJfz3mYNEVkU0sllWPbniEGYC0Ulqj/zbWszTh2Hmnm93g7bj3vFTgy/S
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 16:54:00.3900
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8459cac2-f557-492f-cb27-08df41a6b73f
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM2PEPF00070CF3.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3667

Hello Ulf,

On 11/13/26 12:46, Ulf Hansson wrote:
> On Thu, Nov 12, 2026 at 7:26 AM Marek Vasut <marex@nabladev.com> wrote:
>> On 11/11/26 12:45 PM, Ulf Hansson wrote:
>>
>> Hello Ulf,
>>
>>>>>> -       if (ios.power_mode == MMC_POWER_OFF) {
>>>>>> +       if (ios.power_mode == MMC_POWER_OFF ||
>>>>>> +           ios.power_mode == MMC_POWER_UP) {
>>>>>>                    /* Only a reset could power-off sdmmc */
>>>>>>                    reset_control_assert(host->rst);
>>>>>>                    udelay(2);
>>>>> What exactly will this reset?
>>>> The controller.
>>> Okay, I see.
>>>
>>> In that case, this reset also makes us reset preceding updates to any
>>> other registers, for example the clock register. I would not recommend
>>> doing that here, but perhaps there is no better option.
>> Does that pose a problem in the MMC_POWER_OFF/UP state ? I agree this
>> would pose a problem in the MMC_POWER_ON state, but here the card is not ON.
> I think it is a problem, yes. If you have a closer look at what
> happens in mmci_set_ios(), I think you will agree.
>
>>> If I may I suggest an alternative solution, perhaps we can manage this
>>> in the ->runtime_resume() callback instead. If the power_mode ==
>>> MMC_POWER_OFF, perhaps do this reset there instead? Would that work?
> Can you try this?

I have sent a new patch based on your proposal:
https://lore.kernel.org/linux-mmc/20261113-fix-resume-reset-v1-1-115b3da5764d@foss.st.com/

It works fine on my side.

Hi Marek,
Could you also test it on your board to confirm that it fixes the issue 
you reported?

Regards,
Christophe Kerello.

>
>>> Anothing thing that caught my eyes was the MCI_STM32_PWR_CYC bit that
>>> gets written at MMC_POWER_OFF. This bit becomes cached in
>>> host->pwr_reg, hence it's also rewritten at MMC_POWER_ON. Is that
>>> intentional?
>> I _think_ so, this seems to be used to power cycle the card.
> Well, we are not power-cycling the card at MMC_POWER_ON, we are turning it on.
>
> Seems like we could use some support from the ST guys to understand this better.
>
> Kind regards
> Uffe

