From: Peppe CAVALLARO <peppe.cavallaro@st.com>
Subject: Re: [PATCH] mmc: add SDHCI driver for STM platforms (V2)
Date: Tue, 21 Sep 2010 11:21:48 +0200
Message-ID: <4C98792C.5000900@st.com>
References: <1284970817-11293-1-git-send-email-peppe.cavallaro@st.com>
 <20100920083842.GA4058@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog120.obsmtp.com ([207.126.144.149]:53483 "EHLO
	eu1sys200aog120.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752171Ab0IUJWW convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 21 Sep 2010 05:22:22 -0400
In-Reply-To: <20100920083842.GA4058@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "matt@console-pimps.org" <matt@console-pimps.org>

On 09/20/2010 10:38 AM, Wolfram Sang wrote:
> On Mon, Sep 20, 2010 at 10:20:17AM +0200, Giuseppe CAVALLARO wrote:
>> This patch adds the Arasan MMC/SD/SDIO driver
>> for the STM ST40 platforms. It is based on the
>> SDHCI driver.
>> It has been tested on the STx7106/STx7108/STx5289
>> platforms.
>>
>> Signed-off-by: Giuseppe Cavallaro <peppe.cavallaro@st.com>
> 
> Looks to me that you could just use the sdhci-pltfm driver?
> 

Hello Wolfram,
some weeks ago I discussed about this driver and I reworked it according
to the changes required. This is the meaning of this patch.

At any rate, I can look at the sdhci-pltfm driver: at first glance, it
could actually help on our platforms. This could take a while.

Regards
Peppe
