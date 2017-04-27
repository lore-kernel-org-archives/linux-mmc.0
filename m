From: Georgi Djakov <georgi.djakov@linaro.org>
Subject: Re: [PATCH v9 07/16] mmc: sdhci-msm: Add get_min_clock() and
 get_max_clock() callback
Date: Thu, 27 Apr 2017 10:58:52 +0300
Message-ID: <51e8cd7e-05f8-3164-5cb1-d4ecd866539a@linaro.org>
References: <1479710246-26676-1-git-send-email-riteshh@codeaurora.org>
 <1479710246-26676-8-git-send-email-riteshh@codeaurora.org>
 <20170426214443.GA32019@hector.attlocal.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <20170426214443.GA32019@hector.attlocal.net>
Sender: linux-clk-owner@vger.kernel.org
To: Andy Gross <andy.gross@linaro.org>, stable@vger.kernel.org
Cc: Ritesh Harjani <riteshh@codeaurora.org>, ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, adrian.hunter@intel.com, sboyd@codeaurora.org, shawn.lin@rock-chips.com, devicetree@vger.kernel.org, linux-clk@vger.kernel.org, david.brown@linaro.org, linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org, alex.lemberg@sandisk.com, mateusz.nowak@intel.com, Yuliy.Izrailov@sandisk.com, asutoshd@codeaurora.org, david.griego@linaro.org, stummala@codeaurora.org, venkatg@codeaurora.org, rnayak@codeaurora.org, pramod.gurav@linaro.org, jeremymc@redhat.com
List-Id: linux-mmc@vger.kernel.org

On 04/27/2017 12:44 AM, Andy Gross wrote:
> On Mon, Nov 21, 2016 at 12:07:17PM +0530, Ritesh Harjani wrote:
>> This add get_min_clock() and get_max_clock() callback
>> for sdhci-msm. sdhci-msm min/max clocks may be different
>> hence implement these callbacks.
>>
>> Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
>> Signed-off-by: Ritesh Harjani <riteshh@codeaurora.org>
>> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
> 
> This patch needs to be picked up for stable as 4.9 is currently broken w.r.t.
> MMC on Qualcomm platforms.
> 
> Fixes: d84be51d1c1d ("mmc: sdhci-msm: Enable few quirks")

Agree! Applying this patch (80031bdeb764) in stable fixes the
broken mmc. Otherwise the following error is seen since v4.9.22:

mmc0: Hardware doesn't specify base clock frequency.

Thanks,
Georgi
