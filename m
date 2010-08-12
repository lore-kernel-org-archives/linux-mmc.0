From: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Subject: Re: [PATCH v4 3/8] wireless: wl1271: add platform driver to get
	board data
Date: Thu, 12 Aug 2010 10:55:46 +0100
Message-ID: <20100812095546.GA3354@n2100.arm.linux.org.uk>
References: <1281550913-17633-1-git-send-email-ohad@wizery.com> <1281550913-17633-4-git-send-email-ohad@wizery.com> <5A47E75E594F054BAF48C5E4FC4B92AB0324110ABD@dbde02.ent.ti.com> <20100811184742.GA21778@nokia.com> <5A47E75E594F054BAF48C5E4FC4B92AB0324110AC1@dbde02.ent.ti.com> <20100811185724.GD21778@nokia.com> <5A47E75E594F054BAF48C5E4FC4B92AB0324110AC7@dbde02.ent.ti.com> <20100811212513.GC827@n2100.arm.linux.org.uk> <AANLkTikDhzGVFZhNJZic9xYX9bL_NhOW=4LS-cTFSG0i@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <AANLkTikDhzGVFZhNJZic9xYX9bL_NhOW=4LS-cTFSG0i-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ohad Ben-Cohen <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>
Cc: "DebBarma, Tarun Kanti" <tarun.kanti-l0cyMroinI0@public.gmane.org>, "felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org" <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, Kalle Valo <kalle.valo-X3B1VOXEql0@public.gmane.org>, "Pandita, Vikram" <vikram.pandita-l0cyMroinI0@public.gmane.org>, "akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org" <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, "Quadros Roger (Nokia-MS/Helsinki)" <roger.quadros-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, "linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Nicolas Pitre <nico-vtqb6HGKxmzR7s880joybQ@public.gmane.org>, San Mehat <san-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, "Chikkature Rajashekar, Madhusudhan" <madhu.cr-l0cyMroinI0@public.gmane.org>, "Coelho Luciano (Nokia-MS/Helsinki)" <Luciano.Coelho-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ido Yariv <ido-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On Thu, Aug 12, 2010 at 09:40:19AM +0300, Ohad Ben-Cohen wrote:
> On Thu, Aug 12, 2010 at 12:25 AM, Russell King - ARM Linux
> <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org> wrote:
> >I've outlined a far simpler and easiler solution
> > which avoids this kind of abuse, and given suggestions on how to extend
> > it to support multiple instances.
> >
> 
> Do you mean:
> http://www.spinics.net/lists/arm-kernel/msg95338.html
> ?
> 
> I was under the impression you eventually discarded that approach in
> that post.

Indeed.

I'm talking about my first suggestion:

http://lists.arm.linux.org.uk/lurker/message/20100804.114148.bf961e83.en.html

which was later expanded by Vitaly:

http://lists.arm.linux.org.uk/lurker/message/20100804.140119.f476c29c.en.html

I don't think anyone had any negative comments against that proposal.
--
To unsubscribe from this list: send the line "unsubscribe linux-wireless" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
