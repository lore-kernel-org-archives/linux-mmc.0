From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 1/3] dt-bindings: mmc: Add 'fixed-emmc-driver-type-hs{200,400}'
Date: Wed, 13 Nov 2019 00:11:11 +0100
Message-ID: <CACRpkdYyYAaW8AYqpC3E7eBx25-3yJqitSE=0yVfxCDtM-CwqA@mail.gmail.com>
References: <20191105055015.23656-1-erosca@de.adit-jv.com> <20191105062223.GB1048@kunai>
 <20191105083213.GA24603@vmlxhi-102.adit-jv.com> <20191107003907.GA22634@bogus>
 <20191112211950.GB3402@kunai>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191112211950.GB3402@kunai>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Rob Herring <robh@kernel.org>, Eugeniu Rosca <erosca@de.adit-jv.com>, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-mmc <linux-mmc@vger.kernel.org>, Mathieu Malaterre <malat@debian.org>, Pavel Machek <pavel@ucw.cz>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Eugeniu Rosca <roscaeugeniu@gmail.com>
List-Id: linux-mmc@vger.kernel.org

On Tue, Nov 12, 2019 at 10:19 PM Wolfram Sang <wsa@the-dreams.de> wrote:

> What I have seen so far: setting drive strength alone is more on the
> rare side. Setting specific values for default and HS200/400 seems even
> more rare to me. With this patchset, it is the first time I hear about
> it.

Like I wrote to Eugeniu this sounds like some kind of errata
for the eMMC ext CSD and should likely be a card quirk rather
than some generic device tree properties.

I might be wrong, we'll hash it out.

Yours,
Linus Walleij
