From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: mmc: sdio: runtime PM and 8686 problems
Date: Wed, 30 Nov 2011 12:36:50 +0200
Message-ID: <CAK=WgbY22BD8WWk71nL3=D3NZfJY92LXUum8yhV3JyHypjOe-g@mail.gmail.com>
References: <WC20111118085327.010279@terrafix.co.uk> <CAK=WgbZvcTqmpT0jWT1b-GN1e5091AikAfL88Q8Z66dsOXx6Og@mail.gmail.com>
 <WC20111118100011.2902A2@terrafix.co.uk> <CAK=WgbaJ-q4TqgV5tdPQPm6CT9roceqn6QMxEJgA=Prd52jVEQ@mail.gmail.com>
 <WC20111129111750.470087@terrafix.co.uk> <CAK=Wgbb6s_BGfJYAoH3V77QvWoAXVAchg0ojBx4Mbmgq8bgvWw@mail.gmail.com>
 <CAMLZHHRF2ygqBRyNm21vv0WnCYKPtduGpW7ME25z55v7nTaRnA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:52673 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753660Ab1K3KhN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 30 Nov 2011 05:37:13 -0500
Received: by ggnr5 with SMTP id r5so451688ggn.19
        for <linux-mmc@vger.kernel.org>; Wed, 30 Nov 2011 02:37:12 -0800 (PST)
In-Reply-To: <CAMLZHHRF2ygqBRyNm21vv0WnCYKPtduGpW7ME25z55v7nTaRnA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Daniel Drake <dsd@laptop.org>
Cc: Joe Woodward <jw@terrafix.co.uk>, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>

Hi Daniel,

On Tue, Nov 29, 2011 at 11:42 PM, Daniel Drake <dsd@laptop.org> wrote:
> Even though I have the pleasure of working with 8686 quite a bit

(Is there a subtle cynicism here ? :)

> So first thing to do is to investigate the source of this error, as b=
efore:
> [ =A0 34.637481] libertas_sdio: probe of mmc1:0001:1 failed with erro=
r -16
>
> which is likely bubbling up from somewhere inside the mmc/sdio layer.

Well, it sounds like Joe might need a hand here.

Since this regression is directly caused by commit 08da834 "mmc:
enable runtime PM by default", which you authored and have interest
in, it does make sense that you help Joe here. In case you're short of
time, then I suggest to revert 08da834 (which anyway was
experimental), and get back to it later, when you're more available.

Thanks,
Ohad.
