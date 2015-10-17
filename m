From: Bjorn Andersson <bjorn.andersson-/MT0OVThwyLZJqsBc5GL+g@public.gmane.org>
Subject: Re: [PATCH v2] mmc: core: Allow specifying current consumption
Date: Sat, 17 Oct 2015 10:09:38 -0700
Message-ID: <20151017170938.GP24668@usrtlx11787.corpusers.net>
References: <1435725525-4367-1-git-send-email-bjorn.andersson@sonymobile.com>
 <1444698032-9051-1-git-send-email-bjorn.andersson@sonymobile.com>
 <CAPDyKFqQEY64AToR0So72Sc4DtKhH5Sxff=oy8pDZZmw8O0aMQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAPDyKFqQEY64AToR0So72Sc4DtKhH5Sxff=oy8pDZZmw8O0aMQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-mmc <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On Fri 16 Oct 05:55 PDT 2015, Ulf Hansson wrote:

> On 13 October 2015 at 03:00, Bjorn Andersson
> <bjorn.andersson-/MT0OVThwyLZJqsBc5GL+g@public.gmane.org> wrote:
> > This allows us to specify expected current consumption of the vmmc and
> > vqmmc regulators. This is needed to bring the supplying regulators out
> > of their low-power-mode while accessing the mmc.
> 
> This indeed makes sense, still I need to think a bit more on this.
> 

Thanks.

We can currently work around this by using "regulator-system-load" on
the vmmc regulator, but a proper fix would be nice.

> For example, can we allow these regulators to enter low power again at
> some times? If so, when and what should that current value be.
> 

The regulator framework recalculates the total load on a regulator upon
enable/disable, but currently it doesn't depend on the state of the
regulator.

I talked to Mark about this a while back and he was positive to us
correcting this, so disabled regulators wouldn't count towards the total
load of a regulator. (So that still is on my todo)


The second option would be to do what is done in the Qualcomm codeaurora
kernels, where the regulators are never disabled and there's a smaller
current specified for the suspend case.

This would require bigger changes to the mmc core I presume, but the
naming of the dt properties support such future adaption.

> Moreover, wouldn't vmmc|vqmmc-active-current be depending what eMMC/SD
> card that is attached?
> 

I would say so, I do however not know how to acquire or encode that
information. Any suggestions here are welcome.

Regards,
Bjorn
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
