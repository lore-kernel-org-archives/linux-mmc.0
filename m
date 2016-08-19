From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH v3 2/9] mmc: sdhci-msm: Update DLL reset sequence
Date: Fri, 19 Aug 2016 16:03:13 +0300
Message-ID: <7c7b5936-0234-3626-5caf-45cb5693d11b@intel.com>
References: <1471581384-18961-1-git-send-email-riteshh@codeaurora.org>
 <1471581384-18961-3-git-send-email-riteshh@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1471581384-18961-3-git-send-email-riteshh@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Ritesh Harjani <riteshh@codeaurora.org>
Cc: ulf.hansson@linaro.org, bjorn.andersson@linaro.org, shawn.lin@rock-chips.com, jh80.chung@samsung.com, linux-mmc@vger.kernel.org, linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org, alex.lemberg@sandisk.com, mateusz.nowak@intel.com, Yuliy.Izrailov@sandisk.com, asutoshd@codeaurora.org, kdorfman@codeaurora.org, david.griego@linaro.org, stummala@codeaurora.org, venkatg@codeaurora.org
List-Id: linux-mmc@vger.kernel.org

On 19/08/16 07:36, Ritesh Harjani wrote:
> From: Venkat Gopalakrishnan <venkatg@codeaurora.org>
> 
> SDCC core with minor version >= 0x42 introduced new 14lpp
> DLL. This has additional requirements in the reset sequence
> for DLL tuning. Make necessary changes as needed.
> 
> Without this patch we see below errors on such SDHC controllers
> 	sdhci_msm 7464900.sdhci: mmc0: DLL failed to LOCK
> 	mmc0: tuning execution failed: -110
> 
> Signed-off-by: Venkat Gopalakrishnan <venkatg@codeaurora.org>
> Signed-off-by: Ritesh Harjani <riteshh@codeaurora.org>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>
