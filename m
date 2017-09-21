From: Jeremy McNicoll <jmcnicol@redhat.com>
Subject: Re: [PATCH v2 0/2] Support SDHCI on 8974pro devices
Date: Thu, 21 Sep 2017 03:13:08 -0700
Message-ID: <20170921101308.GA10466@mini-rhel.redhat.com>
References: <20170915233524.1375-1-bjorn.andersson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170915233524.1375-1-bjorn.andersson@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, Venkat Gopalakrishnan <venkatg@codeaurora.org>, Ritesh Harjani <riteshh@codeaurora.org>, devicetree@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Fri, Sep 15, 2017 at 04:35:22PM -0700, Bjorn Andersson wrote:
> The calibration clocks for the delay circut should be enabled, as done in the
> downstream kernel, in order for reset of the SDHCI not to fail on some Qualcomm
> platforms (e.g. 8974pro). These patches makes it possible to reference these
> clocks.
> 
> Bjorn Andersson (2):
>   mmc: sdhci-msm: Utilize bulk clock API
>   mmc: sdhci-msm: Enable delay circuit calibration clocks
> 
>  .../devicetree/bindings/mmc/sdhci-msm.txt          |  2 +
>  drivers/mmc/host/sdhci-msm.c                       | 90 +++++++++++-----------
>  2 files changed, 46 insertions(+), 46 deletions(-)
>


Thanks!  This fixes my Nexus5X (msm8992) and now expected messages such
as:

   mmc0: new HS400 MMC card at address 0001
   mmcblk0: mmc0:0001 016G72 14.7 GiB 
   mmcblk0boot0: mmc0:0001 016G72 partition 1 4.00 MiB
   mmcblk0boot1: mmc0:0001 016G72 partition 2 4.00 MiB
   mmcblk0rpmb: mmc0:0001 016G72 partition 3 4.00 MiB
   mmcblk0: p1 p2 p3 p4 p5 p6 p7 p8 p9 p10 p11 p12 p13 p14 p15....

are appearing in my boot messages / debug spew.  

Tested-by: Jeremy McNicoll <jeremymc@redhat.com>


-jeremy
