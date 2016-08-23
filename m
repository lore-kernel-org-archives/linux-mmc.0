From: Zach Brown <zach.brown@ni.com>
Subject: Re: [PATCH] sdhci: Add quirk and device tree parameter to force SD
 test mode
Date: Tue, 23 Aug 2016 17:14:22 -0500
Message-ID: <20160823221421.GB20351@zach-desktop>
References: <1471906531-28668-1-git-send-email-zach.brown@ni.com>
 <684dd3fb-15ac-fa84-2f1e-89f379b5149a@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-co1nam03on0139.outbound.protection.outlook.com ([104.47.40.139]:52219
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755147AbcHWXuB (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 23 Aug 2016 19:50:01 -0400
Content-Disposition: inline
In-Reply-To: <684dd3fb-15ac-fa84-2f1e-89f379b5149a@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: ulf.hansson@linaro.org, mark.rutland@arm.com, robh+dt@kernel.org, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, Aug 23, 2016 at 09:22:29AM +0300, Adrian Hunter wrote:
> On 23/08/16 01:55, Zach Brown wrote:
> > From: Jaeden Amero <jaeden.amero@ni.com>
> > 
> > On some devices, CD is broken so that we must force the SDHCI into test
> > mode and set CD, so that it always detects an SD card as present.
> > 
> > In order to get a device with broken CD working, we had previously
> > always set the SDHCI into test mode. Unfortunately, this had the side
> > effect of making all SD cards used with our Linux kernels undetectable
> > and non-removable.
> > 
> > By making this "SD test mode" setting optional via a quirk, we can avoid
> > this side effect for devices other than the device with broken CD.
> > Additionally, we add a device parameter to sdhci-pltfm to allow all
> > SDHCI drivers to enable this quirk.
> 
> Generally new quirks are not acceptable, but I don't see how test mode helps
> very much since you still don't get any card detection events.  If you
> really need test mode, please explain more about how it helps (as opposed to
> polling for example).
> 
> 

Polling doesnt work in our case, since the issue lies with the SD controller
itself. The SD controller in xilinx zynq devices requires the CDn signal to
work. http://www.xilinx.com/support/answers/61064.html We have a situation 
where the controller requires the signal, but we can't use any of our pins to
supply it. With test mode we can get the controller into a state where it works
despite not having the signal.
