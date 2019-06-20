From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH RESEND] mmc: core: try to use an id from the devicetree
Date: Thu, 20 Jun 2019 14:16:52 -0700
Message-ID: <CAD=FV=WBycK5hfa75e0vJ=9sjEG88TJyzU4--jsB6UyDe6nGVA@mail.gmail.com>
References: <20190620152432.1408278-1-lkundrak@v3.sk> <CAPDyKFrSQR7+POv++8jW5VF4hTcQbNwZzqHntK1k4eNpy2gH=Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFrSQR7+POv++8jW5VF4hTcQbNwZzqHntK1k4eNpy2gH=Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Lubomir Rintel <lkundrak@v3.sk>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

Hi,

On Thu, Jun 20, 2019 at 8:37 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> + Doug
>
> On Thu, 20 Jun 2019 at 17:24, Lubomir Rintel <lkundrak@v3.sk> wrote:
> >
> > If there's a mmc* alias in the device tree, take the device number from
> > it, so that we end up with a device name that matches the alias.
>
> Lots of people would be happy if I queue something along the lines of
> what you propose. I am not really having any big problems with it, but
> I am reluctant to queue it because of other peoples quite strong
> opinions [1] that have been expressed in regards to this already.
>
> Kind regards
> Uffe
>
> [1]
> https://www.spinics.net/lists/devicetree-spec/msg00254.html

Yeah, I personally like being able to assign numbers too, but
unfortunately there are lots of people who objected.  BTW: if you
prefer the patchwork view of the same discussion that Ulf pointed to:

https://lore.kernel.org/patchwork/cover/674381/

As per that discussion, I think might be OK if we could find a way to
assign a string-based name to devices.  Then if your user manual calls
them "emmc", "sd", and "sdio" you could name them that way.  ...and if
your manual calls them "emmc", "sd0", "sd1" you could name them that
way.  ...but I wouldn't swear that people would actually truly like
that.

Given the total number of people who keep feeling like this is an
issue that needs to be solved, though, it does seem worthwhile for
someone to come up with a solution.


-Doug
