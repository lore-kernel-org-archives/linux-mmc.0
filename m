Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01olkn2093.outbound.protection.outlook.com [40.92.103.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EFFB368;
	Tue, 18 Jun 2024 00:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.103.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718669538; cv=fail; b=PkCrDiPbmhpzLkQlcJCnki/iEXQMaBoaMRYqg+wLabAmemNfSaRYl8nkhtBQiS8muAx/sP4pPYJ+rNPQeQ6wOVjpBC6adSc1eYG+Y3TaSWr7KuN8TkymNmuKnYkgr9EebSBJOIjZc5GwyUvY7/2G9xv1Bp5r54Orlaw8EFZEnj0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718669538; c=relaxed/simple;
	bh=14F6T41//hBiSYJsPmKaV6VjTvC7OH3e7MQA276xD+Q=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MjaKtZkIB8p55pDzhF55Zk6Wj6q9cCgQTM+ASpt5/xwGleAW2F+2oz//2TEY0H/wXh+qQQjt5ZeiHCoHOLwwWeacBp0omC580xczaU0SGteWqguPW73op/13TKmNpqzioWhRmOOPJECPE9IuzXKUNgAznhMh4ZiW+n0gpwljNf4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=mjj2Di6J; arc=fail smtp.client-ip=40.92.103.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="mjj2Di6J"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ChGebS2KqzvZaUJ3P4kVuL5FT/BGR+0OArVSoONRhwQjpQBygHbv2lSOX7vAKq94LiniKs38sZKMqMy6d8cXfYIBHLNl+7ucr02LWbM/jAMz4fQksqtNFqOeV6RRY+DFhg1M4surAZO4RKaWHLEA6zAFxyzBkWzJ1SY9e/JY29Jy1ndMukRi1JWz3AaTrfRfIpq9NxTouf8bDcP01F79y8BpqgSP7HOl2PDM9mh2Na2brxvp8QkYAEIBdWJsA3MHsbeoDK/Y/Jx5ka9CXN2wmwxbFAwOB+mu5ro9m6CEJN7v3FXxQO+4axyNSq6Bky0LXVMjQzUDu79kH3/LsSh1ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KfYPs1kwS5b3AXJOYq2Pm0Zsuxt9JTxBidFj7djxErA=;
 b=OAr+4tVtUaE4qHqmo8KGGt8BEAwtMGLGDeyioDOGV2TeSEpEolB7axEtsjEzJUrarOBf+c4OaZZQkrOd5lEBY1Zm2Ugo9CY29KZ8ZP0SffhCnM9uDA35INjZQL6250LyX2eVzbeI1F360oUPEdsFLFkUxyH+uP5JH7FQxOZZGBG9JyjYvfn9W7eAC8Un7NKUiZbWqmxe1v61lOxL7a/tjF8TH/iI+RLI5UEA6wn3HhFm6aWIagduN8+ctUlMHWK6+XvZR1kvMayMFSTdrWlihb6UqiasnS+lpACcTc3dwS9A+7NSau9likYwJ4azJQzDrxS93sNUaQS1v3nlnPSbmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KfYPs1kwS5b3AXJOYq2Pm0Zsuxt9JTxBidFj7djxErA=;
 b=mjj2Di6JJFGgCdFgUOZMeWXSVCJHxVx0mS9chBJa3WzgjWzPz3eMlW6H+nTVESe/06uiyWECKv5jStIGbbGT9H8eVSlx//0qTONr8XpPdfyiwt6QLmGgGI+Tuexe7KlTC8G16Io7O2yF45cnCVDJwnffXIDekyh8/Mh4vGLAQioGvvR3JZhCf0H2qRmbC6Qs5zVToISDair/9KPL7LibWg4eIauIDz10U26U3fMR1Yv6PBwcBwhGSJ6g/lzFqfFJdC0K6z+OqNsHQmMi/rVeBb+3KoeveJJA7Glyzngn8xAByG1i+H2bsj4YXMPeAl0v8ROZETELIDskAA3LaJt/LA==
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:138::5)
 by MA0P287MB1497.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:f3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Tue, 18 Jun
 2024 00:12:08 +0000
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::a94:ad0a:9071:806c]) by MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::a94:ad0a:9071:806c%3]) with mapi id 15.20.7677.030; Tue, 18 Jun 2024
 00:12:08 +0000
Message-ID:
 <MA0P287MB2822DCBF6E0AFC2146E05621FECE2@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
Date: Tue, 18 Jun 2024 08:12:03 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/4] mmc: sdhci-of-dwcmshc: enhance framework
To: Drew Fustini <dfustini@tenstorrent.com>, Chen Wang <unicornxw@gmail.com>
Cc: adrian.hunter@intel.com, aou@eecs.berkeley.edu, conor+dt@kernel.org,
 guoren@kernel.org, inochiama@outlook.com, jszhang@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, palmer@dabbelt.com,
 paul.walmsley@sifive.com, robh@kernel.org, ulf.hansson@linaro.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mmc@vger.kernel.org, linux-riscv@lists.infradead.org,
 chao.wei@sophgo.com, haijiao.liu@sophgo.com, xiaoguang.xing@sophgo.com,
 tingzhu.wang@sophgo.com
References: <cover.1718241495.git.unicorn_wang@outlook.com>
 <Zm5OYfzMSv6hnCdL@x1>
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <Zm5OYfzMSv6hnCdL@x1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN: [acJsLYoxQqlPLR0DycVh2uIVt6Fc2fMR]
X-ClientProxiedBy: SG2PR01CA0151.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::31) To MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:138::5)
X-Microsoft-Original-Message-ID:
 <faf58cd2-06b0-41c5-ab9b-2c8022315e67@outlook.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA0P287MB2822:EE_|MA0P287MB1497:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b3626f9-3c46-4900-d48c-08dc8f2b4ad6
X-Microsoft-Antispam: BCL:0;ARA:14566002|461199025|3412199022|440099025;
X-Microsoft-Antispam-Message-Info:
	SdTyY6sWbkHlyTcT3sUtX1lrPXQX2qSAiGnfK3xZClp/GX0wH/Rs7SwXfEniQMURQazyoj3kmxCSXEU/JzoObwGeqozMeDBjMin1mfzCLo5GE9yzqGxrWPm5lglI1WhiaeV3ikKkTmd5kIfnQJktrIi04BJnzXfcMovhwRijISTVgm6u8Q4I3Qpc19r9CyhiKD0Pb9ZjrUzTFNYSD5F8xAQ0L9PGIev+I2m5KUzjVD130XsTCKa4JssYbFKWrrJqvi37Ve8p+pDHr20X/TGGuK+wkL5tgO8Bp2GSzfeJ3jGa3SBV6QsvZAlJbTaKXPcJ6mjxr7djkjUYPv+0+uy0jmsA49BN8LYsLs6dPUcIbof/5yQFYuJJ55T9dZw0JqcGAvutd7Z0DcuGaO5TS+3KMietkqWbowJlNOmSAUr85l0f09rr/7TvXgXLT0My3IleqfdFQM2+eIRqGUYzRZ2kw/Bs6EtU6EfTvtBpaKXTvXtKw7pI8sVECcbBV15oxErt+AtoAdQZt1xf/6ThbMJNX0hYav11qJeD6/+5pbi28SFwH+qQLZCSkDA6s94qRFe6
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T3hoU0gvRkVyVGorL2FrV2QzdFI0YzJkNUVkNmRZZ09DKzlQUzZaYkdsQnND?=
 =?utf-8?B?VDlITm8wbUphU0ZsZmVDT2hOQ0U2Z1k3MXVONDhua0pJaEdoVlN6MjQvZjR5?=
 =?utf-8?B?WVNFVTBubGw4cDFoOVRpTVRQbmx1cHQzaTl0SktjNG8zMFF5dXV1YVJqcEhx?=
 =?utf-8?B?anJWcHlmMG55aWlPS1RIbWMzdlQ0UnJBMU12aWJLbjNZSVd1UXBoMHhxWlNz?=
 =?utf-8?B?aFQrdldHdWh1K09nNlRMMXVHZ1MzbU82ZmZOcjNWU0NEdW4yUEhvYlRCeTZX?=
 =?utf-8?B?eENnL2l4enpMWlFJOTVHUHhrWUQ2azhBVGdDWXgwTVpZMkhZQzN3QzBUakpM?=
 =?utf-8?B?dlpSWUlkZGYyd1BXN1htV21wSk0yNjFZVnY1Mmd0cGxqb0d5bkswaEdGa2Ew?=
 =?utf-8?B?elpxWHI4VkY1UGZyUkhjYUlDSlpKZExVR2RmenUxdDRDemQ2T2tCQW4vaDg3?=
 =?utf-8?B?aE5UcThZZlgweWJLUG9pb2daRHlWUlhWMWZjYjhZdXkxMURtR0QzckMzbEI4?=
 =?utf-8?B?amRsT3VDLy81cVBHVXgyM04weVk0ZFI5SGd5SUwvcmtiRmJic2xaZjVEc0Fo?=
 =?utf-8?B?WUE3ODdEZ1ROdHJpT2o3RmtGd0pMNndlR2EyQmZBaFI3M0lKRS8zV0w1MmEw?=
 =?utf-8?B?eTY0OFRsd1Y0dzkzY3R1alpOeVFvd3NBUjZqUjBYdW9EL2hOWXg4WnF1Y29E?=
 =?utf-8?B?WldVaTArS2hWaDJEamFFd0lXY0dHUnVUOVg5TjNhaE1ya2lMMkx6Y216d3R1?=
 =?utf-8?B?ZWZoaVp2QVlWakVNZS9FV2VZUnB5Rk8wcFJUUzQrRXNZTGpncWprUFhMa1dL?=
 =?utf-8?B?MENWem8yQzcxQ0FndEJLSjFWWHVtZSs3cU5xL1FFYW9MVnlTTllCRXdRYzMr?=
 =?utf-8?B?QlJlS3p0emNkT0ZicnczeEZLK2FBc1hjdkxTMlpHd241eGJhdWFzN0N5bmFq?=
 =?utf-8?B?RDFjbnNlb0MrUGhzRmlvR3loL1czUk12ZDRTM3JySUFVNzlLblEyODNyczdU?=
 =?utf-8?B?MWRlalZnbnBIcHBONXNIalpEVDJudlkrbzJwNXJSS2tQUU1aTEROVEE3cHJG?=
 =?utf-8?B?eElmdkhWK3p1T3AzWDZhVlRwOXdRZVV6YWpiWmRwc2YxYnFGYVBlZXJwWmdz?=
 =?utf-8?B?ejFWOTRUaHV2R2hIdExDMnNVaXRjcGlZK3o2QURpeS9tNTM0NU51SW9CYTd3?=
 =?utf-8?B?a1BqaW9oVERFRkNhdDBGY1A2R20wZkIxdUJJUWtVbEFCczkvQ0toZjJJT3Zn?=
 =?utf-8?B?YTVicjVpdTU5cjlrU1V3ODNseW13aWcwZXNOTUJEaTFLZm1jTUpCcmRXb3Uy?=
 =?utf-8?B?N2ZDYnIxNHliazlVRzJFdi82Vll2KzI4a2tkaWkzREZ0a2xoMEswa1BQRlpI?=
 =?utf-8?B?VlMwNnpsZituaWxwMUZVVWZkaVBKU0gzZ3NNYTdIdWpRT0grY29LZ0VPM2Rj?=
 =?utf-8?B?YXhnWlBmeXNCbmdCNDlPZnpNUFFqRGRPMmNjeDg2TEZ0clZqVmNqNmZlTzBZ?=
 =?utf-8?B?QkgxSjhFY2M4THVLUDUrSGRWQ0VqRlFoOTVGMGdQSW9SV2lKa3gxemIrUXpa?=
 =?utf-8?B?b3JudDMwRG1pMkM5enBLM2tZeXpPWXVrald4Mkhnd0h1SE1kbFVHZ0JTZXNK?=
 =?utf-8?B?ZDJsT2swWklpNFQyck9rekdvbHhZNzlSOFpGVWJ3QzlqVTgyamhyVHVNS2pK?=
 =?utf-8?Q?U5N6Nl7RIGdO61K8Fjuk?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b3626f9-3c46-4900-d48c-08dc8f2b4ad6
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 00:12:08.3023
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0P287MB1497


On 2024/6/16 10:30, Drew Fustini wrote:
> On Thu, Jun 13, 2024 at 09:42:03AM +0800, Chen Wang wrote:
[......]
> I have tested successfully on top of 6.10-rc3 with the Lichee Pi 4a:
>
> Tested-by: Drew Fustini <dfustini@tenstorrent.com> # TH1520

Thank you for your testing effort. I will continue to revise it 
according to other reviewers' suggestions.

Regards,

Chen

