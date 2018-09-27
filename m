From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCHv4 4/6] ARM: dts: exynos: Add CD and WP pins to Odroid
 XU3/XU4 SD card
Date: Thu, 27 Sep 2018 08:28:22 +0200
Message-ID: <CAJKOXPeRauojpS9kEbQK8k+BQLSGEHEVsAwi406tW3zN2RzPWQ@mail.gmail.com>
References: <20180922075238.884-1-linux.amoon@gmail.com> <20180922075238.884-6-linux.amoon@gmail.com>
 <20180926190639.GA6461@kozik-lap> <CANAwSgSPkKL3jaHHSkEhgocKT_Sq4zg3Z=+7d5889ttpnNPHDA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CANAwSgSPkKL3jaHHSkEhgocKT_Sq4zg3Z=+7d5889ttpnNPHDA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux.amoon@gmail.com
Cc: robh+dt@kernel.org, mark.rutland@arm.com, kgene@kernel.org, Jaehoon Chung <jh80.chung@samsung.com>, ulf.hansson@linaro.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Thu, 27 Sep 2018 at 05:45, Anand Moon <linux.amoon@gmail.com> wrote:
>
> Hi Krzysztof,
> On Thu, 27 Sep 2018 at 00:36, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> >
> > On Sat, Sep 22, 2018 at 07:52:36AM +0000, Anand Moon wrote:
> > > Add the card-detect and write-protect GPIO pins for OdroidXU3/XU4
> > > SD card by adding pinctrl setting for wp-gpio pin and set it to
> > > active low.
> > >
> > > This also removes debug messages:
> > >     dwmmc_exynos 12220000.mmc: No GPIO consumer cd found
> > >     dwmmc_exynos 12220000.mmc: No GPIO consumer wp found
> > >
> > > Suggested-by: Krzysztof Kozlowski <krzk@kernel.org>
> > > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > > ---
> > > Fix the commit message and squash it with cd-gpios and wp-gpio
> > > patches into single patch as suggested by Krzysztof.
> >
> > As Marek pointed to my Odroid XU patch, there is no point of adding
> > cd-gpios and wp-gpios properties.
> >
> > Adding pin configuration for wp pin is also not needed. Reset values are
> > working properly. However there might be meaning of adding it just in
> > case - if bootloader decided to touch it...
> >
> > Best regards,
> > Krzysztof
> >
>
> Do I need to send the all the patches again or just resend this as per
> your patch for Odroid XU.
> with dropping the cd-gpios and wp-gpios changes.

I am fine with both (resend all or only this).

Best regards,
Krzysztof
