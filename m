From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH RFC v1 2/2] mmc: host: meson-mx-sdhc: new driver for the
 Amlogic Meson SDHC host
Date: Sat, 24 Aug 2019 23:34:31 +0200
Message-ID: <CAFBinCBOhKezUQMJb4eRHTbzXOhucxuAJydDe4H5JyRFgOxS-w@mail.gmail.com>
References: <20190708173330.13217-1-martin.blumenstingl@googlemail.com>
 <20190708173330.13217-3-martin.blumenstingl@googlemail.com>
 <CAPDyKFoFQ_QvHD-+Mg_VAR5rqs3CM_h7dw25p81JTzE1Yz7d1A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAPDyKFoFQ_QvHD-+Mg_VAR5rqs3CM_h7dw25p81JTzE1Yz7d1A@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>, DTML <devicetree@vger.kernel.org>, jianxin.pan@amlogic.com, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

Hi Ulf,

On Thu, Aug 22, 2019 at 3:53 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Mon, 8 Jul 2019 at 19:33, Martin Blumenstingl
> <martin.blumenstingl@googlemail.com> wrote:
> >
> > WiP - only partially working - see performance numbers.
> >
> > Odroid-C1 eMMC (HS-200):
> > Amlogic's vendor driver @ Linux 3.10:
> >   7781351936 bytes (7.8 GB) copied, 134.714 s, 57.8 MB/s
> > This driver:
> >   7781351936 bytes (7.8 GB, 7.2 GiB) copied, 189.02 s, 41.2 MB/s
> >
> > EC-100 eMMC (HS MMC):
> > Amlogic's vendor driver @ Linux 3.10:
> >   15762194432 bytes (16 GB) copied, 422.967 s, 37.3 MB/s
> > This driver:
> >   15762194432 bytes (16 GB, 15 GiB) copied, 9232.65 s, 1.7 MB/s
> >
> > 1) Amlogic's vendor driver does some magic with the divider:
> >       clk_div = input_rate / clk_ios - !(input_rate%clk_ios);
> >       if (!(clk_div & 0x01)) // if even number, turn it to an odd one
> >          clk_div++;
> >    It's not clear to me whether what the reason behind this is, what is
> >    supposed to be achieved with this?
> >
> > 2) The hardcoded RX clock phases are taken from the vendor driver. It
> >    seems that these are only valid when fclk_div3 is used as input
> >    clock (however, there are four more inputs). It's not clear to me how
> >    to calculate the RX clock phases in set_ios based on the input clock
> >    and the ios rate.
> >
> > 3) The hardware supports a timeout IRQ but the max_busy_timeout is not
> >    documented anywhere.
> >
> > Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
>
> Martin, overall this looks good to me. Once you moved from RFC to a
> formal patch I will check again, of course.
OK, great

in the meantime I got answers to my questions (off-list) from Jianxin.

also someone asked me (just this week) for the .dts patches so he
could test on his own board (I have them ready but didn't send them
yet)
unfortunately he ran into some data corruption on writing
I can reproduce it but I didn't have time to debug this yet

I'll send an updated version once I have resolved that - as non-RFC

> There are a couple of calls to readl_poll_timeout(), for different
> reasons, that I have some questions about, but we can discuss those in
> the next step.
sure.
feel free to ask now since I still have to debug that data corruption
problem as stated above


Martin
