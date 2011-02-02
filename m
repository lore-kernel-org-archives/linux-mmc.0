From: Tony Lindgren <tony@atomide.com>
Subject: Re: Setting MMC_CAP_POWER_OFF_CARD on mmc2 leads to filesystem
 problems on mmc1
Date: Tue, 1 Feb 2011 16:11:55 -0800
Message-ID: <20110202001155.GO3358@atomide.com>
References: <E6C3A477-63F7-4BA0-8E6B-A35A53B3AEA1@dominion.thruhere.net>
 <1295621342.1925.139.camel@pimenta>
 <AANLkTi=H2rJkbZnuuS7jfrXE6WunzhTYKGk+ZFPjOivp@mail.gmail.com>
 <EC9B76BF-F0F4-4F8C-9C6D-5CE311B2785C@dominion.thruhere.net>
 <AANLkTi=xPhi1Bho-8qhRup=fG02ybNzipq7Z-iQrqT1B@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <AANLkTi=xPhi1Bho-8qhRup=fG02ybNzipq7Z-iQrqT1B@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: Koen Kooi <koen@dominion.thruhere.net>, l-o List <linux-omap@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "Chikkature Rajashekar, Madhusudhan" <madhu.cr@ti.com>, "cjb@laptop.org" <cjb@laptop.org>, Luciano Coelho <coelho@ti.com>
List-Id: linux-mmc@vger.kernel.org

* Ohad Ben-Cohen <ohad@wizery.com> [110122 07:47]:
> On Sat, Jan 22, 2011 at 5:30 PM, Koen Kooi <koen@dominion.thruhere.ne=
t> wrote:
> > That was indeed the problem, not I get:
> >
> > [ =C2=A0 35.417053] wl1271: firmware booted (Rev 6.1.0.0.343)
> >
> > and
> >
> > root@beagleboard-xm-next:~# ifconfig wlan0 hw eth 00:11:22:33:44:55
> > root@beagleboard-xm-next:~# iwlist wlan0 scanning | grep ESSID | wc=
 -l
> > 13
> >
> > That get's me a lot further!
>=20
> Cool !

Hmm, do we need to still patch something for the -rc cycle for this?
If so, please let me know.

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
