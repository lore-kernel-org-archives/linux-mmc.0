From: Jeremy McNicoll <jmcnicol@redhat.com>
Subject: Re: [RFC PATCH 2/3] mmc: sdhci-msm: Implement platform_dumpregs
 callback in sdhci-msm
Date: Sun, 15 Jan 2017 21:20:12 -0800
Message-ID: <20170116052011.GA623@mini-rhel.redhat.com>
References: <1483097531-9991-1-git-send-email-riteshh@codeaurora.org>
 <1483097531-9991-3-git-send-email-riteshh@codeaurora.org>
 <20170113223117.GB22862@mini-rhel.redhat.com>
 <120ebd64-e643-c859-05f7-c97294925803@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:47396 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750897AbdAPFUR (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 16 Jan 2017 00:20:17 -0500
Content-Disposition: inline
In-Reply-To: <120ebd64-e643-c859-05f7-c97294925803@codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ritesh Harjani <riteshh@codeaurora.org>
Cc: ulf.hansson@linaro.org, adrian.hunter@intel.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, shawn.lin@rock-chips.com, stummala@codeaurora.org, georgi.djakov@linaro.org, linux-arm-msm@vger.kernel.org, pramod.gurav@linaro.org, jeremymc@redhat.com, venkatg@codeaurora.org, asutoshd@codeaurora.org, subhashj@codeaurora.org

On Mon, Jan 16, 2017 at 07:51:40AM +0530, Ritesh Harjani wrote:
> Hi Jeremy,
> 
> On 1/14/2017 4:01 AM, Jeremy McNicoll wrote:
> >On Fri, Dec 30, 2016 at 05:02:10PM +0530, Ritesh Harjani wrote:
> >>From: Sahitya Tummala <stummala@codeaurora.org>
> >>
> >>Implement ->platform_dumpregs host operation to print the
> >>platform specific registers in addition to standard SDHC
> >>register during error conditions.
> >>
> >>Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
> >>Signed-off-by: Ritesh Harjani <riteshh@codeaurora.org>
> >>---
> >> drivers/mmc/host/sdhci-msm.c | 34 ++++++++++++++++++++++++++++++++++
> >> 1 file changed, 34 insertions(+)
> >>
> >>diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
> >>index 32879b8..1241dbd 100644
> >>--- a/drivers/mmc/host/sdhci-msm.c
> >>+++ b/drivers/mmc/host/sdhci-msm.c
> >>@@ -29,6 +29,11 @@
> >> #define CORE_VERSION_MAJOR_MASK		(0xf << CORE_VERSION_MAJOR_SHIFT)
> >> #define CORE_VERSION_MINOR_MASK		0xff
> >>
> >>+#define CORE_MCI_DATA_CNT	0x30
> >>+#define CORE_MCI_STATUS		0x34
> >>+#define CORE_MCI_FIFO_CNT	0x44
> >>+#define CORE_MCI_STATUS2	0x6c
> >>+
> >> #define CORE_HC_MODE		0x78
> >> #define HC_MODE_EN		0x1
> >> #define CORE_POWER		0x0
> >>@@ -77,6 +82,10 @@
> >> #define CORE_HC_SELECT_IN_HS400	(6 << 19)
> >> #define CORE_HC_SELECT_IN_MASK	(7 << 19)
> >>
> >>+#define CORE_VENDOR_SPEC_FUNC2		0x110
> >>+#define CORE_VENDOR_SPEC_ADMA_ERR_ADDR0	0x114
> >>+#define CORE_VENDOR_SPEC_ADMA_ERR_ADDR1	0x118
> >>+
> >> #define CORE_CSR_CDC_CTLR_CFG0		0x130
> >> #define CORE_SW_TRIG_FULL_CALIB		BIT(16)
> >> #define CORE_HW_AUTOCAL_ENA		BIT(17)
> >>@@ -658,6 +667,30 @@ static int sdhci_msm_hs400_dll_calibration(struct sdhci_host *host)
> >> 	return ret;
> >> }
> >>
> >>+static void sdhci_msm_dumpregs(struct sdhci_host *host)
> >>+{
> >>+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> >>+	struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
> >>+
> >>+	pr_err("----------- PLATFORM REGISTER DUMP -----------\n");
> >>+
> >>+	pr_err("Data cnt: 0x%08x | Fifo cnt: 0x%08x | Int sts: 0x%08x | Int sts2: 0x%08x\n",
> >>+	       readl_relaxed(msm_host->core_mem + CORE_MCI_DATA_CNT),
> >>+	       readl_relaxed(msm_host->core_mem + CORE_MCI_FIFO_CNT),
> >>+	       readl_relaxed(msm_host->core_mem + CORE_MCI_STATUS),
> >>+	       readl_relaxed(msm_host->core_mem + CORE_MCI_STATUS2));
> >>+	pr_err("DLL cfg:  0x%08x | DLL sts:  0x%08x | SDCC ver: 0x%08x\n",
> >>+	       readl_relaxed(host->ioaddr + CORE_DLL_CONFIG),
> >>+	       readl_relaxed(host->ioaddr + CORE_DLL_STATUS),
> >>+	       readl_relaxed(msm_host->core_mem + CORE_MCI_VERSION));
> >>+	pr_err("Vndr func: 0x%08x | Vndr adma err : addr0: 0x%08x addr1: 0x%08x\n",
> >>+	       readl_relaxed(host->ioaddr + CORE_VENDOR_SPEC),
> >>+	       readl_relaxed(host->ioaddr + CORE_VENDOR_SPEC_ADMA_ERR_ADDR0),
> >>+	       readl_relaxed(host->ioaddr + CORE_VENDOR_SPEC_ADMA_ERR_ADDR1));
> >>+	pr_err("Vndr func2: 0x%08x\n",
> >>+	       readl_relaxed(host->ioaddr + CORE_VENDOR_SPEC_FUNC2));
> >>+}
> >>+
> >
> >Why did you omit the printing of CORE_TESTBUS_CONFIG like that of
> >https://patchwork.kernel.org/patch/9442449/
> Actually testbus registers aren't something we analyze every-time.
> So I have skipped it for now. We can add it later if and when required.
> 

Sounds reasonable.  

> 
> >
> >and sdhci_dump_state() was dropped too.  Being able to dump the rpm_info
> >was very handy for issues I was running into.
> Sure, let me add that info as well.
> 

Great, as it was useful when I was debugging SDHCI enablement. 

-jeremy

> >
> >-jeremy
> >
> >> static int sdhci_msm_execute_tuning(struct sdhci_host *host, u32 opcode)
> >> {
> >> 	int tuning_seq_cnt = 3;
> >>@@ -1035,6 +1068,7 @@ static void sdhci_msm_set_clock(struct sdhci_host *host, unsigned int clock)
> >> 	.set_bus_width = sdhci_set_bus_width,
> >> 	.set_uhs_signaling = sdhci_msm_set_uhs_signaling,
> >> 	.voltage_switch = sdhci_msm_voltage_switch,
> >>+	.platform_dumpregs = sdhci_msm_dumpregs,
> >> };
> >>
> >> static const struct sdhci_pltfm_data sdhci_msm_pdata = {
> >>--
> >>The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
> >>a Linux Foundation Collaborative Project.
> >>
> 
> -- 
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
> a Linux Foundation Collaborative Project
