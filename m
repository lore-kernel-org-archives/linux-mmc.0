From: Peppe CAVALLARO <peppe.cavallaro@st.com>
Subject: Re: [PATCH] mmc: add SDHCI driver for STM platforms (V2)
Date: Thu, 23 Sep 2010 11:30:26 +0200
Message-ID: <4C9B1E32.4070700@st.com>
References: <1284970817-11293-1-git-send-email-peppe.cavallaro@st.com>
 <20100920083842.GA4058@pengutronix.de> <4C98792C.5000900@st.com>
 <20100921094457.GD3168@pengutronix.de> <4C9A0518.3090904@st.com>
 <20100922141223.GF2693@pengutronix.de> <4C9A1427.7030806@st.com>
 <20100923084716.GB2994@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog102.obsmtp.com ([207.126.144.113]:39112 "EHLO
	eu1sys200aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752489Ab0IWJbH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 23 Sep 2010 05:31:07 -0400
In-Reply-To: <20100923084716.GB2994@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "matt@console-pimps.org" <matt@console-pimps.org>

On 09/23/2010 10:48 AM, Wolfram Sang wrote:
> I think it will be better to give init() access to all information
> needed than to implement another hook. I tried with this patch
> 
> https://patchwork.kernel.org/patch/196992/
> 
> I am still not sure what kind of information you need from the pdev. Can
> you create a branch somewhere with your current work?


Hi Wolfram,
I've just sent some patches and I used the .init as you wanted.

Fortunately the problem can be resolved without modifying .init within
the sdhci_pltfm_data structure.

The sdhci_host structure has the mmc field that also has the pointer to
the device parent.
This can be used for getting the device structure pointer in my platform.
For example, below there is the piece of code added, in my platform, to
use the sdhci-pltfm driver.

It works fine without modifying other files.

What do you think?

Regards,
Peppe

[snip]

static int mmc_pad_resources(struct sdhci_host *sdhci)
{
        if (!devm_stm_pad_claim(sdhci->mmc->parent,
                                &stx7108_mmc_pad_config,
                                dev_name(sdhci->mmc->parent)))
                return -ENODEV;

        return 0;
}

static struct sdhci_pltfm_data stx7108_mmc_platform_data = {
                .init = &mmc_pad_resources,
                .quirks = SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC,
};

static struct platform_device stx7108_mmc_device = {
                .name = "sdhci",

[snip]

> 
> Regards,
> 
>    Wolfram
> 
