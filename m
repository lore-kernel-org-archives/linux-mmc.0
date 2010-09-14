From: Ohad Ben-Cohen <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v1 7/8] sdio: enable Runtime PM for SDIO functions
Date: Tue, 14 Sep 2010 21:32:01 +0200
Message-ID: <AANLkTikA+LXc4hq0WLEa6H146Rfib5iqGBKi-Cey41vt@mail.gmail.com>
References: <1283858949-11073-1-git-send-email-ohad@wizery.com>
 <1283858949-11073-8-git-send-email-ohad@wizery.com> <20100914192738.GB21918@void.printf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100914192738.GB21918-zkTaxWjgBN6ccd+RBA7C9g@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>
Cc: linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Luciano Coelho <luciano.coelho-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, San Mehat <san-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Roger Quadros <roger.quadros-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, Nicolas Pitre <nico-vtqb6HGKxmzR7s880joybQ@public.gmane.org>, Gao Yunpeng <yunpeng.gao-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Hi Chris,

On Tue, Sep 14, 2010 at 9:27 PM, Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org> wrote:
> On Tue, Sep 07, 2010 at 02:29:08PM +0300, Ohad Ben-Cohen wrote:
> > @@ -152,6 +173,11 @@ static int sdio_bus_remove(struct device *dev)
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 sdio_release_host(func);
> > =A0 =A0 =A0 }
> >
> > + =A0 =A0 pm_runtime_put_noidle(dev);
> > +
> > + =A0 =A0 /* Undo the runtime PM settings in sdio_bus_probe() */
> > + =A0 =A0 pm_runtime_put_noidle(dev);
> > +
> > =A0 =A0 =A0 return 0;
> > =A0}
> >
>
> Nit: =A0This makes sense in context, but stands out as a possible pas=
te
> accident on first sight. =A0:) =A0I think it's worth adding a comment=
 to
> the first call

Will do, thanks for the review!

Ohad.
--
To unsubscribe from this list: send the line "unsubscribe linux-wireles=
s" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
