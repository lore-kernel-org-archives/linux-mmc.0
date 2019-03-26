From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [BACKPORT 4.4.y 01/25] mmc: pwrseq: constify mmc_pwrseq_ops structures
Date: Tue, 26 Mar 2019 09:11:44 +0100
Message-ID: <CAK8P3a1zF7VMoLQfby4W=TzB0btN82gMn2FNvkc3te5Ey97=+A@mail.gmail.com>
References: <20190322154425.3852517-1-arnd@arndb.de> <20190322154425.3852517-2-arnd@arndb.de>
 <20190326010831.GA29420@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20190326010831.GA29420@kroah.com>
Sender: stable-owner@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: "# 3.4.x" <stable@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Janusz Krzysztofik <jmkrzyszt@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, "Tobin C. Harding" <me@tobin.cc>, Geert Uytterhoeven <geert+renesas@glider.be>, Julia Lawall <Julia.Lawall@lip6.fr>, linux-mmc <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Tue, Mar 26, 2019 at 2:22 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> On Fri, Mar 22, 2019 at 04:43:52PM +0100, Arnd Bergmann wrote:

> >  }
> >
> > -static struct mmc_pwrseq_ops mmc_pwrseq_simple_ops = {
> > +static const struct mmc_pwrseq_ops mmc_pwrseq_simple_ops = {
> >       .pre_power_on = mmc_pwrseq_simple_pre_power_on,
> >       .post_power_on = mmc_pwrseq_simple_post_power_on,
> >       .power_off = mmc_pwrseq_simple_power_off,
>
> Why is this needed for a stable patch?  It doesn't fix a bug, it just
> looks like it is a "nice thing" to have, right?  I don't think any later
> patch in this series relies it it, or am I missing something?

Right, the benefit here is rather small. In theory, any structure of
function pointers is a place into which an exploit can be placed
in case someone finds a way to modify a few bytes of kernel
memory. Placing the structures in read-only memory make this
a little harder (it doesn't prevent rowhammer attacks though).

Dropping this patch is certainly fine with me, as we have a large
supply of other structure definitions like this, and we wont' get close to
plugging enough of them in stable kernels.

       Arnd
