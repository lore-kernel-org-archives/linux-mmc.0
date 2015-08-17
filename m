From: Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Subject: Re: [GIT PULL] Update dw-mmc controller
Date: Mon, 17 Aug 2015 10:12:00 +0000
Message-ID: <1439806320.3667.39.camel@synopsys.com>
References: <55C8D73D.10709@gmail.com>
	 <CAPDyKFqN9FxQNbwoiCj1A+BUUWHm_H8RXNhKVzUkV0xOUUdCFA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-7"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from us01smtprelay-2.synopsys.com ([198.182.60.111]:38190 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751693AbbHQKVz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 17 Aug 2015 06:21:55 -0400
In-Reply-To: <CAPDyKFqN9FxQNbwoiCj1A+BUUWHm_H8RXNhKVzUkV0xOUUdCFA@mail.gmail.com>
Content-Language: en-US
Content-ID: <367B959773547B47AC975318ADBF5364@internal.synopsys.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>
Cc: "jh80.chung@gmail.com" <jh80.chung@gmail.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "jh80.chung@samsung.com" <jh80.chung@samsung.com>, "Alexey.Brodkin@synopsys.com" <Alexey.Brodkin@synopsys.com>, "heiko@sntech.de" <heiko@sntech.de>, "shawn.lin@rock-chips.com" <shawn.lin@rock-chips.com>, "addy.ke@rock-chips.com" <addy.ke@rock-chips.com>

Hi Ulf,

On Mon, 2015-08-17 at 11:47 +-0200, Ulf Hansson wrote:
+AD4- On 10 August 2015 at 18:54, Jaehoon Chung +ADw-jh80.chung+AEA-gmail.com+AD4- wrote:
+AD4- +AD4- Dear, Ulf.
+AD4- +AD4- 
+AD4- +AD4- Could you pull these patches into your repository?
+AD4- +AD4- 
+AD4- +AD4- Best Regards,
+AD4- +AD4- Jaehoon Chung
+AD4- 
+AD4- Thanks+ACE- Pulled into my next branch.
+AD4- 
+AD4- Kind regards
+AD4- Uffe

I'm wondering if mentioned fixes only hit 4.3 (you mentioned your
+ACI-next+ACI- branch) or there's a chance for them to be pulled in the next 4.2-rcX?

The thing is we need at least +ACI-mmc: dw+AF8-mmc: handle data blocks +AD4- than 4kB if IDMAC is used+ACI-
to get our AXS board upstreamed in full in that 4.2, see:
http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id+AD0-0890a264794f33df540fbaf274699146903b4e6b)
functional with SD/MMC.

Regards,
Alexey