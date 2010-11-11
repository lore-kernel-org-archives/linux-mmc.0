From: Peppe CAVALLARO <peppe.cavallaro@st.com>
Subject: Re: [PATCH (1/5)] mmc: sdhci-pltfm calls the sdhci_alloc_host with
 pdev->dev
Date: Thu, 11 Nov 2010 08:16:32 +0100
Message-ID: <4CDB9850.709@st.com>
References: <1289402889-14160-1-git-send-email-peppe.cavallaro@st.com>
 <1289402889-14160-2-git-send-email-peppe.cavallaro@st.com>
 <1289402889-14160-3-git-send-email-peppe.cavallaro@st.com>
 <20101110154352.GC2691@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog114.obsmtp.com ([207.126.144.137]:53072 "EHLO
	eu1sys200aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757679Ab0KKHRV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 11 Nov 2010 02:17:21 -0500
In-Reply-To: <20101110154352.GC2691@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Hi Wolfram

On 11/10/2010 4:43 PM, Wolfram Sang wrote:
> Hi,
>
> thanks for the work in general, just...
>
>> -	if (pdev->dev.parent)
>> -		host = sdhci_alloc_host(pdev->dev.parent, 0);
>> -	else
>> -		host = sdhci_alloc_host(&pdev->dev, 0);
>> -
>> +	host = sdhci_alloc_host(&pdev->dev, 0);
>>  	if (IS_ERR(host)) {
>>  		ret = PTR_ERR(host);
>>  		goto err;
> NACK. This part looks different in current mainline (and for a reason).
Yes, as I had written in the first email I built these patches against
our Kernel 2.6.32.
I wanted to align them to the mmc-next after clarifying some doubts I had.
For example the wakeup option used for selecting at runtime the wakeup mode.

> Removing the dev.parent-branch will break some PCI-based solutions.
Hmm, I suspected this :-(. Unfortunately I need to not pass the parent
for the problem described in the patch.
How to proceed? Do I have to re-introduce the sdhci-stm driver?
> I think you should first rebase the series to mmc-next and then ask for
> review. It is too confusing for reviewers otherwise. At least, I will
> stop here.
At any rate, no problem to re-base the patches to the mmc-next.I'll do
it soon!

Regards
Peppe
> Kind regards,
>
>    Wolfram
>
