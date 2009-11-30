From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] mmc: add module parameter to set whether cards are
 assumed removable
Date: Mon, 30 Nov 2009 12:54:05 +0000
Message-ID: <20091130125405.541a6a01@lxorguk.ukuu.org.uk>
References: <1257914676.2237.57.camel@localhost>
	<20091116122329.847916b6.akpm@linux-foundation.org>
	<1258410709.2792.9.camel@localhost>
	<4B02565C.1030406@s5r6.in-berlin.de>
	<20091130133949.794fef00@mjolnir.ossman.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753458AbZK3MwW@vger.kernel.org>
In-Reply-To: <20091130133949.794fef00@mjolnir.ossman.eu>
Sender: linux-kernel-owner@vger.kernel.org
To: Pierre Ossman <pierre@ossman.eu>
Cc: Stefan Richter <stefanr@s5r6.in-berlin.de>, Ben Hutchings <ben@decadent.org.uk>, Andrew Morton <akpm@linux-foundation.org>, linux-mmc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 504391@bugs.debian.org, Wouter van Heyst <larstiq@larstiq.dyndns.org>
List-Id: linux-mmc@vger.kernel.org

> I'm afraid that's insufficient. What it would need to do is to is
> flush everything (to make sure what's on disk matches what's in
> memory), but also read back the filesystem on resume to verify that
> nothing else modified it (i.e. making sure what's on disk still matches
> what's in memory).

For most file systems it is sufficient to check the superblock related
information. So we'd need an fs->ops->validate_media() or somesuch but it
wouldn't be that horrific or need to do much I/O in most cases.

You could defeat that by being really stupid, but the purpose of the
check isn't a stupidity filter but to stop accidents happening in normal
use.

> Another way of putting it is that the kernel needs to umount/mount
> around suspend in a way that's transparent to users of the filesystem.

No. The kernel needs to push stuff to media on suspend (which is good
manners anyway), and validate on resume. if the validate fails you mark
the media as changed and the block layer will already see to it that
everything gets aborted as it already does with a truely removable device.

In fact if you did this by media serial numbers and idents you don't even
need the fs hook, although it would certainly be safer that way.

Alan
