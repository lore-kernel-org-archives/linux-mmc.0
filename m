From: Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Subject: Re: [GIT PULL] Update dw-mmc controller
Date: Wed, 16 Sep 2015 11:27:54 +0000
Message-ID: <1442402874.31048.8.camel@synopsys.com>
References: <55C8D73D.10709@gmail.com>
	 <CAPDyKFqN9FxQNbwoiCj1A+BUUWHm_H8RXNhKVzUkV0xOUUdCFA@mail.gmail.com>
	 <1439806320.3667.39.camel@synopsys.com>
	 <CAPDyKFowfusQa+geBxjZZ1KCffVu5BnGM4jD52k3Ztf3wSt7og@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-7"
Content-Transfer-Encoding: 8BIT
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFowfusQa+geBxjZZ1KCffVu5BnGM4jD52k3Ztf3wSt7og@mail.gmail.com>
Content-Language: en-US
Content-ID: <E4223023E4117A49AF0118664458D09C@internal.synopsys.com>
Sender: stable-owner@vger.kernel.org
To: "stable@vger.kernel.org" <stable@vger.kernel.org>
Cc: "jh80.chung@samsung.com" <jh80.chung@samsung.com>, "jh80.chung@gmail.com" <jh80.chung@gmail.com>, "heiko@sntech.de" <heiko@sntech.de>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "shawn.lin@rock-chips.com" <shawn.lin@rock-chips.com>, "addy.ke@rock-chips.com" <addy.ke@rock-chips.com>, Vineet Gupta <Vineet.Gupta1@synopsys.com>, "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org

Hello,

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

Please consider following patch to be picked-up for stable branches because
it fixes real problem on systems with 4Kb MMU page.

That commit is already in Linux 4.3-rc1 here:
http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id+AD0-5959b32e3636f9bfe3f869d1e440bc4a4d660965

-Alexey
