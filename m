From: Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Subject: Re: [GIT PULL] Update dw-mmc controller
Date: Mon, 17 Aug 2015 11:11:42 +0000
Message-ID: <1439809902.28471.1.camel@synopsys.com>
References: <55C8D73D.10709@gmail.com>
	 <CAPDyKFqN9FxQNbwoiCj1A+BUUWHm_H8RXNhKVzUkV0xOUUdCFA@mail.gmail.com>
	 <1439806320.3667.39.camel@synopsys.com>
	 <CAPDyKFowfusQa+geBxjZZ1KCffVu5BnGM4jD52k3Ztf3wSt7og@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-7"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtprelay.synopsys.com ([198.182.47.9]:59924 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754225AbbHQLMI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 17 Aug 2015 07:12:08 -0400
In-Reply-To: <CAPDyKFowfusQa+geBxjZZ1KCffVu5BnGM4jD52k3Ztf3wSt7og@mail.gmail.com>
Content-Language: en-US
Content-ID: <AEB405A72A40864BB1B6A06875DE814C@internal.synopsys.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "jh80.chung@samsung.com" <jh80.chung@samsung.com>, "jh80.chung@gmail.com" <jh80.chung@gmail.com>, "heiko@sntech.de" <heiko@sntech.de>, "shawn.lin@rock-chips.com" <shawn.lin@rock-chips.com>, "addy.ke@rock-chips.com" <addy.ke@rock-chips.com>, Vineet Gupta <Vineet.Gupta1@synopsys.com>

Hi Ulf,

On Mon, 2015-08-17 at 12:32 +-0200, Ulf Hansson wrote:
+AD4- On 17 August 2015 at 12:12, Alexey Brodkin +ADw-Alexey.Brodkin+AEA-synopsys.com+AD4- wrote:
+AD4- +AD4- Hi Ulf,
+AD4- +AD4- 
+AD4- +AD4- On Mon, 2015-08-17 at 11:47 +-0200, Ulf Hansson wrote:
+AD4- +AD4- +AD4- On 10 August 2015 at 18:54, Jaehoon Chung +ADw-jh80.chung+AEA-gmail.com+AD4- wrote:
+AD4- +AD4- +AD4- +AD4- Dear, Ulf.
+AD4- +AD4- +AD4- +AD4- 
+AD4- +AD4- +AD4- +AD4- Could you pull these patches into your repository?
+AD4- +AD4- +AD4- +AD4- 
+AD4- +AD4- +AD4- +AD4- Best Regards,
+AD4- +AD4- +AD4- +AD4- Jaehoon Chung
+AD4- +AD4- +AD4- 
+AD4- +AD4- +AD4- Thanks+ACE- Pulled into my next branch.
+AD4- +AD4- +AD4- 
+AD4- +AD4- +AD4- Kind regards
+AD4- +AD4- +AD4- Uffe
+AD4- +AD4- 
+AD4- +AD4- I'm wondering if mentioned fixes only hit 4.3 (you mentioned your
+AD4- +AD4- +ACI-next+ACI- branch) or there's a chance for them to be pulled in the next 4.2-rcX?
+AD4- +AD4- 
+AD4- +AD4- The thing is we need at least +ACI-mmc: dw+AF8-mmc: handle data blocks +AD4- than 4kB if IDMAC is used+ACI-
+AD4- +AD4- to get our AXS board upstreamed in full in that 4.2, see:
+AD4- +AD4- http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id+AD0-0890a264794f33df540fbaf274699146903b4e6b)
+AD4- +AD4- functional with SD/MMC.
+AD4- 
+AD4- Is the above mentioned patch a fix for a regression? If not, it's too
+AD4- late for 4.2.

Ok then we'll need to apply selected patches (probably all but then we'll need
feedback of other interested parties) on top of 4.2 stable a bit later.

-Alexey