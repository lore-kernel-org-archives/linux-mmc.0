From: Peppe CAVALLARO <peppe.cavallaro@st.com>
Subject: Re: [PATCH] mmc: add SDHCI driver for STM platforms (V2)
Date: Wed, 22 Sep 2010 15:31:04 +0200
Message-ID: <4C9A0518.3090904@st.com>
References: <1284970817-11293-1-git-send-email-peppe.cavallaro@st.com>
 <20100920083842.GA4058@pengutronix.de> <4C98792C.5000900@st.com>
 <20100921094457.GD3168@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog120.obsmtp.com ([207.126.144.149]:55495 "EHLO
	eu1sys200aog120.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752254Ab0IVNbs convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 22 Sep 2010 09:31:48 -0400
In-Reply-To: <20100921094457.GD3168@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "matt@console-pimps.org" <matt@console-pimps.org>

On 09/21/2010 11:44 AM, Wolfram Sang wrote:
> On Tue, Sep 21, 2010 at 11:21:48AM +0200, Peppe CAVALLARO wrote:
>> On 09/20/2010 10:38 AM, Wolfram Sang wrote:
>>> On Mon, Sep 20, 2010 at 10:20:17AM +0200, Giuseppe CAVALLARO wrote:
>>>> This patch adds the Arasan MMC/SD/SDIO driver
>>>> for the STM ST40 platforms. It is based on the
>>>> SDHCI driver.
>>>> It has been tested on the STx7106/STx7108/STx5289
>>>> platforms.
>>>>
>>>> Signed-off-by: Giuseppe Cavallaro <peppe.cavallaro@st.com>
>>>
>>> Looks to me that you could just use the sdhci-pltfm driver?
>>>
>>
>> Hello Wolfram,
>> some weeks ago I discussed about this driver and I reworked it according
>> to the changes required. This is the meaning of this patch.
>>
>> At any rate, I can look at the sdhci-pltfm driver: at first glance, it
>> could actually help on our platforms. This could take a while.
> 
> Sorry, I didn't spot the first version of your patch. I would have said
> the same then, simply to avoid the code duplication. Oh, and no need to
> hurry from my side :)

Hi Wolfran,
I agree that it's a good idea to reduce duplicated code when possible
(i.e. the probe function that, at first glance, is almost equal for
several sdhci drivers based).

Maybe, I could use on our ST boxes the sdhci_pltfm but I have the
following questions and ideas. Welcome advice and feedback.

1) I've already a patch to add the suspend/resume in the sdhci_pltfm
   driver. Please note this is mandatory for me.

   Note: I'd like to look at the wake-up on card that should be nice to
   have in the future. IIUC, it is missing in the sdhci. Please correct
   me if I'm wrong.

2) sdhci_pltfm_data has a "quirk" flag but IMO the quirk macros, that
   currently are in linux-2.6/drivers/mmc/host/sdhci.h, should be
   moved in a separate file:

    include/linux/mmc/sdhci.h or
    include/linux/mmc/sdhci-quirk.h or ...

   I don't know if it has been already done but I could create a patch
   for this too. Let me know the name convention you like, eventually.

   Otherwise, in my platforms, where I need to set this flag (e.g. the
   sdhci-stm needs: SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC), I should include
   drivers/mmc/host/sdhci.h?!? I don't like it :-(
   Please, correct me if I've missed something.

3) In the end, another hook could be added in the sdhci_pltfm_data to
   invoke specific own functions for claiming resources etc.
   For example, I need an extra callback to invoke the STM pad manager
   that's used for managing clocks, PIO lines and syscfg registers.

   I'm thinking about something like this:

   struct sdhci_pltfm_data {
        struct sdhci_ops *ops;
        unsigned int quirks;
        int (*init)(struct sdhci_host *host);
        void (*exit)(struct sdhci_host *host);
        int (*claim_resource)(struct platform_device *pdev);
                 |
                 |_ we can use another name.
   };

What do you think?

Regards
Peppe
