From: Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Subject: Re: ARC dw-mshc binding compat string
Date: Mon, 28 Mar 2016 10:55:37 +0000
Message-ID: <1459162537.4785.45.camel@synopsys.com>
References: <56F66121.8050507@denx.de> <56F6C639.5000301@mentor.com>
	 <56F6C71B.6070002@denx.de> <56F6CC68.5040408@mentor.com>
	 <56F6D083.1020402@denx.de> <56F6D1E9.3050606@mentor.com>
	 <56F6E860.8070207@denx.de> <56F6ED41.5020908@mentor.com>
	 <56F6EFFD.9070007@denx.de> <1459157818.4785.5.camel@synopsys.com>
	 <56F908A1.3070701@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-7"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtprelay.synopsys.com ([198.182.60.111]:44227 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753141AbcC1Kzt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 28 Mar 2016 06:55:49 -0400
In-Reply-To: <56F908A1.3070701@samsung.com>
Content-Language: en-US
Content-ID: <17E6EF8E053FA146AA0158893243A32F@internal.synopsys.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "jh80.chung@samsung.com" <jh80.chung@samsung.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "marex@denx.de" <marex@denx.de>, "vladimir_zapolskiy@mentor.com" <vladimir_zapolskiy@mentor.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

Hi+AKA-Jaehoon,

On Mon, 2016-03-28 at 19:34 +-0900, Jaehoon Chung wrote:
+AD4- Hi,

+AFs-snip+AF0-

+AD4- +AD4- +AD4- +AD4- +AD4- +AD4- +AD4- +AD4- 
+AD4- +AD4- +AD4- +AD4- +AD4- +AD4- +AD4- +AD4- That said, I would rather prefer to see +ACI-snps,dw-mshc+ACI- prefix on description
+AD4- +AD4- +AD4- +AD4- +AD4- +AD4- +AD4- +AD4- of an MMC controller found on SoCFPGA series, +ACI-altr,socfpga-dw-mshc+ACI- seems
+AD4- +AD4- +AD4- +AD4- +AD4- +AD4- +AD4- +AD4- to be redundant.
+AD4- Yes..it's redundant..i should be combined to +ACI-snps,dw-mshc+ACI-.

So for socfpga platform compat string should be something like +ACI-snps,dw-mshc-socfpga+ACI- then?

+AD4- +AD4- 
+AD4- +AD4- +AD4- 
+AD4- +AD4- +AD4- +AD4- 
+AD4- +AD4- +AD4- +AD4- +AD4- 
+AD4- +AD4- +AD4- +AD4- +AD4- +AD4- 
+AD4- +AD4- +AD4- +AD4- +AD4- +AD4- +AD4- 
+AD4- +AD4- +AD4- +AD4- +AD4- +AD4- +AD4- According to drivers/mmc/host/dw+AF8-mmc-pltfm.c , the Altera SoCFPGA one
+AD4- +AD4- +AD4- +AD4- +AD4- +AD4- +AD4- +ACI-altr,socfpga-dw-mshc+ACI- and also Imagination Technology Pistacio one
+AD4- +AD4- +AD4- +AD4- +AD4- +AD4- +AD4- +ACI-img,pistachio-dw-mshc+ACI- need specialty bit (SDMMC+AF8-CMD+AF8-USE+AF8-HOLD+AF8-REG),
+AD4- +AD4- +AD4- +AD4- +AD4- +AD4- +AD4- while the stock one +ACI-snps,dw-mshc+ACI- does not. I am not sure if the ARC
+AD4- +AD4- +AD4- +AD4- +AD4- +AD4- +AD4- one needs it as well, but most likely yes.
+AD4- +AD4- +AD4- +AD4- +AD4- +AD4- +AD4- 
+AD4- +AD4- +AD4- +AD4- +AD4- +AD4- +AD4- I wonder if that bit is needed on some particular version of the DWMMC
+AD4- +AD4- +AD4- +AD4- +AD4- +AD4- +AD4- core. In that case, should we have +ACI-snps,dw-mshc+ACI- and +ACI-snps,dw-mshc-vN+ACI-
+AD4- +AD4- +AD4- +AD4- +AD4- +AD4- +AD4- binding ? Or should we use DT property to discern the need for this bit ?
+AD4- +AD4- +AD4- +AD4- +AD4- +AD4- +AD4- 
+AD4- +AD4- +AD4- +AD4- +AD4- +AD4- That's the most common way to take into account peculiarities, add
+AD4- +AD4- +AD4- +AD4- +AD4- +AD4- a property and handle it from the driver.
+AD4- +AD4- +AD4- +AD4- +AD4- And by +ACI-that+ACI- you mean which of those two I listed , the
+AD4- +AD4- +AD4- +AD4- +AD4- +ACI-snps,dw-mshc-vN+ACI- or adding new DT prop ?
+AD4- +AD4- +AD4- +AD4- +AD4- 
+AD4- +AD4- +AD4- +AD4- I meant to add a new property, not a new compatible, but that's just
+AD4- +AD4- +AD4- +AD4- my experience.
+AD4- +AD4- +AD4- +AD4- 
+AD4- +AD4- +AD4- +AD4- Let me say it +AF8AXw-might+AF8AXw- happen that a particular change you need is
+AD4- +AD4- +AD4- +AD4- specific to a particular version of the DWMMC IP (query Synopsys
+AD4- +AD4- +AD4- +AD4- by the way), but more probably it might be e.g. the same IP version with
+AD4- +AD4- +AD4- +AD4- a different reduced or extended configuration or a minor fix/improvement
+AD4- +AD4- +AD4- +AD4- to the IP block without resulting version number bump.
+AD4- +AD4- +AD4- +AD4- 
+AD4- +AD4- +AD4- +AD4- For example I don't remember that errata fixes in IP blocks result in
+AD4- +AD4- +AD4- +AD4- a new compatible, instead there are quite common optional +ACI-quirk+ACI-
+AD4- +AD4- +AD4- +AD4- properties for broken IPs -- e.g. check bindings/usb/dwc3.txt :)
+AD4- +AD4- +AD4- Right, this very much matches how I see it as well. Thanks for confirming.
+AD4- +AD4- +AD4- 
+AD4- +AD4- +AD4- Alexey, can you tell us if the requirement for setting
+AD4- +AD4- +AD4- SDMMC+AF8-CMD+AF8-USE+AF8-HOLD+AF8-REG came with some new revision of the core or
+AD4- +AD4- +AD4- disappeared with some revision OR if this is some configuration
+AD4- +AD4- +AD4- option of the core during synthesis ?
+AD4- +AD4- Sorry for not following that discussion during my weekend but I'll try
+AD4- +AD4- to address all questions now.
+AD4- SDMMC+AF8-CMD+AF8-USE+AF8-HOLD+AF8-REG didn't come with new revision..It's using continuously.
+AD4- But it's difficult to use the generic feature..because it's considered the below things.
+AD4- 
+AD4- If Card is SDR50/SDR104/DDR50 mode..
+AD4- 	1) and phase shift of cclk+AF8-in+AF8-drv is 0 then SDMMC+AF8-CMD+AF8-USE+AF8-HOLD+AF8-REG bit is set to 0,
+AD4- 	2) and phase shift of cclk+AF8-in+AF8-drv +AD4- 0 then SDMMC+AF8-CMD+AF8-USE+AF8-HOLD+AF8-REG bit is set to 1,
+AD4- If Card is SDR12/SDR25 mode, then this bit is set to 1.

So card type is also important here and for certain card type we don't need to
set+AKA-SDMMC+AF8-CMD+AF8-USE+AF8-HOLD+AF8-REG, right?

+AD4- We need to check phase shift scheme..but as i knew, each SoC have been implemented differently for phase shift.
+AD4- (Phase shift have dependency to SoC.)

Given my assumption above we need to check 2 things:
+AKAAKg- Card type
+AKAAKg- SoC-specific implementation detail (phase shift scheme)

+AD4- And it have to check HCON register..there is IMPLEMENT+AF8-HOLD+AF8-REG(bit+AFs-22+AF0-).
+AD4- (It described whether IP have hold register or not)

Ah actually 3 things
+AKAAKwCg-IMPLEMENT+AF8-HOLD+AF8-REG

+AD4- I didn't read this thread entirely.
+AD4- I'm not sure what you have discussed..but my understanding is right..i recommend to use +ACI-snps,dw-mshc+ACI- for ARC compat
+AD4- string.
+AD4- Otherwise it need to add +ACI-dw+AF8-mmc-+ADw-SoC+AD4-.c+ACI-. dw+AF8-mmc-pltfm.c should provide the basic dw-mmc controller functionality.

Hm, interesting looks like you already made some changes here:
http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id+AD0-aaaaeb7a933471f6413ca44dd36efd57f2fa9429

So now driver checks if SoC has HOLD REG then SDMMC+AF8-CMD+AF8-USE+AF8-HOLD+AF8-REG will be set
(regardless card type).

And what's interesting and connected to this discussion since mentioned commit
there's no point in having both+AKAAIg-altr,socfpga-dw-mshc+ACI- and+AKAAIg-img,pistachio-dw-mshc+ACI-
compat strings because the do nothing now. I.e. it's time to replace both mentioned
compat strings with generic+AKAAIg-snps,dw-mshc+ACI-.

Anybody volunteers for that .dts+ACo- cleanup?

-Alexey