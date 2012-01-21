From: Greg KH <gregkh@suse.de>
Subject: Re: [PATCH] Add Winbond WB528SD Secure Digital (SD) card reader
 driver
Date: Sat, 21 Jan 2012 07:51:53 -0500
Message-ID: <20120121125153.GB18829@suse.de>
References: <4F1A98F5.3080402@freemail.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:43477 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751345Ab2AUM4m (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 21 Jan 2012 07:56:42 -0500
Content-Disposition: inline
In-Reply-To: <4F1A98F5.3080402@freemail.hu>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: =?iso-8859-1?Q?N=E9meth_M=E1rton?= <nm127@freemail.hu>
Cc: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, devel@driverdev.osuosl.org, techeng <dzshen@gmail.com>, clyu@citiz.net, LKML <linux-kernel@vger.kernel.org>

On Sat, Jan 21, 2012 at 11:52:37AM +0100, N=E9meth M=E1rton wrote:
> From: M=E1rton N=E9meth <nm127@freemail.hu>
>=20
> This driver version of Winbond WB528SD can detect mechanical card
> presence only. The information is provided through sysfs.

How is it provided through sysfs?  Is this done in a standard way?  If
not, why not?

Why is this driver submitted to the staging tree?  What is keeping it
from going into the "real" portion of the kernel for other card readers=
?

We need a TODO file for what is needed to get it moved out of staging.

Oh, and it needs to do a bit more than just detect a card to be useful,
right?  How about read/write to it?

thanks,

greg k-h
