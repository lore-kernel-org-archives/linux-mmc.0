From: Chris Ball <cjb@laptop.org>
Subject: Re: Question about read only flag
Date: Mon, 31 Jan 2011 15:54:22 +0000
Message-ID: <20110131155422.GA28016@void.printf.net>
References: <AANLkTi=odLjJtR19fMAyDNB9f+FV_Y-e48Li7fkZTKrv@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:55117 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752983Ab1AaPyY (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 31 Jan 2011 10:54:24 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTi=odLjJtR19fMAyDNB9f+FV_Y-e48Li7fkZTKrv@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: =?iso-8859-1?Q?Marc-Andr=E9_H=E9bert?= <hebert.marcandre@gmail.com>
Cc: linux-mmc@vger.kernel.org

Hi Marc-Andr=E9,

On Mon, Jan 31, 2011 at 09:01:02AM -0500, Marc-Andr=E9 H=E9bert wrote:
> Hello,
>=20
> I have on an OMAPL138 board running 2.6.33-rc4 (I would liked to try =
a
> more recent kernel but I do not have any boards which supports a more
> recent version). I noticed that I was unable to detect from sysfs if
> the inserted card was set to read only. The block device's
> /sys/class/block/mmcblk0/ro entry always reported 0. The read only
> gpio is correctly setup as opening the device for writing fails as
> expected.

Interesting, thanks -- no, I don't imagine this is intentional, and I c=
an
confirm the behavior on an x86 laptop/SDHCI running 2.6.38-rc2.  Your
patch looks correct to me.  I'm surprised no-one's noticed this before.

Could you re-send it as a Git patch with a Signed-off-by: line, please?

--=20
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
