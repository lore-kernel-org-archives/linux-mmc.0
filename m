From: Peppe CAVALLARO <peppe.cavallaro@st.com>
Subject: Re: [PATCH] mmc: add SDHCI driver for STM platforms (V2)
Date: Wed, 22 Sep 2010 16:35:19 +0200
Message-ID: <4C9A1427.7030806@st.com>
References: <1284970817-11293-1-git-send-email-peppe.cavallaro@st.com>
 <20100920083842.GA4058@pengutronix.de> <4C98792C.5000900@st.com>
 <20100921094457.GD3168@pengutronix.de> <4C9A0518.3090904@st.com>
 <20100922141223.GF2693@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog110.obsmtp.com ([207.126.144.129]:50655 "EHLO
	eu1sys200aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754998Ab0IVOfr convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 22 Sep 2010 10:35:47 -0400
In-Reply-To: <20100922141223.GF2693@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "matt@console-pimps.org" <matt@console-pimps.org>

On 09/22/2010 04:12 PM, Wolfram Sang wrote:
> Hi Peppe,
> 
>> 1) I've already a patch to add the suspend/resume in the sdhci_pltfm
>>    driver. Please note this is mandatory for me.
> 
> Great, improvements to the generic pltfm-driver are most welcome!

Good! I'm happy to contribute on it. I'll start soon and post the
patches asap.

> 
>>    Note: I'd like to look at the wake-up on card that should be nice to
>>    have in the future. IIUC, it is missing in the sdhci. Please correct
>>    me if I'm wrong.
> 
> It is not in sdhci yet. Please make sure to send very early RFC-patches
> here, so we can see what you are aiming for.

OK!

> 
>> 2) sdhci_pltfm_data has a "quirk" flag but IMO the quirk macros, that
>>    currently are in linux-2.6/drivers/mmc/host/sdhci.h, should be
>>    moved in a separate file:
>>
>>     include/linux/mmc/sdhci.h or
>>     include/linux/mmc/sdhci-quirk.h or ...
>>
>>    I don't know if it has been already done but I could create a patch
>>    for this too. Let me know the name convention you like, eventually.
>>
>>    Otherwise, in my platforms, where I need to set this flag (e.g. the
>>    sdhci-stm needs: SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC), I should include
>>    drivers/mmc/host/sdhci.h?!? I don't like it :-(
>>    Please, correct me if I've missed something.
> 
> You are correct. So far, all users of the quirk-flags happened to be
> inside the host-directory. If you happen to have a controller which only
> needs quirk-flags and no custom functions (congrats! ;)), then those
> quirk-flags really need to be moved, so your platform code can find it.
> 
> I'd go for sdhci.h as the name. Be sure to catch all users of the quirks
> to include your new file.

OK! I like shdci.h too ;-)
I'll pay attention to add this header file in the other drivers based on
sdhci.

> 
>> 3) In the end, another hook could be added in the sdhci_pltfm_data to
>>    invoke specific own functions for claiming resources etc.
>>    For example, I need an extra callback to invoke the STM pad manager
>>    that's used for managing clocks, PIO lines and syscfg registers.
>>
>>    I'm thinking about something like this:
>>
>>    struct sdhci_pltfm_data {
>>         struct sdhci_ops *ops;
>>         unsigned int quirks;
>>         int (*init)(struct sdhci_host *host);
>>         void (*exit)(struct sdhci_host *host);
>>         int (*claim_resource)(struct platform_device *pdev);
>>                  |
>>                  |_ we can use another name.
>>    };
> 
> And init() is too late?

No it's not late but I need the dev structure from the platform_device.
We could add the "struct device dev;" in the sdhci_host structure
instead of.
In this case the sdhci_host should be moved within the new
include/linux/mmc/sdhci.h file.
Indeed, this could make sense because the drivers/mmc/host/sdhci.h will
only have the HW register configuration. Shared macros (quirks) and
structures among sdhci driver based could be moved in
include/linux/mmc/sdhci.h header.

What do you think?

Regards,
Peppe
