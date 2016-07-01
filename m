From: Andy Gross <andy.gross@linaro.org>
Subject: Re: [PATCH RFC 4/8] mmc: sdhci-msm: Add regulator DT props to
 sdhci-msm bindings
Date: Thu, 30 Jun 2016 23:22:13 -0500
Message-ID: <20160701042213.GB2926@hector.attlocal.net>
References: <1467199233-20506-1-git-send-email-riteshh@codeaurora.org>
 <1467199233-20506-5-git-send-email-riteshh@codeaurora.org>
 <20160629215326.GD16832@hector.attlocal.net>
 <2e77ecd7-abd8-cffc-b0ff-f29f68543263@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-oi0-f51.google.com ([209.85.218.51]:36184 "EHLO
	mail-oi0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751036AbcGAE3e (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 1 Jul 2016 00:29:34 -0400
Received: by mail-oi0-f51.google.com with SMTP id f189so95482600oig.3
        for <linux-mmc@vger.kernel.org>; Thu, 30 Jun 2016 21:29:33 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <2e77ecd7-abd8-cffc-b0ff-f29f68543263@codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ritesh Harjani <riteshh@codeaurora.org>
Cc: ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, linux-arm-msm@vger.kernel.org, adrian.hunter@intel.com, asutoshd@codeaurora.org, kdorfman@codeaurora.org, david.griego@linaro.org, stummala@codeaurora.org, venkatg@codeaurora.org

On Thu, Jun 30, 2016 at 07:00:54PM +0530, Ritesh Harjani wrote:
> Hi Andy,
> 
> On 6/30/2016 3:23 AM, Andy Gross wrote:
> >On Wed, Jun 29, 2016 at 04:50:29PM +0530, Ritesh Harjani wrote:
> >>This patch adds the DT properties for voltage regulator nodes
> >>for Qualcomm SDHCI driver.
> >>
> >>Signed-off-by: Ritesh Harjani <riteshh@codeaurora.org>
> >>---
> >> Documentation/devicetree/bindings/mmc/sdhci-msm.txt | 19 +++++++++++++++++++
> >> 1 file changed, 19 insertions(+)
> >>
> >>diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
> >>index 851e66d..32cea75 100644
> >>--- a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
> >>+++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
> >>@@ -17,7 +17,15 @@ Required properties:
> >> 	"iface" - Main peripheral bus clock (PCLK/HCLK - AHB Bus clock) (required)
> >> 	"core"	- SDC MMC clock (MCLK) (required)
> >> 	"bus"	- SDCC bus voter clock (optional)
> >>+- qcom,<supply>-voltage_level - specifies voltage levels for supply. Should be
> >>+					specified in pairs (min, max), units uV.
> >>+- qcom,<supply>-current_level - specifies load levels for supply in lpm or
> >>+					high power mode (hpm). Should be specified in
> >>+					pairs (lpm, hpm), units uA.
> >
> >These seem like OPPs to me.  Why use something non-standard?
> >
> >Check out Documentation/devicetree/bindings/opp/opp.txt
> Isn't OPP used w.r.t. DVFS?
> This is voltage/load regulator supplies used to provide vdd/vdd-io to card.
> We require this to switch the I/O voltage while switching to UHS card mode
> or to turn on/off the regulators while not in use, (but not tied to voltage
> switching while different frequency transitions).

It isn't necessarily tied to DVFS.  Someone else can chime in if I am wrong
here.

I was expecting these different voltage points to be tied to the speed/mode.  As
such it would kind of fall under the normal OPP definition.  Same with the load.

> 
> This is mentioned in the same way how other drivers uses vmmc/vqmmc, but the
> deviation in the name is since Qcom follows pwr_irq deviation(different from
> standard) to switch the I/O voltage, bus on/off.

Ok.  Fair enough.

> 
> >
> >>
> >>+Optional Properties:
> >>+	- qcom,<supply>-always-on - specifies whether supply should be kept "on" always.
> >
> >Would this only be the base if mmc is used on this platform?  You could specify
> >this in the regulator binding itself if this is more of a global thing.
> This could be specific to SDHC nodes, like for emmc - we may need only
> vdd-io to be on. So we need this per sdhc node.

Ok.  thanks for the clarification


Regards,

Andy
