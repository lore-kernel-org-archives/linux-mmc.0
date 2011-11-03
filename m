From: Giuseppe CAVALLARO <peppe.cavallaro@st.com>
Subject: Re: [PATCH] mmc: debugfs: expose the SDCLK frq in sys ios (v3)
Date: Thu, 03 Nov 2011 07:46:54 +0100
Message-ID: <4EB238DE.9050706@st.com>
References: <1319031945-2630-1-git-send-email-peppe.cavallaro@st.com> <1319696209-3171-1-git-send-email-peppe.cavallaro@st.com> <CAAgDR1N=mPVMoQNHmFvX2BvH_nmuemzQx3+z16qqS7BjQeOWDg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog106.obsmtp.com ([207.126.144.121]:44550 "EHLO
	eu1sys200aog106.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752572Ab1KCGq6 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 3 Nov 2011 02:46:58 -0400
In-Reply-To: <CAAgDR1N=mPVMoQNHmFvX2BvH_nmuemzQx3+z16qqS7BjQeOWDg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Sebastian Rasmussen <sebras@gmail.com>
Cc: linux-mmc@vger.kernel.org

On 10/28/2011 12:02 AM, Sebastian Rasmussen wrote:
> Hi!
> 
>> +++ b/drivers/mmc/host/sdhci.c
>> @@ -1107,9 +1113,13 @@ static void sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
>>                        if ((host->max_clk / div) <= clock)
>>                                break;
>>                }
>> +               real_div = div;
>>                div >>= 1;
>>        }
>>
>> +       if (real_div)
>> +               host->mmc->actual_clock = (host->max_clk * clk_mul) / real_div;
> 
> What triggered me to look at this is that usually a divider of 0 means
> that the clock is not divided at all, and your code seemed to set
> host->mmc->actual_clock to 0 in this case. After further inspection I
> realize that real_div appears to always be >= 1 which means that the
> if-statement is unnecessary. Or did I miss something?

fixed in v4
thx
peppe

> 
>  / Sebastian
> 
> PS. I don't have a good SDHCI spec, is it publicly available
> somewhere? I have only found Pierre Ossman's old wiki on
> archive.org...
> 

