From: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Subject: Re: [PATCH] mmc: sdhci-pci: Only do AMD tuning for HS200
Date: Tue, 10 Apr 2018 10:21:06 +0530
Message-ID: <02cf09ac-2390-2d80-a77c-b79c21783664@amd.com>
References: <20180406220806.150534-1-djkurtz@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180406220806.150534-1-djkurtz@chromium.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Kurtz <djkurtz@chromium.org>
Cc: satyajit.sahu@amd.com, ssundark@amd.com, craigb@chromium.org, Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, open list <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org



On 4/7/2018 3:37 AM, Daniel Kurtz wrote:
> Commit c31165d7400b ("mmc: sdhci-pci: Add support for HS200 tuning mode
> on AMD, eMMC-4.5.1") added a HS200 tuning method for use with AMD SDHCI
> controllers.  As described in the commit subject, this tuning is specific
> for HS200.  However, as implemented, this method is used for all host
> timings, because platform_execute_tuning, if it exists, is called
> unconditionally by sdhci_execute_tuning().  This breaks tuning when using
> the AMD controller with, for example, a DDR50 SD card.
>
> Instead, we can implement an amd execute_tuning wrapper callback, and
> then conditionally do the HS200 specific tuning for HS200, and otherwise
> call back to the standard sdhci_execute_tuning().
>
> Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
Looks good.

Acked-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
