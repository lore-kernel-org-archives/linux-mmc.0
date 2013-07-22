From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: kernel panic in sg_complete
Date: Sun, 21 Jul 2013 22:07:35 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1307212200390.24298-100000@netrider.rowland.org>
References: <20130722002314.GA990@kroah.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from netrider.rowland.org ([192.131.102.5]:55898 "HELO
	netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753156Ab3GVCHg (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 21 Jul 2013 22:07:36 -0400
In-Reply-To: <20130722002314.GA990@kroah.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Marcin =?utf-8?Q?=C5=9Alusarz?= <marcin.slusarz@gmail.com>, linux-usb@vger.kernel.org, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>

On Sun, 21 Jul 2013, Greg Kroah-Hartman wrote:

> On Mon, Jul 22, 2013 at 01:00:41AM +0200, Marcin =C5=9Alusarz wrote:
> > If you want me to test some patches, just shout ;)
>=20
> Interesting patch, it makes sense to have this applied.  Can you rese=
nd
> it with a "Signed-off-by:" line so that I can add it to the tree?

Wait a minute.  The patch catches cases where io->dev is NULL in
sg_complete().  But how does that happen?

The only place io->dev gets set to NULL is in sg_clean(), and=20
sg_clean() gets called in only two places:

	if an URB could not be allocated in usb_sg_init(),

	or after all the URBs have completed in usb_sg_wait().

In either case, no more URBs will complete after sg_clean() is called,=20
so sg_complete() won't run.

A patch like this merely covers up the symptom without fixing the=20
underlying cause.  How did this manage to go wrong in the first place? =
=20
There must be a bug in the logic of sg_complete() or usb_sg_wait(). =20
_That_ logic bug is what needs to be fixed.

Alan Stern

