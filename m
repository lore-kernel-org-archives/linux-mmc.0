From: Pramod Gurav <pramod.gurav@linaro.org>
Subject: Re: [PATCH v3] mmc: sdhci-msm: Add pm_runtime and system PM support
Date: Mon, 12 Sep 2016 13:17:07 +0530
Message-ID: <CANYu_0tviS8tiG1Zskk2XHnXQ=7CJKH_gcCaUOoT+kMh-2oTCQ@mail.gmail.com>
References: <20160901142335.2396-1-pramod.gurav@linaro.org> <57D28847.8070308@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <57D28847.8070308@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: "Tummala, Sahitya" <stummala@codeaurora.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, "open list:ARM/QUALCOMM SUPPORT" <linux-arm-msm@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org

On 9 September 2016 at 15:30, Tummala, Sahitya <stummala@codeaurora.org> wrote:
> Hi Pramod,
<snip>
>> +       ret = clk_prepare_enable(msm_host->clk);
>> +       if (ret) {
>> +               dev_err(dev, "clk_enable failed: %d\n", ret);
>
> A minor comment - Both error prints related to clock enable are same. Better
> to print the clock name as well to know which clock enable got failed.
>

Thanks Sahitya for comments. Will take care of this in next version.
>> +               return ret;
>> +       }
