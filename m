From: Christian Daudt <bcm@fixthebug.org>
Subject: Re: [PATCH v4 1/8] ARM: dts: Declare clocks as fixed on bcm11351
Date: Thu, 12 Dec 2013 23:48:47 -0800
Message-ID: <CAEPRUYoJJ054rGhZmMMBy93ZtLrFJPRkM6LHmjygcyaDqzbDEw@mail.gmail.com>
References: <1386271244-3927-1-git-send-email-tim.kryger@linaro.org>
	<1386271244-3927-2-git-send-email-tim.kryger@linaro.org>
	<CAEPRUYrw_owwBYEmmXO3=OG9pXrKPrJTwF+jPVm4+-Vvf0Xorw@mail.gmail.com>
	<CAAYSxhp3MsnaX80tF7iCzUfjfjyQnOoZbTrtBKs_nAk4SUYReQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAAYSxhp3MsnaX80tF7iCzUfjfjyQnOoZbTrtBKs_nAk4SUYReQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tim Kryger <tim.kryger@linaro.org>
Cc: Rob Herring <rob.herring@calxeda.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Chris Ball <cjb@laptop.org>, Axel Lin <axel.lin@ingics.com>, Device Tree List <devicetree@vger.kernel.org>, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux MMC List <linux-mmc@vger.kernel.org>, Linaro Patches List <patches@linaro.org>
List-Id: linux-mmc@vger.kernel.org

On Tue, Dec 10, 2013 at 12:26 PM, Tim Kryger <tim.kryger@linaro.org> wrote:
> On Mon, Dec 9, 2013 at 11:18 PM, Christian Daudt <bcm@fixthebug.org> wrote:
>> Applied to armsoc/for-3.14/dt
>
> Could you wait till other maintainers provide their acks and then take
> the entire series into a branch that feeds into the arm-soc
> drivers-for-linus branch?
>
> Thanks,
> Tim Kryger

I'll try to sync with other maintainers to pull it in together. I'll
leave this commit in as-is for now as it is harmless on its own. I'll
back it off before 3.14 merge if it poses a problem.
