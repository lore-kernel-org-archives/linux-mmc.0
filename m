From: Michael =?ISO-8859-1?Q?B=FCsch?= <mb-fseUSCV1ubazQB+pC5nmwQ@public.gmane.org>
Subject: Re: b43 sdio: WARNING: at drivers/mmc/core/core.c:237
 mmc_wait_for_cmd
Date: Thu, 28 Oct 2010 17:11:18 +0200
Message-ID: <1288278678.29188.71.camel@maggie>
References: <4CC874F4.5050908@arndnet.de> <4CC8CAAE.3040100@lwfinger.net>
	 <4CC98892.7080000@arndnet.de> <4CC98D85.20703@lwfinger.net>
	 <4CC99206.5090105@arndnet.de> (sfid-20101028_170910_533098_04D99458)
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4CC99206.5090105-BCMAnToX5e2ELgA04lAiVw@public.gmane.org> (sfid-20101028_170910_533098_04D99458)
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arnd Hannemann <arnd-BCMAnToX5e2ELgA04lAiVw@public.gmane.org>
Cc: Larry Finger <Larry.Finger-tQ5ms3gMjBLk1uMJSBkQmQ@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On Thu, 2010-10-28 at 17:08 +0200, Arnd Hannemann wrote: 
> > Index: wireless-testing/drivers/net/wireless/b43/sdio.c
> > ===================================================================
> > --- wireless-testing.orig/drivers/net/wireless/b43/sdio.c
> > +++ wireless-testing/drivers/net/wireless/b43/sdio.c
> > @@ -175,7 +175,9 @@ static void b43_sdio_remove(struct sdio_
> >  	struct b43_sdio *sdio = sdio_get_drvdata(func);
> > 
> >  	ssb_bus_unregister(&sdio->ssb);
> > +	sdio_claim_host(func);
> >  	sdio_disable_func(func);
> > +	sdio_release_host(func);
> >  	kfree(sdio);
> >  	sdio_set_drvdata(func, NULL);
> >  }
> > 
> 
> Thanks, that fixes the warning.

I'm OK with that patch.

-- 
Greetings Michael.

--
To unsubscribe from this list: send the line "unsubscribe linux-wireless" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
