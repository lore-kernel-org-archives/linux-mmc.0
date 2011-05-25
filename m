From: Chris Ball <cjb@laptop.org>
Subject: Re: Stopping mmc clock between transfers
Date: Wed, 25 May 2011 11:54:53 -0400
Message-ID: <m3aaeasrle.fsf@pullcord.laptop.org>
References: <BANLkTikbm_OjtwB4fhwj1Mc0HAsNPH3CVg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:51731 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757978Ab1EYPxi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 25 May 2011 11:53:38 -0400
In-Reply-To: <BANLkTikbm_OjtwB4fhwj1Mc0HAsNPH3CVg@mail.gmail.com>
 (=?utf-8?Q?=22Marc-Andr=C3=A9=09H=C3=A9bert=22's?= message of "Tue, 24 May
 2011 14:42:32 -0400")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: =?utf-8?Q?Marc-Andr=C3=A9_H=C3=A9bert?= <hebert.marcandre@gmail.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

Hi Marc-Andr=C3=A9,

On Tue, May 24 2011, Marc-Andr=C3=A9 H=C3=A9bert wrote:
> We are using a OMAPL108 with 2.6.33 and noticed that the mmc clock
> signal stays active when idle. This doesn't seem very power efficient
> and we wondered if there was a reason for this. Before trying to fix
> this on our side I had a few questions regarding this:
> -Is this behavior the same in more recent versions?
> -Was this designed to be this way?
> -Would stopping the clock be a responsibility of the core (set_ios) o=
r
> the host controller (between requests)?

Check out CONFIG_MMC_CLKGATE=3Dy, introduced in 2.6.38.

- Chris.
--=20
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
