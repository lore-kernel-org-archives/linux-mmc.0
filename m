From: Peppe CAVALLARO <peppe.cavallaro@st.com>
Subject: Re: [PATCH (1/5)] mmc: sdhci-pltfm calls the sdhci_alloc_host with
 pdev->dev
Date: Thu, 11 Nov 2010 11:58:21 +0100
Message-ID: <4CDBCC4D.8040608@st.com>
References: <1289402889-14160-1-git-send-email-peppe.cavallaro@st.com>
 <1289402889-14160-2-git-send-email-peppe.cavallaro@st.com>
 <1289402889-14160-3-git-send-email-peppe.cavallaro@st.com>
 <20101110154352.GC2691@pengutronix.de> <4CDB9850.709@st.com>
 <20101111074818.GA28699@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog113.obsmtp.com ([207.126.144.135]:57614 "EHLO
	eu1sys200aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753593Ab0KKK6g convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 11 Nov 2010 05:58:36 -0500
In-Reply-To: <20101111074818.GA28699@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Hi Wolfram,

On 11/11/2010 8:48 AM, Wolfram Sang wrote:

>>> Removing the dev.parent-branch will break some PCI-based solutions.
>> Hmm, I suspected this :-(. Unfortunately I need to not pass the parent
>> for the problem described in the patch.
>> How to proceed? Do I have to re-introduce the sdhci-stm driver?
> The current mainline code does not work for you?\
your commit 4b711cb13843f5082e82970dd1e8031383134a65
resolves the issue I'm facing.

>>> I think you should first rebase the series to mmc-next and then ask for
>>> review. It is too confusing for reviewers otherwise. At least, I will
>>> stop here.
>> At any rate, no problem to re-base the patches to the mmc-next.I'll do
>> it soon!
> Great!
I'll resend all without this patch.

Many thanks!
Peppe

> Kind regards,
>
>    Wolfram
>
