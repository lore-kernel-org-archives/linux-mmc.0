From: "Murali Krishna Palnati" <palnatim@codeaurora.org>
Subject: Re: Fwd: [RFC] MMC: error handling improvements
Date: Tue, 1 Mar 2011 10:39:59 -0800 (PST)
Message-ID: <a8453bae3ced14c4c325d1782be92e24.squirrel@www.codeaurora.org>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <AANLkTimpJUoc64py_jCrvsrXscawsR2c7JBtr1e0U+e8@mail.gmail.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Brian Swetland <swetland@google.com>, David Brown <davidb@codeaurora.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

> ---------- Forwarded message ----------
> From: Linus Walleij <linus.walleij@linaro.org>
> Date: Tue, Feb 22, 2011 at 2:19 AM
> Subject: Re: [RFC] MMC: error handling improvements
> To: Brian Swetland <swetland@google.com>, David Brown
> <davidb@codeaurora.org
>>
> Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Chris Ball <
> cjb@laptop.org>, linux-mmc@vger.kernel.org,
> linux-arm-kernel@lists.infradead.org
>
>
> Out of sheer curiosity, Qualcomm/CodeAurora guys:
>
> if you dump out the registers at offset 0xfe0-0xfff on the
> SDCC, does it contain a valid PrimeCell ID? Anyone who
> can make a hexdump of it?
>
> It is possible to hardcode an AMBA ID to use this driver
> even if this area is just 0x0000... but I'm just curious
> about how different silicon vendors treat these registers,
> e.g. if they contain something sensible.
>

Linus,

These Prime cell ID registers are removed in the newer versions of the MSM
SDCC controller and are replaced with a different register that indicates
the controller version number. So, using these prime cell ID registers may
not be an option for us. Nevertheless, as you pointed out we can hard code
the AMBA ID in the platform device data and use that in the mmci driver to
handle stuff specific to this controller similar to what is done for ST
variant in mmci driver.

Though the bulk of the MSM SDCC controller is designed around PL180, there
are still some modifications to include flow control, SDIO support, Data
Mover interface (DMA engine on Qualcomm MSMs) etc. Support/ability to talk
to the Data Mover is one of the main differences when compared to original
PL180 prime cell.

Our main concern in moving to mmci is support for DMA that needs to be
added to this driver. I believe PL180 controller does have the ability to
talk to DMA engines, but i dont see any relevant support for that in mmci
driver, unless i grossly missed something.

Regards

P Murali Krishna



Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora
Forum.

