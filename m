Return-Path: <SRS0=q7gx=CZ=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4375DC43461
	for <linux-mmc@archiver.kernel.org>; Wed, 16 Sep 2020 06:43:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A384208E4
	for <linux-mmc@archiver.kernel.org>; Wed, 16 Sep 2020 06:43:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726281AbgIPGm7 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 16 Sep 2020 02:42:59 -0400
Received: from mga18.intel.com ([134.134.136.126]:30202 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726279AbgIPGm7 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 16 Sep 2020 02:42:59 -0400
IronPort-SDR: NBgssxAuhlGYZYgR1UR5iwSSJRlEPRJSlvWywd0g1Cam/sjWMBgiO52TUCVFC+gSGtkQmPfGQj
 UEw3cVP9PLrw==
X-IronPort-AV: E=McAfee;i="6000,8403,9745"; a="147163234"
X-IronPort-AV: E=Sophos;i="5.76,431,1592895600"; 
   d="scan'208";a="147163234"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2020 23:42:57 -0700
IronPort-SDR: PpHmEUn8pkqBkhBNvyeaWiBzg3+Eeq/8Rtfdr0W/M6o7Wd+XSlWJ5mZzWZVcvUgy4QdWKO0kqi
 JYFrmrhiKCSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,431,1592895600"; 
   d="scan'208";a="319734179"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.190]) ([10.237.72.190])
  by orsmga002.jf.intel.com with ESMTP; 15 Sep 2020 23:42:55 -0700
Subject: Re: [RFC PATCH V3 15/21] mmc: sdhci: UHS-II support, modify
 set_power() to handle vdd2
To:     AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Ben Chuang <benchuanggli@gmail.com>, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.chuang@genesyslogic.com.tw, greg.tu@genesyslogic.com.tw
References: <20200710111140.29725-1-benchuanggli@gmail.com>
 <97c43596-a18f-4c7a-c226-5209772d91d1@intel.com>
 <20200914054537.GA2738017@laputa>
 <f0ff6c0a-4029-72a9-559c-8930ef0ea8bb@intel.com>
 <20200915062443.GB2860208@laputa>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <0c11a3cb-fe7c-978d-7608-c98453899b5f@intel.com>
Date:   Wed, 16 Sep 2020 09:42:28 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200915062443.GB2860208@laputa>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 15/09/20 9:24 am, AKASHI Takahiro wrote:
> Adrain,
> 
> On Mon, Sep 14, 2020 at 09:36:02AM +0300, Adrian Hunter wrote:
>> On 14/09/20 8:45 am, AKASHI Takahiro wrote:
>>> Adrian,
>>>
>>> On Fri, Aug 21, 2020 at 05:11:18PM +0300, Adrian Hunter wrote:
>>>> On 10/07/20 2:11 pm, Ben Chuang wrote:
>>>>> From: AKASHI Takahiro <takahiro.akashi@linaro.org>
>>>>>
>>>>> VDD2 is used for powering UHS-II interface.
>>>>> Modify sdhci_set_power_and_bus_voltage(), sdhci_set_power_noreg()
>>>>> and sdhci_set_power_noreg() to handle VDD2.
>>>>
>>>> vdd2 is always 1.8 V and I suspect there may never be support for anything
>>>> else, so we should start with 1.8 V only.
>>>
>>> What do you mean here?
>>> You don't want to add an extra argument, vdd2, to sdhci_set_power().
>>> Correct?
>>
>> Yes
>>
>>>
>>>> Also can we create uhs2_set_power_reg() and uhs2_set_power_noreg() and use
>>>> the existing ->set_power() callback
>>>
>>> Again what do you expect here?
>>>
>>> Do you want to see any platform-specific mmc driver who supports UHS-II
>>> to implement its own call back like:
>>
>> Not exactly.  I expect there to be a common implementation in sdhci-uhs2.c
>> called sdhci_uhs2_set_power() for example, that drivers can use by setting
>> their .set_power = sdhci_uhs2_set_power.  If they need platform-specific
>> code as well then their platform-specific code can call
>> sdhci_uhs2_set_power() if desired.
>>
>>>
>>> void sdhci_foo_set_power(struct sdhci_host *host, unsigned char mode,
>>>                                   unsigned short vdd)
>>> {
>>>         sdhci_set_power(host, mode,vdd);
>>>
>>>         /* in case that sdhci_uhs2 module is not inserted */
>>>         if (!(mmc->caps & MMC_CAP_UHS2))
>>>                 return;
>>>
>>>         /* vdd2 specific operation */
>>>         if (IS_ERR_OR_NULL(host->mmc->supply.vmmc2))
>>>                 sdhci_uhs2_set_power_noreg(host, mode);
>>>         else
>>>                 sdhci_uhs2_set_power_reg(host, mode);
>>>
>>>         /* maybe more platform-specific initialization */
>>> }
>>>
>>> struct sdhci_ops sdhci_foo_ops = {
>>>         .set_power = sdhci_foo_set_power,
>>>         ...
>>> }
> 
> What do you think about this logic in general?
> (If necessary, read it replacing "foo" to "uhs2".)
> 
> What I'm concerned about is SDHCI_POWER_CONTROL register.
> Vdd and vdd2 are controlled with corresponding bits in this register.
> It seems to be "natural" to me that vdd and vdd2 are enabled
> in a single function rather than putting them in separate ones.
> 
> In particular, in the case of sdhci_set_power_noreg(), there exist a couple
> of "quirks" around writing the bits to SDHCI_POWER_CONTROL register.

We can treat UHS-II support as being for new hardware and therefore
we don't necessarily need to support old quirks.  Just make sure if
a quirk is not being supported, to add a comment to that effect.

> I don't know how we should handle them if we have a separate function,
> say, sdhci_uhs2_set_power_noreg().
> Do you want to see a copy of the same logic in sdhci_uhs2_set_power_noreg()? 

I would probably consider making another function that non-UHS-II
drivers do not need to care about e.g. existing drivers can keep using
sdhci_set_power_noreg() and sdhci_uhs2 can call __sdhci_set_power_noreg()

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 592a55a34b58..ffe54f06fe38 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2013,8 +2013,8 @@ static void sdhci_set_power_reg(struct sdhci_host *host, unsigned char mode,
 		sdhci_writeb(host, 0, SDHCI_POWER_CONTROL);
 }
 
-void sdhci_set_power_noreg(struct sdhci_host *host, unsigned char mode,
-			   unsigned short vdd)
+void __sdhci_set_power_noreg(struct sdhci_host *host, unsigned char mode,
+			   unsigned short vdd, u8 vdd2)
 {
 	u8 pwr = 0;
 
@@ -2048,7 +2048,7 @@ void sdhci_set_power_noreg(struct sdhci_host *host, unsigned char mode,
 	if (host->pwr == pwr)
 		return;
 
-	host->pwr = pwr;
+	host->pwr = pwr | vdd2;
 
 	if (pwr == 0) {
 		sdhci_writeb(host, 0, SDHCI_POWER_CONTROL);
@@ -2085,6 +2085,13 @@ void sdhci_set_power_noreg(struct sdhci_host *host, unsigned char mode,
 			mdelay(10);
 	}
 }
+EXPORT_SYMBOL_GPL(__sdhci_set_power_noreg);
+
+void sdhci_set_power_noreg(struct sdhci_host *host, unsigned char mode,
+			   unsigned short vdd)
+{
+	__sdhci_set_power_noreg(host, mode, vdd, 0);
+}
 EXPORT_SYMBOL_GPL(sdhci_set_power_noreg);
 
 void sdhci_set_power(struct sdhci_host *host, unsigned char mode,

> 
> -Takahiro Akashi
> 
> 
>>>
>>> Is this what you mean?
>>> (I'm not quite sure yet that sdhci_ush2_set_power_noreg() can be split off
>>> from sdhci_set_power_noreg().)
>>>
>>> -Takahiro Akashi

