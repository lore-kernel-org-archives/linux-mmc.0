From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [EXT] Re: [PATCH v2] mmc: core: add mmc-card hardware reset
 enable support
Date: Tue, 20 Jun 2017 11:45:16 +0200
Message-ID: <CACRpkdb92scfO=tghucfC3RqQpi9K6YSuavte_b-AxH4hS87rQ@mail.gmail.com>
References: <1491895862-7952-1-git-send-email-richard.leitner@skidata.com>
 <CACRpkdaBrk91hh3JGZ0vcD3aXO+OHD41xwRKn9prPSOX_SXuWg@mail.gmail.com>
 <CAPDyKFoL5dbs_xKxaBGk2bqd2tOXrhG_SVcBoUpMetsKDdNXxQ@mail.gmail.com>
 <0a29de1a-2635-2bb8-808a-7b9a0197921a@skidata.com> <6b92d0af00024549a0d22dda039780dd@bowex36d.micron.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <6b92d0af00024549a0d22dda039780dd@bowex36d.micron.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Luca Porzio (lporzio)" <lporzio@micron.com>
Cc: Richard Leitner <richard.leitner@skidata.com>, Ulf Hansson <ulf.hansson@linaro.org>, Bart Van Assche <bart.vanassche@sandisk.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Shawn Lin <shawn.lin@rock-chips.com>, Adrian Hunter <adrian.hunter@intel.com>, Jaehoon Chung <jh80.chung@samsung.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Richard Leitner <dev@g0hl1n.net>
List-Id: linux-mmc@vger.kernel.org

Hi Luca,

thanks for joining!

On Wed, Jun 14, 2017 at 6:12 PM, Luca Porzio (lporzio)
<lporzio@micron.com> wrote:

> This behavior is not Micron specific but instead it is enforced by the Jedec
> Specification. All eMMC must have HW reset disabled by default.

That's very good to know.

> This specification (as Ulf correctly hinted) originated from badly connected
> HW Reset pins which caused unnecessary eMMC reset glitches.
> Disabling this feature is a good option to contain glitches and avoid
> system level bugs.

Ah, makes sense.

> IMHO mmc-util is where the patch really stands: the enabling is OTP,
> the programmer have to use mmc-util only once and the kernel
> will behave accordingly.

So we should not add it to the device tree.

> Any platform vendor must check that the HW Reset pin is actually
> Connected BEFORE enabling this feature otherwise the system may be
> unstable. A DT Binding may be dangerous if this condition is not met
> as well as the code execution at each MMC init is honestly redundant
> for an OTP location of the extCSD.

I agree. So the device should be configured during production, or
a user who know exactly what they are doing may reconfigure it
using the mmc-utils.

Thus the kernel should just read what the device says and stay with
that, no DT props or anything.

This makes a lot of sense.

When say ethernet devices need MAC addresses written to their OTP
we do not put that into the device tree to be programmed either, we assume
production tools to do that job.

Yours,
Linus Walleij
