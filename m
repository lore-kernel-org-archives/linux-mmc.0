From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: Fwd: [RFC] MMC: error handling improvements
Date: Wed, 2 Mar 2011 11:12:44 +0100
Message-ID: <AANLkTi=jfB-BiEpKqAy98_jtOTyN4Ozavp=7CnYMGZ_h@mail.gmail.com>
References: <20110215230311.GT4152@n2100.arm.linux.org.uk>
	<8yaoc6c7tan.fsf@huya.qualcomm.com>
	<AANLkTikpdwfM19oirENbOhnz8Rh40ZnMXByGX_QKdu-V@mail.gmail.com>
	<8ya8vxf4w4w.fsf@huya.qualcomm.com>
	<AANLkTimQqGVTwUv4ywQnmd4Z1Ur4vWk2sK5+ZLa4mmTs@mail.gmail.com>
	<AANLkTikDxOeW9Nfaew_mZLnVJ6e7pyzQTNs139g_AehW@mail.gmail.com>
	<AANLkTin64W=VQP+EomU3PK-Ye=Nz_SP+DOLxgT__4fkQ@mail.gmail.com>
	<AANLkTin7UaKPgvmPC0+cJf5nBWuUmuUreAjDZxQGNB2j@mail.gmail.com>
	<AANLkTimE5xK8RgNiP+9D2D_beBcbWhBNSzjnhEU36GTO@mail.gmail.com>
	<AANLkTimpJUoc64py_jCrvsrXscawsR2c7JBtr1e0U+e8@mail.gmail.com>
	<a8453bae3ced14c4c325d1782be92e24.squirrel@www.codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <a8453bae3ced14c4c325d1782be92e24.squirrel@www.codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Murali Krishna Palnati <palnatim@codeaurora.org>
Cc: Brian Swetland <swetland@google.com>, David Brown <davidb@codeaurora.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Thanks for writing back Murali!

2011/3/1 Murali Krishna Palnati <palnatim@codeaurora.org>:

> Though the bulk of the MSM SDCC controller is designed around PL180, there
> are still some modifications to include flow control, SDIO support,

We have these fixes in the U300/Ux500 version of MMCI as well, I suspect
it's nothing more than altering which bits are to be poked into which
registers.

> Data
> Mover interface (DMA engine on Qualcomm MSMs) etc. Support/ability to talk
> to the Data Mover is one of the main differences when compared to original
> PL180 prime cell.

The main work would be to switch the DMA engine in MSM to using
the DMA engine in drivers/dma. This is one thing we do to avoid the
proliferation of DMA engine code in arch/arm/*, and we very early
started to use that framework for U300 and Ux500 and I must say that
it has payed off well for us, now we have much nicer interfaces and more
review than any of the custom engines under arch/arm/*.

It's some upfront work but I think it would benefit you if you could
do this.

Yours,
Linus Walleij
