From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/3] dt-bindings: mmc: Add 'fixed-emmc-driver-type-hs{200,400}'
Date: Thu, 14 Nov 2019 11:46:26 +0100
Message-ID: <CAPDyKFoXT-UtO05xbHRVJTJAg+yYJK9AM7KjK18QcaGM0Bqn9g@mail.gmail.com>
References: <20191105055015.23656-1-erosca@de.adit-jv.com> <20191105062223.GB1048@kunai>
 <20191105083213.GA24603@vmlxhi-102.adit-jv.com> <20191107003907.GA22634@bogus>
 <20191112211950.GB3402@kunai>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191112211950.GB3402@kunai>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Rob Herring <robh@kernel.org>, Eugeniu Rosca <erosca@de.adit-jv.com>, Adrian Hunter <adrian.hunter@intel.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Mathieu Malaterre <malat@debian.org>, Pavel Machek <pavel@ucw.cz>, DTML <devicetree@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Eugeniu Rosca <roscaeugeniu@gmail.com>
List-Id: linux-mmc@vger.kernel.org

[...]

> > >
> > > One option to achieve a similar degree of flexibility by using an array
> > > OF property (instead of several u32 properties) would be to agree on a
> > > convention based on magic values, i.e. below DT one-liner could be an
> > > example of providing solely the "fixed-emmc-driver-type-hs200" value
> > > (based on the agreement that 0xFF values are discarded by the driver):
> > >
> > >     fixed-emmc-driver-type = <0xFF 0x1 0xFF>;
> >
> > I don't understand why you have 3 values instead of 2.
>
> Because he sketches maximum flexibility here. Have a non-HS (default)
> value, one for HS200, and one for HS400:
>
>         fixed-emmc-driver-type = <[default] [HS200] [HS400]>;
>
> > I would just use -1 if you want to ignore an entry. If that's the common
>
> '-1' sounds good to me, too.
>
> > case, then I'd stick with what you originally proposed. If rare, then I
> > think an array is the better route.
>
> What I have seen so far: setting drive strength alone is more on the
> rare side. Setting specific values for default and HS200/400 seems even
> more rare to me. With this patchset, it is the first time I hear about
> it.
>
> Yet, my experience might be a bit limited, maybe others (Hi Ulf! ;)) can add
> their views, too?

My experience in this field is quite limited. No input from me, sorry.

Kind regards
Uffe
