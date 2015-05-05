From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Subject: Re: [PATCH] sdhci-of-esdhc: Support 8BIT bus width.
Date: Tue, 5 May 2015 12:22:57 +0000
Message-ID: <1430828577.27859.77.camel@transmode.se>
References: <1429564296-30396-1-git-send-email-joakim.tjernlund@transmode.se>
	 <CAPDyKFpQuLDafARu6=5XqxPsShRzcC__ZFgjE1yUrP4SobFjGQ@mail.gmail.com>
	 <1430816674.27859.71.camel@transmode.se>
	 <CAPDyKFo-j-9SCH+EBqqgCaRpDcHsNp3s_hOL7aAuUMiVmBe-ig@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.transmode.se ([31.15.61.139]:58829 "EHLO smtp.transmode.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422797AbbEEMXA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 5 May 2015 08:23:00 -0400
In-Reply-To: <CAPDyKFo-j-9SCH+EBqqgCaRpDcHsNp3s_hOL7aAuUMiVmBe-ig@mail.gmail.com>
Content-Language: en-US
Content-ID: <6169D24C46A8B14388F47CE3E05E33BC@transmode.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On Tue, 2015-05-05 at 12:11 +0200, Ulf Hansson wrote:
> On 5 May 2015 at 11:04, Joakim Tjernlund <joakim.tjernlund@transmode.se> wrote:
> > On Tue, 2015-05-05 at 10:34 +0200, Ulf Hansson wrote:
> > > On 20 April 2015 at 23:11, Joakim Tjernlund
> > > <joakim.tjernlund@transmode.se> wrote:
> > > > Signed-off-by: Joakim Tjernlund <joakim.tjernlund@transmode.se>
> > > 
> > > Thanks, applied.
> > > 
> > > Kind regards
> > > Uffe
> > 
> > Argh, I just learned that this patch is buggy. Please "unapply"
> > 
> >  Jocke
> > 
> 
> Done!

Thanks, new version sent :)

BTW, can I ask, cat /sys/kernel/debug/mmc0/ios:
clock:          52000000 Hz
actual clock:   50000000 Hz
vdd:            7 (1.65 - 1.95 V)
bus mode:       2 (push-pull)
chip select:    0 (don't care)
power mode:     2 (on)
bus width:      3 (8 bits)
timing spec:    1 (mmc high-speed)
signal voltage: 0 (3.30 V)

What is signal voltage: 0 (3.30 V) here ?

 Jocke
