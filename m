From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH RFCv2 10/10] mmc: sdhci: add command queue support to
 sdhci
Date: Wed, 6 Jul 2016 13:01:42 +0300
Message-ID: <577CD706.30105@intel.com>
References: <1467033757-32498-1-git-send-email-riteshh@codeaurora.org>
 <1467033757-32498-11-git-send-email-riteshh@codeaurora.org>
 <577B96E2.5050009@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <577B96E2.5050009@intel.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>, Ritesh Harjani <riteshh@codeaurora.org>, ulf.hansson@linaro.org, linux-mmc@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org, alex.lemberg@sandisk.com, mateusz.nowak@intel.com, Yuliy.Izrailov@sandisk.com, jh80.chung@samsung.com, dongas86@gmail.com, asutoshd@codeaurora.org, zhangfei.gao@gmail.com, kdorfman@codeaurora.org, david.griego@linaro.org, stummala@codeaurora.org, venkatg@codeaurora.org, shawn.lin@rock-chips.com, Subhash Jadavani <subhashj@codeaurora.org>
List-Id: linux-mmc@vger.kernel.org

On 05/07/16 14:15, Adrian Hunter wrote:
> On 27/06/16 16:22, Ritesh Harjani wrote:

<SNIP>

>> +{
>> +	struct sdhci_host *host = mmc_priv(mmc);
>> +
>> +	sdhci_writeb(host, val, SDHCI_TIMEOUT_CONTROL);
>> +}
> 
> We can't expect CQHCI to provide the SDHCI register value.  Ideally we don't
> want to set the highest value but instead calculate the value based on the
> maximum sized transfer.

Except cache flush doesn't have a timeout, so we will have to set the
highest value if we issue cache flush via DCMD.
