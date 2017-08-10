From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v2 0/8] omap*: Fixes/Cleanups for MMC devicetree node
Date: Thu, 10 Aug 2017 09:13:22 -0700
Message-ID: <20170810161322.GD8569@atomide.com>
References: <20170607093749.15656-1-kishon@ti.com>
 <CAPDyKFrJh9qAz6q2-TH8rMshuMjDTkT5pHP==FUUH9KZEOehOQ@mail.gmail.com>
 <e9c1cce6-5d6d-3762-8a84-28f36fa3bc33@ti.com>
 <20170807064813.GA5487@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170807064813.GA5487-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Cc: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

* Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> [170806 23:49]:
> * Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org> [170803 04:20]:
> 
> > Do you want me to resend the entire series or only "ARM: dts: omap*: Replace
> > deprecated "vmmc_aux" with "vqmmc"?
> 
> Seems that the missing one is safe to apply now? If so, let me just
> take a look at that since I do have a branch already set up that
> I can use.

I'll move pdata-quirks change to omap-for-v4.14/soc branch
and will merge and apply the dts changes into
omap-for-v4.14/dt branch.

Thanks,

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
