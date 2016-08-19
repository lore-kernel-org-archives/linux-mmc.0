From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH v3 6/9] mmc: sdhci-msm: Enable few quirks
Date: Fri, 19 Aug 2016 16:04:15 +0300
Message-ID: <c170a586-e6fb-7e48-93ae-ff8be0cbc9d0@intel.com>
References: <1471581384-18961-1-git-send-email-riteshh@codeaurora.org>
 <1471581384-18961-7-git-send-email-riteshh@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1471581384-18961-7-git-send-email-riteshh@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Ritesh Harjani <riteshh@codeaurora.org>
Cc: ulf.hansson@linaro.org, bjorn.andersson@linaro.org, shawn.lin@rock-chips.com, jh80.chung@samsung.com, linux-mmc@vger.kernel.org, linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org, alex.lemberg@sandisk.com, mateusz.nowak@intel.com, Yuliy.Izrailov@sandisk.com, asutoshd@codeaurora.org, kdorfman@codeaurora.org, david.griego@linaro.org, stummala@codeaurora.org, venkatg@codeaurora.org
List-Id: linux-mmc@vger.kernel.org

On 19/08/16 07:36, Ritesh Harjani wrote:
> sdhc-msm controller needs this SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN
> & SDHCI_QUIRK2_PRESET_VALUE_BROKEN to be set. Hence setting it.
> 
> Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
> Signed-off-by: Ritesh Harjani <riteshh@codeaurora.org>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>
