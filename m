From: Christopher Covington <cov@codeaurora.org>
Subject: Re: [PATCH v8 0/3] mmc: sdhci-msm: Add support for Qualcomm chipsets
Date: Tue, 04 Feb 2014 08:19:02 -0500
Message-ID: <52F0E8C6.5090006@codeaurora.org>
References: <1391107507-17321-1-git-send-email-gdjakov@mm-sol.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1391107507-17321-1-git-send-email-gdjakov@mm-sol.com>
Sender: linux-doc-owner@vger.kernel.org
To: Georgi Djakov <gdjakov@mm-sol.com>
Cc: linux-mmc@vger.kernel.org, cjb@laptop.org, devicetree@vger.kernel.org, grant.likely@linaro.org, rob.herring@calxeda.com, pawel.moll@arm.com, mark.rutland@arm.com, swarren@wwwdotorg.org, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, rob@landley.net, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hi Georgi,

On 01/30/2014 01:45 PM, Georgi Djakov wrote:
> This patchset adds basic support of the Secure Digital Host Controller
> Interface compliant controller found in Qualcomm chipsets.
> 
> Tested with eMMC and various micro SD cards on APQ8074 Dragonboard.

[...]

>  .../devicetree/bindings/mmc/sdhci-msm.txt          |   83 ++
>  drivers/mmc/host/Kconfig                           |   13 +
>  drivers/mmc/host/Makefile                          |    1 +
>  drivers/mmc/host/sdhci-msm.c                       |  938 ++++++++++++++++++++
>  4 files changed, 1035 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mmc/sdhci-msm.txt
>  create mode 100644 drivers/mmc/host/sdhci-msm.c

You must have added entries to the Dragonboard device tree source to test
these changes. Why not include them with this patchset? Is there a stand-alone
patch that I've overlooked?

Thanks,
Christopher

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by the Linux Foundation.
