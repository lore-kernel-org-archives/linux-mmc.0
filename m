From: Ritesh Harjani <riteshh@codeaurora.org>
Subject: Re: [RESEND PATCHv1 0/8] mmc: sdhci-msm: Provide support for enhanced
 strobe
Date: Wed, 18 Jan 2017 13:24:25 +0530
Message-ID: <1a747499-7c47-0feb-ac6b-c229e78e10a4@codeaurora.org>
References: <1484031652-12059-1-git-send-email-riteshh@codeaurora.org>
 <20170117010751.GA25703@mini-rhel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:33656 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751090AbdARHz2 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 18 Jan 2017 02:55:28 -0500
In-Reply-To: <20170117010751.GA25703@mini-rhel.redhat.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jeremy McNicoll <jmcnicol@redhat.com>, adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, shawn.lin@rock-chips.com, linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org, asutoshd@codeaurora.org, stummala@codeaurora.org, venkatg@codeaurora.org, pramod.gurav@linaro.org, jeremymc@redhat.com, git@kchr.de



On 1/17/2017 6:37 AM, Jeremy McNicoll wrote:
> On Tue, Jan 10, 2017 at 12:30:44PM +0530, Ritesh Harjani wrote:
>> Hi,
>>
>> Resending this patch series, as no one could review it -possibly due to
>> holidays during that time.
>>
>> This patch series mainly provides enhanced strobe support to sdhci-msm driver
>> along with some additions of HW recommended sequence. This has been tested on
>> 8996 based internal target & on db410c.
>>
>> Patches 1-3 :- Factors out few functions to be re-used again.
>> 	       To also simplify large functions and makes it more readable.
>>
>> Patches 4-5 :- Few recommendations based on HW prog. guide.
>>
>> Patches 6 :- Clear SDHCI_HS400_TUNING flag after platform_execute_tuning
>> 	     so that ->platform_execute_tuning (underlying platform driver) can
>> 	     know about HS400 tuning.
>>
>> Patch 7 :- Implements an additional step as per HPG for HS400 tuning.
>>
>> Patch 8 :- Implements enhanced strobe functionality in sdhci-msm driver.
>>
>>
>
> I have included this series in my tree while testing my SDHCI V2 series.
>
> One message did occur which looks new or unfamilar and relatively
> harmless,
>
> "sdhci_msm f9824900.mmc: TCXO clk not present (-2) "
This should be ok.

>
> Is that something I am missing on my side?
You should provide this in your DT.
@@ -463,8 +463,9 @@
                         interrupts = <0 141 0>, <0 134 0>;
                         interrupt-names = "hc_irq", "pwr_irq";
                         clocks = <&gcc GCC_SDCC1_APPS_CLK>,
-                                <&gcc GCC_SDCC1_AHB_CLK>;
-                       clock-names = "core", "iface";
+                                <&gcc GCC_SDCC1_AHB_CLK>,
+                                <&xo_board>;
+                       clock-names = "core", "iface", "xo";



>
> In anycase,
>
> Tested-by: Jeremy McNicoll <jeremymc@redhat.com>
Thanks for testing this series.

Hi Adrian/Ulf,
In case if we dont have any other comments, can we please include this 
series in next ?


-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
