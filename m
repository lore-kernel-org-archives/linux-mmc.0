Received: from IND01-MAX-obe.outbound.protection.outlook.com (mail-maxind01olkn2102.outbound.protection.outlook.com [40.92.102.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D48C8249E5;
	Wed, 17 Jul 2024 08:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.102.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721203305; cv=fail; b=TqK0D/E6wr4oBAoUm7BNvlF6dt2xknBgWmGjandka3+B3pBBBi7heXLBr3P2q95YdGRXbZky+/sTIgkIaH7mXXdqeO3GiJAx84CUgndZu0l/Ge19fdkMkSS/P+Q6LlAGGtqsGkcf68+zlK4X7bZyJ8Jagc54MxymwotVYJCNYN4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721203305; c=relaxed/simple;
	bh=J/yVuQaemQ+B81Ld89PuW0JmRpN7VDQH+o8cCNZnLjw=;
	h=Message-ID:Date:Subject:To:References:From:Cc:In-Reply-To:
	 Content-Type:MIME-Version; b=N776tik4ec2dZEKPd4IdXLO5jejZolUiIbtDc42VRWn+vRVdd0YW4YcJoOmpHA1nPzEgkG/71V4FrCc93/rm9J10Q4Xg4bxWzYxX4LpukKKqDM7/AgIt4SbK3qswVtaaKSjYgehcT2Aaeb+18II64x9CHNxSlpV6Z1nduVr0GRQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=CJQegKmH; arc=fail smtp.client-ip=40.92.102.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="CJQegKmH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TQtoK6CyuCeODK7rzFOMQrywkLthAv/LZM8uDf6/CWB1j74oWyo+WwOR2v2dOLkiLJRDu8GZUHASpHVqvC3tJrfLMuhX5rX1Yv9lWCHzHilqoQUWHpC5zumIrCpUTN/65j1Lp6sJ3681CyUQYfdgkpQPK7ej2MCUzuNXadwKm+R+J3iVfFNRfORc1fVZpNLLRndroC4uH5Ng6WS6sIjV6jphRJt0Egjv/dpouxVTuiwcHfhR4l7r/Sq7rijIHs1f5NiMJJzom8f9p4th701h6NUC6DLXg/IVCnXH5f6uUsb7cJqoHZ7w7ccZPFPJDrrPMts2VRSjhSf1vUb5z2IBBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lcAvOZ5KykyLXTcVGYP3iEsMppJhskQ77dqNrKmtY/s=;
 b=A7ZcLUhCNF3/wzp4lTgEqk/BIYR+5X7kimWbRmyfCSJs9cmgK1rPHxO4Vr9olrwxqYNei07LoCkrQ0zx3FVlGx1gUUCpYZlT3vcXBVcm9E6tHp0aNArVLG9sCW4ymR+69vBkiGrQ2x3Rkpi2Wa1FPTZFX+b5RGjjctY6vgsSEtYdBPBS7gr8lVcFWulJPRmj0eXTyxhoxr4ASc+ELaym+B51MFkelG0Xz8QSFno+xlKge36FcEuuO2p+VZ75QtOgrNOk3A7UVoJnGDQddzU2M1FelSss7hqwQ6MxkETQckK0pAXBPHA11w4mRUHJlbDGK6kgqH5b5/nSQjNYyR5DgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lcAvOZ5KykyLXTcVGYP3iEsMppJhskQ77dqNrKmtY/s=;
 b=CJQegKmHWSeQPOB5oj+cy1cGsorQkiYF3/gK3Yq1qg9UpkbHgCYw7AIKKbjZSZD1ATKfNzqAe58svwoIhRHLwLj5wmDbWOf6dasFE3RIFo8aK9S7U7qgd/dssVrevKDkF2bhvu3K0JKUCkMO0Xi0XIsNs+TnKNGuwc+lj4gPlE1Mowke2MKhreRDqCLkAR3aO9OuRMi/dUzcknuoxwBKeH6N4g27oVWS4QIYMYtDxEfI/sS1jTJkgfoh7D0fFGj4eV72R4vNOesB5hIkx8xdVbNDuyDNKRQh1rzpz6X8nSALAi8807nNY9pBblHOdZ+sqYuAuQGhW5AhTkZ6Ca/Biw==
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:138::5)
 by PN0P287MB0591.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:161::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Wed, 17 Jul
 2024 08:01:33 +0000
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::a94:ad0a:9071:806c]) by MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::a94:ad0a:9071:806c%6]) with mapi id 15.20.7784.016; Wed, 17 Jul 2024
 08:01:32 +0000
Message-ID:
 <MA0P287MB2822C4FB66C0CD31BED2E3B8FEA32@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
Date: Wed, 17 Jul 2024 16:01:25 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/4] dt-bindings: mmc: sdhci-of-dwcmhsc: Add Sophgo
 SG2042 support
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <cover.1718697954.git.unicorn_wang@outlook.com>
 <dcc060c3ada7a56eda02b586c16c47f0a0905c61.1718697954.git.unicorn_wang@outlook.com>
 <6e5ad808-f4ee-45c3-a1cc-009f2f1010b9@linaro.org>
From: Chen Wang <unicorn_wang@outlook.com>
Cc: Chen Wang <unicornxw@gmail.com>, adrian.hunter@intel.com,
 aou@eecs.berkeley.edu, conor+dt@kernel.org, guoren@kernel.org,
 inochiama@outlook.com, jszhang@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, palmer@dabbelt.com,
 paul.walmsley@sifive.com, robh@kernel.org, ulf.hansson@linaro.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mmc@vger.kernel.org, linux-riscv@lists.infradead.org,
 chao.wei@sophgo.com, haijiao.liu@sophgo.com, xiaoguang.xing@sophgo.com,
 tingzhu.wang@sophgo.com
In-Reply-To: <6e5ad808-f4ee-45c3-a1cc-009f2f1010b9@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TMN: [nqNLfbJsekHi2+9ZrmilL7fL0dHLrvd4]
X-ClientProxiedBy: SG2PR01CA0166.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::22) To MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:138::5)
X-Microsoft-Original-Message-ID:
 <ad173e81-6485-4c40-98e6-93d9787ddfb8@outlook.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA0P287MB2822:EE_|PN0P287MB0591:EE_
X-MS-Office365-Filtering-Correlation-Id: f72fe459-1193-460a-4231-08dca636ab8e
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799003|8060799006|461199028|1602099012|440099028|3412199025|4302099013;
X-Microsoft-Antispam-Message-Info:
	bIfhdjntK3d7ZhpyTG0AY8csJADn5x34EDGIKAyBtvzsDCggKh3KER1bR65aiuIp4Bwg5P2Xr2eTZWdWVSVvoOmmlHdx1uS5BJ7bjmBvVE8ptpVsAYViMmPbcMnDQlezVd7P3E0ILrJxu9WbuU99S6LJZjH/hW4iV528joFK/Sdxd+8TJGC7LveTrqZAxKFfCGAMdTMemvYli5A7JidRDQuAmB2bGaUGjNEUFSwzt3roclQGx38cW0ENZLtd9Quwc/AiGMNbEKlXu/IymCuNb3CpVUufCVIrk3W2MeHRkU3f6bvYtkObLWKHl0iKq/kF1fYwnYVPdmQpzuPtUZDC9XXaY0D9p+j28lkNvgZDZI2mpn5iYWXWvz8L7oBsZrOpGYDVBhVWp1MFifCWOJBHGvMgoLTMevfcOc6hwkJX1LKZPGxGg2//yDKhySoCiuKO0NYKiRl7O5tX1Z8e/lefkxVt/alExMz2oRd12EydSjTeKY83L/X4RM5GWUK9C/4ZTPXVcpP2nC3fcO3tY1z00Qvx0NSUo5RWYJosLPWyo9QQH9HU9B3mwj6QFVpDvKaz9Rbr+F5rmdSKJYXrIjxxuooKfxk4FfSvmJnOObzuddUG8fv5xGoHV8kkxNgBYNTBGJNqi02XhF3kCSl/9Bx9e7RoTQ6eSFT4yduCVczS+zNNVvARmDylcMuhAOkG4nneV4sNgT7KnB5LjFcQM/sKR8dk2ZqM0Q1hmngsALGUn7GtAfpm7jyBjEgBF6WoSIal
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UnNZQlhaVU4xNTN4MUFiNWRZYm83TEEwYXFab0pzNEdscWkyOXdGWEF2TFpR?=
 =?utf-8?B?TlRjUjB5VkZhRkVXbmN6Qis4bkUrUFQvQUR5Qkowa2dNOE9ZNWp2S2lCamtI?=
 =?utf-8?B?N25uU05OQmNwMVBaNTRLMWtkVm05bmRWM1JXbmFiSzFBdVV5UU05Z1dLTW1o?=
 =?utf-8?B?L0FTekJoU0xqbW5HUFRjK2VMSjYzWG16eHdNbER1RTlHVnNNaXI3Q3QyVEM5?=
 =?utf-8?B?bWVWZjlkVDNVTTJqVXJPRjRxV2EvTTZacTF5Y29tckZVdjJmSlNkcEEwaDc0?=
 =?utf-8?B?Z2IybWNEdG8rdGpyUWVjZ20xVDJSTzI0Y2NRWjI3eS9XUWtqRlpKRlJiblBM?=
 =?utf-8?B?b1cvZGg4bDJQa1o3dTA2MzdUY1hlTWttMlpyTWZVRGJVNHVHVVE2U2FZSjVZ?=
 =?utf-8?B?YXRGeVFYNzYycVFTd2VsTm9uRTJnVFpQY2hQRWNhNGJOVFo2SmFxc0ZTSllV?=
 =?utf-8?B?QXI3QU9CMy9NUWl1UVFqRlo0T3pwSEZNRE5hUjMvUUx2bktCVHkvYjkzcmND?=
 =?utf-8?B?OFUwWmlHSll6SXhLOWU1ZXh6Q0JTbWVJTm5jc1RzM1FZbnl0TFlXZ1AzRHFF?=
 =?utf-8?B?K1V5bElTcllwNjl1RWtQN2krbVNwcUYvZ3JKMXQxakNFcjRXNXozQnRucm9y?=
 =?utf-8?B?MVpCMlZ4SHdrc2RuL0Z6aUlnYWNudnBJYzRZNDAwZ2QxRk1kRVJZa3lkUjly?=
 =?utf-8?B?bGhFdW5FWGUwNTAxT0JuTXFuUFBubmxwdlZYMGIxeEszMGtZZm42Z3FxREE3?=
 =?utf-8?B?YVdEak1EbGo3WE43SkVPZ0ZWSS9TdEU1WmJUa0VCaDhIRE01Y0djUWlKVHpX?=
 =?utf-8?B?TXdsd3BJODgrdG1VcC9ZdEl1K1k2WStlSi9sSDh1b1lkY2pEREFDM1pnVWhr?=
 =?utf-8?B?SU10SS91c3FSemhnRERVSDlqMGk2NGkxdkM3OWNselpPK0ExZkdGZzhpRU9T?=
 =?utf-8?B?em9yVXpSTEg1R1RrY0tBYlEyMFdiNWkyMUMzUm51bVdkTEV0bXc0cnlYZUVT?=
 =?utf-8?B?bFltQW03SUM2ZkVDTTFtaVhmRldpVWo1dSsyUG5VRlhFQ2JLZ1lrWkRrbWtp?=
 =?utf-8?B?Q1pPdVNrMmlHVlZ3MVh0enk2bkFFc1hRQkppSk1qb24xYzY5T202bncvZU8x?=
 =?utf-8?B?NlRyY25GMXdUNTIvNmVXcWkyamdpVzZsU0orVGk3WVEzUVcyTms1YlhPdXU5?=
 =?utf-8?B?eSt6bGRQVXljd1IweEJndHoxem8rRXVHeWJMdVRuRmJKeW9ZNDk4b1lldlo5?=
 =?utf-8?B?NDNjdktUM1JYSW9GRi9YWS9aUlJqZ1pKS2tmZHUyeHdzMUVteFU4MzJuL0pi?=
 =?utf-8?B?dUtmRnFBUzRmZWZsZXp5aTA5NDIvdVpGdDMyOFc4T0hUL0ZicGpRU0lLVHky?=
 =?utf-8?B?T2xPWnIzZ1B2QkdMQmlmREJ5VHZIcTlrMlo0bFF6bnNvTHdTVWJmK08zQURh?=
 =?utf-8?B?Q3U1Wlk3ZzZySnVrQjZ5YUtDZEhtSi9RWmU4Y3FhcVUvVVNrWkhjSVpUSVMw?=
 =?utf-8?B?S1BHdjBmRENzNzNjSllpOWZkcnVNNkNRZHZKc1pRZ1ZvR1FUc2M2d29uNnl2?=
 =?utf-8?B?dzYxUGg0M0Njc3dyRUliSUVhdWQvUzQyblBHOTE4SnJLcFhqcEsyMGRERys5?=
 =?utf-8?B?b0hxb1VPR0NBbWg3VW9WcGk1eTNDMFVsemJ2NEl4WXFZeWVuczFDMzNsbVNz?=
 =?utf-8?Q?mxEAuiam4gW/nr7O9Oof?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f72fe459-1193-460a-4231-08dca636ab8e
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2024 08:01:31.8478
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0P287MB0591


On 2024/6/18 17:39, Krzysztof Kozlowski wrote:
> On 18/06/2024 10:38, Chen Wang wrote:
>> From: Chen Wang <unicorn_wang@outlook.com>
>>
>> SG2042 use Synopsys dwcnshc IP for SD/eMMC controllers.
>>
>> SG2042 defines 3 clocks for SD/eMMC controllers.
>> - AXI_EMMC/AXI_SD for aclk/hclk(Bus interface clocks in DWC_mshc)
>>    and blck(Core Base Clock in DWC_mshc), these 3 clocks share one
>>    source, so reuse existing "core".
>> - 100K_EMMC/100K_SD for cqetmclk(Timer clocks in DWC_mshc), so reuse
>>    existing "timer" which was added for rockchip specified.
>> - EMMC_100M/SD_100M for cclk(Card clocks in DWC_mshc), add new "card".
>>
>> Adding example for sg2042.
>>
>> Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
>> ---
>>   .../bindings/mmc/snps,dwcmshc-sdhci.yaml      | 69 +++++++++++++------
>>   1 file changed, 49 insertions(+), 20 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml b/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
>> index 4d3031d9965f..b53f20733f79 100644
>> --- a/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
>> +++ b/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
>> @@ -21,6 +21,7 @@ properties:
>>         - snps,dwcmshc-sdhci
>>         - sophgo,cv1800b-dwcmshc
>>         - sophgo,sg2002-dwcmshc
>> +      - sophgo,sg2042-dwcmshc
>>         - thead,th1520-dwcmshc
>>   
>>     reg:
>> @@ -29,25 +30,6 @@ properties:
>>     interrupts:
>>       maxItems: 1
>>   
>> -  clocks:
> Widest constraints stay here.
>
>> -    minItems: 1
>> -    items:
>> -      - description: core clock
>> -      - description: bus clock for optional
>> -      - description: axi clock for rockchip specified
>> -      - description: block clock for rockchip specified
>> -      - description: timer clock for rockchip specified
>> -
>> -
>> -  clock-names:
>> -    minItems: 1
> Widest constraints stay here.

hi, Krzysztof,

Please ask you a question about this widest constraints, I write 
bindings as below:

```yaml

properties:

......

   clocks:
     minItems: 1

   clock-names:
     minItems: 1
......

allOf:
   - $ref: mmc-controller.yaml#

   - if:
       properties:
         compatible:
           contains:
             const: sophgo,sg2042-dwcmshc

     then:
       properties:
         clocks:
           minItems: 1
           items:
             - description: core clock
             - description: bus clock
             - description: timer
         clock-names:
           minItems: 1
           items:
             - const: core
             - const: bus
             - const: timer
     else:
       properties:
         clocks:
           minItems: 1
           items:
             - description: core clock
             - description: bus clock for optional
             - description: axi clock for rockchip specified
             - description: block clock for rockchip specified
             - description: timer clock for rockchip specified
         clock-names:
           minItems: 1
           items:
             - const: core
             - const: bus
             - const: axi
             - const: block
             - const: timer

```

and with DTS as below:

```dts

sd: mmc@704002b000 {
             compatible = "sophgo,sg2042-dwcmshc";
             reg = <0x70 0x4002b000 0x0 0x1000>;
             interrupt-parent = <&intc>;
             interrupts = <136 IRQ_TYPE_LEVEL_HIGH>;
             clocks = <&clkgen GATE_CLK_SD_100M>,
                  <&clkgen GATE_CLK_AXI_SD>,
                  <&clkgen GATE_CLK_100K_SD>;
             clock-names = "core",
                       "bus",
                       "timer";
             status = "disabled";
         };

```

dtb check will report error:

```

.../arch/riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dtb: mmc@704002b000: 
clocks: [[84, 38], [84, 64], [84, 76]] is too long
     from schema $id: 
http://devicetree.org/schemas/mmc/snps,dwcmshc-sdhci.yaml#
.../arch/riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dtb: mmc@704002b000: 
clock-names: ['core', 'bus', 'timer'] is too long
     from schema $id: 
http://devicetree.org/schemas/mmc/snps,dwcmshc-sdhci.yaml#
```

After I removed the widest constraints from the binding file, dtb check 
passes.

Not sure if my understanding is wrong. Do you know what's the problem 
here? Seems the widest constraints is not needed,

Thanks,

Chen


[......]

