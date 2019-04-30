From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH v2 0/7] mmc: meson-gx: clean up and tuning update
Date: Tue, 30 Apr 2019 22:03:15 +0200
Message-ID: <CAFBinCC+w6aD6sSk8u=Pt54OKZuo84YMB2mWiLVHFNr329-kEg@mail.gmail.com>
References: <20190423090235.17244-1-jbrunet@baylibre.com> <CAPDyKFoQyPKERckAdU+kkw3go=161PWc+5GAkz7y=xWMGbq+SQ@mail.gmail.com>
 <CAFBinCBGU53h9063jj8n8q3whT=eZ9y6MPaYYqU_K9UXssK_nw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAFBinCBGU53h9063jj8n8q3whT=eZ9y6MPaYYqU_K9UXssK_nw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@baylibre.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

Hi Ulf,

On Mon, Apr 29, 2019 at 8:40 PM Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:
>
> Hi Ulf, Hi Kevin,
>
> On Mon, Apr 29, 2019 at 12:45 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >
> > On Tue, 23 Apr 2019 at 11:02, Jerome Brunet <jbrunet@baylibre.com> wrote:
> > >
> > > The purpose of this series is too improve reliability of the amlogic mmc
> > > driver on new (g12a) and old ones (axg, gxl, gxbb, etc...)
> > >
> > > * The 3 first patches are just harmless clean ups.
> >
> > Applied these first three, postponing the the rest until Martin are
> > happy with all of them. Thanks!
> thank you for taking the first three patches!
> I am fine with everything except the patch description of patch 4 and
> 7 as noted here: [0]
I did not understand how HS400 works. based on Jerome's latest
explanation I'm fine with the patches as they are


Martin
