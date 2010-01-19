From: Matt Fleming <matt@console-pimps.org>
Subject: Re: mmc_spi and flash cards
Date: Tue, 19 Jan 2010 20:49:17 +0000
Message-ID: <m3fx61hlbm.fsf@phlog.console-pimps.org>
References: <f96d234e0911180757l22af9e5dq4fa27db7f260c104@mail.gmail.com>
	<f96d234e0912280958u559c41e6yd47eea5526b6cbda@mail.gmail.com>
	<m3d41slhf4.fsf@phlog.console-pimps.org>
	<f96d234e1001141309g746f2f67l9f92d8b8a2dcf49f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from 124x34x33x190.ap124.ftth.ucom.ne.jp ([124.34.33.190]:34419 "EHLO
	master.linux-sh.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753657Ab0ASUtV (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 19 Jan 2010 15:49:21 -0500
In-Reply-To: <f96d234e1001141309g746f2f67l9f92d8b8a2dcf49f@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Cliff Brake <cliff.brake@gmail.com>
Cc: linux-mmc@vger.kernel.org

On Thu, 14 Jan 2010 16:09:05 -0500, Cliff Brake <cliff.brake@gmail.com> wrote:
> 
> I wonder if there is something wrong with the previous
> READ_MULTIPLE_BLOCK command, and that is what the cards are
> complaining about, not the STOP_TRANSMISSION command?
> 

If there was some wrong with the READ_MULTIPLE_BLOCK command the card
should have complained before the host started reading data.

> I'm decoding the READ_MULTIPLE_BLOCK arguments next ....
> 

Your best bet is probably going to be getting a 'scope on the bus.
