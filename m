From: Peppe CAVALLARO <peppe.cavallaro@st.com>
Subject: Re: [PATCH] mmc: add SDHCI driver for STM platforms (V2)
Date: Thu, 23 Sep 2010 12:05:20 +0200
Message-ID: <4C9B2660.6050802@st.com>
References: <1284970817-11293-1-git-send-email-peppe.cavallaro@st.com>
 <20100920083842.GA4058@pengutronix.de> <4C98792C.5000900@st.com>
 <20100921094457.GD3168@pengutronix.de> <4C9A0518.3090904@st.com>
 <20100922141223.GF2693@pengutronix.de> <4C9A1427.7030806@st.com>
 <20100923084716.GB2994@pengutronix.de> <4C9B1E32.4070700@st.com>
 <20100923095142.GC2994@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog115.obsmtp.com ([207.126.144.139]:33076 "EHLO
	eu1sys200aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751527Ab0IWKG1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 23 Sep 2010 06:06:27 -0400
In-Reply-To: <20100923095142.GC2994@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "matt@console-pimps.org" <matt@console-pimps.org>

On 09/23/2010 11:51 AM, Wolfram Sang wrote:
> 
>> static int mmc_pad_resources(struct sdhci_host *sdhci)
>> {
>>         if (!devm_stm_pad_claim(sdhci->mmc->parent,
>>                                 &stx7108_mmc_pad_config,
>>                                 dev_name(sdhci->mmc->parent)))
>>                 return -ENODEV;
>>
>>         return 0;
>> }
>>
>> static struct sdhci_pltfm_data stx7108_mmc_platform_data = {
>>                 .init = &mmc_pad_resources,
> 
> You can drop the &

Thx ;-)

> 
>>                 .quirks = SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC,
>> };
>>
>> static struct platform_device stx7108_mmc_device = {
>>                 .name = "sdhci",
>>
>> [snip]
> 
> All in all, this looks like the right way! A good example how to
> slightly update and then use the pltfm-driver. Redundant code saved and
> benefits for all added :)

Regards,
Peppe

> Regards,
> 
>    Wolfram
> 
