From: Viresh Kumar <viresh.kumar@st.com>
Subject: Re: [Query] mmc/sdhci: Suspend hangs if card is inserted at suspend.
Date: Tue, 15 Nov 2011 12:40:11 +0530
Message-ID: <4EC21053.8060402@st.com>
References: <4EBCC49E.5060008@st.com> <877h36hvki.fsf@laptop.org> <4EC1FCC1.6070609@st.com> <5D8008F58939784290FAB48F549751984E6510F91D@shsmsx502.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog101.obsmtp.com ([207.126.144.111]:34676 "EHLO
	eu1sys200aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752851Ab1KOHK1 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 15 Nov 2011 02:10:27 -0500
In-Reply-To: <5D8008F58939784290FAB48F549751984E6510F91D@shsmsx502.ccr.corp.intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Dong, Chuanxiao" <chuanxiao.dong@intel.com>
Cc: Chris Ball <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Shiraz HASHIM <shiraz.hashim@st.com>, Armando VISCONTI <armando.visconti@st.com>, Ajay KHANDELWAL <ajay.khandelwal@st.com>

On 11/15/2011 12:27 PM, Dong, Chuanxiao wrote:
> Hi Viresh,
> I also meet the hang issue when suspending a system with a mounted SD card. Actually it caused by a dead lock of mmc_claim_host. Maybe we faced the same issue.
> So may be the two mails in the attachment can help you.

Hi Dong,

You wouldn't believe it, but just 5 mins earlier i found the mail
chain you sent to me. I got this fix of moving claim_host below remove
and it worked for me too. But i faced another issue with the patch when
i suspend/resume again and again in a loop. It might or might not be
related to this patch.

But i don't see this work getting pushed into Linux.
What is the current state at your SoC? Are you keeping this issue open as
"Don't suspend with MMC card mounted"

Or you are working with this fix?

Thanks for the mail.

-- 
viresh
