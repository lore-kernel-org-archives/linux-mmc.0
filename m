From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: working around a Marvell wifi SDIO bug
Date: Tue, 7 Dec 2010 00:31:13 +0200
Message-ID: <AANLkTin=H653apPnritr4j0XEunt-_To5OwKDD-G_zHH@mail.gmail.com>
References: <AANLkTik2F_-g2beZT5mLe4+XSBL-HUKnceeKqtKQZC=g@mail.gmail.com>
 <AANLkTinPbGcxOU8w_Wy3YVe-QOYpmQm+K7sgRHd-K2vp@mail.gmail.com> <43E4817426ED174AA81263BCECB4351D13200C556E@sc-vexch3.marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:48735 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753174Ab0LFWbe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 6 Dec 2010 17:31:34 -0500
Received: by iwn9 with SMTP id 9so732248iwn.19
        for <linux-mmc@vger.kernel.org>; Mon, 06 Dec 2010 14:31:33 -0800 (PST)
In-Reply-To: <43E4817426ED174AA81263BCECB4351D13200C556E@sc-vexch3.marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Philip Rakity <prakity@marvell.com>
Cc: Daniel Drake <dsd@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On Mon, Dec 6, 2010 at 6:37 AM, Philip Rakity <prakity@marvell.com> wro=
te:
>
> I have seen this solved using rfkill. =A0Is that acceptable?

It doesn't make a lot of sense.. rfkill is a few layers above.. and if
any, then an rfkill implementation will eventually end up triggering
this code and not the other way around.
