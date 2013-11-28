From: Chris Ball <cjb@laptop.org>
Subject: Re: =?utf-8?Q?e=E2=8B=85MMC?= forward compatibility
Date: Thu, 28 Nov 2013 15:48:56 +0000
Message-ID: <867gbsjzmf.fsf@void.printf.net>
References: <CAGkQfmOjUeKYMq8aosZTyco4Sna4yM_20zGWUG2nWRyX_gwyhw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:49622 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754857Ab3K1Ps6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 28 Nov 2013 10:48:58 -0500
In-Reply-To: <CAGkQfmOjUeKYMq8aosZTyco4Sna4yM_20zGWUG2nWRyX_gwyhw@mail.gmail.com>
	(Romain Izard's message of "Thu, 28 Nov 2013 15:01:49 +0100")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Romain Izard <romain.izard.pro@gmail.com>
Cc: linux-mmc@vger.kernel.org

Hi Romain,

On Thu, Nov 28 2013, Romain Izard wrote:
> The e=E2=8B=85MMC 5.0 specification has been published by JEDEC on Se=
ptember
> 2013 [1], and contains a note in section B.8, which says: "A host
> system should work properly considering future eMMC version. For
> example, a host system is expected not to exit only due to the
> EXT_CSD_REV[192] value greater than 7 which will be used for next
> e=E2=80=A2MMC revision."
>
> Right now, the kernel controls the value of both fields 192 and 194,
> and rejects any device where CSD_STRUCTURE > 2 or EXT_CSD_REV > 7.

Sounds good to me -- want to send a patch?

Thanks,

- Chris.
--=20
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
