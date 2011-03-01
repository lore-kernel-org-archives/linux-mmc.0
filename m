From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: Fwd: [RFC] MMC: error handling improvements
Date: Tue, 1 Mar 2011 20:22:34 +0000
Message-ID: <20110301202234.GB27107@n2100.arm.linux.org.uk>
References: <8yaoc6c7tan.fsf@huya.qualcomm.com> <AANLkTikpdwfM19oirENbOhnz8Rh40ZnMXByGX_QKdu-V@mail.gmail.com> <8ya8vxf4w4w.fsf@huya.qualcomm.com> <AANLkTimQqGVTwUv4ywQnmd4Z1Ur4vWk2sK5+ZLa4mmTs@mail.gmail.com> <AANLkTikDxOeW9Nfaew_mZLnVJ6e7pyzQTNs139g_AehW@mail.gmail.com> <AANLkTin64W=VQP+EomU3PK-Ye=Nz_SP+DOLxgT__4fkQ@mail.gmail.com> <AANLkTin7UaKPgvmPC0+cJf5nBWuUmuUreAjDZxQGNB2j@mail.gmail.com> <AANLkTimE5xK8RgNiP+9D2D_beBcbWhBNSzjnhEU36GTO@mail.gmail.com> <AANLkTimpJUoc64py_jCrvsrXscawsR2c7JBtr1e0U+e8@mail.gmail.com> <a8453bae3ced14c4c325d1782be92e24.squirrel@www.codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <a8453bae3ced14c4c325d1782be92e24.squirrel@www.codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Murali Krishna Palnati <palnatim@codeaurora.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, Brian Swetland <swetland@google.com>, David Brown <davidb@codeaurora.org>, Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Tue, Mar 01, 2011 at 10:39:59AM -0800, Murali Krishna Palnati wrote:
> Our main concern in moving to mmci is support for DMA that needs to be
> added to this driver. I believe PL180 controller does have the ability to
> talk to DMA engines, but i dont see any relevant support for that in mmci
> driver, unless i grossly missed something.

DMA engine support will be added at the next merge window.  It's already
in linux-next.

Note that as ARM evaluation boards all have entirely broken DMA, it's
something I can't test here, so I'm entirely reliant on other people
using the driver with working DMA engines, testing it, and reporting
back.  This is why the ARM primecell drivers traditionally have had no
DMA support - I just don't have any working hardware to develop such
facilities.
