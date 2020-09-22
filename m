Return-Path: <SRS0=6BIs=C7=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88460C4363D
	for <linux-mmc@archiver.kernel.org>; Tue, 22 Sep 2020 07:00:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA8E823A1D
	for <linux-mmc@archiver.kernel.org>; Tue, 22 Sep 2020 07:00:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="pEwuWZ3q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729595AbgIVHAg (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 22 Sep 2020 03:00:36 -0400
Received: from mail-dm6nam10on2077.outbound.protection.outlook.com ([40.107.93.77]:27105
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729168AbgIVHAf (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 22 Sep 2020 03:00:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lor0jeeuCpTMGqKoD/jsFkBJ7G4MqfKqAHvODnfBCZiFEbGiQiGvOI1nJR9Nue4rc6h9RoJ44wDAzo8OLpglnOqK1QLpGh39Gwu1SFmvQ5H3W7nsU69/uTD79rKezh81PVGauFm1Fqmxj/P0FVsrXHzZdSv5Njxt3LSDw/H9dukF7AI6K/Z0Ms328/c9L3PUCgnW8ZN+DQHlTmaMr915tzodxPmXi1RKM/L7sQPQDymhjsKQMphwUBTccTzRWFVK3pIeYx1MQU9Hq27be0jaEb7Uu0Fq/PJ9kxJ4sa2shMLXHNo+02wVksVjR10Eie8ysit1BtYsiCtDyn6fjRmzYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O5EX2x9Buw+QaaMN5JkA/EcUtsKbhMT8alU8lNMWmWM=;
 b=FU0b4INsgxxn26mKrPvTd40cM+9MdzeNZvDtU3/H+B6ZEw7HnqPqqn6rbjU1RjUVJpm44DOP0S9JlXt4yM265n42aa+nlAnQk1SEoxPnllgrvAa+I2Ny0Ke84/3MgtaAsG5Cmc8KNWie063MvU/q0HS5tnqBXLIZXlY7YI1l612JRqBbytbxeA1BmlVNbLu/1TxQDrxRZxxg0SuprCYUAcePCQMNGsLDXoNQUBt1V8UU0VUTAwSUTwIANzFzctE69lEK2JPTTJ5jmhApcuUE1h+nJzacbZowZB8zyqyNwd6FKvjsm0NSAzcZPmbHSE9JeRGtFQPsovACU9O0kC9Ubw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=intel.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O5EX2x9Buw+QaaMN5JkA/EcUtsKbhMT8alU8lNMWmWM=;
 b=pEwuWZ3qhGjgVynIR1QNkeBSnCmsS2EDl8KY2wn5RcWHzTNAnwqme3SwqaHN9umYkrkE7H9wOGkeXkz7DjD/lmRThrUr/dYUvRvc/6s65MSAFaRlYyuE+EVZXuFaDbDzWrKzn0PpN+jno0N108udZ8t0A51PVBTw3qMcGI4/yS0=
Received: from DM6PR03CA0056.namprd03.prod.outlook.com (2603:10b6:5:100::33)
 by BYAPR02MB4695.namprd02.prod.outlook.com (2603:10b6:a03:52::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.19; Tue, 22 Sep
 2020 07:00:31 +0000
Received: from CY1NAM02FT014.eop-nam02.prod.protection.outlook.com
 (2603:10b6:5:100:cafe::a2) by DM6PR03CA0056.outlook.office365.com
 (2603:10b6:5:100::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.14 via Frontend
 Transport; Tue, 22 Sep 2020 07:00:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT014.mail.protection.outlook.com (10.152.75.142) with Microsoft SMTP
 Server id 15.20.3391.15 via Frontend Transport; Tue, 22 Sep 2020 07:00:30
 +0000
Received: from [149.199.38.66] (port=45670 helo=smtp.xilinx.com)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1kKcHg-000277-Ku; Tue, 22 Sep 2020 00:00:16 -0700
Received: from [127.0.0.1] (helo=localhost)
        by smtp.xilinx.com with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1kKcHu-0007Hy-Hb; Tue, 22 Sep 2020 00:00:30 -0700
Received: from [172.30.17.109]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1kKcHq-00077Y-9c; Tue, 22 Sep 2020 00:00:26 -0700
Subject: Re: [PATCH v1 1/1] mmc: sdhci-of-arasan: Enable UHS-1 support for
 Keem Bay SOC
To:     "Zulkifli, Muhammad Husaini" <muhammad.husaini.zulkifli@intel.com>,
        Michal Simek <michal.simek@xilinx.com>,
        "Hunter, Adrian" <adrian.hunter@intel.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     "Raja Subramanian, Lakshmi Bai" 
        <lakshmi.bai.raja.subramanian@intel.com>,
        "Wan Mohamad, Wan Ahmad Zainie" 
        <wan.ahmad.zainie.wan.mohamad@intel.com>
References: <20200914051214.13918-1-muhammad.husaini.zulkifli@intel.com>
 <20200914051214.13918-2-muhammad.husaini.zulkifli@intel.com>
 <21d34b75-5947-e115-7c9a-6d068375bbdd@xilinx.com>
 <BYAPR11MB3015FF6503F4FBB4A184FA57B8230@BYAPR11MB3015.namprd11.prod.outlook.com>
 <452d5580-a1d6-c509-2760-80bde1f84ef9@xilinx.com>
 <BYAPR11MB3015BD6F223ADB5C45C1435CB83B0@BYAPR11MB3015.namprd11.prod.outlook.com>
From:   Michal Simek <michal.simek@xilinx.com>
Autocrypt: addr=michals@xilinx.com; keydata=
 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
 0Z1MQlmNcq2bhOMzTxuXX2NDzUZs4aqEyZQ=
Message-ID: <6b1c9c71-ca10-47b0-895c-adafc6881063@xilinx.com>
Date:   Tue, 22 Sep 2020 09:00:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <BYAPR11MB3015BD6F223ADB5C45C1435CB83B0@BYAPR11MB3015.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4dd74549-4164-4a44-fcb8-08d85ec531cc
X-MS-TrafficTypeDiagnostic: BYAPR02MB4695:
X-Microsoft-Antispam-PRVS: <BYAPR02MB4695FCD21DF2E4CD038F109BC63B0@BYAPR02MB4695.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LdrDGiK5Cg4N/73Xn9ZxVPYfQL0PsN8ApuefiZhJCJMLuayd2yGoUjBjbC7Sbv72DLQ5pkssYlw7FvRruKEDIJR0XjSSTu75EQUSJXRS4avUmDzYT29xsISmcC/QAo7P5WQo/FOiEzS/YWUI5Ug0QwHyXVlh5OD9FLP042w+OHlF0nR+/DoLDT5Op0Z4/JK1Hlnbj/diwA2qrKAcTmYWOVGFliUy15qPWoksgZx1bbCLTvFCZhlulcGPLiRUgn40UCb9gA5YP2HwZO78cCZTEnxp4m/CTdjXlsh3r2wXUKsxBrhMmYu1An8N2v6Rfr4MNR+T3DQPpGfVNEJ9PnLVmPAhdQujPwmlfmtj9XvugiVSjRf7RwrFNKjyB2Gmy0sZHo7FbCmgayUmezedkjKnRZzeCxUudtH5NDEIKGiw6MgSDclVvMtnGiy/rM9B3Wkn
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFS:(376002)(39860400002)(346002)(136003)(396003)(46966005)(6666004)(53546011)(8936002)(9786002)(5660300002)(4326008)(316002)(44832011)(81166007)(8676002)(356005)(26005)(110136005)(83380400001)(54906003)(70586007)(70206006)(31696002)(31686004)(36756003)(186003)(82740400003)(47076004)(2616005)(478600001)(82310400003)(336012)(2906002)(426003)(921003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2020 07:00:30.9771
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dd74549-4164-4a44-fcb8-08d85ec531cc
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: CY1NAM02FT014.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4695
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi,

On 22. 09. 20 2:47, Zulkifli, Muhammad Husaini wrote:
> 
> -----Original Message-----
> From: Michal Simek <michal.simek@xilinx.com> 
> Sent: Monday, September 14, 2020 9:40 PM
> To: Zulkifli, Muhammad Husaini <muhammad.husaini.zulkifli@intel.com>; Michal Simek <michal.simek@xilinx.com>; Hunter, Adrian <adrian.hunter@intel.com>; ulf.hansson@linaro.org; linux-mmc@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org; Arnd Bergmann <arnd@arndb.de>
> Cc: Raja Subramanian, Lakshmi Bai <lakshmi.bai.raja.subramanian@intel.com>; Wan Mohamad, Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>
> Subject: Re: [PATCH v1 1/1] mmc: sdhci-of-arasan: Enable UHS-1 support for Keem Bay SOC
> 
> Hi,
> 
> On 14. 09. 20 15:26, Zulkifli, Muhammad Husaini wrote:
>> HI Michal,
>>
>> Thanks for the comments.
>> I replied inline
>>
>> -----Original Message-----
>> From: Michal Simek <michal.simek@xilinx.com>
>> Sent: Monday, September 14, 2020 2:46 PM
>> To: Zulkifli, Muhammad Husaini <muhammad.husaini.zulkifli@intel.com>; 
>> Hunter, Adrian <adrian.hunter@intel.com>; michal.simek@xilinx.com; 
>> ulf.hansson@linaro.org; linux-mmc@vger.kernel.org; 
>> linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org; 
>> Arnd Bergmann <arnd@arndb.de>
>> Cc: Raja Subramanian, Lakshmi Bai 
>> <lakshmi.bai.raja.subramanian@intel.com>
>> Subject: Re: [PATCH v1 1/1] mmc: sdhci-of-arasan: Enable UHS-1 support 
>> for Keem Bay SOC
>>
>> Hi, +Arnd,
>>
>> On 14. 09. 20 7:12, muhammad.husaini.zulkifli@intel.com wrote:
>>> From: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>
>>>
>>> Voltage switching sequence is needed to support UHS-1 interface as 
>>> Keem Bay EVM is using external voltage regulator to switch between 
>>> 1.8V and 3.3V.
>>>
>>> Signed-off-by: Muhammad Husaini Zulkifli 
>>> <muhammad.husaini.zulkifli@intel.com>
>>> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
>>> Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
>>> ---
>>>  drivers/mmc/host/sdhci-of-arasan.c | 140
>>> +++++++++++++++++++++++++++++
>>>  1 file changed, 140 insertions(+)
>>>
>>> diff --git a/drivers/mmc/host/sdhci-of-arasan.c
>>> b/drivers/mmc/host/sdhci-of-arasan.c
>>> index f186fbd016b1..c133408d0c74 100644
>>> --- a/drivers/mmc/host/sdhci-of-arasan.c
>>> +++ b/drivers/mmc/host/sdhci-of-arasan.c
>>> @@ -16,7 +16,9 @@
>>>   */
>>>  
>>>  #include <linux/clk-provider.h>
>>> +#include <linux/gpio/consumer.h>
>>>  #include <linux/mfd/syscon.h>
>>> +#include <linux/arm-smccc.h>
>>>  #include <linux/module.h>
>>>  #include <linux/of_device.h>
>>>  #include <linux/phy/phy.h>
>>> @@ -41,6 +43,11 @@
>>>  #define SDHCI_ITAPDLY_ENABLE		0x100
>>>  #define SDHCI_OTAPDLY_ENABLE		0x40
>>>  
>>> +/* Setting for Keem Bay IO Pad 1.8 Voltage Selection */
>>> +#define KEEMBAY_AON_SIP_FUNC_ID		0x8200ff26
>>> +#define KEEMBAY_AON_SET_1V8_VOLT	0x01
>>> +#define KEEMBAY_AON_SET_3V3_VOLT	0x00
>>> +
>>>  /* Default settings for ZynqMP Clock Phases */
>>>  #define ZYNQMP_ICLK_PHASE {0, 63, 63, 0, 63,  0,   0, 183, 54,  0, 0}
>>>  #define ZYNQMP_OCLK_PHASE {0, 72, 60, 0, 60, 72, 135, 48, 72, 135, 
>>> 0} @@ -150,6 +157,7 @@ struct sdhci_arasan_data {
>>>  	struct regmap	*soc_ctl_base;
>>>  	const struct sdhci_arasan_soc_ctl_map *soc_ctl_map;
>>>  	unsigned int	quirks;
>>> +	struct gpio_desc *uhs_gpio;
>>>  
>>>  /* Controller does not have CD wired and will not function normally without */
>>>  #define SDHCI_ARASAN_QUIRK_FORCE_CDTEST	BIT(0)
>>> @@ -361,6 +369,121 @@ static int sdhci_arasan_voltage_switch(struct mmc_host *mmc,
>>>  	return -EINVAL;
>>>  }
>>>  
>>> +static int sdhci_arasan_keembay_set_voltage(int volt) { #if
>>> +IS_ENABLED(CONFIG_HAVE_ARM_SMCCC)
>>> +	struct arm_smccc_res res;
>>> +
>>> +	arm_smccc_smc(KEEMBAY_AON_SIP_FUNC_ID, volt, 0, 0, 0, 0, 0, 0, &res);
>>> +	if (res.a0)
>>> +		return -EINVAL;
>>> +	return 0;
>>
>> I am just curious about calling this smc directly from device driver. I see that several drivers are doing this but isn't it better to hide these in firmware driver?
>> [Husaini] In order to change the voltage selection for IO Pads voltage switching level control, I need to access/write to AON register. 
>> Due to security concern, U-Boot Team provided an interface using this SIP Service for me to call during kernel driver voltage switching operation. 
> 
> I expect U-Boot team is any internal team not U-Boot upstream folks.
> [Husaini] I requote my statement. It is ATF that provided the services. They are in the process of upstreaming the code as well. 
> That is a great idea to hide these in firmware driver.
> I created one firmware driver under /drivers/firmware. This firmware driver provide an api for device driver to call for the operations.
> 
> 
>> Also the part of FUNC_ID is smc32, sip service call (0x82000000) function identifier which is likely something what should be used as macro in shared location that others can use it too.
>> [Husaini] The only thing provided was the FUNC_ID value and argument.
>>
>> Another part is that based on description you are talking to external voltage regulator without using regulator framework at all. Isn't it better just to create firmware based regulator for this purpose?
>> [Husaini] This is for Keembay specific and we did not use regulator framework. 
>> During the voltage switching, this SIP function need to be executed to change the Keem Bay IO Pad Switching Level Control to 1.8V for UHS or 3.3v for default mode.
>> To be specific, below line of code must come together during the voltage switching operation.
>>
>> For 1.8V
>> +		/* Set VDDIO_B voltage to Low for 1.8V */
>> +		gpiod_set_value_cansleep(sdhci_arasan->uhs_gpio, 0);
>> +
>> +		ret = sdhci_arasan_keembay_set_voltage(KEEMBAY_AON_SET_1V8_VOLT);
>> +		if (ret)
>> +			return ret;
>>
>> For 3.3V
>> 		/* Set VDDIO_B voltage to High for 3.3V */
>> +		gpiod_set_value_cansleep(sdhci_arasan->uhs_gpio, 1);
>> +
>> +		ret = sdhci_arasan_keembay_set_voltage(KEEMBAY_AON_SET_3V3_VOLT);
>> +		if (ret)
>> +			return ret;
> 
> 
> I understand that you need to change voltage here but I don't think the code you have written is how this should be done. I understand that this is the quickest and direct way how to do it but I don't think this is done via proper interface. I pretty much dislike that you are putting Func IDs to drivers instead of adding them to central place that it is visible what your platform needs.
> [Husaini] let me rephase my sentences . I make some confusion here and in commit message. To summarize there are 2 places to final generate the IO Voltage.
> 
> 1) Setting the V_VDDIO_B . AON Register for IO PADS Voltage Switching Level Control.
> This register defines the IO Voltage for particular GPIOs pin for clk,cmd,data1-2.
> 
> 2) Setting the GPIO expander pin value to drive either 1.8V or 3.3V.
> SD card IO can operate at 3.3V (default) or 1.8V. 
> Keem Bay has a bank of IO that can be switched between 3.3V or 1.8V for this reason.
> The output V_VDDIO_B_MAIN be either 3.3v (in) or 1.8v(in), depending on the state of GPIO expander PIN value. 
> 
> The final IO voltage is set by V_VDDIO_B (= V_VDDIO_B_MAIN after passing through voltage sense resistor).
> I will use the gpio consumer interface to specify a direction and value for the gpio expander pin.
> Is this OK with these 2 implementation?

Ok. This more sounds like changing IO state which targets pin control
driver. Take a look at sdhci-tegra.c and trace pinctrl_state_3v3 and
pinctrl_state_1v8 and pinctrl_select_state and corresponding DT binding.

IMHO you should create pin control driver which will call firmware
driver to change voltage.

Thanks,
Michal

