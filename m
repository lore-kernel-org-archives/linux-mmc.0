From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH 1/2] Documentation/gpio.txt: Explain expected pinctrl interaction
Date: Mon, 12 Mar 2012 10:32:12 -0600
Message-ID: <20120312163212.70E283E07B0@localhost>
References: <1329719263-18971-1-git-send-email-swarren@nvidia.com> <CACRpkdbPeVBv5VWefDvib5HmGF0K2gT79Mx7g-yviyQj33+Z-w@mail.gmail.com>
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CACRpkdbPeVBv5VWefDvib5HmGF0K2gT79Mx7g-yviyQj33+Z-w-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>, Randy Dunlap <rdunlap-/UHa2rfvQTnk1uMJSBkQmQ@public.gmane.org>, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, Colin Cross <ccross-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org>, Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

On Tue, 21 Feb 2012 11:46:03 +0100, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
> On Mon, Feb 20, 2012 at 7:27 AM, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org> wrote:
> 
> > Update gpio.txt based on recent discussions regarding interaction with the
> > pinctrl subsystem.
> >
> > Previously, gpio_request() was described as explicitly not performing any
> > required mux setup operations etc.
> >
> > Now, gpio_request() is explicitly as explicitly performing any required mux
> > setup operations where possible. In the case it isn't, platform code is
> > required to have set up any required muxing or other configuration prior to
> > gpio_request() being called, in order to maintain the same semantics.
> >
> > This is achieved by gpiolib drivers calling e.g. pinctrl_request_gpio() in
> > their .request() operation.
> >
> > Signed-off-by: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> 
> Acked-by: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> 
> Grant can you take this one? I'd prefer for you to have a look at
> it as well.

I've taken this one, but left the 2nd for Olof.

g.
