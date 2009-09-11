From: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Subject: Re: [PATCH] sdio: pass unknown cis tuples to sdio drivers
Date: Fri, 11 Sep 2009 01:01:02 -0700
Message-ID: <20090911010102.4c7840b0.akpm@linux-foundation.org>
References: <20090910203951.041d5c17.akpm@linux-foundation.org>
	<354996.83066.qm@web28302.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <354996.83066.qm-T3+ej8jpW3nGRxTy+Q50vsz6deESKz/lQQ4Iyu8u01E@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Albert Herranz <albert_herranz-mRCrAkd8dF0@public.gmane.org>
Cc: linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bcm43xx-dev-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org, linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

On Fri, 11 Sep 2009 07:52:11 +0000 (GMT) Albert Herranz <albert_herranz-mRCrAkd8dF0@public.gmane.org> wrote:

> --- El vie, 11/9/09, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org> escribi__:
> > > Some manufacturers provide vendor information in
> > non-vendor specific CIS
> > > tuples. For example, Broadcom uses an Extended
> > Function tuple to provide
> > > the MAC address on some of their network cards, as in
> > the case of the
> > > Nintendo Wii WLAN daughter card.
> > > 
> > > This patch allows passing correct tuples unknown to
> > the SDIO core to
> > > a matching SDIO driver instead of rejecting them and
> > failing.
> > > 
> > 
> > This looks leaky to me.
> > 
> 
> Hi Andrew, thanks for the review.
> I hope I can clarify a bit what the patch does in the next comments.
> 
> > 
> > : ______ ______ if (i < ARRAY_SIZE(cis_tpl_list)) {

argh, now yahoo mail is converting tabs to 0xa0's as well.  Despair.

> > : ______ ______ ______ const struct cis_tpl *tpl = cis_tpl_list + i;
> > : ______ ______ ______ if (tpl_link < tpl->min_size) {
> > : ______ ______ ______ ______ printk(KERN_ERR
> > : ______ ______ ______ ______ __ __ ______"%s: bad CIS tuple 0x%02x"
> > : ______ ______ ______ ______ __ __ ______" (length = %u, expected >= %u)\n",
> > : ______ ______ ______         ______mmc_hostname(card->host),
> > : ______ ______ ______ ______ __ __ ______tpl_code, tpl_link, tpl->min_size);
> > : ______ ______ ______ ______ ret = -EINVAL;
> > 
> > ret == -EINVAL
> > 
> 
> At this point ret is not -EINVAL.

Yes it is.  We just did

	ret = -EINVAL;


If that assignment happens, we leak `this'.
--
To unsubscribe from this list: send the line "unsubscribe linux-wireless" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
