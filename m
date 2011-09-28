From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: slow eMMC write speed
Date: Wed, 28 Sep 2011 07:42:22 +0200
Message-ID: <CACRpkdYamRVpBbhAcgn7rXBGcgHUp7+9PCrmOUkXV1BvZ+4pDw@mail.gmail.com>
References: <CAHzg1A9usWP8o3xjEq3yFn56bEqk_Qp0a8-2FJzoRZG1MqPRPA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:34803 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752643Ab1I1FmY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 28 Sep 2011 01:42:24 -0400
Received: by ywb5 with SMTP id 5so6073194ywb.19
        for <linux-mmc@vger.kernel.org>; Tue, 27 Sep 2011 22:42:24 -0700 (PDT)
In-Reply-To: <CAHzg1A9usWP8o3xjEq3yFn56bEqk_Qp0a8-2FJzoRZG1MqPRPA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Praveen G K <praveen.gk@gmail.com>
Cc: linux-mmc@vger.kernel.org

On Fri, Sep 23, 2011 at 7:05 AM, Praveen G K <praveen.gk@gmail.com> wro=
te:

> I am working on the block driver module of the eMMC driver (SDIO 3.0
> controller). =A0I am seeing very low write speed for eMMC transfers. =
=A0On
> further debugging, I observed that every 63rd and 64th transfer takes
> a long time.

Are you not just seeing the card-internal garbage collection?
http://lwn.net/Articles/428584/

Yours,
Linus Walleij
