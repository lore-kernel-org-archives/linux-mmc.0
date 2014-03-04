From: =?utf-8?B?U8O2cmVu?= Brinkmann <soren.brinkmann@xilinx.com>
Subject: Re: [PATCH v2] mmc: sdhci: add quirk for broken write protect
 detection
Date: Tue, 4 Mar 2014 13:00:55 -0800
Message-ID: <ae0f71ac-c5f7-4af7-a9ba-c019cec19ebf@AM1EHSMHS017.ehs.local>
References: <1393759200-22819-1-git-send-email-eli.billauer@gmail.com>
 <74003aec-1707-4f43-b947-df148d573fa1@TX2EHSMHS038.ehs.local>
 <53163247.8000904@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <53163247.8000904@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Eli Billauer <eli.billauer@gmail.com>
Cc: chris@printf.net, michal.simek@xilinx.com, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Mike Looijmans <mike.looijmans@topic.nl>
List-Id: linux-mmc@vger.kernel.org

On Tue, 2014-03-04 at 10:06PM +0200, Eli Billauer wrote:
> Hello S=C3=B6ren,
>=20
> wp-inverted solves the practical problem indeed, and fools the
> driver into thinking that the card has an inverted write protection
> sensor, and the logic zero that it finds in the hardware register
> means that the card isn't write protected.
>=20
> I'm insisting on this patch, because I think that the device tree
> should describe the hardware as it is, and not fool the driver into
> behaving the way we want it to. These tricks always bite back later
> on.
Well, why is broken-wp more accurate than wp-inverted? Strictly
speaking the WP is there and working, it's just tied off to some value
you want to have interpreted the other way.
Anyway, seems like this is solvable with wp-inverted and whether the
additional quirk is needed I leave to others do decide.

	S=C3=B6ren
